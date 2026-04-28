Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BA37AA86;
	Tue, 28 Apr 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414364; cv=none; b=qa7aZTekMOgcDJrQXV+eTWK01qO8X92neFY2AAwV9thxxG0Q46BrDEDd5mzKZAYWuWA/cjs9db5acVK93PBD/G+84Td43UlOMAPXn9Vnmx/ph/RYA4xaWF6MtUn8BGr8qOzW1BW/3LldyrNoexu1aL9crF9+h7UQKa7rvp2NPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414364; c=relaxed/simple;
	bh=CAvegt6Dc5+x0/H24NVIcdd99sIGb6Ak9wGep1sQfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VQ40kyzuqiprF4Ko4Crm5tDXYgn9jOAP9vJvxrK9TInMcI45RD3skujqK3unWAd3BRXWPpERkLw5gTTdLlBXgZJxOMy8ld/vj0IHESPwboixyflpVdENieiNddqRFtSGjbuQDrTUFbLLOWv+fBxlrduLcqYDajSaOLkocHqfxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSqZSmgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSqZSmgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDD3C2BCAF;
	Tue, 28 Apr 2026 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777414364;
	bh=CAvegt6Dc5+x0/H24NVIcdd99sIGb6Ak9wGep1sQfbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rSqZSmgdN6DB9TvbncHtHtDVILqsFashoQVxCjcEvmEDsgE7mXlClNSbk+KrEyvlw
	 6I0APiFy6zactxPAEIsQWnrMGS4j9TsIpkyaI+kUIRER8QRRtRp8Qy5hxuxFhDvf9t
	 RJBeLZrUG6uraa6KVWqYwgnw5UNBCU12avocNdZM2FdkfkiAVSVqwOLy45Wq46g65P
	 NJCQGORis2kTu+yMMaXLiSOWDG8Yh7B08akIuKYs+GrA8uCoZQmmWKHYlo+rIUOyjb
	 O699TMrsN+H11lBggxxHu7SbGH8zikpGNVWHhLTd9pJ+ZEV79duOqDkwBzqcEjQg1d
	 VZygvUMVL4BUg==
Date: Tue, 28 Apr 2026 17:12:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improvements to PCI hibernate path
Message-ID: <20260428221243.GA259307@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2c9c0e-96e8-4416-97b2-08f98c2b2d6b@kernel.org>

On Tue, Apr 28, 2026 at 05:02:16PM -0500, Mario Limonciello wrote:
> On 4/28/26 16:51, Bjorn Helgaas wrote:
> > On Mon, Apr 27, 2026 at 03:50:18PM -0500, Mario Limonciello (AMD) wrote:
> > > A few cycles ago I sent out a kernel series for using the S4 paths when
> > > the system goes to S5.  Some parts of it got merged, and Rafael suggested
> > > to split the other parts into smaller pieces across multiple kernel cycles
> > > to make bisecting easier.
> > 
> > Thanks for posting this again.  Sashiko had a few questions:
> > https://sashiko.dev/#/patchset/20260427205024.254677-1-superm1%40kernel.org
> > 
> > I didn't look at them in detail, although I did think the ACPI r6.5
> > sec 16.1.5 reference was a little bit obscure.  The diagram in sec
> > 16.1 certainly implies that wakeups only occur in S1-S4 and not in S5.
> > 
> > Sec 16.1.5 does mention "Remote Start", which is completely undefined
> > by the spec but searching does find sec 7.4.2.6, which clearly says
> > the system requires a complete boot when awakened.  Possibly a little
> > misleading to refer to Remote Start as "awakening" when it's
> > apparently not a "wakeup".
> > 
> > That section also says "OSPM does not disable wake events
> > before setting the SLP_EN bit when entering the S5 system state."
> 
> Yeah; especially the comments on patch #2 I'm not in agreement with it.
> 
> How exactly do you want to handle the rest of the Sashiko comments?  I
> suppose one option is to copy and paste them all to refute the ones I agree
> or disagree with.
> 
> But I was thinking let you and Lukas provide comments and then I'll rev for
> your comments (if necessary) and then ones that I agree with Sashiko, ignore
> the rest.

It's a fair question.  From my perspective I don't think it scales
very well for me to go through all the Sashiko comments and figure out
whether they make sense.

The trivial kernel-doc comment is definitely legit.  The others would
take me significant legwork to evaluate.
