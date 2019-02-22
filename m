Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC8C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81602070B
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550867621;
	bh=rH/kMWCDr+zTRXnmEfk4T4r2c1G/KwxBGQmRURC8a/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HLyx45DSiBU7yPJrt3FiaQbkFeW5VQ0gl14d7t+O8bqnU1vMLtpEPYhj+o3epSsRP
	 Lww0lMehReaVWuFxL0+srUrqYi+92BPgke2nBAu8C5HxwLaVNN2j2QmA0saZ+flpvV
	 8snzB81atGxLcWpdZdKrd3DiXlIG6utSaUyes2a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfBVUde (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:33:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37989 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfBVUde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 15:33:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so2989510otf.5;
        Fri, 22 Feb 2019 12:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hh37lePBQi++VHgdWO+dQ4D9xyeh9xkY3aJloqZe+Tg=;
        b=HOm/ns14TKDdNKNW2CPiVMG0qrGPP4RpWRvr6Eai2f4K7WTdYNVdorcBL9UtqIdT9w
         Oo2KdBVm2hZFZ8kt/IGhAh5GKvEm8XQ9NtrZ681D8iEgP00K3En6K4nJ2Qqs0+UOmRwe
         yS3306ltU9cAgwuyBCcbWNFarTob64+3fmqTbUM6/EM1bYpLVpKwpOq0D0PPOlz19VEk
         oKJwhENvz7a2LQefd8CVFlZpcdeD8Tl7Wi4KYn6KZLe/Mj15+tDumHh9hrekNwCPkELQ
         tC6ynyHE59KpIxQvRelycQ8dk0oZFQYJn94JDLVej1Jj6atji3oVHjrGfWqcBwTmlBTm
         nJkA==
X-Gm-Message-State: AHQUAuYJA/IkOVSUjdu0tWAwpM04Ih/vuBxMbogV2IpSTlC6IA/x2osf
        emmb16w8Qa6LBPP6/ZM0AQ==
X-Google-Smtp-Source: AHgI3IbbYNJnAfSQ3weaHFf2M4E4OwC35e114YzOtAU7/uco9QVKpBlZIFht/PfuH+DMZXFLmjCtyw==
X-Received: by 2002:a9d:1b2f:: with SMTP id l44mr3926797otl.217.1550867613155;
        Fri, 22 Feb 2019 12:33:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v8sm941095otq.4.2019.02.22.12.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:33:32 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:33:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: PCI: qcom: Add QCS404 to the binding
Message-ID: <20190222203331.GA14965@bogus>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219060407.15263-6-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Feb 2019 22:04:05 -0800, Bjorn Andersson wrote:
> The Qualcomm QCS404 platform contains a PCIe controller, add this to the
> Qualcomm PCI binding document. The controller is the same version as the
> one used in IPQ4019, but the PHY part is described separately, hence the
> difference in clocks and resets.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
