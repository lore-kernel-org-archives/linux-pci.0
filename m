Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595AC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 09:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1806206C0
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 09:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LCc2Untk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfABJht (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:37:49 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48640 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfABJht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 04:37:49 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AD18710C1189;
        Wed,  2 Jan 2019 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546421869; bh=2qNiGqzha50XcWrAprcnnSRTovjLYD7B/givc4nhFQ0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=LCc2UntkIjecTdVEhB3sxa7jrWCvQr+7aDZDMTQSxLKko0zV/W9nTpjeynJupC2pn
         tw1GOY18Yph3wPgJyebA68D9LKlsLweNMFZmS+GVjFs2NX4HBvYSlUAWXkMtbWJ8Tv
         dmdPv6JT+1UJ5cFAfdTDZu8tVexoPh5AoXjPIR8kptke/cc7xEgPZVGR9unUGs6IlH
         DI+9bW6yr5+LdefO02ymXPCCuSPFwqveOsdqdWc5KLNiRsnMUexNSkwkLioAvjyyHR
         ttA1X9l779ZyFMr9dlGAizRbWfpu8qtSVj9Ob24P6mXISiyiA6Ejf9tyTt0Uqqf1I+
         B3JPuAvjFn4dA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1300637AC;
        Wed,  2 Jan 2019 01:37:47 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 01:37:46 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 10:37:44 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 10:37:44 +0100
Subject: Re: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-8-andrew.smirnov@gmail.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
Date:   Wed, 2 Jan 2019 09:33:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-8-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 21/12/2018 07:27, Andrey Smirnov wrote:
> Make the intent a bit more clear as well as get rid of explicit
> arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
> "size". No functional change intended.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 93ef8c31fb39..67236379c61a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -22,7 +22,7 @@
>  
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  {
> -	if ((uintptr_t)addr & (size - 1)) {
> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>  		*val = 0;
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	}
> @@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  
>  int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  {
> -	if ((uintptr_t)addr & (size - 1))
> +	if (!IS_ALIGNED((uintptr_t)addr, size))
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (size == 4)
> 

Sounds good.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

