Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:54746 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbaFYJbZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 05:31:25 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 25 Jun 2014 15:01:21 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 33F7C394004E
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 15:01:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5P9VSrZ35127544
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 15:01:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5P9VCqe009831
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 15:01:13 +0530
Date: Wed, 25 Jun 2014 17:31:10 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Cc: "'Wei Yang'" <weiyang@linux.vnet.ibm.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	"benh@au1.ibm.com" <benh@au1.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
	"yan@linux.vnet.ibm.com" <yan@linux.vnet.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table
 dynamically
Message-ID: <20140625093110.GA8362@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru>
 <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru>
 <20140625052758.GA8873@richard>
 <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 09:20:11AM +0000, David Laight wrote:
>From: Wei Yang
>> On Wed, Jun 25, 2014 at 02:12:34PM +1000, Alexey Kardashevskiy wrote:
>> >On 06/25/2014 11:12 AM, Wei Yang wrote:
>> >> On Tue, Jun 24, 2014 at 08:06:32PM +1000, Alexey Kardashevskiy wrote:
>> >>> On 06/10/2014 11:56 AM, Wei Yang wrote:
>> >>>> Current iommu_table of a PE is a static field. This will have a problem when
>> >>>> iommu_free_table is called.
>> >>>
>> >>> What kind of problem? This table is per PE and PE is not going anywhere.
>> >>>
>> >>
>> >> Yes, for Bus PE, they will always sit in the system. When VF PE introduced,
>> >> they could be released on the fly. When they are released, so do the iommu
>> >> table for the PE.
>> >
>> >iommu_table is a part of PE struct. When PE is released, iommu_table will
>> >go with it as well. Why to make is a pointer? I would understand it if you
>> >added reference counting there but no - iommu_table's lifetime is equal to
>> >PE lifetime.
>> >
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
>What are the sizes of the iommu table and the PE structure?

I calculated it in my mind, the size of iommu_table, defined in
arch/powerpc/include/asm/iommu.h is 256 bytes.

>If the table is a round number of pages then you probably don't want to
>embed it inside the PE structure.

If my understanding is correct, the iommu table structure size is not that
big.

>
>	David
>

-- 
Richard Yang
Help you, Help me

