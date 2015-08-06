Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:51877 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbbHFVj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Aug 2015 17:39:57 -0400
Date: Fri, 7 Aug 2015 07:39:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
Message-ID: <20150807073954.3d19fc69@canb.auug.org.au>
In-Reply-To: <20150806175322.GB20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist>
	<20150806175322.GB20873@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark,

On Thu, 6 Aug 2015 18:53:22 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an ARM allmodconfig due to:
> 
> > ../drivers/pci/host/pcie-xilinx.c:235:3: error: implicit declaration of function 'msi_desc_to_pci_sys_data' [-Werror=implicit-function-declaration]
> 
> msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
> current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
> helper functions to access fields in struct msi_desc) at which time it
> looks like it did exist but I can't immediately see where it was removed.

Actually, it is a typo ... all other uses are spelt msi_desc_to_pci_sysdata.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
