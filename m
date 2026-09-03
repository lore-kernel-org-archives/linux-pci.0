Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB244E042;
	Thu,  3 Sep 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434462; cv=none; b=o7BvrXAqa8Mw1wT/cX81WXATJBHV1Jtepr87nP8XYnco0ojN1WEgYpVnSbXouSXBtxdLFbhNaEEqNd5u/VczNYVZ7zBxgzNQN6SSNts1o665g5m9T7C4ozzCAzJmdzMV/pjWoWVjpu25gDKcjRzKUlYOnIz3DwCCnxmOZYHLnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434462; c=relaxed/simple;
	bh=LyEp3TbHrjZAzO1HK0cDV1nfJ8DDtoKj3lUa4xfWSFM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GuQkWZPk7C9sKkcVoMN0mOnw7W4ZHdQ4QUoqo+b0Q6OzB+nSf/bLCs9F1ztN865t0sjb4q3yv1rKk5v9EQCU3U+QeQP+/7ETpgW9GR8P5EZz1HKdaIYeE+WQyaUN6igbQjBcO+8ya5yA0krcxd5jlMF30SuQnqHDPWkcrdZdtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWiO2HtA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWiO2HtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788434455; x=1819970455;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LyEp3TbHrjZAzO1HK0cDV1nfJ8DDtoKj3lUa4xfWSFM=;
  b=OWiO2HtAzda84RI6oH+/Vx2T1qYyZ8Ug440CNhc/ypmptet4VNf72g4x
   pQJHnoffEUM9xVKzBa4dd4exsYgFI6KshHIriJyx48HVHFBRWfxr4jeEj
   wjTn5CD8Yjs3t4OgClpWFhvNDWkWQSdgGc407BuDh3xZrrWe3tJNBy5eK
   J4/NoIugqJdu/qxgnyiIi7u27+wJMtOG2gr/n0BZYmAkWJISNOAbo9D6b
   5bnWkL1djvQidnE8/WikPGnd1rEdy7TN8FVPYactgRVWJnwYv9OmX+8GO
   OREIpy7euw/4W7lfGhnGyjxT5JHXsOtkKpzOfRpsrNmdNztbvEY/4xGsu
   Q==;
X-CSE-ConnectionGUID: wB6tsQtuSi6DEu7bYfVkEA==
X-CSE-MsgGUID: AGazmUoVQLOGS+QUTwOGdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87853099"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="87853099"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:20:52 -0700
X-CSE-ConnectionGUID: DLboxSHaRB6+LiLCLNbPFA==
X-CSE-MsgGUID: o1Y826pgQfqT3EJ7vVxuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="273446960"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.119])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:20:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Sep 2026 14:20:46 +0300 (EEST)
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: fix use-after-free in pci_pme_list_scan()
In-Reply-To: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
Message-ID: <ed26d48b-6f82-ebac-c737-5d951dfc206d@linux.intel.com>
References: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Torsten Hilbrich wrote:

> struct pci_pme_device holds a raw, non-refcounted pointer to the
> pci_dev it tracks. A device is added to pci_pme_list by pci_pme_active()
> only while its pme_poll flag is set, but that flag can be cleared by the
> various PME wakeup paths (pci_acpi_wake_dev(), pcie_pme_handle_request(),
> pcie_pme_walk_bus(), pci_pme_wakeup()) without removing the entry from the
> list.
> 
> On device teardown, pci_stop_dev() -> pci_pme_active(dev, false) skips
> the list removal whenever pme_poll has already been cleared, so the entry
> is left behind. pci_destroy_dev() then frees the pci_dev while its entry
> is still on the list, and the periodic pci_pme_list_scan() work
> dereferences the freed structure, causing a use-after-free (observed as a
> general protection fault on a PaX 0xfe-poisoned pointer).
> 
> Take a reference to the pci_dev for each list entry (pci_dev_get() when
> adding) and drop it when the entry is removed, both in pci_pme_list_scan()
> and in pci_pme_active(). This keeps the device alive as long as its entry
> is on the list, regardless of the pme_poll state or teardown ordering.
> 
> Patch is based on v7.3-rc1.
> 
> The problem was found when using PaX memory free poisoning (0xfe). Here
> is the panic from a v6.18.45 test run. It happened after disconnecting
> a TB4 dock with 2 displays connected.
> 
> <6>[66245.416348] usb 5-1.4.4.4: USB disconnect, device number 19
> <6>[66245.448107] [drm] drm_dp_dpcd_access card0-DP-4 via AMDGPU DM aux hw bus 5: Too many retries, giving up. First error: -5, First reply: 0x0, Last reply: 0x0, Request: 0x9, Address: 0x111, Size: 0x1
> <6>[66245.485882] [drm] drm_dp_dpcd_access card0-DP-4 via AMDGPU DM aux hw bus 5: Too many retries, giving up. First error: -5, First reply: 0x0, Last reply: 0x0, Request: 0x8, Address: 0x111, Size: 0x1
> <4>[66245.930686] Oops: general protection fault, probably for non-canonical address 0xfefefefefefeff36: 0000 [#1] SMP NOPTI
> <4>[66245.931209] CPU: 0 UID: 0 PID: 21940 Comm: kworker/0:4 Tainted: P           O        6.18.45-grsec+ #1 PREEMPT(voluntary) 
> <4>[66245.931623] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
> <4>[66245.931890] Hardware name: LENOVO 21QKS01V00/21QKS01V00, BIOS R2XET42T (1.21 ) 08/20/2026
> <4>[66245.932213] Workqueue: events_freezable pci_pme_list_scan
> <4>[66245.932475] RIP: 0010:[<ffffffff818f09ec>] pci_pme_list_scan+0x4c/0x1f0
> <4>[66245.932761] Code: 1f 03 4c 8b 23 48 89 df 48 81 fb c0 64 ae 84 0f 84 36 01 00 00 48 8b 6b 10 f6 85 9d 00 00 00 20 0f 84 88 00 00 00 48 8b 45 10 <48> 8b 58 38 48 85 db 0f 84 b2 00 00 00 49 89 de 49 81 c6 c0 00 00
> <4>[66245.933346] RSP: 0018:ffffc9002109bee8 EFLAGS: 00010202
> <4>[66245.933607] RAX: fefefefefefefefe RBX: ffff8901040c10e0 RCX: ffff8907dca25828
> <4>[66245.933916] RDX: ffff890181762940 RSI: 0000000000000000 RDI: ffff8901040c10e0
> <4>[66245.934227] RBP: ffff8905fe998000 R08: ffffffffffffffff R09: ffff89010000d4c0
> <4>[66245.934538] R10: ffff89046b63ff40 R11: fefefefefefefeff R12: ffff8901040c1a60
> <4>[66245.934848] R13: ffff8907dca25800 R14: ffff8901000a3205 R15: 0000000000000000
> <4>[66245.935172] RBX: kmalloc-32+0x0/0x20 [slab object]
> <4>[66245.935433] RCX: cpu_worker_pools+0x28/0x640 [percpu0 25828]
> <4>[66245.935718] RDX: task_struct[kworker/0:4+events_freezable 21940 21940]+0x0/0xdc0 [slab object]
> <4>[66245.936076] RDI: kmalloc-32+0x0/0x20 [slab object]
> <4>[66245.936339] RBP: kmalloc-4k+0x0/0x1000 [slab object]
> <4>[66245.936609] RSP: vm[ffffc90021098000 4002 kernel_clone+0xcc/0x450]+0x3ee8/0x4000 [vmalloc]
> <4>[66245.936958] R08: -EPERM
> <4>[66245.937166] R09: kmalloc-512+0xc0/0x200 [slab object]
> <4>[66245.937437] R10: kmalloc-192+0x80/0xc0 [slab object]
> <4>[66245.937706] R12: kmalloc-32+0x0/0x20 [slab object]
> <4>[66245.937972] R13: cpu_worker_pools+0x0/0x640 [percpu0 25800]
> <4>[66245.938261] R14: pool_workqueue+0x5/0x200 [slab object]
> <4>[66245.938542] FS:  0000000000000000(0000) GS:ffff890856bdd000(0000) knlGS:0000000000000000
> <4>[66245.938893] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[66245.939187] CR2: ffff9a8a2c97d000 CR3: 0000000182794000 CR4: 0000000000740ef0 shadow CR4: 0000000000740ef0
> <4>[66245.939581] PKRU: 55555554
> <4>[66245.939807] Stack:
> <4>[66245.940015]  ffff89046b63fec0 ffffffff84ae6440 ffff8901000a3200 ffff8907dca25800
> <4>[66245.940355]  ffff8901000a3205 ffffffff812f497a ffff8907dca25800 ffff89046b63ff00
> <4>[66245.940697]  ffff8907dca25828 ffff89046b63fec0 ffff8907dca25800 0000000000000000
> <4>[66245.941045] Call Trace:
> <4>[66245.941269]  <TASK>
> <4>[66245.941484]  [<ffffffff812f497a>] process_one_work+0x1ca/0x4b0 ffffc9002109bf10
> <4>[66245.941829]  [<ffffffff812f569c>] worker_thread+0x16c/0x2f0 ffffc9002109bf48
> <4>[66245.942165]  [<ffffffff812f5530>] ? __pfx_worker_thread+0x10/0x10 ffffc9002109bf68
> <4>[66245.942513]  [<ffffffff812fe89f>] kthread+0x12f/0x270 ffffc9002109bf80
> <4>[66245.942837]  [<ffffffff812fe770>] ? __pfx_kthread+0x10/0x10 ffffc9002109bf88
> <4>[66245.943174]  [<ffffffff812fe770>] ? __pfx_kthread+0x10/0x10 ffffc9002109bf98
> <4>[66245.943508]  [<ffffffff81265203>] ret_from_fork+0x173/0x190 ffffc9002109bfc8
> <4>[66245.943842]  [<ffffffff812fe770>] ? __pfx_kthread+0x10/0x10 ffffc9002109bfd0
> <4>[66245.944175]  [<ffffffff81221639>] ret_from_fork_asm+0x29/0x50 ffffc9002109bfe8
> <4>[66245.944512]  </TASK>
> <4>[66245.944727] Modules linked in: vtx(O) vboxdrv(O) pl2303 ftdi_sio usbserial modstop_test_unload(O) mcd_drv(O) wacom mac_passthrough(O) dm_crypt_sina(O) chiasmus(PO) cryptoapi_plugger(O) dm_mod
> <4>[66245.945340] ---[ end trace 0000000000000000 ]---

Can you trim this dump a bit, at least the level and timestamps are not 
useful here and no need for the end trace line either.

> Assisted-by: LLM opencode
> Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..b3a4b710d7c8d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2410,6 +2410,7 @@ static void pci_pme_list_scan(struct work_struct *work)
>  				pm_runtime_put(bdev);
>  		} else {
>  			list_del(&pme_dev->list);
> +			pci_dev_put(pdev);
>  			kfree(pme_dev);
>  		}
>  	}
> @@ -2497,7 +2498,7 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
>  				pci_warn(dev, "can't enable PME#\n");
>  				return;
>  			}
> -			pme_dev->dev = dev;
> +			pme_dev->dev = pci_dev_get(dev);
>  			mutex_lock(&pci_pme_list_mutex);
>  			list_add(&pme_dev->list, &pci_pme_list);
>  			if (list_is_singular(&pci_pme_list))
> @@ -2510,6 +2511,7 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
>  			list_for_each_entry(pme_dev, &pci_pme_list, list) {
>  				if (pme_dev->dev == dev) {
>  					list_del(&pme_dev->list);
> +					pci_dev_put(pme_dev->dev);
>  					kfree(pme_dev);

How about adding a helper for these three calls as they seem common in 
those two contexts.

>  					break;
>  				}
> 
