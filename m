Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:60933 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbCBID1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2015 03:03:27 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 2 Mar 2015 18:03:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7C58A2CE8052
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2015 19:03:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2283EW230081254
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 19:03:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2282mpv013381
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2015 19:02:48 +1100
Date: Mon, 2 Mar 2015 16:02:31 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
Message-ID: <20150302080231.GK21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083435.32124.65099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084653.GI6220@google.com>
 <20150302075036.GH21571@richard>
 <1425282979.4636.10.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425282979.4636.10.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 02, 2015 at 06:56:19PM +1100, Benjamin Herrenschmidt wrote:
>On Mon, 2015-03-02 at 15:50 +0800, Wei Yang wrote:
>> >
>> >Is there a hotplug remove path where we should also be calling
>> >iommu_free_table()?
>> 
>> When VF is not introduced, no one calls this on powernv platform.
>> 
>> Each PCI bus is a PE and it has its own iommu table, even a device is
>> hotpluged, the iommu table will not be released.
>
>Actually, I believe Alexey patches to add support for dynamic DMA
>windows for KVM guests using VFIO will also alloc/free iommu tables. In
>fact his patches somewhat change quite a few things in that area, and
>I'm currently reviewing them.

Yes, I see these changes before.

>
>Wei, can you post a new series when you've finished sync'ing with
>Bjorn ? At that point, I'll try to work with Alexey to evaluate the
>impact of his changes on your patches.

Sure, I will do it ASAP.

>
>Cheers,
>Ben.
>

-- 
Richard Yang
Help you, Help me

