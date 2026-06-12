Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1414395DAC;
	Fri, 12 Jun 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279050; cv=none; b=jr9zb0o2Sfy7qax9MOyb9AQlaABH8bpMqbII+0MkcF7R5bCEAhjHAxp5KpvxDPf46Tw+3T0nLjshSts8WXd2Mhs/wIu7WmZ8eZ6rRM58sBzSNotQsUhHzA6EsOvnk/FCQG/eN/jQenqqmby1O7w5GqMfNfvf7i9eV1wLbbCFPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279050; c=relaxed/simple;
	bh=YG4Xj6NQS4XPDuEw1LeL4GXAUZzmYAL3wX1M8+fJW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UGz0/ImRWP8/xHF1oA9t2n8lEDSBiG0M8CVMz158NtZyJzsJl4d/w5j44cg9NxkHCk/65DNwqVkorxJ4rk82Ym7D7VTADBs1TLHRH6VvMJxYVSG/C6SkRBK4F+hl2Dz4dHdf6CilojfeWZiS+65pOpo49M3Z9SiDibxgGGoTMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPpw26fK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPpw26fK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDD81F00A3A;
	Fri, 12 Jun 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279049;
	bh=uV3fB5rdPbckchyokDpVyk7qtdmHfncZc3SxcPGsUjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HPpw26fKBMReVbSELb3LL42sH5+toP/bSXvIa0Luu/O2NqpDlXgbqq+663TVD99eM
	 8ScPQb6+UAvaWnPjpTOpzGTZRWcxkKdJoFyeFTR2Xnvn+wlV3DBCYPeTdnVwOPGyWs
	 H6GccNr9NY0ZK0MGG42A6ku0Aa4pVNGLg02QmY/QGdyeVsuc3wIEEmP0v9JwvT4G+n
	 2C/zBeILVO1i5c1DgHsDCWjkzE2xsx/A1uzYzD5ScStzDyOFEP/0FMFxz0QsXu3Bzz
	 l7xy6x8kNymaFH4lDIb4jU4US77D1ZTCbH/B6VTb99ypueOtllQKneeKwpjAiZY55N
	 V3x+Fe0WCX+Dw==
Date: Fri, 12 Jun 2026 10:44:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260612154408.GA608704@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edb130d-8db5-4d48-8f26-1ed24dc544c8@linux.ibm.com>

On Thu, Jun 11, 2026 at 04:29:05PM -0700, Farhan Ali wrote:
> ...

> I do agree exposing both pcie_flr() and pcie_reset_flr() is not ideal, and
> having single API with all the checks would be good. I can take a stab at it
> (separate from this series) and look into either folding the contents of
> pcie_flr() to pcie_reset_flr() or converting all pcie_flr() caller to
> pcie_reset_flr(). AFAICT reset_intel_82599_sfp_virtfn() could be the only
> caller that actually needed to avoid the PCI_EXP_DEVCAP_FLR check.

That would be great.  Probably something that should be in linux-next
for quite a while so we have a chance to find any issues.
