Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3221C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 18:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E8D2173C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 18:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KSsrF91g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfAGSOU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:14:20 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:55144 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfAGSOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 13:14:20 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3A25410C1348;
        Mon,  7 Jan 2019 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546884859; bh=xfv4a6oIlGGkJUOKSYW1fKJRcCt6B25NVKEuNckXDqU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=KSsrF91gMQyy7g8ya5IEAA0OUcVwKo8MzNpraDnwdFzHWdHv2t4Q0ebpd2FqFmi5t
         i7MkAXXy/aXM7gebVdivT+vVUgb+jM0A/nC8jPjBLWy/n97bEXj7rGLzL8kOArXOox
         q5ikv//H3Tk75ZHuVzFKWXY81DvE0vKyt2HAQPGL9APn9WseBn7Ab5yk2ZRNgcCktF
         lV4h1PO6OWrSyDJ3WHBS/NuIjRwO5tPYa/pEybnXgt8Tw26xtAPQSOt2Dx/CUe1Vow
         ScsM990yNB0/12v1+DMXriPgKAUyJAbbJtcGU4vzUVEIboMRKgHE/3P6LB3sCO5TLu
         bEz7gfdXhDcVQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7944750CA;
        Mon,  7 Jan 2019 10:14:15 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 10:14:15 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 19:14:12 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 19:14:12 +0100
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Faiz Abbas <faiz_abbas@ti.com>,
        Harro Haan <hrhaan@gmail.com>,
        Jingoo Han <jg1.han@samsung.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Juergen Beisert <jbe@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Mann <m.mann@arkona-technologies.de>,
        Mohit Kumar <mohit.kumar@st.com>,
        "Pratyush Anand" <pratyush.anand@st.com>,
        Richard Zhu <hong-xing.zhu@freescale.com>,
        Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
        "Siva Reddy Kallam" <siva.kallam@samsung.com>,
        Srikanth T Shivanand <ts.srikanth@samsung.com>,
        Tim Harvey <tharvey@gateworks.com>
References: <20190104214509.16891-1-swarren@wwwdotorg.org>
 <520c9d1b-8b1f-46ac-687a-fdb703328567@synopsys.com>
 <567e726d-e3c5-c48d-ec99-af1c1576180f@wwwdotorg.org>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <98788751-12e0-7099-171a-a121dc1e6204@synopsys.com>
Date:   Mon, 7 Jan 2019 18:09:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <567e726d-e3c5-c48d-ec99-af1c1576180f@wwwdotorg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/01/2019 17:16, Stephen Warren wrote:
> On 1/7/19 2:36 AM, Gustavo Pimentel wrote:
>> Hi Stephen,
>>
>> On 04/01/2019 21:45, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> The current code does this when handling MSI IRQs:
>>>
>>> a) Process the irq.
>>> b) Clear the latched IRQ status.
>>>
>>> If a new IRQ occurs any time after (a) has read the IRQ status for the
>>> last time and before (b), it will be lost. For example, this occurs in
>>> practice when using a Marvell 9171 AHCI controller with NCQ enabled;
>>> many command timeouts occur with certain disk access patterns.
>>>
>>> Fix the code to do the following instead, so that if any new IRQs are
>>> raised during the processing of the IRQ, the IRQ status is not cleared,
>>> so that the IRQ is not lost.
>>>
>>> a) Clear the latched IRQ status.
>>> b) Process the IRQ.
>>>
>>> This change reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt
>>> status after it is handled, not before")
>>>
>>> This change re-applies commit ca1658921b63 ("PCI: designware: Fix
>>> missing MSI IRQs")
>>>
>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>>> Cc: Harro Haan <hrhaan@gmail.com>
>>> Cc: Jingoo Han <jg1.han@samsung.com>
>>> Cc: Joao Pinto <jpinto@synopsys.com>
>>> Cc: Juergen Beisert <jbe@pengutronix.de>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Matthias Mann <m.mann@arkona-technologies.de>
>>> Cc: Mohit Kumar <mohit.kumar@st.com>
>>> Cc: Pratyush Anand <pratyush.anand@st.com>
>>> Cc: Richard Zhu <hong-xing.zhu@freescale.com>
>>> Cc: Sean Cross <xobs@kosagi.com>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
>>> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
>>> Cc: Tim Harvey <tharvey@gateworks.com>
>>> ---
>>> Note: This issue was found in downstream NVIDIA 4.9 and 4.14 kernels.
>>> However, the exact same code structure is present in mainline and I have
>>> no reason to believe the problem would not reproduce there. I have
>>> compile tested but not runtime tested it in mainline, since my board is
>>> not yet supported in mainline.
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 692dd1b264fb..7fd6c56a6f35 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -98,10 +98,10 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>   			irq = irq_find_mapping(pp->irq_domain,
>>>   					       (i * MAX_MSI_IRQS_PER_CTRL) +
>>>   					       pos);
>>> -			generic_handle_irq(irq);
>>>   			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>>>   						(i * MSI_REG_CTRL_BLOCK_SIZE),
>>>   					    4, 1 << pos);
>>> +			generic_handle_irq(irq);
>>>   			pos++;
>>>   		}
>>>   	}
>>
>> This fix was already suggested by Trent Piepho, however, after review by Marc
>> Zyngier and some information obtained from Synopsys IP development team, the
>> following set of patches was generated to correct the problem.
>>
>> 830920e065e9 ("PCI: dwc: Use interrupt masking instead of disabling")
>> fce5423e4f43 ("PCI: dwc: Take lock when ACKing an interrupt")
>> 3f7bb2ec20ce ("PCI: dwc: Move interrupt acking into the proper callback")
> 
> OK. I assume that dw_pci_bottom_ack() gets called before 
> dw_handle_msi_irq() for each IRQ? In which case, the last of those 3 

Yes, the dw_pci_bottom_ack() gets called before dw_handle_msi_irq().

> changes is essentially identical to the patch I proposed, it's just that 
> the acking is handled in a separate function rather than earlier in the 
> same function.
> 

No, there is also two other fixes. A missing lock/unlock on the ack and the
correct use of the MASK/UNMASK interrupt register instead of ENABLE interrupt
register.

