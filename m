Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55872 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcFVQQM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 12:16:12 -0400
Date: Wed, 22 Jun 2016 11:16:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
Message-ID: <20160622161607.GD25485@localhost>
References: <1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <201606111501.h2bC6u5a%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201606111501.h2bC6u5a%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 11, 2016 at 03:09:49PM +0800, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/Aardvark-PCIe-controller-driver-for-Marvell-Armada-3700/20160611-001044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: x86_64-lkp (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/of/Kconfig:4:error: recursive dependency detected!

Was there a resolution to this?
