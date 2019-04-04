Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B2C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC68206DF
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/eUApgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfDDQle (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:41:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44839 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDQle (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 12:41:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so1428873pll.11;
        Thu, 04 Apr 2019 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uenWNpIoJ4m0YsZyBYyNcvf/yqPcCp16FMlFmc3fw54=;
        b=e/eUApgIjYMbx+cHGGPuN6SrAhe9M+WvztlXyVWNu+spUsEBe08JkuqvdzAsu/eIsH
         arULfOS7tfpAm4zzioI8ZFPW6iy9Owi7qQfEy/XNMIX5JCu/GAYHj2gz8bHBBfVp1OZl
         N+xqucdLzCzy2MPIrNJwRTMd6BC7G1Y029MLOBa3P2x70/uinDTJ+QUul9IbmtzT7MyH
         tKFO9Ma6qeNQe44EtgcXN+mzlmwBhMae/kQkIjsjhO9jB8J8+Dk8cDBW39pR11mq31zF
         j0g2YIGcN47NLfZv//fTY0rvbEo2g1b8K+X1wn1pQUCYCNqb6zbk3NbGaLdE6Swnxl1G
         kTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uenWNpIoJ4m0YsZyBYyNcvf/yqPcCp16FMlFmc3fw54=;
        b=hhrerC+dv/3zvDVPg+nDCMrb7JXU1+Fa6qEhH7ZwhsctHDPbc1ryK3JuYOm1ywp6Vr
         w9gtjxDSSwlLKRkHJIM1SaUeG69Nxg1L8N7yv6SPYPwQScspBj4Yue40dN/giOpBiFeD
         sqXi/gfEcShoLktw4MXjJ21TJlHt7CVrrNwxqvFco17bzdRicAOYlPi30Y9XkDjQDVRW
         v5cbeWQPWIxSE5YmiVj6fRg1bogAqO2c60RQyZ1nzlxrkrOFhys9XMPcdd+AQFXFyq5n
         9GAr7gb9ct+ICdzf0BI99QT/FucVSo71ELq1bx/CfyFb5KDqjjsOLbCL4jXcYQj3BBLp
         jwrA==
X-Gm-Message-State: APjAAAVbfg96vXf2oYvCe5MKD3JZXf+4opVPwykLvUFREeAWp7wwkSVl
        gF1elemxl/x8QMsEkTvgJcw7YLYE
X-Google-Smtp-Source: APXvYqyCE86GOkSayF6AwsvdAiWgMPja5B1GtS2tUgEbKpHW+z+LYGzl2gXFRPn7cUrfpD32g8HTrQ==
X-Received: by 2002:a17:902:e084:: with SMTP id cb4mr7603441plb.77.1554396093398;
        Thu, 04 Apr 2019 09:41:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p81sm33367209pfi.186.2019.04.04.09.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 09:41:32 -0700 (PDT)
Date:   Thu, 4 Apr 2019 09:41:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Garry <john.garry@huawei.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, arnd@arndb.de,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bp@suse.de, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com, andy.shevchenko@gmail.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190404164130.GA12203@roeck-us.net>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554393602-152448-4-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 05, 2019 at 12:00:01AM +0800, John Garry wrote:
> Currently when accessing logical indirect PIO addresses in
> logic_{in, out}{,s}, we first ensure that the region is registered.
> 
> However, no such check exists for CPU MMIO regions. The CPU MMIO regions
> would be registered by the PCI host - when PCI_IOBASE is defined - in
> pci_register_io_range().
> 
> We have seen scenarios when systems which don't have a PCI host or, they
> do, and the PCI host probe fails, that certain devices attempts to still
> attempt to access PCI IO ports; examples are in [1] and [2].
> 
> And even though we should protect against this by ensuring the driver
> calls request_{muxed_}region(), some don't do this:
> 
> root@(none)$ insmod hwmon/f71805f.ko
>  Unable to handle kernel paging request at virtual address ffff7dfffee0002e
>  Mem abort info:
>    ESR = 0x96000046
>    Exception class = DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000046
>    CM = 0, WnR = 1
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>  [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
>  Internal error: Oops: 96000046 [#1] PREEMPT SMP
>  Modules linked in: f71805f(+)
>  CPU: 20 PID: 2736 Comm: insmod Not tainted 5.1.0-rc1-00003-g6f1bfec2a620-dirty #99
>  Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
>  pstate: 80000005 (Nzcv daif -PAN -UAO)
>  pc : logic_outb+0x54/0xb8
>  lr : f71805f_find+0x2c/0x1b8 [f71805f]
>  sp : ffff000025fbba90
>  x29: ffff000025fbba90 x28: ffff000008b944d0
>  x27: ffff000025fbbdf0 x26: 0000000000000100
>  x25: ffff801f8c270580 x24: ffff000011420000
>  x23: ffff000025fbbb3e x22: ffff000025fbbb40
>  x21: ffff000008b991b8 x20: 0000000000000087
>  x19: 000000000000002e x18: ffffffffffffffff
>  x17: 0000000000000000 x16: 0000000000000000
>  x15: ffff00001127d6c8 x14: 0000000000000000
>  x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000010820 x10: 0000841fdac40000
>  x9 : 0000000000000001 x8 : 0000000040000000
>  x7 : 0000000000210d00 x6 : 0000000000000000
>  x5 : ffff801fb6a46040 x4 : ffff841febeaeda0
>  x3 : 0000000000ffbffe x2 : ffff000025fbbb40
>  x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
>  Process insmod (pid: 2736, stack limit = 0x(____ptrval____))
>  Call trace:
>   logic_outb+0x54/0xb8
>   f71805f_find+0x2c/0x1b8 [f71805f]
>   f71805f_init+0x38/0xe48 [f71805f]
>   do_one_initcall+0x5c/0x198
>   do_init_module+0x54/0x1b0
>   load_module+0x1dc4/0x2158
>   __se_sys_init_module+0x14c/0x1e8
>   __arm64_sys_init_module+0x18/0x20
>   el0_svc_common+0x5c/0x100
>   el0_svc_handler+0x2c/0x80
>   el0_svc+0x8/0xc
>  Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
>  ---[ end trace 10ea80bde051bbfc ]---
> root@(none)$
> 
> Note that the f71805f driver does not call request_{muxed_}region(), as it
> should.
> 
... which is the real problem, one that is not solved by this patch. This may
result in parallel and descructive accesses if there is another device on the
LPC bus, and another driver accessing that device. Personally I'd rather have
request_muxed_region() added to the f71805f driver.

Guenter

> This patch adds a check to ensure that the CPU MMIO region is registered
> prior to accessing the PCI IO ports.
> 
> [1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
> [2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/
> 
> This patch includes some other tidy-up.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  lib/logic_pio.c | 103 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index 431cd8d99236..3d8d986e9dcb 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -193,95 +193,135 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
>  
>  #if defined(PCI_IOBASE)
>  #if defined(CONFIG_INDIRECT_PIO)
> +#define INVALID_RANGE(range)						\
> +	(!(range) || ((range)->flags == LOGIC_PIO_INDIRECT && !(range)->ops))
> +
>  #define BUILD_LOGIC_IO(bw, type)					\
>  type logic_in##bw(unsigned long addr)					\
>  {									\
>  	type ret = (type)~0;						\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return ret;						\
> +	}								\
>  									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		ret = read##bw(PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>  		size_t sz = sizeof(type);				\
> +		void *hostdata = range->hostdata;			\
>  									\
> -		if (entry && entry->ops)				\
> -			ret = entry->ops->in(entry->hostdata, addr, sz);\
> -		else							\
> -			WARN_ON_ONCE(1);				\
> +		if (range->ops->in)					\
> +			ret = range->ops->in(hostdata, addr, sz);	\
>  	}								\
>  	return ret;							\
>  }									\
>  									\
> -void logic_out##bw(type value, unsigned long addr)			\
> +void logic_out##bw(type val, unsigned long addr)			\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
> -		write##bw(value, PCI_IOBASE + addr);			\
> +		write##bw(val, PCI_IOBASE + addr);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>  		size_t sz = sizeof(type);				\
> +		void *hostdata = range->hostdata;			\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->out(entry->hostdata,		\
> -					addr, value, sz);		\
> -		else							\
> -			WARN_ON_ONCE(1);				\
> +		if (range->ops->out)					\
> +			range->ops->out(hostdata, addr, val, sz);	\
>  	}								\
>  }									\
>  									\
>  void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>  		size_t sz = sizeof(type);				\
> +		void *hostdata = range->hostdata;			\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->ins(entry->hostdata,		\
> -				addr, buf, sz, cnt);			\
> -		else							\
> -			WARN_ON_ONCE(1);				\
> +		if (range->ops->ins)					\
> +			range->ops->ins(hostdata, addr, buf, sz, cnt);	\
>  	}								\
> -									\
>  }									\
>  									\
>  void logic_outs##bw(unsigned long addr, const void *buf,		\
>  		    unsigned int cnt)					\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT) {					\
>  		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>  		size_t sz = sizeof(type);				\
> +		void *hostdata = range->hostdata;			\
>  									\
> -		if (entry && entry->ops)				\
> -			entry->ops->outs(entry->hostdata,		\
> -				addr, buf, sz, cnt);			\
> -		else							\
> -			WARN_ON_ONCE(1);				\
> +		if (range->ops->outs)					\
> +			range->ops->outs(hostdata, addr, buf, sz, cnt);	\
>  	}								\
>  }
>  
>  #else /* CONFIG_INDIRECT_PIO */
>  
> +#define INVALID_RANGE(range) (!(range))
> +
>  #define BUILD_LOGIC_IO(bw, type)					\
>  type logic_in##bw(unsigned long addr)					\
>  {									\
>  	type ret = (type)~0;						\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return ret;						\
> +	}								\
>  									\
>  	if (addr < MMIO_UPPER_LIMIT)					\
>  		ret = read##bw(PCI_IOBASE + addr);			\
>  	return ret;							\
>  }									\
>  									\
> -void logic_out##bw(type value, unsigned long addr)			\
> +void logic_out##bw(type val, unsigned long addr)			\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT)					\
> -		write##bw(value, PCI_IOBASE + addr);			\
> +		write##bw(val, PCI_IOBASE + addr);			\
>  }									\
>  									\
>  void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT)					\
>  		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
>  }									\
> @@ -289,6 +329,13 @@ void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>  void logic_outs##bw(unsigned long addr, const void *buf,		\
>  		    unsigned int cnt)					\
>  {									\
> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
> +									\
> +	if (INVALID_RANGE(range)) {					\
> +		WARN_ON_ONCE(1);					\
> +		return;							\
> +	}								\
> +									\
>  	if (addr < MMIO_UPPER_LIMIT)					\
>  		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
>  }
> -- 
> 2.17.1
> 
