Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC88C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 11:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986B82084D
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 11:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986B82084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJESHG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:07:06 -0400
Received: from foss.arm.com ([217.140.101.70]:50136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJESHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 14:07:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A287A9;
        Fri,  5 Oct 2018 04:08:47 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 826BD3F5A0;
        Fri,  5 Oct 2018 04:08:45 -0700 (PDT)
Date:   Fri, 5 Oct 2018 12:08:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Subject: Re: [PATCH v2 4/4] PCI: imx: Add PME_Turn_Off support
Message-ID: <20181005110840.GA27329@e107981-ln.cambridge.arm.com>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
 <37d60fe2119361381a6a81f439fa1c3ad29db45e.1538670431.git.leonard.crestez@nxp.com>
 <20181005102906.GA25651@red-moon>
 <1538737156.3545.22.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538737156.3545.22.camel@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 05, 2018 at 12:59:16PM +0200, Philipp Zabel wrote:
> Hi Lorenzo,
> 
> On Fri, 2018-10-05 at 11:29 +0100, Lorenzo Pieralisi wrote:
> > On Thu, Oct 04, 2018 at 04:34:30PM +0000, Leonard Crestez wrote:
> > > When the root complex suspends it must send a PME_Turn_Off TLP.
> > > Implement this by asserting the "turnoff" reset.
> > > 
> > > On imx7d this functionality is part of the SRC and exposed through the
> > > linux reset-controller subsystem. On imx6 equivalent bits are in the
> > > IOMUXC GPR area which the imx6-pcie driver accesses directly.
> > 
> > Nit: I am merging the series, please define what SRC and GPR are so
> > that I can update the commit log accordingly, it must be clear to
> > anyone reading it.
> 
> SRC is the System Reset Controller, which controls reset signals to all
> kinds of devices, among them the PCIe PHY.
> 
> IOMUXC GPR is a General Purpose Register range in the IOMUXC (pinmux
> controller) that is used to control various signals all over the SoC.

Thanks Philipp. Updated the commit log and pushed out the series
for v4.20 (branch pci/dwc - I have just updated this patch log).

Thanks,
Lorenzo
