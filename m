Return-Path: <SRS0=IdhR=Y3=coreos.com=matthew.garrett@kernel.org>
Return-Path: <SRS0=IdhR=Y3=coreos.com=matthew.garrett@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170112231726.GH8312@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
 <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
 <CAPeXnHvbGMC-MuQbVTV+CCjqEbbp6WC4PaWmijEVWv=Nnbm8Zg@mail.gmail.com> <20170112231726.GH8312@bhelgaas-glaptop.roam.corp.google.com>
From: Matthew Garrett <mjg59@coreos.com>
Date: Thu, 12 Jan 2017 16:00:29 -0800
Message-ID: <CAPeXnHudtWmPimrA3sNuYGMGvH2BvWw4gJytHk=1W51jgdtrKA@mail.gmail.com>
Subject: Re: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Julia Cartwright <julia@ni.com>, Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 3:17 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> A driver can explicitly change the ASPM state with
> pci_disable_link_state().  But that doesn't do anything when
> ACPI_FADT_NO_ASPM (and thus aspm_disabled) is set.
>
> Are you suggesting that we should remove the aspm_disabled check and
> make pci_disable_link_state() work regardless of ACPI_FADT_NO_ASPM?
> It's only called by drivers that presumably know about their device
> issues, and one would think it would be relatively safe to *disable*
> ASPM states (or at least safer than *enabling* them).

That would be my gut feeling. Windows provides an API in .inf files to
disable ASPM states on driver load, but it's unclear whether that does
anything if the firmware asks that ASPM be left alone. Windows drivers
obviously have the ability to hit the PCI registers directly anyway,
and there's evidence that some do so.
