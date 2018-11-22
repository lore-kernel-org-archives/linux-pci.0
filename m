Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C313C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C5020818
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C5020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406080AbeKWDfK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:35:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42624 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404133AbeKWDfJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 22:35:09 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gPsFe-000490-79; Thu, 22 Nov 2018 09:54:51 -0700
To:     Wesley Sheng <wesley.sheng@microchip.com>,
        kurt.schwemmer@microsemi.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     wesleyshenggit@sina.com
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a386850a-6fe9-9cd6-72dd-c00e09405d51@deltatee.com>
Date:   Thu, 22 Nov 2018 09:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/3] ntb_hw_switchtec: Added support of >=4G memory
 windows
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey,

This entire series looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

On 2018-11-22 2:01 a.m., Wesley Sheng wrote:
> Hi, Everyone,
> 
> This patch series adds support of >=4G memory windows.
> 
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
> 
> Additionally, we've made the following changes:
> 
> * debug print 64bit aligned crosslink BAR numbers
> * Fix the array size of NT req id mapping table
> 
> Tested with ntb_test.sh successfully based on NTB fixes series from
> Logan Gunthorpe <logang@deltatee.com> at 
> https://github.com/sbates130272/linux-p2pmem on branch of
> ntb_multiport_fixes
> 
> Regards,
> Wesley
> 
> 
> 
> Paul Selles (2):
>   ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
>   ntb_hw_switchtec: Added support of >=4G memory windows
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: NT req id mapping table register entry number should
>     be 512
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
>  include/linux/switchtec.h              | 10 +++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
