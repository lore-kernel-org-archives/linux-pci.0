Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEFC43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D9821470
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 15:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D9821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJXVG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:21:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50722 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJXVG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Oct 2018 19:21:06 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAGsJ-0000cA-MT; Wed, 10 Oct 2018 09:58:16 -0600
To:     Wesley Sheng <wesley.sheng@microchip.com>, bhelgaas@google.com,
        corbet@lwn.net, kurt.schwemmer@microsemi.com
Cc:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>
References: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7da3c288-0174-b8c7-21a7-2ff3fb3f504b@deltatee.com>
Date:   Wed, 10 Oct 2018 09:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, wesley.yung@microchip.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kurt.schwemmer@microsemi.com, corbet@lwn.net, bhelgaas@google.com, wesley.sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-10 8:42 a.m., Wesley Sheng wrote:
> From: Wesley Yung <wesley.yung@microchip.com>
> 
> The ntb_hw_switchtec driver has requirements on kernel configuration
> so we add these notes to the documentation and also clean up a few 
> other sentences in the documentation.
> 
> Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
