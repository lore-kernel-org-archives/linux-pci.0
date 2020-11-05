Return-Path: <SRS0=slvM=EL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24330C4741F
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF3620759
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604595367;
	bh=R33c4lO1WMXdnXfmfXA5uunqMR3i9f86Q+vykz+XUqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=srgKx693xDBFPhSyV01Jh/6Lej7kANFupw65xEGtHPqBYQgcvQTB/lp1m3PPnTj4h
	 cvndzaf0jM19PI4Jn8+bly/PhdM54Y0kxFsnjJP0aTubl6LH08GFey9ayHyJSesE4d
	 U4OHRBh37Bwj2Kyxzn75LatetMjEDXNyoH5HJc5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKEQ4H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Nov 2020 11:56:07 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42499 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQ4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 11:56:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id w145so2347199oie.9;
        Thu, 05 Nov 2020 08:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VOQmjlktCwnbXQkwSM/LIq5piGxkps5/0saOasyYxSc=;
        b=fTBx4ehxU64cIR/AEFjaK8L3VUgLmiEFL+JBPhsGCVx0uy++4wpRhNOEArJDYO+uny
         MHTknO0Drkulk/dmHeaq3kJzF9MpkS7SqNDv3b4zqL9ZMOhRIEyFUGUhH+YkY5I5uA/U
         y9ncjnDDVj8sdwsWPVFMPQFG5aDA1i6o+Awx5zDI3CeOIc8sFhIVF9jVo0y7BSl4XEtf
         +ehHa8u0U+oINYqpzL2ZPy+xfWZpDGZMClMv43CR0KkE7u4jKsMb1/gGtYBmOFvlhaNt
         Dbi5I1WsNya0U7Uxms6JRCtLme9H+pLMUo5H2gDDPk5BA4lUF9ufNLzQOi1vNWc6P3RY
         XDlQ==
X-Gm-Message-State: AOAM530ffUZjjE+tULIFMVxEDYNCPFY8sioJiPgWcdIk7NaWM1aPFS4i
        Yt0JUQ3Qyl5MwzVKb1HeYA==
X-Google-Smtp-Source: ABdhPJzebqtYxAGOlRrabjUSfbZzKHBUpa/RzrqLCR6poXEl8QX9yGIpDR+kNFa90NwK8gTm8+LgQw==
X-Received: by 2002:aca:ddc6:: with SMTP id u189mr196777oig.59.1604595365679;
        Thu, 05 Nov 2020 08:56:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a23sm452301oot.33.2020.11.05.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:56:04 -0800 (PST)
Received: (nullmailer pid 1474077 invoked by uid 1000);
        Thu, 05 Nov 2020 16:56:04 -0000
Date:   Thu, 5 Nov 2020 10:56:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/8] dt-bindings: PCI: Add host mode dt-bindings for TI's
 J7200 SoC
Message-ID: <20201105165604.GA1474027@bogus>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102101154.13598-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 02 Nov 2020 15:41:48 +0530, Kishon Vijay Abraham I wrote:
> Add host mode dt-bindings for TI's J7200 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml          | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
