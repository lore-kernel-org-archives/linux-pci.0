Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539B3E5598;
	Wed,  5 Aug 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920567; cv=none; b=jalSjq4hsBvxmpP5XJ6ThV4ku01+WWcVZdDYNG8/GRm/evOdBeKEhRnDPJHkvs7BPXHSsesWhtr2aLaJ3P+343CFElZWmwGhqXEFH69T/QEbikpqI99qpMjgXIebWuo3gdNhE3US/q1MIzKVymPummnW1cfFDoAsGXgYtU8wqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920567; c=relaxed/simple;
	bh=1KA8gPHKvZBs5uurLr0X4MWhBp7w/ZavaYHgWW2p3bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKczMsUdT9L8aoSSy4rYuEtlfgIN0aUK1ldXYiBWgUsskUI5ynU0GmaK+aTBkk89n1YwRrTpA9/h8q6gP6C2rpmshHec+7U5Ip+aCTYT/bFgBsBE95sjDpvYPz3eh2xBQdArydVEcOBd6ipHhc6iUhScyHzTo/LtQlKxwaX74Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKD37hlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKD37hlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76491F00A3A;
	Wed,  5 Aug 2026 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920564;
	bh=ToyNKMsiXdhJOroO6GPBchoHVXWBFgFS6VzMfpL4Mq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lKD37hlvBRSXPHrsNiklYY0huMziFqO/He9M0ZxXUzeMrW+o84iNjvf42MsjWODGs
	 ls2K5UuVrzdasIljwY2FPBJCz+sZ5BaX7NQLEuE/+phZBFL0REGdUFNIlPTznDzyDV
	 Ub0PDsticzVcJvsCA6+vrcZqKZn/QAAuAeVvmidvuS+1wX4tZY8F8gSfJBPlLA/s4V
	 6poEOdtQQ6aEQ1afvfRuxwVymQuwu5BpXtM9Gwggero7FLHBOyhJDFjCgGsTu8wV8d
	 Kt4uBx+60CI9MS9WjYJdtJriiJiQKDwn2a3W5FyBUMTcPCk95Lfa4aZg8VVLKF5vxK
	 wAQJX7nsc4Rhg==
Date: Wed, 5 Aug 2026 12:02:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 09/13] PCI/P2PDMA: Document ACS egress control handling
Message-ID: <20260805090239.GB23431@unreal>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
 <748b76b4-0a07-4145-87e2-9991412f0401@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748b76b4-0a07-4145-87e2-9991412f0401@deltatee.com>

On Tue, Aug 04, 2026 at 04:01:41PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-02 09:09, Leon Romanovsky wrote:
> > +ACS P2P Egress Control does not by itself force a transaction upstream. A
> > +clear Egress Control Vector bit for the peer port permits direct routing; a
> > +set bit redirects the request upstream when P2P Request Redirect is enabled.
> > +When Request Redirect is disabled, a set vector bit causes an ACS Violation
> > +instead. The kernel evaluates these controls together and routes P2P DMA
> > +through the host bridge when the direct path is blocked or cannot be
> > +determined.
> 
> One small nit here: I'd put commas around "by itself" to make it read a
> little easier:
> 
> "ACS P2P Egress Control does not, by itself, force a transaction..."
> 
> Other than that:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks for the review. I understand the effort involved and truly
appreciate it.
