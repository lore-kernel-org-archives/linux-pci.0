Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30920 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbbHGB4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Aug 2015 21:56:38 -0400
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mark Brown <broonie@kernel.org>
References: <E1ZNIul-0007IF-Ev@optimist>
 <20150806175322.GB20873@sirena.org.uk>
 <20150807073954.3d19fc69@canb.auug.org.au>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <55C41052.9030505@linux.intel.com>
Date: Fri, 7 Aug 2015 09:56:34 +0800
MIME-Version: 1.0
In-Reply-To: <20150807073954.3d19fc69@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/7 5:39, Stephen Rothwell wrote:
> Hi Mark,
> 
> On Thu, 6 Aug 2015 18:53:22 +0100 Mark Brown <broonie@kernel.org> wrote:
>>
>> On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:
>>
>> Today's linux-next fails to build an ARM allmodconfig due to:
>>
>>> ../drivers/pci/host/pcie-xilinx.c:235:3: error: implicit declaration of function 'msi_desc_to_pci_sys_data' [-Werror=implicit-function-declaration]
>>
>> msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
>> current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
>> helper functions to access fields in struct msi_desc) at which time it
>> looks like it did exist but I can't immediately see where it was removed.
> 
> Actually, it is a typo ... all other uses are spelt msi_desc_to_pci_sysdata.
Hi Mark and Stephen,
	Sorry for this, it's a typo. Should I send a patch to fix this
issue or is there some other quick ways to get this fixed?
Thanks!
Gerry

