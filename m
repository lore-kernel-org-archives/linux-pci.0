Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E83C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F0A20851
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F0A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLLW60 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:58:26 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51268 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLW6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 17:58:25 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gXDSS-0001Bc-2q; Wed, 12 Dec 2018 15:58:25 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
 <20181212225201.GL99796@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b96a3667-de25-9e51-bbdb-406cc4b879f3@deltatee.com>
Date:   Wed, 12 Dec 2018 15:58:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181212225201.GL99796@google.com>
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



On 2018-12-12 3:52 p.m., Bjorn Helgaas wrote:
> On Mon, Dec 10, 2018 at 05:12:24PM +0800, Wesley Sheng wrote:
>> MRPC normal mode requires the host to read the MRPC command status and
>> output data from BAR. This results in high latency responses from the
>> Memory Read TLP and potential Completion Timeout (CTO).
>>
>> MRPC DMA mode implementation includes:
>> Macro definitions for registers and data structures corresponding to
>> MRPC DMA mode.
>>
>> Add module parameter use_dma_mrpc to select between MRPC DMA mode and
>> MRPC normal mode.
>>
>> Add MRPC mode functionality to:
>> * Retrieve MRPC DMA mode version
>> * Allocate DMA buffer, ISR registration, and enable DMA function during
>>   initialization
>> * Check MRPC execution status and collect execution results from DMA buffer
>> * Release DMA buffer and disable DMA function when unloading module
>>
>> MRPC DMA mode is a new feature of firmware and the driver will fall back
>> to MRPC normal mode if there is no support in the legacy firmware.
>>
>> Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq is replaced
>> by two readl/writel on systems that do not support it.
>>
>> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/switch/switchtec.c | 108 +++++++++++++++++++++++++++++++++++++----
>>  include/linux/switchtec.h      |  16 ++++++
>>  2 files changed, 114 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 0b8862b..6b726cb 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -13,7 +13,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/poll.h>
>>  #include <linux/wait.h>
>> -
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>  #include <linux/nospec.h>
>>  
>>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
>> @@ -25,6 +25,11 @@ static int max_devices = 16;
>>  module_param(max_devices, int, 0644);
>>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
>>  
>> +static bool use_dma_mrpc = 1;
>> +module_param(use_dma_mrpc, bool, 0644);
>> +MODULE_PARM_DESC(use_dma_mrpc,
>> +		 "Enable the use of the DMA MRPC feature");
> 
> What's the purpose of the module parameter?  Can't you automatically
> figure out whether the firmware supports DMA mode?
> 
> Module parameters make life difficult for users and lead to code
> that's rarely used and poorly tested, so I think we should avoid them
> whenever we can.
> 
> If you *can't* automatically figure out when to use DMA, please make
> it clear in the changelog that the "use_dma_mrpc" parameter is
> required with legacy firmware.  And in that case, it seems like it
> should be named "disable_dma" or similar, since it defaults to being
> enabled.

The code should already automatically determine whether the firmware
supports DMA or not. This parameter is just to aid debugging/testing so
we can run the module without DMA even if the firmware indicates it has
support.

It's not that critical so I'm sure we can remove it at this point if you
don't think that's a good enough justification.

Logan
