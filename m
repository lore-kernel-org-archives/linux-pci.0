Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE93EFD1B;
	Thu, 12 Mar 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336872; cv=none; b=QKGVqa8m1BicpjpGcQoXxAcTyzGWeHZz1ysTs3M3FfW5Bhal+5yNBvJ0R+v7fvKY5q+UU0wlS4TkJ/E/fkXy6flNGhB7OHv2PdCfO4v3WsqIHvHYat279Bz8ufK5amyGyFS7y/b8HacIcxktDKOomzapWlfPe1vEMWRc5HRTUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336872; c=relaxed/simple;
	bh=EkDtA6K/Ec6Kyld7KjhTsjZWrO4UNUSnBgkvFqS1k2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qY9eJZ80Y7i69DHEO813o/kdxcoAOYaHBISIPCnFXOpAbKIkn4mwn3EFiUonDsNFzGpr2A8a8+iLkzEyJILGugV+KNLrhJrL46kPZmdyT9y35ggfVMEkF/yTBjhk4PdDljMHJ/Vi0rfmYlYquBQlWicXQz+1kfrw1eqN/KNFCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1FFbLwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1FFbLwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CACC4CEF7;
	Thu, 12 Mar 2026 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336871;
	bh=EkDtA6K/Ec6Kyld7KjhTsjZWrO4UNUSnBgkvFqS1k2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P1FFbLwCH9/W9g05ioAzL63OafJ+c/1ROoA+dvTKJFZedHCCaX7fV0YtwNQeaerA8
	 X+hjznulyMv4cpTwW1zDSZ3ALOtbgpK6qlq9ZXa0h58a8AMBerk4xUhgmmC2K1qFuk
	 tdLR1ulaagOrug7ZRif1zB9gLu8vTv6cbp0hDt6oj6WDPGUAWvGH5eNgsa5ovKS6h/
	 +hClGQ4WYhbTNonx6Gy0XdGKqYN10/llmNcQaBvIVfqasqYoruRKSdqBRajIpBaErq
	 SE7Dx8hlazyp4EKbTBPJDSEj/slgDcfCFduRe9mf9oiZAnO/7mnl5xC08gqGzEMmNU
	 J6HEGvGBkomAg==
Date: Thu, 12 Mar 2026 12:34:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Jin <shawn.jin@asteralabs.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Message-ID: <20260312173430.GA1108119@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>

On Thu, Mar 12, 2026 at 12:02:14AM +0000, Shawn Jin wrote:
> On Wed, Mar 11, 2026 at 10:00:39PM +0000, Shawn Jin wrote:
> > I'm reporting a potential critical bug in the Linux kernel's PCIe
> > resource allocation code that creates invalid bridge window limit
> > addresses during hotplug re-enumeration after Secondary Bus Reset
> > (SBR) recovery.
> 
> Thanks for the report and the repro and debugging information!
> 
> > ## AFFECTED KERNEL VERSIONS
> > - Confirmed: 5.15.0, 6.8.0 (Ubuntu 6.8.0-88-generic, 6.8.0-90-generic)
> > - Likely affected: All recent kernels including 6.19
> 
> Do you know of any kernels that are *not* affected?  If you do, we
> could bisect.
> 
> <SJ> I haven't tried the latest kernel 6.19 yet. I'm planning to
> install the openSUSE Tumbleweed with kernel 6.19.

I didn't notice at first, but AFAICS the most recent kernel you've
actually tested is v6.8, and "6.19 likely affected" is just
speculation.

There have been a lot of resource assignment changes since then, so
I doubt it's worth testing/debugging these old kernels until we
actually know the problem happens on v6.19 or v7.0-rc1.

IMO we should start by debugging the current kernel, fix the issue
there, then decide about backporting.

Bjorn
