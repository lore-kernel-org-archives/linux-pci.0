Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:32284 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbC0CcB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2015 22:32:01 -0400
Message-ID: <5514C101.8070705@huawei.com>
Date: Fri, 27 Mar 2015 10:31:29 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	the arch/x86 maintainers <x86@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 10/30] PCI: Introduce pci_host_bridge_list to manage
 host bridges
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>	<1427168064-8657-11-git-send-email-wangyijing@huawei.com> <CAE9FiQVgXfViM22qhB-sKDSTtnhvLDMk0NTiK_G88UogVMuM_w@mail.gmail.com>
In-Reply-To: <CAE9FiQVgXfViM22qhB-sKDSTtnhvLDMk0NTiK_G88UogVMuM_w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/27 0:31, Yinghai Lu wrote:
> On Mon, Mar 23, 2015 at 8:34 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Introduce pci_host_bridge_list to manage pci host
>> bridges in system, this make us have the ability
>> to check whether the new host would conflict with
>> existing one. Then we could remove bus alreay exist
>> check in __pci_create_root_bus().
> 
> Can we use bus_type instead?
> Then we can use bus_find_device for the host_bridge enumeration.
> 
> Please refer the patches that I sent out couple years ago.

HI Yinghai,
   I think your changes is good, but in this series, we only iterate the pci_host_bridge
in drivers/pci/host-bridge.c. The simple list is enough, of course, if we want to export
this list and support to host bridge hotplug, we must need a new iteration for host bridge,
and your series looks good to me, I read your series history, found Bjorn comment a lot.

So I think Bjorn may have some comments for this.

Thanks!
Yijing.




-- 
Thanks!
Yijing

