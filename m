Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:47768 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeAKIcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jan 2018 03:32:08 -0500
Subject: Re: [PATCH v2] PCI: endpoint: Use EPC's device in
 dma_alloc_coherent/dma_free_coherent
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20171219083627.7904-1-kishon@ti.com>
 <20180110111130.GA27463@red-moon>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8af4c0ae-e132-e56c-7e07-bbe4b78265bd@ti.com>
Date: Thu, 11 Jan 2018 14:01:57 +0530
MIME-Version: 1.0
In-Reply-To: <20180110111130.GA27463@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 10 January 2018 04:41 PM, Lorenzo Pieralisi wrote:
> On Tue, Dec 19, 2017 at 02:06:27PM +0530, Kishon Vijay Abraham I wrote:
>> After commit 723288836628bc1c08 ("of: restrict DMA configuration"),
>> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
>> of endpoint function device (since it doesn't have a dt node associated
>> with and hence no dma-ranges property), resulting in dma_alloc_coherent
>> (used in pci_epf_alloc_space) to fail.
>>
>> Fix it by making dma_alloc_coherent use EPC's device for allocating
>> memory address as per discussion in [1]
>>
>> [1] https://lkml.org/lkml/2017/10/24/26
> 
> Hi Kishon,
> 
> small nit, mind embedding the link [1] above in a lkml redirector
> format - as described in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v4.15-rc7
> 
> put it in a Link: tag to be added below - I think that's important
> for the commit log to have.
> 
> Either send me the formatted link or send a v3 with it, I will merge
> then.

sure, sent you a v3.

Thanks
Kishon
