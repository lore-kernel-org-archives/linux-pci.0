Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 29 Apr 2014 21:16:03 +0200
From: Borislav Petkov <bp@suse.de>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Myron Stowe <myron.stowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	kim.naru@amd.com, daniel@numascale.com,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	hpa@zytor.com, x86 <x86@kernel.org>, sp@numascale.com,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] ACPI/PCI: Warn if we have to "guess" host bridge
 node information
Message-ID: <20140429191603.GC4726@pd.tnic>
References: <20140419025308.2408.51252.stgit@amt.stowe>
 <20140419025339.2408.17866.stgit@amt.stowe>
 <20140420102105.GA19676@pd.tnic>
 <CAL-B5D1MRjOGZJ-1PmDmkmqD2nG4+xhwWWsfib_E4-PFuKEkhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL-B5D1MRjOGZJ-1PmDmkmqD2nG4+xhwWWsfib_E4-PFuKEkhw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 28, 2014 at 03:24:39PM -0600, Myron Stowe wrote:
> >> @@ -489,8 +489,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >>       }
> >>
> >>       node = acpi_get_node(device->handle);
> >> -     if (node == NUMA_NO_NODE)
> >> +     if (node == NUMA_NO_NODE) {
> >>               node = x86_pci_root_bus_node(busnum);
> >> +             if (node != NUMA_NO_NODE)
> >> +                     dev_info(&device->dev, FW_BUG "No _PXM; guessing node number %x\n",
> >
> > Hmm, I'm not really convinced this message is user-friendly enough. Can
> > we be more descriptive here please?
> >
> 
> How about -
>   dev_info(&device->dev, FW_BUG "no _PXM; falling back to node %d from
> hardware (may be inconsistent with ACPI node numbers)\n", node);

Yep, better.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
