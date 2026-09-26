Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794E1E32D6;
	Sat, 26 Sep 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439989; cv=none; b=rXAQwmadz04Z2+2tdDNKmIfTWOlCDeptnlatrCUsdbFPSWHdMMRtTBN0fASCoZ9ZoCWupd/6s6afbChtHf6bZZkPJGMWLxQ4p8Iu2NoomsAhxBonSogTkb9wiY73IpWp5krpZFzc4nuI80Yn0+LUj7BK6aQJ3HACaquGEVVv+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439989; c=relaxed/simple;
	bh=UQCOfWJzxARhie6nlXxoC8sa6BBw+T/hyGMnDQ4xNJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RtL+L7f/5c2f0HDszi1BlzjRyIGIBT0EhrCX5++TN7tfVSEWKXZPeS3hKM9KVvYE/e/19EE0/MuyDBMUEnbLIbiEPpNBaKfL5xoyNcCTyDfyrZuohb6ZhE1rZkj9d9VjzF0e/M8T6ki319dx6OI/2BuxIIcXCb7l+qwf//fJkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX2mVlRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX2mVlRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336891F000FF;
	Sat, 26 Sep 2026 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790439987;
	bh=Cz2ZwJO1HHOlAUYBtqJOf1g+WlB4Y0TrJGQ2pqro30E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MX2mVlRz833rNE1+Qi79BnfPWuB1OEzGKB9hUYSRyfLJNCIin8BPZbbpAt4Hbj453
	 OYp2ulu0DXjBWPOsSMe9wIwI4QXNmKey4/shM+KRZ802f1RUwaeyUfhb8mYxmFAcDK
	 GPkc+V5xzuI9JyhBx3mbhYDRhT/Tf9nhgMXfwwLVEW2efoR8DtHagISTOpMjFpKzwR
	 8h5WXSeOIueycsHxhIZFEYOh8TMkio2TA+NcKv3taJgHG1dA2dD2vrDbHd522zRlED
	 VtKKhVnD0lE2G7icKRaCJZmkOt2Hu477nYdZeYCZTDPfe6z9yF/4thB/cLvVZnNBqz
	 3EpGgqRXUxMEQ==
Date: Sat, 26 Sep 2026 11:26:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	Arthur Husband <artmoty@gmail.com>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	snoep <snoepke@live.nl>
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Message-ID: <20260926162625.GA2140496@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arfea9Zk6mbaoRYr@ryzen>

On Sat, Sep 26, 2026 at 05:02:03PM +0200, Niklas Cassel wrote:
> On Fri, Sep 25, 2026 at 03:01:39PM -0500, Mario Limonciello wrote:
> > On 9/25/26 14:42, Bjorn Helgaas wrote:
> > > 
> > > What if I just merge patch [1/2] ("x86/PCI: Disable enhanced atomics
> > > on AMD NBIO 7.7 and 7.11") for v7.3?  Would that leave anything
> > > broken?
> > > 
> > > [1] https://lore.kernel.org/all/20260403050225.50186-1-artmoty@gmail.com/t/#u)
> > > [2] https://forum.radxa.com/t/repeated-ext4-metadata-corruption-on-raspberry-pi-5-with-penta-sata-hat-jmb585-despite-healthy-ssds-and-raid1/31393/10
> > > [3] https://forums.raspberrypi.com/viewtopic.php?p=2386959#p2386959
> > > 
> > > > Cc: Arthur Husband <artmoty@gmail.com>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > I think we should let Niklas speak up here because there was confirmation on
> > this thread it's an AMD only issue.
> > 
> > https://lore.kernel.org/all/ap6RyP28fxXNjRWS@ryzen/
> 
> 1) The original reporter mentioned that he had never seen any issues on
>    Raspberry Pi, the commit message was AI generated.
> 
> 2) The problem "repeated-ext4-metadata-corruption" appears to be a problem
>    with NCQ on a specific drive. I asked that person for more tests, but
>    he did not to once turning off NCQ solved his problem.
> 
> 3) The quirk actually introduced a bunch of problems on Raspberry Pi,
>    because libata did not clear upper 64 bit addresses. This has since
>    been fixed in commit 82e47533221d ("ata: libahci: clear PxCLBU and
>    PxFBU for AHCI_HFLAG_32BIT_ONLY")
> 
> 4) People had been using this AHCI controller for years (including on
>    Raspberry Pi) without seeing any issues (until the quirk was
>    introduced).
> 
> 5) The people who were complaining about data corruption could be
>    identified to all use AMD systems.
> 
> 6) These people complained that it broke directly for any address > 32 bit.
>    For the JMicron (instead of ASMedia), it breaks for any address > 43 bit.
>    I have a hard time believing that the controller is so broken that the
>    set the 64-bit DMA addresses supported bit in the AHCI CAP register,
>    but does not support a single bit more than 32 bit.
> 
> 7) For all AHCI controllers with these quirks (except for an old ATI
>    one), we have gotten an errata from the manufacturer.
>    We have never seen any errata for this controller.
> 
> 
> All in all, I am 100% confident to revert the patch.
> But, I don't care if it goes into 7.3 or 7.4.
> 
> Just say the word and I can pick it up for 7.4 instead.

That all sounds good.  How about if I ask Linus to pull Mario's AMD
SMN fix for v7.3, since that seems to be PCI-related, and then you can
decide how/when to take the quirk revert, since that seems to be
ATA-related?

I'll ask Linus to pull the AMD SMN fix today, so you could still
revert the quirk for v7.3 also if you wanted.  It sounds like there
might be more details that could be included in the quirk revert,
e.g., the fact that the quirk caused issues on Raspberry Pi and the
fact that the problem the quirk address was fixed by commit X.
