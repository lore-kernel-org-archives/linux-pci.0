Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04FC4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404E920989
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404E920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbeKUEBF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:01:05 -0500
Received: from foss.arm.com ([217.140.101.70]:58032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeKUEBF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 23:01:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09BD1DC8;
        Tue, 20 Nov 2018 09:30:48 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D836E3F5AF;
        Tue, 20 Nov 2018 09:30:44 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:30:34 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bao Xiaowei <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, bhelgaas@google.com, shawnguo@kernel.org,
        madalin.bucur@nxp.com, sumit.garg@nxp.com, yangbo.lu@nxp.com,
        hongtao.jia@nxp.com, Yuantian.Tang@nxp.com, leoyang.li@nxp.com,
        kishon@ti.com, jingoohan1@gmail.com, pbrobinson@gmail.com,
        songxiaowei@hisilicon.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zhiqiang.Hou@nxp.com, mingkai.hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCHv4 0/3] dts: Add the property of IB and OB
Message-ID: <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110034847.17891-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 10, 2017 at 11:48:44AM +0800, Bao Xiaowei wrote:
> Depend on http://patchwork.ozlabs.org/patch/815382/
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 121 +++++++++++++++++++++++--
>  3 files changed, 121 insertions(+), 7 deletions(-)

Can I drop this series from the linux-pci patch queue ? I reckon
it is superseded by:

https://patchwork.ozlabs.org/patch/992928/

but I wanted to make sure that's the case, I really can't follow
the version numbering so I am asking.

Thanks,
Lorenzo
