Return-Path: <SRS0=cGNF=ED=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24240C56202
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8CC246CD
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603922085;
	bh=NmuMkX3jIaTN7lQIN3KvoqabTDKn16tIELqhxOaWm5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dgi6DBZLS/lKHjwU21mLyJBknk1x8qE6r0ySAD6MhBuwMSxmLF2GNH84s6uYb4LSM
	 sX/V6eyjVDgCdzLZLN2VjtEh3F77V5XenuR2km+g3jptZoAon+m4pA+1L9ouWERF6b
	 cOWAQqdrGSDXsh0sAf5HVw6m16PQ9YiKcbBnXdRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgJ1Vyl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:54:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36250 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgJ1Vyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:54:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id y186so1166822oia.3;
        Wed, 28 Oct 2020 14:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uc78x8CmwZLzrKJ78c98Bv6j8H6O42mQH8+34OvgxWs=;
        b=CfLad6XA+URAMmONLs7b5YFk1mHUAf4qjcUe8DI/9oDAlz54boCzbDAKkTmf/CCWsl
         gHEVo6hlLzXiKHvmhPx6HluQBtx1UON4ioMgTG6jkfmfK+qG8sMzT2xPizgejuQxgO5y
         1FAxWzIrn2YxMYnkg/a7NSQHEEiaG/5CuxPkkl7upE8iTB3p0uNuG4HfhMFsiiW/l1ln
         K4C5yrvAhMrf0bH7AF0TNuoYpk8vMVyAKy2rXR7SEOfjs7N2zJhDEPiBKl88T5lbBgLb
         RA1nAgNC6E9BgEMX0Eu/ySQXhY09yq5dHrjyQlr+jognx+uhdUNuuK9C8oyXaI5QJsZy
         v5MA==
X-Gm-Message-State: AOAM533I7KlG0uCOBss75cPbYyMhld80JTisozrAP/XNAb+NSAhfMhju
        TSuXCssD3XRn5t+xXW6ehNVlPxBZmQ==
X-Google-Smtp-Source: ABdhPJzBeWZH6SAY7afIgY1/3BfjtQmztEeFkp69qvQ5J2PDJhbpSiCR8mcjBJXcwrLL2OvDMKpx/g==
X-Received: by 2002:aca:4ac6:: with SMTP id x189mr4914954oia.58.1603896288433;
        Wed, 28 Oct 2020 07:44:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v123sm2710068oif.29.2020.10.28.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:44:47 -0700 (PDT)
Received: (nullmailer pid 3995233 invoked by uid 1000);
        Wed, 28 Oct 2020 14:44:47 -0000
Date:   Wed, 28 Oct 2020 09:44:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com,
        marek.vasut+renesas@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Message-ID: <20201028144447.GA3994930@bogus>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Oct 2020 11:05:49 +0900, Yoshihiro Shimoda wrote:
> Convert Renesas PCIe Host controller bindings documentation to
> json-schema. Note that some compatible doesn't contain on
> the original documantation so that incremental patches are required
> for it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 146 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----------
>  2 files changed, 146 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/rcar-pci-host.yaml:18:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/pci/rcar-pci-host.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1389094

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

