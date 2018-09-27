Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F460C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666CF21582
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666CF21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeI0Wig (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:38:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58006 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeI0Wig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 18:38:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g5Z0m-0003OM-A3; Thu, 27 Sep 2018 10:19:33 -0600
To:     Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        Kurt.Schwemmer@microchip.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelvin.Cao@microchip.com
References: <DM2PR11MB0105CD1B3A264290413ED1CA95140@DM2PR11MB0105.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f640f7a1-946f-c1b2-56aa-a4ee0bad67b4@deltatee.com>
Date:   Thu, 27 Sep 2018 10:19:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105CD1B3A264290413ED1CA95140@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Kelvin.Cao@microchip.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kurt.Schwemmer@microchip.com, kurt.schwemmer@microsemi.com, Wesley.Sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/12 v2] switchtec: Remove immediate status check after
 submit a MRPC command
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Wesley, I'm going to suggest you send patches to me before sending them
to the community until you have a better handle of the tools and
process. The subject suggests you have 11 other patches in this series
so you've mishandled the tools.

On 2018-09-26 11:57 p.m., Wesley.Sheng@microchip.com wrote:
> After submit a Firmware Download (Download sub-command) MRPC
> command, Switchtec firmware refuses to response any management 
> EP's BAR access until current flash programming finished.
> During this time, a READ TLP to the gas area in the BAR of the
> management EP will complete with significant delay like more than 
> 10ms.
> It's a Switchtec firmware limitation that READ requests cannot get
> prompt service during firmware download.
> The delayed completion of READ TLP would be a problem on some system
>  which is sensitive to READ timeout.
> Current driver check status immediately after submit a MRPC command,
> which triggers READ TLP to the gas area in the BAR of the management EP.
> Also, other processes or functions, like NTB, would also trigger READ TLP by
> accessing the GAS.
> To avoid this, the immediate check of status is removed in this patch, and
> driver delays the status check to the occurrence of MSIx or MRPC timeout.
> In the meantime, user must not initiate any gas access during a firmware
> download.
> Also, any process that issues MRPC command will be affected by the delay
> in this patch.
> However, this is only a software workaround to the READ issue in firmware
> download. A complete fix of this should happen in firmware.
> 
> Note: For NTB function, the memory window access is handled by Switchtec
> hardware. So it's not affected by this firmware limitation. But the other GAS
> access which is handled by Switchtec firmware is are affected by this firmware
> limitation.

The commit message is poorly formatted/wrapped and with all due respect,
I think the grammar needs a lot of work.

> ---
>  drivers/pci/switch/switchtec.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c index 4591f15..b759228 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -142,10 +142,6 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
>  		    stuser->data, stuser->data_len);
>  	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
>  
> -	stuser->status = ioread32(&stdev->mmio_mrpc->status);
> -	if (stuser->status != SWITCHTEC_MRPC_STATUS_INPROGRESS)
> -		mrpc_complete_cmd(stdev);
> -
>  	schedule_delayed_work(&stdev->mrpc_timeout,
>  			      msecs_to_jiffies(500));
>  }

The change itself looks good.

Logan
