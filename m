Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6435AC18;
	Fri,  3 Apr 2026 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239464; cv=none; b=fmFi5yuEDeoKBpsQqvpTp6SD0Yg95JRDFN/H2rFWcuOL4mItnFBZX3a8GgeiSCtDbNpUZ56RVuM97L2Ug9ileqhSsZdsnnWh7OVpHZSJ1ioGD7UZ/GpCZqgHffYtTrz9ygEKR55iEks+3FCyNmniDGWAShEve5Of3663S16e0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239464; c=relaxed/simple;
	bh=0rpFGRnZD7bQxsaSjSiGChDCXmq1MQboK29kaOd//OE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pR/sLwFBY7UCSRGyhnRKL2XcP+RxY1rUMHngfMR2qxhfWl4M4vEXr8bDPB+hdhNeGsW+uz+b5gWaAshrkOG2rg/7Sc3S/SkUa6y4TOQBXPszjbHgfu3BExqJ/hQUhH7CfjxzHsWmSSMCIpSKVqc8uYJYUApzKiTZ/l6tOCjdqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6KZsKsW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6KZsKsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E30C4CEF7;
	Fri,  3 Apr 2026 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775239463;
	bh=0rpFGRnZD7bQxsaSjSiGChDCXmq1MQboK29kaOd//OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b6KZsKsWBWQboNM9133pjj4BcGTohKOQO7jOeQ8uUEU2G+3cdGcxKYPsn+6xPNIe1
	 QDKYT72EBUXcYfONBY2f69y4t1d9hxLzgBEJFdlcDdF6tC8fz8cPnSCa0mOqvS2EFa
	 tuQzTESIN8b2Tj3vX84Rf/b3MkbTeHd46UvsFfxhybUiolgrOTjmSM07DR3VueITpN
	 BGXKyi5mBQXLEbAPYU+276o5bA5KBN2HkR34jFrOZ3uplMb0a+yluYw2u50ZVKSpmy
	 8VjcpeCnUpdYW0ITnnW3av3tMZqQ8p2nO4Z+1W333urmuA26TN+tkpPhTJN0q5KVun
	 rnqXGOOuy8Mlw==
Date: Fri, 3 Apr 2026 13:04:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Joyful Lee <joy@joyfullee.me>, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts
 AMD 1022:150b root port, NVIDIA dGPU returns header type 7f
Message-ID: <20260403180422.GA341023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>

[+cc Lukas, pciehp expert, beginning of thread with full dmesg/lspci at
https://lore.kernel.org/all/CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com]

On Fri, Apr 03, 2026 at 11:48:15AM -0500, Mario Limonciello wrote:
> On 4/3/26 11:19 AM, Joyful Lee wrote:
> > On Fri, Apr 3, 2026 at 10:25 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > > That's really unfortunate to hear.  If I was in your shoes - If not
> > > solved by the end of the return period I would return the machine and
> > > purchase one from a vendor that has been testing, fixing BIOS issues and
> > > supporting Linux.
> > > 
> > > I'm not going to pick favorites, but Dell, Framework, HP, and Lenovo all
> > > have offerings that they do this.
> > > 
> > > By chance does the BIOS offer access to "AMD PBS" or "AMD CBS" menus?
> > > If so, there may be an option nestled in there for dGPU D3 behavior.
> > 
> > I got it working. My kernel, which I build up from defconfig, was
> > missing CONFIG_HOTPLUG_PCI_PCIE. It makes sense, but I wish there was
> > more evidence that pointed me to this option. At least we can close the
> > loop here in case anyone else runs into this problem. As a side benefit,
> > enabling this option also got the dGPU to enter D3cold where before the
> > lowest it would get is D3hot.
> 
> That's great news!  I'll add a check to flag this in amd-debug-tools too to
> help anyone else in the future.

That is indeed great news.

But as you point out, it doesn't close the issue.  Somebody else is
going to trip over the same issue.  Most likely they will not report
it and have no idea how to fix it.  Even if they do report it, we'll
have to go through this whole debug process again.

The kernel should work correctly (possibly with increased power
consumption or some other non-functional issue) regardless of whether
CONFIG_HOTPLUG_PCI_PCIE is enabled.

How can we make Linux smart enough that if we're lacking pciehp or
whatever is necessary, we automatically avoid s2idle or S0ix or
whatever causes this problem?

Here are the obvious clues in dmesg during resume from S0ix:

  pci 0000:00:03.1: [1022:150b] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:03.1: PCI bridge to [bus c4]
  pci 0000:c4:00.0: [10de:28a1] type 00 class 0x030000 PCIe Legacy Endpoint
  pci 0000:c4:00.1: [10de:22be] type 00 class 0x040300 PCIe Endpoint
  pci 0000:c4:00.1: extending delay after power-on from D3hot to 20 msec
  pci 0000:c4:00.1: D0 power state depends on 0000:c4:00.0
  pci 0000:c4:00.0: Unable to change power state from D0 to D0, device inaccessible
  snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot to D0, device inaccessible

It looks like something is wrong with the 00:03.1 Root Port config
space after S0ix, e.g., the HwInit Port Number is non-sensical:

  00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge
  -               LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM not supported
  +               LnkCap: Port #247, Speed 16GT/s, Width x8, ASPM not supported

but the c4:00 device below it seems completely inaccessible; maybe the
link is down or the endpoint is in D3cold so config reads return ~0:

  c4:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD107M
  +       !!! Unknown header type 7f
  +       Interrupt: pin ? routed to IRQ 255

I don't know what pciehp is doing that avoids this issue.
Understanding that seems like the first step in avoiding or fixing the
problem.

Joyful, could you collect a dmesg log with pciehp enabled and with
this kernel parameter (the quotes are a required part of the
parameter):

  dyndbg="file drivers/pci/* +p"
