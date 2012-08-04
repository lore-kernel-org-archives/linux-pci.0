Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1343475772-21345-3-git-send-email-jiang.liu@huawei.com>
References: <1343475772-21345-1-git-send-email-jiang.liu@huawei.com>
	<1343475772-21345-3-git-send-email-jiang.liu@huawei.com>
Date: Sat, 4 Aug 2012 13:14:27 -0700
Message-ID: <CAE9FiQU=HmRCy0nxLgi7oqnjbaW4DJ2ct1EE2pVP+=rac2D+wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] ACPIHP: ACPI system device hotplug slot enumerator
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luch@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Wen Congyang <wency@cn.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Gaohuai Han <hangaohuai@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2012 at 4:42 AM, Jiang Liu <liuj97@gmail.com> wrote:
> The first is an ACPI hotplug slot enumerator, which enumerates ACPI hotplug
> slots on load and provides callbacks to manage those hotplug slots.
> An ACPI hotplug slot is an abstraction of receptacles, where a group of
> system devices could be connected to. This patch implements the skeleton for
> ACPI system device hotplug slot enumerator. On loading, the driver scans the
> whole ACPI namespace for hotplug slots and creates a device node for each
> hotplug slots. Every slot is associated with a device class named
> acpihp_slot_class and will be managed by ACPI hotplug drivers.

I was thinking:
   We can have module in ACPI DSDT, and every module is coresponding
to SystemModule.
   so it will be
	\_SB.NOD1
		CPU0
		CPU1
		CPU2
		CPU3
		MEM0
		MEM1
		MEM2
		MEM3
		PCI0
		PCI1
		PCI2
		PCI3
		NTFY
		STAT
		STOP
    NTFY will be something like:
	Notify(\_SB.NOD1.CPU0,....)
	Notify(\_SB.NOD1.CPU1,....)
	Notify(\_SB.NOD1.CPU2,....)
	Notify(\_SB.NOD1.CPU3,....)

	Notify(\_SB.NOD1.MEM0,....)
	Notify(\_SB.NOD1.MEM1,....)
	Notify(\_SB.NOD1.MEM2,....)
	Notify(\_SB.NOD1.MEM3,....)

	Notify(\_SB.NOD1.PCI0,....)
	Notify(\_SB.NOD1.PCI1,....)
	Notify(\_SB.NOD1.PCI2,....)
	Notify(\_SB.NOD1.PCI3,....)

   and will link GPE button for SystemModule to call NTFY.

   STAT could be 32bit integer for final turn off the power.
	every CPU, MEM, PCI will own one bit, it will clear that bit in this own
	_EJ0.
	Every _EJ0 will double check if all are cleared, then it call extra STOP
	to power off the whole SystemModule.

if OS already have seperated handler for those type objects (CPU, MEM,
PCI),  we may not need to change to much to os.

Thanks

Yinghai
