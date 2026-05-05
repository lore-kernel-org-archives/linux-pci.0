Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED652C21EE
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025197; cv=none; b=W64Q9/YWQtYimfem+wl5CKPyBfHVVbB039DT4EMZPO5A3eaVgpk43Wm9NgOwUDgaaj9eRgHjuKSKsgjVYcPqh0umTpDLgqHph5bh3AjES/BH99BuXVpq/05t7YhEjReFiurKYBEK0cBdBxx7QRT77fAMbcvBPAKxVgNILYZI9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025197; c=relaxed/simple;
	bh=M/Y9g/XLxMmWmVs1W3+8998tRt5JGDJl3BHMFlKu+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au4LyXHqk6E5mrJg+7GbqDCQ3rk6o5sZOJLq7UIzfNM4qaysEO25d4TLrfG8mhyy24gdP62d462PPVdap/vsoQ1HXGj6l99fK/KGtUmC6Q8zzRhAYw7JOQ9kQJHFkhvsqEsvdVH4zN1XAKtTOYwFXNLyM0hy7I8Rk+Q6052J+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag9pMgnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag9pMgnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFB5C2BCB9;
	Tue,  5 May 2026 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025196;
	bh=M/Y9g/XLxMmWmVs1W3+8998tRt5JGDJl3BHMFlKu+30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ag9pMgnzlH89nRKDW3rL5+7afdITgagfDvpsi9NSmfi0k99p+1cX5OBXdLIe8S+kj
	 UaDM9/j6kNM/P7T1sBJo7zKBcBUfVLucoOJnPKxrpn3JW4Y7KQVARDcR67WKHrkBh4
	 oom74WuErIIyjG782Bhdl4ULlwrfRKTUM1uN/fOemWwnvGmNfkM8MqiFa5XZWytPIm
	 BA8hxgAMknLVtQqmuqYrjpBmUu1En3ACFPMft//Eu0bG/DCeLZMAOlPP+tUKRjhUZ3
	 hg6LYxcee8az+IgXncpD/PxNDRstaD8IiIuRpbi9gtcxQwMgAXM5qqiF/gjd8q1U4F
	 +s0+6O1QmpAWQ==
Date: Wed, 6 May 2026 08:53:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260505234738.GC1410272@rocinante>
References: <20260501010127.GA990551@rocinante>
 <20260501193721.GA511830@bhelgaas>
 <afm8y+KHlgtSWBqH@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afm8y+KHlgtSWBqH@lpieralisi>

Hello,

> > > Lorenzo Pieralisi did some testing reported outside the mailing list (we
> > > talked on IRC) on the platform he had some boot issues.  With this patch
> > > applied, the problems seen before were resolved.
> > 
> > Thanks!  Can we include a link to the problem report and maybe a
> > couple lines of the symptoms?
> 
> You can add a Link tag:
> 
> https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/
> 
> FWIW I tested it on top of:
> 
> https://lore.kernel.org/lkml/20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org/
> 
> so:
> 
> Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> > Also the analysis of Sashiko feedback?
> 
> I have not looked into this yet though I/We should.
> 
> Thanks for the fix !

Thank you for taking the time to test it!  Much appreciated.

	Krzysztof
