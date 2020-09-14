Return-Path: <SRS0=ryE9=CX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348EAC433E2
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED83121974
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 16:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0tBg5CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgINPbu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINPbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 11:31:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2BEC06174A;
        Mon, 14 Sep 2020 08:31:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i1so17503edv.2;
        Mon, 14 Sep 2020 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fLNb41VIkD/RuPBy33egUq3B1KbchS1GHIy2wAcNoFg=;
        b=d0tBg5CSotliTfnKU7Ilv5nD9qZmOmvj/sU2Ziv6THacAnNAFTW90Yu2SPIxroUKsV
         xrmiUPNCSlyl3aS/OnAPZLAxu0/xuDAcixMjklz/Zrg9fu+RzNHWNFCCDDmRV9jPExea
         EyTMhntUbksZ0nXC2jqaVEeNjXq/LcWt0oZy4H/4LLABUKEBm15YPRUshQarzoAzB4ZO
         2RUhIwMFPfuM7dHoPvA8v/G6CLw9kdLaWm3xbA+CAXO7WNT4W7Wd4QEF+utG86NZbIbL
         YurdpOElqlpSsf5ChLfltUGYueNj2XYA+YtnRMEU/+e+jAYqUtR5LXlCJ6NO9gB8c7l7
         mz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fLNb41VIkD/RuPBy33egUq3B1KbchS1GHIy2wAcNoFg=;
        b=ScJYXKki9eyOvICr+OZpYSAY30lrnzbS7YJqxzMwbT+ra38FE8tfAu3ABX3yXmaoLv
         33V52M8GIVV69btltyorNBjDWwfNeA950e1lzNmKYsmZdPa3Jlfz+bsdyvxp2l5K1CPM
         d4qnQSOyf/xxPJY1da2nMwICEfyranOoR6PkChPyEINV3pasW3+j30XLyIZScnRLR4ES
         Om5Lk2pnnKaZyKoW54n98Y3IjW0z6g+rX6Dgu/IRmNvBxRF/KC1Ik8XnAoizEp6G2LTz
         KupCCP0aQ8DlkeOr4zU2YOzRgbcOD5sn9IVHQccDshLH9haNAkDtaUwdgG1kcxeUAzth
         OdSQ==
X-Gm-Message-State: AOAM532aMTGAXY3C5RQH4y1KD9U35/lSzczxCtc5Khv4jvi/Ab4fLCga
        THXSswbzQZMgNVa/bA7nTvk=
X-Google-Smtp-Source: ABdhPJwRC+BDZn+93nSISeCmb/4S7FDAVbfdIR/fBXtuiCtf3Xc9d5JcoVVQV7/DqrSLMq3Wh4zs0g==
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr17354077edv.302.1600097500699;
        Mon, 14 Sep 2020 08:31:40 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id bo8sm9559422edb.39.2020.09.14.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:31:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 17:31:38 +0200 (CEST)
X-X-Sender: lukas@felia
To:     David Woodhouse <dwmw2@infradead.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks
 consistent
In-Reply-To: <bc5ba52bb0c123d0ed038e5dce9474f27ac2f750.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.2009141731030.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com> <alpine.DEB.2.21.2009141208200.17999@felia> <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com> <alpine.DEB.2.21.2009141552570.17999@felia>
 <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org> <alpine.DEB.2.21.2009141615020.17999@felia> <f511570405799df421397ff65847e927745dad08.camel@infradead.org> <alpine.DEB.2.21.2009141717470.17999@felia>
 <bc5ba52bb0c123d0ed038e5dce9474f27ac2f750.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 14 Sep 2020, David Woodhouse wrote:

> On Mon, 2020-09-14 at 17:23 +0200, Lukas Bulwahn wrote:
> > >  # /usr/lib/mailman/bin/config_list -o- linux-mediatek | grep -B5 ^generic_nonmember_action
> > > # legal values are:
> > > #    0 = "Accept"
> > > #    1 = "Hold"
> > > #    2 = "Reject"
> > > #    3 = "Discard"
> > > generic_nonmember_action = 0
> >
> > David, I guess if you have access to the ground truth on 
> > lists.infradead.org, maybe you can dump the actual setting for all those 
> > lists?
> 
> ath10k:generic_nonmember_action = 0
> ath11k:generic_nonmember_action = 0
> b43-dev:generic_nonmember_action = 0
> kexec:generic_nonmember_action = 0
> libertas-dev:generic_nonmember_action = 0
> linux-afs:generic_nonmember_action = 0
> linux-amlogic:generic_nonmember_action = 0
> linux-arm-kernel:generic_nonmember_action = 0
> linux-geode:generic_nonmember_action = 1
> linux-i3c:generic_nonmember_action = 1
> linux-mediatek:generic_nonmember_action = 0
> linux-mtd:generic_nonmember_action = 0
> linux-nvme:generic_nonmember_action = 0
> linux-parport:generic_nonmember_action = 1
> linux-realtek-soc:generic_nonmember_action = 1
> linux-riscv:generic_nonmember_action = 0
> linux-rockchip:generic_nonmember_action = 0
> linux-rpi-kernel:generic_nonmember_action = 0
> linux-snps-arc:generic_nonmember_action = 0
> linux-um:generic_nonmember_action = 0
> linux-unisoc:generic_nonmember_action = 1
> wcn36xx:generic_nonmember_action = 0
> 

Thanks, I will provide a suitable patch for MAINTAINERS.

Lukas
