Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Jul 2018 09:06:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
Message-ID: <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc, Thomas]

On Wed, Jul 18, 2018 at 03:28:15PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a MSI B350M MORTAR with AMD Ryzen 3 2200g (Raven) with Linux 4.18-rc5+
> and Debian Sid/unstable the system freezes with the messages below.
> 
> ```
> $ git log --oneline -1
> 30b06abfb92b (HEAD -> master, origin/master, origin/HEAD) Merge tag 'pinctrl-v4.18-3' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> $ git describe --dirty
> v4.18-rc5-36-g30b06abfb92b
> ```
> 
> Serial log (unfortunately *quiet* passed on command line):
> 
> ```
> 93.885: [   23.020572] BUG: unable to handle kernel NULL pointer dereference at 000000000000003c
> 93.885: [   23.029011] PGD 0 P4D 0 
> 93.885: [   23.031670] Oops: 0000 [#1] SMP NOPTI
> 93.885: [   23.035455] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc5+ #1
> 93.885: [   23.042079] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> 93.886: [   23.049868] RIP: 0010:msi_set_mask_bit+0xe/0x70
> 93.913: [   23.049868] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48 
> 93.957: [   23.049880] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> 93.957: [   23.049881] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> 93.958: [   23.049882] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> 93.958: [   23.049882] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> 93.958: [   23.049882] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> 93.958: [   23.049883] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> 93.959: [   23.049884] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> 93.959: [   23.049884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 93.959: [   23.049885] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> 93.959: [   23.049885] Call Trace:
> 93.959: [   23.049887]  <IRQ>
> 93.960: [   23.049889]  __irq_move_irq+0x3c/0x70
> 93.960: [   23.049892]  apic_ack_irq+0x2b/0x30
> 93.960: [   23.049893]  handle_edge_irq+0x7d/0x1d0
> 93.960: [   23.049895]  handle_irq+0x1f/0x30
> 93.960: [   23.049898]  do_IRQ+0x41/0xc0
> 93.960: [   23.049899]  common_interrupt+0xf/0xf
> 93.961: [   23.049900]  </IRQ>
> 93.961: [   23.049902] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
> 93.961: [   23.049902] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3 7f 
> 93.961: [   23.049914] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd8
> 93.962: [   23.049915] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 000000000000001f
> 93.962: [   23.049915] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0000000000000000
> 93.962: [   23.049916] RBP: 0000000000000002 R08: 000000201f49eece R09: 0000000000003e14
> 93.962: [   23.049916] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: ffff9e8e4c664c00
> 93.963: [   23.049917] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0000000096860c6f
> 93.963: [   23.049919]  ? cpuidle_enter_state+0x92/0x2a0
> 93.963: [   23.049921]  do_idle+0x229/0x270
> 93.963: [   23.049923]  cpu_startup_entry+0x6f/0x80
> 93.963: [   23.049925]  start_kernel+0x50c/0x52c
> 93.963: [   23.049927]  secondary_startup_64+0xa5/0xb0
> 93.963: [   23.049928] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_codec_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_intel pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_helper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_timer snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt dm_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci aes_x86_64 xhci_pci
> 93.965: [   23.049959]  crypto_simd libahci cryptd glue_helper xhci_hcd libata scsi_mod usbcore gpio_amdpt gpio_generic
> 93.966: [   23.049963] CR2: 000000000000003c
> 93.966: [   23.049967] ---[ end trace 45709f5d819a95c4 ]---
> 93.966: [   23.131635] RIP: 0010:msi_set_mask_bit+0xe/0x70
> 93.966: [   23.422197] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48 
> 93.998: [   23.422209] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> 93.998: [   23.422210] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> 93.998: [   23.422211] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> 93.999: [   23.422211] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> 93.999: [   23.422212] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> 93.999: [   23.422212] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> 94.000: [   23.422213] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> 94.000: [   23.422213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 94.000: [   23.422214] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> 94.000: [   23.422215] Kernel panic - not syncing: Fatal exception in interrupt
> 94.001: [   23.442505] Kernel Offset: 0x5200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 94.001: [   23.554334] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 94.001: [   23.562144] ------------[ cut here ]------------
> 94.001: [   23.566929] sched: Unexpected reschedule of offline CPU#1!
> 94.002: [   23.572610] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x34/0x40
> 94.002: [   23.582078] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_codec_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_intel pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_helper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_timer snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt dm_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci aes_x86_64 xhci_pci
> 94.004: [   23.655181]  crypto_simd libahci cryptd glue_helper xhci_hcd libata scsi_mod usbcore gpio_amdpt gpio_generic
> 94.004: [   23.665290] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           4.18.0-rc5+ #1
> 94.005: [   23.673300] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> 94.005: [   23.681232] RIP: 0010:native_smp_send_reschedule+0x34/0x40
> 94.005: [   23.686911] Code: 05 d1 f6 0d 01 73 15 48 8b 05 e8 f7 e7 00 be fd 00 00 00 48 8b 40 30 e9 5a 9c 9b 00 89 fe 48 c7 c7 e0 b3 02 87 e8 d6 08 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 83 ec 20 
> 94.006: [   23.706603] RSP: 0018:ffff9e8e5e803af8 EFLAGS: 00010082
> 94.006: [   23.712040] RAX: 0000000000000000 RBX: ffff9e8e5e861b80 RCX: 0000000000000006
> 94.007: [   23.719474] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9e8e5e816730
> 94.007: [   23.726975] RBP: ffff9e8e4cadc9c0 R08: 00000000000008c9 R09: 0000000000000000
> 94.007: [   23.734416] R10: 0000000000000002 R11: 000000000000000f R12: ffff9e8e4cadd10c
> 94.008: [   23.741921] R13: ffff9e8e5e803b48 R14: 0000000000000046 R15: 0000000000021b80
> 94.008: [   23.749387] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> 94.009: [   23.757810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 94.009: [   23.763704] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> 94.009: [   23.771145] Call Trace:
> 94.009: [   23.773676]  <IRQ>
> 94.009: [   23.775794]  check_preempt_curr+0x7a/0x90
> 94.009: [   23.779958]  ttwu_do_wakeup+0x19/0x140
> 94.010: [   23.783843]  try_to_wake_up+0x1e3/0x4c0
> 94.010: [   23.787813]  autoremove_wake_function+0x11/0x50
> 94.010: [   23.792475]  __wake_up_common+0x7a/0x190
> 94.010: [   23.796537]  __wake_up_common_lock+0x7c/0xc0
> 94.010: [   23.800926]  irq_work_run_list+0x4d/0x70
> 94.010: [   23.804978]  smp_call_function_single_interrupt+0x32/0xc0
> 94.011: [   23.810578]  call_function_single_interrupt+0xf/0x20
> 94.011: [   23.815688] RIP: 0010:panic+0x201/0x247
> 94.011: [   23.819628] Code: eb a6 83 3d 2f 87 54 01 00 74 05 e8 88 54 02 00 48 c7 c6 60 26 7c 87 48 c7 c7 40 4d 03 87 e8 d3 18 06 00 fb 66 0f 1f 44 00 00 <31> db e8 27 5e 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 d7 86 54 
> 94.012: [   23.839139] RSP: 0018:ffff9e8e5e803d60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
> 94.012: [   23.846953] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
> 94.012: [   23.854334] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff9e8e5e816730
> 94.012: [   23.861741] RBP: ffff9e8e5e803dd0 R08: 00000000000008c7 R09: 0000000000000000
> 94.013: [   23.869140] R10: 0000000000000002 R11: 000000000000000f R12: 0000000000000000
> 94.013: [   23.876532] R13: 0000000000000000 R14: 0000000000000009 R15: 0000000000000001
> 94.013: [   23.883907]  ? call_function_single_interrupt+0xa/0x20
> 94.013: [   23.889224]  oops_end.cold.8+0xc/0x18
> 94.014: [   23.893036]  no_context+0x1be/0x380
> 94.014: [   23.896630]  __do_page_fault+0xd1/0x4e0
> 94.014: [   23.900597]  ? try_to_wake_up+0x54/0x4c0
> 94.014: [   23.904676]  ? try_to_wake_up+0x54/0x4c0
> 94.014: [   23.908727]  page_fault+0x1e/0x30
> 94.014: [   23.912151] RIP: 0010:msi_set_mask_bit+0xe/0x70
> 94.015: [   23.916850] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48 
> 94.015: [   23.936257] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> 94.015: [   23.941627] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> 94.016: [   23.948992] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> 94.016: [   23.956321] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> 94.016: [   23.963721] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> 94.016: [   23.971025] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> 94.016: [   23.978382]  ? __do_softirq+0x123/0x2bd
> 94.017: [   23.982330]  __irq_move_irq+0x3c/0x70
> 94.017: [   23.986073]  apic_ack_irq+0x2b/0x30
> 94.017: [   23.989668]  handle_edge_irq+0x7d/0x1d0
> 94.017: [   23.993582]  handle_irq+0x1f/0x30
> 94.017: [   23.996998]  do_IRQ+0x41/0xc0
> 94.017: [   24.000089]  common_interrupt+0xf/0xf
> 94.017: [   24.003882]  </IRQ>
> 94.017: [   24.006007] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
> 94.018: [   24.011134] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3 7f 
> 94.018: [   24.030413] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd8
> 94.018: [   24.038209] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 000000000000001f
> 94.018: [   24.045523] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0000000000000000
> 94.019: [   24.052799] RBP: 0000000000000002 R08: 000000201f49eece R09: 0000000000003e14
> 94.019: [   24.060148] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: ffff9e8e4c664c00
> 94.019: [   24.067487] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0000000096860c6f
> 94.019: [   24.074782]  ? cpuidle_enter_state+0x92/0x2a0
> 94.019: [   24.079300]  do_idle+0x229/0x270
> 94.020: [   24.082680]  cpu_startup_entry+0x6f/0x80
> 94.020: [   24.086760]  start_kernel+0x50c/0x52c
> 94.020: [   24.090573]  secondary_startup_64+0xa5/0xb0
> 94.020: [   24.094906] ---[ end trace 45709f5d819a95c5 ]---
> 94.020: [   24.099676] ------------[ cut here ]------------
> 94.020: [   24.104421] sched: Unexpected reschedule of offline CPU#2!
> 94.021: [   24.110102] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x34/0x40
> 94.021: [   24.119512] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_codec_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_intel pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_helper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_timer snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt dm_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci aes_x86_64 xhci_pci
> 94.023: [   24.192305]  crypto_simd libahci cryptd glue_helper xhci_hcd libata scsi_mod usbcore gpio_amdpt gpio_generic
> 94.023: [   24.202328] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W         4.18.0-rc5+ #1
> 94.023: [   24.210314] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> 94.024: [   24.218116] RIP: 0010:native_smp_send_reschedule+0x34/0x40
> 94.024: [   24.223753] Code: 05 d1 f6 0d 01 73 15 48 8b 05 e8 f7 e7 00 be fd 00 00 00 48 8b 40 30 e9 5a 9c 9b 00 89 fe 48 c7 c7 e0 b3 02 87 e8 d6 08 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 83 ec 20 
> 94.024: [   24.243144] RSP: 0018:ffff9e8e5e803a28 EFLAGS: 00010082
> 94.024: [   24.248494] RAX: 0000000000000000 RBX: ffff9e8e49ab6a00 RCX: 0000000000000006
> 94.025: [   24.255791] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9e8e5e816730
> 94.025: [   24.263078] RBP: ffff9e8e4d400080 R08: 0000000000000913 R09: 0000000000000000
> 94.025: [   24.270375] R10: 0000000000000002 R11: 000000000000000f R12: ffff9e8e5e8a1b80
> 94.025: [   24.277688] R13: ffff9e8e4d400000 R14: 0000000000000008 R15: 0000000000000002
> 94.026: [   24.285063] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> 94.026: [   24.293338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 94.026: [   24.299251] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> 94.026: [   24.306562] Call Trace:
> 94.026: [   24.309093]  <IRQ>
> 94.026: [   24.311113]  check_preempt_wakeup+0x18d/0x230
> 94.026: [   24.315606]  check_preempt_curr+0x62/0x90
> 94.026: [   24.319719]  ttwu_do_wakeup+0x19/0x140
> 94.027: [   24.323548]  try_to_wake_up+0x1e3/0x4c0
> 94.027: [   24.327460]  __wake_up_common+0x7a/0x190
> 94.027: [   24.331506]  ep_poll_callback+0xc1/0x2c0
> 94.027: [   24.335654]  __wake_up_common+0x7a/0x190
> 94.027: [   24.339714]  __wake_up_common_lock+0x7c/0xc0
> 94.027: [   24.344169]  irq_work_run_list+0x4d/0x70
> 94.028: [   24.348248]  smp_call_function_single_interrupt+0x32/0xc0
> 94.028: [   24.353840]  call_function_single_interrupt+0xf/0x20
> 94.028: [   24.358984] RIP: 0010:panic+0x201/0x247
> 94.028: [   24.362976] Code: eb a6 83 3d 2f 87 54 01 00 74 05 e8 88 54 02 00 48 c7 c6 60 26 7c 87 48 c7 c7 40 4d 03 87 e8 d3 18 06 00 fb 66 0f 1f 44 00 00 <31> db e8 27 5e 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 d7 86 54 
> 94.029: [   24.382385] RSP: 0018:ffff9e8e5e803d60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
> 94.029: [   24.390179] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000006
> 94.029: [   24.397519] RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff9e8e5e816730
> 94.029: [   24.404797] RBP: ffff9e8e5e803dd0 R08: 00000000000008c7 R09: 0000000000000000
> 94.030: [   24.412118] R10: 0000000000000002 R11: 000000000000000f R12: 0000000000000000
> 94.030: [   24.419466] R13: 0000000000000000 R14: 0000000000000009 R15: 0000000000000001
> 94.030: [   24.426839]  ? call_function_single_interrupt+0xa/0x20
> 94.030: [   24.432175]  oops_end.cold.8+0xc/0x18
> 94.031: [   24.435967]  no_context+0x1be/0x380
> 94.031: [   24.439521]  __do_page_fault+0xd1/0x4e0
> 94.031: [   24.443442]  ? try_to_wake_up+0x54/0x4c0
> 94.031: [   24.447494]  ? try_to_wake_up+0x54/0x4c0
> 94.031: [   24.451547]  page_fault+0x1e/0x30
> 94.031: [   24.454927] RIP: 0010:msi_set_mask_bit+0xe/0x70
> 94.031: [   24.459598] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48 
> 94.032: [   24.479138] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> 94.032: [   24.484557] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> 94.033: [   24.491965] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> 94.033: [   24.499330] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> 94.033: [   24.506702] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> 94.033: [   24.514049] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> 94.033: [   24.521397]  ? __do_softirq+0x123/0x2bd
> 94.034: [   24.525391]  __irq_move_irq+0x3c/0x70
> 94.034: [   24.529167]  apic_ack_irq+0x2b/0x30
> 94.034: [   24.532755]  handle_edge_irq+0x7d/0x1d0
> 94.034: [   24.536737]  handle_irq+0x1f/0x30
> 94.034: [   24.540179]  do_IRQ+0x41/0xc0
> 94.034: [   24.543241]  common_interrupt+0xf/0xf
> 94.034: [   24.547054]  </IRQ>
> 94.035: [   24.549195] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
> 94.035: [   24.554349] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3 7f 
> 94.035: [   24.573766] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd8
> 94.036: [   24.581606] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 000000000000001f
> 94.036: [   24.588979] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0000000000000000
> 94.036: [   24.596353] RBP: 0000000000000002 R08: 000000201f49eece R09: 0000000000003e14
> 94.036: [   24.603682] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: ffff9e8e4c664c00
> 94.037: [   24.611055] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0000000096860c6f
> 94.037: [   24.618414]  ? cpuidle_enter_state+0x92/0x2a0
> 94.037: [   24.622911]  do_idle+0x229/0x270
> 94.037: [   24.626240]  cpu_startup_entry+0x6f/0x80
> 94.037: [   24.630328]  start_kernel+0x50c/0x52c
> 94.038: [   24.634105]  secondary_startup_64+0xa5/0xb0
> 94.038: [   24.638389] ---[ end trace 45709f5d819a95c6 ]---
> ```
> 
> Please tell me, if I can provide more information.
> 
> 
> Kind regards,
> 
> Paul
> 
