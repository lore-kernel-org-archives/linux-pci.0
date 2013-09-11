Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:57074 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3IKApx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2013 20:45:53 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 11 Sep 2013 21:39:29 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A34062CE8051
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2013 10:45:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r8B0TFkD4260274
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2013 10:29:15 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r8B0jiFA017346
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2013 10:45:45 +1000
Date: Wed, 11 Sep 2013 08:45:40 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
Message-ID: <20130911004540.GA7654@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130906230941.GC12956@google.com>
 <20130909070017.GB3726@weiyang.vnet.ibm.com>
 <CAErSpo5BTV_b1NpeifuAPwHvfsrAERpdmwgnUFMS6gQ3Asik-Q@mail.gmail.com>
 <20130910074611.GA11724@weiyang.vnet.ibm.com>
 <1378808696.4121.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378808696.4121.9.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 10, 2013 at 08:24:56PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-09-10 at 15:46 +0800, Wei Yang wrote:
>> On some platforms, like powernv, each pci-dev has a dev-tree node to represent
>> it. The dev-tree node is set by pci_set_of_node() during pci_scan_device().
>> 
>> In pci_set_of_node(), it searchs for the node with the same devfn in its
>> parent. Here comes the question, who should be the VF's parent. Would be a
>> conflict for the devfn between PF and VF?
>
>I think it makes no sense to create OFW nodes for VFs under powernv anyway ...
>
>(which is another reason why we need urgently to disconnect the EEH data
>from the device node ...)

Ok, got it.

>
>Cheers,
>Ben.
>

-- 
Richard Yang
Help you, Help me

