Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:64672 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbaIXVEF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 17:04:05 -0400
MIME-Version: 1.0
In-Reply-To: <f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
	<CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
	<f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
Date: Wed, 24 Sep 2014 18:04:03 -0300
Message-ID: <CAOMZO5CKZce3AZfm79DVGShx7bY6DJ3YvSC7q9MYx5v+Zwve5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
From: Fabio Estevam <festevam@gmail.com>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Tue, Sep 23, 2014 at 11:54 PM, Hong-Xing.Zhu@freescale.com
<Hong-Xing.Zhu@freescale.com> wrote:

> [Richard] 6qdl sabreauto boards don't have the pcie reset gpio in the board design at all.

I have just downloaded the mx6 sabreauto board schematics from
freescale.com and it matches the one I have seen before.

You can search for the CPU_PER_RST_B signal. It is connected via R785
0 ohm resistor to PCIE_RST_B.

CPU_PER_RST_B can be controlled via MAX7310 pin IO/2.
