Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452635957
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557399; cv=none; b=ZgP+0jaSZK/v0/k0obCCdgl/ENS2RhZtkW12wUwFuz2nMrSDTW8Nf88eQK3hbQ+1Q+7ATz71V0PR9nBBY57Q2O7MDQ9HF3QYbJjq+WCdBQabJNVyIesIntPoriTESVsIxLumspx37rC3Rr02i4Dp9hbNiR978VC18wimX9u5YGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557399; c=relaxed/simple;
	bh=Ub43lKOjaaBfmepJKncZn7ENlEmBWirYBP1yRbQScII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBO0WkIeJOA5rVUdJ060XcGgpyEw6Fvszz1e9L+uMu4kTpS/Ke3LSHCPz9dBbvIvIE4s6lTiAL+7gtPdgPaaBF+B/UZpBb5NEckFE6PqAFZzq13UsWpYeRWT7NJAl0039Ty3JCeX+KL4ikuSAxCPMyU6kaJvJKjHXGdQRKW1ewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3NuRIa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3NuRIa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0A1F00AC4;
	Sat,  1 Aug 2026 04:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557397;
	bh=M+/RGxgz9aoLWS4CrYEo7sJq2G8C+N3cMhEp13KUqzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3NuRIa2qKkJTzD8J9rU+BnAFtce/CeVOwrEjp1ljq5ppFKYwFA9nFwhEcGuTeFFb
	 Vp6X0BUh00WW+4HTd22DfgQPuCeVaylqn+pTT7evY15yQRUU6OiROoJlp7PG+IP68k
	 9cHBVRITWoS6DaOongN9IkMrg//6QQ8Qvo/0x910szHkXfQ98BAuNxiNXSHyVpRtyA
	 ANjVTJYvGlHrrnABrsvIT3QZMPW2jN7/uFStlrv+07uT6mhqH5lIdU1DuVrN6MhH02
	 iI8HWlkDOVPDUOHFXBjlIoX8x1MWBB97UZuX6subyz5C2Dbg5jo01hyB4mRNtAFhQo
	 DB9lXcJgPdcnQ==
Date: Sat, 1 Aug 2026 13:09:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/sysfs: Follow-up to the static attribute
 conversion
Message-ID: <20260801040935.GH3183355@rocinante>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721020427.1541197-1-kwilczynski@kernel.org>

Hello,

> This series is a follow-up to the PCI sysfs static attribute
> conversion [1], carrying the clean-up changes from its v8 revision.
> 
> The v7 revision of the series was applied and went out with the PCI
> pull request for 7.2 [2], so the changes from v8 did not land in time
> to make the 7.2 release.
> 
> The series consists of three clean-ups:
> 
>   - Add the pci_ prefix to the generated PCI resource attribute names
>     dev_resourceN_{io,uc,wc}_attr, for consistency with the macros
>     that generate them and the arrays that collect them.
> 
>   - Make the attribute name suffix the first parameter of Alpha's
>     __pci_dev_resource_attr() macro, resolving a checkpatch.pl
>     complaint about two consecutive commas.
> 
>   - Add the pci_legacy_resource_{io,mem}_attr() macros, and use them
>     for the legacy I/O and memory attribute definitions instead of
>     open-coding each struct bin_attribute.
> 
> These correspond to the items listed under "Changes in v8" in the v8
> cover letter [1].
> 
> No functional changes intended.
> 
> 1. https://lore.kernel.org/linux-pci/20260619085200.3729431-1-kwilczynski@kernel.org/
> 2. https://lore.kernel.org/linux-pci/20260624110021.GA996382@bhelgaas/

Applied to the sysfs branch.

Thank you!

	Krzysztof
