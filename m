Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132020;
	b=q971YJ5IdypWydCJzXmn7YmoEjxPmdw0Fufv2xTIgYBvrPvmgA2fb4PXWkgZWISm6dn/
	 gmwd8t2eBCcp+vx8Ly3i0uZgwdvGlQ30UuR1CYIVe+Rcl4EG2RYRHrprEm+HZw7WfW6Xr
	 IbL1htO8nk5FAPP0YoJpFEGUJgVrJ8cJREmNwVQssV/KkdurWj8qLNG0xE337FaY66aJk
	 /qMLO6onZGCFQwxXVlbGhMDlHgc/HLcZL4fa0X0CI1Y8C30elwIwZAL8uX/NriYaM1d6T
	 9mlUEuXoa8xNXEfnCnotBiNYeMnRsz2AF3ZNw5mJSh6VmoCQLz6Snepf06d7YzQ2P5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ay8M5kGDBwMQmJOM2Q/RBf1PHxtwlcHfBqyhnd/ZXeA=;
	b=UVvQscrc413SxTPHRQt/i6QJlvSBbSu0R3YoAQlpzgX/eEFvh7WwBZPHHsO8Eo70ucy5
	 tN+qUKeN+A2QyRKnXN290sInX3PEoqepsnitTI0oTAP9FwW77S2JIiOQq4+4y4qNBCgrk
	 YU0Wi1xMjw90kMFZfJWdHxNenfdBcSoyvu8qr+1XhRzh6VYIINeNREGXvxRZkrESi9H4D
	 QSLfkF1ZvMhmVZkyCCoW9krKhkLyiL2C6F61Aumi7a/c4S/Dlx6/kKo2ylRLfeBZTYvgE
	 9Pv4ey1hzJJsuT3x2liJ+QtT3vOg0nZDq9X4RA9hASDdOnOevtnE7qRTKpjc1aTuGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZKL/rv58";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C26606A31A;
	Tue, 27 Oct 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKL/rv58
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B91F01825;
	Tue, 27 Oct 2026 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132020;
	bh=ay8M5kGDBwMQmJOM2Q/RBf1PHxtwlcHfBqyhnd/ZXeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZKL/rv58Nf6/50hxQ7L+yyVfjhxGqEsXEweBpUWAEzgvgbBY8OPFpupGn9uM/jCgO
	 nEYL6oojX95nc+Is62oKbJ324c6g02VdjhVzV3y3+ssOpq3ijPI9qLcESxThXqwrBf
	 E7+xahPdSjE0SstbXykRb95nL+OtSypPpWqTkQBcJPU+L+B80tTmV0nQF32YqtnC84
	 PBxcggYJQqLY6LVdTJYFEGH2eK18WG2cW09WrRCkIZsgo3snf5exmDkbIOo5wNuMVk
	 OXRJSULybEmJfNlEDW6aph/Gg6lXZHmXJWBnexuYsJGRj2x8SvPkA0qTjoLV6aKn80
	 LkFSMfKyd9Pvw==
Date: Tue, 27 Oct 2026 15:13:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <20261027201338.GA485510@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auB_h07OAckfI7gV@kernel.org>

On Tue, Oct 27, 2026 at 11:40:07AM +0100, Thorsten Blum wrote:
> Hi Bjorn,
> 
> On Mon, Oct 26, 2026 at 01:37:18PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
> > > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > > returns nonzero, which avoids probing functions 1-7 on single-function
> > > devices, but also stops scanning when a function is absent on a
> > > multifunction device.
> > > 
> > > This can skip early quirks on multifunction devices with holes in their
> > > function numbering.
> > > 
> > > On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> > > 00:1c.3, also documented by the model list in commit abb2bafd295f
> > > ("x86/quirks: Add early quirk to reset Apple AirPort card").
> > > 
> > > Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> > > 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> > > stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> > > is silently skipped on these machines.
> > > 
> > > Check function 0 first, and if it indicates a multifunction device, scan
> > > functions 1-7 independently so that absent functions do not cause later
> > > ones to be skipped.
> > > 
> > > Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > > Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> > > Link: https://zoringroup.com/forum/5/7170/ [2]
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Let me know if you'd prefer this to be merged via the PCI tree.
> 
> Thanks for the Ack.
> 
> I'd appreciate it if you could take this through the PCI tree.

I don't mind doing that but would like to have an ack from the x86
folks.

I wish we didn't have this early-quirk thing at all because (a) it's
x86-only, and (b) it only works on domain 0, but obviously those are
known issues and we don't have a better way to solve them so I'm not
here to fight that battle.
