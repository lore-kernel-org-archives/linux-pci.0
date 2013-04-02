Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:48587 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758426Ab3DBC5H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 22:57:07 -0400
Message-ID: <515A48E8.60605@huawei.com>
Date: Tue, 2 Apr 2013 10:56:40 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] PCI/IA64: fix pci_dev->enable_cnt balance when doing
 pci hotplug
References: <1364805775-12396-1-git-send-email-wangyijing@huawei.com> <1364805775-12396-2-git-send-email-wangyijing@huawei.com> <3908561D78D1C84285E8C5FCA982C28F1E096033@ORSMSX108.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F1E096033@ORSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/4/2 6:23, Luck, Tony wrote:
>> In IA64 platform, we don't call pci_enable_bridges()
>> when scan all pci buses during system boot up. But in
>> X86 we do it in
> 
> Your patch looks plausible ... but I have a question. X86 doesn't
> *directly* call pci_enable_bridges() from any arch/x86/* file.
> 

Hi Tony,
   In x86, we will use pcibios_assign_resources() in arch/x86/pci/i386.c to
assign pci device resource. And at the end of pci_assign_unassigned_resources()
function we enable pci bridges. So X86 call pci_enable_bridges() when doing device
resource assignment. But in IA64, we assign device resource according BIOS setting in
PCI BARs. No additional resource reassignment code support after scan all pci buses.
In this respects, resource reassignment support is weak in IA64.

But this patch mainly to fix the unbalanced dev->enable_cnt in IA64 which will print WARNING Calltrace
in dmesg.

If you think it is valuable, I will try to improve resource assignment in IA64 like other arch (eg arm, m68k, mips and sh..)
in another patch.

Thanks!
Yijing.

> Do we need this in an arch/ia64 file because our PCI support
> is getting old and stale?  "git grep" says that arm, m68k, mips
> and sh all make direct calls.

I think so.

> 
> -Tony
> 
> .
> 


-- 
Thanks!
Yijing

