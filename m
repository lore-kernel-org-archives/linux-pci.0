Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:32968 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcEaUJh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2016 16:09:37 -0400
Received: by mail-yw0-f177.google.com with SMTP id h19so200519353ywc.0
        for <linux-pci@vger.kernel.org>; Tue, 31 May 2016 13:09:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201606010302.zx7ZnkzC%fengguang.wu@intel.com>
References: <201606010302.zx7ZnkzC%fengguang.wu@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 31 May 2016 15:09:16 -0500
Message-ID: <CAErSpo4_ErtrNNz-QdMMk=qQxSqE4cr_FkxrJBv42UaAuefotA@mail.gmail.com>
Subject: Re: [pci:pci/host-request-windows 3/22] drivers/pci/host/pci-xgene.c:562:25:
 error: 'resources' undeclared
To: kbuild test robot <fengguang.wu@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 2:14 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-request-windows
> head:   001fdc8c3dd699197ede3f80776e40ad26d6ea20
> commit: ca08256c121d5fa1c94c70e650c9442a7095f201 [3/22] PCI: xgene: Free bridge resource list on failure
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ca08256c121d5fa1c94c70e650c9442a7095f201
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> Note: the pci/pci/host-request-windows HEAD 001fdc8c3dd699197ede3f80776e40ad26d6ea20 builds fine.
>       It only hurts bisectibility.

This note is incorrect.  The HEAD (001fdc8c3dd6) contains the same
error as the one shown below.

> All errors (new ones prefixed by >>):

The new errors are actually prefixed by ">", not ">>".

> vim +/resources +562 drivers/pci/host/pci-xgene.c
>
>    556          pci_bus_add_devices(bus);
>    557
>    558          platform_set_drvdata(pdev, port);
>    559          return 0;
>    560
>    561  error:
>  > 562          pci_free_resource_list(resources);
>    563          return ret;
>    564  }
>    565
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
