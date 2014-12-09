Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:45973 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902AbaLIKfb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Dec 2014 05:35:31 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 9 Dec 2014 20:35:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 59E7D2CE8065
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2014 21:35:28 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB9AZSLH36372716
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2014 21:35:28 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB9AZRVj019238
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2014 21:35:27 +1100
Date: Tue, 9 Dec 2014 18:35:25 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] PCI: Refresh offset/stride after NumVFs is written
Message-ID: <20141209103525.GA13643@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1416624759-13543-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141124230108.GA8765@shangw>
 <20141125031455.GA9070@richard>
 <20141125034651.GA5646@shangw>
 <20141125091114.GA314@richard>
 <20141125230359.GA11309@shangw>
 <20141126084051.GA11487@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141126084051.GA11487@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 26, 2014 at 04:40:51PM +0800, Wei Yang wrote:
>On Wed, Nov 26, 2014 at 10:03:59AM +1100, Gavin Shan wrote:
>>>>>>
>>>>>>The 1 second delay here might be for waiting VFs to be ready.
>>>>>>
>>>>>
>>>>>Hmm... so add this ssleep() in pci_iov_set_numvfs() would be better?
>>>>>
>>>>
>>>>I was not suggesting to do that. I just raised the concern for you
>>>>to look into.
>>>>
>>>
>>>I looked in the SPEC sec 3.3.3.1 VF Enable. In this section, it says this:
>>>
>>>To allow components to perform internal initialization, system software must wait for at least
>>>100 ms after changing the VF Enable bit from a 0 to a 1, before it is permitted to issue Requests to
>>>the VFs which are enabled by that VF Enable bit. The Root Complex and/or system software must
>>>allow at least 1.0 s after Setting the VF Enable bit, before it may determine that a VF which fails to
>>>return a Successful Completion status for a valid Configuration Request is broken. After Setting the
>>>VF Enable bit, the VFs enabled by that VF Enable bit are permitted to return a CRS status to
>>>configuration requests up to the 1.0 s limit, if they are not ready to provide a Successful Completion
>>>status for a valid Configuration Request. Additionally, a VF is not permitted to return CRS after
>>>having previously returned a Successful Completion without an intervening VF disable or other valid
>>>reset condition.
>>>
>>>As my understanding, it will take 1ms or 1s after VF Enable bit is set.
>>>Actually I am confused with the two different time, in which case we needs to
>>>wait for different time? And some place we add a lock, but no lock in others.
>>>
>>
>>Are you talking about 1ms or 100ms? I assume it's 100ms. If I
>>understand things correctly, 100ms delay before issuing config
>>read request, CRS can be returned before it reaches the timeout
>>(1 second).
>
>Took a look at the sleep again. There are five sleep in iov.c, two are 100ms
>sleep and three are 1s sleep. 100ms sleep are both after VF Enable is set. 1s
>sleep are all after VF Enable is cleared. These are stated in SRIOV SPEC
>3.3.3.1.
>
>While I still suggest to wait 1s after VF Enable is set. Otherwise we need to
>add some logic like pci_bus_read_dev_vendor_id() on VF to check whether VF is
>ready, when CRS Software Visibility is enabled on the Bridge. Like in
>sriov_enable(), the msleep() needs to be replaced by a call on a VF, while
>the VF is not created in the system yet.
>
>If my understanding is not correct, please let me know.

Bjorn,

After discussion with Gavin, I think it is ok to refresh the offset/stride
after NumVFs is written.

1. NumVFs are written all with VFE cleared (comply with SPEC)
2. The time to wait, like 100ms and 1s are the time to wait before accessing
   VF not the PF. So to me, it is not necessary to wait before retrieve the
   offset/stride after writing NumVFs.

If my understanding is not correct, please let me know.

>
>>
>>Thanks,
>>Gavin
>
>-- 
>Richard Yang
>Help you, Help me

-- 
Richard Yang
Help you, Help me

