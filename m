Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34746 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeCGRXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 12:23:36 -0500
Received: by mail-oi0-f43.google.com with SMTP id c83so2262762oib.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2018 09:23:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307171308.GA21985@e107981-ln.cambridge.arm.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180220153947.GA21801@e107981-ln.cambridge.arm.com> <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
 <20180307171308.GA21985@e107981-ln.cambridge.arm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Mar 2018 14:23:34 -0300
Message-ID: <CAOMZO5Aedfy3CfxOAEXSPTQt_1pher2FYjC1_NnXrxiArDEDgQ@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 2:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> I asked Bjorn to send it for -rc5 and he kindly accepted, it is now
> in his for-linus branch.

Excellent, thanks!
