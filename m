Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B466C43334
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jun 2022 16:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiF2QWo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiF2QWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:22:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2D35841;
        Wed, 29 Jun 2022 09:22:43 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY68Z5ZBRz67ZTj;
        Thu, 30 Jun 2022 00:18:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:22:41 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:22:40 +0100
Date:   Wed, 29 Jun 2022 17:22:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 24/46] tools/testing/cxl: Fix decoder default state
Message-ID: <20220629172239.00002671@Huawei.com>
In-Reply-To: <165603888091.551046.6312322707378021172.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603888091.551046.6312322707378021172.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:48:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The 'enabled' state is reserved for committed decoders. By default,
> cxl_test decoders are uncommitted at init time.
> 
> Fixes: 7c7d68db0254 ("tools/testing/cxl: Enumerate mock decoders")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Whilst sanity checking this I notcie we have
CXL_DECODER_F_MASK but never use it. Might be worth dropping...

For this

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index c396f20a57dd..51d517fa62ee 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -479,7 +479,6 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			.end = -1,
>  		};
>  
> -		cxld->flags = CXL_DECODER_F_ENABLE;
>  		cxld->interleave_ways = min_not_zero(target_count, 1);
>  		cxld->interleave_granularity = SZ_4K;
>  		cxld->target_type = CXL_DECODER_EXPANDER;
> 

