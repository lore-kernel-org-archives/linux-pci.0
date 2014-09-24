Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:50687 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaIXVMn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 17:12:43 -0400
MIME-Version: 1.0
In-Reply-To: <d61b12831f97408badd1850d6a8782b1@BY1PR0301MB0855.namprd03.prod.outlook.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
	<1411382705-15301-5-git-send-email-r65037@freescale.com>
	<CAOMZO5D_s7ST_J0FV+NbrHpw2jVBDSpHprHnwJfPbQ=tqy7PWQ@mail.gmail.com>
	<8f7c463a0c7c4bd2a4a4416bd8b046b3@DM2PR0301MB0862.namprd03.prod.outlook.com>
	<CAOMZO5BQQdVvyh56dO6CWJF23NN17hgsEEeBBzruhjV4FpSyXQ@mail.gmail.com>
	<d61b12831f97408badd1850d6a8782b1@BY1PR0301MB0855.namprd03.prod.outlook.com>
Date: Wed, 24 Sep 2014 18:12:41 -0300
Message-ID: <CAOMZO5ADM1ig6=+TiQJJVkBMSK6qW_Vf7vYsnW_KKoGcFtmxJg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] PCI: imx6: add imx6sx pcie support
From: Fabio Estevam <festevam@gmail.com>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 11:55 PM, Hong-Xing.Zhu@freescale.com
<Hong-Xing.Zhu@freescale.com> wrote:

>> What about the existing mx6q silicon version? How can we fix the hang?
> [Richard] There is already one SW workaround(toggle the TEST_PD bit in arch/arm/mach-imx/pm.c) for this issue.
> It can workaround this issue, although we don't get guarantee from design team.

This workaround is available in the FSL kernel. However, I am
interested in a solution for the mainline kernel.
