Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FCC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E31218AC
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550170293;
	bh=JyWWa/TYeUKwUnwnoOG1g79lawmlfFpG1e39tdIjxgM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AWpYUCnB93YCVawqxmR54iZ1zIOh56Oy1cip9EVfqoyu5/GkyVl+W5F7/215I0jYS
	 ABkbl3tuERSmzzZWt+hGMa3Csg5G/5ALyzSDDhfQz0oYO/mwq/gwFYue5O5mESljdp
	 op56vzIt7D+b2kKEIQV8A7jCqr/M4gmg1NpZd0/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBNSvc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfBNSvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 13:51:32 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62749218AC;
        Thu, 14 Feb 2019 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550170291;
        bh=JyWWa/TYeUKwUnwnoOG1g79lawmlfFpG1e39tdIjxgM=;
        h=Date:From:To:Cc:Subject:From;
        b=q99qNveebRefkW6dm+U1jKUvkkzdq2sDwJ/S7sZnfhKT97cssRoitTQrMajq2pWEZ
         WUA+aq0ShJAu+CTXUgAsAOwCAS479ivUoJkJIX9j1OLmyDJKInKzQvoTk6812OxKyU
         WYtAEpuhi9R5rSG4829PDi4Zi3E4CNy4BM1DchvE=
Date:   Thu, 14 Feb 2019 12:51:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael A. Leonetti" <mikealeonetti@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Bug 202511 - amdgpu fails to load saying "Could not allocate 8192
 bytes percpu data"
Message-ID: <20190214185128.GL96272@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202511

From reporter (Michael):

> Working on 4.17.19 (which is what I use) but any kernel 4.19* 4.20* I try has this issue. Built amdgpu as a module, when it tries to load it (or I try to modprobe it) I get
> 
>   amdgpu: Could not allocate 8192 bytes percpu data
>   ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
>   percpu: allocation failed, size=8192 align=4096 atomic=0, alloc from reserved chunk failed
>   CPU: 1 PID: 2620 Comm: systemd-udevd Not tainted 4.20.6-gentoo #1
>   Hardware name: Acer Aspire A315-41/Metapod_RR, BIOS V1.11 10/30/2018
>   Call Trace:
>    dump_stack+0x46/0x5b
>    pcpu_alloc+0x56e/0x590
>    ? find_module_all+0x4c/0x80
>    load_module+0xb51/0x1e80
>    ? wait_woken+0x80/0x80
>    __se_sys_finit_module+0xe0/0xf0
>    do_syscall_64+0x4a/0x100
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7fb64cd77fb9
>   Code: 00 00 00 75 05 48 83 c4 18 c3 e8 42 a5 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9f 4e 2c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffe5fe76eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>   RAX: ffffffffffffffda RBX: 00005615a81b2c10 RCX: 00007fb64cd77fb9
>   RDX: 0000000000000000 RSI: 00007fb64dd3c1c5 RDI: 000000000000000f
>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>   R10: 000000000000000f R11: 0000000000000246 R12: 00005615a81d0290
>   R13: 00007fb64dd3c1c5 R14: 0000000000020000 R15: 0000000003938700

Full dmesg and bisection info in the bugzilla.  Any help is welcome.
