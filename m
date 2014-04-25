Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbaDYI7E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Apr 2014 04:59:04 -0400
Date: Fri, 25 Apr 2014 11:00:30 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Shahed Shaikh <shahed.shaikh@qlogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Dept-HSG Linux NIC Dev <Dept-HSGLinuxNICDev@qlogic.com>,
	netdev <netdev@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] qlcnic: Use pci_enable_msix_exact() instead
 of pci_enable_msix()
Message-ID: <20140425090029.GA2500@dhcp-26-207.brq.redhat.com>
References: <cover.1398412015.git.agordeev@redhat.com>
 <0a0d5f5c33d86e3777c22c3c1bbd81035660d57c.1398412015.git.agordeev@redhat.com>
 <262CB373A6D1F14F9B81E82F74F77D5A46F9EE54@avmb2.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <262CB373A6D1F14F9B81E82F74F77D5A46F9EE54@avmb2.qlogic.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 25, 2014 at 08:48:14AM +0000, Shahed Shaikh wrote:
> > diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> > b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> > index dbf7539..26f022b 100644
> > --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> > +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> > @@ -690,8 +690,8 @@ int qlcnic_setup_tss_rss_intr(struct qlcnic_adapter
> > *adapter)
> >  		adapter->msix_entries[vector].entry = vector;
> > 
> >  restore:
> > -	err = pci_enable_msix(pdev, adapter->msix_entries, num_msix);
> > -	if (err > 0) {
> > +	err = pci_enable_msix_exact(pdev, adapter->msix_entries,
> > num_msix);
> > +	if (err == -ENOSPC) {
> >  		if (!adapter->drv_tss_rings && !adapter->drv_rss_rings)
> >  			return -ENOSPC;
> 
> I think, it would be good if we return "err" instead of "-ENOSPC" .
>   
>                 if (!adapter->drv_tss_rings && !adapter->drv_rss_rings)
> -                       return -ENOSPC;
> +                       return err;

At this point "err" could only be -ENOSPC. I am not sure why returning
"err" is better, but I'll repost if you insist.

> 
> Thanks,
> Shahed
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
