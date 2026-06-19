Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359F2AD03;
	Fri, 19 Jun 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893614; cv=none; b=JjYmFeQRsT/hJiou9oBkoSLGimlG6MtLvGU8sZbTBow+swk9ZPy1i+1OI4gdgriqx1DmjY6JBGKxxNtKAWBM8EsiQcL9Odw4OKQBYG3WiNTHHaHrEyNcsh3DHxtEHcDaQ3vbE4lU3urkKnTxqaBwS64TcMdIuOaUQWMGhC7zqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893614; c=relaxed/simple;
	bh=N45CtaDZr33VhrbPRkWElClPHFGKdwKHRTGYO8RICNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQAVnF3uO7SVPJu7F3iyXNGiAmZA6A2YRuqzFOkZ11qiNyyKt2jBNWtJJZ6mvJNnCQo1+3f0Lit7SwXJ9ThSO1yJ20niO9/17Hk9Jowmozk65LCdzDj1nzOEc58mWR2/IsdbO6+y5m/z0v6npFYxnH7R9ft29fLxwskNOIQijOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqw43Dka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqw43Dka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F29D1F000E9;
	Fri, 19 Jun 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893613;
	bh=O90z38LeE6i6QaVkuSD9BRsZhKa8NI0927rD1P9TLxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqw43DkarCaENCkekdO0AKbMjbJ8aJHydsaDL17hlu46rzHlDN0PG9gsPIplUe5Tw
	 wW0KbdFjhppEID51D8uvKptg4rZj41ghT51J/5z7N7dyajAUDlEpmRVznt9EUUQ2Zn
	 r+uHTsWGNI60Qq6QYk/V/UXFuOY67iWykBAgE8rP2U4SYrNXL/OovRRmhIeptJZp1k
	 kfVymhH6OKwENKDeEvKk8UG3YwfP+39Vo2+9H+Hpf+gZw12Ck/QWPFprCzYlmn+XuJ
	 fWBpLs3pnZ8ObXV6wuUHCorYPHKpMXH437rkq+sQqwE2xJK0Sqa1PKR/n/ODApjC33
	 OSSRY8yR1+kFg==
Date: Sat, 20 Jun 2026 03:26:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 22/25] PCI/sysfs: Add legacy I/O and memory attribute
 macros
Message-ID: <20260619182603.GA2528910@rocinante>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-23-kwilczynski@kernel.org>
 <20260619091836.0883F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619091836.0883F1F000E9@smtp.kernel.org>

Hello,

> [Severity: High]
> This isn't a bug introduced by this patch, but can the use of
> pci_write_legacy_io() here trigger an out-of-bounds heap read?
> 
> When a user writes 1 or 2 bytes to a legacy_io sysfs file,
> kernfs_fop_write_iter() allocates a buffer of count + 1 bytes.
> 
> In pci_write_legacy_io(), after validating count is 1, 2, or 4, the buffer is
> cast and unconditionally dereferenced as a u32:
> 
> drivers/pci/pci-sysfs.c:pci_write_legacy_io() {
>         /* Only support 1, 2 or 4 byte accesses */
>         if (count != 1 && count != 2 && count != 4)
>                 return -EINVAL;
> 
>         return pci_legacy_write(bus, off, *(u32 *)buf, count);
> }
> 
> Does the *(u32 *)buf dereference cause a 4-byte read from the smaller 2-byte
> or 3-byte buffer, potentially triggering a KASAN slab-out-of-bounds read?

A known issue for which a patch with a fix has been sent.

Thank you!

	Krzysztof
