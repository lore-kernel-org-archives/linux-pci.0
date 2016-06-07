Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37709 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbcFGJTA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 05:19:00 -0400
Date: Tue, 7 Jun 2016 11:17:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rui Wang <rui.y.wang@intel.com>
cc: rjw@rjwysocki.net, Tony Luck <tony.luck@intel.com>,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/ioapic: Fix wrong pointers in
 ioapic_setup_resources()
In-Reply-To: <1465284073-354-3-git-send-email-rui.y.wang@intel.com>
Message-ID: <alpine.DEB.2.11.1606071111100.28031@nanos>
References: <1465284073-354-1-git-send-email-rui.y.wang@intel.com> <1465284073-354-3-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

B1;2802;0cOn Tue, 7 Jun 2016, Rui Wang wrote:
> On a 4-socket brickland, hot-removing one ioapic is fine. Hot-removing
> the 2nd one causes panic:
> 
> [  453.422259] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000030
> [  453.431059] IP: [<ffffffff8109a8c2>] release_resource+0x22/0x80

<Useless information>
> [  453.437713] PGD 0
> [  453.439976] Oops: 0000 [#1] SMP
> [  453.698876]  ffff88046267fd20 ffffffff8104e3ff 0000000000000000
> ffff88046267fd58
</Useless information>

> [  453.707195] Call Trace:
> [  453.709935]  [<ffffffff81057965>] mp_unregister_ioapic+0x125/0x180
> [  453.716846]  [<ffffffff8104e3ff>] acpi_unregister_ioapic+0x1f/0x40
> [  453.723759]  [<ffffffff8140cfe3>] acpi_ioapic_remove+0x5f/0xf0
> [  453.730283]  [<ffffffff813e0645>] acpi_pci_root_remove+0x2c/0x80
> [  453.737002]  [<ffffffff813da86b>] acpi_bus_trim+0x5a/0x8d
> [  453.743039]  [<ffffffff813dc31d>] acpi_device_hotplug+0x1b7/0x418
> [  453.749851]  [<ffffffff813d4f8a>] acpi_hotplug_work_fn+0x1e/0x29

<Useless information>
> [  453.756570]  [<ffffffff810ad67f>] process_one_work+0x14f/0x3d0
> [  453.763092]  [<ffffffff810adf35>] worker_thread+0x125/0x4b0
> [  453.769325]  [<ffffffff816fd5c1>] ? __schedule+0x2b1/0x700
> [  453.775459]  [<ffffffff810ade10>] ? rescuer_thread+0x370/0x370
> [  453.781981]  [<ffffffff810b3a58>] kthread+0xd8/0xf0
> [  453.787435]  [<ffffffff810b3980>] ? kthread_park+0x60/0x60
> [  453.793570]  [<ffffffff8170190f>] ret_from_fork+0x3f/0x70
> [  453.800203]  [<ffffffff810b3980>] ? kthread_park+0x60/0x60
> [  453.806914] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
> e5 53 48 89 fb 48 c7 c7 f8 c0 e3 81 e8 87 69 66 00 48 8b 4b 20 b8 ea ff
> ff ff <48> 8b 51 30 48 85 d2 74 1d 48 39 d3 75 0a eb 3f 48 39 c3 74 1b
> [  453.829861] RIP  [<ffffffff8109a8c2>] release_resource+0x22/0x80
> [  453.837188]  RSP <ffff88046267fcc8>
> [  453.841673] CR2: 0000000000000030
</Useless information>

Please trim the dumps to the relevant information

> Fix it by assigning the correct pointers to ioapics[i].iomem_res in
> ioapic_setup_resources().

This does not explain the splat above. Please explain which pointer is
wrong and what effects that has.

> Also simplify the function by removing the redundant 'num' variable.

Please don't do that. This makes the patch hard to read. Split this into a
minimal bugfix, which can be backported and a cleanup patch which gets rid of
the extra variable.
 
> -		ioapics[i].iomem_res = res;
> +		ioapics[i].iomem_res = &res[i];

If I read the patch correctly, then this is the fix. Right? So please make it
a one liner and send a cleanup patch seperately.

Thanks,

	tglx
