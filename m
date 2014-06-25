Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:41457 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbaFYKut (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 06:50:49 -0400
Received: by mail-la0-f52.google.com with SMTP id ty20so612438lab.11
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2014 03:50:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140625062243.GD3242@dragon>
References: <20140624153559.GA5741@dragon>
	<CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
	<20140625062243.GD3242@dragon>
Date: Wed, 25 Jun 2014 07:50:47 -0300
Message-ID: <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
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

On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> should be another issue.

Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
driver removed.
