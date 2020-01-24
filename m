Return-Path: <SRS0=FXHr=3N=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C23C3F68F
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37E4214DB
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAXIT2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:19:28 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34267 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXIT2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 03:19:28 -0500
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2232424000C;
        Fri, 24 Jan 2020 08:19:23 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:27:47 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: Add AXG PCIE PHY bindings
Message-ID: <20200124082747.GS1803@voidbox>
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-2-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123232943.10229-2-repk@triplefau.lt>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing Review/Ack-by tags from v5.

On Fri, Jan 24, 2020 at 12:29:37AM +0100, Remi Pommarel wrote:
> Add documentation for PCIE PHYs found in AXG SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
