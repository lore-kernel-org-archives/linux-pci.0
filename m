Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50161 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbcBWMZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:25:35 -0500
Subject: Re: [PATCH v4 11/11] PCI: Sleep rather than busy-wait for VPD access
 completion
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004742.10635.55287.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4FB6.5020709@suse.de>
Date: Tue, 23 Feb 2016 20:25:26 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004742.10635.55287.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:47 AM, Bjorn Helgaas wrote:
> Use usleep_range() instead of udelay() while waiting for a VPD access to
> complete.  This is not a performance path, so no need to hog the CPU.
> 
> Rationale for usleep_range() parameters:
> 
>   We clear PCI_VPD_ADDR_F for a read (or set it for a write), then wait for
>   the device to change it.  For a device that updates PCI_VPD_ADDR between
>   our config write and subsequent config read, we won't sleep at all and
>   can get the device's maximum rate.
> 
>   Sleeping a minimum of 10 usec per 4-byte access limits throughput to
>   about 400Kbytes/second.  VPD is small (32K bytes at most), and most
>   devices use only a fraction of that.
> 
>   We back off exponentially up to 1024 usec per iteration.  If we reach
>   1024, we've already waited up to 1008 usec (16 + 32 + ...  + 512), so if
>   we miss an update and wait an extra 1024 usec, we can still get about 1/2
>   of the device's maximum rate.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
