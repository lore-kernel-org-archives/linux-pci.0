Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20550C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 12:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA32146E
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 12:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBSMmU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:42:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44712 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBSMmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 07:42:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE542EBD;
        Tue, 19 Feb 2019 04:42:19 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542673F720;
        Tue, 19 Feb 2019 04:42:17 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:42:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
Message-ID: <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 05:51:06PM -0800, Andrey Smirnov wrote:
> Lorenzo:
> 
> This small series adds code to control "pcie_aux" clock. This is an
> oversight from original submission [pcie-imx8mq-v7], which was only
> discovered once I submitted an RFC for corresponding DT changes going
> via i.MX tree [imx-dt-rfc].
> 
> Thanks,
> Andrey Smirnov
> 
> [imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
> [pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (2):
>   dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
>   PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
>  drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Hi Andrey,

I have applied it to pci/dwc for v5.1, however it looks like it would
break the driver with an old dts - I assume that's expected but let
me know if there is a better way to handle this.

Lorenzo
