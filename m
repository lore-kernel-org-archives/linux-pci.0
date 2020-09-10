Return-Path: <SRS0=01Vy=CT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E0C433E2
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078732075A
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599755143;
	bh=yqFxUKQ2rxoWnT6nIDCr9f+m4K7b9mE9qLBjdJ/agL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RW+8sN69FvJXjdwsdyIis729HCwFCxOdaE3oabLuG0puXzR/eq5PDaAKGX8/sGvg+
	 Rh6Vc3Z0Q8zeB0nIfRPQfePe40rIfIb+7tH7fwOLCN9oSY8ZeSlmsW6oxTqO2mI60S
	 REqYPFz5glx2KTmCH2jbwunBsduapICyLMiuZpL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIJQZJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:25:09 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41159 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJQXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:23:44 -0400
Received: by mail-il1-f196.google.com with SMTP id f82so1544937ilh.8;
        Thu, 10 Sep 2020 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CflFaa51AgoVeUMKJRVvC/1ImTtuXzNaYlLhUZTATjo=;
        b=KTg+G3Y3cJSAZgPdQWy4+06GCdPdm+PoRXPR2zMr1FpQQhtBpcwItoiNgrQX3dE9jv
         v9HidVpZxhU57/6euo8ZxzX9jPAXPLFBnT1br7U2jGm4cXmUmFl/+dJOSCOW+XitfldF
         4maAVp7ktMTOij3xkUCZc2+6IGhO/LVTepTy/AiguV4Z92W8gN/oNHU0V6g5m8sObqiO
         hal9TVjsXIZa+IpbwmW86oJfQ3Fiq7rhRCFYtHgXeYXYruE9Wx74CU47QZzhlVMKVVSs
         pfJMnURJ00dQf8mGS5mr6+9xT7uz0tipfpGvm+3LXbBpquj9L9RSj2nNg7ImeXtb4xzG
         88yw==
X-Gm-Message-State: AOAM532rvY2G0U9i6APMNlNwMe+un/rFCb/qWioiOd8shlPeUgVM3Ad4
        dFkezsaXJLahACVptlMtcA==
X-Google-Smtp-Source: ABdhPJypPDaunnEXeMUR+OxZcGRIoQMi7j72eDnze1G1r2FwHRVuivCsVaETqgiMh7B6qoBz2CFljA==
X-Received: by 2002:a92:5e49:: with SMTP id s70mr9175809ilb.108.1599754997816;
        Thu, 10 Sep 2020 09:23:17 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x185sm3168120iof.41.2020.09.10.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:23:17 -0700 (PDT)
Received: (nullmailer pid 474564 invoked by uid 1000);
        Thu, 10 Sep 2020 16:23:15 -0000
Date:   Thu, 10 Sep 2020 10:23:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v11 11/11] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445,
 bcm7278 to match list
Message-ID: <20200910162315.GA474518@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-12-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-12-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Aug 2020 15:30:24 -0400, Jim Quinlan wrote:
> Now that the support is in place with previous commits, we add several
> chips that use the BrcmSTB driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
