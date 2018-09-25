Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF781C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5642086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5642086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZDE2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:04:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45825 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 23:04:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63-v6so2695489oic.12;
        Tue, 25 Sep 2018 13:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4V4I9cuu0zr7k8htcOxbtJKHIx3sECSRMltRNOfzVhk=;
        b=rUrkCPFkDws5+pBC4w6PF32B1yqpDZ/MWz+axdsMe3TZ9zd4sDcryh1c7tBBsAtymw
         kQEsPvX0q4B8Hr9cWW4/tb6cHG+g7ZwPoBJgrHBrxpADc5nfUKc8aApdE8A+UT3KeGss
         UtnmaRUXw4fg+N3PWyOvgCI/oU69NJ7395bDfOpMlgJ/seWjwxBi1QEXJyvNCfmdbr6/
         kyuQq8qiDQZsTIK8z3h0BAJESjkkoHgKjsXYskAHonIIOaH9hJdu6dW5Vgpkh2b7QiXm
         zSGzg0JbxFdt1lUtaM+1aVr0hyVtqTT9qSDCgM2Z1kte4jiwiT3ptlXf+3LTPREadGT7
         oeXA==
X-Gm-Message-State: ABuFfojxtNyxwmnnkRU2a3Ei/onGi8BTLubHnihhYGnXfYRRTsKdlxO6
        waQPvVtkFsD+UmmLcHugsA==
X-Google-Smtp-Source: ACcGV62wGEhlzsf/bzH5dK6Hf1f5OiDzxyOVqI/jSTi0T45gdU42fgvONGCQr5x4A1nwqGxkqpDZmg==
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr1685209oig.15.1537908903402;
        Tue, 25 Sep 2018 13:55:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2-v6sm1188669ote.50.2018.09.25.13.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:55:02 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:55:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: add UniPhier PCIe host
 controller description
Message-ID: <20180925205502.GA12949@bogus>
References: <1536226832-5089-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536226832-5089-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536226832-5089-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 06, 2018 at 06:40:31PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs when
> configured in Root Complex (host) mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/pci/uniphier-pcie.txt      | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> new file mode 100644
> index 0000000..a34e167
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> @@ -0,0 +1,78 @@
> +Socionext UniPhier PCIe host controller bindings
> +
> +This describes the devicetree bindings for PCIe host controller implemented
> +on Socionext UniPhier SoCs.
> +
> +UniPhier PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +Required properties:
> +- compatible: Should be "socionext,uniphier-pcie".
> +- reg: Specifies offset and length of the register set for the device.
> +	According to the reg-names, appropriate register sets are required.
> +- reg-names: Must include the following entries:
> +    "dbi"    - controller configuration registers
> +    "link"   - SoC-specific glue layer registers
> +    "config" - PCIe configuration space
> +- clocks: A phandle to the clock gate for PCIe glue layer including
> +	the host controller.
> +- resets: A phandle to the reset line for PCIe glue layer including
> +	the host controller.
> +- interrupts: A list of interrupt specifiers. According to the
> +	interrupt-names, appropriate interrupts are required.
> +- interrupt-names: Must include the following entries:
> +    "dma"    - DMA interrupt
> +    "msi"    - MSI interrupt
> +    "intx"   - Legacy INTA/B/C/D interrupt
> +
> +Optional properties:
> +- phys: A phandle to generic PCIe PHY. According to the phy-names, appropriate
> +	phys are required.
> +- phy-names: Must be "pcie-phy".
> +
> +Required sub-node:
> +- interrupt-controller: Specifies interrupt controller for legacy PCI
> +	interrupts. The node name isn't important.

No, it is important.

With that sentence removed,

Reviewed-by: Rob Herring <robh@kernel.org>
