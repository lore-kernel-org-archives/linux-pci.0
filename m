Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785C3E8C5A
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196132; cv=none; b=aFX3rF3TaM7FJXQ6bIUww/UnmRNis6E4P5i3CHdeFfWDv2GaFYACPtP+eW5jEdeiGQcmnA+2/Nk5tKjcEePQaBQcZkGX7PvTGk5JZg9q2SGa67b2jsU7ilmCGyjW0a8UFNdw61eXnnWAe4/qAFAo7oKTn1aD2eJTH8cLGjQbNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196132; c=relaxed/simple;
	bh=mLKe0cjPqXj1HhxCkjlTv9vToMPU9R3USFRoF7/hWYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cGLi3EirCV59gGCNsoBv+QnOMpvgeWhzuQ6b90ysYeet7iinIPs+8L2Z88l3F/CKB8XjUf7kETh/3AjtsOMzIbpdS/jDluLuG+sHYeGVpO054HV+48ADGj11pOQMdwEnOHx8dp+f8MVa5P7639azTPrLPjUNvOt2hjpHUS7Eaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQmBgmmq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQmBgmmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B4EC116C6;
	Fri, 27 Feb 2026 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772196132;
	bh=mLKe0cjPqXj1HhxCkjlTv9vToMPU9R3USFRoF7/hWYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DQmBgmmqs16dAC+5TRWQyJygLAppKzb+/8JTZKGMLYM/d5qMD5JwCh8I9DYd8RLcm
	 +lk4cMl67bilxJyJ0toO2DplLUq4O1AFXEGN6AQ3lovpfl24gaGTs1osl3gJvWsxEX
	 zvIPqrYt0xrrWGWc2yLJeF6QBib2p3IsgA82+Ai+e36p+DmSPAZB3tC636Ol5MWsVe
	 QeNHjJFixEDX5/UXngAKoZns6mR4CSqtY2/3D7Lr+9AMBrs7digTarlnQzmybGxL46
	 gdmZq3lsujE29ukhgFO7N24+/x3EIBFgQyU1RCOsFbfDDMZf+HBSHll7WFUjPhFb4j
	 p0zyJebdvrUkg==
Date: Fri, 27 Feb 2026 06:42:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: baruch@tkos.co.il, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Change PCIe capability registers offset to hex
Message-ID: <20260227124210.GA3891195@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae392a0158e9d9ab09a1d42150429dd8ca42791.camel@infradead.org>

On Fri, Feb 27, 2026 at 09:12:39AM +0000, David Woodhouse wrote:
> > On Thu, Nov 18, 2021 at 04:13:00PM +0200, Baruch Siach wrote:
> > > Hex notation matches the spec documents, and is less error prone.
> > > 
> > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Link: https://lore.kernel.org/r/20210825160516.GA3576414@bjorn-Precision-5520/
> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > 
> > Applied to pci/misc for v5.17, thanks!
> > 
> > I also converted some other capabilities that had offsets > 8.
> ...

> What you committed in fb82437fdd8cd also changes
> PCI_CAP_EXP_ENDPOINT_SIZEOF_V2:
> 
> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
> +#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
> 
> That's not actually the same number. Was that intentional? If so it
> should have been done in a separate commit...

Ouch.  Unintentional and completely my mistake.  Did you trip over
something, or find it by inspection?  If there's any kind of defect
signature, I'd like to include it in the commit log.

I posted a fix:
https://lore.kernel.org/linux-pci/20260227123653.3891008-1-bhelgaas@google.com/T/#u

and put it on pci/for-linus.  I intend to ask Linus to pull it later
today.

Thank you very much for finding this.

Bjorn
