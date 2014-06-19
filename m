Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:47186 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbaFSJmO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 05:42:14 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 19 Jun 2014 15:12:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id CC353E0045
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 15:13:13 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5J9h9wD4260136
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 15:13:09 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5J9g4BJ020439
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 15:12:05 +0530
Date: Thu, 19 Jun 2014 17:42:02 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	gwshan@linux.vnet.ibm.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, yan@linux.vnet.ibm.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH V3 14/17] ppc/pci: create/release dev-tree node for
 VFs
Message-ID: <20140619094202.GA10609@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-15-git-send-email-weiyang@linux.vnet.ibm.com>
 <CACxGe6v6Rdd=GQ8qR5LQ64NThidn7kn3WkKFkOXOsNuWq75D-A@mail.gmail.com>
 <20140619024651.GC6478@richard>
 <CACxGe6sgOh3MP-03Ge9NK7DWf+dgC98huA9Sv4DcThXNfByf2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACxGe6sgOh3MP-03Ge9NK7DWf+dgC98huA9Sv4DcThXNfByf2w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 19, 2014 at 09:30:47AM +0100, Grant Likely wrote:
>On Thu, Jun 19, 2014 at 3:46 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Wed, Jun 18, 2014 at 07:26:27PM +0100, Grant Likely wrote:
>>>On Tue, Jun 10, 2014 at 2:56 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>>>> Currently, powernv platform is not aware of VFs. This means no dev-node
>>>> represents a VF. Also, VF PCI device is created when PF driver want to enable
>>>> it. This leads to the pdn->pdev and pdn->pe_number an invalid value.
>>>>
>>>> This patch create/release dev-node for VF and fixs this when a VF's pci_dev
>>>> is created.
>>>>
>>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>
>>>I don't think this is the right way to handle this. Unless it is a
>>>fixup to a buggy devicetree provided by firmware, I don't want to see
>>>any code modifying the devicetree to describe stuff that is able to be
>>>directly enumerated. Really the pci code should handle the lack of a
>>>device_node gracefully. If it cannot then it should be fixed.
>>
>> Grant,
>>
>> Glad to see your comment.
>>
>> I will fix this in the firmware.
>
>That's not really what I meant. The kernel should be able to deal with
>virtual functions even if firmware doesn't know how, and the kernel
>should not require modifying the device tree to support them.
>
>I'm saying fix the kernel so that a device node is not necessary for
>virtual functions.

oh, sorry for my poor understanding. Let me do some investigation to see
whether it is fine to get rid of device node for vfs.

>
>g.

-- 
Richard Yang
Help you, Help me

