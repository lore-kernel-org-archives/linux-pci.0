Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C834229A2;
	Thu, 30 Jul 2026 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412935; cv=none; b=cdsh9TOR+oTPnFjZI4kzoxXKvAwLdZ8VD4UlpZynGskZ3R9k+VfNXsU4DCQOk9nR+WClWj3ruz48NNrJ8jCkhpct9ZEL67IUYr+cwKKUmGDWaDc4/bNsOkRBjXJlgLM27IkVV4jgG+3p2jVm98sHzCNFVHZdyBgMLieTxLWdFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412935; c=relaxed/simple;
	bh=yp3mf0eE3p1GAwzMZw0FpHhLA0s0tYlPPlCMPtTt2X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkNKVzBNF1WI2OB94/d+GOUzPO68PVzvMtwnEwJdTVxMYfk8C8vrU6Dr/4lSsnJGyuqIvolqw4JOAosyeWiE/uE0eSK6APr3peF3awwLDwB05P01XE/s+yZ1oxM+whvjyMy9qXD5hHBMXWIbMtFKr4+crzIvDbDxwc6JT3W8Q6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVad8syQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVad8syQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0F21F000E9;
	Thu, 30 Jul 2026 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412934;
	bh=BhlgFGquvMk1fChk332ttk/Tpeu+WIBZHPMOcUEVKv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MVad8syQYFSHFQ135p73ZkH5++OlOfqfmduwOD+Mdcra2uELVIUmRKIVv1R0KCZDy
	 YTcCN+PNT1Xb43bLdcU8ISRc/3dmfUZoHCXrACuWpvwqajfuNx61AshIpPuy1W7Jbk
	 MbC4hNvG3MKRWRN9gjzItACrBUbdBJSP+/debMgyvE3ZCNbVG344bVrWOAWItbj2ff
	 eRimZf/xslqpHJJPBMswAcLO5uSvFRftndkscRnTGtWI5ah/g2l8m/u3Hqe4+rdbA6
	 P66j3wZ0Thon+OCz8weBCOqsP2Zjiok/nJFFoxE5OZfwTaRM2zWbuUr5A1hMo2DSC7
	 ImiTXuwq3t4Ug==
Date: Thu, 30 Jul 2026 14:02:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Add WARN_ON() to detect broken
 EPC drivers
Message-ID: <ams9Q-34x6pjbARk@ryzen>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <20260729203850.689781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729203850.689781F000E9@smtp.kernel.org>

On Wed, Jul 29, 2026 at 08:38:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The newly added `WARN_ON` can be trivially triggered by shared interrupts or untrusted hardware, leading to a Denial of Service (host panic) if `panic_on_warn` is enabled.

Don't think this something we should care about.
This is a test driver, and if someone plugs in a PCIe endpoint on the PCIe bus
that runs the PCIe endpoint framework, and the pci-epf-test driver, they
obviously know what they are doing, and want good/important warnings.

> - [Medium] Direct, lockless read of the internal `done` field in `struct completion` causes a data race, violates API encapsulation, and relies on a flawed TOCTOU heuristic.

Will user proper API in V2.


Kind regards,
Niklas
