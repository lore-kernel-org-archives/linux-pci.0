Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbdL0AEd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Dec 2017 19:04:33 -0500
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97A22191C
        for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2017 00:04:32 +0000 (UTC)
Received: by mail-qk0-f177.google.com with SMTP id v188so17477264qkh.11
        for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2017 16:04:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514321395-13025-1-git-send-email-festevam@gmail.com>
References: <1514321395-13025-1-git-send-email-festevam@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 26 Dec 2017 18:04:11 -0600
Message-ID: <CAL_JsqK_10hiSJ57G=LXawRdLRp=23sWF=Japb7aP7YYp7Xx1w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx6q-pcie: Add required property for i.MX6SX
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 26, 2017 at 2:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> i.MX6SX needs a PCI 'power-domains' entry, so add it to its required
> properties section.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> The i.MX6SX PCI power domain patches have been accepted by the ARM
> maintainer:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt&id=1f1b7ec6714e08c9ab4243146ff8b572a25d1837
>
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/drivers&id=cfabb7921ccbede2968e5049d433ba3d0e0950af
>
> and they will land into 4.16.
>
> It would be nice if this dt-bindings update could also reach 4.16.

Shawn should have taken this with the rest of the series.

Applied. Next time, please send to DT list.

Rob
