Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397AbaCDV4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Mar 2014 16:56:13 -0500
Message-ID: <53164BEE.9060405@redhat.com>
Date: Tue, 04 Mar 2014 22:55:58 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>
Subject: Re: kmemleak through e1000?
References: <5315F785.4050602@redhat.com> <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com>
In-Reply-To: <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/04/2014 09:58 PM, Bjorn Helgaas wrote:
> On Tue, Mar 4, 2014 at 8:55 AM, Daniel Borkmann <dborkman@redhat.com> wrote:
>> Hi all, I'm not very familiar with the e1000 code, but on the latest
>> net.git kernel I get reliably the following (not sure if it's actually
>> caused by e1000 though):
>
> Thanks a lot for the report.  What kernel is this exactly (URL and
> SHA-1 hash)?  We have fixes for a couple leaks already queued up [1,
> 2], so possibly you're seeing those leaks.  If you already have those
> fixes in net.git, then we should investigate further.

Great, good to know Bjorn.

I was using [1] with 8b4703e9bd117 ("macvlan: Add support for 'always_on'
offload features") as HEAD.

   [1] https://git.kernel.org/cgit/linux/kernel/git/davem/net.git/

> Bjorn
>
> [1] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/msi&id=13f81c099bee8141f764fd41a1f4b68b93be3296
> [2] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/msi&id=b3bac8e57c82e8d3e05f4abcb18c4f0a40656655
>
>> unreferenced object 0xffff8800361a7d80 (size 32):
>>    comm "systemd-udevd", pid 246, jiffies 4294677997 (age 1117.522s)
>>    hex dump (first 32 bytes):
>>      60 7d 1a 36 00 88 ff ff 24 01 00 00 00 00 00 00  `}.6....$.......
>>      f0 aa 35 81 ff ff ff ff 00 00 00 00 00 00 00 00  ..5.............
>>    backtrace:
>>      [<ffffffff8166609e>] kmemleak_alloc+0x4e/0xb0
>>      [<ffffffff8119f547>] kmem_cache_alloc_trace+0xd7/0x220
>>      [<ffffffff8135ad48>] populate_msi_sysfs+0x128/0x220
>>      [<ffffffff8135b4b8>] pci_enable_msi_block+0x1b8/0x2c0
>>      [<ffffffffa0221781>] e1000e_set_interrupt_capability+0x41/0x120 [e1000e]
>>      [<ffffffffa0226047>] e1000_probe+0x3a7/0xe20 [e1000e]
>>      [<ffffffff81343805>] local_pci_probe+0x45/0xa0
>>      [<ffffffff81344b89>] pci_device_probe+0xd9/0x130
>>      [<ffffffff813fc317>] driver_probe_device+0x87/0x390
>>      [<ffffffff813fc6f3>] __driver_attach+0x93/0xa0
>>      [<ffffffff813fa323>] bus_for_each_dev+0x63/0xa0
>>      [<ffffffff813fbd6e>] driver_attach+0x1e/0x20
>>      [<ffffffff813fb950>] bus_add_driver+0x180/0x250
>>      [<ffffffff813fcd04>] driver_register+0x64/0xf0
>>      [<ffffffff813431ab>] __pci_register_driver+0x4b/0x50
>>      [<ffffffffa0240041>] iptable_filter_hook+0x41/0x70 [iptable_filter]
>> unreferenced object 0xffff8800c4ac1920 (size 32):
>>    comm "NetworkManager", pid 409, jiffies 4294693366 (age 1102.161s)
>>    hex dump (first 32 bytes):
>>      34 34 00 c4 00 88 ff ff 00 00 00 00 00 00 00 00  44..............
>>      00 00 00 00 00 00 00 00 6f 2e 32 00 00 00 00 00  ........o.2.....
>>    backtrace:
>>      [<ffffffff8166609e>] kmemleak_alloc+0x4e/0xb0
>>      [<ffffffff8119f547>] kmem_cache_alloc_trace+0xd7/0x220
>>      [<ffffffff8135ad2f>] populate_msi_sysfs+0x10f/0x220
>>      [<ffffffff8135b4b8>] pci_enable_msi_block+0x1b8/0x2c0
>>      [<ffffffffa0226ce5>] e1000_open+0x225/0x5b0 [e1000e]
>>      [<ffffffff815785af>] __dev_open+0xbf/0x140
>>      [<ffffffff815788bd>] __dev_change_flags+0x9d/0x170
>>      [<ffffffff815789b9>] dev_change_flags+0x29/0x60
>>      [<ffffffff81585482>] do_setlink+0x312/0x9e0
>>      [<ffffffff81587958>] rtnl_newlink+0x508/0x710
>>      [<ffffffff81584199>] rtnetlink_rcv_msg+0x99/0x260
>>      [<ffffffff815a3269>] netlink_rcv_skb+0xa9/0xc0
>>      [<ffffffff815840f8>] rtnetlink_rcv+0x28/0x30
>>      [<ffffffff815a2bd8>] netlink_unicast+0x168/0x250
>>      [<ffffffff815a2fa1>] netlink_sendmsg+0x2e1/0x3f0
>>      [<ffffffff8155cc6b>] sock_sendmsg+0x8b/0xc0
>> unreferenced object 0xffff8800c4ac17a0 (size 32):
>>    comm "NetworkManager", pid 409, jiffies 4294693366 (age 1102.161s)
>>    hex dump (first 32 bytes):
>>      20 19 ac c4 00 88 ff ff 24 01 00 00 00 00 00 00   .......$.......
>>      f0 aa 35 81 ff ff ff ff 00 00 00 00 00 00 00 00  ..5.............
>>    backtrace:
>>      [<ffffffff8166609e>] kmemleak_alloc+0x4e/0xb0
>>      [<ffffffff8119f547>] kmem_cache_alloc_trace+0xd7/0x220
>>      [<ffffffff8135ad48>] populate_msi_sysfs+0x128/0x220
>>      [<ffffffff8135b4b8>] pci_enable_msi_block+0x1b8/0x2c0
>>      [<ffffffffa0226ce5>] e1000_open+0x225/0x5b0 [e1000e]
>>      [<ffffffff815785af>] __dev_open+0xbf/0x140
>>      [<ffffffff815788bd>] __dev_change_flags+0x9d/0x170
>>      [<ffffffff815789b9>] dev_change_flags+0x29/0x60
>>      [<ffffffff81585482>] do_setlink+0x312/0x9e0
>>      [<ffffffff81587958>] rtnl_newlink+0x508/0x710
>>      [<ffffffff81584199>] rtnetlink_rcv_msg+0x99/0x260
>>      [<ffffffff815a3269>] netlink_rcv_skb+0xa9/0xc0
>>      [<ffffffff815840f8>] rtnetlink_rcv+0x28/0x30
>>      [<ffffffff815a2bd8>] netlink_unicast+0x168/0x250
>>      [<ffffffff815a2fa1>] netlink_sendmsg+0x2e1/0x3f0
>>      [<ffffffff8155cc6b>] sock_sendmsg+0x8b/0xc0
