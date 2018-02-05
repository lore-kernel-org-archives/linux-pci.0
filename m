Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:44485 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Feb 2018 17:12:49 -0500
Received: by mail-ot0-f179.google.com with SMTP id l5so22251432otj.11
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2018 14:12:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205200648.GM27654@lahna.fi.intel.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180205191420.GA12397@red-moon> <20180205200648.GM27654@lahna.fi.intel.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 20:12:48 -0200
Message-ID: <CAOMZO5ArPt2MMVp5g0FD8v=HtMOcja8XUH9BkSZ-n-wMqrLo3A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root subordinate
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika

On Mon, Feb 5, 2018 at 6:06 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> BTW, this should have a stable tag so that it gets backported to stable
> kernels. I guess whoever is applying the patch can add it so no need for
> another revision.

I agree it needs to be backported to stable as I adapted this patch to
4.9 and it fixed the issue there.

However the Fixes lines mentions commit a20c7f36bd3d, which only
appears in 4.15, so that is confusing for backporting to older
kernels.
