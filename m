Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56901 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab2EKXi0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2012 19:38:26 -0400
Received: by dady13 with SMTP id y13so3664678dad.19
        for <linux-pci@vger.kernel.org>; Fri, 11 May 2012 16:38:26 -0700 (PDT)
Date: Fri, 11 May 2012 16:38:21 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: benh@kernel.crashing.org, aik@ozlabs.ru,
	david@gibson.dropbear.id.au, joerg.roedel@amd.com,
	dwmw2@infradead.org, chrisw@sous-sol.org, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com,
	kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 01/13] driver core: Add iommu_group tracking to struct
 device
Message-ID: <20120511233821.GA9335@kroah.com>
References: <20120511222148.30496.68571.stgit@bling.home>
 <20120511225534.30496.54563.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120511225534.30496.54563.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 04:55:35PM -0600, Alex Williamson wrote:
> IOMMU groups allow IOMMU drivers to represent DMA visibility
> and isolation of devices.  Multiple devices may be grouped
> together for the purposes of DMA.  Placing a pointer on
> struct device enable easy access for things like streaming
> DMA programming and drivers like VFIO.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Can't you get this today from the iommu_ops pointer that is on the bus
that the device is associated with?  Or can devices on a bus have
different iommu_group pointers?

thanks,

greg k-h
