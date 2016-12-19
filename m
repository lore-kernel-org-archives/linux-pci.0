Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Dec 2016 09:04:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org, jthumshirn@suse.de,
        haver@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
        Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH] genwqe: drop .link_reset()
Message-ID: <20161219150435.GA4655@bhelgaas-glaptop.roam.corp.google.com>
References: <1482132236-30243-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482132236-30243-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Linas]

On Mon, Dec 19, 2016 at 03:23:56PM +0800, Cao jin wrote:
> In AER recovery, pci_error_handlers.link_reset() is never called,
> drop it now.

I think it's true that .link_reset() is never called.  If that's the
case, why not remove it completely, i.e., remove it from struct
pci_error_handlers and from all the other drivers that supply it?

> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/misc/genwqe/card_base.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
> index 6c1f49a85023..4fd21e86ad56 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -1336,7 +1336,6 @@ static int genwqe_sriov_configure(struct pci_dev *dev, int numvfs)
>  static struct pci_error_handlers genwqe_err_handler = {
>  	.error_detected = genwqe_err_error_detected,
>  	.mmio_enabled	= genwqe_err_result_none,
> -	.link_reset	= genwqe_err_result_none,
>  	.slot_reset	= genwqe_err_slot_reset,
>  	.resume		= genwqe_err_resume,
>  };
> -- 
> 2.1.0
> 
> 
> 
