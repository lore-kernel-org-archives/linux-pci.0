Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F03B6370;
	Tue, 28 Jul 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266654; cv=none; b=J+6yKnIqRTM3m+FuT00sJJIIMvyi807MgUeIzLYecRXuv4D467xUTGS675/JcGzZLaA2P+NCjZI+MR1lKx+TVX8cU8D64rqcaPqHLIUHXwyYkHyhA01MgfRk8JdV6z/wXQM65ZTH1QMTOe48ruoG6qZmEJ3/0APgbwCX70g3A7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266654; c=relaxed/simple;
	bh=XuZXygw5b2kIx+dVT21Rq2mwfBgkQNhxKQSnRaBOBw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FKJBUFEqR566s7QLdvrajdzVW3woXeL4EoArS3qiNf9GjrQBVJEp18mZ/HUmf+R/AXxyBrAl+Yuz5CkzsolHCv9JhlnmxfB6k6wBL2+K6+c63ezXaI6cMgxQ3wAJ9Ak9MD6bMlppEwd7pdrKqZOt2P57wcDVgOD/mtm86kLRXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0z9EozE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0z9EozE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFFA1F000E9;
	Tue, 28 Jul 2026 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785266651;
	bh=kjxjhCW6e9Nch7bd3ypoPg0Bg9XIm5Yg9G8Jq3BOsm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=D0z9EozEAV+VjbZKfwAVjaObvS/nTPkGMTPUG17bUDboG0s4xjLSyiTrNw/OatCzD
	 jh/52gJcOrSzKrCeKivUIm2e6ImdhNKIVeXvk4D6wZQMXwhn2dyEKur7cuoRapU52C
	 r1rdFd9T8lwyrtG6cqjelYCii8cKvBcjCHwGxPpOENkLYDUlUqqJturHzHmwtM2rrS
	 Fe1w3Q2benbI3bcMNDEaFoIb0MW/ZoLLr0PL7wWfpItSQI/34fwny0qPOJa586dshv
	 LJXdvSZqZfFE1bhdFDWFl/hdjHjPQ4FzU5oQERkMKBkz2j9ehMMZyIfmhn4ze+oGcP
	 LJL/ont+joZtQ==
Date: Tue, 28 Jul 2026 14:24:10 -0500
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
Message-ID: <20260728192410.GA1387466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1934c51592fc56c65232b1379680c52c6d0cea3.camel@intel.com>

On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach, Emmanuel wrote:
> On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
> ...

> > AFAICS we still don't know why Tegra264 would set NoSnoop and/or
> > RlxdOrd in the MMIO read.
> 
> Me neither but... I can't comment on that. And de-facto, once it does
> that, the BE200 replies with the NoSnoop and RlxOrd clear in the TLP
> which is then considered as a malformed TLP.
> 
> > Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be set, I think
> > it's a potential problem for drivers if Tegra264 sets them.
> 
> I ... don't think we would do that. The driver would certainly not do
> that... Regarding the hardware itself, I can't comment, but I can check
> internally.

Forgot to ask, can you collect the output of "sudo lspci -vv", at
least for the RP and the BE200?

And maybe the dmesg log when booted with "log_buf_len=16M
pci=earlydump" as well, so we can see if attributes were enabled by a
bootloader?
