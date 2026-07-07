Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BF22A1D4;
	Tue,  7 Jul 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443271; cv=none; b=UelDsgy/iyyxKJyD684n0YMLjydsdoo48PU0BJJTv9PzwfKTJqq1zjQqBF257atSLqIcPIeuFFN+D01MucYVp3HCAsku/MruuWurdIUpRpSMGxj63KBha8EzDjHJtOeHkvQbkxT0VzAteKyokH9KyB+ieRs5eE5Der5jHLZjtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443271; c=relaxed/simple;
	bh=FpXqF6jk5toMGJXq4EtPaKYm/o4ECCY0nVqige8yqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQq+XPu1kAfKySmLhGRYELlWK+SQdUeCuh2f7kZyXSkWn6bXFnNc/Nr9cc3dPhuUrKMaGuQplhW87C68WCkHVEthnbOLCxht8voCyHyV7OLU8prRmmuvDGoL4wwhY+z8ZjGFaFAzG3wldHWTnutyUujc/Kp8sOJXW4VkZDAN2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Pl4p1yal; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Pl4p1yal"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=j2Rqn1Z44LxF7P3FTLDUbHYmw1rGJj24sZvFbQfBOow=; b=Pl4p1yalKmm+mrZN7WFY+OF3pM
	EKFT9R+1VEqiL2myq3u6bDdn34eocPOjGy9JrK477auMsnFu7fLI5bKaCGN2GvnTsj3kBl6mV7AcU
	4YBbRFNWwR3rWAFsVDWI1ibDYxasy5K/hDqoS3SBo/MCJcDQqsx19Spietc/z21PqdKLeXsNQHs+1
	wSqtBxnD+ylek2GfjgWVFqC6hyb8pS3dIofyFEnYVP/ia3JodiWWQ9PNFlbDtW3fw8LDlDUszQc1s
	p9v1z5eBEx7PinOyrxu7eLDXRctpsmbQKHA3d+AabcpgqwuctT2osEXUEMxp42Y990eiWJOEXngH3
	0SzOND0g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh93F-002KMz-26;
	Tue, 07 Jul 2026 16:53:42 +0000
Date: Tue, 7 Jul 2026 09:53:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <ak0sGAX_NWMyeofC@gmail.com>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
 <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
X-Debian-User: leitao

On Tue, Jul 07, 2026 at 09:02:47AM -0700, Borislav Petkov wrote:
> On Tue, Jul 07, 2026 at 07:02:34AM -0700, Breno Leitao wrote:
> > Move the implementation to drivers/ras/hwerr_tracking.c and the
> > declaration (with its no-op stub) to <linux/ras.h>.  Give it a dedicated
> > CONFIG_RAS_HWERR (bool, under RAS, default y) rather than riding
> 
> Definitely not default y.

The current vmcoreinfo implementation defaults to enabled, so I wanted to
preserve that behavior to avoid silently removing symbols that existing
tools may depend on. Would you prefer a different default?

> Do not explain the WHAT - that's visible from the diff below; explain the WHY.

Will do.

> > Link: https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/ [1]
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Once we move it outside of vmcore info, I am planning to add new
> > features that are in the limbo now, given they don't belong to vmcore
> > info, such as:
> > 
> > Track fatal hardware errors
> > 	https://lore.kernel.org/all/20260617-hwerr-v1-0-ff131cd6203c@debian.org/
> > 
> > Expose hardware error recovery statistics via sysfs
> > 	https://lore.kernel.org/all/20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org/
> 
> We already have rasdaemon and a whole pile of infrastructure around reporting
> errors. Why isn't what we have, enough?
> 
> The stick-the-error-into-vmcore makes sense as a use case, sure. But this
> other information we already have plenty. I think you should use/extend that
> instead of adding more.

I agree the sysfs exposure duplicates existing infrastructure, points
taken. However, tracking fatal hardware errors provides value at crash
analysis time—it lets us quickly determine whether a fatal hardware
error occurred during the kernel's lifetime, which is useful for
root-cause attribution.

> The stick-the-error-into-vmcore makes sense as a use case

For this, would you like to keep it in vmcore info (as of today), or
move to RAS subsystem?

Thanks for the review and direction,
--breno
