Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49983 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbDCTGB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 15:06:01 -0400
Date: Fri, 03 Apr 2015 15:05:58 -0400 (EDT)
Message-Id: <20150403.150558.188543237134528987.davem@davemloft.net>
To: bhelgaas@google.com
Cc: yinghai@kernel.org, david.ahern@oracle.com,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150403185939.GC10892@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-2-git-send-email-yinghai@kernel.org>
	<20150403185939.GC10892@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Apr 2015 13:59:39 -0500

> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>> David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>> to fit in upstream windows") broke booting on sparc/T5-8.
>> 
>> In the boot log, there is
>>   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>   0x110204000)
>> but that only could happen when dma_addr_t is 32-bit.
>> 
>> According to David Miller, all DMA occurs behind an IOMMU and these
>> IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>> 32-bit on sparc64.
>> 
>> Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>> and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
> 
> I propose the following doc updates (I can just fold them into this patch
> if you approve):

No objection.
