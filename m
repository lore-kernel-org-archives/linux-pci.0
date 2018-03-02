Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:39316 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932836AbeCBW5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2018 17:57:17 -0500
Received: by mail-oi0-f44.google.com with SMTP id t185so8188459oif.6
        for <linux-pci@vger.kernel.org>; Fri, 02 Mar 2018 14:57:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220153947.GA21801@e107981-ln.cambridge.arm.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com> <20180220153947.GA21801@e107981-ln.cambridge.arm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Mar 2018 19:57:16 -0300
Message-ID: <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root subordinate
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-pci@vger.kernel.org,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Tue, Feb 20, 2018 at 12:39 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> I have applied it to pci/dwc for v4.17, with a tag to stable
> for v4.15, we will have to send a backport to older stable
> kernels.

Since this is a regression, why not apply it to 4.16-rc instead?
