Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757295AbcLAQeE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 11:34:04 -0500
Date: Thu, 1 Dec 2016 10:34:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Christopher Covington <cov@codeaurora.org>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/ecam 8/12] drivers/acpi/pci_mcfg.c:57:16: error:
 expected expression before ',' token
Message-ID: <20161201163400.GC19681@bhelgaas-glaptop.roam.corp.google.com>
References: <201612011836.FOuJrJ5G%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612011836.FOuJrJ5G%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 06:43:40PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ecam
> head:   652f5e38afee70579c8723730c08d197a90e5b3a
> commit: 8d4bb02c09160ce73982b39d497aaf15a9414209 [8/12] PCI: Add MCFG quirks for Qualcomm QDF2432 host controller
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8d4bb02c09160ce73982b39d497aaf15a9414209
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/acpi/pci_mcfg.c:57:16: error: expected expression before ',' token
>      QCOM_ECAM32(0),
>                    ^
> 
> vim +57 drivers/acpi/pci_mcfg.c
> 
>     51	
>     52	static struct mcfg_fixup mcfg_quirks[] = {
>     53	/*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>     54	
>     55	#define QCOM_ECAM32(seg) \
>     56		{ "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops },
>   > 57		QCOM_ECAM32(0),
>     58		QCOM_ECAM32(1),
>     59		QCOM_ECAM32(2),
>     60		QCOM_ECAM32(3),

Fixed, thanks.
