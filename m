Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nicolas.pitre@linaro.org>, Rob Herring <robh@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jayachandran C <jchandra@broadcom.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Ley Foon Tan <lftan@altera.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies
Date: Wed, 15 Jun 2016 23:06:26 +0200
Message-ID: <6064404.Y6hC1iYELB@wuerfel>
In-Reply-To: <20160615210211.GA17504@localhost>
References: <8531046.3ceRqUA835@wuerfel> <20160615210211.GA17504@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 15, 2016 4:02:11 PM CEST Bjorn Helgaas wrote:
> I applied this to pci/msi, minus the crypto change that looks unrelated:
> 
> > @@ -1038,6 +1038,8 @@ source "arch/arm64/Kconfig.debug"
> >  source "security/Kconfig"
> >  
> >  source "crypto/Kconfig"
> > +if CRYPTO
> >  source "arch/arm64/crypto/Kconfig"
> > +endif

Indeed, thanks for catching this!

	Arnd
