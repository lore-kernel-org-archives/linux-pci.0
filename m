Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34582 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760610AbcDEWHK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 18:07:10 -0400
MIME-Version: 1.0
In-Reply-To: <20160405213117.GD15353@localhost>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<20160405213117.GD15353@localhost>
Date: Tue, 5 Apr 2016 19:07:04 -0300
Message-ID: <CAOMZO5D4PpxSD6oc8MehYBFPu+Bz-7pEQheKxNkXnEtvK-f2eg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 5, 2016 at 6:31 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Applied with acks from Tim and Lucas to for-linus for v4.6, thanks!
>
> If I understand correctly, the revert fixes Gateworks Ventana, but
> breaks Toradex Apalis Ixora.  It would be really nice to get Petr's
> patches to fix that system in at the same time.  Looks like we just
> need a minor documentation update there?

Yes, that's correct.
