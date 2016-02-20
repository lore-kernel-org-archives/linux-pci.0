Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33289 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbcBTThI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Feb 2016 14:37:08 -0500
Received: by mail-io0-f176.google.com with SMTP id z135so142094155iof.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Feb 2016 11:37:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455796743-5987-3-git-send-email-chf.fritz@googlemail.com>
References: <1455796743-5987-1-git-send-email-chf.fritz@googlemail.com>
	<1455796743-5987-3-git-send-email-chf.fritz@googlemail.com>
Date: Sat, 20 Feb 2016 17:37:07 -0200
Message-ID: <CAOMZO5CfO5ZiMj-QEgEJn4zRkw=vg6zChrLKa0i=H+mnqLKRkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: imx6: add initial imx6sx support
From: Fabio Estevam <festevam@gmail.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph,

On Thu, Feb 18, 2016 at 9:59 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

>  static const struct of_device_id imx6_pcie_of_match[] = {
>         { .compatible = "fsl,imx6q-pcie", },
> +       { .compatible = "fsl,imx6sx-pcie", },

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt needs to be
updated to include this new compatible string.

Thanks
