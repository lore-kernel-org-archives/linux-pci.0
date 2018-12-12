Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A32C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE4620851
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE4620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLLWwy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:52:54 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51194 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLLWwy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 17:52:54 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gXDN4-00018k-BX; Wed, 12 Dec 2018 15:52:51 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-4-git-send-email-wesley.sheng@microchip.com>
 <20181212224315.GK99796@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0e8da614-dd78-5e41-df25-ec1b037ef4d7@deltatee.com>
Date:   Wed, 12 Dec 2018 15:52:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181212224315.GK99796@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/5] switchtec: A temporary variable should be used for
 the flags of switchtec_ioctl_event_ctl
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-12 3:43 p.m., Bjorn Helgaas wrote:
> On Mon, Dec 10, 2018 at 05:12:22PM +0800, Wesley Sheng wrote:
>> From: Joey Zhang <joey.zhang@microchip.com>
>>
>> For nr_idxs is larger than 1 switchtec_ioctl_event_ctl event flags will be
>> used by each event indexes. In current implementation the event flags are
>> overwritten by first call of the function event_ctl().
>>
>> Preserve the event flag value with a temporary variable.
>>
>> Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
>> Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
>> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/switch/switchtec.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 480107e..a908670 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -796,6 +796,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>>  {
>>  	int ret;
>>  	int nr_idxs;
>> +	unsigned int event_flags;
>>  	struct switchtec_ioctl_event_ctl ctl;
>>  
>>  	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
>> @@ -817,7 +818,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>>  		else
>>  			return -EINVAL;
>>  
>> +		event_flags = ctl.flags;
>>  		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
>> +			ctl.flags = event_flags;
>>  			ret = event_ctl(stdev, &ctl);
> 
> event_ctl() overwrites several other things, in addition to ctl.flags:
> 
>   ctl.data[]
>   ctl.occurred
>   ctl.count
> 
> Is that what you intend?  It looks like only the values from the *last*
> call of event_ctl() will be copied back to the user buffer.

Yeah, it's just SWITCHTEC_IOCTL_EVENT_IDX_ALL is perhaps a strange abuse
of the interface. The intention being that if you are querying
information about an event you'd use it's specific index. If you are
trying to set flags you can set them for all event of a specific type at
once using IDX_ALL.

Looking at it now it looks pretty ugly (and I'm not sure what I was
thinking when I wrote it). But it's what we have and this patch fixes a
bug where we aren't actually enabling/disabling all events when that's
what the user is asking for.

Logan
