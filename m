Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:39458 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab3IIHAZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 03:00:25 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 9 Sep 2013 12:21:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1AB5D1258043
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2013 12:30:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r8972FLZ46006374
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 12:32:15 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r8970JdJ031954
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 12:30:20 +0530
Date: Mon, 9 Sep 2013 15:00:17 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
Message-ID: <20130909070017.GB3726@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130906230941.GC12956@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130906230941.GC12956@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 06, 2013 at 05:09:41PM -0600, Bjorn Helgaas wrote:
>[+cc Kenji, Alex]
>
>On Fri, Sep 06, 2013 at 09:45:56AM +0800, Wei Yang wrote:
>> In __pci_bus_size_bridges() we check whether a pci bus is a root
>> bus by testing bus->self. As indicated by commit 79af72d7
>> ("PCI: pci_is_root_bus helper"), bus->self == NULL is not a proper
>> way to check the pci root bus.
>> 
>> This patch changes it to pci_is_root_bus() to check whether it is
>> a root bus.
>
>I think this is a good change, even if only on the grounds of
>consistency.
>
>Did you trip over a case where a root bus has bus->self != NULL?
>I'd like to know more details about the case where:
>
>  (bus->parent == NULL) && (bus->self != NULL)

I found one case that (bus->self == NULL) and this bus is not root bus.

Not sure, this case will meet your requirement?

-- 
Richard Yang
Help you, Help me

