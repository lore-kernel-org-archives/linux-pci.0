Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C1BC10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E9D20879
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfDHQAM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:00:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54448 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHQAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 12:00:12 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hDWgr-00086V-Nm; Mon, 08 Apr 2019 10:00:10 -0600
To:     Wesley Sheng <wesley.sheng@microchip.com>,
        kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wesleyshenggit@sina.com, kelvin.cao@microchip.com
References: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8f1962b8-3e6b-0729-dc29-043bb13cebf9@deltatee.com>
Date:   Mon, 8 Apr 2019 10:00:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, wesleyshenggit@sina.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kurt.schwemmer@microsemi.com, wesley.sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/2] Fix two bugs of switchtec module
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-08 8:34 a.m., Wesley Sheng wrote:
> Wesley Sheng (2):
>   switchtec: Fix false maximum supported PCIe function number issue
>   switchtec: Fix unintended mask of MRPC event

This series looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
