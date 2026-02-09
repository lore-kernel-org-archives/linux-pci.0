Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF2374174;
	Mon,  9 Feb 2026 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654854; cv=none; b=KCSV2YFPxKQvWPQcbYMxd2hIxthdHxQ0jq8c/9z/f+RxBwwiQwR3WbaHuJ4TQLV/JatUUoNwIf9k4ECtJU9h/Wxo18ZTJUVS+5yuGu5ic1AlV/TPfvZUROl6PHGC77SOJN/ObtAblO8dAFSrs4tsRKoS2XyGUlj77Pd+Evy5RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654854; c=relaxed/simple;
	bh=hXItPnSI4S1Mss6k7FHxY9pDox6GjX4eWt9ADUIr01M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MS2FKejuQ83tRqo+MYW47gVE+GRJZCJInz0iMfR5CVDKKfGt9TranagWN6oJOSsiEzjptque8o7MSPxSfh5QW6nf4UsOAqn0fbyQ5Co4ioGV0O8ROny+JXYkTRcigG2TmSKtVmwPiS8DQ0baa4QqHYRU8vIPrLfLOc5w0ihVWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYkl+bkL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYkl+bkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437E5C116C6;
	Mon,  9 Feb 2026 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770654854;
	bh=hXItPnSI4S1Mss6k7FHxY9pDox6GjX4eWt9ADUIr01M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QYkl+bkL0n+mf1o+jrVIsKb9QtYltoddflERBitBiCIIT3pb+uMRu82DCRp70F6+k
	 gN2P2ZKXTSkSFOE+BZQJp8AEOfext3x+tt6tU22llyKrOa7lRpAaT54xvgyUOlPTlO
	 CyhJ9G3ypaIxAAZg8BjhvBxAa7jR/rZArLOZBcLJklB8DC1tAPqNYBZZMT9dQowhwI
	 ukc+/W6wbdUL1pMjfyFc1v4y8Ja+wagOhupUUGiXM6eWIgDlrzUqur44qWcnjMQeoQ
	 NahwCBVv9tFumFuYeNjtaajoVuZKn9S8EHPDqsUO58OhyccKlmp1z7mVCUgPVMeylz
	 Xd8FOlqgjVKUw==
Date: Mon, 9 Feb 2026 10:34:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linux-Fan <info@masysma.net>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Hui Wang <hui.wang@canonical.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20260209163413.GA192568@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cone.1770586239.550948.1302334.1000@masysma-18>

On Sun, Feb 08, 2026 at 10:30:39PM +0100, Linux-Fan wrote:
> Linux regression tracking (Thorsten Leemhuis) writes:
> > The issue discussed in this thread is still on my list of tracked
> > regression, which got me wondering what's the status here. Did it
> > fall through the cracks? Or was the regression maybe fixed already
> > and I just missed it?

> I am one of the users affected by this issue and are currently
> running an old Linux version (Linux 6.1 from Debian oldstable) to
> work around it. As a user I would very much appreciate an upstream
> fix.
> 
> The Debian bug is still open
> <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1112238> whereas
> I think Ubuntu got a patch working around the issue for their users:
> <https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521>
> 
> Is there a chance to possibly include the workaround in the
> upstream?
> 
> As the issue is reproducible on my system, I should be able to test
> some patches if necessary. Tests are not easy to perform because it
> degrades the RAID system and I would like to avoid damaging my
> “production” data hence limit the tests to the required minimum.
> 
> But if there is some real doubt that the issue is still present,
> tell me and I check it again with a more recent kernel version?

As far as I know this issue still exists, and it has unfortunately
fallen through the cracks, mostly because I don't have a good idea how
to debug it.

Thanks for keeping it alive.  I'll try to come up with some ideas.

> > On 10/8/25 18:53, Bjorn Helgaas wrote:
> > > Nirmal, Jonathan, can you confirm that when RRS SV is enabled for VMD
> > > Root Ports, we should actually see the 0x0001 value when a device
> > > downstream of VMD responds with RRS?  From the log below, it appears
> > > that we actually get 0xffffffff when reading Device ID after a reset.
> > >
> > > On Thu, Aug 21, 2025 at 11:39:36AM -0500, Bjorn Helgaas wrote:
> > >> On Thu, Jul 03, 2025 at 08:05:05AM +0800, Hui Wang wrote:
> > >>> On 7/2/25 17:43, Hui Wang wrote:
> 
> [...]
> 
> > > The patch is here:
> > > https://lore.kernel.org/r/20250701232341.GA1859056@bhelgaas
> > > and the log with that patch is here:
> 
> [...]
