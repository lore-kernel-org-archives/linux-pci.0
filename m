Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F2C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A4C21479
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 15:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfDRPuE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:50:04 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35230 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388450AbfDRPuD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 11:50:03 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.229])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hH9IX-0002Vq-CL; Thu, 18 Apr 2019 09:50:02 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
 <1555339302-31829-2-git-send-email-wesley.sheng@microchip.com>
 <20190417224858.GW126710@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3318670-f7f4-5f2e-751a-e028d4caf0b9@deltatee.com>
Date:   Thu, 18 Apr 2019 09:49:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417224858.GW126710@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/2] switchtec: Fix false maximum supported PCIe
 function number issue
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-17 4:48 p.m., Bjorn Helgaas wrote:
>> ---
>>   drivers/pci/switch/switchtec.c       | 39 +++++++++++++++++++++++++-----------
>>   include/linux/switchtec.h            |  2 +-
>>   include/uapi/linux/switchtec_ioctl.h | 13 +++++++++++-
>>   3 files changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index e22766c..7df9a69 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -658,19 +658,25 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
>>   
>>   static int ioctl_event_summary(struct switchtec_dev *stdev,
>>   	struct switchtec_user *stuser,
>> -	struct switchtec_ioctl_event_summary __user *usum)
>> +	struct switchtec_ioctl_event_summary __user *usum,
>> +	size_t size)
>>   {
>> -	struct switchtec_ioctl_event_summary s = {0};
>> +	struct switchtec_ioctl_event_summary *s;
>>   	int i;
>>   	u32 reg;
>> +	int ret = 0;
>>   
>> -	s.global = ioread32(&stdev->mmio_sw_event->global_summary);
>> -	s.part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
>> -	s.local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
>> +	s = kzalloc(sizeof(*s), GFP_KERNEL);
>> +	if (!s)
>> +		return -ENOMEM;
>> +
>> +	s->global = ioread32(&stdev->mmio_sw_event->global_summary);
>> +	s->part_bitmap = ioread32(&stdev->mmio_sw_event->part_event_bitmap);
>> +	s->local_part = ioread32(&stdev->mmio_part_cfg->part_event_summary);
>>   
>>   	for (i = 0; i < stdev->partition_count; i++) {
>>   		reg = ioread32(&stdev->mmio_part_cfg_all[i].part_event_summary);
>> -		s.part[i] = reg;
>> +		s->part[i] = reg;
>>   	}
>>   
>>   	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
> 
> Should this be "i < stdev->pff_csr_count", as in
> check_link_state_events(), enable_link_state_events() and
> mask_all_events()?  If so, I assume the read and check of vendor_id
> would be unnecessary?

Yes, nice catch. I think that would be a good simplification.

> The last loop in init_pff() currently checks against
> SWITCHTEC_MAX_PFF_CSR:
> 
>          for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
>                  reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
>                  if (reg < SWITCHTEC_MAX_PFF_CSR)
>                          stdev->pff_local[reg] = 1;
>          }
> 
> Should it check "reg < stdev->pff_csr_count" instead?  It looks like
> mask_all_events(), the only reader of pff_local[], only looks up to
> pff_csr_count anyway.

Yeah, I could go either way. The hardware would have to be broken if reg 
was between pff_csr_count and SWITCHTEC_MAX_PFF_CSR. This is mostly to 
catch 0xFF which indicates it's unset (if I recall correctly).

Logan

