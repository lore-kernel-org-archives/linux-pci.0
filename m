Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Mar 2016 11:40:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
Message-ID: <20160310174030.GB17238@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
 <1456366370-28995-7-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456366370-28995-7-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 06:11:57PM -0800, Yinghai Lu wrote:
> Meelis reported that qla2000 driver does not get loaded on one sparc system.
> 
> schizo f00732d0: PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> 
> So the quirk for M7101 claim the io range early.
> 
> According to spec with M7101 in M1543 page 103/104,
> 	http://www.versalogic.com/Support/Downloads/pdf/ali1543.pdf
> 0xe0, and 0xe2 do not include address info for acpi/smb.
> 
> Kill wrong quirk about them.

This needs an explanation for why the quirk was added in the first
place, and why it is now safe to remove it.

> Link: http://kodu.ut.ee/~mroos/dm/dm.v240
> Link: http://kodu.ut.ee/~mroos/dm/dm.sb100
> Reported-by: Meelis Roos <mroos@linux.ee>
> Cc: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  drivers/pci/quirks.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0575a1e..051999e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -445,24 +445,6 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
>  		quirk_amd_nl_class);
>  
> -/*
> - * Let's make the southbridge information explicit instead
> - * of having to worry about people probing the ACPI areas,
> - * for example.. (Yes, it happens, and if you read the wrong
> - * ACPI register it will put the machine to sleep with no
> - * way of waking it up again. Bummer).
> - *
> - * ALI M7101: Two IO regions pointed to by words at
> - *	0xE0 (64 bytes of ACPI registers)
> - *	0xE2 (32 bytes of SMB registers)
> - */
> -static void quirk_ali7101_acpi(struct pci_dev *dev)
> -{
> -	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
> -	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
> -}
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
> -
>  static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
>  {
>  	u32 devres;
> -- 
> 1.8.4.5
> 
