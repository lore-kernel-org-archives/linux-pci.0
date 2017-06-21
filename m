Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33866 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFUMrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2017 08:47:47 -0400
Received: by mail-yb0-f179.google.com with SMTP id e201so42160215ybb.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2017 05:47:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201706192108.j0gmKdUJ%fengguang.wu@intel.com>
References: <20170619100834.43321-3-songxiaowei@hisilicon.com> <201706192108.j0gmKdUJ%fengguang.wu@intel.com>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Wed, 21 Jun 2017 20:47:45 +0800
Message-ID: <CAFGCpxzJJGyhJWFe9J5f34e-etsF=0AC4+y9sKeVxWRD8L0tPw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] PCI: dwc: kirin: add PCIe Driver for HiSilicon
 Kirin SoC
To: kbuild test robot <lkp@intel.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>, kbuild-all@01.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 10:02 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Xiaowei,
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.12-rc5 next-20170619]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Xiaowei-Song/PCI-hisi-Add-DT-binding-for-PCIe-of-Kirin-SoC-series/20170619-194535
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):


Thanks for the finding. Sorry about this.

v10 patchset should be ignored. Xiaowei sent v11 yesterday.

-Guodong

>
>    drivers/pci/dwc/pcie-kirin.c: In function 'kirin_pcie_establish_link':
>>> drivers/pci/dwc/pcie-kirin.c:424:12: error: 'dev' undeclared (first use in this function)
>        dev_err(dev, "Link Fail\n");
>                ^~~
>    drivers/pci/dwc/pcie-kirin.c:424:12: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/dev +424 drivers/pci/dwc/pcie-kirin.c
>
>    418
>    419          /* check if the link is up or not */
>    420          while (!kirin_pcie_link_up(pci)) {
>    421                  usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>    422                  count++;
>    423                  if (count == 1000) {
>  > 424                          dev_err(dev, "Link Fail\n");
>    425                          return -EINVAL;
>    426                  }
>    427          }
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
