Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:56875 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbGOCJD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 22:09:03 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 15 Jul 2015 07:38:58 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7ED7EE0056
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 07:42:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F28sa240632380
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 07:38:55 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F0qiwm001893
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 06:22:44 +0530
Date: Wed, 15 Jul 2015 10:08:52 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/4] PCI: code clean up on pci configuration space
Message-ID: <20150715020852.GD6525@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150714213738.GJ24416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714213738.GJ24416@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 04:37:38PM -0500, Bjorn Helgaas wrote:
>On Tue, Jun 30, 2015 at 09:16:40AM +0800, Wei Yang wrote:
>> This series is a clean up in the pci subsystem when accessing the pci
>> configuration space.
>> 
>> The first one is to re-use the PCI_FIND_CAP_TTL to limit the times iterating
>> in pci configuration space.
>> 
>> The next three are to use the exact type to access the pci cap and pcie ext
>> cap.
>> 
>> Tested on x86 and powerpc on top of v4.1.
>> 
>> The original thread could be referenced in below link:
>> http://comments.gmane.org/gmane.linux.kernel.pci/35931
>> 
>> ---
>> v1->v2:
>>    * define PCI_FIND_CAP_TTL in drivers/pci/pci.h instead of
>>      include/linux/pci.h
>>    * split the change for return position check from second one, and make the
>>      forth patch
>> 
>> Wei Yang (4):
>>   PCI: move PCI_FIND_CAP_TTL to pci.h and use it in quirks
>>   PCI: use u8 to represent pci configuration space pos and cap
>>   PCI: use u16 to represent pci express extended capabilities pos and
>>     cap
>>   PCI: consolidate return value check for pci_find_(ext_)capability
>
>The first and last seem fine to me.  As far as I can tell, the last does
>not actually depend on the u8 and u16 changes.
>

With patch 2/3, changing the return value, it makes sure pos will not be
negative. So that patch 4 could make sure there is not cap when pos is 0. And
no possibility to check the negative value.

>The u8 and u16 patches change the signatures of several exported functions.
>Do they fix some problem?  Unless there's something broken, these seem like
>pretty minor changes, and I don't think they're worth it.
>

You are right, no functional change and currently no bug related.

While without 2/3, it would not be that clear the pos return value must not
be negative. Then then the change in patch 4 would not be that obvious.

>Bjorn

-- 
Richard Yang
Help you, Help me

