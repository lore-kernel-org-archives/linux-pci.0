Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34187 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbcBVAkj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 21 Feb 2016 19:40:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id b205so15956109wmb.1
        for <linux-pci@vger.kernel.org>; Sun, 21 Feb 2016 16:40:38 -0800 (PST)
Message-ID: <1456101636.2176.4.camel@googlemail.com>
Subject: Re: [PATCH v2 2/2] PCI: imx6: add initial imx6sx support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Fabio Estevam <festevam@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 22 Feb 2016 01:40:36 +0100
In-Reply-To: <CAOMZO5CfO5ZiMj-QEgEJn4zRkw=vg6zChrLKa0i=H+mnqLKRkg@mail.gmail.com>
References: <1455796743-5987-1-git-send-email-chf.fritz@googlemail.com>
	 <1455796743-5987-3-git-send-email-chf.fritz@googlemail.com>
	 <CAOMZO5CfO5ZiMj-QEgEJn4zRkw=vg6zChrLKa0i=H+mnqLKRkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio

On Sat, 2016-02-20 at 17:37 -0200, Fabio Estevam wrote:
> On Thu, Feb 18, 2016 at 9:59 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> >  static const struct of_device_id imx6_pcie_of_match[] = {
> >         { .compatible = "fsl,imx6q-pcie", },
> > +       { .compatible = "fsl,imx6sx-pcie", },
> 
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt needs to be
> updated to include this new compatible string.

Thanks, I'll wait a bit for other possible comments and will then send a
v3 patchset which updates the documentation too.

