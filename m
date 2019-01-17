Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55465C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7B20855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547736426;
	bh=DET5lPdVz4oKb2peBHvW/UlN0wKOs+MypNk5v2wp02U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxVKtiZInr2vNp3YJ6c1432NzQLMCPOLayqJMjf1yVVgxPlox0yN+vNb+HYARhTrw
	 t0QX+xA6P2swUqbyetACGGgZ1rZVrT4zwp2Vezje8i7+mx2UGEkUTlYWD4ez/0fvTD
	 +AZNTubiB1GXhmNsdg9h6LgX0+Yoo4c/PPBb193c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfAQOrF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfAQOrF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 09:47:05 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580A020652;
        Thu, 17 Jan 2019 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547736424;
        bh=DET5lPdVz4oKb2peBHvW/UlN0wKOs+MypNk5v2wp02U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRQteO3w6XtMth6mwZjk2WVSnGaFiyyAdDoaUYx2lwdHhB39pgiZS6NQ3SFwaPmLf
         I4Kwafb2J/WfFOVLS8PhRHTzUcN9ZjaWaBQhod8B+VfvjKs9lusLD/c/f3GjtTKcZP
         2waUBW75QoapIXh7uYOnIGCGVhvh+BdjqyZ49oM0=
Date:   Thu, 17 Jan 2019 08:47:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] PCI: fix using __initdata memory after free in
 disable_acs_redir parameter
Message-ID: <20190117144703.GC158366@google.com>
References: <20190115173203.14850-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115173203.14850-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 15, 2019 at 10:32:03AM -0700, Logan Gunthorpe wrote:
> The disable_acs_redir parameter stores a pointer to the string passed to
> pci_setup(). However, the string passed to PCI setup is actually a
> temporary copy allocated in static __initdata memory. After init, once
> the memory is freed, it is no longer valid to reference this pointer.
> 
> This bug was noticed in v5.0-rc1 after a change in commit c5eb1190074c
> ("PCI / PM: Allow runtime PM without callback functions") caused
> pci_disable_acs_redir() to be called during shutdown which manifested
> as an unable to handle kernel paging request at:
> 
> RIP: 0010:pci_enable_acs+0x3f/0x1e0
> Call Trace:
>    pci_restore_state.part.44+0x159/0x3c0
>    pci_restore_standard_config+0x33/0x40
>    pci_pm_runtime_resume+0x2b/0xd0
>    ? pci_restore_standard_config+0x40/0x40
>    __rpm_callback+0xbc/0x1b0
>    rpm_callback+0x1f/0x70
>    ? pci_restore_standard_config+0x40/0x40
>     rpm_resume+0x4f9/0x710
>    ? pci_conf1_read+0xb6/0xf0
>    ? pci_conf1_write+0xb2/0xe0
>    __pm_runtime_resume+0x47/0x70
>    pci_device_shutdown+0x1e/0x60
>    device_shutdown+0x14a/0x1f0
>    kernel_restart+0xe/0x50
>    __do_sys_reboot+0x1ee/0x210
>    ? __fput+0x144/0x1d0
>    do_writev+0x5e/0xf0
>    ? do_writev+0x5e/0xf0
>    do_syscall_64+0x48/0xf0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> It was also likely possible to trigger this bug when hotplugging PCI
> devices.
> 
> To fix this, instead of storing a pointer, we use kstrdup to copy the
> disable_acs_redir_param to its own buffer which will never be freed.
> 
> Fixes: aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied with Jarkko's tested- and reviewed-by to for-linus for v5.0,
thanks!

> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..c25acace7d91 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6195,7 +6195,8 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "pcie_scan_all", 13)) {
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> -				disable_acs_redir_param = str + 18;
> +				disable_acs_redir_param =
> +					kstrdup(str + 18, GFP_KERNEL);
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);
> -- 
> 2.19.0
> 
