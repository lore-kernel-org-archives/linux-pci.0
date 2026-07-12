Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97868175A81;
	Sun, 12 Jul 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852422; cv=none; b=cFqSfVk+M0zXUcj7plWNOfRTJe/WN7VUuBoPd6CkF1rFcaL4ZysSHfrrTma46hM5g9fUUwf/LWOhucTha67HoIV8RkKBFO625fxKtrqAxLqqQTndYzTMnlZ6EL5h6cePtMJ7Pzh7eoP/NpzAfwWAAUlBagjdVOdGj910+zPD818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852422; c=relaxed/simple;
	bh=2/yr9kdJUEX2gmmhuMz8bHDLGaZtA3GOxmjVbPv6avA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnwkGd3GpzfgYUSq06E8KQVAq2Cnw/qz7l+9hBThPHiqeyNis67yGN0zb7qBH6aIJNDAo2ATKaO73YbSnsVFjPgGFquyGYILQdDwaaAQDoZBDTe/4Ljg/g6BOpdqj3H/M8V4F2mwoky/mKPOwh6rU7U9kPUh2bTwt8ES/4ALC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id D83104F9;
	Sun, 12 Jul 2026 12:33:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BAA7460211BE; Sun, 12 Jul 2026 12:33:36 +0200 (CEST)
Date: Sun, 12 Jul 2026 12:33:36 +0200
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
Message-ID: <alNtgEIG1b-bdyFF@wunner.de>
References: <20260707221800.920270-1-rosenp@gmail.com>
 <20260707221800.920270-3-rosenp@gmail.com>
 <alNp9GFvMDN7yDQ3@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNp9GFvMDN7yDQ3@wunner.de>

On Sun, Jul 12, 2026 at 12:18:28PM +0200, Lukas Wunner wrote:
> However, I vaguely remember that some Intel chipsets of that day were
> paired with DEC Alpha.  Triton maybe?

Okay it was AMD Irongate (751/761) which was compatible with both
Athlon and Alpha 21264 because they shared the EV6 bus protocol:

https://en.wikipedia.org/wiki/Socket_A#Chipsets

But Irongate was paired with a VIA VT82C686B southbridge according
to Wikipedia, and in patch [3/8] of this series you're moving
quirk_vt82c686_acpi() to arch/x86.  That doesn't look right.

Moral of the story is, I'd be very cautious about assumptions
that these chipsets were all x86-only.

Thanks,

Lukas
