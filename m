Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE239FCC8;
	Tue, 28 Jul 2026 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269903; cv=none; b=njdtpiBNoYEB/Vzu0/aRPCylFH6icsHS2zKVmkganzVe+9qscRwEWaWKEsLGiqRHPDvz2ln951ifos73IIjh6FCbA3B9Q1Xn1857QaRXKuoPSOeZN2Kc8342nNH1Bpc9MUpzcRwe1C3OOBhV1/BX0Ad5rTvbLUeOoDkxrSJR3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269903; c=relaxed/simple;
	bh=nHnp9/KWuPWbnBj87fPHZ+supNtc4JSNAj2qiY6gWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sfFhDqIoAo+/rpP5+7aw2J2FEYiB5qe5gOzE7I2yJyET7YOMaDt1gI/LcGzsbXoAClKKlkLKriB1A3T1yiDE/9mOPeby8zmFpJiBKDaXSrAPpCgJjUcMEhP+B6ekuVfGaAi42u1NsIf0NsdTjWWwDWEg8iX/1DDUcu2OhEHIuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvEITonC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvEITonC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577121F000E9;
	Tue, 28 Jul 2026 20:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785269902;
	bh=L9A9P5ZAXT9Z3wPahwK1WnKEHlS15YXT8mjrq1pej9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DvEITonCr6GEdflBYIkHzQsh5atSgIyyz1foa8FdGIad0Z0Eoelg9j4FNzr6U+Y/I
	 AIm5ExIw+cW8COxVUnMn2cCLNFwaJVrJ4ucjPYHYQA4UrOyXDthyDB+AVp1cV0E7PQ
	 HLKGP29b0jvDVuLwxBX5OP/kItf3I4VDKYjv+8Wkz+J/qW48q5ZXyKSB+ps+Tkpun9
	 8exE5crUuH8xaMOHjYtmi+Xn/1KxWXhdI6j6zfIE/gxN6HUlaizIfUtHSBrBAPnYJ5
	 40MLroUmql1vInZL1CjvQeZ+BPzGVjcJGrwLcm1rsIGRC8NdVTzW0URcBgneJ2Wpxu
	 SJohyX+ri5BpQ==
Date: Tue, 28 Jul 2026 15:18:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260728201821.GA1394074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddabba85b064bb731fc99476184804f225d6858.camel@intel.com>

On Tue, Jul 28, 2026 at 07:47:04PM +0000, Grumbach, Emmanuel wrote:
> On Tue, 2026-07-28 at 14:24 -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach, Emmanuel wrote:
> > > On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > AFAICS we still don't know why Tegra264 would set NoSnoop
> > > > and/or RlxdOrd in the MMIO read.
> > > 
> > > Me neither but... I can't comment on that. And de-facto, once it
> > > does that, the BE200 replies with the NoSnoop and RlxOrd clear
> > > in the TLP which is then considered as a malformed TLP.
> > > 
> > > > Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be set, I
> > > > think it's a potential problem for drivers if Tegra264 sets
> > > > them.
> > > 
> > > I ... don't think we would do that. The driver would certainly
> > > not do that... Regarding the hardware itself, I can't comment,
> > > but I can check internally.
> > 
> > Forgot to ask, can you collect the output of "sudo lspci -vv", at
> > least for the RP and the BE200?
> > 
> > And maybe the dmesg log when booted with "log_buf_len=16M
> > pci=earlydump" as well, so we can see if attributes were enabled by a
> > bootloader?
> 
> I assume you want all this without the quirk, right?

Right.
