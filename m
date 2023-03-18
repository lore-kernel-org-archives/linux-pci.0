Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B47C61DA4
	for <linux-pci@archiver.kernel.org>; Sat, 18 Mar 2023 03:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCRDZM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 Mar 2023 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCRDZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 23:25:11 -0400
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 20:25:09 PDT
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45DF2CC57
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 20:25:09 -0700 (PDT)
Message-ID: <ef8c77ef-c29a-0a5e-0ba2-33fbd6039700@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679109373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3PQbVF04lrfgGSiNQGfDV6uA+9yDI7AUIZjSe2pcLw=;
        b=kdm6rXsttf/2otkUE2bmfXfOfABjvA2YXUDGrSTlFl+CVB3ZQOG4RplBheFGdg4PA33eJ5
        JYvgZHEEwkhmgtLEf3JFYb1oaCoHDjho1OprJI/csf+Ar4kF0x4FDBLwV9ivNDfunryN9+
        nCVtuPZW8onUWRxPggEnGsXe+V9ue94=
Date:   Fri, 17 Mar 2023 21:15:40 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Reset VMD config register between soft reboots
Content-Language: en-US
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
References: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
 <8b5e6130-13c2-8142-6e70-075ba735fe60@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <8b5e6130-13c2-8142-6e70-075ba735fe60@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/23 3:51 PM, Patel, Nirmal wrote:
> On 2/24/2023 1:28 PM, Nirmal Patel wrote:
>> VMD driver can disable or enable MSI remapping by changing
>> VMCONFIG_MSI_REMAP register. This register needs to be set to the
>> default value during soft reboots. Drives failed to enumerate
>> when Windows boots after performing a soft reboot from Linux.
>> Windows doesn't support MSI remapping disable feature and stale
>> register value hinders Windows VMD driver initialization process.
>> Adding vmd_shutdown function to make sure to set the VMCONFIG
>> register to the default value.
>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
>> ---
>>   drivers/pci/controller/vmd.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 769eedeb8802..50a187a29a1d 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -979,6 +979,13 @@ static void vmd_remove(struct pci_dev *dev)
>>   	ida_simple_remove(&vmd_instance_ida, vmd->instance);
>>   }
>>   
>> +static void vmd_shutdown(struct pci_dev *dev)
>> +{
>> +        struct vmd_dev *vmd = pci_get_drvdata(dev);
>> +
>> +        vmd_remove_irq_domain(vmd);
>> +}
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   static int vmd_suspend(struct device *dev)
>>   {
>> @@ -1056,6 +1063,7 @@ static struct pci_driver vmd_drv = {
>>   	.id_table	= vmd_ids,
>>   	.probe		= vmd_probe,
>>   	.remove		= vmd_remove,
>> +	.shutdown	= vmd_shutdown,
>>   	.driver		= {
>>   		.pm	= &vmd_dev_pm_ops,
>>   	},
> 
> Gentle ping.
> 
> Thanks
> 

LGTM
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
