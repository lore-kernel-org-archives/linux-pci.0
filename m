Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:22428 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbCYBWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2015 21:22:40 -0400
Message-ID: <55120DBA.7080105@huawei.com>
Date: Wed, 25 Mar 2015 09:22:02 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 24/30] PCI/tegra: Remove redundant tegra_pcie_scan_bus()
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com> <1427168064-8657-25-git-send-email-wangyijing@huawei.com> <20150324123139.GA11625@ulmo.nvidia.com>
In-Reply-To: <20150324123139.GA11625@ulmo.nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/24 20:31, Thierry Reding wrote:
> On Tue, Mar 24, 2015 at 11:34:18AM +0800, Yijing Wang wrote:
>> Now pci_scan_root_bus() is almost similar to
>> pci_create_root_bus() + pci_scan_child_bus().
>> So we could use common pci_scan_root_bus() in
>> pci_common_init_dev() to scan pci busses.
>> tegra_pcie_scan_bus() is redundant, remove it.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Thierry Reding <thierry.reding@gmail.com>
>> CC: linux-tegra@vger.kernel.org
>> ---
>>  drivers/pci/host/pci-tegra.c |   16 ----------------
>>  1 files changed, 0 insertions(+), 16 deletions(-)
> 
> Jetson TK1 still boots over NFS root via the onboard PCIe network card
> with this series applied, so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Thanks!

> 


-- 
Thanks!
Yijing

