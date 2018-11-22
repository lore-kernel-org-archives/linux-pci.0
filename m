Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156BC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E497D2081C
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 11:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEU/BCJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394639AbeKVVyB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:54:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52256 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKVVyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 16:54:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so8535107wmb.2;
        Thu, 22 Nov 2018 03:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dRiYMIUednuIfQfeppP8giB2MXTsNS8bx6NiRVsNR6M=;
        b=ZEU/BCJ9GcItUr/ENvduuRnJtH4SVnseFdpWMKTukpThLozU3z11pVjbIm9/o1vbke
         k8iFVgqMx25OX/LmP/DAe8/srjIDPqsswXFzy3a5aF1zjlE+2MKcniSHmnh9v8Oyw7ND
         VmVwebhy4QLolpbeUPVltauitdJYC0oztTpgWPG0t5qvaa7e8ZiqrjBs0GBUpfcPghU/
         cePhbcyZymqCMSUEqnSV3zqrQtriVYjavgmSEu3AXZcAksDnZn+l9SznyU12KJRAaip4
         mbR2f66UxzKdLAgYnqg1TMMcZAVZ6fHp6967Zt8WQDETeaDwiz01J9hiEDKcIIByAh/d
         SF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dRiYMIUednuIfQfeppP8giB2MXTsNS8bx6NiRVsNR6M=;
        b=YSdgDZvfDnqxMSpBmC+5XPnACaU0XNY/M2IA3nlir91V1XJfZp1Me+WhxTyPj6s50e
         NmdOzqzzBu46NxOKK29mULrWODaaGwnUb0+7pyDenbNvC20d56rNY+I9m/Yi0GERQgkR
         gqrlgAK7GcRz7beM3mKas0Jb0KoYRHVr+Lw39EsmyzmbdVay8iB5QPa2n8v3gYNoxY8i
         D4kddslaEtpw5iYVs6BvuQRlWgolsZV/pDdEglzbWESW7vOMU+OhbAFt1iPBwIHY9VxW
         c57bp4/OgCihFakVQxUjpaMk9wV44/WwHFik1G7siolWc4/WmQt/6bwmoEmzo4YH2Pm9
         6eGQ==
X-Gm-Message-State: AGRZ1gIEz/m+XIOafilV7VhdZi/TjmMgCHUIH1PH4CEwBBaOdaQj1YuU
        aQyF0ThSHRXhMyJq8nZVClkjpWgH
X-Google-Smtp-Source: AFSGD/VNhlgzKaj5S6HXSrYoZacDu5lipCtOPhlQMW9IJ5+O78dCGKK8rsokvlJvJ9GpGGKahDmlxg==
X-Received: by 2002:a1c:702:: with SMTP id 2-v6mr9355747wmh.113.1542885303023;
        Thu, 22 Nov 2018 03:15:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n15sm20926974wrt.21.2018.11.22.03.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 03:15:02 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:14:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     wang.yi59@zte.com.cn
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
Message-ID: <20181122111458.GA107823@gmail.com>
References: <20181122084815.GA84118@gmail.com>
 <201811221904598072830@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201811221904598072830@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* wang.yi59@zte.com.cn <wang.yi59@zte.com.cn> wrote:

> Hi Ingo,
> 
> > * Yi Wang <wang.yi59@zte.com.cn> wrote:
> >
> > > We may get -Wmissing-prototypes warnings when building
> > > kernel with W=1, it's better to fix them as global function
> > > signature can be changed and caller who use the old unchanged
> > > prototypes will be hosed.
> > >
> > > This patch fixes most of -Wmissing-prototypes warnings which
> > > are in the root directory of arch/x86/kernel, not including
> > > the subdirectories.
> > >
> > > These are the warnings fixed in this patch:
> > > arch/x86/kernel/signal.c:865:17: warning: no previous prototype for ‘sys32_x32_rt_sigreturn’ [-Wmissing-prototypes]
> 
> ......
> 
> > >  include/linux/ftrace.h             | 3 +++
> > >  include/linux/kexec.h              | 1 +
> > >  include/linux/of_fdt.h             | 1 +
> > >  include/linux/ptrace.h             | 1 +
> > >  24 files changed, 55 insertions(+), 3 deletions(-)
> >
> > Breaks 32-bit compilation:
> >
> > ../arch/x86/include/asm/setup.h: Assembler messages:
> > ../arch/x86/include/asm/setup.h:30: Error: no such instruction: `unsigned long __startup_64(unsigned long physaddr,struct boot_params *bp)'
> >
> > I'll skip the setup.h bits - let's hope that's the only bug.
> 
> Sorry for the inconvenience, though I have checked carefully :-)
> 
> How do you produce this error? I tested this way but did not reproduce
> that error:
> # make allmodconfig
> # make -j8
> 
> Thanks for your time again!

I don't remember the exact config, but you could try the 32-bit 
allnoconfig and defconfig.

Note that the commands you used above will use the 64-bit kernel, not the 
32-bit kernel.

Thanks,

	Ingo
