Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Jun 2018 14:00:40 +0530
From: poza@codeaurora.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
In-Reply-To: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <8c6d5faccee6723ccb635f538105f1cc@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-12 05:51, Ray Jui wrote:
> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
> the following PCIe device ID:
> 0xd750, 0xd802, 0xd804
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..47dfea0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev 
> *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, 
> quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, 
> quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, 
> quirk_paxc_bridge);
>  #endif
> 
>  /* Originally in EDAC sources for i82875P:

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
