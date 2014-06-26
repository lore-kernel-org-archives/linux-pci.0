Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:49736 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbaFZLng (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 07:43:36 -0400
Received: by mail-la0-f54.google.com with SMTP id mc6so1791155lab.27
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2014 04:43:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201406260932.30524.jbe@pengutronix.de>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
	<20140626031247.GN2224@dragon>
	<CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
	<201406260932.30524.jbe@pengutronix.de>
Date: Thu, 26 Jun 2014 08:43:34 -0300
Message-ID: <CAOMZO5CJmORit5-rqkARYHtc95NKMRDf4yMFeTswr9KoxKyrwQ@mail.gmail.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
From: Fabio Estevam <festevam@gmail.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	=?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Juergen,

On Thu, Jun 26, 2014 at 4:32 AM, Juergen Borleis <jbe@pengutronix.de> wrote:
> Hi Fabio,
>
> On Thursday 26 June 2014 05:43:19 Fabio Estevam wrote:
>> [...]
>> Below is the log with linux-next kernel and earlyprintk enabled:
>
> Does it also hang when you disable "earlyprintk"? A few weeks ago we had a
> similar issue with i.MX6/PCI and "earlyprintk" (at the end it was caused by a
> clock change for the UART when changing from the early to the regular
> console).

Yes, it also hangs without earlyprintk.

Regards,

Fabio Estevam
