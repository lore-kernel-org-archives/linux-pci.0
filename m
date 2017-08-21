Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754354AbdHUUXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Aug 2017 16:23:32 -0400
Subject: Re: [PATCH] PCI: Fix and amend express capability sizes
To: Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
References: <20170810165403.2968.49940.stgit@gimli.home>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0e06c6a2-8c48-f82d-aa7f-685143e28153@redhat.com>
Date: Mon, 21 Aug 2017 22:23:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170810165403.2968.49940.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On 10/08/2017 18:54, Alex Williamson wrote:
> PCI_CAP_EXP_ENDPOINT_SIZEOF_V1 defines the size of the PCIe express
> capability structure for v1 devices with link, but we also have a need
> in the vfio code for sizing the capability for devices without link,
> such as root complex endpoints.  Create a separate define for this
> ending the structure before the link fields.
> 
> Additionally, this reveals that PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 is
> currently incorrect, ending the capability length before the v2 link
> fields.  Rename this to specify an RC endpoint (no link) capability
> length and move PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 to include the link
> fields as we have for the v1 version.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/uapi/linux/pci_regs.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index c22d3ebaca20..7439821214d1 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -513,6 +513,7 @@
>  #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>  #define  PCI_EXP_DEVSTA_AUXPD	0x0010	/* AUX Power Detected */
>  #define  PCI_EXP_DEVSTA_TRPND	0x0020	/* Transactions Pending */
> +#define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1	12	/* v1 endpoints without link end here */
nit: this should have been PCI_EXP_CAP_* from the very beginning but I
guess you don't new defines to be named differently from other *SIZEOF*?
>  #define PCI_EXP_LNKCAP		12	/* Link Capabilities */
>  #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
> @@ -556,7 +557,7 @@
>  #define  PCI_EXP_LNKSTA_DLLLA	0x2000	/* Data Link Layer Link Active */
>  #define  PCI_EXP_LNKSTA_LBMS	0x4000	/* Link Bandwidth Management Status */
>  #define  PCI_EXP_LNKSTA_LABS	0x8000	/* Link Autonomous Bandwidth Status */
> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V1	20	/* v1 endpoints end here */
> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V1	20	/* v1 endpoints with link end here */
>  #define PCI_EXP_SLTCAP		20	/* Slot Capabilities */
>  #define  PCI_EXP_SLTCAP_ABP	0x00000001 /* Attention Button Present */
>  #define  PCI_EXP_SLTCAP_PCP	0x00000002 /* Power Controller Present */
> @@ -639,7 +640,7 @@
>  #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
>  #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
>  #define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
> +#define PCI_CAP_EXP_RC ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
>  #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
>  #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5.0GT/s */
> @@ -647,6 +648,7 @@
>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
Looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
>  #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
>  #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
> 
