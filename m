Return-Path: <SRS0=pntK=W6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6FCC3A5A2
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC382343A
	for <linux-pci@archiver.kernel.org>; Tue,  3 Sep 2019 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfICPvJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:51:09 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60760 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfICPvJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 11:51:09 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i5B5H-0006fG-8O; Tue, 03 Sep 2019 09:51:08 -0600
To:     Christoph Hellwig <hch@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190831124932.18759-1-yuehaibing@huawei.com>
 <20190902075006.GB754@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9d2094f7-eb71-4975-eb9b-166a1483afa0@deltatee.com>
Date:   Tue, 3 Sep 2019 09:51:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902075006.GB754@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, yuehaibing@huawei.com, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH -next] PCI: Use GFP_ATOMIC in resource_alignment_store()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-09-02 1:50 a.m., Christoph Hellwig wrote:
> On Sat, Aug 31, 2019 at 12:49:32PM +0000, YueHaibing wrote:
>> When allocating memory, the GFP_KERNEL cannot be used during the
>> spin_lock period. It may cause scheduling when holding spin_lock.
>>
>> Fixes: f13755318675 ("PCI: Move pci_[get|set]_resource_alignment_param() into their callers")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pci/pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 484e35349565..0b5fc6736f3f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6148,7 +6148,7 @@ static ssize_t resource_alignment_store(struct bus_type *bus,
>>  	spin_lock(&resource_alignment_lock);
>>  
>>  	kfree(resource_alignment_param);
>> -	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
>> +	resource_alignment_param = kstrndup(buf, count, GFP_ATOMIC);
>>  
>>  	spin_unlock(&resource_alignment_lock);
> 
> Why not move the allocation outside the lock? Something like this
> seems much more sensible:

Yes, that seems like a good way to do it. Bjorn, can you squash
Christoph's patch or do you want me to resend a new one?

Thanks,

Logan

> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 484e35349565..fe205829f676 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6145,14 +6145,16 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  static ssize_t resource_alignment_store(struct bus_type *bus,
>  					const char *buf, size_t count)
>  {
> -	spin_lock(&resource_alignment_lock);
> +	char *param = kstrndup(buf, count, GFP_KERNEL);
>  
> -	kfree(resource_alignment_param);
> -	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
> +	if (!param)
> +		return -ENOMEM;
>  
> +	spin_lock(&resource_alignment_lock);
> +	kfree(resource_alignment_param);
> +	resource_alignment_param = param;
>  	spin_unlock(&resource_alignment_lock);
> -
> -	return resource_alignment_param ? count : -ENOMEM;
> +	return count;
>  }
>  
>  static BUS_ATTR_RW(resource_alignment);
> 
