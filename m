Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BE3C8C7F;
	Fri, 10 Jul 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718853; cv=none; b=uaLRm6zb9WaiJs3GhhW7zAKbnDH8Ub8QOHdc7QazYwowNvank3S94rhUmkwvziVs/p/sMR4AfEzYawFSj6IjRnigWmLnEzeJFdCYqt8dxuuf4FvSNUTW6K2NpSbOS+PSnUe74HLpZpQhzypExMWEouIoA6CApVeuhFF9ipJNBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718853; c=relaxed/simple;
	bh=//Sh59KNciE3FmwTdWjqr/H5f7Cm3Y/MZdGKVx8xi5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SBDxGrjNheDa0hHrTqtXTSoEkKj87K7FqC5mMouxLsdtqgF7TdYje0yjDpsIjOK6iH/HQ6ghefB2qUKxsxiBRtihI4iim1N6eCVeIDPjbZSvF4TGjlpEENwzby3vJbL1ZkCv9TnjAIKUbEqgyskDSj7Cjwn4COqxuZl+HrK2yYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcK4RAri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcK4RAri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E21F000E9;
	Fri, 10 Jul 2026 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718852;
	bh=/WL52UK+TW7sh0dphYbUGY6oLQnJ4iKHAE+9f9iITUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mcK4RAriI3/oq75Q6pfHwlqAN0I1m04sc6W28g0/cLXPi5ALZbxqkhmhTcU/firY6
	 lCF5pJkwn9lB4OACyUwhdE9WvT/M2BNJfKql+vsNEZgASxjtvamHuB8bSXR9IU2EW3
	 hMvtNdmGSSkqMaA32KUSvuSOlfm19E/HGlwmDNczOD5YRu7KbRSPYgYklLvXX9gRkS
	 tmf8KewpzJm+ZAefTVxEzpS39mQ7xR61Fn77bSvMpW9uI6hZOYftR7m9xZujp090bt
	 re0BOABFT09kyJtnENamyo1TmzX6GdnYCpbBmJrJ8Ouz6sesiU+D79NaszwwSQFN+e
	 JtjINoOHzSBRQ==
Date: Fri, 10 Jul 2026 16:27:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] x86/pci: consolidate x86-specific PCI quirks into
 arch/x86/pci/fixup.c
Message-ID: <20260710212730.GA1002024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-_HuWVAZznMBqFVde4cKyF=uM_skeW1fZ8xkmLjbFN3Q@mail.gmail.com>

On Fri, Jul 10, 2026 at 01:51:01PM -0700, Rosen Penev wrote:
> On Fri, Jul 10, 2026 at 1:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 07, 2026 at 03:17:52PM -0700, Rosen Penev wrote:
> > > This series moves all x86-specific PCI quirks from the generic
> > > drivers/pci/quirks.c into arch/x86/pci/fixup.c, where they
> > > architecturally belong. This reduces the ifdef burden in the generic
> > > quirk file and improves build granularity by gating the x86 fixups
> > > behind CONFIG_PCI_QUIRKS.
> > >
> > > The series is organized as a preparatory commit followed by one
> > > commit per vendor/family, keeping each move reviewable.
> > >
> > > Suggested by: https://lore.kernel.org/all/20161221142607.GA8594@infradead.org/
> > >
> > > Rosen Penev (8):
> > >   x86/pci: gate arch fixups with CONFIG_PCI_QUIRKS
> > >   x86/pci: move Intel chipset quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move VIA chipset quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move SiS chipset quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move ALi chipset quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move AMD x86 chipset quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move x86 ifdef-gated quirks to arch/x86/pci/fixup.c
> > >   x86/pci: move remaining x86-specific quirks to fixup.c
> > >
> > >  arch/x86/pci/Makefile |    2 +-
> > >  arch/x86/pci/fixup.c  | 2284 ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.h     |    3 +
> > >  drivers/pci/quirks.c  | 2330 +----------------------------------------
> > >  4 files changed, 2316 insertions(+), 2303 deletions(-)
> >
> > I don't object to any of this from a PCI perspective, so I guess it's
> > up to the x86 folks if they want them.
> >
> > It looks like the typical subject line style in fixup.c is:
> >
> >   x86/PCI: <Capitalized-first-word> ...
>
> I'm guessing this means I should resend.

I'd wait a few days in case others have comments.

While you're waiting you could analyze these to make sure they don't
change any critical ordering.  The quirks are called by
pci_do_fixups(), which I'm sure you didn't change, but the order of
the quirks in each level will change because the tables, e.g.,
__start_pci_fixups_early[], are put together by the linker so the
order within the table depends on the file the quirks are in.
