Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130E6C43143
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8F52073F
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 20:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8F52073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeI2DFE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:05:04 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:38330 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2DFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 23:05:04 -0400
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 4F6EB1C0160;
        Fri, 28 Sep 2018 14:39:37 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.1 at avon.wwwdotorg.org
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
From:   Stephen Warren <swarren@wwwdotorg.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
 <a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
 <52dc4d4b-b521-17a5-dc93-e2992e481083@wwwdotorg.org>
Message-ID: <4dc0ffa8-7b16-9063-2aba-b8249a09885f@wwwdotorg.org>
Date:   Fri, 28 Sep 2018 14:39:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52dc4d4b-b521-17a5-dc93-e2992e481083@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/18/2018 12:16 PM, Stephen Warren wrote:
> On 09/18/2018 04:59 AM, Robin Murphy wrote:
>> Hi Stephen,
>>
>> On 17/09/18 22:36, Stephen Warren wrote:
>>> Joerg, Christoph, Marek, Robin,
>>>
>>> I believe that the driver for our PCIe endpoint controller hardware 
>>> will need to explicitly manage its IOVA space more than current APIs 
>>> allow. I'd like to discuss how to make that possible.
...
>>> Does this API proposal sound reasonable?
>>
>> Indeed, as I say apart from using streaming DMA for coherency 
>> management (which I think could be added in pretty much orthogonally 
>> later), this sounds like something you could plumb into the endpoint 
>> framework right now with no dependent changes elsewhere.
> 
> Great. I'll take a look at Oza's code and see about getting this 
> implemented.

I took a longer look at the various APIs in iommu.h and dma-iommh.h. As 
you said, I think most of it is already there. I think we just need to 
add functions iommu_dma_alloc/free_iova() [1] that drivers can call to 
acquire an IOVA range that is guaranteed not be used by any other device 
that shares the same IOVA domain (i.e. IOMMU ASID). After the driver 
calls that, it can just use iommu_map() and iommu_map_sg() on the IOVA 
range that was reserved. Does that sound reasonable?

[1] there's already a static function of that name for internal use in 
dma-iommu.c. I guess I'd rename that to __iommu_dma_alloc_iova() and 
have the new function be a thin wrapper on top of it.
