Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC2C10F00
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70A22146E
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 12:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfBSMqk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:46:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55535 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfBSMqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 07:46:39 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gw4n8-0006Zo-7B; Tue, 19 Feb 2019 13:46:30 +0100
Message-ID: <bea67ed9d36e79d87e37056d175318ec5a6e667a.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 19 Feb 2019 13:46:28 +0100
In-Reply-To: <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
         <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Am Dienstag, den 19.02.2019, 12:42 +0000 schrieb Lorenzo Pieralisi:
> On Mon, Feb 11, 2019 at 05:51:06PM -0800, Andrey Smirnov wrote:
> > Lorenzo:
> > 
> > This small series adds code to control "pcie_aux" clock. This is an
> > oversight from original submission [pcie-imx8mq-v7], which was only
> > discovered once I submitted an RFC for corresponding DT changes going
> > via i.MX tree [imx-dt-rfc].
> > 
> > Thanks,
> > Andrey Smirnov
> > 
> > [imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
> > [pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com
> > 
> > Andrey Smirnov (2):
> >   dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
> >   PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
> > 
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
> >  drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> 
> Hi Andrey,
> 
> I have applied it to pci/dwc for v5.1, however it looks like it would
> break the driver with an old dts - I assume that's expected but let
> me know if there is a better way to handle this.

There is no upstream DT using the imx8mq binding, yet. We've actually
noticed the issue due to the DT patches adding the PCIe nodes and those
2 patches fix the driver _before_ we introduce any DT using it. So I
think it's okay not to worry about backwards compatibility here.

Regards,
Lucas

