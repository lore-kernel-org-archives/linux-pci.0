Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933545AbeCGRNa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 12:13:30 -0500
Date: Wed, 7 Mar 2018 17:13:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fabio Estevam <festevam@gmail.com>
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
Subject: Re: [PATCH v2] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180307171308.GA21985@e107981-ln.cambridge.arm.com>
References: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180220153947.GA21801@e107981-ln.cambridge.arm.com>
 <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5CSMJz8=Mm-fJR1aJK=V19uTyVO1PXkOGd1g6v64BNHNg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2018 at 07:57:16PM -0300, Fabio Estevam wrote:
> Hi Lorenzo,
> 
> On Tue, Feb 20, 2018 at 12:39 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> > I have applied it to pci/dwc for v4.17, with a tag to stable
> > for v4.15, we will have to send a backport to older stable
> > kernels.
> 
> Since this is a regression, why not apply it to 4.16-rc instead?

I asked Bjorn to send it for -rc5 and he kindly accepted, it is now
in his for-linus branch.

Thank you for bearing with me on this.

Lorenzo
