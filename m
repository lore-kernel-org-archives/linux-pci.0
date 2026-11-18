Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028061;
	b=lgbAfyEKrnQO9L8JbdmxYmjfZhdV0Uow7gIsJBWYrGT4M9V7KMJEpIq0kA5ydUOsshmy
	 IYn1yqbJoYMQNl78kWtIaabb07hB5r6wSiXGIp1kW+Oy8qGO8+ZyjD7XNOM5k9QR02w/N
	 HgiJd/O3v+MUCz2ax3lQDQRnwdsgTvnsFgGVtCutHN9FzQOiYU1FqH0Oe1hUNNQUypxv9
	 vKq7sUAHnboghaa8xfM+DOCh5sCiYgiDvTFQ7I9A1g6z+NusXZQ9yQsJbNov8wUP2VU9k
	 J8FvLRGccuFM1k9GPvhYZe8DURYl10y1DpVg9IObxISZLH1KkXyl22qKsRB40FyQP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028061;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TZsTikxfxLhewEbP2xR/h7zJwb5pgHnbb8uIv7AdPeo=;
	b=tG/lmY27jSfnj/P60XHkWRjR9zrfF7yzzPfi1ol+vycfptBO8Gee3qxmasTAEReTWB7e
	 a6/graVdojNoiKCLyGJT8BOUCxAK7jZ/lVtzCNc1j/gFtsupQ5otB8NVgGi9QCP83elR/
	 K7mV72qwvV4/98aS0d1/HiLmamaNXmPfwagsTStuA3xMsQcYNb0vQz2GNvVtzqxwSiUDE
	 b/+AtzpFWhQudUPyV4SDhskXfM2vyW9Idc+G85bGYDqgqw1b8LPOVzqHribMDl0iMX6+Z
	 VXRLj1bB6Ih5gDeAu+HK/Q449mffBxzVsBoAaq/HP7+o/udHIkxrD63ZpttkNuQm6yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAVBtdBK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7A606A325;
	Wed, 18 Nov 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAVBtdBK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD461F000C4;
	Wed, 18 Nov 2026 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028060;
	bh=TZsTikxfxLhewEbP2xR/h7zJwb5pgHnbb8uIv7AdPeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CAVBtdBKiBua6AQR1YohOwJUX4aO/2Q0tv9TEF+7XlxUgb8/hTMAcTjU1BRo9mNhM
	 vXlXljYJ68uR0nta3BcJzXxhizkEaFpau8HtwwTpAMB9EpYrh7caZXxus/c58QuuJY
	 OxQVkJTcj1AU9jmeUw5z+Xmix19MT+e/a7VRcvEgtTgCWDxrCx5CLRGY2oJVGilPrG
	 aIR6R36xz2meISdE12Fj3Lz8mjYuedoWR31zdi66bRgzItaXpNzih99tvTnHEOYx4z
	 3XvTuBvys9gsXyDPTo2lbtBEFr+VVVG264RmidGpNQZXHyWiy/OI5CEwB/o4aShiAP
	 GkmDQRva+xv1A==
Date: Wed, 18 Nov 2026 18:54:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Radu Rendec <radu@rendec.net>, Avadhut Naik
 <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 01/19] x86/APEI: Extract common CPER memory error
 reporting helper
Message-ID: <20261118185406.21700e81@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-2-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-2-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 12:10:11 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Prepare for reporting CPER Memory Error Section 2 records through MCE
> by extracting apei_mce_report_mem_error_common().
> 
> No functional change.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
One curious question + trivial comment inline.

Otherwise, this is a simple refactor and seems clean to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  arch/x86/kernel/cpu/mce/apei.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 0a89947e47bc8..b993ac78a3b36 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -26,24 +26,15 @@
>  
>  #include "internal.h"
>  
> -void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> +static void apei_mce_report_mem_error_common(int severity, u64 physical_addr,
> +					     u64 physical_addr_mask)
>  {
>  	struct mce_hw_err err;
>  	struct mce *m;
>  	int lsb;
>  
> -	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> -		return;
> -
> -	/*
> -	 * Even if the ->validation_bits are set for address mask,
> -	 * to be extra safe, check and reject an error radius '0',
> -	 * and fall back to the default page size.
> -	 */
> -	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
> -	else
> -		lsb = PAGE_SHIFT;
> +	/* Missing or zero masks default to page granularity. */
> +	lsb = find_first_bit((void *)&physical_addr_mask, PAGE_SHIFT);

Silly question.  What stops it being bigger than a page?  I appreciate you
aren't changing what is already here but it made me curious.  It's 8 bytes
so limiting it to page size seems odd.

That larger usecase came up last year for how to handle error injection
into a VM that was running smaller pages than the host.

I guess on x86 it simply isn't ever bigger than one page?


>  
>  	mce_prep_record(&err);
>  	m = &err.m;
> @@ -60,9 +51,21 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  		m->tsc = rdtsc();
>  	}
>  
> -	m->addr = mem_err->physical_addr;
> +	m->addr = physical_addr;
>  	mce_log(&err);
>  }
> +
> +void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> +{
> +	u64 mask = 0;
> +
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +		return;

I'd add a blank line here given that return is a mite hard to spot.

> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		mask = mem_err->physical_addr_mask;
> +
> +	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
> +}
>  EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  
>  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)

