Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FD425898;
	Mon, 12 Oct 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843814; cv=none; b=rZqnE2vAFTktykNVxW0YYv2afxOxA5yh8igFT46K5pjtWBuTUqRCc3c5frsybBU7y8exswRTWakgw3oON1Ql3LfdHK7R6Gv2mdiGWtEefHe4Bbc/kUxMVuPK628z8bbT/vSvIhvi7rwj/L4SdVikOxCN+1LzBfb2NIbNwB9qNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843814; c=relaxed/simple;
	bh=DBJ4pJTxT6Rb9UBkZ2YQD0NglIFhCzvUKQ3qx9/XYp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ytx4BBbBTs4mfzUswwG10OQr/uUDaqBycznLrmIc847VXIv1yszLO35whYmuLIoGEhGFdZ5pDa0ExxNde25LyYWtPwGWOcz5eogwGcyzSKv3/VAK3c/Lm7bdbI3HfczC5mlTHpTyG5EECOAG0w9PtWBtiIO7WJ0sptHSYTcGCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUxisRdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUxisRdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B59D1F0089B;
	Mon, 12 Oct 2026 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843812;
	bh=GTd4VLReYg7xyozF0HzNASJhv28istpJzAjSxKqTyNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JUxisRdUaCoAOYNq0aOfwMJeW88Q0uydQNiD3D0CChAGZSrjhB6AOEqTc1qrl5Bz7
	 YYXQuBZ0HmyT3auNap07HmD45cJR9/+SbbVmgueRvtFND/MWi6NQqhGqtgQ+5QrN8O
	 2KiZ1vlE+3HJs7qUovNtkZI8fTtipierr9XTbPKQOGfFnX3MT84BwVWdedq6QEDd0A
	 Y7dYtqLcgjKogaQJQpCZMQ6RhxVPP9af3kB2HLpJFNBcPp7sW0sobYZu6sf9QN2VlW
	 XU7zjBoWvxEaTx+oTmx1cIuPrjZSmRlQxbdN/hEZm5rPfZD9MZWxL2iseVAw0LhRmB
	 1B4YSFK4/b6/Q==
Date: Mon, 12 Oct 2026 17:23:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3 0/2] PCI: Wait after FLR for devices that don't honor
 Immediate Readiness
Message-ID: <20261012222331.GA1411603@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011190145.23621-1-gruhlke@mailbox.org>

On Sun, Oct 11, 2026 at 09:01:43PM +0200, Alexander Gruhlke wrote:
> Since v7.2, VFIO passthrough of a Samsung 990 PRO NVMe [144d:a80c] fails
> on the second VM start, and the device is inaccessible until reboot.  The
> drive advertises Immediate Readiness but returns ~0 for up to 7 ms after
> FLR, so since 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring
> BARs") the config restore after FLR is lost.
> 
> Patch 1 ignores Immediate Readiness on that drive.  Firmware 8B2QJXD7
> fixes it, but the Revision ID and Subsystem ID don't change, so the
> quirk can't tell firmware versions apart.  A 990 EVO Plus [144d:a80d]
> reports the same errors [1], but it isn't confirmed to advertise
> Immediate Readiness, so it's not included.
> 
> Patch 2 is independent and keeps pci_dev_wait() from treating ~0 as
> ready with RRS Software Visibility, which also affects the Intel
> [8086:0a54] in the open d591f6804e7e regression.  Hui, Linux-Fan: testing
> patch 2 on that drive would be appreciated.
> 
> Tested on v7.2.9 (Ryzen 9 7950X, X670E): with patch 1 and drive firmware
> 1B2QJXD7, three VM starts in a row work, and every FLR reports "ready
> 0ms after FLR".  With firmware 8B2QJXD7, plain v7.2.9 works.
> 
> Patch 2 is only tested for regressions, as the drive no longer shows the
> problem: below a Root Port with RRS SV, three VM starts work and every
> FLR reports "ready 0ms after FLR".  The VF path is untested with the
> patch, but on another machine, an X550 VF below a Root Port with RRS SV
> reads ~0 from the Vendor ID and valid data from the Command register
> 100 ms after FLR.  v1's variant, which read the Command register, was
> tested against the old firmware, and the drive's Vendor ID read ~0
> while it wasn't ready.  Applies to pci/next.
> 
> Changes since v2:
> - Patch 1: add Lukas's Reviewed-by
> - Patch 2: read the Command register on VFs whose Vendor ID reads ~0
>   instead of treating them as ready (Lukas, sashiko)
> 
> v2: https://lore.kernel.org/r/20261011163249.18479-1-gruhlke@mailbox.org
> v1: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org
> 
> [1] https://bbs.archlinux.org/viewtopic.php?id=314833
> 
> Alexander Gruhlke (2):
>   PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
>   PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
> 
>  drivers/pci/pci.c    | 14 ++++++++++----
>  drivers/pci/quirks.c | 11 +++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)

Applied to pci/reset for v7.4, thank you!
