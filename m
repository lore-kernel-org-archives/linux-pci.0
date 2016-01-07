Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44138 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcAGRsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jan 2016 12:48:07 -0500
Date: Thu, 7 Jan 2016 11:48:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] PCI: msi: fix typos in <linux/msi.h>
Message-ID: <20160107174803.GC14105@localhost>
References: <1450703588-12295-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450703588-12295-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 21, 2015 at 02:13:08PM +0100, Thomas Petazzoni wrote:
> This commit fixes two typos in the <linux/msi.h> header.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied for v4.5, thanks!  I plan to merge this with other trivial patches
near the end of the merge window.

> ---
>  include/linux/msi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index f71a25e..8974b21 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -186,7 +186,7 @@ struct msi_domain_info;
>   * @msi_free:		Domain specific function to free a MSI interrupts
>   * @msi_check:		Callback for verification of the domain/info/dev data
>   * @msi_prepare:	Prepare the allocation of the interrupts in the domain
> - * @msi_finish:		Optional callbacl to finalize the allocation
> + * @msi_finish:		Optional callback to finalize the allocation
>   * @set_desc:		Set the msi descriptor for an interrupt
>   * @handle_error:	Optional error handler if the allocation fails
>   *
> @@ -194,7 +194,7 @@ struct msi_domain_info;
>   * msi_create_irq_domain() and related interfaces
>   *
>   * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
> - * are callbacks used by msi_irq_domain_alloc_irqs() and related
> + * are callbacks used by msi_domain_alloc_irqs() and related
>   * interfaces which are based on msi_desc.
>   */
>  struct msi_domain_ops {
> -- 
> 2.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
