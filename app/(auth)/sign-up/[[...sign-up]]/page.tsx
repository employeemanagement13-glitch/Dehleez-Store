import { SignUp } from "@clerk/nextjs";

export default function Page() {
    return (
        <div className="min-h-screen bg-black flex items-center justify-center p-4">
            <SignUp
                appearance={{
                    elements: {
                        formButtonPrimary: "bg-white text-black hover:bg-neutral-200 transition-colors",
                        card: "bg-neutral-900 border border-neutral-800",
                        headerTitle: "text-white",
                        headerSubtitle: "text-neutral-400",
                        socialButtonsBlockButton: "bg-neutral-800 border-neutral-700 text-white hover:bg-neutral-700",
                        socialButtonsBlockButtonText: "text-white",
                        formFieldLabel: "text-neutral-400",
                        formFieldInput: "bg-black border-neutral-800 text-white focus:ring-white",
                        footerActionText: "text-neutral-500",
                        footerActionLink: "text-white hover:text-neutral-300 transition-colors"
                    }
                }}
            />
        </div>
    );
}
