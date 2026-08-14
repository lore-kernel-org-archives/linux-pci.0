Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCF36920F;
	Fri, 14 Aug 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700166; cv=none; b=ddQWdDkhQyBPQkx6T5l1sJXtS+R8AYBggpVKYYp+qYi6NcQF5WewLi2uToEc35akkso4lQ+mzRYIl4DnhdsxjrYMFr139Of9LIyfBHsqnAiKu5uYI+bLqo7wr9J55fH87IWd+Wq6uV5Gmr/5OQZb05oCclRRgOivqRyKlEMTCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700166; c=relaxed/simple;
	bh=TKTn0qtOC1fyI5Mpr75ZQC6EJkhsMr/3n0lgQds3KgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9ReLglphcagK4Vev/lkEVrAZiBD2/uN6ecS3Nrh6TU2X3GX6BFfbwAQdLCpY59nc3NPtIfra34QTIXQ09U9IgsRkfVh9xXVhsJ7mc5EYtT2YArZ22PNbq7tqG7lvorEnYA1UzY2KagU7OxrmbPgAmNhM//sqwS0bbuvbvGQmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYuau5GF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYuau5GF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2F81F000E9;
	Fri, 14 Aug 2026 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786700164;
	bh=1PssRw9lVKNSmLGwhISTOVhoXzFCeGJUeto8VC36qiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bYuau5GFTHFcYmm3UNj9IhKSTXoUbv4zVr0KjQ+JDm9pa7NbbAGR7YptTPNJzwoeZ
	 3lJVpIE5UjalEjbXXsG0enoWhwLgQU/BvrFXtVUlA8cXikbJ4Zfg1OPFGiqtNwqTl1
	 pF68GVxNayYmr6/XANn5EWvyn91YuBFtvoY1/3xpsWNZ80OJWKtpyGu6H5N+ldfKsQ
	 1P+5QZ6CHVpVsZ/lCO7XKhuWM1e/OVVx9yaSDDABZ3YqKPbd9Gx2vAuFs/ktZS0th4
	 wShaV1mVzflD+ngQQdjZFX9XJpTju+u6Ut9e2hy/FBHySkjLeyIah1f819UzA4mm1U
	 HMw1Xs04FdnGA==
Date: Fri, 14 Aug 2026 18:36:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/sysfs: Stop reporting _DSM failures as -EPERM
Message-ID: <20260814093533.GB3463973@rocinante>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-2-kwilczynski@kernel.org>
 <20260814071901.78AA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814071901.78AA11F000E9@smtp.kernel.org>

Hello,

> [Severity: High]
> This isn't a bug introduced by this patch, but does this code cause a buffer
> over-read?
> 
> It appears utf16s_to_utf8s() expects the maximum number of 16-bit characters
> as its second argument, but it is being passed obj->buffer.length in bytes.
> 
> If a PCI device with a firmware-provided ACPI _DSM returns a
> non-NUL-terminated buffer of UTF-16 characters, could this read past the end
> of the allocation when a user reads the world-readable sysfs label attribute?
> 
> Should the length be divided by sizeof(wchar_t) to prevent reading out of
> bounds?

The last patch of this series aims to address this issue.

Thank you!

	Krzysztof
