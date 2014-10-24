Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:54731 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbaJXP4t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Oct 2014 11:56:49 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so3072577lbd.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2014 08:56:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414154737.6267.8.camel@pengutronix.de>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
	<1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
	<CAOMZO5CE=gDUTHQW7h1nDv_H+1iakPAatZ8Pzr=dqHxFZChTeA@mail.gmail.com>
	<1414154737.6267.8.camel@pengutronix.de>
Date: Fri, 24 Oct 2014 13:56:47 -0200
Message-ID: <CAOMZO5Aet_wiqRvK8Uk64ATWUe-AR5E4f=3nvQ0pC0NKuF1agQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <richard.zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Tim Harvey <tharvey@gateworks.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Richard Zhu <r65037@freescale.com>,
	Eric Nelson <eric.nelson@boundarydevices.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 24, 2014 at 10:45 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> Given that the moving of the usleep didn't cause any ill effects I'm
> pretty confident that the additional 10us will not break thing.
>
> As this short sleep is certainly needed on some platforms it will get
> added eventually anyways, so I'm fine with having it in this patch.

Ok, but my point is that a Tested-by tag should not be added if a new
patch is resent with modifications, and only the previous version was
actually tested.
