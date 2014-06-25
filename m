Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53773 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbaFYKwv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 06:52:51 -0400
Message-ID: <1403693452.4249.1.camel@weser.hi.pengutronix.de>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 25 Jun 2014 12:50:52 +0200
In-Reply-To: <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
References: <20140624153559.GA5741@dragon>
	 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
	 <20140625062243.GD3242@dragon>
	 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 25.06.2014, 07:50 -0300 schrieb Fabio Estevam:
> On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> > should be another issue.
> 
> Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
> driver removed.

Can you please send me a dmesg from a working boot?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

