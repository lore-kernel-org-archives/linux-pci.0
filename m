Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Apr 2018 14:41:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
Message-ID: <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 04, 2018 at 06:50:09PM -0400, Sinan Kaya wrote:
> Per PCIe r3.1, sec 2.2.6.2 and 7.8.4, a Requester may not use 8-bit Tags
> unless its Extended Tag Field Enable is set, but all Receivers/Completers
> must handle 8-bit Tags correctly regardless of their Extended Tag Field
> Enable.
> 
> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
> them.  If we find such a device, we disable Extended Tags for the entire
> hierarchy to make peer-to-peer DMA possible.
> 
> The Broadcom HT1100/HT2000/HT2100 seems to have issues with handling 8-bit
> tags.  Mark it as broken.
> 
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196197
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/enumeration for v4.18, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8b14bd3..f012742 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4813,9 +4813,13 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
>  
>  	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
>  }
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0142, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>  
>  #ifdef CONFIG_PCI_ATS
>  /*
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
