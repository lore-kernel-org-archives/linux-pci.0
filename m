Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EFBC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51BA21855
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrghVhic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCNRMD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:12:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38799 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfCNRMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 13:12:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id m2so4420289pgl.5;
        Thu, 14 Mar 2019 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xasB1ae2coF0jOh9+BM/milD/UZemG6W2sE7ENEOXW4=;
        b=JrghVhic0LOfYTkxovvh542skdnL67l6kn7rQigwl2dBSPoHbrM87g5vtWxaH7FMQQ
         SdI0vWgSxMAa7Q8xhNt3cwZcb4XZ2B4Kj02HnikZcWrNpqby59pGQ74s8KVDdRHEM7wd
         LQgLbu/HGfQ1+m2iuKSnW4GVdZcffbgHXm0yMUVhq8CRcXaPAxYFkXEwEYxpKC74HCNw
         MLzlxuSIEdzFbLYr2XsvK3UcHxTNL5JMKa9wM/DsLyLUwbP5UEe6D68Y83il2qINA8d2
         9je4lZWG2Wx9ebS63fAkqNu+T8jtFbxCl9rgeFqSgEgbEiXnKl4TYDTBAzbf5vDX5rT3
         fSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xasB1ae2coF0jOh9+BM/milD/UZemG6W2sE7ENEOXW4=;
        b=Yco3u3XzhlhYvQFvx499YZm/LsbkrH5i3ITaQVN95LhwfjJk/vSe4sEogq84VOe425
         wTq+NWUriNpyzyMlXVwdiu7DzJ9J+eD8rJjzZEt/IU4hUQbQrCoihxk7+vz5ShWVSaUJ
         DDXBuIqWgLq/2tOiXr3h6zgSKljoj4IK//bq1KPB5TZbRk4KFlpqojQML04qU9ckDIkg
         EVFrp6WB5gLv4vduhn8ykKs9i8LZx2PtiSu9U18wSYAdSSAToqPMxUcs6cMdjD9AXNct
         oex7p6ycFXt+VJnijNPRNBKUyKv3w2ULesMm+oUmzELOUxZW9PuvspX4KjXjIz4jqDh5
         6NUg==
X-Gm-Message-State: APjAAAVNBOvgON9ODO82wDW004AikqqKhZNT3vZeISB2a1w93uEBeuzD
        XR1HehnvUetIvmfwEIun9xs=
X-Google-Smtp-Source: APXvYqyBbqo5Pj2atA0uYGbv//Y03us7TwKgx5o06oJrHy4SwIGExafhnrix2QHTyAkKtlCkPBBCEQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr46170480pla.226.1552583521683;
        Thu, 14 Mar 2019 10:12:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2sm19360812pfo.163.2019.03.14.10.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 10:12:01 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:12:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Garry <john.garry@huawei.com>
Cc:     jdelvare@suse.com, bhelgaas@google.com, rafael@kernel.org,
        arnd@arndb.de, lorenzo.pieralisi@arm.com, bp@suse.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 1/2] resource: Request IO port regions from children
 of ioport_resource
Message-ID: <20190314171200.GC14159@roeck-us.net>
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
 <1552582516-70855-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552582516-70855-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 15, 2019 at 12:55:15AM +0800, John Garry wrote:
> Currently when we request an IO port region, the request is made directly
> to the top resource, ioport_resource.
> 
> There is an issue here, in that drivers may request an IO port region even
> if the IO port region has not even been mapped in (in pci_remap_iospace()).
> 
> This may lead to crashes when the PCI host has not enumerated prior to
> accessing the IO port region, as below:
> 
> root@(none)$ insmod f71805f.ko
> [   32.264016] Unable to handle kernel paging request at virtual address ffff7dfffee0002e
> [   32.279936] Mem abort info:
> [   32.285536]   ESR = 0x96000046
> [   32.291657]   Exception class = DABT (current EL), IL = 32 bits
> [   32.303542]   SET = 0, FnV = 0
> [   32.309661]   EA = 0, S1PTW = 0
> [   32.315957] Data abort info:
> [   32.321728]   ISV = 0, ISS = 0x00000046
> [   32.329420]   CM = 0, WnR = 1
> [   32.335367] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [   32.349174] [ffff7dfffee0002e] pgd=0000000001392003, pud=0000000001393003, pmd=0000000000000000
> [   32.366652] Internal error: Oops: 96000046 [#1] PREEMPT SMP
> [   32.377835] Modules linked in: f71805f(+)
> [   32.385876] CPU: 4 PID: 2681 Comm: insmod Not tainted 5.0.0-00003-ga6247cc0f8f2 #52
> [   32.401252] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
> [   32.419597] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [   32.429213] pc : logic_outb+0x54/0xb8
> [   32.436556] lr : f71805f_find+0x2c/0x1b8 [f71805f]
> [   32.446167] sp : ffff0000256bba90
> [   32.452808] x29: ffff0000256bba90 x28: ffff000008b544d0
> [   32.463468] x27: ffff0000256bbdf0 x26: 0000000000000100
> [   32.474127] x25: 000000000000002c x24: ffff000011396000
> [   32.484787] x23: ffff0000256bbb3e x22: ffff0000256bbb40
> [   32.495446] x21: ffff000008b591b8 x20: 0000000000000087
> [   32.506106] x19: 000000000000002e x18: ffffffffffffffff
> [   32.516765] x17: 0000000000000000 x16: 0000000000000000
> [   32.527424] x15: 0000000000000400 x14: 0000000000000400
> [   32.538084] x13: 0000000000001832 x12: 0000000000000000
> [   32.548743] x11: ffff801ffbf08ac0 x10: 0000801fead02000
> [   32.559403] x9 : ffff801ffbffe840 x8 : 0000000000000001
> [   32.570062] x7 : 0000000000210d00 x6 : 0000000000000000
> [   32.580721] x5 : ffff801fb3eac380 x4 : ffff801ffbef4b20
> [   32.591381] x3 : 0000000000ffbffe x2 : ffff0000256bbb40
> [   32.602040] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
> [   32.612701] Process insmod (pid: 2681, stack limit = 0x(____ptrval____))
> [   32.626155] Call trace:
> [   32.631050]  logic_outb+0x54/0xb8
> [   32.637693]  f71805f_find+0x2c/0x1b8 [f71805f]
> [   32.646607]  f71805f_init+0x38/0xe48 [f71805f]
> [   32.655521]  do_one_initcall+0x5c/0x178
> [   32.663212]  do_init_module+0x58/0x1b0
> [   32.670728]  load_module+0x1dc8/0x2178
> [   32.678243]  __se_sys_init_module+0x14c/0x1e8
> [   32.686981]  __arm64_sys_init_module+0x18/0x20
> [   32.695894]  el0_svc_common+0x60/0x100
> [   32.703409]  el0_svc_handler+0x2c/0x80
> [   32.710924]  el0_svc+0x8/0xc
> [   32.716693] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
> [   32.728925] ---[ end trace ddb5e493ee686685 ]---
> Segmentation fault
> root@(none)$
> 
> This issue was originally reported in [1].
> 
> This patch changes the functionality of request_region() to request a
> region of the direct children of the top ioport_resource.
> 
> In this, if the IO port region has not been mapped for a particular IO
> region, a suitable child region will not exist, and, as such,
> request_region() calls will fail.
> 
> A side note: there are many drivers in the kernel which fail to even call
> request_region() prior to IO port accesses, and they also need to be fixed
> (to call request_region() as appropriate).
> 

Isn't that orthogonal to this problem ?

> [1] https://www.spinics.net/lists/linux-pci/msg49821.html
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/linux/ioport.h |  6 +++++-
>  kernel/resource.c      | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..cf40e1ed8211 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -217,7 +217,7 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>  
>  
>  /* Convenience shorthand with allocation */
> -#define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
> +#define request_region(start,n,name)		__request_region_from_children(&ioport_resource, (start), (n), (name), 0)
>  #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
>  #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
>  #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)

I can't comment on the merits of the patch (though I am a bit concerned
about its impact and potential source of regressions), but I don't really
understand why it would only apply to request_region() and not to
request_muxed_region(). Is this an oversight or on purpose ?

Guenter
