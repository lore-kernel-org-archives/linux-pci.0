Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52137 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbbJOQXk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 12:23:40 -0400
Message-ID: <561FD30E.20203@ti.com>
Date: Thu, 15 Oct 2015 12:23:42 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC v2] PCI: keystone: Fix definition of LTSSM_STATE_MASK
References: <1444042389-8036-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1444042389-8036-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/05/2015 06:53 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Designware PCI block uses 0x3f for the LTSSM_STATE_MASK.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix Subject
>
> Murali,
>
> I am doing some consolidation on the PCI DW drivers and I noticed that
> keystone uses a different LTSSM_STATE_MASK definition.
>
> Could you please double check it?
>
>   drivers/pci/host/pci-keystone-dw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 3cf55cd..78320e4 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -25,7 +25,7 @@
>
>   /* Application register defines */
>   #define LTSSM_EN_VAL		        1
> -#define LTSSM_STATE_MASK		0x1f
> +#define LTSSM_STATE_MASK		0x3f
NACK

The mask should be 0x1f as was originally as per document


4-0                LTSSM_STATE 
        LTSSM current state. Please see Appendix
A.1 for the names of the LTSSM states corresponding to
the encoded values.

refer the document at http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf

Murali
>   #define LTSSM_STATE_L0			0x11
>   #define DBI_CS2_EN_VAL			0x20
>   #define OB_XLAT_EN_VAL		        2
>


-- 
Murali Karicheri
Linux Kernel, Keystone
