Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B0313552;
	Sun, 29 Mar 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801358; cv=none; b=pzaPLarlDLM6p8wgYS6SBjpSGcWEzRTBRsOVoc4m/AF519WzpH23FrWfXvCU4U7+d4GeF+Cz4kQC99UkYrz0cdZ2owiXv7xduIF8ygCv+PI61ZI6WTZuEQxJcf4oBE4dI0xMyRcQ4eMC/SFNSso1QogCfizl4npQEMe0FtV3ahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801358; c=relaxed/simple;
	bh=KZiCfpy9O2foCamZAq+523MBEjBL3TBg0Dr5ng5vm4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdJjd4LU6WB7JqMXajbwIz1jYgiyW+5mJFeFiROuOnHIdgBl0QCinjy2xEjhRfd+ekP12Ct8JUIVi3n4szngIvJ8eXauf+rAot9EMdF+Utg1hWZ7Td9I3LkMSED1qDlLyUpSYhQbbKX1QFMS3OVaOvbELsfhOpRundz3UsiqcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id D067CC1C;
	Sun, 29 Mar 2026 18:22:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 793626014951; Sun, 29 Mar 2026 18:22:27 +0200 (CEST)
Date: Sun, 29 Mar 2026 18:22:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <aclRwznwq6KpA2qA@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>

On Sun, Mar 29, 2026 at 03:52:15PM +0200, Bernd Schumacher wrote:
> [   20.660351] vfio-pci 0000:07:00.0: vgaarb: pci_notify
> [   20.660357] vfio-pci 0000:07:00.0: runtime IRQ mapping not provided by arch
> [   20.660547] vfio-pci 0000:07:00.0: restore config 0x14: 0x00000000 -> 0xffffffff
> [   20.660615] vfio-pci 0000:07:00.0: save config 0x00: 0x0003dd01
> [   20.660620] vfio-pci 0000:07:00.0: save config 0x04: 0x00100000
> [   20.660626] vfio-pci 0000:07:00.0: save config 0x08: 0x04800000
> [   20.660631] vfio-pci 0000:07:00.0: save config 0x0c: 0x00000010
> [   20.660636] vfio-pci 0000:07:00.0: save config 0x10: 0xfc500004
> [   20.660642] vfio-pci 0000:07:00.0: save config 0x14: 0xffffffff
> [   20.660647] vfio-pci 0000:07:00.0: save config 0x18: 0x00000000
> [   20.660652] vfio-pci 0000:07:00.0: save config 0x1c: 0x00000000
> [   20.660657] vfio-pci 0000:07:00.0: save config 0x20: 0x00000000
> [   20.660662] vfio-pci 0000:07:00.0: save config 0x24: 0x00000000
> [   20.660667] vfio-pci 0000:07:00.0: save config 0x28: 0x00000000
> [   20.660670] vfio-pci 0000:07:00.0: vgaarb: pci_notify
> [   20.660672] vfio-pci 0000:07:00.0: save config 0x2c: 0x0020dd01
> [   20.660677] vfio-pci 0000:07:00.0: save config 0x30: 0x00000000
> [   20.660682] vfio-pci 0000:07:00.0: save config 0x34: 0x00000050
> [   20.660687] vfio-pci 0000:07:00.0: save config 0x38: 0x00000000
> [   20.660689] vfio-pci 0000:12:00.0: vgaarb: pci_notify
> [   20.660692] vfio-pci 0000:07:00.0: save config 0x3c: 0x000001ff

The above is from the non-working kernel version 6.12.73.  The BAR at
offset 0x14 in config space is restored and saved with a value of
"all ones" here (0xffffffff).

The working kernel version 6.12.63 is using "all zeroes" instead
(0x00000000).

I'm guessing that the initial pci_save_state() that the offending
commit inserted into device enumeration already saves the incorrect
0xffffffff value and that is subsequently restored by vfio-pci after
resetting the device through a D0 -> D3hot -> D0 transition.

On the working kernel, the pci_restore_state() performed by vfio-pci
probably becomes a no-op because no pci_save_state() was performed
beforehand.

Question is where the incorrect BAR value is coming from.  This could
actually be a resource allocation issue that happens to manifest itself
as a passthrough failure.  It's not visible in the dmesg output because
it is truncated.

Could you repeat this and add log_buf_len=16M to the kernel command line
so that the dmesg output isn't truncated?

Thanks!

Lukas
