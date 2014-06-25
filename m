Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:46328
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751755AbaFYGWy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jun 2014 02:22:54 -0400
Date: Wed, 25 Jun 2014 14:22:44 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
CC: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140625062243.GD3242@dragon>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 24, 2014 at 04:37:19PM -0300, Fabio Estevam wrote:
> On Tue, Jun 24, 2014 at 12:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Lucas,
> >
> > I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> > just fine if PCIe support is built out.  However the issue was not
> > exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> > is part of the cause.
> 
> I have just tested this on linux-next and I see that suspend/resume
> fails even if I build a kernel without PCI support.

Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
should be another issue.

Shawn
