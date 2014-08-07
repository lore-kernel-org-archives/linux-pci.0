Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:61239 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbaHGCcw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 22:32:52 -0400
MIME-Version: 1.0
In-Reply-To: <20140807021246.GL2167@dragon>
References: <1407356079-28908-1-git-send-email-festevam@gmail.com>
	<20140807021246.GL2167@dragon>
Date: Wed, 6 Aug 2014 23:32:49 -0300
Message-ID: <CAOMZO5AEjPmW6xSeTn6WBc9SMMeKed+NJZDE3oDV0bb6bVNSPg@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix boot hang when link already enabled
From: Fabio Estevam <festevam@gmail.com>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	=?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 6, 2014 at 11:12 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> I believe Lucas already had a new version of his patch.
>
> http://thread.gmane.org/gmane.linux.kernel.pci/33712/focus=33711

Ok, I wasn't aware of the updated version.
