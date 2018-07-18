Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Subject: NULL pointer dereference in msi_set_mask_bit
Message-ID: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de>
Date: Wed, 18 Jul 2018 15:28:15 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030102060105090607050508"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms030102060105090607050508
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


On a MSI B350M MORTAR with AMD Ryzen 3 2200g (Raven) with Linux 4.18-rc5+=

and Debian Sid/unstable the system freezes with the messages below.

```
$ git log --oneline -1
30b06abfb92b (HEAD -> master, origin/master, origin/HEAD) Merge tag 'pinc=
trl-v4.18-3' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linu=
x-pinctrl
$ git describe --dirty
v4.18-rc5-36-g30b06abfb92b
```

Serial log (unfortunately *quiet* passed on command line):

```
93.885: [   23.020572] BUG: unable to handle kernel NULL pointer derefere=
nce at 000000000000003c
93.885: [   23.029011] PGD 0 P4D 0=20
93.885: [   23.031670] Oops: 0000 [#1] SMP NOPTI
93.885: [   23.035455] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-r=
c5+ #1
93.885: [   23.042079] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37),=
 BIOS 1.G1 05/17/2018
93.886: [   23.049868] RIP: 0010:msi_set_mask_bit+0xe/0x70
93.913: [   23.049868] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9=
 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 =
8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38=
 48=20
93.957: [   23.049880] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
93.957: [   23.049881] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0=
000000000000000
93.958: [   23.049882] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: f=
fff9e8e45919098
93.958: [   23.049882] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0=
000000000000000
93.958: [   23.049882] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff9e8e45919000
93.958: [   23.049883] R13: 0000000000000027 R14: 0000000000000000 R15: 0=
000000000000000
93.959: [   23.049884] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(00=
00) knlGS:0000000000000000
93.959: [   23.049884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
93.959: [   23.049885] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 0=
0000000003406f0
93.959: [   23.049885] Call Trace:
93.959: [   23.049887]  <IRQ>
93.960: [   23.049889]  __irq_move_irq+0x3c/0x70
93.960: [   23.049892]  apic_ack_irq+0x2b/0x30
93.960: [   23.049893]  handle_edge_irq+0x7d/0x1d0
93.960: [   23.049895]  handle_irq+0x1f/0x30
93.960: [   23.049898]  do_IRQ+0x41/0xc0
93.960: [   23.049899]  common_interrupt+0xf/0xf
93.961: [   23.049900]  </IRQ>
93.961: [   23.049902] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
93.961: [   23.049902] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f=
 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f =
44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3=
 7f=20
93.961: [   23.049914] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_R=
AX: ffffffffffffffd8
93.962: [   23.049915] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 0=
00000000000001f
93.962: [   23.049915] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0=
000000000000000
93.962: [   23.049916] RBP: 0000000000000002 R08: 000000201f49eece R09: 0=
000000000003e14
93.962: [   23.049916] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: f=
fff9e8e4c664c00
93.963: [   23.049917] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0=
000000096860c6f
93.963: [   23.049919]  ? cpuidle_enter_state+0x92/0x2a0
93.963: [   23.049921]  do_idle+0x229/0x270
93.963: [   23.049923]  cpu_startup_entry+0x6f/0x80
93.963: [   23.049925]  start_kernel+0x50c/0x52c
93.963: [   23.049927]  secondary_startup_64+0xa5/0xb0
93.963: [   23.049928] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp=
437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_code=
c_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_p=
clmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_inte=
l pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_he=
lper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_time=
r snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivar=
fs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt d=
m_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_mem=
cpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear=
 md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci=
 aes_x86_64 xhci_pci
93.965: [   23.049959]  crypto_simd libahci cryptd glue_helper xhci_hcd l=
ibata scsi_mod usbcore gpio_amdpt gpio_generic
93.966: [   23.049963] CR2: 000000000000003c
93.966: [   23.049967] ---[ end trace 45709f5d819a95c4 ]---
93.966: [   23.131635] RIP: 0010:msi_set_mask_bit+0xe/0x70
93.966: [   23.422197] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9=
 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 =
8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38=
 48=20
93.998: [   23.422209] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
93.998: [   23.422210] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0=
000000000000000
93.998: [   23.422211] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: f=
fff9e8e45919098
93.999: [   23.422211] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0=
000000000000000
93.999: [   23.422212] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff9e8e45919000
93.999: [   23.422212] R13: 0000000000000027 R14: 0000000000000000 R15: 0=
000000000000000
94.000: [   23.422213] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(00=
00) knlGS:0000000000000000
94.000: [   23.422213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
94.000: [   23.422214] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 0=
0000000003406f0
94.000: [   23.422215] Kernel panic - not syncing: Fatal exception in int=
errupt
94.001: [   23.442505] Kernel Offset: 0x5200000 from 0xffffffff81000000 (=
relocation range: 0xffffffff80000000-0xffffffffbfffffff)
94.001: [   23.554334] ---[ end Kernel panic - not syncing: Fatal excepti=
on in interrupt ]---
94.001: [   23.562144] ------------[ cut here ]------------
94.001: [   23.566929] sched: Unexpected reschedule of offline CPU#1!
94.002: [   23.572610] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/smp.c:12=
8 native_smp_send_reschedule+0x34/0x40
94.002: [   23.582078] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp=
437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_code=
c_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_p=
clmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_inte=
l pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_he=
lper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_time=
r snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivar=
fs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt d=
m_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_mem=
cpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear=
 md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci=
 aes_x86_64 xhci_pci
94.004: [   23.655181]  crypto_simd libahci cryptd glue_helper xhci_hcd l=
ibata scsi_mod usbcore gpio_amdpt gpio_generic
94.004: [   23.665290] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D   =
        4.18.0-rc5+ #1
94.005: [   23.673300] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37),=
 BIOS 1.G1 05/17/2018
94.005: [   23.681232] RIP: 0010:native_smp_send_reschedule+0x34/0x40
94.005: [   23.686911] Code: 05 d1 f6 0d 01 73 15 48 8b 05 e8 f7 e7 00 be=
 fd 00 00 00 48 8b 40 30 e9 5a 9c 9b 00 89 fe 48 c7 c7 e0 b3 02 87 e8 d6 =
08 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 83 ec=
 20=20
94.006: [   23.706603] RSP: 0018:ffff9e8e5e803af8 EFLAGS: 00010082
94.006: [   23.712040] RAX: 0000000000000000 RBX: ffff9e8e5e861b80 RCX: 0=
000000000000006
94.007: [   23.719474] RDX: 0000000000000007 RSI: 0000000000000092 RDI: f=
fff9e8e5e816730
94.007: [   23.726975] RBP: ffff9e8e4cadc9c0 R08: 00000000000008c9 R09: 0=
000000000000000
94.007: [   23.734416] R10: 0000000000000002 R11: 000000000000000f R12: f=
fff9e8e4cadd10c
94.008: [   23.741921] R13: ffff9e8e5e803b48 R14: 0000000000000046 R15: 0=
000000000021b80
94.008: [   23.749387] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(00=
00) knlGS:0000000000000000
94.009: [   23.757810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
94.009: [   23.763704] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 0=
0000000003406f0
94.009: [   23.771145] Call Trace:
94.009: [   23.773676]  <IRQ>
94.009: [   23.775794]  check_preempt_curr+0x7a/0x90
94.009: [   23.779958]  ttwu_do_wakeup+0x19/0x140
94.010: [   23.783843]  try_to_wake_up+0x1e3/0x4c0
94.010: [   23.787813]  autoremove_wake_function+0x11/0x50
94.010: [   23.792475]  __wake_up_common+0x7a/0x190
94.010: [   23.796537]  __wake_up_common_lock+0x7c/0xc0
94.010: [   23.800926]  irq_work_run_list+0x4d/0x70
94.010: [   23.804978]  smp_call_function_single_interrupt+0x32/0xc0
94.011: [   23.810578]  call_function_single_interrupt+0xf/0x20
94.011: [   23.815688] RIP: 0010:panic+0x201/0x247
94.011: [   23.819628] Code: eb a6 83 3d 2f 87 54 01 00 74 05 e8 88 54 02=
 00 48 c7 c6 60 26 7c 87 48 c7 c7 40 4d 03 87 e8 d3 18 06 00 fb 66 0f 1f =
44 00 00 <31> db e8 27 5e 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 d7 86=
 54=20
94.012: [   23.839139] RSP: 0018:ffff9e8e5e803d60 EFLAGS: 00000246 ORIG_R=
AX: ffffffffffffff04
94.012: [   23.846953] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0=
000000000000006
94.012: [   23.854334] RDX: 0000000000000000 RSI: 0000000000000092 RDI: f=
fff9e8e5e816730
94.012: [   23.861741] RBP: ffff9e8e5e803dd0 R08: 00000000000008c7 R09: 0=
000000000000000
94.013: [   23.869140] R10: 0000000000000002 R11: 000000000000000f R12: 0=
000000000000000
94.013: [   23.876532] R13: 0000000000000000 R14: 0000000000000009 R15: 0=
000000000000001
94.013: [   23.883907]  ? call_function_single_interrupt+0xa/0x20
94.013: [   23.889224]  oops_end.cold.8+0xc/0x18
94.014: [   23.893036]  no_context+0x1be/0x380
94.014: [   23.896630]  __do_page_fault+0xd1/0x4e0
94.014: [   23.900597]  ? try_to_wake_up+0x54/0x4c0
94.014: [   23.904676]  ? try_to_wake_up+0x54/0x4c0
94.014: [   23.908727]  page_fault+0x1e/0x30
94.014: [   23.912151] RIP: 0010:msi_set_mask_bit+0xe/0x70
94.015: [   23.916850] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9=
 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 =
8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38=
 48=20
94.015: [   23.936257] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
94.015: [   23.941627] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0=
000000000000000
94.016: [   23.948992] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: f=
fff9e8e45919098
94.016: [   23.956321] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0=
000000000000000
94.016: [   23.963721] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff9e8e45919000
94.016: [   23.971025] R13: 0000000000000027 R14: 0000000000000000 R15: 0=
000000000000000
94.016: [   23.978382]  ? __do_softirq+0x123/0x2bd
94.017: [   23.982330]  __irq_move_irq+0x3c/0x70
94.017: [   23.986073]  apic_ack_irq+0x2b/0x30
94.017: [   23.989668]  handle_edge_irq+0x7d/0x1d0
94.017: [   23.993582]  handle_irq+0x1f/0x30
94.017: [   23.996998]  do_IRQ+0x41/0xc0
94.017: [   24.000089]  common_interrupt+0xf/0xf
94.017: [   24.003882]  </IRQ>
94.017: [   24.006007] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
94.018: [   24.011134] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f=
 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f =
44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3=
 7f=20
94.018: [   24.030413] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_R=
AX: ffffffffffffffd8
94.018: [   24.038209] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 0=
00000000000001f
94.018: [   24.045523] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0=
000000000000000
94.019: [   24.052799] RBP: 0000000000000002 R08: 000000201f49eece R09: 0=
000000000003e14
94.019: [   24.060148] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: f=
fff9e8e4c664c00
94.019: [   24.067487] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0=
000000096860c6f
94.019: [   24.074782]  ? cpuidle_enter_state+0x92/0x2a0
94.019: [   24.079300]  do_idle+0x229/0x270
94.020: [   24.082680]  cpu_startup_entry+0x6f/0x80
94.020: [   24.086760]  start_kernel+0x50c/0x52c
94.020: [   24.090573]  secondary_startup_64+0xa5/0xb0
94.020: [   24.094906] ---[ end trace 45709f5d819a95c5 ]---
94.020: [   24.099676] ------------[ cut here ]------------
94.020: [   24.104421] sched: Unexpected reschedule of offline CPU#2!
94.021: [   24.110102] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/smp.c:12=
8 native_smp_send_reschedule+0x34/0x40
94.021: [   24.119512] Modules linked in: nls_ascii ppdev wmi_bmof nls_cp=
437 vfat fat amdkfd efi_pstore edac_mce_amd ccp rng_core kvm snd_hda_code=
c_realtek irqbypass amdgpu snd_hda_codec_generic crct10dif_pclmul crc32_p=
clmul snd_hda_codec_hdmi chash ghash_clmulni_intel gpu_sched snd_hda_inte=
l pcspkr r8169 ttm sg efivars sp5100_tco snd_hda_codec k10temp drm_kms_he=
lper i2c_piix4 mii snd_hda_core snd_hwdep drm snd_pcm parport_pc snd_time=
r snd i2c_algo_bit soundcore wmi parport video button acpi_cpufreq efivar=
fs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_crypt d=
m_mod raid10 raid456 libcrc32c crc32c_generic async_raid6_recov async_mem=
cpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 multipath linear=
 md_mod sd_mod evdev hid_generic usbhid hid crc32c_intel aesni_intel ahci=
 aes_x86_64 xhci_pci
94.023: [   24.192305]  crypto_simd libahci cryptd glue_helper xhci_hcd l=
ibata scsi_mod usbcore gpio_amdpt gpio_generic
94.023: [   24.202328] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W =
        4.18.0-rc5+ #1
94.023: [   24.210314] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37),=
 BIOS 1.G1 05/17/2018
94.024: [   24.218116] RIP: 0010:native_smp_send_reschedule+0x34/0x40
94.024: [   24.223753] Code: 05 d1 f6 0d 01 73 15 48 8b 05 e8 f7 e7 00 be=
 fd 00 00 00 48 8b 40 30 e9 5a 9c 9b 00 89 fe 48 c7 c7 e0 b3 02 87 e8 d6 =
08 03 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 83 ec=
 20=20
94.024: [   24.243144] RSP: 0018:ffff9e8e5e803a28 EFLAGS: 00010082
94.024: [   24.248494] RAX: 0000000000000000 RBX: ffff9e8e49ab6a00 RCX: 0=
000000000000006
94.025: [   24.255791] RDX: 0000000000000007 RSI: 0000000000000092 RDI: f=
fff9e8e5e816730
94.025: [   24.263078] RBP: ffff9e8e4d400080 R08: 0000000000000913 R09: 0=
000000000000000
94.025: [   24.270375] R10: 0000000000000002 R11: 000000000000000f R12: f=
fff9e8e5e8a1b80
94.025: [   24.277688] R13: ffff9e8e4d400000 R14: 0000000000000008 R15: 0=
000000000000002
94.026: [   24.285063] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(00=
00) knlGS:0000000000000000
94.026: [   24.293338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
94.026: [   24.299251] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 0=
0000000003406f0
94.026: [   24.306562] Call Trace:
94.026: [   24.309093]  <IRQ>
94.026: [   24.311113]  check_preempt_wakeup+0x18d/0x230
94.026: [   24.315606]  check_preempt_curr+0x62/0x90
94.026: [   24.319719]  ttwu_do_wakeup+0x19/0x140
94.027: [   24.323548]  try_to_wake_up+0x1e3/0x4c0
94.027: [   24.327460]  __wake_up_common+0x7a/0x190
94.027: [   24.331506]  ep_poll_callback+0xc1/0x2c0
94.027: [   24.335654]  __wake_up_common+0x7a/0x190
94.027: [   24.339714]  __wake_up_common_lock+0x7c/0xc0
94.027: [   24.344169]  irq_work_run_list+0x4d/0x70
94.028: [   24.348248]  smp_call_function_single_interrupt+0x32/0xc0
94.028: [   24.353840]  call_function_single_interrupt+0xf/0x20
94.028: [   24.358984] RIP: 0010:panic+0x201/0x247
94.028: [   24.362976] Code: eb a6 83 3d 2f 87 54 01 00 74 05 e8 88 54 02=
 00 48 c7 c6 60 26 7c 87 48 c7 c7 40 4d 03 87 e8 d3 18 06 00 fb 66 0f 1f =
44 00 00 <31> db e8 27 5e 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 d7 86=
 54=20
94.029: [   24.382385] RSP: 0018:ffff9e8e5e803d60 EFLAGS: 00000246 ORIG_R=
AX: ffffffffffffff04
94.029: [   24.390179] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0=
000000000000006
94.029: [   24.397519] RDX: 0000000000000000 RSI: 0000000000000092 RDI: f=
fff9e8e5e816730
94.029: [   24.404797] RBP: ffff9e8e5e803dd0 R08: 00000000000008c7 R09: 0=
000000000000000
94.030: [   24.412118] R10: 0000000000000002 R11: 000000000000000f R12: 0=
000000000000000
94.030: [   24.419466] R13: 0000000000000000 R14: 0000000000000009 R15: 0=
000000000000001
94.030: [   24.426839]  ? call_function_single_interrupt+0xa/0x20
94.030: [   24.432175]  oops_end.cold.8+0xc/0x18
94.031: [   24.435967]  no_context+0x1be/0x380
94.031: [   24.439521]  __do_page_fault+0xd1/0x4e0
94.031: [   24.443442]  ? try_to_wake_up+0x54/0x4c0
94.031: [   24.447494]  ? try_to_wake_up+0x54/0x4c0
94.031: [   24.451547]  page_fault+0x1e/0x30
94.031: [   24.454927] RIP: 0010:msi_set_mask_bit+0xe/0x70
94.031: [   24.459598] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9=
 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 =
8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38=
 48=20
94.032: [   24.479138] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
94.032: [   24.484557] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0=
000000000000000
94.033: [   24.491965] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: f=
fff9e8e45919098
94.033: [   24.499330] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0=
000000000000000
94.033: [   24.506702] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff9e8e45919000
94.033: [   24.514049] R13: 0000000000000027 R14: 0000000000000000 R15: 0=
000000000000000
94.033: [   24.521397]  ? __do_softirq+0x123/0x2bd
94.034: [   24.525391]  __irq_move_irq+0x3c/0x70
94.034: [   24.529167]  apic_ack_irq+0x2b/0x30
94.034: [   24.532755]  handle_edge_irq+0x7d/0x1d0
94.034: [   24.536737]  handle_irq+0x1f/0x30
94.034: [   24.540179]  do_IRQ+0x41/0xc0
94.034: [   24.543241]  common_interrupt+0xf/0xf
94.034: [   24.547054]  </IRQ>
94.035: [   24.549195] RIP: 0010:cpuidle_enter_state+0xb7/0x2a0
94.035: [   24.554349] Code: e8 be b0 b3 ff 80 7c 24 03 00 74 17 9c 58 0f=
 1f 44 00 00 f6 c4 02 0f 85 d7 01 00 00 31 ff e8 70 71 b9 ff fb 66 0f 1f =
44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 f3 ba ff ff ff 7f 48 39 c3=
 7f=20
94.035: [   24.573766] RSP: 0018:ffffffff87203e78 EFLAGS: 00000246 ORIG_R=
AX: ffffffffffffffd8
94.036: [   24.581606] RAX: ffff9e8e5e821b80 RBX: 000000055c21c9b7 RCX: 0=
00000000000001f
94.036: [   24.588979] RDX: 000000055c21c9b7 RSI: 0000000000000000 RDI: 0=
000000000000000
94.036: [   24.596353] RBP: 0000000000000002 R08: 000000201f49eece R09: 0=
000000000003e14
94.036: [   24.603682] R10: 0000000000003f1f R11: ffff9e8e5e820b28 R12: f=
fff9e8e4c664c00
94.037: [   24.611055] R13: ffffffff872b6c18 R14: 000000055be072f3 R15: 0=
000000096860c6f
94.037: [   24.618414]  ? cpuidle_enter_state+0x92/0x2a0
94.037: [   24.622911]  do_idle+0x229/0x270
94.037: [   24.626240]  cpu_startup_entry+0x6f/0x80
94.037: [   24.630328]  start_kernel+0x50c/0x52c
94.038: [   24.634105]  secondary_startup_64+0xa5/0xb0
94.038: [   24.638389] ---[ end trace 45709f5d819a95c6 ]---
```

Please tell me, if I can provide more information.


Kind regards,

Paul


--------------ms030102060105090607050508
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA3MTgxMzI4MTVaMC8GCSqGSIb3DQEJBDEiBCBHvC2mTXAn+BiRtWTH
7p4VJUtQAL0AlIBgMglXzlpF0zBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAKTd
rwGJDai/IWPzQRQm9zGBcg9HcaJB6OanZlK+e94DQ3jNUcJZ+QSydlqT+gypxyr7/x1R2yi+
0EZFmStGUpIAEDjNnA9othAZR0UgAJ6DdUdhEQzZ814bt9geuTfxXQdM7+B14lUkF+4yOIxI
CpKkzkk7wlVxiy5wAxVgY8rq+qruylTVB9iuxdeQi2fb6i6cU4rBSsKTbcQtmcSOLQWyBl1V
u/fjRF5aZEKrY+b7B+TjCTQulvJTcpuBGAKlr09sd4x0zRYJykOGGYVCncrGVW85tXUkIrXz
2AZaY8OOY1kiQ17JZ4o1diie759lZ8nwBIImM8SZ4+2F8TZQXpkAAAAAAAA=
--------------ms030102060105090607050508--
