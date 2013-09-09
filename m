Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:40477 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3IICOe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Sep 2013 22:14:34 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 9 Sep 2013 07:34:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id DE934E0054
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2013 07:45:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r892GM4K38928392
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 07:46:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r892ERbW016069
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 07:44:28 +0530
Date: Mon, 9 Sep 2013 10:14:26 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
Message-ID: <20130909021426.GC6953@weiyang.vnet.ibm.com>
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

Currently no. I believe the two platforms I have met, x86 and powerpc, don't
have this status.

>
>I'm sure that situation exists, or Kenji and Alex would not have
>made the change in 79af72d7, but I don't know the details.

Agree, willing to hear about some backgroups about the original patch.

>
>I'd like to know the details so I can recognize similar problems
>elsewhere.
>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/setup-bus.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 520210f..989de3c 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1134,7 +1134,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
>>  	}
>>  
>>  	/* The root bus? */
>> -	if (!bus->self)
>> +	if (pci_is_root_bus(bus))
>>  		return;
>>  
>>  	switch (bus->self->class >> 8) {
>> -- 
>> 1.7.1
>> 

-- 
Richard Yang
Help you, Help me

