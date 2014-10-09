Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:43545 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbaJIBLY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Oct 2014 21:11:24 -0400
MIME-Version: 1.0
In-Reply-To: <f11b939d2a1f4d6f823bc36d55eb3d09@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
	<1412069804-17162-11-git-send-email-r65037@freescale.com>
	<CAOMZO5A3Bdxdspc_UnJcQ-DVrmUXQCKW0W08msnDs7TELzXEJg@mail.gmail.com>
	<28E9FA64-81D5-42C2-ABCA-8B72239EC6AA@freescale.com>
	<f11b939d2a1f4d6f823bc36d55eb3d09@DM2PR0301MB0862.namprd03.prod.outlook.com>
Date: Wed, 8 Oct 2014 22:11:22 -0300
Message-ID: <CAOMZO5DUkM=ao5Fa-DZEjMDNrQJ2rAaBLxuCDjQFNBfTT89eCA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] ARM: imx6sx: enable pcie on imx6sx sdb board
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

On Wed, Oct 8, 2014 at 3:41 AM, Hong-Xing.Zhu@freescale.com
<Hong-Xing.Zhu@freescale.com> wrote:

> This hunk is wrong. There is no "power-on-gpio" in the binding anymore.
> Also there is already a change in Shawns tree to model this as a always-on regulator. If we really want to control pci bus power this needs to be done through this regulator, not some arbitrary gpio hack.

Yes, I never asked you to include 'power-on-gpio'. What needs to be
done is the same as in imx6qdl-sabresd, which passes the regulator
that powers the PCI slot. You can refer to Shawn's tree or linux-next.
