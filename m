Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38858 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbcCOOKr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 10:10:47 -0400
Received: by mail-ig0-f182.google.com with SMTP id ig19so16361352igb.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2016 07:10:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56E7ED1E.3070506@tekno-soft.it>
References: <56D5E3DF.9030906@tekno-soft.it>
	<56D71F27.7070708@tekno-soft.it>
	<20160302195634.GA19223@localhost>
	<DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D80435.90408@tekno-soft.it>
	<DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D8180A.1050708@tekno-soft.it>
	<56D84B6D.1050800@tekno-soft.it>
	<56D883AD.5060601@tekno-soft.it>
	<56DEE426.8030902@tekno-soft.it>
	<1457448829.3207.22.camel@pengutronix.de>
	<56E1B04A.9010206@tekno-soft.it>
	<56E679FE.20409@tekno-soft.it>
	<56E7ED1E.3070506@tekno-soft.it>
Date: Tue, 15 Mar 2016 11:10:46 -0300
Message-ID: <CAOMZO5C9H92mMqTPiOwMYhywBCyQuXQen3Vw==ELE-ppTtogqg@mail.gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Fabio Estevam <festevam@gmail.com>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 8:08 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:

> Just to say that I've fixed the problem by asserting PERST before to drop PCIe refclk and enable
> power down. PERST is finally released at the usual place.

Excellent! Do you plan to submit a patch to fix this issue?
