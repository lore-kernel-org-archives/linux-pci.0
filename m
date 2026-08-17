Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70159282F30;
	Mon, 17 Aug 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991285; cv=none; b=t9qD4OTszOtNBgivE/VKiU02RVxpmn01AcbQ+y3yWWLQ0H1QzFPGWvj9bU8TVFLhzydX8O6PoCJG+BByo1HfZ55rCu72XXhSKcKtRO8Ew4+ORG/a5KPK8M+kMBLd8+N65whrKFglMi5uRSvzqFuf+b625EDDhOUNPhH4ybJ1oXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991285; c=relaxed/simple;
	bh=AoVTIzk3jGmCg58mMb/LowghHt/XyzU6NK34w8QPPHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhCf/BYlTItyWvOAPAgr1m5ihKxS7DCZceaQbfjRTQvnmGhym/oWFJGjeLcb87nnFqiT5XTcMkSurvfWXpyQYEIHwbu8nBqVavqVcAGt58kzcXSz9F3LPdWIke5/ENScWEbqlvxyKJUfXMkDabqdp1swOpjeGRHcRDVmA+0RU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4DvbLHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4DvbLHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEB91F000E9;
	Mon, 17 Aug 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786991284;
	bh=PVtjT/hfRhRlJODdlOASejcjGNfWFR2Xaqt/rj6G1LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P4DvbLHY8OF5GWUfPuY+r7quycQRLI28NnoRoEiXSxVOKqBdyFCN3nVbG+QMsUD8a
	 yCqn/o0NNHQfu+hp/pm7zc3G4+A7XgxjCxOzXv9/dCovROu8lqGG3LijmlnrJhyctJ
	 f4g3msBNzHdQWeIq07eoKGE9kFhLsiwJLrX68ODzelP/k58C2JnrJ6SjK7GpDGeIKh
	 SpcAGU14WzpahfyuzT9PtPM+o9ZAiZLphkidUxBLxOES4wOHthve1Kd38NW0n0J+13
	 UiE9DJgi5J37vdgCWXRkVvDq0rp1KiGyYDcXHwBxojGQ4LYkkqzm+xIHXFxTsBe3WE
	 QuSD5ZrDVoXHw==
Date: Mon, 17 Aug 2026 21:27:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 4/7] PCI/P2PDMA: Prefer providers with better HMAT
 performance
Message-ID: <20260817182750.GD66924@unreal>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
 <5e7eb09b-a47b-4cb5-8629-0ca5fa39f1f9@deltatee.com>
 <20260816123836.GC66924@unreal>
 <3dc699d8-a5d1-4100-b717-07fd0956e61d@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc699d8-a5d1-4100-b717-07fd0956e61d@deltatee.com>

On Mon, Aug 17, 2026 at 10:09:42AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-16 06:38, Leon Romanovsky wrote:
> >> This feels backwards to me. If ACPI is kind enough to include
> >> information on P2PDMA support then I feel like we should use it
> >> exclusively. Not prioritize the old janky whitelists.
> > 
> > Right now, there is no ACPI support, and I chose to prioritize
> > existing systems that already have some form of support over an ACPI
> > solution that does not yet exist.
> But don't we know whether ACPI is advertising support now? Certainly if
> ACPI indicates support we should use it above all other considerations
> today. Otherwise fall back on the white lists. And that should always
> work. Even on my old hardware because the ACPI on that machine doesn't
> advertise support, so it should fall back on the whitelist. I see no
> need to ever check the whitelist before checking ACPI.

Definitely. This will be addressed in the next version.

Thanks

> 
> Logan
