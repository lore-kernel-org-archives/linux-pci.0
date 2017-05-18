Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33249 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754486AbdERImA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2017 04:42:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170518074535.20635-1-songxiaowei@hisilicon.com>
References: <20170518074535.20635-1-songxiaowei@hisilicon.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 May 2017 10:41:54 +0200
Message-ID: <CAK8P3a2cx9t92XKSDn8JCC4Lbq9QcaPt3swgj2mdMw3nXRZk4w@mail.gmail.com>
Subject: Re: [Patch v3 2/3] PCI: dwc: kirin: add PCIe Driver for HiSilicon
 Kirin SoC
To: Song Xiaowei <songxiaowei@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kishon <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Keith Busch <keith.busch@intel.com>, niklas.cassel@axis.com,
        Duc Dang <dhdang@apm.com>, liudongdong3@huawei.com,
        puck.chen@hisilicon.com, Guodong Xu <guodong.xu@linaro.org>,
        wangbinghui@hisilicon.com, suzhuangluan@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 18, 2017 at 9:45 AM, Song Xiaowei <songxiaowei@hisilicon.com> wrote:
> Hisilicon PCIe Driver shares the common functions fo PCIe dw-host
>
> The poweron functions is developed on hi3660 SoC, while Others Functions
> are common for Kirin series SoCs.
>
> Lowpower(L1ss and SR), hotplug and MSI feature are not supported
> currently.
>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Song Xiaowei <songxiaowei@hisilicon.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
