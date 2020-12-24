Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1EC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 24 Dec 2020 01:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98E522517
	for <linux-pci@archiver.kernel.org>; Thu, 24 Dec 2020 01:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLXBHm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Dec 2020 20:07:42 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:59054 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgLXBHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2020 20:07:41 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2020 20:07:40 EST
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 08F7E1AE6
        for <linux-pci@vger.kernel.org>; Thu, 24 Dec 2020 08:55:44 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P9716T140427754485504S1608771343124979_;
        Thu, 24 Dec 2020 08:55:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e2d390eee96b6e244b7448cc0bab19b4>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: kw@linux.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Cc:     shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        Krzysztof Wilczynski <kw@linux.com>
Subject: Re: pcie-rockchip-ep.c coverity issue #1437163
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20201223210444.GA322275@bjorn-Precision-5520>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5bbfb361-4461-167c-2f64-da8578d711f0@rock-chips.com>
Date:   Thu, 24 Dec 2020 08:55:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201223210444.GA322275@bjorn-Precision-5520>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2020/12/24 5:04, Bjorn Helgaas 写道:
> [+cc Krzysztof]
> 
> On Wed, Oct 28, 2020 at 08:34:45AM +0800, Shawn Lin wrote:
>> On 2020/10/28 0:16, Bjorn Helgaas wrote:
>>> Hi Shawn,
>>>
>>> Please take a look at this issue reported by Coverity:
>>>
>>> 332 static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>>> 333 {
>>> 334        struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>>> 335        struct rockchip_pcie *rockchip = &ep->rockchip;
>>> 336        u16 flags;
>>> 337
>>> 338        flags = rockchip_pcie_read(rockchip,
>>> 339                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
>>> 340                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>>>
>>> CID 1437163 (#2 of 2): Operands don't affect result
>>> (CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: flags &
>>> (65536UL /* 1UL << 16 */) is always 0 regardless of the values of its
>>> operands. This occurs as the logical operand of !.
>>>
>>> 341        if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
>>> 342                return -EINVAL;
>>
>> Actually it should be BIT(0) instead of BIT(16),
>> I will fix it, thanks.
> 
> Just a quick reminder about this and the similar issue in
> rockchip_pcie_ep_send_msi_irq().
> 
> Your response above didn't seem to make it to the archive, so maybe
> your patch to fix it also got lost?
> 
> Krzysztof also pointed out that rockchip_pcie_read() returns u32,
> while flags is only u16.
> 

Thanks for reminder. I didn't notice my previous patch hadn't arrived at
the archive but I just sent again a few minutes ago.

> Bjorn
> 
> 
> 


