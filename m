Return-Path: <SRS0=O3Eo=MB=hygon.cn=puwen@kernel.org>
Return-Path: <SRS0=O3Eo=MB=hygon.cn=puwen@kernel.org>
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
To: kernel test robot <rong.a.chen@intel.com>
Cc: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-pci@vger.kernel.org, lkp@01.org
References: <20180919031923.GC8820@shao2-debian>
Message-ID: <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
Date: Wed, 19 Sep 2018 21:53:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180919031923.GC8820@shao2-debian>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 2018/9/19 11:19, kernel test robot wrote:
> [    0.800215] AGP: No AGP bridge found
> PANIC: early exception 0xe3 IP 10:ffffffff8294623f error 0 cr2 0x0
> [    0.815262] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc2-00018-g7ffb318 #1
> [    0.826860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.839894] RIP: 0010:early_is_amd_nb+0x30/0x4b
> [    0.846986] Code: 15 07 3e c8 ff 0f b7 cf 48 c7 c0 c0 6a 01 82 80 fa 02 74 13 80 fa 09 48 c7 c0 20 69 01 82 ba 00 00 00 00 48 0f 45 c2 c1 ef 10 <8b> 10 85 d2 74 0f 39 ca 75 05 39 78 04 74 09 48 83 c0 20 eb eb 31
> [    0.876321] RSP: 0000:ffffffff82403e38 EFLAGS: 00010017 ORIG_RAX: 0000000000000000
> [    0.888131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000ffff
> [    0.899187] RDX: 0000000000000000 RSI: 000000000000c000 RDI: 000000000000ffff
> [    0.910233] RBP: 0000000000000018 R08: 0000000000000002 R09: 0000000000000000
> [    0.921388] R10: ffffffff829ecc40 R11: ffffffff82aeed87 R12: 0000000000000000
> [    0.932476] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.943658] FS:  0000000000000000(0000) GS:ffffffff82909000(0000) knlGS:0000000000000000
> [    0.956271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.965216] CR2: 0000000000000000 CR3: 00000000029a2000 CR4: 00000000000006a0
> [    0.976358] Call Trace:
> [    0.980238]  ? early_gart_iommu_check+0xef/0x2c5
> [    0.987493]  ? setup_arch+0x4fa/0xc67
> [    0.993231]  ? printk+0x52/0x6e
> [    0.998157]  ? start_kernel+0x6e/0x4dc
> [    1.004044]  ? load_ucode_bsp+0x42/0x12e
> [    1.010145]  ? secondary_startup_64+0xa4/0xb0
> BUG: kernel hang in boot stage
> 
> Elapsed time: 700
> 
> #!/bin/bash
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
What kind of host do you use to run the qemu? A Intel one or AMD one?

Thanks,
Pu Wen
