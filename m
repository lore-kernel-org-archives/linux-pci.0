Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:44885 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbBJGTz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 01:19:55 -0500
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Feb 2015 16:19:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A52F52CE8050
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 17:19:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1A6JeXT15269966
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 17:19:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1A6JEjo019012
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 17:19:15 +1100
Date: Tue, 10 Feb 2015 14:18:57 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
Message-ID: <20150210061857.GA31098@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423527979.4924.67.camel@au1.ibm.com>
 <20150210013532.GA6326@richard>
 <1423534394.4924.78.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423534394.4924.78.camel@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 10, 2015 at 01:13:14PM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2015-02-10 at 09:35 +0800, Wei Yang wrote:
>> >Don't we want pcibios_sriov_enable() to be able to crop the number
>> >of VFs or do we think any resource limits have been applied
>> >already ?
>> 
>> The second parameter "initial" is the number of VFs will be enabled.
>> Arch
>> dependent function will check the resources for these number of VFs.
>> 
>> Do I catch your question correctly?
>
>I was wondering if the number of resource that can be enabled is
>smaller, should the arch function be able to return that smaller
>number and we would still enable that number ?
>
>Ie, have the arch function be able to "update" the value of
>"initial" (by passing it by pointer for example).

This would increase the time to enable sriov and block others driver to enable
sriov.

On powernv platform, those resources needed are M64 BAR and PE numbers.
Currently they are acquired separately. We have a lock to protect those
resources respectively. If we want to apply the logic you mentioned, we need
to have a "bigger" lock to protect both of them and try different values,
since at the same time, other driver may want to enable their sriov too. We
have to protect this contention.

Another example is PF has two IOV BAR but just one M64 BAR left in system.
In this case, no matter how many VFs want to enable, it will fail.

>
>Cheers,
>Ben.
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me

