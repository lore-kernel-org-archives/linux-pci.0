Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322DBC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0077B2070D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550865284;
	bh=Z47JLcKeQPTgwUAXGdJwxMDpArrgCOn/XZ67XgSGCxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RQCLh2BdoLdnhskiiLGI4+aOX2Pm6XBIwH+8vGSoNH1Oz57cZ9A3HIghQayGfN7mg
	 feYJcghFChR99Q5cVjBNM1fY7dCyPVtA2QdiOoEuLtTLDzX1eboRcUf0QxPZ/hkE1v
	 ds8yM+7n1axJcAh+Dk15wkVSPPqv7o4jTUYNLiC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBVTyj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:54:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45831 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfBVTyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 14:54:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so2847225ota.12;
        Fri, 22 Feb 2019 11:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLSf1F8h4zenC+IA1SEKa3+nVZ7TzyWzcS8/NUrEaGA=;
        b=tM1uEdOpgE1c6FwfhCgpybQ6juGoMPtakE0DXZ72qf9zcqK36XUhIOhdas+JbddZoY
         AGLaHupkxnNAtfcPWIw7kNVUojYdMVRldFIT7BA34pTQdDJjz8eA4J+EPuBSNWJoEHUQ
         sHTR+4PqOsKG4CL/3+9ctwKGONh1leJIs+h6nr7NlKBVMya9ZT3j1jcKKWQefeDCrXIn
         0eugZpvhlOn25VQA0a6SmEefpCXzHyeC+TyInRzb6XwzZbJ2tzcOENBMLpmvcwZMDv2G
         mxDw+608ZuKkRQQN2FN68AZ9rT0V6nlrR+7PlZow5jGB9FEZFoMJUQ8CzTJZ4CCdTeZv
         /xdA==
X-Gm-Message-State: AHQUAuZbNV2eiNNQ8gK3JULK6D2PIrsHvxwmGDmP9YPTEB5qgV9Nlnk0
        3vHhNfwDqHe5TlxX0KC4XA==
X-Google-Smtp-Source: AHgI3IaMfxAxy1d5B1Ip8fYOLVMWVTIl7LABQBDFjU+427ucRIvC0UkEFejJwpVMTIA8XNwbxw1Tzw==
X-Received: by 2002:a9d:7cca:: with SMTP id r10mr3956749otn.81.1550865277934;
        Fri, 22 Feb 2019 11:54:37 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y124sm919639oie.57.2019.02.22.11.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:54:37 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:54:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/7] clk: gcc-qcs404: Add PCIe resets
Message-ID: <20190222195436.GA26101@bogus>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219060407.15263-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 10:04:01PM -0800, Bjorn Andersson wrote:
> Enabling PCIe requires several of the PCIe related resets from GCC, so
> add them all.
> 
> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gcc-qcs404.c               | 7 +++++++
>  include/dt-bindings/clock/qcom,gcc-qcs404.h | 7 +++++++
>  2 files changed, 14 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
