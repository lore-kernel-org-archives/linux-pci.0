Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:52920 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686Ab2FTIqh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 04:46:37 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 20 Jun 2012 08:25:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5K8bhel18350172
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 18:37:43 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5K8jI4r031597
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 18:45:19 +1000
Date: Wed, 20 Jun 2012 16:45:15 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>
Subject: One question about the useage of pci_dev->resource[]
Message-ID: <20120620084515.GA22809@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

I want to confirm something for the pci_dev->resource[].

As in the definition in the pci.h, this resource array is divided into
several parts.
    0-5  for standard PCI resources
    6    for ROM resource
    7-10 for bridge resource( if no iov )


1. For P2P bridge, 0-5 is left empty?
2. If so, in code pci_setup_device(), I think it set the wrong resource.
   It call pci_read_bases(dev, 2, PCI_ROM_ADDRESS1), for a p2p bridge. 
   And in pci_read_bases(), BAR information is retrieved and set to
   pci_dev->resource[0|1].
3. If pci_setup_device() just set first two resource, the child bus will
   point to empty resource.
   In pci_alloc_child_bus(), child->resource[0-3] will be point to
   bridge->resource[7-10], which is not set in pci_setup_device().
4. Another question is, is there any convention for pci_bus->resource[].
   [0] for io, [1] for mem, [2] for prefetch?

-- 
Richard Yang
Help you, Help me

