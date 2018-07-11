Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Jul 2018 08:11:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
Message-ID: <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2018 at 05:21:03PM -0700, Ray Jui wrote:
> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
> the following PCIe device ID:
> 0xd750, 0xd802, 0xd804
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Because this quirk_paxc_bridge() mechanism is already established,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

BUT, I would push back on quirk_paxc_bridge() if it were new code.

I think it would be much better to implement this in the driver's
config accessors so lspci would show the correct things and the
generic code that deals with pcie_mpss would work unmodified.

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..47dfea0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>  #endif
>  
>  /* Originally in EDAC sources for i82875P:
> -- 
> 2.1.4
> 
