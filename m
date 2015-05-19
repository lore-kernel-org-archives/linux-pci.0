Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35874 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbbESO64 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 10:58:56 -0400
Received: by obbkp3 with SMTP id kp3so14167007obb.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 07:58:56 -0700 (PDT)
Date: Tue, 19 May 2015 09:58:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 1/2] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150519145853.GP31666@google.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
 <1431431730-25164-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431431730-25164-2-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 12, 2015 at 03:03:32PM +0200, Michael S. Tsirkin wrote:
> d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
> ... 

I know you're trying to put all the justification in the changelog, and
that's great if it can be done.  But would you please just add the single
link here to https://bugzilla.kernel.org/show_bug.cgi?id=96571 ?

And please attach the dmesg log and instructions for reproducing the
problem to the bugzilla.  I've asked for this before, and it seems like a
simple request, but maybe there's a reason it's more complicated than it
seems to me.  It's obvious to you how all this fits together, but I'd like
it to be more concrete to the rest of us, too.

The bugzilla says Ulrich Obergfell noticed this in RHEL7.  If there's a
RHEL bugzilla, it'd be nice to have a link to it in the kernel.org
bugzilla.  Informal hints are great right now, but they'll be useless after
six months.

Bjorn

> Reported-by: Fam Zheng <famz@redhat.com>
> Tested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
> CC: Ulrich Obergfell <uobergfe@redhat.com>
> CC: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/pci/pci-driver.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..38a602c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> -	pci_msi_shutdown(pci_dev);
> -	pci_msix_shutdown(pci_dev);
>  
>  #ifdef CONFIG_KEXEC
>  	/*
> -- 
> MST
> 
