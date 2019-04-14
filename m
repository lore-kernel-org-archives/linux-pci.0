Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D771C10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128A920870
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctGeg9qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDNSrn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:47:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50955 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDNSrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 14:47:43 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so8618230itk.0;
        Sun, 14 Apr 2019 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrliId4qys7aPliPHv/VO09uT34Vo15G/Z1XnAs4G2Q=;
        b=ctGeg9qElllM+Kve50DBDbfKrOdN2RvCzzFhAP995+rkQplO5wKD4gNtDI26Y1IaOA
         Na3YumlBBUqZz6erTGPtWRgxHuJfy6ki6QfxdenafvKIcYmcKjae6GVWNf+n2gNRbwuh
         3Vk4au3Ij/CqizswL+x7WQlPlcNAzm3JA5kFyBs2GPTEYl+FEL1TAUU1wR5tbjktLuTE
         BgvFX2DLhSKXkpGju45TxLmoYxKCFaPQejeBtMBZsh/Y0BzHAPFylk67VTLz8YcaQNUF
         N5mNLvMAkqsevuwFvdpsb0wv+XBsT7W683OlV5lHfBPTcA2/BAPoKsL1gmf5w96ghDA9
         NsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrliId4qys7aPliPHv/VO09uT34Vo15G/Z1XnAs4G2Q=;
        b=bUzIFiQ+TdC0zSJHpwQaJQN9fRX982cvKT0ep/tZX16SXBMU1Myj8Ij8jwVFk4nQFl
         OyhLs8QY6F/tWARiiTrzSj78W9KQgc6edBrB2Zsq5vHZ1PGOIrRAmqPh9mz/igkLzQoF
         boNJ3I6SSlWCnO6tdWvvPlDrUEXjHxaKRcMlnsOlgjCWX82XuVaFgbsBwI4ZqO5MECss
         O/iXfvqLLRnNoPMDnAMgjOgSDEhM8z98cfRcWGcTVchLGmQcpkfBeTKKarOqV7agdh4c
         /IOqKNJ8IloKquJhyZt/BGabxARD7/ZktrBWcxHQ202ViBLQzsN86tFelHHb0E0bNcDR
         Pm4Q==
X-Gm-Message-State: APjAAAUZ15p1KEcOxTjllTEo0IUR/uo2S17qwOSiMRfq7Koc6/00aUzx
        d2o00J1sq/bzlcYnaYrVXV83hNroD2JFizVTjmQ=
X-Google-Smtp-Source: APXvYqwv6W/Nev0eKA2pqyffWiAEEv/n4tbznWHtCPF04chRD+tGMjUOCAWgCRxBTDaZCwCTkrOFohpFY4EmxM7LMsQ=
X-Received: by 2002:a24:4702:: with SMTP id t2mr20773143itb.105.1555267662309;
 Sun, 14 Apr 2019 11:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
 <20190401042547.14067-3-andrew.smirnov@gmail.com> <1555084415.11529.29.camel@pengutronix.de>
In-Reply-To: <1555084415.11529.29.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 14 Apr 2019 11:47:31 -0700
Message-ID: <CAHQ1cqGHic4Osyzy9jtPc_7tPqEanmSVJo8n-NAV0uzcpJbxqA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] PCI: imx6: Remove redundant debug tracing
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 8:53 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> > All calls to imx6_pcie_wait_for_link() share the same error path and
> > the state of PHY debug registers will already be printed there.
>
> With this change we can drop imx6_pcie_wait_for_link altogether, as
> it's now just wrapper around dw_pcie_wait_for_link that pulls out the
> dw_pcie struct from imx6_pcie. Both callers have dw_pcie already
> available, so there is no point in keeping this function.
>

Good point, will do.

Thanks,
Andrey Smirnov
