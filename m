Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:23712
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732374AbeHNSnB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 14:43:01 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Date: Tue, 14 Aug 2018 15:55:12 +0000
Message-ID: <BL0PR02MB484920A86EB6267FA35FC2CCA5380@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
 <201808131647.wzxWvkIy%fengguang.wu@intel.com>
In-Reply-To: <201808131647.wzxWvkIy%fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Agreed, will Fix it in next version.

Regards,
Bharat
> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Monday, August 13, 2018 2:39 PM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: kbuild-all@01.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; bhelgaas@google.com; Ravikiran Gummaluri
> <rgummal@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
> setup_platform_service_irq hook
>=20
> Hi Bharat,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on pci/next]
> [also build test WARNING on v4.18 next-20180810] [if your patch is applie=
d to
> the wrong git tree, please drop us a note to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-
> Gogada/Add-support-to-register-platform-service-IRQ/20180813-144216
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git n=
ext
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/pci/controller/pcie-xilinx-nwl.c:823:5: sparse: symbol
> 'nwl_setup_service_irqs' was not declared. Should it be static?
>=20
> Please review and possibly fold the followup patch.
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
