Return-Path: <SRS0=niy7=4Q=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70013C3F2D2
	for <linux-pci@archiver.kernel.org>; Fri, 28 Feb 2020 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A08D2469D
	for <linux-pci@archiver.kernel.org>; Fri, 28 Feb 2020 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582904304;
	bh=xf57BYdgRaL5TPlhWHSjSr3IkSphINGZj7t7/H8WgVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g1wryXyoeGkM0Q7FDRujGO1ZpOFSMpUMgbzrDxjwgPEqb6w/deuVh+JsbS1bdObBh
	 aOpq6SD/uAnFj+e02mhFeFPEvnEEHaDM0X8FiOGViP/neUsq6Uwe+e0tk0O+l2JIE3
	 V7+eE3JA1fzoUihLGtexYdjIteOtOKLbAkF10G+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgB1PiX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:38:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43023 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgB1PiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:38:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so3203305oif.10;
        Fri, 28 Feb 2020 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDpey6T8lgxYQHJUzjwO210zO7/INLaAqTjmTmx/Qhg=;
        b=tRtdIaJWoK8dJLjYMmYsV+iguGKL3Z9hB6ZjJvZfLtEUqiQoLo9Qw0R+rzfjDDAOrr
         8becKJjUB11MVIeU99OBHKEKPREh5sMk9NnhHt/VJ/YJkKqK/pKNwxDqwU5VV1/Vzj8f
         JZp8pyweYLS9ROT5ju8Rj75w0KrrZfLhpQWR1L35LdchgXb3AW3aEro5CZyVy5d/Pw0U
         8y1GFMvp9ybhxHllCNZ6PzD+/GPi+sJBnzRnOT6dksOm6hNQdyldgszcXxIP/iDxCYr0
         mBWQG1MbLgs8uDwI+GHahLUxf8CxfPtYTIZxBp+xJDXz1h/qPW7iCzVBE9cWc1FTqXqW
         8pnA==
X-Gm-Message-State: APjAAAWGgH1QMRa1VMBFuzvY/K3WaVgjCyoCaTaYNHKse2quBz7jiVUi
        Mg8Iaub2jJCB3AWJ8YmPAQ==
X-Google-Smtp-Source: APXvYqwHhcuUz78YlJ14pZKglmsIhSta+BjmU1PYsKxSZExgso3eu7jX1iI+4smic8rg9VnjmMfOUg==
X-Received: by 2002:aca:4a86:: with SMTP id x128mr1057001oia.29.1582904301019;
        Fri, 28 Feb 2020 07:38:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b4sm3181050oie.55.2020.02.28.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:38:20 -0800 (PST)
Received: (nullmailer pid 6555 invoked by uid 1000);
        Fri, 28 Feb 2020 15:38:19 -0000
Date:   Fri, 28 Feb 2020 09:38:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: cadence: Add PCIe RC/EP DT
 schema for Cadence PCIe
Message-ID: <20200228153819.GA5476@bogus>
References: <20200224130905.952-1-kishon@ti.com>
 <20200224130905.952-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130905.952-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 06:39:03PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
> PCIe core library. Platforms using Cadence PCIe core can include the
> schemas added here in the platform specific schemas.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns-pcie-host.yaml          | 27 ++++++++++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 31 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
