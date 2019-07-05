Return-Path: <SRS0=x2S0=VC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD89C4649E
	for <linux-pci@archiver.kernel.org>; Fri,  5 Jul 2019 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F8E216E3
	for <linux-pci@archiver.kernel.org>; Fri,  5 Jul 2019 15:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww5ZLvjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGEPzx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:55:53 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33866 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEPzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2019 11:55:53 -0400
Received: by mail-lj1-f181.google.com with SMTP id p17so9749978ljg.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2019 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKwXT1RcHz5I4xSzSc1iUYKDnYA91eojCR/XtAaZCRo=;
        b=Ww5ZLvjzGhi087k9VMxrLXjE9B7dMRxt8tE5LV5hfq0NTuyThIF1aJIKIRrX4BKCbe
         qfB2wM3mCkepbrPIpOHURy8tuMnU68N5EpJSqK6ZOfrK/qQ5HWbetLC6prZTrBAfkfjZ
         45oylQPvzVHDusg2V3OCr2ksznWMH0XpNEVcEA2OVrwcKgU/6qXP7UjDB30X1Jn5QUQQ
         V0YXyGJqHZTLuhYFFmXhQHNHE4YKX3hieSSAC664K2VubLJMMVsJ7He6iWMw991UeKOu
         z5UucPBc8+rnAhcjXvKnyWD4WHq7R8rMXRScgRNwXWIVAD6dc1erOHXYfb5hoNz5ydEC
         3LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKwXT1RcHz5I4xSzSc1iUYKDnYA91eojCR/XtAaZCRo=;
        b=WJPHFJp9gR4Z8cyUWN87TVyi9l7LEawyeC2nsq4wRU9mib7u7gHI9rOgCyldw+1daV
         X+rvJFpfRmfGMHHV5U4UpW12Y36XkiClnM0Tn5jElnryKVD90lO9GAOBi+fZCthWjAfs
         UjBEa8CophEpWB1W5h+8CpOXiGrqd2fk3mWT0bvOW9a/jvqJgDGuK2W1b6VcopMnXA9g
         w8/RSiloW6xzLFVHrLD/shHEvbo0q3t0WKZhJYDu7vxE0vRvzP2AqGkn98dFTxjjrYvk
         cpJ5Cz9MMKnglryaBL+e/z+H681iA90bnNLQ21pK36Sfpday1J6Gae4pjAeJsoptEDrq
         xfKw==
X-Gm-Message-State: APjAAAVU7F5gl9ihyS5XF/mQ8mr6vqUY4hsfnXLDea2+VIQqq3FOTqcj
        K4PdB7FLBQd+518+yM3ljc9+FDtV+qJCe6orSvs=
X-Google-Smtp-Source: APXvYqzFJXnW2tp0ZRsv4pA0nzG7k/onYXdRXh0u88dfA+uAmwEitXltGSENSsiu0T3kvlu1pVxreCA9KI6c9L79Ip4=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr2551457lje.214.1562342150110;
 Fri, 05 Jul 2019 08:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190630205307.27360-1-marex@denx.de> <1562073505.2321.3.camel@pengutronix.de>
 <20190705153314.GB6284@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190705153314.GB6284@e121166-lin.cambridge.arm.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Jul 2019 12:55:40 -0300
Message-ID: <CAOMZO5BFqyqzPc31eSc7oZ=B8cntTvVPjn-jvFgPmA3xMGmxBg@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx: Allow iMX PCIe driver on iMX6SX
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Fri, Jul 5, 2019 at 12:34 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> If so can you ACK it
>
> https://patchwork.ozlabs.org/patch/1054789/
>
> please ? At the same time, I will drop this patch from the PCI queue.

Lucas has already acked the patch from the patchwork link you shared.
