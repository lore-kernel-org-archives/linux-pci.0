Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031788AbeBNPt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Feb 2018 10:49:28 -0500
Message-ID: <1518623360.2744.20.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Date: Wed, 14 Feb 2018 16:49:20 +0100
In-Reply-To: <CAOMZO5A2pn23+nBEMV=bYaHa6-Pa3qohFMzrcnkECGhMFAJW6g@mail.gmail.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
         <20180205191420.GA12397@red-moon>
         <CAOMZO5A2pn23+nBEMV=bYaHa6-Pa3qohFMzrcnkECGhMFAJW6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 14.02.2018, 13:41 -0200 schrieb Fabio Estevam:
> Hi Lucas and Richard,
> 
> On Mon, Feb 5, 2018 at 5:14 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
[...]
> > I would appreciate some testing from dwc host maintainers so that
> > we can merge this patch, it is a bug fix that should be merged as
> > soon as possible, please help Koen test it and provide feedback
> > on the list.
> 
> Is it possible for you to test this patch?

I did not test myself, but a Pengutronix colleague did and reported it
did fix the bus scanning issues, while not introducing any obvious
issues.

Acked-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas
