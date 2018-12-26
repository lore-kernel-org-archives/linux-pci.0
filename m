Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EFC43387
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2B214C6
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 15:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dscSSnUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLZPbC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:31:02 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:52276 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeLZPbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Dec 2018 10:31:02 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 153FB24E25B5;
        Wed, 26 Dec 2018 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545838262; bh=Te//KRYuxaqva0xlJVkZ+PV9LWlrJf8OLOsnwHq3sO8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=dscSSnUPhoDAP92rIMGL5ig/0glyo7OgdwBJbNiQH704pUhmpBe+u6pK67BQyQ8cL
         7gxF718YxtdTl97fTsR7uMMarX9UOm3wxS3cBqeqewyDkMOv06gw5z+kfB2a7N0F4E
         Um98ZH8rkwT45t+prDGgnPwTl7QlXlr3rXGD0Go0Ku+l78DoCCQ5b2drktMnR6jgcT
         imOupR+yFm0UjbSgMhgGgOOhKi2H7OUhVFwToWxlJPJmQMZ+KvqhnyY20iIGKesq9z
         M1vyL9feYcj4jvc7EN3LPRw6eHqHYmhEF7034ktkTQPbSy6/cyU4BuMu+zEhXD0fQU
         d2oRoUHawhemg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id E44525F8E;
        Wed, 26 Dec 2018 07:31:01 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 07:31:01 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 26 Dec 2018 16:30:59 +0100
Received: from [10.225.2.19] (10.225.2.19) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 26 Dec
 2018 16:30:59 +0100
Subject: Re: [PATCH 00/21] i.MX6, DesignWare PCI improvements
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
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3b3a232c-4991-cdb4-59f3-29fba93dfefc@synopsys.com>
Date:   Wed, 26 Dec 2018 15:26:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.225.2.19]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 21/12/2018 07:26, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.
> 
> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (21):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Remove redundant debug tracing
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove duplicate macro definitions
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
>   PCI: designware: Make use of IS_ALIGNED()
>   PCI: designware: Share code for dw_pcie_rd/wr_other_conf()
>   PCI: imx6: Drop imx6_pcie_link_up()
>   PCI: designware: imx6: Share PHY debug register definitions
>   PCI: designware: Make use of BIT() in constant definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
>   PCI: imx6: Use common mask in imx6_pcie_reset_phy()
>   PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
>   PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
>   PCI: designware: Make use of GENMASK/FIELD_PREP
>   PCI: designware: Remove superfluous shifting in definitions


s/DesignWare/dwc in all patches, please.

Regards,

Gustavo

> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 151 +++++++-----------
>  .../pci/controller/dwc/pcie-designware-host.c |  61 +++----
>  drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
>  drivers/pci/controller/dwc/pcie-designware.h  |  60 +++----
>  4 files changed, 116 insertions(+), 174 deletions(-)
> 

