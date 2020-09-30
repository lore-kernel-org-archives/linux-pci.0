Return-Path: <SRS0=vfl7=DH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB82C4727E
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8843E20789
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601470142;
	bh=YZ7UzTMYVJZe+LHRVd/RhUo0ji/OxfI8bOpxqXHrkws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CY0dVb5BvDCCAGnCWL1b/px7+L/PhiqAd1Y9L4nZfGuyhG7BaM2G5bGtwysocwJ2M
	 IItdMjiDpR6cpIKR6zm8JmoM3MpfRpyCgrH7l+Ptk54mgfT2m7bJ8LlJ5ksm0gnKI7
	 5QNIRYrobOQfQvP+AxzyBIbuacO6i+wj70oTjg7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgI3MtC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3MtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 08:49:01 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE2A20B1F;
        Wed, 30 Sep 2020 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601470141;
        bh=YZ7UzTMYVJZe+LHRVd/RhUo0ji/OxfI8bOpxqXHrkws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZeOpA6b8YK9mvEWlauu3yF2dpSEiJTn3PZjywcKFUQagW8hau9cCGU28okY4sOWO7
         MRilDU+kWnIB2LVznJZ+6KZDGmbFlagXkWjzSDe1wpb1WCFPCw7OIPQMTuOZN27c41
         2GB8/hZySair6RDdSjhQZdRQ8Ppf8pQptIoicGh4=
Received: by mail-ot1-f43.google.com with SMTP id s66so1681875otb.2;
        Wed, 30 Sep 2020 05:49:01 -0700 (PDT)
X-Gm-Message-State: AOAM530W54IfhMHmH0WPd+1M57YttEVZ+W1VM/saotZFJ5J4uXHZX2MJ
        fcdIlIVM8K63scmqM/ouzQhNFlcbMko74i1ySw==
X-Google-Smtp-Source: ABdhPJxKUwgnUO4UqAew6bcpi9uqHMt3XuJNvM5Dm4iHTs5wtT0XXtw6b/KaolL9/XamDNNhFufr3KvUXDVYhbxdvb0=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1497526otp.129.1601470140827;
 Wed, 30 Sep 2020 05:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com> <1601444167-11316-3-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1601444167-11316-3-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 30 Sep 2020 07:48:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJPx3jUHEo+W_1za3u4LvvBgO8v1C=Zb=WzG-F8SSJHYA@mail.gmail.com>
Message-ID: <CAL_JsqJPx3jUHEo+W_1za3u4LvvBgO8v1C=Zb=WzG-F8SSJHYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: uniphier-ep: Add iATU register description
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 12:36 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> In the dt-bindings, "atu" reg-names is required to get the register space
> for iATU in Synopsis DWC version 4.80 or later.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml     | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
