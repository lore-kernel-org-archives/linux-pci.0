Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdGAN0n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Jul 2017 09:26:43 -0400
Date: Sat, 1 Jul 2017 08:26:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-pci@vger.kernel.org, mj@ucw.cz, rajatja@google.com,
        briannorris@chromium.org
Subject: Re: [PCIUTILS PATCH v2] lspci: Fix wrong read size for RootSta
Message-ID: <20170701132640.GA18324@bhelgaas-glaptop.roam.corp.google.com>
References: <1498817340-24918-1-git-send-email-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498817340-24918-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 30, 2017 at 06:09:00PM +0800, Jeffy Chen wrote:
> We are reading wrong size(word) for this cap, since:
> 
> RootSta has:
> PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
> PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Looks good to me.  Root Status is indeed a 32-bit register, per
PCIe r3.1, sec 7.8.14.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v2:
> Sorry, DevCtl2/LnkCtl2 are correct, remove wrong modifies for them...
> 
>  ls-caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index 0ca46fb..d4aebc8 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -879,7 +879,7 @@ static void cap_express_root(struct device *d, int where)
>    printf("\t\tRootCap: CRSVisible%c\n",
>  	FLAG(w, PCI_EXP_RTCAP_CRSVIS));
>  
> -  w = get_conf_word(d, where + PCI_EXP_RTSTA);
> +  w = get_conf_long(d, where + PCI_EXP_RTSTA);
>    printf("\t\tRootSta: PME ReqID %04x, PMEStatus%c PMEPending%c\n",
>  	w & PCI_EXP_RTSTA_PME_REQID,
>  	FLAG(w, PCI_EXP_RTSTA_PME_STATUS),
> -- 
> 2.1.4
> 
> 
