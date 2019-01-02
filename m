Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CFC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9398218E2
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Areo76/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfABSgT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:36:19 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:54398 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 13:36:18 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4D89D24E0EA3;
        Wed,  2 Jan 2019 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546454178; bh=QZ1F5Bc2hwQdWvFOj5M8RYiUnujm9yVhM6A5Xc0RMr8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Areo76/dBuaCYgF7pNjh90m+Z6YWpadZ90vPKQT1pPJ5CR4qeTAh43b9EuYgIrPKM
         nMPxHe41qSGIDkap822H+ktNTTwvguc6cmpEIk89lfvQt05TXrMK1dwCXrhFPTpJAw
         iOFc8eR34mc0b8B6rbNyFHxWZSyzvXKqAmFg++oNK3wPE7ShMI7fgo1swC+jm8egFR
         2semBzzbBA1ro0x81GM3Dpat/kFXe/YRkUSDq1ARFsi8sRoRpg5Km3ONpeIk6sM2vn
         ghB5SzeqIdwsktfIaKeWawaC3k8U2YLduJVNKtG8Ckw3C9YWjXBxFnp9E+rqWCxDg+
         1MOH1hbYbsbVQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2D3B631CD;
        Wed,  2 Jan 2019 10:36:18 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 10:36:16 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 19:36:14 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 19:36:14 +0100
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant
 definitions
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        "Lucas Stach" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-12-andrew.smirnov@gmail.com>
 <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
 <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <0fd12beb-1e53-4596-a261-9870452a6c19@synopsys.com>
Date:   Wed, 2 Jan 2019 18:31:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 02/01/2019 18:28, Andrey Smirnov wrote:
> On Wed, Dec 26, 2018 at 7:19 AM Gustavo Pimentel
> <gustavo.pimentel@synopsys.com> wrote:
>>
>> Hi,
>>
>> On 21/12/2018 07:27, Andrey Smirnov wrote:
>>> Avoid using explicit left shifts and convert various definitions to
>>> use BIT() instead. No functional change intended.
>>>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>>> Cc: Chris Healy <cphealy@gmail.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Leonard Crestez <leonard.crestez@nxp.com>
>>> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
>>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>>> Cc: linux-imx@nxp.com
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-pci@vger.kernel.org
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-designware.c |  2 +-
>>>  drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index d123ac290b9e..086e87a40316 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>>>       }
>>>
>>>       dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
>>> -     dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
>>> +     dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
>>
>> This is unrelated with the patch description purpose.
>>
> 
> This is a direct result of converting PCIE_ATU_ENABLE to BIT(31).
> BIT(31) expands to (1UL << 31) so, without that cast I get
> 
> drivers/pci/controller/dwc/pcie-designware.c: In function
> ‘dw_pcie_disable_atu’:
> drivers/pci/controller/dwc/pcie-designware.c:303:40: warning: large
> integer implicitly truncated to unsigned type [-Woverflow]
>   dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
> 
> on AArch64. I am guessing that original definition of (1 << 31) avoids
> this problem by being an "int" instead of "unsigned long".

Ok, understood.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

> 
> Thanks,
> Andrey Smirnov
> 

