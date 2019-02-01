Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B48C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFD120844
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfBAJOy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:14:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfBAJOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 04:14:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 558F7E56BC4368A1FF86;
        Fri,  1 Feb 2019 17:14:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 17:14:40 +0800
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
From:   Hanjun Guo <guohanjun@huawei.com>
To:     John Garry <john.garry@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <anthony.jebson@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
 <f9a8ab1f-d560-0fb6-dfc9-61be3c1a2d82@huawei.com>
 <ce031291-3050-3817-0ed9-9d83dad0cc55@huawei.com>
Message-ID: <e47d89e3-9bb0-95b0-db63-717594b1692b@huawei.com>
Date:   Fri, 1 Feb 2019 17:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ce031291-3050-3817-0ed9-9d83dad0cc55@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/2/1 13:55, Hanjun Guo wrote:
> Hi John,
> 
> On 2019/1/31 17:54, John Garry wrote:
>> On 30/01/2019 07:01, Hanjun Guo wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
> [...]
>>>
>>>  drivers/usb/core/hcd-pci.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>>> index 0343246..a9c33e6 100644
>>> --- a/drivers/usb/core/hcd-pci.c
>>> +++ b/drivers/usb/core/hcd-pci.c
>>> @@ -188,6 +188,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>      if (pci_enable_device(dev) < 0)
>>>          return -ENODEV;
>>>
>>> +    retval = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
>>> +    if (retval)
>>> +        return retval;
>>
>> Hi Hanjun,
>>
>> You're missing tidy-up upon failure.
> 
> Good catch, needs to disable pci for failure, I will send
> a updated version to address the comments from you and Christoph.

There is a _DMA method which was introduced in ACPI 6.2 to cover
this, I will try that solution then report back.

Thanks
Hanjun


