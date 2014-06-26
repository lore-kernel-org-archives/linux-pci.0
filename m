Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35030 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbaFZHc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 03:32:57 -0400
From: Juergen Borleis <jbe@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Date: Thu, 26 Jun 2014 09:32:30 +0200
Cc: Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	Marek =?utf-8?q?Va=C5=A1ut?= <marex@denx.de>,
	"David =?utf-8?q?M=C3=BCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com> <20140626031247.GN2224@dragon> <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
In-Reply-To: <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201406260932.30524.jbe@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

On Thursday 26 June 2014 05:43:19 Fabio Estevam wrote:
> [...]
> Below is the log with linux-next kernel and earlyprintk enabled:

Does it also hang when you disable "earlyprintk"? A few weeks ago we had a 
similar issue with i.MX6/PCI and "earlyprintk" (at the end it was caused by a 
clock change for the UART when changing from the early to the regular 
console).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Borleis             |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
