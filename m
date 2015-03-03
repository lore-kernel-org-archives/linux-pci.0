Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:31846 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbCCINA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 03:13:00 -0500
Message-ID: <54F56CD7.8080906@huawei.com>
Date: Tue, 3 Mar 2015 16:12:07 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
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
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 13/30] PCI: Introduce new scan function pci_scan_root_bridge()
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com> <1424938344-4017-14-git-send-email-wangyijing@huawei.com> <20150303025222.GG11978@google.com>
In-Reply-To: <20150303025222.GG11978@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/3 10:52, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2015 at 04:12:07PM +0800, Yijing Wang wrote:
>> Introduce new scan function pci_scan_root_bridge() to
>> support host bridge drivers that need to provide platform
>> own pci_host_bridge_ops.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/probe.c |   21 +++++++++++++++++++++
>>  include/linux/pci.h |    3 +++
>>  2 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8cec6ab..b5f9ca4 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2063,6 +2063,27 @@ static struct pci_bus *__pci_scan_root_bus(
>>  	return b;
>>  }
>>  
>> +struct pci_host_bridge *pci_scan_root_bridge(struct device *parent,
>> +		u32 db, struct pci_ops *ops, void *sysdata,
>> +		struct list_head *resources, struct pci_host_bridge_ops *phb_ops)
> 
> I prefer "host bridge" over "root bridge" because that's the terminology
> used by the PCI specs.

OK, I will use "host bridge" instead of "root bridge".


> 
> .
> 


-- 
Thanks!
Yijing

