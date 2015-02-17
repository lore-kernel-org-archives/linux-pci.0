Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:53999 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbBQW1T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 17:27:19 -0500
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 18 Feb 2015 08:27:17 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 18B212CE8040
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 09:27:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1HMR56K14811296
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 09:27:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1HMQe2s020066
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 09:26:40 +1100
Date: Wed, 18 Feb 2015 09:26:15 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/7] powerpc/powernv: Unified PCI slot reset
 and hotplug
Message-ID: <20150217222615.GA6454@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 18, 2015 at 08:44:19AM +1100, Stewart Smith wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> The patchset was built based on patchset "powerpc/powernv: Simplify EEH
>> implementation", which can be found from:
>>
>> https://patchwork.ozlabs.org/patch/439956/
>>
>> The patchset corresponds to skiboot changes, which manages PCI slots
>> in a unified way: OPAL APIs used to do slot reset, power management,
>> presence status retrival. The patchset shouldn't be merged before
>> the OPAL firmware counterpart is merged:
>>
>> https://patchwork.ozlabs.org/patch/440463/
>
>But this patchset will work with old OPAL, right? We're not breaking
>compatibility with newer kernels (with this patchset) and older
>firmware?

Yes. With old OPAL, the reset stuff in Linux works as before and we
shouldn't see hotpluggable slots from /sys/bus/pci/slots.

The compatibility issue was pointed by Ben. It's something fixed by
this revision (v2).

Thanks,
Gavin

