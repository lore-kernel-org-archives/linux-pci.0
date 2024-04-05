Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FA160783;
	Fri,  5 Apr 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311358; cv=none; b=pM5zAxmeTOegRYtIwpvJ/P1eKQ15OsoFXTt4kwduubLSl13wxbvsV7U+G/Iie8Sv+zmcWBmGOrI+GVUlB5p7GYW+OwBVf+Vtl7AwVzKNdTVuIfyx98rO3SWKjUynWU3Q322jDJUBhANoq1oyOLgO+LzxrwNMoGAr1MEnfdIecEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311358; c=relaxed/simple;
	bh=NxvxzWFEm1vUUexok4ekiOZ5+EfNkBZCkduLoUStE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxkVK7tIRqYWdN0cS4Sn1ik2z2wuOdxK7ndkvCM4NQBAQ0DElOHTtP+qHgJjTFLY83KMrCh1B4CkMIuMhO5/+V/Il8M6ydDGSQ1LI1HhKVSEJ29aDfTCQ6rgnND0Erja2As9PdoDOJCpHKbF2TRjmrCb8Q5C6pfAOCUR1/gz7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 015C9100DA1A6;
	Fri,  5 Apr 2024 12:02:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C87935FC4DA; Fri,  5 Apr 2024 12:02:32 +0200 (CEST)
Date: Fri, 5 Apr 2024 12:02:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Roman Lozko <lozko.roma@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: Deadlock in pciehp on dock disconnect
Message-ID: <Zg_MOG1OufptoRph@wunner.de>
References: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>

[cc += netdev maintainers]

On Fri, Apr 05, 2024 at 11:14:01AM +0200, Roman Lozko wrote:
> Hi, I'm using HP G4 Thunderbolt docking station, and recently (?)
> kernel started to "partially" deadlock after disconnecting the dock
> station. This results in inability to turn network interfaces on or
> off, system can't reboot, `sudo` does not work (guess because it uses
> DNS).
> 
> It started to occur ~two weeks ago, don't know why, I did not change
> anything at that time. First seen on 6.8.2, nothing changed with
> 6.9.0-rc2.

This is not a pciehp issue, it's a networking issue:

In the stacktrace you've provided below, the rtnl_lock() is acquired
recursively, which leads to the deadlock:

unregister_netdev() acquires rtnl_lock(), indirectly invokes
netdev_trig_deactivate() upon unregistering some LED, thereby
calling unregister_netdevice_notifier(), which tries to
acquire rtnl_lock() again.

From a quick look at the source files involved, this doesn't look
like something new, though I note LED support for igc was added
only recently with ea578703b03d ("igc: Add support for LEDs on
i225/i226"), which went into v6.9-rc1.

The other hanging tasks are simply waiting for rtnl_lock() as well.


> pciehp stack trace:
> INFO: task irq/122-pciehp:209 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:irq/122-pciehp  state:D stack:0     pid:209   tgid:209   ppid:2
>    flags:0x00004000
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  unregister_netdevice_notifier+0x40/0x150
>  netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev c68f5c964fe428d1a2169816a653c62dba2f2e01]
>  led_trigger_set+0x102/0x330
>  led_classdev_unregister+0x4b/0x110
>  release_nodes+0x3d/0xb0
>  devres_release_all+0x8b/0xc0
>  device_del+0x34f/0x3c0
>  unregister_netdevice_many_notify+0x80b/0xaf0
>  unregister_netdev+0x7c/0xd0
>  igc_remove+0xd8/0x1e0 [igc d1bcf7b726f7370e167c72960cdb27ae7f970357]
>  pci_device_remove+0x3f/0xb0
>  device_release_driver_internal+0x1be/0x2d0
>  pci_stop_bus_device+0x68/0xa0
>  pci_stop_bus_device+0x39/0xa0
>  pci_stop_bus_device+0x39/0xa0
>  pciehp_unconfigure_device+0x12b/0x1d0
>  pciehp_disable_slot+0x65/0x120
>  pciehp_handle_presence_or_link_change+0x7a/0x450
>  pciehp_ist+0xf5/0x320
>  irq_thread_fn+0x1d/0x40
>  irq_thread+0x19b/0x260
>  kthread+0x147/0x160
>  ret_from_fork+0x34/0x40
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> 
> Other affected kernel threads
> INFO: task NetworkManager:1294 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:NetworkManager  state:D stack:0     pid:1294  tgid:1294  ppid:1
>    flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  ____sys_sendmsg+0x1a5/0x2a0
>  ___sys_sendmsg+0x293/0x2d0
>  __x64_sys_sendmsg+0x10d/0x140
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7971ac52c02b
> RSP: 002b:00007ffc684c09a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00005661e9bc5be0 RCX: 00007971ac52c02b
> RDX: 0000000000000000 RSI: 00007ffc684c09e0 RDI: 000000000000000d
> RBP: 00007ffc684c09c0 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000293 R12: 0000000000000001
> R13: 0000000000000000 R14: 00005661e9c45030 R15: 00005661e9bc5cac
>  </TASK>
> INFO: task geoclue:2325 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:geoclue         state:D stack:0     pid:2325  tgid:2325  ppid:1
>    flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7ad712b2beea
> RSP: 002b:00007fff94c1fd80 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ad712b2beea
> RDX: 0000000000000014 RSI: 00007fff94c1fe10 RDI: 0000000000000007
> RBP: 00007fff94c1fdb0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000004000 R11: 0000000000000246 R12: 00007fff94c1fe10
> R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> INFO: task pool-geoclue:84396 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:pool-geoclue    state:D stack:0     pid:84396 tgid:2325  ppid:1
>    flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7ad712b2c0e4
> RSP: 002b:00007ad6e7dfdf40 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ad712b2c0e4
> RDX: 0000000000000014 RSI: 00007ad6e7dff070 RDI: 000000000000000b
> RBP: 00007ad6e7dfdf80 R08: 00007ad6e7dff014 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000b
> R13: 0000000000000010 R14: 00007ad6e7dff030 R15: 00000000d3fb1bea
>  </TASK>
> INFO: task Qt bearer threa:4002 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:Qt bearer threa state:D stack:0     pid:4002  tgid:3506
> ppid:3034   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x76f3c692beea
> RSP: 002b:000076f3a51fecb0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000076f3c692beea
> RDX: 0000000000000020 RSI: 000076f3a51fed60 RDI: 0000000000000023
> RBP: 000076f3a51fece0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000076f3a51fee38
> R13: 000076f378026b30 R14: 000076f3a51fed30 R15: 000076f378026b48
>  </TASK>
> INFO: task gnome-software:3529 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:gnome-software  state:D stack:0     pid:3529  tgid:3529
> ppid:3034   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x7d6be892beea
> RSP: 002b:00007ffd94e01560 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007d6be892beea
> RDX: 0000000000000014 RSI: 00007ffd94e015f0 RDI: 000000000000000d
> RBP: 00007ffd94e01590 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000004000 R11: 0000000000000246 R12: 00007ffd94e015f0
> R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> INFO: task Qt bearer threa:3960 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:Qt bearer threa state:D stack:0     pid:3960  tgid:3550
> ppid:3034   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x777a42b2beea
> RSP: 002b:0000777a2abfecf0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000777a42b2beea
> RDX: 0000000000000020 RSI: 0000777a2abfeda0 RDI: 000000000000001d
> RBP: 0000777a2abfed20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000777a2abfee78
> R13: 0000777a080285b0 R14: 0000777a2abfed70 R15: 0000777a080285c8
>  </TASK>
> INFO: task xdg-desktop-por:3821 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:xdg-desktop-por state:D stack:0     pid:3821  tgid:3821
> ppid:2776   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x79d76612beea
> RSP: 002b:00007ffd480942a0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000079d76612beea
> RDX: 0000000000000014 RSI: 00007ffd48094330 RDI: 0000000000000008
> RBP: 00007ffd480942d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000004000 R11: 0000000000000246 R12: 00007ffd48094330
> R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> INFO: task DNS Res~ver #11:25588 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:DNS Res~ver #11 state:D stack:0     pid:25588 tgid:4934
> ppid:3070   flags:0x00000002
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  netlink_dump+0x1c4/0x3f0
>  __netlink_dump_start+0x2b3/0x340
>  rtnetlink_rcv_msg+0x469/0x4a0
>  netlink_rcv_skb+0xed/0x120
>  netlink_unicast+0x2ce/0x3f0
>  netlink_sendmsg+0x39c/0x450
>  __sys_sendto+0x2c8/0x350
>  __x64_sys_sendto+0x26/0x30
>  do_syscall_64+0x92/0x170
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> RIP: 0033:0x72d65892c0e4
> RSP: 002b:000072d649cbb880 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000072d65892c0e4
> RDX: 0000000000000014 RSI: 000072d649cbc9b0 RDI: 0000000000000053
> RBP: 000072d649cbb8c0 R08: 000072d649cbc954 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000053
> R13: 0000000000000010 R14: 000072d649cbc970 R15: 00000000b48fd654
>  </TASK>
> INFO: task kworker/u88:2:31385 blocked for more than 120 seconds.
>       Not tainted 6.9.0-rc2 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u88:2   state:D stack:0     pid:31385 tgid:31385 ppid:2
>    flags:0x00004000
> Workqueue: ipv6_addrconf addrconf_verify_work
> Call Trace:
>  <TASK>
>  __schedule+0x5dd/0x1380
>  schedule+0x6e/0xf0
>  schedule_preempt_disabled+0x15/0x20
>  __mutex_lock+0x2a0/0x750
>  addrconf_verify_work+0x20/0x30
>  process_scheduled_works+0x1f4/0x450
>  worker_thread+0x349/0x5e0
>  kthread+0x147/0x160
>  ret_from_fork+0x34/0x40
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
