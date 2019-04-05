Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F57C4360F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1621871
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOcY6O6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDELml (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:42:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41648 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDELml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2019 07:42:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so4145477lfr.8
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2019 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM+ohr0H2VVY4IRSYQ+IFN4sfpFEMY7nzJoQiXWEhqo=;
        b=sOcY6O6mWwGZDGyZfbo4LtNSdVJ/xxtqkzR//ap5OI4Qh/HaOx4NtGwQk5nNTBXcmz
         hsfrdhtmTWu5ItcuNxxC3FTlHHWlkPqbWNBlUE2xSkCxqYkp9+XxMlLbVI2eUUULHXm/
         NR+Emmj2oKFMbA4KEhcbtUAv6BN7up91YngZeI9P4lX8a1cDeONSeWVR8cenz9QgU5Lx
         gq4k2/sEc2vGCOwvw02nlhizXZKgWOtCAm8dSF6o60qpWHARxb35K1UW3VKgFK7QQfjZ
         LAecMzVNAlc3j4fnnL+kpE3iq+PuX+ZCDAGAltAX+XZnut4Jg0xQ5hXa/QE/kVcg+nUu
         qxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM+ohr0H2VVY4IRSYQ+IFN4sfpFEMY7nzJoQiXWEhqo=;
        b=IHk+Z3yE5u8YkBH32/zvPaggFE/g87AqsKClX8kJqqG5paEzq6g7yO6KDkagfVnAo4
         +am7ZJCmOJzzNlh1kpTvwc3JPAJljevNUedu5UyoeoXmwOJHxYfcveimifODm264kzh7
         ZbVVhFicMPAlXIZnB6FUyQ4JKOWeE98zSsVuS+S3TIlCU6gX6q1wCF2Z49x+gtuSHVES
         Rqqiyer+iwh3NiNp2NQ3sHDXEo63MTNksS1Prqryg4uy0GELtwpSU22kdLJxqhN4upqD
         bYVpz9r+mFQa5qGsHDxa+Rua7uLUNaSeVoNtj8r+RT9qpUjinX9r+vwxdA+JMCe7YR4W
         VtVA==
X-Gm-Message-State: APjAAAUD4zwPWIcUrNrYAT0e7V7vnYXYNHs9wfS8fOsOtd23vJLjunBQ
        TXmoIBw2bYnBnfJTRfStAHdSntex4A2z1YdMMy4=
X-Google-Smtp-Source: APXvYqxmgCHy2puvjV/2GzBXSOu7OmAnLoBlK7wz13EQWXoJrPy+PQlT1tlD/oei5tzGJOSK1oJJMn8p1S7f1avvEds=
X-Received: by 2002:a19:6b14:: with SMTP id d20mr114623lfa.152.1554464559088;
 Fri, 05 Apr 2019 04:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190404164517.17735-1-l.stach@pengutronix.de>
 <CAOMZO5Cycm23RFM=GBME_gGXT=F_oaT-XB2P1eCz8M9T+-DEjA@mail.gmail.com> <1554453537.2748.10.camel@pengutronix.de>
In-Reply-To: <1554453537.2748.10.camel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 08:42:29 -0300
Message-ID: <CAOMZO5D03FWVpJBm9KD6O41fU77hBbjLXaSiugEL71GrNbsU6g@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Allow async probe
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,

On Fri, Apr 5, 2019 at 5:38 AM Lucas Stach <l.stach@pengutronix.de> wrote:

> This property needs to be set in the SoC specific driver that gets
> probed, we don't use pcie-designware-plat.c t all. While it isn't
> really i.MX specific, I won't go around and set it for platforms I
> can't test, as the async behavior may have some unexpected consequences
> on other platforms.

Got it. It makes sense:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
