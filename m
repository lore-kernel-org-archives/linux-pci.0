Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3942DC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DC621850
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeLSK5a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:57:30 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8380 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeLSK53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 05:57:29 -0500
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 19 Dec
 2018 18:57:48 +0800
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com>
 <1545120286-129258-2-git-send-email-hanjie.lin@amlogic.com>
 <CAFBinCD1x7jcJJx78yNx87MOmKQ2HuSBeRpDRQE0hyNCwm1JAg@mail.gmail.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <e3cce5d7-354c-4042-bf76-c22f3893d72c@amlogic.com>
Date:   Wed, 19 Dec 2018 18:57:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAFBinCD1x7jcJJx78yNx87MOmKQ2HuSBeRpDRQE0hyNCwm1JAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/12/19 7:14, Martin Blumenstingl wrote:
> Hi Rob, Hi Hanjie,
> 
> (sorry for being late with my question)
> 
> On Tue, Dec 18, 2018 at 9:05 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
> [...]
>> +- reg-names: Must be
>> +       - "elbi"        External local bus interface registers
>> +       - "cfg"         Meson specific registers
>> +       - "phy"         Meson PCIE PHY registers
> I have learned that there are two PHY register designs:
> - AXG only has a PCIe PHY
> - G12A has a PHY which supports PCIe and USB 3.0. The PCIe part of
> this PHY design is compatible with AXG, but this design also supports
> a USB 3.0 port (it's an exclusive choice: either PCIe *or* USB 3.0)
> 
> The PCIe controller itself is identical on both, AXG and G12A.
> This patch adds support for the AXG PCIe controller and PHY within one
> device-tree node.
> 
> For G12A I propose to add a separate "phys" property with a phandle to
> the "combo" PCIe and USB3.0 PHY - this can be part of a separate patch
> though.
> I would like to know whether it's OK that for AXG the PCIe PHY is
> described in the same device-tree node as the PCIe controller (in
> other words: we're not using a "phys" property here)?
> 
> 
> Kind Regards
> Martin
> 
> .
> 

hi matrin,

We do had a dedicated PHY driver for a time at the begining
of this patch series, but we decided to remove it and integrate
into the controller driver after series reviews and disscussions,
and the main reason is it's too overkill to have a dedicated 
PHY driver which only do the RESET job.

Of course we can consider the dedicated PHY driver for G12A upstream
in future.

thanks
hanjie

