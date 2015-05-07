Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:59842 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbEGCgw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 22:36:52 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 7 May 2015 12:36:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6E3C13578048
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2015 12:36:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t472ad5646334000
	for <linux-pci@vger.kernel.org>; Thu, 7 May 2015 12:36:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t472aFgC025922
	for <linux-pci@vger.kernel.org>; Thu, 7 May 2015 12:36:15 +1000
Date: Thu, 7 May 2015 10:35:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
Message-ID: <20150507023557.GA6645@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150505212905.GB24643@google.com>
 <20150506060933.GA19030@richard>
 <CAErSpo7xis8=QWOeOubZmRxY0v3jSqC0WxGCo-KaEJisCJGB6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7xis8=QWOeOubZmRxY0v3jSqC0WxGCo-KaEJisCJGB6Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 10:30:39AM -0500, Bjorn Helgaas wrote:
>On Wed, May 6, 2015 at 1:09 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, May 05, 2015 at 04:29:05PM -0500, Bjorn Helgaas wrote:
>
>>>Prior to your patch, the VF reference was released in virtfn_remove(),
>>>which is only called via pci_disable_sriov().  This typically happens in
>>>a driver .remove() method.  The reference is *not* released if we call
>>>pci_stop_and_remove_bus_device(VF) directly, as we would via the
>>>remove_store() (sysfs "remove" file) or hot unplug paths, e.g.,
>>>pciehp_unconfigure_device().
>>
>> You want to say the reference for VF or PF?
>
>Yes, I meant the PF reference.
>
>The hot unplug paths call pci_stop_and_remove_bus_device() for the VFs
>first, then the PF.  Calling it for the VF releases the VF reference
>but not the PF one.  Calling it for the PF will call virtfn_remove()
>via the driver's .remove() method, but it probably does nothing
>because when it calls pci_get_domain_bus_and_slot() to get the virtfn,
>it gets a NULL because the VF has already been removed.
>
>>>What about the other things done in virtfn_remove(), e.g., the sysfs link
>>>removal?  Your patch fixes a reference count leak, but don't we still have
>>>a sysfs link leak?
>>
>> Agree, I am afraid the sysfs would have a leak too.
>>
>> While I am not that familiar with the sysfs part, I don't dare to move that to
>> pci_destroy_dev(). Need more investigation.
>
>OK.  I don't want to fix half of the leak problem.  I want to fix the
>whole thing at once.
>

Sure, I will do some investigation and repost it.

BTW, seems we also face the leak of the virtual bus. Will fix it in next
version too.

>Bjorn

-- 
Richard Yang
Help you, Help me

