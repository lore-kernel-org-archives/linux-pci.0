Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33619 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbcC1WIJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2016 18:08:09 -0400
Received: by mail-ob0-f174.google.com with SMTP id x3so41290850obt.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2016 15:08:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459126196-15063-1-git-send-email-festevam@gmail.com>
References: <1459126196-15063-1-git-send-email-festevam@gmail.com>
Date: Mon, 28 Mar 2016 15:08:08 -0700
Message-ID: <CAJ+vNU3kDtaHtmP2AZxuLdHKVmB_XVc3OuuzqPdVdO5M91ggSg@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 27, 2016 at 5:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
> has the following issues:
>

Hi Fabio,

I agree with reverting this - this patch does break PCI for all the
Gateworks Ventana boards.

It's Gateworks 'Ventana' here that uses IMX6 PCI, not Laguna so your
comment is wrong. Also, Ventana boards 'do' have their PCI reset
properly defined as active-low so we probably shouldn't refer to
Gateworks Ventana having gpio polarity not specified in the
device-tree.

It is the fact that the gpio polarity has the wrong logic level in
that patch which breaks things. I think your second point is really
the problem that needs to be mentioned for the reason of the revert.

Other than that you can add a 'Tested-by: Tim Harvey
<tharvey@gateworks.com>' in reference to Gateworks Ventana PCI.

Thanks,

Tim
