Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A88C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0C2064E
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 10:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0C2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJER5k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:57:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60599 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeJER5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2018 13:57:40 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8NpG-0005pP-7R; Fri, 05 Oct 2018 12:59:18 +0200
Message-ID: <1538737156.3545.22.camel@pengutronix.de>
Subject: Re: [PATCH v2 4/4] PCI: imx: Add PME_Turn_Off support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 05 Oct 2018 12:59:16 +0200
In-Reply-To: <20181005102906.GA25651@red-moon>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
         <37d60fe2119361381a6a81f439fa1c3ad29db45e.1538670431.git.leonard.crestez@nxp.com>
         <20181005102906.GA25651@red-moon>
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

Hi Lorenzo,

On Fri, 2018-10-05 at 11:29 +0100, Lorenzo Pieralisi wrote:
> On Thu, Oct 04, 2018 at 04:34:30PM +0000, Leonard Crestez wrote:
> > When the root complex suspends it must send a PME_Turn_Off TLP.
> > Implement this by asserting the "turnoff" reset.
> > 
> > On imx7d this functionality is part of the SRC and exposed through the
> > linux reset-controller subsystem. On imx6 equivalent bits are in the
> > IOMUXC GPR area which the imx6-pcie driver accesses directly.
> 
> Nit: I am merging the series, please define what SRC and GPR are so
> that I can update the commit log accordingly, it must be clear to
> anyone reading it.

SRC is the System Reset Controller, which controls reset signals to all
kinds of devices, among them the PCIe PHY.

IOMUXC GPR is a General Purpose Register range in the IOMUXC (pinmux
controller) that is used to control various signals all over the SoC.

regards
Philipp
