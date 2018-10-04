Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C08C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B22082A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 13:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757B22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJDUT0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:19:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJDUT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2018 16:19:26 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g83df-0004ly-KW; Thu, 04 Oct 2018 15:25:59 +0200
Message-ID: <1538659558.14153.12.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Date:   Thu, 04 Oct 2018 15:25:58 +0200
In-Reply-To: <e7d5a2beb146f627e7043a81083e6978961b2761.camel@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
         <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
         <1538643596.3515.5.camel@pengutronix.de>
         <e7d5a2beb146f627e7043a81083e6978961b2761.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-10-04 at 13:20 +0000, Leonard Crestez wrote:
> On Thu, 2018-10-04 at 10:59 +0200, Lucas Stach wrote:
> > Am Montag, den 01.10.2018, 22:53 +0300 schrieb Leonard Crestez:
> > > When the root complex suspends it must send a PME_Turn_Off TLP.
> > > Implement this by asserting the "turnoff" reset.
> > > 
> > > +static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
> > > +{
> > > +	reset_control_assert(imx6_pcie->turnoff_reset);
> > > +	reset_control_deassert(imx6_pcie->turnoff_reset);
> > 
> > I'm a bit surprised to see no timing requirements here. I would have
> > expected that there is a minimum time from asserting the reset, so the
> > turnoff message gets transmitted to the EP before the clocks are
> > stopped.
> 
> According to the PCI standard after PME_Turn_Off is sent all components
> must respond with PME_TO_Ack. There doesn't seem to be any bit exposed
> to check if acks were received but the standard recommends a 1-10ms
> timeout after which you should proceed anyway.
> 
> It seems the NXP vendor tree has an udelay(1000) which I missed, it
> seems like an acceptable solution. Or maybe it should be msleep(10)?

Maybe usleep_range(1000, 10000) ?

regards
Philipp
