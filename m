Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC61C07E97
	for <linux-pci@archiver.kernel.org>; Sat,  3 Jul 2021 15:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15BF61402
	for <linux-pci@archiver.kernel.org>; Sat,  3 Jul 2021 15:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhGCPSi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 3 Jul 2021 11:18:38 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33337 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCPSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:18:37 -0400
Received: by mail-lf1-f44.google.com with SMTP id t17so23985060lfq.0
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhSi9qBdB+dgATMWMs41ZtC9Bq9Jvry9wenvZ464x38=;
        b=DXUABHCHSt4Lo20vl2op7J02XL4OpyYDHOVDcUAcBEYJ4p03pG3bBKoMtkNVboxg4+
         iXWXpQDiv6JeLL4feOs1jbZqP9SaY95FU4RGilygyZuL60i3jMYVIBrRoEYzi6zIR99b
         S9qEnyD8C5w+1+AX0v6prdROhiqSXukTFMdPioD4/4uq0bOcgtz1kutOSRGOwjT6Fu1z
         OfVMw0+Df2VbvQ1/VKkNyLY/VCUPNjmmXcHy/QLmdrxYS2DOmsdZyFPC/MsksWvjvfO0
         Zss/JI+2Mlg+Ku+CmzOuEy7YDghDvM4PMvWB7mJyDXwGa+khhoCLPkoU67R0mUwnRYBe
         c6eQ==
X-Gm-Message-State: AOAM5323WCPnfVGNZy+kFzH1xcrJJZSN0ceTEvgGQMRePEiJCRxFmExg
        BYeQwdUe5IyZ8nqr811no/8=
X-Google-Smtp-Source: ABdhPJz4Rpd/SlQ0fmFZuTex7CI/t18u6t1WSvSs0pZr8j0xAdDakDyPTjS5cWl7BC9md+Np1z87Jw==
X-Received: by 2002:ac2:528f:: with SMTP id q15mr3915804lfm.581.1625325363108;
        Sat, 03 Jul 2021 08:16:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s13sm318179ljp.8.2021.07.03.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:16:02 -0700 (PDT)
Date:   Sat, 3 Jul 2021 17:16:01 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix kernel-doc formatting and add missing
 documentation
Message-ID: <20210703151601.GA445417@rocinante>
References: <20210703004642.1680585-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210703004642.1680585-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This patch has been superseded by the following series:
  https://lore.kernel.org/linux-pci/20210703151306.1922450-1-kw@linux.com/T/

	Krzysztof
