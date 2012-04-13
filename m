Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:34728 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308Ab2DMPXf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 11:23:35 -0400
Message-ID: <4F8844E1.5080806@snewbury.org.uk>
Date: Fri, 13 Apr 2012 16:23:13 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Daniel Vetter <daniel@ffwll.ch>
CC: linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: drm-next i915 regression? ( was: Re: PCI resources above 4GB)
References: <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com> <1334317529.2910.21.camel@Nokia-N900> <4F8814F7.20808@snewbury.org.uk> <4F8820F0.5010607@snewbury.org.uk> <4F88297B.3020200@snewbury.org.uk> <1334325128.2910.24.camel@Nokia-N900> <4F883364.3080601@snewbury.org.uk> <20120413141305.GI4525@phenom.ffwll.local> <4F88360E.704@snewbury.org.uk>
In-Reply-To: <4F88360E.704@snewbury.org.uk>
Content-Type: multipart/mixed;
 boundary="------------050800080807070406090806"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050800080807070406090806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/04/12 15:19, Steven Newbury wrote:
> On 13/04/12 15:13, Daniel Vetter wrote:
>> On Fri, Apr 13, 2012 at 03:08:36PM +0100, Steven Newbury wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>> 
>>> On 13/04/12 14:52, Steven Newbury wrote:
>>>> On Fri, 13 Apr 2012, 14:26:19 BST, Steven Newbury 
>>>> <steve@snewbury.org.uk> wrote:
>>>> 
>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>> 
>>>>> On 13/04/12 13:49, Steven Newbury wrote:
>>>>>> On 13/04/12 12:58, Steven Newbury wrote:
>>>>>> 
>>>>>>>> It's not stable, crashes soon after GMA comes up. 
>>>>>>>> (Could be unrelated breakage in linus/master? 
>>>>>>>> Probably not but I will verify.)   I noticed the
>>>>>>>> high allocations are occuring from the top of 64-bit
>>>>>>>>  address-space, whilst /proc/cpuinfo shows only 48 
>>>>>>>> bits of virtual addressing.   Could that be why..?
>>>>>>> To reply to myself again, I should have said crashes 
>>>>>>> shortly after Xorg initialises using the intel driver,
>>>>>>>  in both cases! I'm building a kernel now without the 
>>>>>>> patch set to see if it's unrelated.   If it still dies
>>>>>>>  I'll try applying your patch set to a branch without 
>>>>>>> the changes from linus/master... (should have done that
>>>>>>> anyway...)
>>>>>> 
>>>>>> Okay, I instead created a branch from an older 3.4-rc1+ 
>>>>>> kernel tree, running it now, and it seems to be stable. 
>>>>>> Something perhaps in the newer tree not playing nicely. 
>>>>>> I'll see if I can bisect it, or at least base of rc2 if 
>>>>>> that works... (I'm a little wary of crashing the system 
>>>>>> too much and losing my btrfs filesystem...)
>>>>> rc2 is fine as well.   Not sure what happened there, I
>>>>> need to be more careful about keeping a clean tree to work
>>>>>  from.
>>>> I'm pretty sure the crash was a from a drm-next regression. 
>>>> I'll try bisecting it....
>>> Sorry, posted too soon!  Almost as I clicked on send it froze 
>>> again (using rc2 + for-pci-res-alloc ).  I had problems with 
>>> the earlier patches re. X/i915 stability.  Strange.  I'll see 
>>> if I can track it down.
> 
>> Please upgrade to the latest version of Linus' upstream git. A 
>> few fixes for regressions in drm/i915 just landed there for -rc3.
>> -Daniel
> 
> Okay.  I'll try clean latest linus + for-pci-res-alloc.  Will 
> report back.
> 
Looks like either a btrfs regression or bad interaction with
for-pci-res-alloc.  Oops attached.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+IROAACgkQGcb56gMuC63hFQCguhdhV6AUoNKHnasgD0zjqJXt
AwkAoKh8Rdrj3PqzuYUXpUkvyw3TujZV
=XiAW
-----END PGP SIGNATURE-----

--------------050800080807070406090806
Content-Type: text/plain; charset=UTF-8;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="oops"

Apr 13 15:10:02 infinity kernel: BUG: unable to handle kernel NULL pointer dereference at           (null)
Apr 13 15:10:02 infinity kernel: IP: [<ffffffffa02778d0>] find_workspace+0x92/0x190 [btrfs]
Apr 13 15:10:02 infinity kernel: PGD 7bfb2067 PUD d8978067 PMD 0 
Apr 13 15:10:02 infinity kernel: Oops: 0000 [#1] SMP 
Apr 13 15:10:02 infinity kernel: CPU 1 
Apr 13 15:10:02 infinity kernel: Modules linked in: cryptd aes_x86_64 aes_generic fuse fbcon bitblit fbcon_rotate fbcon_ccw fbcon_ud fbcon_cw softcursor font tileblit joydev arc4 dell_wmi sparse_keymap 8250_pnp dell_laptop dcdbas btusb bluetooth snd_hda_codec_idt crc16 microcode psmouse pcspkr iwl4965 iwlegacy snd_hda_intel mac80211 snd_hda_codec snd_hwdep tg3 snd_pcm cfg80211 snd_page_alloc snd_timer snd soundcore wmi 8250 serial_core evdev smsc47m192 hwmon_vid tpm_tis tpm tpm_bios rfkill loop nfs nfs_acl auth_rpcgss fscache lockd sunrpc phc_intel mperf coretemp hwmon autofs4 usb_storage usb_libusual uas btrfs zlib_deflate sd_mod pata_acpi ahci libahci ata_piix libata scsi_mod ehci_hcd uhci_hcd usbcore usb_common i915 video intel_agp intel_gtt cfbfillrect cfbimgblt cfbcopyarea i2c_algo_bit backlight drm_kms_helper drm agpgart
Apr 13 15:10:02 infinity kernel: 
Apr 13 15:10:02 infinity kernel: Pid: 2591, comm: btrfs-endio-2 Not tainted 3.4.0-rc2-wl-00669-g502ad46 #110 Dell Inc. Latitude D830                   /0HN341
Apr 13 15:10:02 infinity kernel: RIP: 0010:[<ffffffffa02778d0>]  [<ffffffffa02778d0>] find_workspace+0x92/0x190 [btrfs]
Apr 13 15:10:02 infinity kernel: RSP: 0018:ffff880078e7fcc0  EFLAGS: 00010207
Apr 13 15:10:02 infinity kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff88007bde9000
Apr 13 15:10:02 infinity kernel: RDX: ffffffffa029d500 RSI: dead000000200200 RDI: ffffffffa029d4f6
Apr 13 15:10:02 infinity kernel: RBP: ffff880078e7fd50 R08: 0000000000000008 R09: 0000000000004000
Apr 13 15:10:02 infinity kernel: R10: 0000000000000200 R11: 0000000000000200 R12: ffff880078e7fcf8
Apr 13 15:10:02 infinity kernel: R13: ffffffffa029d504 R14: ffffffffa029d4f6 R15: ffff880078e7fd10
Apr 13 15:10:02 infinity kernel: FS:  0000000000000000(0000) GS:ffff88011fd00000(0000) knlGS:0000000000000000
Apr 13 15:10:02 infinity kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Apr 13 15:10:02 infinity kernel: CR2: 0000000000000000 CR3: 000000007bfe6000 CR4: 00000000000007e0
Apr 13 15:10:02 infinity kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 13 15:10:02 infinity kernel: DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Apr 13 15:10:02 infinity kernel: Process btrfs-endio-2 (pid: 2591, threadinfo ffff880078e7e000, task ffff880119880000)
Apr 13 15:10:02 infinity kernel: Stack:
Apr 13 15:10:02 infinity kernel: ffff880078e7fcd0 ffffffff810bcacf ffff880119880000 ffffffffa029d500
Apr 13 15:10:02 infinity kernel: 0000000200000003 ffffffffa029d548 ffff880078e7fd00 ffffffff811a1060
Apr 13 15:10:02 infinity kernel: ffff880078e7fd20 ffffffff811764f9 0000000000000200 ffff880078e7fd40
Apr 13 15:10:02 infinity kernel: Call Trace:
Apr 13 15:10:02 infinity kernel: [<ffffffff810bcacf>] ? mempool_free_slab+0x17/0x19
Apr 13 15:10:02 infinity kernel: [<ffffffff811a1060>] ? __crc32c_le+0x10/0x12
Apr 13 15:10:02 infinity kernel: [<ffffffff811764f9>] ? chksum_update+0x19/0x24
Apr 13 15:10:02 infinity kernel: [<ffffffffa02785ee>] btrfs_decompress_biovec+0x2b/0x7c [btrfs]
Apr 13 15:10:02 infinity kernel: [<ffffffffa027874e>] end_compressed_bio_read+0x10f/0x19d [btrfs]
Apr 13 15:10:02 infinity kernel: [<ffffffff81123ccd>] bio_endio+0x2d/0x2f
Apr 13 15:10:02 infinity kernel: [<ffffffffa023beb2>] end_workqueue_fn+0x38/0x3d [btrfs]
Apr 13 15:10:02 infinity kernel: [<ffffffffa02696f8>] worker_loop+0x16e/0x4a2 [btrfs]
Apr 13 15:10:02 infinity kernel: [<ffffffffa026958a>] ? btrfs_queue_worker+0x281/0x281 [btrfs]
Apr 13 15:10:02 infinity kernel: [<ffffffff8104c0e6>] kthread+0x8b/0x93
Apr 13 15:10:02 infinity kernel: [<ffffffff8136b734>] kernel_thread_helper+0x4/0x10
Apr 13 15:10:02 infinity kernel: [<ffffffff8104c05b>] ? kthread_freezable_should_stop+0x48/0x48
Apr 13 15:10:02 infinity kernel: [<ffffffff8136b730>] ? gs_change+0xb/0xb
Apr 13 15:10:02 infinity kernel: Code: 65 48 8b 04 25 80 b8 00 00 48 89 45 80 4c 89 f7 e8 be 20 0f e1 48 8b 55 88 48 8b 02 48 39 d0 74 3d 48 be 00 02 20 00 00 00 ad de <48> 8b 08 48 8b 50 08 48 89 51 08 48 89 0a 48 b9 00 01 10 00 00 
Apr 13 15:10:02 infinity kernel: RIP  [<ffffffffa02778d0>] find_workspace+0x92/0x190 [btrfs]
Apr 13 15:10:02 infinity kernel: RSP <ffff880078e7fcc0>
Apr 13 15:10:02 infinity kernel: CR2: 0000000000000000
Apr 13 15:10:02 infinity kernel: ---[ end trace 2e6b178742035e68 ]---
Apr 13 15:10:07 infinity kernel: ICMPv6 RA: ndisc_router_discovery() failed to add default route.
Apr 13 15:10:17 infinity NetworkManager[1019]: nm_ip6_config_add_nameserver: assertion `IN6_ARE_ADDR_EQUAL (nameserver, &nameservers[i]) == FALSE' failed
Apr 13 15:10:22 infinity NetworkManager[1019]: nm_ip6_config_add_nameserver: assertion `IN6_ARE_ADDR_EQUAL (nameserver, &nameservers[i]) == FALSE' failed
Apr 13 15:10:22 infinity NetworkManager[1019]: <info> Clearing nscd hosts cache.
Apr 13 15:10:22 infinity NetworkManager[1019]: <info> Clearing nscd hosts cache.
Apr 13 15:10:22 infinity NetworkManager[1019]: <info> Policy set 'snewbury.org.uk' (wlan0) as default for IPv4 routing and DNS.
Apr 13 15:10:22 infinity NetworkManager[1019]: <info> Policy set 'snewbury.org.uk' (wlan0) as default for IPv6 routing and DNS.
Apr 13 15:10:22 infinity NetworkManager[1019]: nm_ip6_config_add_nameserver: assertion `IN6_ARE_ADDR_EQUAL (nameserver, &nameservers[i]) == FALSE' failed
Apr 13 15:10:41 infinity NetworkManager[1019]: nm_ip6_config_add_nameserver: assertion `IN6_ARE_ADDR_EQUAL (nameserver, &nameservers[i]) == FALSE' failed
Apr 13 15:10:47 infinity NetworkManager[1019]: nm_ip6_config_add_nameserver: assertion `IN6_ARE_ADDR_EQUAL (nameserver, &nameservers[i]) == FALSE' failed
Apr 13 15:11:03 infinity kernel: INFO: rcu_sched self-detected stall on CPU { 1}  (t=60000 jiffies)
Apr 13 15:11:03 infinity kernel: Pid: 819, comm: btrfs-endio-2 Tainted: G      D      3.4.0-rc2-wl-00669-g502ad46 #110
Apr 13 15:11:03 infinity kernel: Call Trace:
Apr 13 15:11:03 infinity kernel: <IRQ>  [<ffffffff81093d0f>] __rcu_pending+0xc2/0x3c4
Apr 13 15:11:03 infinity kernel: [<ffffffff8109403a>] rcu_pending+0x29/0x5a
Apr 13 15:11:03 infinity kernel: [<ffffffff81094686>] rcu_check_callbacks+0x57/0x76
Apr 13 15:11:03 infinity kernel: [<ffffffff8103e5a1>] update_process_times+0x3f/0x76
Apr 13 15:11:03 infinity kernel: [<ffffffff8106ed0f>] tick_sched_timer+0x70/0x90
Apr 13 15:11:03 infinity kernel: [<ffffffff8104f401>] __run_hrtimer+0xad/0x151
Apr 13 15:11:03 infinity kernel: [<ffffffff8106ec9f>] ? tick_nohz_handler+0xce/0xce
Apr 13 15:11:03 infinity kernel: [<ffffffff8104fb6c>] hrtimer_interrupt+0xe0/0x19d
Apr 13 15:11:03 infinity kernel: [<ffffffff8136bf7c>] smp_apic_timer_interrupt+0x77/0x8a
Apr 13 15:11:03 infinity kernel: [<ffffffff8136b0c7>] apic_timer_interrupt+0x67/0x70
Apr 13 15:11:03 infinity kernel: <EOI>  [<ffffffff81073e3f>] ? do_raw_spin_lock+0x17/0x1d
Apr 13 15:11:03 infinity kernel: [<ffffffff81369986>] _raw_spin_lock+0xe/0x10
Apr 13 15:11:03 infinity kernel: [<ffffffffa02778ba>] find_workspace+0x7c/0x190 [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffff811a1060>] ? __crc32c_le+0x10/0x12
Apr 13 15:11:03 infinity kernel: [<ffffffff811764f9>] ? chksum_update+0x19/0x24
Apr 13 15:11:03 infinity kernel: [<ffffffffa02785ee>] btrfs_decompress_biovec+0x2b/0x7c [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffffa027874e>] end_compressed_bio_read+0x10f/0x19d [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffff81123ccd>] bio_endio+0x2d/0x2f
Apr 13 15:11:03 infinity kernel: [<ffffffffa023beb2>] end_workqueue_fn+0x38/0x3d [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffffa02696f8>] worker_loop+0x16e/0x4a2 [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffffa026958a>] ? btrfs_queue_worker+0x281/0x281 [btrfs]
Apr 13 15:11:03 infinity kernel: [<ffffffff8104c0e6>] kthread+0x8b/0x93
Apr 13 15:11:03 infinity kernel: [<ffffffff8136b734>] kernel_thread_helper+0x4/0x10
Apr 13 15:11:03 infinity kernel: [<ffffffff8104c05b>] ? kthread_freezable_should_stop+0x48/0x48
Apr 13 15:11:03 infinity kernel: [<ffffffff8136b730>] ? gs_change+0xb/0xb

--------------050800080807070406090806--
