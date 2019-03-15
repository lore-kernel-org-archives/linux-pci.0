Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDCDC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 00:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9CD21872
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 00:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ugJcVH/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfCOALZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:11:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfCOALZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 20:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tXLLeoZnbWmL72Tu5XSFt/OZYwu72y9Y6gqL357MgGE=; b=ugJcVH/LmS9Y91zbl3TQ2saRT
        TBSG9q3UirVhuSQvwMCZ3RA5+1kIXBFYXLJzb3VQH8C70WfU8zZVPyCiqH02iEMKn2bHtfHJypweu
        8ZOmB0VkjFpAQDHrprAS0/5/DLUFn5Q5JvGYdztcdXrG6doeVx1sH4UeR4QfKkHbUjcQqsika/rLa
        Z2ddlkIsiU4YURm4Bv9e/TwgSXfNN2OnfqBiSLQv0+gfdHphV30ezS0p6Rqe/xfma/OITbBqI4HoH
        986vn2mgWzn+9iulWhRxWJ5y0JCI9pnKKhVxXJFMkR8bL7iwmED5olfGKOGoHrXtjqMKFSGJizpEw
        BjoroU2Sg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4aRY-0004TD-66; Fri, 15 Mar 2019 00:11:24 +0000
To:     linux-pci <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: PCI: BUG in pci_epf_remove_cfs() from pci-epf-test
Message-ID: <db529506-8595-4a3f-effd-b8e3dff7cffe@infradead.org>
Date:   Thu, 14 Mar 2019 17:11:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is Linux v5.0-11053-gebc551f2b8f9 from March 12, on x86_64.

Just load and unload the pci-epf-test module.


[   78.942581] calling  pci_epf_test_init+0x0/0x1000 [pci_epf_test] @ 1650
[   78.945926] initcall pci_epf_test_init+0x0/0x1000 [pci_epf_test] returned 0 after 3216 usecs
[   91.293344] ==================================================================
[   91.293381] BUG: KASAN: use-after-free in pci_epf_remove_cfs+0x1b0/0x1f0
[   91.293404] Write of size 8 at addr ffff888111843388 by task rmmod/1672

[   91.293435] CPU: 3 PID: 1672 Comm: rmmod Not tainted 5.0.0mod #1
[   91.293454] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   91.293486] Call Trace:
[   91.293501]  dump_stack+0x7b/0xb5
[   91.293520]  print_address_description+0x6e/0x360
[   91.293544]  kasan_report+0x11a/0x198
[   91.293568]  ? kasan_slab_free+0xe/0x10
[   91.293583]  ? pci_epf_remove_cfs+0x1b0/0x1f0
[   91.293602]  ? pci_epf_remove_cfs+0x1b0/0x1f0
[   91.293620]  __asan_report_store8_noabort+0x17/0x20
[   91.293638]  pci_epf_remove_cfs+0x1b0/0x1f0
[   91.293658]  pci_epf_unregister_driver+0xd/0x20
[   91.293678]  pci_epf_test_exit+0x10/0x18 [pci_epf_test]
[   91.293697]  __x64_sys_delete_module+0x329/0x490
[   91.293715]  ? __ia32_sys_delete_module+0x490/0x490
[   91.293736]  ? blkcg_exit_queue+0x20/0x20
[   91.293751]  ? _raw_spin_unlock_irq+0x22/0x40
[   91.293778]  do_syscall_64+0xaa/0x310
[   91.293793]  ? prepare_exit_to_usermode+0x8b/0x150
[   91.293812]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.293830] RIP: 0033:0x7f7494f5af77
[   91.293845] Code: 73 01 c3 48 8b 0d 21 af 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 ae 2b 00 f7 d8 64 89 01 48
[   91.293893] RSP: 002b:00007fff91ebf118 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[   91.293917] RAX: ffffffffffffffda RBX: 00007fff91ebf178 RCX: 00007f7494f5af77
[   91.293938] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b8934a47d8
[   91.293959] RBP: 000055b8934a4770 R08: 00007fff91ebe091 R09: 0000000000000000
[   91.293980] R10: 00007f7494fca1c0 R11: 0000000000000206 R12: 00007fff91ebf340
[   91.294001] R13: 00007fff91ec173e R14: 000055b8934a4260 R15: 000055b8934a4770

[   91.294042] Allocated by task 1650:
[   91.294057]  save_stack+0x43/0xd0
[   91.294071]  __kasan_kmalloc.constprop.8+0xa7/0xd0
[   91.294088]  kasan_kmalloc+0x9/0x10
[   91.294104]  configfs_register_default_group+0x63/0xe0
[   91.294121]  pci_ep_cfs_add_epf_group+0x20/0x50
[   91.294138]  __pci_epf_register_driver+0x2b2/0x410
[   91.294154]  0xffffffffc1d18032
[   91.294168]  do_one_initcall+0xab/0x2ad
[   91.294182]  do_init_module+0x1c7/0x548
[   91.294197]  load_module+0x46bb/0x5da0
[   91.294211]  __do_sys_finit_module+0x193/0x1b0
[   91.294227]  __x64_sys_finit_module+0x6e/0xb0
[   91.294243]  do_syscall_64+0xaa/0x310
[   91.294257]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   91.294282] Freed by task 1672:
[   91.294295]  save_stack+0x43/0xd0
[   91.294309]  __kasan_slab_free+0x137/0x190
[   91.294324]  kasan_slab_free+0xe/0x10
[   91.294339]  kfree+0xb0/0x1b0
[   91.294352]  configfs_unregister_default_group+0x15/0x20
[   91.294370]  pci_ep_cfs_remove_epf_group+0x17/0x20
[   91.294387]  pci_epf_remove_cfs+0x8e/0x1f0
[   91.294403]  pci_epf_unregister_driver+0xd/0x20
[   91.294419]  pci_epf_test_exit+0x10/0x18 [pci_epf_test]
[   91.294437]  __x64_sys_delete_module+0x329/0x490
[   91.294454]  do_syscall_64+0xaa/0x310
[   91.294475]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   91.294503] The buggy address belongs to the object at ffff888111843308
                which belongs to the cache kmalloc-192 of size 192
[   91.294547] The buggy address is located 128 bytes inside of
                192-byte region [ffff888111843308, ffff8881118433c8)
[   91.294579] The buggy address belongs to the page:
[   91.294596] page:ffffea0004461000 count:1 mapcount:0 mapping:ffff888107c10e40 index:0xffff888111841fe8 compound_mapcount: 0
[   91.294628] flags: 0x17ffffc0010200(slab|head)
[   91.294646] raw: 0017ffffc0010200 ffffea0004696208 ffff888107c03690 ffff888107c10e40
[   91.294670] raw: ffff888111841fe8 00000000001e0014 00000001ffffffff 0000000000000000
[   91.294692] page dumped because: kasan: bad access detected

[   91.294717] Memory state around the buggy address:
[   91.294734]  ffff888111843280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   91.294756]  ffff888111843300: fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   91.294777] >ffff888111843380: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
[   91.294798]                       ^
[   91.294812]  ffff888111843400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   91.294833]  ffff888111843480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   91.294854] ==================================================================

-- 
~Randy
