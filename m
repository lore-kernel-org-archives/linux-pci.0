Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C12C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 16:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7120879
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 16:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D7120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLMQqT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:46:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57206 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbeLMQqS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 11:46:18 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gXU7s-0006IZ-KR; Thu, 13 Dec 2018 09:46:17 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
 <20181213151756.GD4701@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9f81d636-95da-af77-0a7c-0ad439c0a866@deltatee.com>
Date:   Thu, 13 Dec 2018 09:46:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181213151756.GD4701@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/5] switchtec: MRPC DMA mode implementation
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-13 8:17 a.m., Bjorn Helgaas wrote:
>>  static void init_pff(struct switchtec_dev *stdev)
>> @@ -1294,6 +1367,19 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
>>  
>>  	pci_set_drvdata(pdev, stdev);
>>  
>> +	if (!use_dma_mrpc)
>> +		return 0;
>> +
>> +	if (!(ioread32(&stdev->mmio_mrpc->dma_ver) ? true : false))
>> +		return 0;
> 
> This is ... harder to decode than necessary.  It's obvious that the
> intent is to return if the adapter firmware doesn't support DMA, but I
> lost interest before I could verify that it works as intended.

Oh, ick, yes. I must have missed that in my review.

@Wesley, that would definitely be something worth cleaning up. That
ternary operator doesn't make any sense.

Thanks, Bjorn, for the review and picking up the series.

Logan
