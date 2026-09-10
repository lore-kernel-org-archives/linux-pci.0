Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77656373BE6
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028451; cv=none; b=AKR+w4CkIRZQd2GI45L9BGmlKCW7e4JNebRWX50GqDdvySZ/drZy+TmHOlCOmuHAkxs0wZe35g2u7otfpBzwjq9vERaXCW5Y7IBt906S6yrxU4i2BT53cxXV8e0m2/RbGfuGmG5bN6inGBLz/ZtijleDon3HuEE9Aa4oSozDbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028451; c=relaxed/simple;
	bh=9xQIHxFobyQNC1g3HNX609qvMT8N4OmaZQH3SPRqPi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLZeKqFAUyvTytcz7phtKnXwsYQZH31M5wDJCNQ05BQk2LvThwwZTHyWzri9YwVUrphDFN3fpgPWDf++mfBrU0dXq+ri4afUXkGXlofwIqNgilmaDuqYpsTxitnNJahwO7l0ZENCqBpqBwhLG+aJL5t6UU6O1+EaovzL/9O6+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGw4OXPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGw4OXPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6831F000FF;
	Thu, 10 Sep 2026 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789028450;
	bh=Zr3P5tknxV++03bHWaDdtjbfTEqW+kl5ujjcTgo7KtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LGw4OXPzd6pxnC6yaQRycxC7Audj6LwnmqpptTA2oV5LKw6dCYrQrFmRHU7ZJpvQ6
	 x4ZlsArTxJltJwhAZYL1mTeXqOZtFrj7B63NLqdr+PimFiifAUs4/8zEArV75Pr7tR
	 M4G6BtnnMYZN7xo+02dtJlpagj49JIvdFeKDSGKJpv2NnYUb+AGnnyNLx9nZnLsAe9
	 0hIDHHMjUnnJ2N4qgttHfu4Y/oP2YPNIby7mnT6/cTCaddUGIe966LxbYJD3C3XxD+
	 xRxNXAmKd6/pJuptUpl8Do8LqVnvJr7UoMKod5qk7f/Fm3QVbBI++V9Gqzy+/o3PkT
	 /cLYF5gegYQxg==
Date: Thu, 10 Sep 2026 10:20:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Kees Cook <kees@kernel.org>, linux-pci@vger.kernel.org, 
	xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v1 0/2] PCI: Add pci=nobwctrl to disable the PCIe
 bandwidth controller
Message-ID: <jdzx65tvjubsbepxerpcont4ibflzohihlurm4ze2fich4indq@hjbrps626ssx>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
 <ammlZzv7QSxLm9LC@wunner.de>
 <d8280f27-782d-4d82-b38d-7b48af4912d3@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8280f27-782d-4d82-b38d-7b48af4912d3@linux.alibaba.com>

On Wed, Jul 29, 2026 at 04:28:07PM +0800, Guixin Liu wrote:
> 
> 
> 在 2026/7/29 15:01, Lukas Wunner 写道:
> > On Wed, Jul 29, 2026 at 11:45:03AM +0800, Guixin Liu wrote:
> > > Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
> > > Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
> > > (LABIE) bits.  On some (typically old) platforms this has been observed to
> > > cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
> > > on Intel P45 using a quirk") works around one such platform with a
> > > per-device quirk.
> > > 
> > > A per-device quirk only helps once the offending device is identified and
> > > a quirk has shipped, which is awkward for a boot hang since the machine
> > > cannot be booted to report the culprit.  The only existing escape hatch,
> > > pcie_ports=compat, is a blunt instrument that also disables AER, PME,
> > > hotplug and DPC.
> > Ideally we want to identify all devices that have problems if the
> > bandwidth controller is enabled and add quirks for every one of them.
> > 
> > In a sense, a command line option disincentivizes reporting and
> > fixing affected devices because users can just work around the problem.
> > 
> > Additionally, there is a general dislike in the community for
> > adding new command line options.
> > 
> > Are you seeing issues on different devices than the one that's
> > already been quirked?  If so, a patch to add quirks for them
> > would be welcome.
> > 
> > Thanks,
> > 
> > Lukas
> Thanks Lukas, that's fair - I fully agree that per-device quirks are
> the right long-term fix, and I'll gladly send quirks for any device I
> can reproduce this on.
> 
> I'd argue this option isn't really an alternative to quirks, though.
> It's what lets you *get to* a quirk in the first place, and it closes
> a gap that is specific to bwctrl:
> 
> - To write a bwctrl quirk you first have to prove bwctrl is the
>   culprit. pcie_ports=compat can get a hung machine booted, but it
>   tears down *all* port services at once, so it can't tell you whether
>   the offender was bwctrl, AER, PME or hotplug. pci=nobwctrl isolates
>   exactly one variable, which is precisely the information a quirk
>   needs. In that sense it feeds the quirk pipeline rather than
>   discouraging reports.
> 
> - compat is also too blunt as a workaround on modern systems: losing
>   native AER/DPC/hotplug just to silence bwctrl is a large regression
>   in error handling. A surgical switch keeps everything else native.
> 
> - bwctrl is currently the only PCIe port service with neither a
>   native/_OSC gate nor a disable of its own. hotplug, AER and PME are
>   all gated on pcie_ports_native || host->native_*, and pci=noaer
>   already exists as precedent. This mostly brings bwctrl up to parity
>   rather than inventing a new class of knob.
> 
> If the command-line parameter itself is the sticking point, I'm happy
> to implement this in whatever form you prefer - e.g. gating bwctrl
> registration the same way the other services are gated, or a per-port
> sysfs runtime control. My goal is to close the gap; the mechanism is
> negotiable.
> 

I'd argue the other way that developers can still add quirks for testing whether
the crash is due to bwctrl or not.

I kind of agree with Lukas that once we add this knob, it may demotivate
developers from sending the quirks.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
