Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41897C10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3A920857
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDHQAv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:00:51 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54470 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfDHQAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 12:00:51 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hDWhT-000875-4x; Mon, 08 Apr 2019 10:00:47 -0600
To:     Wesley Sheng <wesley.sheng@microchip.com>,
        kurt.schwemmer@microsemi.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     wesleyshenggit@sina.com, kelvin.cao@microchip.com
References: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <921720bb-4e56-0c19-a29c-565d2fa85185@deltatee.com>
Date:   Mon, 8 Apr 2019 10:00:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/3] Redundant steps removal and bug fix of
 ntb_hw_switchtec
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-08 8:45 a.m., Wesley Sheng wrote:
> Joey Zhang (2):
>   ntb_hw_switchtec: Remove redundant steps of
>     switchtec_ntb_reinit_peer() function
>   ntb_hw_switchtec: Fix setup MW with failure bug
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
>     for crosslink case

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
