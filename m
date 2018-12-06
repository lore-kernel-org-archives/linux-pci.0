Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC9C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDB20878
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 12:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EDB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeLFMP6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:15:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbeLFMP6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 07:15:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A041D80D;
        Thu,  6 Dec 2018 04:15:57 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F4E3F575;
        Thu,  6 Dec 2018 04:15:54 -0800 (PST)
Date:   Thu, 6 Dec 2018 12:15:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
Message-ID: <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains changes I made in order to enable support of PCIE
> IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> 
> NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> 
> Changes since [v1]:
> 
>  - Driver changed to use single "fsl,controller-id" property to
>    distinguish between two intances of PCIE IP block
> 
>  - All code pertaining to L1SS was dropped to simplify the patch
> 
>  - Documented additions to DT bindings
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov

Andrey,

I have applied the patches, I would like to make the CC list in standard
format so I kindly ask you firstname/surname for cphealy@gmail.com, I
could not find it in the maintainers list but I want to keep the CC
list as per patches (I removed the lists, though).

Thanks,
Lorenzo

> [v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/
> [github-v2] https://github.com/ndreys/linux/commits/imx8mq-pcie-v2
> [imx8mq-kconfig] https://lore.kernel.org/linux-arm-kernel/20181114175242.12468-1-l.stach@pengutronix.de/
> 
> Andrey Smirnov (3):
>   PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
>   PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
>   PCI: imx: Add support for i.MX8MQ
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
>  drivers/pci/controller/dwc/Kconfig            |  2 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 87 ++++++++++++++++++-
>  3 files changed, 90 insertions(+), 5 deletions(-)
> 
> -- 
> 2.19.1
> 
