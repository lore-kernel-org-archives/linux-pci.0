Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629A48A2DE;
	Tue,  5 May 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017358; cv=none; b=NKlk3YK+KEYIYtXaHWcWOc3sCuzExtkZngmZhzg0yLL6FAm1AVOVZZjLhqGYf3WFRw6Jewzo0FtGIFUFqGN9lyUXZTV5koupGVx079nEftWB0b7Wi4lvi7hwmWWSFQ0x7RlsQhhhkhw3lH2kgZlM1oCr+Qdd3lSrEg226vpFhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017358; c=relaxed/simple;
	bh=a3YOnkajHyfwERXeEYwLVyZkFUh4Eg/Ia/6U/YCqEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TLHRLfBkM+TxcyBOhhpaB2O8qz1/9d+17kIvvHAAzlmaGZ44lrmge1oxg0ggGNuJnzd+HyS7zZ3m4qLsQyySmIQdO2cbaa6+yTXVkbzfdtCEEFXcVUL+MupknvCYoqTeTMsx2qtsPYJJr/DNeF/9KFwaiOTEaRZ9PPuEBX4sR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Rs5Ysq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Rs5Ysq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F4C2BCB4;
	Tue,  5 May 2026 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017357;
	bh=a3YOnkajHyfwERXeEYwLVyZkFUh4Eg/Ia/6U/YCqEjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g8Rs5Ysq3yjrmKJLH79HPwie7wxnTr7A7fvQQc7zwaMklNAczNvZ6oxdnnL3aJdkN
	 X7EzUEMiyaUoyLinPcDcaf0IFJjLHjpKSJ8mF9SCG8XRLWHamJOMJyxIxxDD9wOYtU
	 asSzF+Ybj0WQazrgHiEbinySZssq45BaPVQxC+hF64Xz2axWfGPyzz9Moag11TrdG9
	 ACWa9/VVU3XZBUogIJSLbEmqLX9Up1A3W4tElWjZtEkrzh4DoGY4sp/jkVSMSUWt+t
	 uVv6u01rQPqHXdl2hJb2Qu7h2wT4oEnXYI5tbkwrHTt4S7rUJbozqVi4T6dY15UdnH
	 WRF2n3Mh4cvEA==
Date: Tue, 5 May 2026 16:42:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Message-ID: <20260505214234.GA751157@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ceb34e-17a0-4ff5-8534-9067d4e9b32c@amd.com>

[+cc Mika]

On Tue, May 05, 2026 at 11:08:14AM -0500, Mario Limonciello wrote:
> On 5/5/26 11:05, Bjorn Helgaas wrote:
> > On Mon, May 04, 2026 at 05:52:46PM -0500, Mario Limonciello wrote:
> > > When comparing lspci output between Windows and Linux for hotplugged
> > > Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
> > > 
> > >    Windows: LnkCtl: ASPM L1 Enabled
> > >    Linux:   LnkCtl: ASPM Disabled
> > > 
> > > This difference in ASPM configuration can cause behavioral differences
> > > between the two operating systems for the same hardware.
> > 
> > A tangent, not a comment on the patch itself, but what sort of
> > behavioral differences are these?  If ASPM is working correctly, the
> > only differences *should* be in power consumption and performance.
> 
> This originally stemmed from a significant performance difference that was
> observed between Windows and Linux with eGPUs.  The link in the patch points
> at that bug if you want to look more closely at it.

Hmm.  The bug (https://bugzilla.kernel.org/show_bug.cgi?id=221319)
reports "instant reboot", which is definitely a behavioral difference.
But AFAICS this patch would just fix something noticed along the way
but not the reboot itself.

To avoid confusion, I would use "performance difference" or "power
difference" when describing this patch.

> I was hopeful that aligning ASPM would align the behavior, but alas this
> didn't.
> 
> It was still a difference that I figured we should discuss whether it should
> be changed to be consistent.

Definitely.  I hope we can at least enable L1.1.  L1.2 is a whole
'nother issue.
