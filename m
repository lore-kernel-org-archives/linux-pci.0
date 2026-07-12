Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FA82866;
	Sun, 12 Jul 2026 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851520; cv=none; b=Z5m2p7wKiUIFLs3W0FGmOEigZwoi3DSWGItBLfGoexMSfrB0WvUutqigur5tfNlIbh6Lr6CmWMyiLrOZGWEfiYuBiFureSKY0vt1arAw9Yuv0+ErysXAka7R6LWZozbsFqvTpKV63Dk6wDnC0mEBw3XTPcwL52roWxcNAbpoiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851520; c=relaxed/simple;
	bh=4JWOZ7Z+VjTcuBiaoR/tbLu40SPXwQ0lNF5iqY/PCzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFha2M2sFS9X/zm4BJhx82v6Pq/BrGlKgJTsW9eGYdPvEf3xPQ+cPwEbhFO0L4jhSwb6kszENgfR6xDCr5DSbzMIDvMLDtiV6s7czyRzqp8qKu4klNu7eUQtA5EnZdBgMhGdhhqfYkT8ukk0ASvxJnnzFnKx5jKxwgV+Hxt9RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 38F72C12;
	Sun, 12 Jul 2026 12:18:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 085F760211BE; Sun, 12 Jul 2026 12:18:28 +0200 (CEST)
Date: Sun, 12 Jul 2026 12:18:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] x86/pci: move Intel chipset quirks to
 arch/x86/pci/fixup.c
Message-ID: <alNp9GFvMDN7yDQ3@wunner.de>
References: <20260707221800.920270-1-rosenp@gmail.com>
 <20260707221800.920270-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707221800.920270-3-rosenp@gmail.com>

On Tue, Jul 07, 2026 at 03:17:54PM -0700, Rosen Penev wrote:
> Move Intel-specific PCI quirk handlers from drivers/pci/quirks.c to
> arch/x86/pci/fixup.c, where they logically belong as x86 platform code.
> The affected categories are:
> 
> - I82371FB PIIX3 passive release (quirk_passive_release)
> - 82437/82439 Triton PCI/PCI transfer limit (quirk_triton)
> - 82441/82443 Natoma PCI/PCI transfer limit (quirk_natoma)
> - PIIX4 ACPI/SMB IO region decode (quirk_piix4_acpi)
> - ICH4/ICH5 LPC ACPI & GPIO decode (quirk_ich4_lpc_acpi)
> - ICH6 LPC ACPI/GPIO & generic IO decode (quirk_ich6_lpc, ich6_lpc_acpi_gpio,
>   ich6_lpc_generic_decode)

These are all 32-bit chipsets.  We don't need to compile them into
modern 64-bit kernels.  They should be #ifdef'ed to CONFIG_X86_32,
or better yet, moved to a separate fixup_32.c file to reduce clutter
and make it easier to deprecate and remove 32-bit support one day.

However, I vaguely remember that some Intel chipsets of that day were
paired with DEC Alpha.  Triton maybe?

E.g. The Retro Web has some grainy Alpha motherboard pictures
and there are Intel chips soldered to those boards:

https://theretroweb.com/motherboards?itemsPerPage=24&chipsetIds[]=1886

I wouldn't be surprised if Intel PCI bridges such as 82380FB were
used on non-x86 boards like these.

And I'm definitely not surprised that LLMs think these are x86 only.
You'd have to train them with old data sheets, manuals, magazines,
otherwise they're just as clueless as anyone who hasn't lived through
that era.

> - ICH7-10 LPC generic IO decode (quirk_ich7_lpc, ich7_lpc_generic_decode)

ICH7 was used with Core Duo from 2006, I believe that was the first
southbridge to be paired with a 64-bit CPU.

Thanks,

Lukas
