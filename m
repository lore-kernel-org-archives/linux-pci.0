Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:34084 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbaFYJNt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 05:13:49 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 25 Jun 2014 14:43:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8C8651258055
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 14:43:12 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5P9EpBa58196208
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 14:44:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5P9Dclh002164
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 14:43:39 +0530
Date: Wed, 25 Jun 2014 17:13:36 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table
 dynamically
Message-ID: <20140625091336.GA5573@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru>
 <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru>
 <20140625052758.GA8873@richard>
 <53AA7F30.40504@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53AA7F30.40504@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 05:50:08PM +1000, Alexey Kardashevskiy wrote:
>On 06/25/2014 03:27 PM, Wei Yang wrote:
>> On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>>> On 06/25/2014 11:12 AM, Wei Yang wrote:
>>>> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>>>>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>>>>>> Current iommu_table of a PE is a static field. This will have a problem when
>>>>>> iommu_free_table is called.
>>>>>
>>>>> What kind of problem? This table is per PE and PE is not going anywhere.
>>>>>
>>>>
>>>> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>>>> they could be released on the fly. When they are released, so do the iommu
>>>> table for the PE.
>>>
>>> iommu_table is a part of PE struct. When PE is released, iommu_table will
>>> go with it as well. Why to make is a pointer? I would understand it if you
>>> added reference counting there but no - iommu_table's lifetime is equal to
>>> PE lifetime.
>>>
>> 
>> Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
>> need to release the iommu table. Currently, there is one function to release
>> the iommu table, iommu_free_table() which takes a pointer of the iommu_table
>> and release it.
>> 
>> If the iommu table in PE is just a part of PE, it will have some problem to
>> release it with iommu_free_table(). That's why I make it a pointer in PE
>> structure.
>
>So you are saying that you want to release PE by one kfree() and release
>iommu_table by another kfree (embedded into iommu_free_table()). For me
>that means that PE and iommu_table have different lifetime.
>

Hmm... it is right, the lifetime of these two may have some difference.

>And I cannot find the exact place in this patchset where you call
>iommu_free_table(), what do I miss?
>

This is called in pnv_pci_release_dev_dma(), which is introduced in the commit
cd740988: powerpc/powernv: allocate VF PE

>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me

