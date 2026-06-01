Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A243E00A5
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335917; cv=none; b=BEIYUB7vg4JbwRaGtURd+ffVfYB9MN2hy9iPeUDkTd+9s6WS53AP5wXlKYJ3nLhfwKztBYZQRsXr/nnkSL6uW6qO2YBPCs5CYpWM4jwUK3tUowSs1qealBDkaHIf/BNbNH9cF3k0cB+i9Q1gUXciEuZljMfvK1jKWi86073HRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335917; c=relaxed/simple;
	bh=EUaevAzgtzlvUB5/tuC/JSEZdio1mHCw6ZYwf4PCo8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byu0KtjZ3Mp5toE8gW9SSz5TDEfDtbQ3pR52Jq+ygC6U3MFayvVeCBebzqW4ReVjs4yQpqrdfu+U28BbpVN9y3+ZAMa4rSUwcg2OJlypgSucQkPimTuIJEfN+qD3YgHeH6/F3TEGCDYS+VItKCQawoo6tVzAzYh+osxxVRo98hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEfNe5Pt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEfNe5Pt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B9C1F008A3
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335915;
	bh=NQXET+HIwUHzkASejrWXITD/EhCJ1l5nthigBOUX5B4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oEfNe5Pth2hdrzxmWdaSbNtuXmcjlg8gKIUg223dP+4ZwdGCXMPQ33PsBKQQIajO0
	 +AmomxAsFo0OH7Cm9NVqZdKVAj2VPqmGM1B76rNnW+f979D/0veSKY8drBAH+nfGNc
	 iwtxjto4v9iCqHQz09tMd7gQ6idoNceMM5Om1KMkm0MooI9YWggQuGJ3sx852rMKAf
	 ykVuZ4ic3qP0RDUVaPvxl1uMg34mvKS3QR2OjIRjvU/pc/YHl7ZAPGJ+16pMm5xxo/
	 jtM5xKa1OGdj8riB12cmSmbmoc7xp6GteeVjPnL4ENRX/FlIHrQCtAH6t+eJhHXx16
	 RCC5q7A+dxBFA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so1546658e87.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+q0KdJaGi6rp1X77kDjQHLiMm8u/oSpv6aZAXXVnqo/t0Woip3MCcMrPhKaY9yk4oB8Zj+m6F+320=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRWsNIX7uNkRFDednnWo3AP3aCZJdpZfJyKprZvAC6Ll49i5I
	w7yAeg42yEkPTXFryOWgxuIZfOcdJtcCOsFHkeFgpTwwJ2Uqpko1WL9Q+72PRYhbSzYpseNNqSN
	GFjum+vJUD0Sy3k7BvU8So0JqAGpNAwA=
X-Received: by 2002:a05:6512:3b97:b0:5aa:6e86:55c8 with SMTP id
 2adb3069b0e04-5aa6e8657c0mr1302970e87.12.1780335912894; Mon, 01 Jun 2026
 10:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-6-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-6-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:45:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
X-Gm-Features: AVHnY4L1KYHIevdOf61kuP7a6ocAZfa6dkfv0T6IORvr_Om4IsQ3giCPU7iBHEE
Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] ACPI: pad: Use sysfs_emit() for idlecpus show
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:36=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> idlecpus_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/acpi/acpi_pad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index ec94b09bb747..04d61a6cc95f 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -334,8 +334,8 @@ static ssize_t idlecpus_store(struct device *dev,
>  static ssize_t idlecpus_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
> -       return cpumap_print_to_pagebuf(false, buf,
> -                                      to_cpumask(pad_busy_cpus_bits));
> +       return sysfs_emit(buf, "%*pb\n",
> +                         cpumask_pr_args(to_cpumask(pad_busy_cpus_bits))=
);
>  }
>
>  static DEVICE_ATTR_RW(idlecpus);
> --

Applied (with a tweaked subject) as 7.2 material, thanks!
