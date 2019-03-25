Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E832DC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B1920989
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfCYPth (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:49:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34054 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbfCYPtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 11:49:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h8Rqv-00035p-VR; Mon, 25 Mar 2019 09:49:34 -0600
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Kelvin Cao <kelvin.cao@microsemi.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
References: <20190325091726.GD16023@kadam>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e2bc8cf0-8e3e-9335-e21b-4a9697e9c0ef@deltatee.com>
Date:   Mon, 25 Mar 2019 09:49:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325091726.GD16023@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kernel-janitors@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, kelvin.cao@microsemi.com, kurt.schwemmer@microsemi.com, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ntb_hw_switchtec: potential shift wrapping bug in
 switchtec_ntb_init_sndev()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks!

On 2019-03-25 3:17 a.m., Dan Carpenter wrote:
> This code triggers a Smatch warning:
> 
>     drivers/ntb/hw/mscc/ntb_hw_switchtec.c:884 switchtec_ntb_init_sndev()
>     warn: should '(1 << sndev->peer_partition)' be a 64 bit type?
> 
> The "part_map" and "tpart_vec" variables are u64 type so this seems like
> a valid warning.
> 
> Fixes: 3df54c870f52 ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

