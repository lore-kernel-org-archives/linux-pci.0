Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:57512 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab2FZB5t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jun 2012 21:57:49 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 26 Jun 2012 07:27:46 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5Q1vgtQ11272458
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 07:27:42 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5Q7SKQt017597
	for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 17:28:21 +1000
Date: Tue, 26 Jun 2012 09:57:40 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>
Subject: Re: One question about the useage of pci_dev->resource[]
Message-ID: <20120626015740.GA8128@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120620084515.GA22809@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120620084515.GA22809@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2012 at 04:45:15PM +0800, Richard Yang wrote:
>All,
>
>I want to confirm something for the pci_dev->resource[].
>
>As in the definition in the pci.h, this resource array is divided into
>several parts.
>    0-5  for standard PCI resources
>    6    for ROM resource
>    7-10 for bridge resource( if no iov )
>
>
>1. For P2P bridge, 0-5 is left empty?
>2. If so, in code pci_setup_device(), I think it set the wrong resource.
>   It call pci_read_bases(dev, 2, PCI_ROM_ADDRESS1), for a p2p bridge. 
>   And in pci_read_bases(), BAR information is retrieved and set to
>   pci_dev->resource[0|1].
>3. If pci_setup_device() just set first two resource, the child bus will
>   point to empty resource.
>   In pci_alloc_child_bus(), child->resource[0-3] will be point to
>   bridge->resource[7-10], which is not set in pci_setup_device().
>4. Another question is, is there any convention for pci_bus->resource[].
>   [0] for io, [1] for mem, [2] for prefetch?
All,

I go through the code again and find pci_dev->resource[7-10] is used for
io/mem base/limit, which is used by the bridge to determine whether it
will forward one pci transaction.

So pci_dev->[0-1] is used by the bridge's driver?

If not exact, please correct me:)

>
>-- 
>Richard Yang
>Help you, Help me

-- 
Richard Yang
Help you, Help me

