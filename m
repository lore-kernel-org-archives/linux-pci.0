Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbeDPNrk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Apr 2018 09:47:40 -0400
Date: Mon, 16 Apr 2018 14:48:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: songxiaowei <songxiaowei@hisilicon.com>
Cc: Loic Poulain <loic.poulain@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] PCI: kirin: Fix
 reset gpio name
Message-ID: <20180416134830.GA32565@red-moon>
References: <1522747141-8299-1-git-send-email-loic.poulain@linaro.org>
 <CAMZdPi-jsf0_oYvdUtobr+pJyaWomFv7MWcZRr_P7xBfi_8-rw@mail.gmail.com>
 <99B4C6BADD9E3241B25E52B02BA737C54126803E@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C54126803E@DGGEMA505-MBS.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:48:52AM +0000, songxiaowei wrote:
> It's a bug indeed, thank you very much for the patch. I think the
> patch is ok.

Is this an ACK ? Please provide one if you want me to merge this
fix.

Lorenzo

> -----邮件原件-----
> 发件人: Loic Poulain [mailto:loic.poulain@linaro.org] 
> 发送时间: 2018年4月16日 19:35
> 收件人: songxiaowei <songxiaowei@hisilicon.com>; Wangbinghui <wangbinghui@hisilicon.com>
> 抄送: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; lorenzo.pieralisi@arm.com; Loic Poulain <loic.poulain@linaro.org>; Guodong Xu <guodong.xu@linaro.org>
> 主题: Re: [PATCH] PCI: kirin: Fix reset gpio name
> 
> Hi Xiaowei,
> 
> On 3 April 2018 at 11:19, Loic Poulain <loic.poulain@linaro.org> wrote:
> > As documented in the device-tree bindings (pci/kirin-pcie.txt) and 
> > defined in existing device-tree (hi3660.dtsi), the reset gpio name is 
> > 'reset-gpios'. However, driver looks for a 'reset-gpio' resource which 
> > makes the driver probe fail. Fix this.
> >
> > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe 
> > controller driver")
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> 
> 
> Are you still maintaining this driver ? Binghui's email seems to be invalid now.
> 
> Regards,
> Loic
