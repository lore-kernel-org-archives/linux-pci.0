Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:60370 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaFYH4x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 03:56:53 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Wed, 25 Jun 2014 17:56:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id E73D32BB0040
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 17:56:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5P7YRnC11206944
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 17:34:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5P7uitK011270
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 17:56:45 +1000
Message-ID: <1403682997.4587.208.camel@pasglop>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table
 dynamically
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Date: Wed, 25 Jun 2014 17:56:37 +1000
In-Reply-To: <53AA7F30.40504@ozlabs.ru>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
	 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
	 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
	 <53AA7F30.40504@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-06-25 at 17:50 +1000, Alexey Kardashevskiy wrote:

> > Yes, iommu_talbe's life time equals to PE lifetime, so when releasing a PE we
> > need to release the iommu table. Currently, there is one function to release
> > the iommu table, iommu_free_table() which takes a pointer of the iommu_table
> > and release it.
> > 
> > If the iommu table in PE is just a part of PE, it will have some problem to
> > release it with iommu_free_table(). That's why I make it a pointer in PE
> > structure.
> 
> So you are saying that you want to release PE by one kfree() and release
> iommu_table by another kfree (embedded into iommu_free_table()). For me
> that means that PE and iommu_table have different lifetime.
> 
> And I cannot find the exact place in this patchset where you call
> iommu_free_table(), what do I miss?

He has a point though... iommu_free_table() does a whole bunch of things
in addition to kfree at the end.

This is a discrepancy in the iommu.c code, we don't allocate the table,
it's allocated by our callers, but we do free it in iommu_free_table().

My gut feeling is that we should fix that in the core by moving the
kfree() out of iommu_free_table() and back into vio.c and
pseries/iommu.c, the only two callers, otherwise we can't wrap the table
structure inside another object if we are going to ever free it.

Cheers,
Ben.




