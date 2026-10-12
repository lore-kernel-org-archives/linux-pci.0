Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548D476047;
	Mon, 12 Oct 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829698; cv=none; b=qK2u2Zya/VAmcMyvt7K33tQcfj9AzdIprtLpMpXnjEBQGN8z5PC3zUh8q8HqCkZErRXURMok8v5ozHHmBzfz9kAPADnCk+a44NK5+OfeZ7x7pSE4HbVYe0APrcRigtCDEfZLsTItJ8RAASDpb9KJoac9fhGslMR3imgoEbt7xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829698; c=relaxed/simple;
	bh=b8bqy7mozkpJrAu2ge7BSnSr75z7m11PVzPs0L4ifoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzxDsaXwBg+cN5Mab/vkuqnVr2Qu5QLIASyZ2pNi9uO2dqHNtdQPioJmZ+2S4E+12LWt7+d8mvzFBWa14fcBhOomZGo875jqLbXBMBTNG+w6ZMtZ2ROhxlzstjeXodaBiA5glIwfyFvpFGHlm1UDYB6mdLB0LMhs4ojwDXgfRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aozXG1sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aozXG1sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BE41F0089B;
	Mon, 12 Oct 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829697;
	bh=JSAT1k/Bn2Js9xrY4E8TzEbyuQGCRvd1NkusHBlEb/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aozXG1szXyxXE+TU3A1PWZy8ti1W2ffvcOggPDIJer+E3heEbpyLU027lH7spDvhT
	 Zqciqr2sxrR2UBoDfrrqh0uRrrptE5SqW66VASxZqYcGXzdICCfaZafv8JfCifsIIL
	 giEg6g/MUArmuFMMWnYv7ct2mdZE0GZqxLwKalehYiS2X8+sJWP9705mkuNDxGxuXC
	 GyTFvkoL931CghbFm7pFccbWoDGQFcX+pcKaXXBM3cN/sxsMTxTzQwV5/ed4WlS0J4
	 zoSsaH/BCTKeF/lZu1knxXS854q6zkWfFjQh3MMXrGjDVKdV+uRXNsgVgyvwoNZ3vR
	 luRtv2dnPCunQ==
Date: Mon, 12 Oct 2026 20:28:11 +0200
From: Thorsten Blum <blum@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <as0mu05UzFWBBRJ7@kernel.org>
References: <20260916100206.92853-2-blum@kernel.org>
 <asDr0tWYBNC296EQ@kernel.org>
 <f9b1c1b6-03d9-44fb-bdc4-78342b05f2af@intel.com>
 <asLw3ZfDy-rDxwtv@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asLw3ZfDy-rDxwtv@kernel.org>

On Mon, Oct 05, 2026 at 02:35:47AM +0200, Thorsten Blum wrote:
> On Sat, Oct 03, 2026 at 04:55:54AM -0700, Dave Hansen wrote:
> > On 10/3/26 04:49, Thorsten Blum wrote:
> > > Gentle ping. Is there anything you'd like to be changed here, or could
> > > someone please pick this up? Thanks.
> > 
> > How has this patch been tested?
> 
> I tested it on an iMac13,1, and dmesg confirms the quirk is loaded, but
> only when this patch is applied:
> 
> [    0.023863] Resetting Apple AirPort card (left enabled by EFI)
> 
> lspci also confirms the hole at 00:1c.1.

Hi Dave,

Is there anything else I can do to help get this queued?

Thanks,
Thorsten
