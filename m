Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55B10013.6070306@arm.com>
Date: Thu, 23 Jul 2015 15:54:11 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 00/19] Per-device MSI domain & platform MSI
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <20150723131832.GW21967@google.com>
In-Reply-To: <20150723131832.GW21967@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23/07/15 14:18, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2015 at 10:26:19AM +0100, Marc Zyngier wrote:
>> MSI-like interrupts are starting to creep out of the PCI world, and
>> can now be seen into a number of "platform"-type busses. The
>> introduction of the MSI domains feature in v3.19 recognised that fact,
>> and started providing a way to implement this.
>> ...
> 
> The PCI parts all look great to me.  I assume Thomas will merge the whole
> thing through his tree.  Thanks!

Thanks a lot for taking the time to review it. I'll respin the series
with your nits and acks :-).

	M.
-- 
Jazz is not dead. It just smells funny...
