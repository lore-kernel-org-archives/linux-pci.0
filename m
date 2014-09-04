Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:46252 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaIDUVu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 16:21:50 -0400
Received: by mail-la0-f47.google.com with SMTP id el20so3968022lab.20
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 13:21:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
	<1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
Date: Thu, 4 Sep 2014 17:21:48 -0300
Message-ID: <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
From: Fabio Estevam <festevam@gmail.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 4, 2014 at 3:45 PM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.

It seems that this is the same IP as on mx6, right?

Is it possible to adapt drivers/pci/host/pci-imx6.c to work on Layerscape?

> +#define PCIE_LS1021A_BASE      0x3400000
> +#define PCIE_LS1021A_REG_SIZE  0x0100000

You should retrieve base and reg size from the dtsi file.
