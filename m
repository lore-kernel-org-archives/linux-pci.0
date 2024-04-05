Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521F15F31D
	for <linux-pci@vger.kernel.org>; Fri,  5 Apr 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308455; cv=none; b=DKttQz6LVTT5fov4Z8zEkSU05iJTdvTh0T24vIrOcMUeFmd96Z0aqmwbxU8XOIthSv7HFwm5LbLt7Yv+rJnlsu0zvv+1MvPPvdC+OYQNDNhr9fZAZrw20LyEanX0pvkjPhGz03Dka79DbbyyqUNTes2lWiYNehz3FSc5SMGg52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308455; c=relaxed/simple;
	bh=Agqd5EUXrrvWxudXLxjMJs2znR3LPl1a6NGBG4ZtpqY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lZMFC6ovTJC325DM4atxmJGTruKx2iSTQP1VYN1/mh2Kg1qlNeTp9lHYF4P+OKVdUZiY1IqaSYhDNrn1rVHrOrRA/salXCFTyaxVPhvXwemNDqpF2wPeNw6SV6IhmsMbgXL7IwDzwo72IkbYJU+hodydwUi2hDovyeB/Q5NJNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzc2vQoo; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzc2vQoo"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3aeef1385so1337372b6e.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2024 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308453; x=1712913253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LDQPMn8RErvYMkk+vk/bcdlEWd9dh3iLXT6Rx0n0eCk=;
        b=Xzc2vQoo7ObKSWsUBQvsn3XLXRHjH6+S9hSEFKyCaFPZJeRrcTEuy3bX0c5nrPbki5
         EVisqMnnTuFrEb4DGYRG63/pGvXhjHgqUxDg5KRo7JEDyTqu405AflyQEtMa0ZadyKbR
         cM5pudPPUotfZJMKShdxN/8zJl+heBXb76hkusdaABUNZ5bJ90JZbKaFpSIVmYKBvGn7
         8O/x5vJRbgrkq+ULJxkP1NTm0TuftLbKoAWbHpw+fDFPpEMA7Xp9rqLZjBGuqGAxnynL
         VklNVntsvcnQ2QudgU1XKy5ICPH5fiU8HxDO6yMqss9wgtrQlPjwhvgRWCi3OKSZOpsf
         6dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308453; x=1712913253;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDQPMn8RErvYMkk+vk/bcdlEWd9dh3iLXT6Rx0n0eCk=;
        b=J/csE7R9kMstYSP1Sn49c7ECirzr5pH4cyPVNTAc4Igrd59NOYVprEGitchd6XbPKq
         /2yWWqfA0wDP6pj23H0/Abf7Bj6UvEasWw9W5aTnXBIkrkq4PN+vshS18w8znuLGn+sR
         QQ7Mid2ARcVFmB1cWtooRC6R9EYQW9hyQjgFnxOvhOqMo+p6nzdkP34p3ZoBFAWTxa1q
         iwaHHzlYXa7qE2e7AFQXBDE7aEL/A39GzK3fbvTVOZucLox6HpEb9YCaAan3ofdJFD7Q
         /mnpkbFWDKX8s3MHSrEj7bmQjjCdh+RqOdrZgwnK5kGFzWfjd7f2vC6W3swr5Fk3ejN3
         oqyw==
X-Gm-Message-State: AOJu0YzaX/xfoKT39DtAvtSEPY2bq1LTYLqS6yQo0RJOZyVcQwkkFu4N
	7THfiCKRo+6OtnqkhFdDgYOBYr1R1mhRqMVMdr/fidm2f7fAZ5J/JzEcnY4YXChr8OApxTP+lsq
	4DsEOc84URofJON7t/8xBT35HN0SDQAc8RZkFIQ==
X-Google-Smtp-Source: AGHT+IG0cjw/YRL21nryWVQ2QtEdX54Uv5WZ3sSH2weBghC0Th0C2kiCyEYOYtH+FZXtiiIysfM1iR4cj4uf4ztImUU=
X-Received: by 2002:aca:1b18:0:b0:3c3:b514:8c6a with SMTP id
 b24-20020aca1b18000000b003c3b5148c6amr790212oib.53.1712308452568; Fri, 05 Apr
 2024 02:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roman Lozko <lozko.roma@gmail.com>
Date: Fri, 5 Apr 2024 11:14:01 +0200
Message-ID: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>
Subject: Deadlock in pciehp on dock disconnect
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, I'm using HP G4 Thunderbolt docking station, and recently (?)
kernel started to "partially" deadlock after disconnecting the dock
station. This results in inability to turn network interfaces on or
off, system can't reboot, `sudo` does not work (guess because it uses
DNS).

It started to occur ~two weeks ago, don't know why, I did not change
anything at that time. First seen on 6.8.2, nothing changed with
6.9.0-rc2.

Can you advise what other info I can collect to help fix this issue?

pciehp stack trace:
INFO: task irq/122-pciehp:209 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/122-pciehp  state:D stack:0     pid:209   tgid:209   ppid:2
   flags:0x00004000
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? sysvec_irq_work+0x15/0x80
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 unregister_netdevice_notifier+0x40/0x150
 netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev
c68f5c964fe428d1a2169816a653c62dba2f2e01]
 led_trigger_set+0x102/0x330
 ? kernfs_put+0xa6/0x120
 led_classdev_unregister+0x4b/0x110
 release_nodes+0x3d/0xb0
 devres_release_all+0x8b/0xc0
 device_del+0x34f/0x3c0
 ? pm_runtime_set_memalloc_noio+0xc3/0xe0
 unregister_netdevice_many_notify+0x80b/0xaf0
 unregister_netdev+0x7c/0xd0
 igc_remove+0xd8/0x1e0 [igc d1bcf7b726f7370e167c72960cdb27ae7f970357]
 pci_device_remove+0x3f/0xb0
 device_release_driver_internal+0x1be/0x2d0
 pci_stop_bus_device+0x68/0xa0
 pci_stop_bus_device+0x39/0xa0
 pci_stop_bus_device+0x39/0xa0
 pciehp_unconfigure_device+0x12b/0x1d0
 pciehp_disable_slot+0x65/0x120
 pciehp_handle_presence_or_link_change+0x7a/0x450
 pciehp_ist+0xf5/0x320
 irq_thread_fn+0x1d/0x40
 irq_thread+0x19b/0x260
 ? irq_forced_thread_fn+0x70/0x70
 ? irq_thread_fn+0x40/0x40
 ? irq_forced_secondary_handler+0x20/0x20
 ? irq_forced_secondary_handler+0x20/0x20
 kthread+0x147/0x160
 ? kthread_blkcg+0x30/0x30
 ret_from_fork+0x34/0x40
 ? kthread_blkcg+0x30/0x30
 ret_from_fork_asm+0x11/0x20
 </TASK>

Other affected kernel threads
INFO: task NetworkManager:1294 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:NetworkManager  state:D stack:0     pid:1294  tgid:1294  ppid:1
   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? __kmalloc_large_node+0xb9/0x130
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? inet_rtm_delroute+0x190/0x190
 ? fib6_run_gc+0x230/0x230
 ? fib6_run_gc+0x230/0x230
 ? update_curr+0x159/0x240
 ? pick_next_task_fair+0x46a/0x6a0
 ? raw_spin_rq_unlock_irq+0x7/0x30
 ? __schedule+0x709/0x1380
 ? housekeeping_any_cpu+0xbe/0xf0
 ? get_nohz_timer_target+0x101/0x140
 ? timerqueue_del+0x2f/0x50
 ? packet_poll+0x167/0x190
 ? sock_poll+0x100/0x120
 ? hrtimer_try_to_cancel+0xb8/0xd0
 ? free_unref_page+0xc2/0x1c0
 ? poll_freewait+0x9f/0xb0
 ? do_sys_poll+0x612/0x6e0
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 ? __skb_try_recv_datagram+0xc8/0x1d0
 ____sys_sendmsg+0x1a5/0x2a0
 ___sys_sendmsg+0x293/0x2d0
 __x64_sys_sendmsg+0x10d/0x140
 do_syscall_64+0x92/0x170
 ? __ct_user_enter+0x2b/0x90
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7971ac52c02b
RSP: 002b:00007ffc684c09a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00005661e9bc5be0 RCX: 00007971ac52c02b
RDX: 0000000000000000 RSI: 00007ffc684c09e0 RDI: 000000000000000d
RBP: 00007ffc684c09c0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00005661e9c45030 R15: 00005661e9bc5cac
 </TASK>
INFO: task geoclue:2325 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:geoclue         state:D stack:0     pid:2325  tgid:2325  ppid:1
   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? sched_clock+0x10/0x20
 ? sched_clock_cpu+0x10/0x190
 ? raw_spin_rq_lock_nested+0x1a/0x80
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_dellink+0x500/0x500
 ? rtnl_dellink+0x500/0x500
 ? __ia32_compat_sys_ppoll_time64+0x170/0x170
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7ad712b2beea
RSP: 002b:00007fff94c1fd80 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ad712b2beea
RDX: 0000000000000014 RSI: 00007fff94c1fe10 RDI: 0000000000000007
RBP: 00007fff94c1fdb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 00007fff94c1fe10
R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task pool-geoclue:84396 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:pool-geoclue    state:D stack:0     pid:84396 tgid:2325  ppid:1
   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_dellink+0x500/0x500
 ? rtnl_dellink+0x500/0x500
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 ? __check_object_size+0x40/0x2b0
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? __ct_user_enter+0x6a/0x90
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? __ct_user_enter+0x6a/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7ad712b2c0e4
RSP: 002b:00007ad6e7dfdf40 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ad712b2c0e4
RDX: 0000000000000014 RSI: 00007ad6e7dff070 RDI: 000000000000000b
RBP: 00007ad6e7dfdf80 R08: 00007ad6e7dff014 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000b
R13: 0000000000000010 R14: 00007ad6e7dff030 R15: 00000000d3fb1bea
 </TASK>
INFO: task Qt bearer threa:4002 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:Qt bearer threa state:D stack:0     pid:4002  tgid:3506
ppid:3034   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? sched_clock+0x10/0x20
 ? get_vtime_delta+0x10/0xb0
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_getlink+0x6b0/0x6b0
 ? rtnl_getlink+0x6b0/0x6b0
 ? xa_load+0xa5/0xc0
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 ? sk_setsockopt+0xfa9/0x1200
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? __ct_user_enter+0x6a/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x76f3c692beea
RSP: 002b:000076f3a51fecb0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000076f3c692beea
RDX: 0000000000000020 RSI: 000076f3a51fed60 RDI: 0000000000000023
RBP: 000076f3a51fece0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000076f3a51fee38
R13: 000076f378026b30 R14: 000076f3a51fed30 R15: 000076f378026b48
 </TASK>
INFO: task gnome-software:3529 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:gnome-software  state:D stack:0     pid:3529  tgid:3529
ppid:3034   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? schedule_hrtimeout_range_clock+0x102/0x180
 ? rtnl_dellink+0x500/0x500
 ? rtnl_dellink+0x500/0x500
 ? poll_freewait+0x45/0xb0
 ? do_sys_poll+0x612/0x6e0
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x7d6be892beea
RSP: 002b:00007ffd94e01560 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007d6be892beea
RDX: 0000000000000014 RSI: 00007ffd94e015f0 RDI: 000000000000000d
RBP: 00007ffd94e01590 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 00007ffd94e015f0
R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task Qt bearer threa:3960 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:Qt bearer threa state:D stack:0     pid:3960  tgid:3550
ppid:3034   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? inet6_dump_addr+0x3ab/0x420
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_getlink+0x6b0/0x6b0
 ? rtnl_getlink+0x6b0/0x6b0
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? do_sock_setsockopt+0xe1/0x170
 ? sched_clock+0x10/0x20
 ? get_vtime_delta+0x10/0xb0
 ? ct_kernel_exit+0x6f/0x90
 ? __ct_user_enter+0x6a/0x90
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x777a42b2beea
RSP: 002b:0000777a2abfecf0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000777a42b2beea
RDX: 0000000000000020 RSI: 0000777a2abfeda0 RDI: 000000000000001d
RBP: 0000777a2abfed20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000777a2abfee78
R13: 0000777a080285b0 R14: 0000777a2abfed70 R15: 0000777a080285c8
 </TASK>
INFO: task xdg-desktop-por:3821 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:xdg-desktop-por state:D stack:0     pid:3821  tgid:3821
ppid:2776   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_dellink+0x500/0x500
 ? rtnl_dellink+0x500/0x500
 ? __ep_eventpoll_poll+0x19c/0x1d0
 ? remove_wait_queue+0x17/0x60
 ? poll_freewait+0x45/0xb0
 ? do_sys_poll+0x612/0x6e0
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? do_syscall_64+0x9e/0x170
 ? __ct_user_enter+0x6a/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x79d76612beea
RSP: 002b:00007ffd480942a0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000079d76612beea
RDX: 0000000000000014 RSI: 00007ffd48094330 RDI: 0000000000000008
RBP: 00007ffd480942d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 00007ffd48094330
R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task DNS Res~ver #11:25588 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:DNS Res~ver #11 state:D stack:0     pid:25588 tgid:4934
ppid:3070   flags:0x00000002
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? __netif_rx+0x11/0xb0
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 netlink_dump+0x1c4/0x3f0
 __netlink_dump_start+0x2b3/0x340
 rtnetlink_rcv_msg+0x469/0x4a0
 ? rtnl_dellink+0x500/0x500
 ? rtnl_dellink+0x500/0x500
 ? dma_pte_clear_level+0x13a/0x210
 ? qi_submit_sync+0x86f/0x910
 ? put_pages_list+0x3f/0x150
 ? chacha_block_generic+0x7c/0x150
 ? rtnetlink_bind+0x30/0x30
 netlink_rcv_skb+0xed/0x120
 netlink_unicast+0x2ce/0x3f0
 netlink_sendmsg+0x39c/0x450
 ? __check_object_size+0x40/0x2b0
 __sys_sendto+0x2c8/0x350
 __x64_sys_sendto+0x26/0x30
 do_syscall_64+0x92/0x170
 ? syscall_exit_to_user_mode+0xb1/0xc0
 ? do_syscall_64+0x9e/0x170
 ? __ct_user_enter+0x6a/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
RIP: 0033:0x72d65892c0e4
RSP: 002b:000072d649cbb880 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000072d65892c0e4
RDX: 0000000000000014 RSI: 000072d649cbc9b0 RDI: 0000000000000053
RBP: 000072d649cbb8c0 R08: 000072d649cbc954 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000053
R13: 0000000000000010 R14: 000072d649cbc970 R15: 00000000b48fd654
 </TASK>
INFO: task kworker/u88:2:31385 blocked for more than 120 seconds.
      Not tainted 6.9.0-rc2 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u88:2   state:D stack:0     pid:31385 tgid:31385 ppid:2
   flags:0x00004000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 __schedule+0x5dd/0x1380
 ? newidle_balance+0x35d/0x380
 schedule+0x6e/0xf0
 schedule_preempt_disabled+0x15/0x20
 __mutex_lock+0x2a0/0x750
 addrconf_verify_work+0x20/0x30
 process_scheduled_works+0x1f4/0x450
 worker_thread+0x349/0x5e0
 ? pr_cont_work+0x1c0/0x1c0
 kthread+0x147/0x160
 ? kthread_blkcg+0x30/0x30
 ret_from_fork+0x34/0x40
 ? kthread_blkcg+0x30/0x30
 ret_from_fork_asm+0x11/0x20
 </TASK>
