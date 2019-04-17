Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58836C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4B02183E
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555536946;
	bh=SJZSA0fLSDTiWyoKeLOooKR6+2R8Vzq7qlRdn+v/hVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nASerDTGqf5UGhEhdYeAWKtu42kpduyzyycAyRGXid/3XLqAc/lk1vouPTpmU/IuQ
	 khnjlKgHY7uvOGRMDLxsUVzbfJ8+2VQh8nx21kUzPpd8tqcIVknLaNyCZ0kTbwhCWH
	 8jJ9yjXjtMkrj8w0Ya8eTv4408vdkapxgflFzZtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfDQVfp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQVfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 17:35:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E57217FA;
        Wed, 17 Apr 2019 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555536944;
        bh=SJZSA0fLSDTiWyoKeLOooKR6+2R8Vzq7qlRdn+v/hVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0tAra3z17APRqg1cXBU+ZIs+qMG8GgkE5e83EhUPlx6bkF1brK8gUWDQxLtdNXJK
         WmlGH8rdgP9A7vrtJYko1vKA7ETlkHXUDi9Mhtqzd4va7ImwmAMpm9aovmTuUetPX7
         cXxIxus6lTn3u2gb97uQlXWTmJ1Fo6Urc3sqEXqk=
Date:   Wed, 17 Apr 2019 16:35:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: This patch fix the following checkpatch
 warning.
Message-ID: <20190417213542.GU126710@google.com>
References: <1555433020-3830-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555433020-3830-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mohan,

On Tue, Apr 16, 2019 at 07:43:40PM +0300, Mohan Kumar wrote:
> Use pr_err instead of printk

I don't mind taking patches like these, but they do tend to clutter
the revision history if we're not careful.  So here are some hints:

  - Make the subject line useful.  The one here really doesn't tell me
    anything.  Run "git log --oneline drivers/pci/bus.c" and follow
    the conventions there.  Something like:

      PCI: Convert printk(KERN_*) to pr_*()

  - Do all the similar changes at once.  I notice similar things in
    these files:

      drivers/pci/pci-acpi.c
      drivers/pci/pci-stub.c
      drivers/pci/pci-sysfs.c
      drivers/pci/pci.c
      drivers/pci/pcie/aspm.c
      drivers/pci/quirks.c
      drivers/pci/setup-bus.c
      drivers/pci/slot.c

    plus several in drivers/pci/hotplug/.  These could all be done in
    a single patch.

  - If there are several in a file that use the same prefix, add a
    "#define pr_fmt()".  This should be a separate patch so each patch
    does only one type of change, which makes them easier to review.

  - There are several uses of "printk(KERN_DEBUG)",
    "dev_printk(KERN_DEBUG)", and "pci_printk(KERN_DEBUG)".  The
    obvious thing would be to convert those to pr_debug(), dev_dbg(),
    and pci_dbg(), but I don't like that approach because pr_debug()
    and friends do different things depending on how the kernel is
    built.  The uses in PCI provide information that I want to appear
    in the dmesg log *always*.  So they could be (a) left alone or (b)
    converted from KERN_DEBUG to KERN_INFO (i.e., converted to
    pr_info(), dev_info(), etc).

> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
> then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5cb40b2..2179a8b 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -23,7 +23,7 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  
>  	entry = resource_list_create_entry(res, 0);
>  	if (!entry) {
> -		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
> +		pr_err("PCI: can't add host bridge window %pR\n", res);
>  		return;
>  	}
>  
> -- 
> 2.7.4
> 
