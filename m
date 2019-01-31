Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D85FC282D7
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 01:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6DC218D9
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 01:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAaBVD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:21:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfAaBVC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 20:21:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 861B6D3390F1A4A550F3;
        Thu, 31 Jan 2019 09:21:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 09:20:50 +0800
Subject: Re: [RFC PATCH] USB: PCI: set 32bit DMA mask for PCI based USB
 controllers
To:     Christoph Hellwig <hch@lst.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <anthony.jebson@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>
References: <1548831714-3706-1-git-send-email-guohanjun@huawei.com>
 <20190130074059.GA29458@lst.de>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b42f939d-8946-4865-59d8-7451d7d753bd@huawei.com>
Date:   Thu, 31 Jan 2019 09:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190130074059.GA29458@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 2019/1/30 15:40, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 03:01:54PM +0800, Hanjun Guo wrote:
>> This is the RFC version, I'm not sure this is the best solution,
>> comments are warmly welcomed.
>>
>> Thanks
>> Hanjun
>>
>>  drivers/usb/core/hcd-pci.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>> index 0343246..a9c33e6 100644
>> --- a/drivers/usb/core/hcd-pci.c
>> +++ b/drivers/usb/core/hcd-pci.c
>> @@ -188,6 +188,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>  	if (pci_enable_device(dev) < 0)
>>  		return -ENODEV;
>>  
>> +	retval = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
>> +	if (retval)
>> +		return retval;
> 
> dma_coerce_mask_and_coherent is only for platform devices (and I'm
> not sure it is a good idea to start with, but that is a different
> story).

Yes, that's why this is the RFC version.

> 
> PCI device should have the dma_mask pointer set already, so you should
> use dma_set_mask_and_coherent here.

I will wait for a while to see if more comments, if not, I will update
my patch as you suggested.

Thanks
Hanjun


