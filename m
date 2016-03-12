Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Mar 2016 09:52:03 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
In-Reply-To: <CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1603120951320.32556@math.ut.ee>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org> <1456366370-28995-7-git-send-email-yinghai@kernel.org> <20160310174030.GB17238@localhost> <CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Thu, Mar 10, 2016 at 9:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Feb 24, 2016 at 06:11:57PM -0800, Yinghai Lu wrote:
> >> Meelis reported that qla2000 driver does not get loaded on one sparc system.
> >>
> >> schizo f00732d0: PCI host bridge to bus 0001:00
> >> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
> >> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
> >> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
> >> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> >>
> >> So the quirk for M7101 claim the io range early.

But why did it work until 4.2 and only with 4.3 the allocations broke?


> >>
> >> According to spec with M7101 in M1543 page 103/104,
> >>       http://www.versalogic.com/Support/Downloads/pdf/ali1543.pdf
> >> 0xe0, and 0xe2 do not include address info for acpi/smb.
> >>
> >> Kill wrong quirk about them.
> >
> > This needs an explanation for why the quirk was added in the first
> > place, and why it is now safe to remove it.
> 
> The related commit does not tell much about why it is there exactly.
> But it is added the same time with intel piix4.
> 
> Maybe Linus could have some hint about that quirk?
> 
> commit 34f550135e349102bd065488eabbbb217ab27f0d
> Author: Linus Torvalds <torvalds@linuxfoundation.org>
> Date:   Fri Nov 23 15:32:20 2007 -0500
> 
>     Import 2.3.49pre2
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index cda39a5..8029b19 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -113,6 +113,55 @@ static void __init quirk_s3_64M(struct pci_dev *dev)
>         }
>  }
> 
> +static void __init quirk_io_region(struct pci_dev *dev, unsigned region, unsign
> ed size, int nr)
> +{
> +       region &= ~(size-1);
> +       if (region) {
> +               struct resource *res = dev->resource + nr;
> +
> +               res->name = dev->name;
> +               res->start = region;
> +               res->end = region + size - 1;
> +               res->flags = IORESOURCE_IO;
> +               pci_claim_resource(dev, nr);
> +       }
> +}
> +
> +/*
> + * Let's make the southbridge information explicit instead
> + * of having to worry about people probing the ACPI areas,
> + * for example.. (Yes, it happens, and if you read the wrong
> + * ACPI register it will put the machine to sleep with no
> + * way of waking it up again. Bummer).
> + *
> + * ALI M7101: Two IO regions pointed to by words at
> + *     0xE0 (64 bytes of ACPI registers)
> + *     0xE2 (32 bytes of SMB registers)
> + */
> +static void __init quirk_ali7101(struct pci_dev *dev)
> +{
> +       u16 region;
> +
> +       pci_read_config_word(dev, 0xE0, &region);
> +       quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES);
> +       pci_read_config_word(dev, 0xE2, &region);
> +       quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
> +}
> +
> +/*
> + * PIIX4 ACPI: Two IO regions pointed to by longwords at
> + *     0x40 (64 bytes of ACPI registers)
> + *     0x90 (32 bytes of SMB registers)
> + */
> +static void __init quirk_piix4acpi(struct pci_dev *dev)
> +{
> +       u32 region;
> +
> +       pci_read_config_dword(dev, 0x40, &region);
> +       quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES);
> +       pci_read_config_dword(dev, 0x90, &region);
> +       quirk_io_region(dev, region, 32, PCI_BRIDGE_RESOURCES+1);
> +}
> 
>  /*
>   *  The main table of quirks.
> @@ -143,6 +192,8 @@ static struct pci_fixup pci_fixups[] __initdata = {
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82443BX_2,  quirk_natoma },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,
> PCI_DEVICE_ID_SI_5597,          quirk_nopcipci },
>         { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_SI,
> PCI_DEVICE_ID_SI_496,           quirk_nopcipci },
> +       { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_82371AB_3,  quirk_piix4acpi },
> +       { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AL,
> PCI_DEVICE_ID_AL_M7101,         quirk_ali7101 },
>         { 0 }
>  };
> 

-- 
Meelis Roos (mroos@linux.ee)
