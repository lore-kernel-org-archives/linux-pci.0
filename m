Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284AC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF2721900
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAaR2i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:28:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbfAaR2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 12:28:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF0BA78;
        Thu, 31 Jan 2019 09:28:37 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43D53F59C;
        Thu, 31 Jan 2019 09:28:35 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:28:30 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: dra7xx: Support PCIe x2 lane mode
Message-ID: <20190131172830.GA31110@e107981-ln.cambridge.arm.com>
References: <20190124082957.29077-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 01:59:54PM +0530, Kishon Vijay Abraham I wrote:
> Previous version of the patch series can be found here [1]
> 
> Patch series adds support to enable x2 lane mode in dra74/dra76 and
> dra72 based boards in pci-dra7xx driver. It introduces new compatible
> strings in order to enable x2 lane mode support.
> 
> Changes from v2:
> *) Have a single syscon dt property for configuring x2 lanes
> *) Fix minor comments given by Lorenzo (falling back to 1 lane mode,
>    remove unused structure member).
> 
> Changes from v1:
> *) Added ti prefix to syscon-lane-conf and syscon-lane-sel as
>    suggested to Rob
> *) Merged "PCI: dwc: dra7xx: Add support for SoC specific compatible
>    strings" and "PCI: dwc: pci-dra7xx: Enable x2 mode support" into
>    a single patch.
> *) Fixed $subject as suggested by Bjorn
> *) Added x2 lane mode support for DRA72x
> 
> The dts changes and phy changes will be sent as a separate series.
> 
> [1] ->  https://lkml.org/lkml/2017/12/19/175
> 
> Kishon Vijay Abraham I (3):
>   dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
>   dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
>   PCI: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x
> 
>  .../devicetree/bindings/pci/ti-pci.txt        | 11 ++-
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 77 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)

I have applied the series to pci/dwc for v5.1, thanks.

Lorenzo
