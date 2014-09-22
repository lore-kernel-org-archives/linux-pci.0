Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:41980 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbaIVOIT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 10:08:19 -0400
Received: by mail-lb0-f169.google.com with SMTP id b12so6885182lbj.28
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 07:08:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1411392758.2599.9.camel@pengutronix.de>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	<1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	<20140814202248.GA2071@google.com>
	<1409743007.1535.1.camel@pengutronix.de>
	<20140904202436.GA17125@google.com>
	<CAOMZO5AAZXVRu3WkKkU=5SM+t8CYBww+Jmqyz5UFYsdog479wA@mail.gmail.com>
	<1411392758.2599.9.camel@pengutronix.de>
Date: Mon, 22 Sep 2014 11:08:17 -0300
Message-ID: <CAOMZO5B8Kn_v4Q97QWYE5Pf-1vmCR76B62ew7mr__ZjPw-euZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Mon, Sep 22, 2014 at 10:32 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> I see this commit in -next for some time now. It changed subject tho, so
> look out for a patch called "PCI: imx6: Put LTSSM in "Detect" state
> before disabling it".

Yes, sorry.

I replied in the wrong thread.

The one I don't see in -next is Tim Harvey's patch:
https://patchwork.ozlabs.org/patch/378077/

Regards,

Fabio Estevam
