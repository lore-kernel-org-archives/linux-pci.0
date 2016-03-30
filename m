Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37923 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbcC3NZI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:25:08 -0400
MIME-Version: 1.0
In-Reply-To: <1459344050.2565.41.camel@pengutronix.de>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	<20160330122103.GN20367@ibawizard.net>
	<CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	<20160330130002.GA13529@ibawizard.net>
	<CAOMZO5BNteOTj+m3h6y83wa25yqz7pb3c1osJbxrea+8B=se3Q@mail.gmail.com>
	<20160330131639.GO20367@ibawizard.net>
	<1459344050.2565.41.camel@pengutronix.de>
Date: Wed, 30 Mar 2016 10:25:06 -0300
Message-ID: <CAOMZO5D5dN58iiqMb3oa4+GDE4JQEjz7dRd=+Fr2EtMriYXaVw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Wed, Mar 30, 2016 at 10:20 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> We can and should fix broken DTs, but keeping DT stability means we need
> to be able to support old (unfixed) DTs with future kernels.
>
> So we can not just fix the DTs and move on, as kernel and DT are two
> separate entities, even if they are currently distributed through the
> same source tree.

Correct.

Could you send your Acked-by for this patch then?
