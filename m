Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2041B37D;
	Thu, 30 Jul 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413749; cv=none; b=i33oaCqKpM8zJ41shiOyuw8JEMgW/+bhMTiUCnk+oV8bYWDDS7/6XYI+MvIgq814CDR7ZGfIPTDzZoLe4Ykwb36c3hZCu5wsqopfWVB74i9fN5lm/Xz2oCRbVRn2UC56PApDDyzgA5n+5TrRdthGLo6LYrzUtkSmGA49mfVGnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413749; c=relaxed/simple;
	bh=A1OWHWU61q05/vi176+9L8M4+KYSxhI0VDRomo7vEPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRLayXlnlgbjC2fLTDudJiKphhsjFPCYeRiXPxUGAnTjfP9joh42EvMZCpdFW61DsvxhDKu4U8rlq4Bf2IDLy91uu4P1wWR758zqSkc7oD2aSkASQyi1mwgyrcvi4RcgpenBo3oWkK1Nwt5RKFwgW2/JbRvWd7UgFxgoMc39zpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcvKZNFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcvKZNFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A31F00A3D;
	Thu, 30 Jul 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413743;
	bh=YqI4zq1WdzjRj+56ApGPqtzfKRfDbKKRgCOSYCgUmCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bcvKZNFUj6Eaw6gblXFHhMCRymnrYJPJ/uzRpVoPrYCjRRB1xQBkQBm9Ab0EihbL3
	 +ho1XlLzEgxPHa+gMCOIqMvdHY8/b6AFnT/Ir1QPlBL8kxPV/GPLa8atUajPXP6RWp
	 0/bB4JKEhTH5GaAqb6F80PyR7EgnKhb4hCvBnoyCXuxonsOFr79tsuREOE9+/igPpT
	 itbGXEticJFQmLsCM+orI3zCIeqbqUK4guR3j0cvX0BDDirljX+t2oLbDtOmKtHvwW
	 2Bh5hc5urawjB/Ik0IcmYKU9Jnq9l5Kyo16WtZuFEOzKtIKj2o7qHomrr5tjvERvJ9
	 0EaVg/PGiHCGA==
Date: Thu, 30 Jul 2026 14:15:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Add WARN_ON() to detect broken
 EPC drivers
Message-ID: <amtAbPGO5nYA1_VE@ryzen>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <20260729203850.689781F000E9@smtp.kernel.org>
 <ams9Q-34x6pjbARk@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ams9Q-34x6pjbARk@ryzen>

On Thu, Jul 30, 2026 at 02:02:11PM +0200, Niklas Cassel wrote:
> On Wed, Jul 29, 2026 at 08:38:49PM +0000, sashiko-bot@kernel.org wrote:
> > - [Medium] Direct, lockless read of the internal `done` field in `struct completion` causes a data race, violates API encapsulation, and relies on a flawed TOCTOU heuristic.
> 
> Will user proper API in V2.

Seems like the proper API is to use completion_done().

But we cannot use this API, as it tries to take the
completion spin lock... so it does not work.

Will just drop this patch for now.


Kind regards,
Niklas
