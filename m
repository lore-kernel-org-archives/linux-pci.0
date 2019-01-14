Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6AC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C40206B7
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzzfE6d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfANOcA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:32:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfANOcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 09:32:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so23183163wrw.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Jan 2019 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asc0J3E873TK4LoN0gZGtkFA1HIbfKM+CB8AkuPfSpo=;
        b=XzzfE6d4YUYUfQx9RnkxSGTizK3ssBUAuJj1YBXX2CLIff1UM59Q4uXJGdNkJRc3u0
         HU+v+MWS86Ln4BJQ6uGGkJlKrbH4M78GzmPuoLo7BcMkjXyUOX7NLYA3Z9C0ESJuTbnZ
         l157jrV+UabUXu9srd3rVLhvDnTElI0DuTUhCDuCnB9Mn/8izj/Fz1Hk8dvXKDrjKpVw
         pkdK7n75/BZRBwpLXfFElIB+1PGl3ktprUFy1Jm78uk5xYcgDr9nERXNYY6K9gzqIRNM
         /CYB6arTd1H/VRWOZE3LXfZq/WWOeQyIZm9wk57YPVMvxFqg8mJ5jg5ZwCdNlt6s8yiI
         DYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asc0J3E873TK4LoN0gZGtkFA1HIbfKM+CB8AkuPfSpo=;
        b=Opr4GkjrxMMl/yhLBNV8/3uewIxUHCu5c2CHLjdllDEuejkwmTkl232D6KVLRPUOPw
         UH1KjDK3Ak5u/Wk/QelmqCe5V/jv/omB4RP35r5VdAsc7dKMPhjPOUhtjDIuhkrwBlSn
         ksCUx/E2iPAWuca5AR9uF9jL8x14LepyT4GVHSHXH8P88/tu4oQ1mwnr1sjn+UUvHq8g
         O6vf0VHsnYgPwWeBgzOnaQaSHlBoV4e58Yi96xQVzWG52HbGDFnu73/UD3xXQiL9OYxL
         Ukhq/+eTqvQMMsj3CgMuhCyk1V+uduBLGCo9HE4Udx3qztsTCPbFgLQi+yk0mldXjC6U
         yJkw==
X-Gm-Message-State: AJcUukeridydEs4Mz7gq1s5FHc9TzNyS1qhxMiIC2x+iqPLDreBF8oeE
        e6g9nc90vPypPNilecrOcIawDIhQo6u9NKZhI0Ce
X-Google-Smtp-Source: ALg8bN5ieDHM+keBpuDpX6U/n9YqNP0Dzi2nP44HwGHAhjMf37nLGRD6J3sett3RSXNeoyklgCD3Gc90sU+jp+fDTaM=
X-Received: by 2002:a5d:480d:: with SMTP id l13mr26023111wrq.175.1547476317504;
 Mon, 14 Jan 2019 06:31:57 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
In-Reply-To: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 14 Jan 2019 08:31:45 -0600
Message-ID: <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com>
Subject: Re: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52 some day
To:     fin4478 fin4478 <fin4478@hotmail.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dou, Jens, Thomas, Christoph, linux-pci, LKML]

On Sun, Jan 13, 2019 at 11:24 PM fin4478 fin4478 <fin4478@hotmail.com> wrote:
>
> Hi,
>
> A regression from the 4.20 kernel: I have the Asgard 256GB nvme drive
> and my custom non debug 1000Hz timer kernel 5.0 started to throw a
> couple of warning messages at boot. My system works ok:
>
> [    1.849778] nvme nvme0: missing or invalid SUBNQN field.
> [    1.858041] nvme nvme0: allocated 64 MiB host memory buffer.
> [    1.886727] nvme nvme0: 16/0/0 default/read/poll queues
> [    1.886737] WARNING: CPU: 8 PID: 1254 at drivers/pci/msi.c:1269
> pci_irq_get_affinity+0x36/0x80
> [    1.886738] Modules linked in: realtek r8169 xhci_pci nvme xhci_hcd
> nvme_core
> [    1.886742] CPU: 8 PID: 1254 Comm: kworker/u32:8 Not tainted
> 5.0.0-rc2 #5
> [    1.886743] Hardware name: System manufacturer System Product
> Name/PRIME B350M-K, BIOS 4207 12/07/2018
> [    1.886747] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> [    1.886749] RIP: 0010:pci_irq_get_affinity+0x36/0x80
> [    1.886750] Code: 48 8b 87 88 02 00 00 48 81 c7 88 02 00 00 48 39 c7
> 74 17 85 f6 74 4e 31 d2 eb 04 39 d6 74 46 48 8b 00 83 c2 01 48 39 f8 75
> f1 <0f> 0b 31 c0 c3 83 e2 02 48 c7 c0 a8 dc 29 82 74 29 48 8b 97 88 02
> [    1.886751] RSP: 0018:ffffc90001ee7cf8 EFLAGS: 00010246
> [    1.886752] RAX: ffff888214423a88 RBX: 000000000000000f RCX:
> 0000000000000040
> [    1.886752] RDX: 0000000000000010 RSI: 0000000000000010 RDI:
> ffff888214423a88
> [    1.886753] RBP: ffff888213a84200 R08: ffff888216c22400 R09:
> ffff8882128da480
> [    1.886753] R10: 0000000000000000 R11: 0000000000000001 R12:
> 0000000000000001
> [    1.886754] R13: ffff888214423800 R14: 00000000ffffffff R15:
> ffff888213005008
> [    1.886754] FS:  0000000000000000(0000) GS:ffff888216c00000(0000)
> knlGS:0000000000000000
> [    1.886755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.886756] CR2: 00007f2eada39441 CR3: 0000000212880000 CR4:
> 00000000003406e0
> [    1.886756] Call Trace:
> [    1.886759]  blk_mq_pci_map_queues+0x32/0xc0
> [    1.886762]  nvme_pci_map_queues+0x7b/0xb0 [nvme]
> [    1.886764]  blk_mq_alloc_tag_set+0x113/0x2c0
> [    1.886767]  nvme_reset_work+0x1210/0x166d [nvme]
> [    1.886769]  process_one_work+0x1c9/0x350
> [    1.886771]  worker_thread+0x210/0x3c0
> [    1.886772]  ? rescuer_thread+0x320/0x320
> [    1.886773]  kthread+0x106/0x120
> [    1.886774]  ? kthread_create_on_node+0x60/0x60
> [    1.886777]  ret_from_fork+0x1f/0x30
> [    1.886778] ---[ end trace 1f86c10439edbd73 ]---
> [    1.886783] WARNING: CPU: 8 PID: 1254 at block/blk-mq-pci.c:52
> blk_mq_pci_map_queues+0xb9/0xc0
> [    1.886784] Modules linked in: realtek r8169 xhci_pci nvme xhci_hcd
> nvme_core
> [    1.886786] CPU: 8 PID: 1254 Comm: kworker/u32:8 Tainted: G
> W         5.0.0-rc2 #5
> [    1.886786] Hardware name: System manufacturer System Product
> Name/PRIME B350M-K, BIOS 4207 12/07/2018
> [    1.886788] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> [    1.886790] RIP: 0010:blk_mq_pci_map_queues+0xb9/0xc0
> [    1.886791] Code: d0 c7 04 91 00 00 00 00 48 89 de 89 c7 e8 4f 18 47
> 00 3b 05 5d d9 fb 00 72 e1 5b 31 c0 5d 41 5c 41 5d 41 5e 41 5f c3 31 c0
> c3 <0f> 0b eb c4 90 90 90 41 57 49 89 ff 41 56 41 55 41 54 55 53 48 8b
> [    1.886791] RSP: 0018:ffffc90001ee7d00 EFLAGS: 00010216
> [    1.886792] RAX: 00000000ffffffff RBX: 000000000000000f RCX:
> 0000000000000040
> [    1.886792] RDX: 0000000000000010 RSI: 0000000000000010 RDI:
> ffff888214423a88
> [    1.886793] RBP: 0000000000000000 R08: ffff888216c22400 R09:
> ffff8882128da480
> [    1.886793] R10: 0000000000000000 R11: 0000000000000001 R12:
> 0000000000000001
> [    1.886794] R13: ffff888214423800 R14: 00000000ffffffff R15:
> ffff888213005008
> [    1.886794] FS:  0000000000000000(0000) GS:ffff888216c00000(0000)
> knlGS:0000000000000000
> [    1.886795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.886796] CR2: 00007f2eada39441 CR3: 0000000212880000 CR4:
> 00000000003406e0
> [    1.886796] Call Trace:
> [    1.886798]  nvme_pci_map_queues+0x7b/0xb0 [nvme]
> [    1.886800]  blk_mq_alloc_tag_set+0x113/0x2c0
> [    1.886802]  nvme_reset_work+0x1210/0x166d [nvme]
> [    1.886803]  process_one_work+0x1c9/0x350
> [    1.886804]  worker_thread+0x210/0x3c0
> [    1.886805]  ? rescuer_thread+0x320/0x320
> [    1.886806]  kthread+0x106/0x120
> [    1.886807]  ? kthread_create_on_node+0x60/0x60
> [    1.886808]  ret_from_fork+0x1f/0x30
> [    1.886809] ---[ end trace 1f86c10439edbd74 ]---
> [    1.893002] nvme nvme0: nvme_report_ns_ids: Identify Descriptors
> failed
> [    1.894725] nvme nvme0: nvme_report_ns_ids: Identify Descriptors
> failed
>
> System:
>   Host: ryzenpc Kernel: 5.0.0-rc2 x86_64 bits: 64 Desktop: Xfce 4.12.4
>   Distro: Debian GNU/Linux buster/sid
> Machine:
>   Type: Desktop Mobo: ASUSTeK model: PRIME B350M-K v: Rev X.0x
>   serial: <root required> UEFI [Legacy]: American Megatrends v: 4207
>   date: 12/07/2018
> CPU:
>   6-Core: AMD Ryzen 5 1600 type: MT MCP speed: 2835 MHz
> Graphics:
>   Device-1: AMD Ellesmere [Radeon RX 470/480] driver: amdgpu v: kernel
>   Display: x11 server: X.Org 1.20.3 driver: amdgpu
>   resolution: 3840x2160~60Hz
>   OpenGL:
>   renderer: Radeon RX 570 Series (POLARIS10 DRM 3.27.0 5.0.0-rc2 LLVM
> 7.0.1)
>   v: 4.5 Mesa 19.0.0-devel (git-04c2f12 2019-01-13 cosmic-oibaf-ppa)
> Network:
>   Device-1: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet
>   driver: r8169
> Drives:
>   Local Storage: total: 476.95 GiB used: 174.65 GiB (36.6%)
> Info:
>   Processes: 227 Uptime: 25m Memory: 7.79 GiB used: 987.6 MiB (12.4%)
