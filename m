Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35384 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422929AbcFNDS6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 23:18:58 -0400
Received: by mail-io0-f180.google.com with SMTP id o127so90795908iod.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2016 20:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465814497.2313.7.camel@pengutronix.de>
References: <1465344472-15703-1-git-send-email-festevam@gmail.com>
 <1465378523.1870.26.camel@googlemail.com> <CAOMZO5Bix1Bgrsbn2K_1sh7ee=dxRccU1zk2fJei-WU4vvpCgg@mail.gmail.com>
 <1465814497.2313.7.camel@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 14 Jun 2016 00:18:50 -0300
Message-ID: <CAOMZO5A2SRPi=-_WJY87GYoY7vQ+e0vyQcNK8FL4fqxuOaHRqg@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain regulator
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Mon, Jun 13, 2016 at 7:41 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> It should be handled the same way as the PU domain regulator on mx6q.
> This means the regulator is a supply of the PCIe PHY power domain and
> should be en-/disabled through the GPC driver.
>
> I already posted a series to rework the GPC driver to allow adding new
> power domains easily, but it was rejected by Shawn on formal grounds, as

Could you please point me to this series?

Thanks
