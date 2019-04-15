Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332EAC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7F20880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfDOPvi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:51:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33136 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOPvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 11:51:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hG3tP-0004hA-CP; Mon, 15 Apr 2019 09:51:36 -0600
To:     Wesley Sheng <wesley.sheng@microchip.com>,
        kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wesleyshenggit@sina.com
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ac314aa2-951b-58c7-cfd6-65e53b5b5f1e@deltatee.com>
Date:   Mon, 15 Apr 2019 09:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 0/2] Fix two bugs of switchtec module
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019-04-15 8:41 a.m., Wesley Sheng wrote:
> Hi, Everyone,
> 
> This patch series fix two bugs of switchtec module.
> 
> The first is introduced by device spec definition issue: the maximum
> supported PCIe function number by hardware should be 255 instead of 
> the false number of 48. Rectify it in driver and for backward 
> compatible, a new ioctl and corresponding data structure are created,
> while keep the deprecated one.
> 
> The second is MRPC event unintentionally masked at corner case.
> Fix this bug by skipping the mask operation for MRPC event in event ISR
> like what we already do for LINK event.
> 
> Regard,
> Wesley
> 
> --
> 
> Changed since v1:
>   - rewrapped the commit message of [PATCH 1/2] into one paragraph

Probably should have collected my Reviewed-by tag into the patches as
well. I still approve this series:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
