Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35884 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbaGERwT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jul 2014 13:52:19 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so2386349ieb.20
        for <linux-pci@vger.kernel.org>; Sat, 05 Jul 2014 10:52:19 -0700 (PDT)
Date: Sat, 5 Jul 2014 11:52:16 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Ryan Desfosses <ryan@desfo.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers/pci/hotplug/cpqphp_sysfs.c: remove
 unnecessary null test before debugfs_remove
Message-ID: <20140705175216.GE26618@google.com>
References: <1403948683-10410-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403948683-10410-1-git-send-email-fabf@skynet.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 28, 2014 at 11:44:43AM +0200, Fabian Frederick wrote:
> Fix checkpatch warning:
> "WARNING: debugfs_remove(NULL) is safe this check is probably not required"
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ryan Desfosses <ryan@desfo.org>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied to pci/hotplug for v3.17, thanks!

> ---
>  drivers/pci/hotplug/cpqphp_sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
> index 4a392c4..d81648f 100644
> --- a/drivers/pci/hotplug/cpqphp_sysfs.c
> +++ b/drivers/pci/hotplug/cpqphp_sysfs.c
> @@ -216,8 +216,7 @@ void cpqhp_create_debugfs_files(struct controller *ctrl)
>  
>  void cpqhp_remove_debugfs_files(struct controller *ctrl)
>  {
> -	if (ctrl->dentry)
> -		debugfs_remove(ctrl->dentry);
> +	debugfs_remove(ctrl->dentry);
>  	ctrl->dentry = NULL;
>  }
>  
> -- 
> 1.8.4.5
> 
