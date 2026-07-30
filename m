Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3723D3302;
	Thu, 30 Jul 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432490; cv=none; b=qEhr7RmGMDcp3Zn7Ki7iBXmab3loJTlGZ1EVDu0vAuoriWrqU64cjx5qF/F3m/EE/8CpBLP4d/MAcYtVLBvT2MeQr6wzo9aImygVoCH7frfaJEiaDRCIWO5YRdq3EaaorE97O5vw6kN9ytWp5WG6amkw0Aauq+u1SNooG9hJEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432490; c=relaxed/simple;
	bh=F7jWIZcpZT8bz6CRDZ0z2h+KSxdRmAD5lnbHO315TYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gzskiaAoKEuEACZc+tNeDwPj7qRsBKSEImbuX6UN56kKwPgGO9PZcavq7XRw8RadqG1eqgPeFgF0aToo4uVPr2Z8tkp0l9ppzEFPXT/Y5+wPUkrfitq9YjiDyNlFfr+DOC6z5vCaqpZLT9OQR7asljRVBYBIKnYTbs/0cycjWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cer9ePU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cer9ePU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0341F000E9;
	Thu, 30 Jul 2026 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785432488;
	bh=hLq2BIPHvrnoSJNFdt47r2lh6p0nxucidPPtpG19mJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Cer9ePU1psWfqEe4uU9Eh3Vp3DiJ3KOSaPGrwckC/1ZI81pE2T5H2THGExoUJnOKh
	 CsmHSIcZQ2vL+oCmfDAcg+06JvqNcN9ocwz6ym6bmVCapI25UH/7BDgYl1zmbn7hku
	 FNhL47TTYF6Icp59BWu2sgnP/N58G2DblbL759SHkP8XAjFVTzwaNyIIycfv6wwN/2
	 NAEBUZmyWsXC5xnaKePMZSaGSRUMVgdN94oW9xH61vKdKKs3IEd8FItYWrIjEE514V
	 iKmtz+nGYpSzN17KjVN1/b5B3mvFE0U3cwwbEu2FpT4CxSdQSKPUuoCglQRNfVoz+M
	 wCY3VVQ7XyNyA==
Date: Thu, 30 Jul 2026 12:28:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260730172807.GA1508799@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa1eb50-6f8e-4f76-8d73-ed3a3276f363@nvidia.com>

On Thu, Jul 30, 2026 at 10:21:06AM +0530, Manikanta Maddireddy wrote:
> On 29/07/26 12:19 pm, Grumbach, Emmanuel wrote:
> > On Tue, 2026-07-28 at 15:18 -0500, Bjorn Helgaas wrote:
> > > On Tue, Jul 28, 2026 at 07:47:04PM +0000, Grumbach, Emmanuel wrote:
> > > > On Tue, 2026-07-28 at 14:24 -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach, Emmanuel
> > > > > wrote:
> > > > > > On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
> > > > > > ...
> > > > > 
> > > > > > > AFAICS we still don't know why Tegra264 would set
> > > > > > > NoSnoop and/or RlxdOrd in the MMIO read.
> > > > > > 
> > > > > > Me neither but... I can't comment on that. And de-facto,
> > > > > > once it does that, the BE200 replies with the NoSnoop and
> > > > > > RlxOrd clear in the TLP which is then considered as a
> > > > > > malformed TLP.
> > > > > > 
> > > > > > > Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be
> > > > > > > set, I think it's a potential problem for drivers if
> > > > > > > Tegra264 sets them.
> > > > > > 
> > > > > > I ... don't think we would do that. The driver would
> > > > > > certainly not do that... Regarding the hardware itself, I
> > > > > > can't comment, but I can check internally.
> > > > > 
> > > > > Forgot to ask, can you collect the output of "sudo lspci
> > > > > -vv", at least for the RP and the BE200?
> > > > > 
> > > > > And maybe the dmesg log when booted with "log_buf_len=16M
> > > > > pci=earlydump" as well, so we can see if attributes were
> > > > > enabled by a bootloader?
> > > > 
> > > > I assume you want all this without the quirk, right?
> > > 
> > > Right.
> > 
> > Attached.
> > Note that we used an out-of-tree driver in those attempts so the
> > kernel is tainted, but this does not impact the issue we're
> > discussing here.
> 
> PCI_EXP_DEVCTL_RELAX_EN and PCI_EXP_DEVCTL_NOSNOOP_EN are set by HW
> default value, this is inline with PCIe spec. It says "the default
> value of this bit is 1b" in both cases.

Huh, you're right.  I was assuming 0b was the default, but indeed 1b
is the default unless they're hardwired to 0.  And they're both set to
1b on my x86 (AMD) Root Ports as well.  

So I would think we'd see this Malformed TLP error on pretty much
every system with BE200 in it.
