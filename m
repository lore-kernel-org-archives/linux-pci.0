Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58506 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaFXThV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 15:37:21 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so1102140lbi.25
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 12:37:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140624153559.GA5741@dragon>
References: <20140624153559.GA5741@dragon>
Date: Tue, 24 Jun 2014 16:37:19 -0300
Message-ID: <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 24, 2014 at 12:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Lucas,
>
> I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> just fine if PCIe support is built out.  However the issue was not
> exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> is part of the cause.

I have just tested this on linux-next and I see that suspend/resume
fails even if I build a kernel without PCI support.
