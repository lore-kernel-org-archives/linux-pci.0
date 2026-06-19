Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FA336897;
	Fri, 19 Jun 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893868; cv=none; b=cl+n08Gg5+nD6BrBCtyxn+WLPKvEdMA8iFCM/TkXMUjf9r9PUEPlUK4se2jvivxjbj3AbaZZ1xZzQB6ZniTpwbo6PtwdXxEZxbuRhbkjiNQYyK208SOKEeCkRe4MwsY2BtZC215Mpcf0bq9tHpLBioUz3luslp5QXr85/laGzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893868; c=relaxed/simple;
	bh=ODpmQCFCK0JHSnHrF0w93bn+zbTNp3AX2VjeRTG2tOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHtPR0VoRyiUePnbhb5SOt5YZAKuMVQ1VHCUH/eRShQvIDMDlFHJkGHSlg5/KRBzwt638sCb0sJmsawqXtaXgfXd0arPaav1YSQD9Mx0pPw1u1czFfPSaMWNYhu/6snjGZhQcc9YoIeeHrPr9qUsyEiPOm3E5l86uO6BO3ahbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyAokcZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyAokcZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA221F000E9;
	Fri, 19 Jun 2026 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893866;
	bh=idgwsKr1BVBWS+hvFWYbNhlxL05HBlSgC6jlCV2Xn/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kyAokcZvf3iLQroiUGG1Zei2KN4pU+toV3YadAJS83pLZyAB/7s8SLSWWWwq91LZ4
	 X15l62UHsgglSO8VBHbHAMbrylT9LvydMJCFAr0bQRPP0I6Hd0V7Axf8DqKkGaFO67
	 53YmxBSRfU1v7APdhPFDFMIyPvZ/dNjnHKFYqGu35j8i0uWnxHNPvwO4MDIf+5QxsI
	 y/hSodrDdp0vxXtx5DP/YdR+cTaFwrGr+zPvF1yAYbmMRjsD4zhqh7koqTLrcUpL/+
	 2ghSS6hnK7c1sKr9id2CkovHIbPgxCxHN8cE8odPTovsVEhaE9Y1Q+T/mOrrLfx0Xa
	 kJ5QigPLccisQ==
Date: Sat, 20 Jun 2026 03:31:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 23/25] PCI/sysfs: Convert legacy I/O and memory
 attributes to static definitions
Message-ID: <20260619182700.GB2528910@rocinante>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-24-kwilczynski@kernel.org>
 <20260619091646.819C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619091646.819C41F000E9@smtp.kernel.org>

Hello,

> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 7f1d8e07924f5..dfb4e06677fce 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> [ ... ]
> > -void pci_create_legacy_files(struct pci_bus *b)
> > -{
> > -	int error;
> > -
> > -	if (!sysfs_initialized)
> > -		return;
> > -
> > -	b->legacy_io = kzalloc_objs(struct bin_attribute, 2, GFP_ATOMIC);
> 
> [Severity: Low]
> Since this patch removes the dynamic allocation and assignments to
> b->legacy_io and b->legacy_mem, are these fields in struct pci_bus
> (defined in include/linux/pci.h) now completely unused?
> 
> If they are dead code, should they also be removed from struct pci_bus
> to reduce the size of the structure?

Both of these struct pci_bus members are removed. The next patch does
exactly that.

Thank you,

	Krzysztof
