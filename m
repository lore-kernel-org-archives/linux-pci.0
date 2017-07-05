Return-Path: <SRS0=czt+=6I=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=czt+=6I=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 5 Jul 2017 07:21:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mason <slash.tmp@free.fr>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170705052148.GA6213@kroah.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
 <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 05, 2017 at 01:59:55AM +0200, Mason wrote:
> Do larger SoC vendors have HW devs working closely with
> Linux devs, to avoid these design bloopers?

Yes they generally do, as they have learned from their prior mistakes :)

good luck!

greg k-h
