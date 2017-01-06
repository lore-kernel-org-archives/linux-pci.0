Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: add a new directory for designware core
To: Arnd Bergmann <arnd@arndb.de>
References: <1483707168-1436-1-git-send-email-kishon@ti.com>
 <4757539.Mx4pNLiAHf@wuerfel>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>,
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
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <586F97B8.8040300@ti.com>
Date: Fri, 6 Jan 2017 18:42:24 +0530
MIME-Version: 1.0
In-Reply-To: <4757539.Mx4pNLiAHf@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Friday 06 January 2017 06:31 PM, Arnd Bergmann wrote:
> On Friday, January 6, 2017 6:22:48 PM CET Kishon Vijay Abraham I wrote:
>> Group all the PCI drivers that use designware core in dwc directory.
>> dwc IP is capable of operating in both host mode and device mode and
>> keeping it inside the *host* directory is misleading.
> 
> I have no objections to the patch, it makes a lot of sense, but I think
> the reasoning above is a bit questionable, as a lot of the other
> host drivers (at least tegra, mvebu and xgene, probably more) equally support
> endpoint mode and remain in the same directory.
> 
> Any suggestion to what we should do with them?

I'm not sure of the exact IP's used by these SoCs. Now that we decided to group
the drivers by IPs used, the best would be identify the IPs used in these SoCs
and create a separate directory for each of the IPs. If the vendors own IP is
used, then create a directory with the name of the vendor?. I'm sure such a
change would increase the number of directories but I'm not sure what else to
do here.

Thanks
Kishon
