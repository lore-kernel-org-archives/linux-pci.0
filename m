Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36667 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbaHHP7Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 11:59:25 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so3988036lbd.14
        for <linux-pci@vger.kernel.org>; Fri, 08 Aug 2014 08:59:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Date: Fri, 8 Aug 2014 12:59:23 -0300
Message-ID: <CAOMZO5A+++cABSKFZR8-NUeNw1sASr_32Odymdp=JDXGGSJoNg@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
From: Fabio Estevam <festevam@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 8, 2014 at 3:36 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
> for SS function) must remain deasserted until the reference clock is running
> at the appropriate frequency.
>
> Without this patch we find a high link failure rate (>5%) on certain
> IMX6 boards at various temperatures.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Thanks, Tim.

Marek,

Does this fix the PCI linkup failures you reported earlier?

Regards,

Fabio Estevam
