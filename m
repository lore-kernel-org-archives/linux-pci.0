Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8EC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5520866
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OReEh0yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA5520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbeKVT0w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:26:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeKVT0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 14:26:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so8372568wru.4;
        Thu, 22 Nov 2018 00:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DOYMijtaJDziVSb7Zv8psIw4n/bqDFgT46BevDmNv9E=;
        b=OReEh0ydQqJ99Eo4W1ohfEeiFObE8fEuYEx0XmICEUH8X1WCGXmwwnTUCNysWYKXE3
         NsaIAObcAs9B8sR2w5mhgSqXSSVYPTX/ncB3VfIrCJxqEDlYb7lUR2w9IDysf7rnR1Ze
         AiHCFaftRti0sK1yQtpA4lLgKZCPRX8JgVX05gMpfRwK9y8R7PmR/lZE4Pb/gSqJnTeJ
         ZCLUm1j0AwUA8xYayDTxPw7gv87hcWbuKF2az+dngQGzfRVkYz3IJKzVdJ/vH/zGeh12
         t2vzx5Ek3L6zGKMUb7eeeBzRjwbOzcQ32Zdh95/JnL1TpxzVFAI33nqVF3hZnxAWZeZi
         eaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DOYMijtaJDziVSb7Zv8psIw4n/bqDFgT46BevDmNv9E=;
        b=Ocmn9ZRYKgv6jPAjaG1bDEdFZQTi2TB2t/QPuwINis/ic04df0Oj/VuxV7Et4gwSio
         9xeAFxfKe+GtjRXPrF+HBAEjN9CbnQV4S7eoZGbE8laeEzQNeX4yMV4wRkpARXcx/gyP
         1AHQPua+Z2CoPcsNpFZYp38m1awLXWB0At0KM2A/17sUJULkGQJ3F/vrYueyFARxynZ0
         AbLJLjKijBloMu/Xmtn/n9nK7Yxv8j6s3HY0rrnYbDVQxBwGnwTZeJcfo8qDfZJEr2QI
         adm+wZbP4AU1nE7oxlx7dILCYJm74S6nnN+agW/G974S0uAxL3H6/mgiZkVd70ryMBFT
         qdnA==
X-Gm-Message-State: AA+aEWbiBrG03dVhTi5TFaJgd2Zezcjv4/bYRCUQr8Trrf4Kb5b88O5Z
        GaWL4RueyWShBTzx9NiwDIQ=
X-Google-Smtp-Source: AFSGD/W3z8lqLSw90N5u8GTXFFAiw5jkJ8szU7oFFEhYPNtcQmUv4I/DFbQlhQM+iG427TiwYbz0UA==
X-Received: by 2002:adf:8101:: with SMTP id 1-v6mr1486285wrm.18.1542876500189;
        Thu, 22 Nov 2018 00:48:20 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y9sm13832755wrq.55.2018.11.22.00.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 00:48:19 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:48:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org,
        jgross@suse.com, akataria@vmware.com,
        virtualization@lists.linux-foundation.org, m.mizuma@jp.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, douly.fnst@cn.fujitsu.com,
        dwmw@amazon.co.uk, luto@kernel.org, pasha.tatashin@oracle.com,
        rajvi.jingar@intel.com, zhe.he@windriver.com,
        akpm@linux-foundation.org, dyoung@redhat.com,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, bhe@redhat.com,
        ivan.gorinov@intel.com, robh@kernel.org, andy.shevchenko@gmail.com,
        frank.rowand@sony.com, jan.kiszka@siemens.com,
        jailhouse-dev@googlegroups.com, konrad.wilk@oracle.com,
        thomas.lendacky@amd.com, pravin.shedge4linux@gmail.com,
        namit@vmware.com, jroedel@suse.de, bhelgaas@google.com,
        linux-pci@vger.kernel.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, rostedt@goodmis.org,
        kexec@lists.infradead.org, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        oleg@redhat.com, zhong.weidong@zte.com.cn, up2wing@gmail.com
Subject: Re: [PATCH] x86: fix -Wmissing-prototypes warning
Message-ID: <20181122084815.GA84118@gmail.com>
References: <1542852249-19820-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542852249-19820-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Yi Wang <wang.yi59@zte.com.cn> wrote:

> We may get -Wmissing-prototypes warnings when building
> kernel with W=1, it's better to fix them as global function
> signature can be changed and caller who use the old unchanged
> prototypes will be hosed.
> 
> This patch fixes most of -Wmissing-prototypes warnings which
> are in the root directory of arch/x86/kernel, not including
> the subdirectories.
> 
> These are the warnings fixed in this patch:
> arch/x86/kernel/signal.c:865:17: warning: no previous prototype for ‘sys32_x32_rt_sigreturn’ [-Wmissing-prototypes]
> arch/x86/kernel/signal_compat.c:164:6: warning: no previous prototype for ‘sigaction_compat_abi’ [-Wmissing-prototypes]
> arch/x86/kernel/traps.c:625:46: warning: no previous prototype for ‘sync_regs’ [-Wmissing-prototypes]
> arch/x86/kernel/traps.c:640:24: warning: no previous prototype for ‘fixup_bad_iret’ [-Wmissing-prototypes]
> arch/x86/kernel/traps.c:929:13: warning: no previous prototype for ‘trap_init’ [-Wmissing-prototypes]
> arch/x86/kernel/irq.c:270:28: warning: no previous prototype for ‘smp_x86_platform_ipi’ [-Wmissing-prototypes]
> arch/x86/kernel/irq.c:301:16: warning: no previous prototype for ‘smp_kvm_posted_intr_ipi’ [-Wmissing-prototypes]
> arch/x86/kernel/irq.c:314:16: warning: no previous prototype for ‘smp_kvm_posted_intr_wakeup_ipi’ [-Wmissing-prototypes]
> arch/x86/kernel/irq.c:328:16: warning: no previous prototype for ‘smp_kvm_posted_intr_nested_ipi’ [-Wmissing-prototypes]
> arch/x86/kernel/irq_work.c:16:28: warning: no previous prototype for ‘smp_irq_work_interrupt’ [-Wmissing-prototypes]
> arch/x86/kernel/irqinit.c:79:13: warning: no previous prototype for ‘init_IRQ’ [-Wmissing-prototypes]
> arch/x86/kernel/quirks.c:672:13: warning: no previous prototype for ‘early_platform_quirks’ [-Wmissing-prototypes]
> arch/x86/kernel/tsc.c:1499:15: warning: no previous prototype for ‘calibrate_delay_is_known’ [-Wmissing-prototypes]
> arch/x86/kernel/process.c:653:13: warning: no previous prototype for ‘arch_post_acpi_subsys_init’ [-Wmissing-prototypes]
> arch/x86/kernel/process.c:717:15: warning: no previous prototype for ‘arch_randomize_brk’ [-Wmissing-prototypes]
> arch/x86/kernel/process.c:784:6: warning: no previous prototype for ‘do_arch_prctl_common’ [-Wmissing-prototypes]
> arch/x86/kernel/reboot.c:869:6: warning: no previous prototype for ‘nmi_panic_self_stop’ [-Wmissing-prototypes]
> arch/x86/kernel/smp.c:176:27: warning: no previous prototype for ‘smp_reboot_interrupt’ [-Wmissing-prototypes]
> arch/x86/kernel/smp.c:260:28: warning: no previous prototype for ‘smp_reschedule_interrupt’ [-Wmissing-prototypes]
> arch/x86/kernel/smp.c:281:28: warning: no previous prototype for ‘smp_call_function_interrupt’ [-Wmissing-prototypes]
> arch/x86/kernel/smp.c:291:28: warning: no previous prototype for ‘smp_call_function_single_interrupt’ [-Wmissing-prototypes]
> arch/x86/kernel/ftrace.c:840:6: warning: no previous prototype for ‘arch_ftrace_update_trampoline’ [-Wmissing-prototypes]
> arch/x86/kernel/ftrace.c:934:7: warning: no previous prototype for ‘arch_ftrace_trampoline_func’ [-Wmissing-prototypes]
> arch/x86/kernel/ftrace.c:946:6: warning: no previous prototype for ‘arch_ftrace_trampoline_free’ [-Wmissing-prototypes]
> arch/x86/kernel/crash.c:114:6: warning: no previous prototype for ‘crash_smp_send_stop’ [-Wmissing-prototypes]
> arch/x86/kernel/crash.c:351:5: warning: no previous prototype for ‘crash_setup_memmap_entries’ [-Wmissing-prototypes]
> arch/x86/kernel/crash.c:424:5: warning: no previous prototype for ‘crash_load_segments’ [-Wmissing-prototypes]
> arch/x86/kernel/machine_kexec_64.c:372:7: warning: no previous prototype for ‘arch_kexec_kernel_image_load’ [-Wmissing-prototypes]
> arch/x86/kernel/paravirt-spinlocks.c:12:16: warning: no previous prototype for ‘__native_queued_spin_unlock’ [-Wmissing-prototypes]
> arch/x86/kernel/paravirt-spinlocks.c:18:6: warning: no previous prototype for ‘pv_is_native_spin_unlock’ [-Wmissing-prototypes]
> arch/x86/kernel/paravirt-spinlocks.c:24:16: warning: no previous prototype for ‘__native_vcpu_is_preempted’ [-Wmissing-prototypes]
> arch/x86/kernel/paravirt-spinlocks.c:30:6: warning: no previous prototype for ‘pv_is_native_vcpu_is_preempted’ [-Wmissing-prototypes]
> arch/x86/kernel/kvm.c:258:1: warning: no previous prototype for ‘do_async_page_fault’ [-Wmissing-prototypes]
> arch/x86/kernel/jailhouse.c:200:6: warning: no previous prototype for ‘jailhouse_paravirt’ [-Wmissing-prototypes]
> arch/x86/kernel/check.c:91:13: warning: no previous prototype for ‘setup_bios_corruption_check’ [-Wmissing-prototypes]
> arch/x86/kernel/check.c:139:6: warning: no previous prototype for ‘check_for_bios_corruption’ [-Wmissing-prototypes]
> arch/x86/kernel/devicetree.c:32:13: warning: no previous prototype for ‘early_init_dt_scan_chosen_arch’ [-Wmissing-prototypes]
> arch/x86/kernel/devicetree.c:42:13: warning: no previous prototype for ‘add_dtb’ [-Wmissing-prototypes]
> arch/x86/kernel/devicetree.c:108:6: warning: no previous prototype for ‘x86_of_pci_init’ [-Wmissing-prototypes]
> arch/x86/kernel/devicetree.c:314:13: warning: no previous prototype for ‘x86_dtb_init’ [-Wmissing-prototypes]
> arch/x86/kernel/tracepoint.c:16:5: warning: no previous prototype for ‘trace_pagefault_reg’ [-Wmissing-prototypes]
> arch/x86/kernel/tracepoint.c:22:6: warning: no previous prototype for ‘trace_pagefault_unreg’ [-Wmissing-prototypes]
> arch/x86/kernel/head64.c:113:22: warning: no previous prototype for ‘__startup_64’ [-Wmissing-prototypes]
> arch/x86/kernel/head64.c:262:15: warning: no previous prototype for ‘__startup_secondary_64’ [-Wmissing-prototypes]
> arch/x86/kernel/head64.c:350:12: warning: no previous prototype for ‘early_make_pgtable’ [-Wmissing-prototypes]
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/include/asm/crash.h       | 1 +
>  arch/x86/include/asm/efi.h         | 2 --
>  arch/x86/include/asm/irq.h         | 7 +++++++
>  arch/x86/include/asm/irq_work.h    | 1 +
>  arch/x86/include/asm/kvm_para.h    | 1 +
>  arch/x86/include/asm/paravirt.h    | 5 +++++
>  arch/x86/include/asm/reboot.h      | 1 +
>  arch/x86/include/asm/setup.h       | 5 +++++
>  arch/x86/include/asm/sighandling.h | 5 +++++
>  arch/x86/include/asm/smp.h         | 6 ++++++
>  arch/x86/include/asm/traps.h       | 4 ++++
>  arch/x86/include/asm/tsc.h         | 1 +
>  arch/x86/kernel/check.c            | 3 ++-
>  arch/x86/kernel/crash.c            | 1 +
>  arch/x86/kernel/devicetree.c       | 1 +
>  arch/x86/kernel/jailhouse.c        | 1 +
>  arch/x86/kernel/process.c          | 3 +++
>  arch/x86/kernel/quirks.c           | 1 +
>  arch/x86/kernel/tracepoint.c       | 1 +
>  include/linux/efi.h                | 2 ++
>  include/linux/ftrace.h             | 3 +++
>  include/linux/kexec.h              | 1 +
>  include/linux/of_fdt.h             | 1 +
>  include/linux/ptrace.h             | 1 +
>  24 files changed, 55 insertions(+), 3 deletions(-)

Breaks 32-bit compilation:

./arch/x86/include/asm/setup.h: Assembler messages:
./arch/x86/include/asm/setup.h:30: Error: no such instruction: `unsigned long __startup_64(unsigned long physaddr,struct boot_params *bp)'

I'll skip the setup.h bits - let's hope that's the only bug.

Thanks,

	Ingo
