Return-Path: <SRS0=kfIp=BG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13AC4345C
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67CB20729
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595866718;
	bh=VbSJ7we7F7x94gn8MtdIpC00p71t6I2a2U/7FXBvqOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pUyWG1/bArx61q0Ay44a+cxtgvvK+KatBk+cf+d0EGNyN5lgXWEUS5wkTXgvO0r/Y
	 /UdivE4/SDyjSwHvG1cfzWEJvd6Q6+FABIDhvz5Ua4z8OiU/Y6tXTsnPMmF/qLGuuz
	 24jbTIpAfds1rQ7uJefmtEyf0yNF+O0df1bdhcm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgG0QSH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgG0QSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 12:18:06 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D45521883;
        Mon, 27 Jul 2020 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595866685;
        bh=VbSJ7we7F7x94gn8MtdIpC00p71t6I2a2U/7FXBvqOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zUq77H9YvtsQbDTgUzIyNOCY0Miln5H0R0NhefZ4bn+WVZIhEW7jIHCBHVO5iDpi4
         /W+NsrMgHCXEmr1Ii7czPaUeyGKh/tFcSHOePe4cDk6bEgv0LMfRupVV9gB4Mi5hWf
         rS7iHGwkSeOQlsouLNGafySTjpksGOi7xaLM6Gyk=
Received: by mail-oo1-f49.google.com with SMTP id z10so377631ooi.10;
        Mon, 27 Jul 2020 09:18:05 -0700 (PDT)
X-Gm-Message-State: AOAM530J4PfQ5LAXjSxKGXlHnXQMCcdPYtY43y/Hfk9mr426SHkC/Xv0
        revu9E0E1kwvioGg07DivcTUoQI4zVmdR9N3fQ==
X-Google-Smtp-Source: ABdhPJxy2HNX2qe5qurpCuCASaH673vpWzF1fqD8RgM/pdLjw54HcFjl1uO6DNZz6SeGELq82YXp3iMU27l37r6AOz4=
X-Received: by 2002:a4a:ae07:: with SMTP id z7mr20031067oom.25.1595866684651;
 Mon, 27 Jul 2020 09:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
In-Reply-To: <20200623145528.1658337-1-thierry.reding@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jul 2020 10:17:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzcx5R+FvoOJwRboDx-FWoiGa_8_q8-eSc=AG_fOz=HA@mail.gmail.com>
Message-ID: <CAL_JsqLzcx5R+FvoOJwRboDx-FWoiGa_8_q8-eSc=AG_fOz=HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: tegra: Remove PLL power supplies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 8:55 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The XUSB pad controller, which provides access to various USB, PCI and
> SATA pads (or PHYs), needs to bring up the PLLs associated with these
> pads. In order to properly do so, it needs to control the power supplied
> to these PLLs.
>
> Remove the PLL power supplies from the PCIe controller because it does
> not need direct access to them. Instead it will only use the configured
> pads provided by the XUSB pad controller.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi Rob,
>
> I already made this change as part of the conversion series, but wanted
> to send this out as part of this subseries since it addresses a fairly
> long-standing issue that I'd like to clean up irrespective of the DT
> binding conversion. Since it looks like the conversion series will take
> a bit longer, I think it makes sense to send this out separately.
>
> Thierry
>
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt  | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
