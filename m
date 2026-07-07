Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55821306D3F;
	Tue,  7 Jul 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449359; cv=none; b=V3whXcqr7s4c294pMf/vyw9Lm7KKHIyplC7Saz+94l0O1OTSNNE6oYh+HkG8Wb8zryWqDfAc9ovOvBgs277qhvF8WUg20rgXIVxKiTif2umkuTBZ0d7KRfWIeAVG6gsfd1wmChQOIAIFbaPZ/7/WF+LL1otKOIkJvFkGxKovpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449359; c=relaxed/simple;
	bh=BDpLDQ7jUxEOvLkZsys35mNRQRxhC+Q50fjweTLjYIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OORPLfcLnzqINulmVpXbRQgb15abCWWFaITwns+0V0zRHsL92AyddqnmR5ObohYjqhIVEOch1ZT9OiDpaB9FGvrXO9Nsr7waRDH7bpv+sZSYbaGtBjrGsR+xe2FOYteZ6HA5SePB0Kh0zd2VJ0OQsqDlcPDbbRgKYhrNjbOLEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gTc6FoWa reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gTc6FoWa"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C575B40E0140;
	Tue,  7 Jul 2026 18:35:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YwzEzrF91RIy; Tue,  7 Jul 2026 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783449343; bh=ua4u1LuUlezN8j6xu2WIJg9JtcJ7b4ThrEAFlNhjKjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTc6FoWaXOvHrcV7b24WqFshXfsrcHIgdZ87MOaPfogiTPw5w20YhQgy/iwJWZUKh
	 7yTEG9SSMwC7UT6G4waoaf4D71z4dRJdOy2a1WowEV5tYoCmuSwYdL7ssMglGvQyy7
	 8ALdrILLDVaX9LtEELvuDM1B1cCxDVsztC9DMAI483AzO7/84fyH7mZswHc+VVyM0M
	 qgfJ5ZNRxGiNzZmhkLm5Bz6I1ivFExeO6Q4+073FfymSMDZy1lK59poyzR9o8v+DNs
	 sc+r0HZLDcVk5/joZ8DLmKToROIqCn5umWnhW0+/OJG7aNstYug+GexLfXnGggWEcg
	 JRoV3XZ6r1+kHRoXFxnJA+09g5McuH6DvyuQbK6Yu26eWilxO+fIImgnJDLpoXBfZ6
	 DFWUzpXId+BxhGag8reTRp7vgLsROnQqym6A2s6ed5lmCZG8k7KejZ0xrQhjXpiJqC
	 m9YgG31jwT4MBqaxZoBM6seQMMHWR236PM/rHbyz8R3BDO7nKediqpFlJ2BJH/4M2t
	 AzYN5ZLOnGNYcyFFnfOOKroAHnspB9gmLU3/Op5NCJ9Z1hd4Z1q8ldCmsA6F0fl+Zm
	 2TuhXQ1T5kVT5y3xXFTE1skK/c/beFypQjmfNPX0eXJKqTOP0//9mTx5hZ+Ler4pxN
	 3BHds+4jjjrob0FIDCu9VWw0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C725A40E00DC;
	Tue,  7 Jul 2026 18:35:20 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:35:17 -0700
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <20260707183517.GCak1G5TKyF1ggs8WW@fat_crate.local>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
 <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
 <ak0sGAX_NWMyeofC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak0sGAX_NWMyeofC@gmail.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 09:53:34AM -0700, Breno Leitao wrote:
> The current vmcoreinfo implementation defaults to enabled, so I wanted =
to
> preserve that behavior to avoid silently removing symbols that existing
> tools may depend on. Would you prefer a different default?

You do know Linus' stance on enabling things by default which are not
ubiquitous, right?

Logging hw errors in vmcore is really necessary to be enabled everywhere?

> I agree the sysfs exposure duplicates existing infrastructure, points
> taken. However, tracking fatal hardware errors provides value at crash
> analysis time=E2=80=94it lets us quickly determine whether a fatal hard=
ware
> error occurred during the kernel's lifetime, which is useful for
> root-cause attribution.

Yes, that's why you put it in vmcore. You can't read sysfs if you encount=
er
a fatal hw error.

> For this, would you like to keep it in vmcore info (as of today), or
> move to RAS subsystem?

You mean, would I like to pay attention to more patches than now?

Not really - I can barely manage as it is.

:-)

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
