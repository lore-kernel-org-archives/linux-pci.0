Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B7C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836472133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbeLQKNG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:13:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53305 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeLQKNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 05:13:05 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gYptT-00015H-EZ; Mon, 17 Dec 2018 11:12:59 +0100
Message-ID: <1545041578.5874.3.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, helgaas@kernel.org
Cc:     lorenzo.pieralisi@arm.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-imx@nxp.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Date:   Mon, 17 Dec 2018 11:12:58 +0100
In-Reply-To: <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
         <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
         <20181214203828.GD20725@google.com>
         <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, den 14.12.2018, 21:25 -0800 schrieb Andrey Smirnov:
> > On Fri, Dec 14, 2018 at 12:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > [+cc Trent]
> > 
> > On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> > > On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > > > Everyone:
> > > > 
> > > > This series contains changes I made in order to enable support of PCIE
> > > > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > > > 
> > > > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> > > > 
> > > > Changes since [v1]:
> > > > 
> > > >  - Driver changed to use single "fsl,controller-id" property to
> > > >    distinguish between two intances of PCIE IP block
> > > > 
> > > >  - All code pertaining to L1SS was dropped to simplify the patch
> > > > 
> > > >  - Documented additions to DT bindings
> > > > 
> > > > Feedback is welcome!
> > > > 
> > > > Thanks,
> > > > Andrey Smirnov
> > > 
> > > Andrey,
> > > 
> > > I have applied the patches, ...
> > 
> > When I merged your pci/dwc branch, I noticed what looks like a merge
> > conflict between these commits:
> > 
> >   d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7")
> >   1a059d994189 ("PCI: imx: Add support for i.MX8MQ")
> > 
> > d123765b58ee added SOC_IMX7D:
> > 
> >   -       depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
> >   +       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> > 
> > and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which looks
> > like a mistake:
> > 
> >   -       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> >   +       depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
> > 
> > So my "next" branch[1] (current head 7053eeb009e0) is:
> > 
> >   config PCI_IMX6
> >         bool "Freescale i.MX6/7 PCIe controller"
> >         depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
> >         depends on PCI_MSI_IRQ_DOMAIN
> >         select PCIE_DW_HOST
> > 
> > which I think is wrong.
> 
> Yeah, this is definitely wrong, should be SOC_IMX8MQ || SOC_IMX6Q ||
> SOC_IMX7D || (ARM && COMPILE_TEST)

arm-soc would like to see the SOC_IMX8MQ option removed, so let's try
to not add any more things that depend on this. Please use (ARM64 &&
MACH_MXC) or something to that tune instead.

Regards,
Lucas
