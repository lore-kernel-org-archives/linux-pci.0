Return-Path: <SRS0=jwu3=TX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFAC282DD
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8417921773
	for <linux-pci@archiver.kernel.org>; Thu, 23 May 2019 16:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfEWQOu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 May 2019 12:14:50 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50298 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfEWQOt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 12:14:49 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hTqMi-0007x2-IG; Thu, 23 May 2019 10:14:49 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1d132344-5649-f910-f155-346d6af2aee6@deltatee.com>
Date:   Thu, 23 May 2019 10:14:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-05-23 3:48 a.m., Koenig, Christian wrote:
> Am 23.05.19 um 11:43 schrieb Christoph Hellwig:
>> [CAUTION: External Email]
>>
>> On Thu, May 23, 2019 at 08:12:18AM +0000, Koenig, Christian wrote:
>>>> Are you DMA-mapping the addresses outside the P2PDMA code? If so there's
>>>> a huge mismatch with the existing users of P2PDMA (nvme-fabrics). If
>>>> you're not dma-mapping then I can't see how it could work because the
>>>> IOMMU should reject any requests to access those addresses.
>>> Well, we are using the DMA API (dma_map_resource) for this. If the P2P
>>> code is not using this then I would rather say that the P2P code is
>>> actually broken.
>>>
>>> Adding Christoph as well, cause he is usually the one discussion stuff
>>> like that with me.
>> Heh.  Actually dma_map_resource-ish APIs are the right thing to do,
>> but I'm not sure how you managed to be able to use it for PCIe P2P
>> yet, as it fails to account for any difference in the PCIe level
>> "physical" address with the hosts view of "physical" addresses.
>>
>> Do these offsets now how up on AMD platforms?  Do you adjust for them
>> elsewhere?
> 
> I don't adjust the address manually anywhere. I just call 
> dma_map_resource() and use the resulting DMA address to access the other 
> devices PCI BAR.
> 
> At least on my test system (AMD CPU + AMD GPUs) this seems to work 
> totally fine. Currently trying to find time and an Intel box to test it 
> there as well.

I'm sure this will work fine in all cases (assuming the RC/IOMMU
supports P2P). It's just you're breaking the existing p2pdma users which
currently work by avoiding the IOMMU and use the pci_bus_address() instead.

Logan
