Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCB340402;
	Thu, 30 Jul 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442102; cv=none; b=S8Ek5OoBMz+ouJB1DkDJI0Cqpf1XRieI+tNJKs3HLkbB2PLf4zWG2Q5EA8BzhdzI3pwAQt7GTuVWjughcViCgxGhCiYdNahlMYQ2Io5aggE9CvhApCzEHWL7eFl3V+UIB+CO9e/cc4EkNf48iqCS49Am0mVrW6ttrK6xedJLQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442102; c=relaxed/simple;
	bh=HOjIAp4Cn+n9NqP6wnN6nF1bOK/yQblloSgw9j4x+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ao7J/dGhtX0/ZK74R1zx9aLqTwMNSu1asjGZ21sImQ+hI9t2K9Fx9ZZuLV5hzKK3aTd0JvrSPyEjwtxfDsrqz5vOdWRCT2jcDgmpMPaSu7E1p6VnWECcWopem3JEwf4Xypxpq+DjeOqYzaMCZ3L07g2KaN7C+HNx4u8IA8EMk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEOg3PMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEOg3PMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0231F00A3A;
	Thu, 30 Jul 2026 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785442100;
	bh=NcznJuISkuKI5c0p8DuER5WeRjiK2U8XmaNgW6aTB2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=CEOg3PMddQaSotNCYdGCsjzz8i0KstZCeCNcUrqVFHR8m7gc7Q87xxhlqjcyVjiVg
	 80hypKyhMQqBMwqV90HT6hzOKqUDEVOuJ5X3B+aKrM5MX477yrJ2jhH0NEsuyKhNtd
	 HkUHQc97/hCmUYy3Qhf4dWMc9yeOtueSiHUpyP21osv/Yu1V4jhMBrWjDRx5na5GGW
	 JYhb3XLTnTs8TWjG6E++zInuldDd6VG1e5NXXZjDzwjDZSV34G2Jf+y9IYJQAgmXx0
	 KrzT6sy7okE1Wjp5mqwZARpGDAOFpfZDLENRNxy6XT7Dxt3ShaZ3ndqUTM1fpwGRKR
	 AyQlFTfBMUtDQ==
Date: Thu, 30 Jul 2026 15:08:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
	"thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Message-ID: <20260730200819.GA1520846@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe27839dfc8c33104ea215912cb7d33c85435fe6.camel@intel.com>

On Thu, Jul 30, 2026 at 06:45:29PM +0000, Grumbach, Emmanuel wrote:
> On Thu, 2026-07-30 at 12:28 -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 30, 2026 at 10:21:06AM +0530, Manikanta Maddireddy wrote:
> > > On 29/07/26 12:19 pm, Grumbach, Emmanuel wrote:
> > > > On Tue, 2026-07-28 at 15:18 -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 28, 2026 at 07:47:04PM +0000, Grumbach, Emmanuel
> > > > > wrote:
> > > > > > On Tue, 2026-07-28 at 14:24 -0500, Bjorn Helgaas wrote:
> > > > > > > On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach,
> > > > > > > Emmanuel
> > > > > > > wrote:
> > > > > > > > On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
> > > > > > > > ...
> > > > > > > 
> > > > > > > > > AFAICS we still don't know why Tegra264 would set
> > > > > > > > > NoSnoop and/or RlxdOrd in the MMIO read.
> > > > > > > > 
> > > > > > > > Me neither but... I can't comment on that. And de-facto,
> > > > > > > > once it does that, the BE200 replies with the NoSnoop and
> > > > > > > > RlxOrd clear in the TLP which is then considered as a
> > > > > > > > malformed TLP.
> > > > > > > > 
> > > > > > > > > Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be
> > > > > > > > > set, I think it's a potential problem for drivers if
> > > > > > > > > Tegra264 sets them.
> > > > > > > > 
> > > > > > > > I ... don't think we would do that. The driver would
> > > > > > > > certainly not do that... Regarding the hardware itself, I
> > > > > > > > can't comment, but I can check internally.
> > > > > > > 
> > > > > > > Forgot to ask, can you collect the output of "sudo lspci
> > > > > > > -vv", at least for the RP and the BE200?
> > > > > > > 
> > > > > > > And maybe the dmesg log when booted with "log_buf_len=16M
> > > > > > > pci=earlydump" as well, so we can see if attributes were
> > > > > > > enabled by a bootloader?
> > > > > > 
> > > > > > I assume you want all this without the quirk, right?
> > > > > 
> > > > > Right.
> > > > 
> > > > Attached.
> > > > Note that we used an out-of-tree driver in those attempts so the
> > > > kernel is tainted, but this does not impact the issue we're
> > > > discussing here.
> > > 
> > > PCI_EXP_DEVCTL_RELAX_EN and PCI_EXP_DEVCTL_NOSNOOP_EN are set by HW
> > > default value, this is inline with PCIe spec. It says "the default
> > > value of this bit is 1b" in both cases.
> > 
> > Huh, you're right.  I was assuming 0b was the default, but indeed 1b
> > is the default unless they're hardwired to 0.  And they're both set
> > to
> > 1b on my x86 (AMD) Root Ports as well.  
> 
> Not on my Intel Root port:
> 
> 00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port 
> 
> <Snip>
> 
>         Capabilities: [40] Express (v2) Root Port (Slot+), IntMsgNum 0
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag- RBE+ TEE-IO-
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes

Super interesting.

I guess Alder Lake isn't one of the RPs affected by
quirk_relaxedordering_disable()?  I think 87e09cdec4da ("PCI: Disable
Relaxed Ordering for some Intel processors") added all the existing
uses of that quirk for Intel RPs, and the commit log only mentions
Broadwell and Haswell.

I wonder if the PCI core should disable RO and NoSnoop on Root Ports
across the board?

I think this would mainly affect MMIO accesses performed by drivers,
and I suspect drivers expect those writes to be performed in order,
e.g., if the driver writes DMA descriptors to the device followed by a
write to a doorbell, those should stay in order.  If the RP has RO
enabled, those writes may be reordered.

> > So I would think we'd see this Malformed TLP error on pretty much
> > every system with BE200 in it.
> 
> I guess that BE200 is almost only plugged into Intel systems which is
> why this bug went unnoticed until now..
