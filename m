Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2F59C96F
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653871; cv=none; b=YPM287gY+8cv3dICIKGoAwR/riyQNX0BMGAwBzgW5SiW1CUsfjAu3n767yqJb8mDXuzHW2b0Qn2WCtHrVzyALMGOSZxxwyde1jHCSQNy2jnFSyPnFm+KXMncCnie9ZIOOYC/tVb34W21ag/m/62gkMcxe1VlNKlokfeDvs3Vqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653871; c=relaxed/simple;
	bh=hzrBgAS6A4icHqj/5EWgVGM1Cj3r3iz4JxJ181iGzu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6iJZPoujE/hZX3A8uwcBAlMc+RNnUKQ4fgI4aEx9bBbUH9EgRApmPj8Ey/VBTItL/SbHMCcnPFMx0amMxxyfhHjmH2iP45uajUCfgbhdE9rqSty1DyCCqDuICGm7Q3v4Iy4m8GD3AG0teyvUBA4xtTD9k6/kyZ0g9BdwNeQ2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj8kislV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj8kislV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA211F00899;
	Thu, 17 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653870;
	bh=kK1ljV+QYClOhJgG4m35EEXgD1hYkTfc/eAy3bwGpgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nj8kislVccBiHwiDPCRQaZZc/BJQB+2NRe2WG3V7w4x/sJarpQCJyqUTAxi+PFtA5
	 R52DrlHzT+fcPB+D0FGLq/QAn65AvCohyveX1sxbgqov24lKiKuY333aEN9dvmmnaC
	 ksOp2oEf08mEx+Fzikf/TMf/p5aRzOYcOJRKJr9rA2Qt6dGtVe4Cax/EPDKgI7c6YU
	 oUe1qljKZ4vdjZTnnPwmMxpsM6Xi6lv88qLRg57J7CogB8ZTYEVkcXNq8OgtmFdPll
	 bZ/MT7Tf3LZwVZqESVmqZ5uZDEXSkjzzSvxLTf5MtcTRpJrOyaR9otYdAC0Sv9T0Zy
	 naJQcJEzJc5aQ==
Date: Thu, 17 Sep 2026 08:04:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, Riana Tauro <riana.tauro@intel.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Fix order of device disablement on reset
Message-ID: <aqvza2g_ptLvZjQL@kbusch-mbp>
References: <4c908eaab127d82ecfdc1e9948964b2e641d41d8.1789478646.git.lukas@wunner.de>
 <6a45ad46-efa6-47fd-9408-302ea8bb66e2@linux.ibm.com>
 <aqvfUldY5mGMMYrG@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqvfUldY5mGMMYrG@wunner.de>

On Thu, Sep 17, 2026 at 02:38:42PM +0200, Lukas Wunner wrote:
> On Tue, Sep 15, 2026 at 10:08:32AM -0700, Farhan Ali wrote:
> > On 9/15/2026 6:35 AM, Lukas Wunner wrote:
> > > Riana reports an AER splat when issuing a Secondary Bus Reset through the
> > > "reset_subordinate" sysfs attribute:
> > > 
> > >    AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:01:00.0
> > >    PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
> > >      device [8086:e2ff] error status/mask=00100000/00400000
> > >      [20] UnsupReq               (First)
> > >    AER:   TLP Header: 0x40000001 0x0000000f 0x81190008 0x00000000
> > > 
> > > The Secondary Bus Reset is issued at the Root Port.  Underneath is a
> > > Switch with two Endpoints.  Riana has identified an ordering issue in
> > > pci_bus_save_and_disable_locked() as root cause of the AER splat:
> [...]
> > Since we are changing the order, maybe we should update comment for the
> > functions to reflect that. The change does make sense to me, but I am
> > curious why we didn't see this before?
> 
> We only enabled error reporting by default starting with v6.0 in 2022,
> cf. commit f26e58bf6f54.
> 
> And the reset_subordinate sysfs attribute only exists since v6.13 in 2025,
> cf. commit 2fa046449a82.
> 
> So it's relatively new functionality which apparently wasn't exercised
> heavily so far.

Yeah, we've used it to reset multi-function devices, but a deeper
topology like you described does look problematic here. Your proposal
makes the save state symmetrical with the restore side, so looks correct
to me.
