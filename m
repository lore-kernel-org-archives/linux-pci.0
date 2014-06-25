Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:41501 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbaFYJTF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 05:19:05 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 25 Jun 2014 19:19:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D86F3578052
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 19:19:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5P92cLj36831364
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 19:02:38 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5P9Ixps017456
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 19:19:00 +1000
Date: Wed, 25 Jun 2014 17:18:57 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table
 dynamically
Message-ID: <20140625091857.GB5573@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru>
 <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru>
 <20140625052758.GA8873@richard>
 <53AA7F30.40504@ozlabs.ru>
 <1403682997.4587.208.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403682997.4587.208.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 05:56:37PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-06-25 at 17:50 +1000, Alexey Kardashevskiy wrote:
>
>> > Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
>> > need to release the iommu table. Currently, there is one function to release
>> > the iommu table, iommu_free_table() which takes a pointer of the iommu_table
>> > and release it.
>> > 
>> > If the iommu table in PE is just a part of PE, it will have some problem to
>> > release it with iommu_free_table(). That's why I make it a pointer in PE
>> > structure.
>> 
>> So you are saying that you want to release PE by one kfree() and release
>> iommu_table by another kfree (embedded into iommu_free_table()). For me
>> that means that PE and iommu_table have different lifetime.
>> 
>> And I cannot find the exact place in this patchset where you call
>> iommu_free_table(), what do I miss?
>
>He has a point though... iommu_free_table() does a whole bunch of things
>in addition to kfree at the end.
>
>This is a discrepancy in the iommu.c code, we don't allocate the table,
>it's allocated by our callers, but we do free it in iommu_free_table().
>
>My gut feeling is that we should fix that in the core by moving the
>kfree() out of iommu_free_table() and back into vio.c and
>pseries/iommu.c, the only two callers, otherwise we can't wrap the table
>structure inside another object if we are going to ever free it.
>

Yes, this is another option. Move the kfree() outside could keep some logic in
current code, like in pnv_pci_ioda_tce_invalidate(). We could get the tbl from
a PE structure directly, instead of adding a field in tbl to point to the PE
structure.

>Cheers,
>Ben.
>
>
>

-- 
Richard Yang
Help you, Help me

