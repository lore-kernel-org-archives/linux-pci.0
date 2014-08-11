Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34964 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbaHKQRz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 12:17:55 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so6797005lab.6
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 09:17:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Date: Mon, 11 Aug 2014 13:17:53 -0300
Message-ID: <CAOMZO5DGLDHetfOf8AUjcHAAbpNfyMpdMRN+JpJVTxR86Kn3Xw@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
From: Fabio Estevam <festevam@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>
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

Thanks for the patch, Tim:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
