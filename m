Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35738 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934886AbcJRSgd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2016 14:36:33 -0400
Received: by mail-vk0-f67.google.com with SMTP id 130so132997vkg.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2016 11:36:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161018082549.10905-1-l.stach@pengutronix.de>
References: <20161018082549.10905-1-l.stach@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Oct 2016 16:36:31 -0200
Message-ID: <CAOMZO5AG+Z8M69HyQv-QUm8HNTgi2NxyiD8ZU+j0eZF+28AoSA@mail.gmail.com>
Subject: Re: [PATCH resend] PCI: designware: fix register access before host init
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 18, 2016 at 6:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The function used to determine if iATU unroll is available will read
> a RC register. This is not possible and will result in a system hang
> if the RC is still in reset, so it is only safe to call this function
> after host_init() has been called.
>
> Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
> Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

This fixes the hang on mx6, thanks:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
