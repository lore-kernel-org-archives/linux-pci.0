Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35909 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbcCHPCH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2016 10:02:07 -0500
Received: by mail-io0-f181.google.com with SMTP id z76so28867567iof.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Mar 2016 07:02:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456997527.3772.37.camel@pengutronix.de>
References: <56D5E3DF.9030906@tekno-soft.it>
	<1456997527.3772.37.camel@pengutronix.de>
Date: Tue, 8 Mar 2016 12:02:06 -0300
Message-ID: <CAOMZO5A4bP34weVAvz5ZiUszNu3gLqAo7yocWaG9H-3FFe+kyw@mail.gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Roberto Fichera <kernel@tekno-soft.it>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 3, 2016 at 6:32 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> Is this a regression from earlier kernel versions?
>
> If so, can you please revert 5c5fb40de8f14 (PCI: imx6: Add support for
> active-low reset GPIO) and see if this helps?

This commit has been applied to 4.5-rc1. Roberto is using 4.4.x.
