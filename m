Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:53914 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbbCBH5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 02:57:25 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Mon, 2 Mar 2015 17:57:23 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 68B8C2BB0040
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2015 18:57:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t227vDSw40960020
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:57:22 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t227umvq017056
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 18:56:48 +1100
Message-ID: <1425282979.4636.10.camel@au1.ibm.com>
Subject: Re: [PATCH v12 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 02 Mar 2015 18:56:19 +1100
In-Reply-To: <20150302075036.GH21571@richard>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	 <20150224083435.32124.65099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	 <20150224084653.GI6220@google.com> <20150302075036.GH21571@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2015-03-02 at 15:50 +0800, Wei Yang wrote:
> >
> >Is there a hotplug remove path where we should also be calling
> >iommu_free_table()?
> 
> When VF is not introduced, no one calls this on powernv platform.
> 
> Each PCI bus is a PE and it has its own iommu table, even a device is
> hotpluged, the iommu table will not be released.

Actually, I believe Alexey patches to add support for dynamic DMA
windows for KVM guests using VFIO will also alloc/free iommu tables. In
fact his patches somewhat change quite a few things in that area, and
I'm currently reviewing them.

Wei, can you post a new series when you've finished sync'ing with
Bjorn ? At that point, I'll try to work with Alexey to evaluate the
impact of his changes on your patches.

Cheers,
Ben.


