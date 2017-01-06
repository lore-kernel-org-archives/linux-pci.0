Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, nsekhar@ti.com,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v5] PCI: add a new directory for designware core
Date: Fri, 06 Jan 2017 14:01:47 +0100
Message-ID: <4757539.Mx4pNLiAHf@wuerfel>
In-Reply-To: <1483707168-1436-1-git-send-email-kishon@ti.com>
References: <1483707168-1436-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 6, 2017 6:22:48 PM CET Kishon Vijay Abraham I wrote:
> Group all the PCI drivers that use designware core in dwc directory.
> dwc IP is capable of operating in both host mode and device mode and
> keeping it inside the *host* directory is misleading.

I have no objections to the patch, it makes a lot of sense, but I think
the reasoning above is a bit questionable, as a lot of the other
host drivers (at least tegra, mvebu and xgene, probably more) equally support
endpoint mode and remain in the same directory.

Any suggestion to what we should do with them?

	Arnd
