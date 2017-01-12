Return-Path: <SRS0=vagm=Y2=coreos.com=matthew.garrett@kernel.org>
Return-Path: <SRS0=vagm=Y2=coreos.com=matthew.garrett@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com> <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
From: Matthew Garrett <mjg59@coreos.com>
Date: Thu, 12 Jan 2017 13:48:15 -0800
Message-ID: <CAPeXnHvbGMC-MuQbVTV+CCjqEbbp6WC4PaWmijEVWv=Nnbm8Zg@mail.gmail.com>
Subject: Re: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Julia Cartwright <julia@ni.com>, Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 12:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Thanks for that.  In addition to yours, we have the following report,
> which was also bisected to 387d37577fdd:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working
>
> The changelog for 387d37577fdd doesn't mention any actual bugs that it
> fixes.  Should we consider reverting it?  Can you shed any light on
> this, Matthew?

Without this commit we disable ASPM on devices that expect to have it
enabled and increase idle power consumption by approximately 200% on
some laptops. Windows drivers may explicitly change the ASPM state on
devices or PCIe bridges, and if so we should be mimicing that
behaviour as well.
