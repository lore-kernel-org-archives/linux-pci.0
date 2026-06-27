Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08967149DF1
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782582571; cv=none; b=aBAMZkMmhJ+tDz+AJBDfbtHfxUm+N/XIpBuAuo8bJUOmrFPKYpl3EHDQUy2iDU+fOFYHgjuO9DfLgdGcyWR5eOgSGD0xTENtX7RMvIe7+Vdvdf5F9mYgnpbZC85gG+zDLCzeHWHRyK7WEZjCmrBvpljFa12HqOLpBl0yBwQ8TpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782582571; c=relaxed/simple;
	bh=YA+1i/UnBYMi612cEFEOy+3MzER+Xfj7iA6l8jGXb4M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqBWml+sZkZLyg3tgy3QWUrv+O87pvRvuZ80rDtczf5Wgo6yto2O9I/3FkFj/I+vhxgFODDK2NfOTzrlCZA2Jf6Ma0Q2cxq0emG7r4fRbVPkP/4UBoQKuhzsPUWPYpC5apcJmHKqjk27WwGuY+hwyQUVSRZrQ70/uoTpSELuNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+APVrVB; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+APVrVB"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-734478b19f7so1484052137.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782582569; x=1783187369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uflCN5dEoFADXWjqBtV9JZXNhAeBkbLG/4dD0z7b4I=;
        b=D+APVrVB7sDaioieVdmISDPXpLFAuW6Z8ACka+jIwp7ns0TQdWs5MEy+Z/dxvn8VAa
         e29T4yf7lV++S7Zg1KPGSJLqvjfqzUAvUEu7tSGmqaCsQogJoe9MO5ZfM/HH/GhY8ux0
         YW6ZINIMDlm8qugBnJpjrCnTOHTSXKlAPJF11MzR2txP/MrDTMvFDy0oCu+HsC/1rWic
         5RnQmKwAXJpxLkTmgZLfBFUKtZnCgcM2yM4bDprDEVL6jHCMPi1e3zAqIe9XmKpm9HEA
         GY5jXZXmdNMNEJwgCkWWPPLSrpsmhX+cbfcTpaZTE+Q/IJm4Gxe+tsxjkBwBxlPFhi9j
         4y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782582569; x=1783187369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uflCN5dEoFADXWjqBtV9JZXNhAeBkbLG/4dD0z7b4I=;
        b=Yp0a0kXBEFSX3hCCbhYhped4/Y29qmT4tWTpqDjeuojJRleHpzl3Io00uXlzXXb3xT
         QYMXVcCQAbZttt7nJh9J0uD25H6qw+7y6M3j5MjSb6sKqMSMqpeZK8U5wA1T7um5Uh+P
         MSPtL0PapG6AWV3w5/N3pSVsKKBOqrT9WXhOcUFvJ1YhMq6Wi7f13sOoQ+rMBExFqHYu
         pWixMsKVv3mxO6RGMKuMyLKpIaUYja8P6Jg3khRuLRlQyI61oKhW5IpbSFYZH+83TGSM
         YX+2Qb6Gj95ZIVcV7F0Gxl9ZQAqzSGvrYAuKowyBG3Jy1t9cKk9qpPNDdjcF9+zPQGas
         vvoA==
X-Forwarded-Encrypted: i=1; AHgh+Rpy9POYwb+0MRbVImd8o896h+t3TO3IdYxtMrswNq88xTI6ibmu/0kFbhhH9/xHMFAsNx19aU7z9dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00GVNt/nIJJLu/VXTmtsm096C57f8ZM0a/9OWMvYFgDAdcD9B
	JbL7eWhZUMEuihSyT2uC4osYC8JWgnOv0nBkvqQnWN5B4np/V996wNQE
X-Gm-Gg: AfdE7cmEzBaRGtzbJCd5wsmBC7mkQN3tcCjkIAKTDGoicEm8yB90V2TXFnn9aQ0uFGh
	TrR2sUtBcGZyiKj6UzaKg1Bc2qc55GbW78I1CydZF2fCcEWkoMZkbtR+h9z7xL4oZBivjdmzuad
	BMyDd4hD457wV1zsZgo+VqPQK3mT1a2hRC5yMYF2b9lqqk4H9Rd3FNVPS1JjADe1Q6Co/xaatde
	k/i3SoLzMeFr64hoOo/ebUneUNMAvGDmSDBfOJcceXTC8X4BOOvV9bO03qWRuScMf4mUgE2zw3f
	CfM+eBXXwLToskJnT8twHMW5//CS4xtj2LzfoPS7Oj3MrBoX95XOJmaVVdEaswviHo290vKAHnL
	8A6qlZR4IvXV945vyuZcbHk6cGRIbfqvHOR60QdkWpePwJuD/n19xfBFYLRnHo2ztFhXA5lnp7A
	QyjdZ4Ll/2kZf58/YYZJ1uG8myNiLzm8gfLXoi49SmE4mp
X-Received: by 2002:a05:6102:440f:b0:730:db02:1d08 with SMTP id ada2fe7eead31-73434452fd5mr5471882137.10.1782582569056;
        Sat, 27 Jun 2026 10:49:29 -0700 (PDT)
Received: from localhost (d-24-145-72-22.fl.cpe.atlanticbb.net. [24.145.72.22])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96916e5b10dsm2811280241.4.2026.06.27.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:49:28 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sat, 27 Jun 2026 13:49:27 -0400
To: David Laight <david.laight.linux@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 13/16] perf: Use sysfs_emit() for cpumask show callbacks
Message-ID: <akANJ-AT7nHpRMq-@yury>
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528183625.870813-14-ynorov@nvidia.com>
 <7e980b99-1e4e-408b-8ebd-4d28116e7ad5@arm.com>
 <20260529130619.12f24264@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529130619.12f24264@pumpkin>

On Fri, May 29, 2026 at 01:06:19PM +0100, David Laight wrote:
> On Fri, 29 May 2026 12:05:08 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
> > On 2026-05-28 7:36 pm, Yury Norov wrote:
> > > These callbacks are sysfs show paths.
> > > 
> > > Use sysfs_emit() and cpumask_pr_args() to emit the masks.
> > > 
> > > This prepares for removing cpumap_print_to_pagebuf().  
> > 
> > TBH, looking at this diff I think it only shows the value of having a 
> > helper to abstract the boilerplate...
> > 
> > I'm not sure I agree with the argument of removing something entirely 
> > just because it may occasionally be misused, but could we at least have 
> > something like:
> > 
> > #define sysfs_emit_cpumask(buf, mask) \
> > 	sysfs_emit((buf), "%*pbl\n", cpumask_pr_args(mask))
> >
> > to save the mess in all the many places where the current 
> > cpumap_print_to_pagebuf() usage _is_ entirely appropriate?

This way you have to add 2 wrappers:

 #define sysfs_emit_cpulist(buf, mask) \
 	sysfs_emit((buf), "%*pbl\n", cpumask_pr_args(mask))

 and

 #define sysfs_emit_cpumask(buf, mask) \
 	sysfs_emit((buf), "%*pb\n", cpumask_pr_args(mask))

There are people who complain even about DIV_ROUND_UP(), how hard it is
to keep all that helpers in memory, and all that things.

https://lore.kernel.org/all/20260304124805.GB2277644@noisy.programming.kicks-ass.net/

Disagree about DIV_ROUND_UP() (because yeah, I'm bad in math), but
this sysfs_emit_cpumask() is a complete syntax redundancy.

Once we have it, people will do this type of things:

        tmp = kmalloc(PAGE_SIZE);
        sysfs_emit_cpumask(tmp, mask);
        sysfs_emit(buf, "my prefix: %s\n", tmp);
        kfree(tmp);

Patch #1 in this series is one example. My series that removes
bitmap_print_to_pagebuf() will give you more:

https://lore.kernel.org/all/20260303200842.124996-2-ynorov@nvidia.com/

It doesn't mean that *you* will misuse the API. It means that *I* will
have to inspect the codebase for that type of bugs periodically.

So, the overall state is simple: we've got well-established
printf()-like functions that people know and understand, and we also
have exotic APIs here and there with a non-standard interface and a
clear potential to misuse. In this case, they have historical roots,
but now we don't need them.

> That has the advantage of letting you change how it is done (again)
> without having to find all the callers.

You mean things like silencing the prints or adding a prefix?

If you believe that perf subsystem would benefit from it - that's
OK. Just please keep it local. The kernel globally doesn't need to
'change how it is done' beyond the lib/vsprintf.  The kernel really
needs people to use something that the other people are familiar with.

Thanks,
Yury
