Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D1C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A25121873
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553109898;
	bh=J/tyPdWp5ij+HzyxPMKplKC0JtfFbMNLhYxrJRSFnpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sYVG5AATPDu6ZyNoNjuvLxj7onED1ymKkCN9FsOJH51yBpHxFWhk9r3toNdchcGDm
	 P1sZ7gkY9XG/LxyS1oaLkTUWR3ZlIQPHF+cNIu7fGX44YwaQlBmqPyut1pvC23sL4u
	 uN4IG4vH8SoRFL+FPlhl/uFfs5QLic5r++KYTF+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfCTTY5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCTTY5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 15:24:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B196D21841;
        Wed, 20 Mar 2019 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553109896;
        bh=J/tyPdWp5ij+HzyxPMKplKC0JtfFbMNLhYxrJRSFnpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogZ3DGvQpv2k6ADYAy3sobBQuPA7xXyxp2IR4AQ3FbPlVlh4EBXkapSsHvDiqd6bd
         k6Jg6aaGaUAAckERGj/2SovqAsg6TukCEDi07EJEAsOgyZ/U7uUPCGPCQYWcuwbyJ5
         olZHouW1t93osddh2Qwe2hw/fJyyhsExrfQuyNyg=
Date:   Wed, 20 Mar 2019 14:24:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: Mark expected switch fall-throughs
Message-ID: <20190320192454.GB251185@google.com>
References: <20190320182715.GA9406@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320182715.GA9406@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 20, 2019 at 01:27:15PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.

Does this fix all the remaining cases in drivers/pci?  I'd like to fix
them all at once.

What's the best way to watch for new warnings being added?  I fiddled
with "make W=2" etc but it didn't seem useful.  Does the 0-day robot
warn when -Wimplicit-fallthrough warnings are added?

Bjorn

> This patch fixes the following warnings:
> 
> drivers/pci/proc.c: In function ‘proc_bus_pci_ioctl’:
> drivers/pci/proc.c:216:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (arch_can_pci_mmap_wc()) {
>       ^
> drivers/pci/proc.c:225:2: note: here
>   default:
>   ^~~~~~~
> 
> drivers/pci/xen-pcifront.c: In function ‘pcifront_backend_changed’:
> drivers/pci/xen-pcifront.c:1105:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (xdev->state == XenbusStateClosed)
>       ^
> drivers/pci/xen-pcifront.c:1108:2: note: here
>   case XenbusStateClosing:
>   ^~~~
> 
> Notice that, in this particular case, the /* fall through */
> comment is placed at the very bottom of the case statement,
> which is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/proc.c         | 1 +
>  drivers/pci/xen-pcifront.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 6fa1627ce08d..445b51db75b0 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -222,6 +222,7 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
>  		}
>  		/* If arch decided it can't, fall through... */
>  #endif /* HAVE_PCI_MMAP */
> +		/* fall through */
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index eba6e33147a2..14cf0f41ecf0 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -1104,7 +1104,7 @@ static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
>  	case XenbusStateClosed:
>  		if (xdev->state == XenbusStateClosed)
>  			break;
> -		/* Missed the backend's CLOSING state -- fallthrough */
> +		/* fall through - Missed the backend's CLOSING state. */
>  	case XenbusStateClosing:
>  		dev_warn(&xdev->dev, "backend going away!\n");
>  		pcifront_try_disconnect(pdev);
> -- 
> 2.21.0
> 
