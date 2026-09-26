Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3F231842;
	Sat, 26 Sep 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434931; cv=none; b=YwmSK6YA+Lkaa9KgkEhbuwiFZ8xNQlC+M81rQjhIy1pWuZYqsBqL9KEB+LawXxLc0kDG8bZoGqnJko9MNE5iNxxZTtJja0O3DtmktACN4iNyJDiaMpVcfJGLc2FP//6CvIdeuiTCcPQHi0aijA9vBW8lkZ/a0HEwCCAHby3p4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434931; c=relaxed/simple;
	bh=4/nLSHrxpqorJAZeMkGE1PSrD9+ARYYS2D3NgPn7tjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmPYW99ZWmxdbgahnBz7A7/OzYYqplN8jFuUtNqpkXvVJF0yR7IkmlLyGzVbqjJiW0T5Im0FrOZbAekFgAHsYtZT1jlcLzshcNmyDHiGAb5CM+SRirT4dAuR/JNepGYT5nxl8W5va+U64Xok8pmFWCnK/qrmmBiy9SjchsgISQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSfd0H6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSfd0H6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E1A1F000FF;
	Sat, 26 Sep 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790434929;
	bh=s5cvX9rhW24sDkkTGKbCcYSVCLIrH5uGHyok7lDtwe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSfd0H6R8S4/DnWp4i8u9mrAaovdDzixikl3GOELYvc7eKTANQmYT1THnChyVeQfr
	 fuBsVt4SSrBSUm9NOGPNo2tCLva4K6vg5Xa3urjkkhwF9XeO0eCscLAZ21dpEIxmHU
	 YxTtnkxy4bEzex3f/jkfkIF17SXijKX0uJxWXN3MpFq/FVHfxdAf4OmFP0qcEaiHh6
	 9myEGFsdLf11rdddpiaTV9RfkF6eJWQGN6ACvQLwqe18vZQTDgUiX9QGS5b8g07GWu
	 zrFZcm0NvSWBZOUcC3eieJ2s30/83IG11VRnbNv6RhNoLirOf7V/nIUYxtR2G5uSdq
	 ZfKyAuQ6AmDCg==
Date: Sat, 26 Sep 2026 17:02:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <arfea9Zk6mbaoRYr@ryzen>
References: <20260925194208.GA2072993@bhelgaas>
 <3cbc91d7-3833-48e4-b21a-ed0f2b1370a7@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cbc91d7-3833-48e4-b21a-ed0f2b1370a7@amd.com>

On Fri, Sep 25, 2026 at 03:01:39PM -0500, Mario Limonciello wrote:
> On 9/25/26 14:42, Bjorn Helgaas wrote:
> > 
> > What if I just merge patch [1/2] ("x86/PCI: Disable enhanced atomics
> > on AMD NBIO 7.7 and 7.11") for v7.3?  Would that leave anything
> > broken?
> > 
> > [1] https://lore.kernel.org/all/20260403050225.50186-1-artmoty@gmail.com/t/#u)
> > [2] https://forum.radxa.com/t/repeated-ext4-metadata-corruption-on-raspberry-pi-5-with-penta-sata-hat-jmb585-despite-healthy-ssds-and-raid1/31393/10
> > [3] https://forums.raspberrypi.com/viewtopic.php?p=2386959#p2386959
> > 
> > > Cc: Arthur Husband <artmoty@gmail.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I think we should let Niklas speak up here because there was confirmation on
> this thread it's an AMD only issue.
> 
> https://lore.kernel.org/all/ap6RyP28fxXNjRWS@ryzen/

1) The original reporter mentioned that he had never seen any issues on
   Raspberry Pi, the commit message was AI generated.

2) The problem "repeated-ext4-metadata-corruption" appears to be a problem
   with NCQ on a specific drive. I asked that person for more tests, but
   he did not to once turning off NCQ solved his problem.

3) The quirk actually introduced a bunch of problems on Raspberry Pi,
   because libata did not clear upper 64 bit addresses. This has since
   been fixed in commit 82e47533221d ("ata: libahci: clear PxCLBU and
   PxFBU for AHCI_HFLAG_32BIT_ONLY")

4) People had been using this AHCI controller for years (including on
   Raspberry Pi) without seeing any issues (until the quirk was
   introduced).

5) The people who were complaining about data corruption could be
   identified to all use AMD systems.

6) These people complained that it broke directly for any address > 32 bit.
   For the JMicron (instead of ASMedia), it breaks for any address > 43 bit.
   I have a hard time believing that the controller is so broken that the
   set the 64-bit DMA addresses supported bit in the AHCI CAP register,
   but does not support a single bit more than 32 bit.

7) For all AHCI controllers with these quirks (except for an old ATI
   one), we have gotten an errata from the manufacturer.
   We have never seen any errata for this controller.


All in all, I am 100% confident to revert the patch.
But, I don't care if it goes into 7.3 or 7.4.

Just say the word and I can pick it up for 7.4 instead.


Kind regards,
Niklas
