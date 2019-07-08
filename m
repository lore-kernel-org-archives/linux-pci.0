Return-Path: <SRS0=RvOS=VF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F4DC606BD
	for <linux-pci@archiver.kernel.org>; Mon,  8 Jul 2019 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F0621537
	for <linux-pci@archiver.kernel.org>; Mon,  8 Jul 2019 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfGHQSP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:18:15 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60112 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfGHQSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jul 2019 12:18:14 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hkWLE-0001Ld-OO; Mon, 08 Jul 2019 10:18:13 -0600
To:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     linux@yadro.com
References: <20190708155717.wh4vweidewab4dpz@yadro.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a9344325-4d43-ff3c-37ca-ecd948cce41f@deltatee.com>
Date:   Mon, 8 Jul 2019 10:18:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708155717.wh4vweidewab4dpz@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux@yadro.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, fomichev.ru@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning error
 if size == 0
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-07-08 9:57 a.m., Alexander Fomichev wrote:
> ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> addr == 0. But error in xlate_pos checking condition prevents this.
> Fix the condition to make ntb_mw_clear_trans working.

Nice catch, but you'll need to resubmit the patch with a Signed-off-by
line. Please see [1].

When you do, you can also add:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan

[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin


> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 1e2f627d3bac..19d46af19650 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
>  		return -EINVAL;
>  
> -	if (xlate_pos < 12)
> +	if (size != 0 && xlate_pos < 12)
>  		return -EINVAL;
>  
>  	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> 
