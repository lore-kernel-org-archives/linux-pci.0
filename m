Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE1C4360F
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5C32184C
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 08:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfCNIKZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:10:25 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33986 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNIKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 04:10:25 -0400
Received: by mail-ua1-f67.google.com with SMTP id a42so1619130uad.1;
        Thu, 14 Mar 2019 01:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJnCbhVRzn6ZVCVZJ9q4XRN92IY5Me+bA8niol+IEJw=;
        b=RaZ4GRmvLh6DiACqoNMO/ygykrAY1fyCC+28VCLrq4os8yBeQko6f3AWZTuZx552Oa
         i4CYOKPGayI7g2n/jzioO0pe+AUGXdMhhjB2UjVeLb4ZavUMw73YS7tAe3xlog6gALHx
         S0Vr16i6MrHlKk23QxaWwQiBjPRVFedbeBY6nLymzZjQmiDN9ZEv2PuO8wg3OC2gS1K8
         kkltpl3+bjjeXqRivCbjgd6WZZucuQS8TAn2i3U0qssaLCRldO0S7uGRUAKzopUySoFO
         eOhnUYpJy6GYniNSf7NUkC5r9RlvCCWlji7ABp7rEnWY3BpYy1bvQEb00XG75MDKBDB3
         kmGQ==
X-Gm-Message-State: APjAAAXvUhG+/7xwb27jIGMZRKEgNLKkmRxVOIU8pHBfzxUlU7GV5zAC
        5BPDxAdInqLFwWJr3Dka59sA8WmjvDaoV+tUcIxrZBin
X-Google-Smtp-Source: APXvYqyO+55CM/r2CD2bNozfBtl1A92yLtJ7WjwICQfumUz6iq7YqSDOu2gc/mUQjprMdV82tpIyl8i+CHMeDtTzvDQ=
X-Received: by 2002:a9f:2f0b:: with SMTP id x11mr24069123uaj.78.1552551024158;
 Thu, 14 Mar 2019 01:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVJENz5wnOV=TX5cVdTsOZD25SwprSLpetZpAsMcPtvEA@mail.gmail.com>
 <20190314080741.31983-1-kjlu@umn.edu>
In-Reply-To: <20190314080741.31983-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 09:10:12 +0100
Message-ID: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
Subject: Re: [PATCH v2] pci: pcie-rcar: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 14, 2019 at 9:08 AM Kangjie Lu <kjlu@umn.edu> wrote:
> In case __get_free_pages fails and returns NULL, the fix returns
> -ENOMEM and releases resources to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Please keep my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
