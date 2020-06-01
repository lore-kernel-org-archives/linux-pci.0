Return-Path: <SRS0=3fN0=7O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC8C433DF
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 21:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294F52074B
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jun 2020 21:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591045383;
	bh=nUgJyB/gk+5ijwnmP7Z8A8YYdLlmTMNQsU+BbLfn66E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XZkw9/M+aTfAo/sYej7BXAfj2OsXazMPmFXoeIRlErF//Lsmfc04x+9EW45yQZeVq
	 nDIC8OTpYGVa2HnyZbTg70VFF1z1u5obCmCdP0G9/ct02WxJluICkP3FYQvdvCq/K0
	 aL3rowKJVkBAvwZmY2J2ZQl2UjBI5hvX+Ce1TW4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFAVC7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:02:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35817 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAVC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:02:58 -0400
Received: by mail-io1-f67.google.com with SMTP id s18so8523914ioe.2;
        Mon, 01 Jun 2020 14:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2KafSWPk9m9zR6lVEGJ97Ox8H0TePRPBQbpHWvp5CM=;
        b=PutXRLzPfONEARMsFgiDhG2CRv9UzlOz1L5IsNT1bAJ1pN/rBaALaqXgy7+7WW0sKZ
         kUaiCB35rInWDQSb/tfpcCfFRnOX8E9rNjajJwyCCgFUdiPH3JjQqGVqp6pUMtT3g8CV
         sXCaZFjKRfHXd5q/Xc9HaA0iiChTw968pB65M+Ik1M18niZIrrbyAtCiwtFS5ruAas6n
         0sf/Bc7HwQddZnSboRwq4VowkypWfqL569zEZEbI8PSgoQeNUnpJyd4VA1C/m42j/sp/
         fix12+1khHEBAzpu3Mqx8pQmzvgpVBmcYzuq9/3ahVNmU14nVXMZLA8NDqNYww6yfCEC
         60bA==
X-Gm-Message-State: AOAM532yFdLrAQTtfJT1t2afGMAoJEn/XVSsu8TZqPpSQvcdYiF8DWYO
        Y7C2wSfJ8faP8bCgq8ExOQ==
X-Google-Smtp-Source: ABdhPJwz55UCxWtYCo6t6r1ao+TKYwaYb4M8xkoqdmM8u+abMjxVNihr3yUCVvMg+jM/9hTtJN2+Bg==
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr20290937ioj.176.1591045377082;
        Mon, 01 Jun 2020 14:02:57 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q7sm325060ilj.78.2020.06.01.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:02:55 -0700 (PDT)
Received: (nullmailer pid 1491019 invoked by uid 1000);
        Mon, 01 Jun 2020 21:02:54 -0000
Date:   Mon, 1 Jun 2020 15:02:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 06/10] PCI: qcom: Use bulk clk api and assert on error
Message-ID: <20200601210254.GA1490941@bogus>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
 <20200514200712.12232-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514200712.12232-7-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 22:07:07 +0200, Ansuel Smith wrote:
> Rework 2.1.0 revision to use bulk clk api and fix missing assert on
> reset_control_deassert error.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 131 +++++++++----------------
>  1 file changed, 46 insertions(+), 85 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
