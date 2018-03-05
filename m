Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:43145 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932817AbeCELzp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 06:55:45 -0500
Received: by mail-oi0-f54.google.com with SMTP id a207so11785253oii.10
        for <linux-pci@vger.kernel.org>; Mon, 05 Mar 2018 03:55:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305094918.GB28109@e107981-ln.cambridge.arm.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180220153947.GA21801@e107981-ln.cambridge.arm.com> <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
 <20180305094918.GB28109@e107981-ln.cambridge.arm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Mar 2018 08:55:43 -0300
Message-ID: <CAOMZO5CFXBciQBOpPDtZc9L48d5Y3zubCK8M=HWo+owEOTQkrQ@mail.gmail.com>
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
        Zhou Wang <wangzhou1@hisilicon.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Mon, Mar 5, 2018 at 6:49 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> It is a balance of urgency and making sure it is extensively tested -
> I'd prefer it to go via usual release cycle (and -next) and then it will
> trickle into stable kernels, let me know if that's not OK.
>
> I would understand your point if dwc maintainers were more proactive
> in testing their respective controllers - all of them should be affected
> by this fix but I have just heard from a few of them.

We got this patch tested by: Koen, myself, Sebastian and the folks at
Pengutronix.

Looks like a decent amount of testing IMHO.

In this case I would prefer that we could fix the regression into
4.16-rc cycle rather than waiting until 4.17.

Thanks
