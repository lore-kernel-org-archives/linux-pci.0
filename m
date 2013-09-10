Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:60572 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab3IJHqV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2013 03:46:21 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Sep 2013 13:09:22 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id F2CD1394005C
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2013 13:16:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r8A7mEGK38535238
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2013 13:18:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r8A7kCZu010527
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2013 13:16:13 +0530
Date: Tue, 10 Sep 2013 15:46:11 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>, benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
Message-ID: <20130910074611.GA11724@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130906230941.GC12956@google.com>
 <20130909070017.GB3726@weiyang.vnet.ibm.com>
 <CAErSpo5BTV_b1NpeifuAPwHvfsrAERpdmwgnUFMS6gQ3Asik-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5BTV_b1NpeifuAPwHvfsrAERpdmwgnUFMS6gQ3Asik-Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 09, 2013 at 10:15:07AM -0600, Bjorn Helgaas wrote:
>On Mon, Sep 9, 2013 at 1:00 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Fri, Sep 06, 2013 at 05:09:41PM -0600, Bjorn Helgaas wrote:
>>>[+cc Kenji, Alex]
>>>
>>>Did you trip over a case where a root bus has bus->self != NULL?
>>>I'd like to know more details about the case where:
>>>
>>>  (bus->parent == NULL) && (bus->self != NULL)
>>
>> I found one case that (bus->self == NULL) and this bus is not root bus.
>>
>> Not sure, this case will meet your requirement?
>
>I'm definitely interested in that case as well.  Can you include a
>complete "lspci -vv" output for the case where this happens?

I don't *see* it. I notice this during the code reading.

So yes, this happens when a virtual bus is created for SR-IOV.

Sounds this is the *only* case for (bus->self == NULl)?

>I suspect this happens with SR-IOV when we create "virtual" buses,
>i.e., in virtfn_add_bus().  I think maybe I'll update the comment at
>pci_is_root_bus() with a note about why we want to use it instead of
>testing for "bus->self == NULL".
>
>I think we still have other tree traversal issues related to those
>virtual buses, e.g., the ones I mentioned here [1].  But those are a
>separate problem.
>
>Bjorn
>
>[1] http://lkml.kernel.org/r/CAErSpo5sFfr=O-Pp=PyaxGauaEajaTr2aK-EQ_rTVUk1zyz8cA@mail.gmail.com

Here comes another problem I met recently.

On some platforms, like powernv, each pci-dev has a dev-tree node to represent
it. The dev-tree node is set by pci_set_of_node() during pci_scan_device().

In pci_set_of_node(), it searchs for the node with the same devfn in its
parent. Here comes the question, who should be the VF's parent. Would be a
conflict for the devfn between PF and VF?

-- 
Richard Yang
Help you, Help me

