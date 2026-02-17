Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F13C2FF;
	Tue, 17 Feb 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347811; cv=none; b=LwcKGv6ANceMP7PJTGkWZ+gi3WtdmPNNeg4Fmj26d+6g6d54tV4WzJdMebR2CZ4b4dev3dAdku0veo/yyTwnFQtXkzcCxlqi3i64gWGX2/cCul1x+4Lr58VgmPd9Fx9NQCsg5JMRbioPXA/AkX0svtdJ8eDg99yMfvYTQXQiiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347811; c=relaxed/simple;
	bh=QD93h6ZjTMy0LoQoX/6B6Or6PN/stlbW07/Jp5k2hJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CWFdAky4xrCRW4POA4SOEcuonwFsUv50qjJFS/4UzpFCiHgDtHOPUz1cSi0y0+JOmphfJadVAE4k1Rg4jBuWoWhwI9wRq71T8A8yqhsB0E/6/ui8876yTiJ1Pf9Pm88/j24l6NaJHRbCPOPcexF/HUTB6IsfE23rPvrLPN29L8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAshu4OA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAshu4OA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D0BC4CEF7;
	Tue, 17 Feb 2026 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771347811;
	bh=QD93h6ZjTMy0LoQoX/6B6Or6PN/stlbW07/Jp5k2hJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dAshu4OAdmYRcjD8iidIjoGiUKWr0EGoZd0EueqSChbgU6oOmCyc+M8fIBG3jWGJs
	 1Y4JchehF/+MOiO7MydqDlsm3lJ5M3uKYSjaAb/57mMjRzbO8ZZ7SgrUclToGrtdym
	 7mrOncqt3fGIzuCOz6j29FsnqtjQbaCcIqmi/KVeV6zBnXnc/YL24M7FRcHOlQSdbk
	 BUQmiDu1LGXkMCuCJjTByLrWKw9EO11rqYrf/Ih9fM5PNwzJptR/BAeSyUgKOaSQwZ
	 gRC/P9k/xkOqWXtDFWEOHBRyGY3u78Lbt+7hjMi/08zvMpZl84tInpTYGRnOWy2Zzi
	 +V7GP97wiZy9w==
Date: Tue, 17 Feb 2026 11:03:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: A couple of fixes
Message-ID: <20260217170329.GA3381022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sq6wub733a7lwmwpjsxp6cxnl3zchzn632b6ni342f4g63rlz3@poxbx7d5vc4y>

On Tue, Feb 17, 2026 at 09:54:43PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 17, 2026 at 10:06:08AM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 17, 2026 at 03:48:45PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Hi,
> > > 
> > > This series fixes a couple of issues introduced in the recent pwrctrl rework
> > > for v7.0. Both issues are due to some incorrect assumptions on deciding when to
> > > create pwrctrl devices. First issue is due to assuming that all OF graph nodes
> > > require pwrctrl and another one is due to assuming that all PCI child nodes are
> > > PCI devices.
> > > 
> > > Both issues are fixed by changing the pwrctrl device creation logic in
> > > pwrctrl/core.
> > > 
> > > Testing
> > > =======
> > > 
> > > This series is tested on Lenovo Thinkpad T14s.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > ---
> > > Manivannan Sadhasivam (2):
> > >       PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
> > >       PCI/pwrctrl: Only create pwrctrl device if the device node is of type "pci"
> > > 
> > >  drivers/pci/pwrctrl/core.c | 51 ++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 38 insertions(+), 13 deletions(-)
> > > ---
> > > base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> > > change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7
> > 
> > Are these v7.0 material?  I assume the pwrctrl changes merged for v7.0
> > were tested but maybe not on this platform or this DT structure?
> > 
> 
> Yes!
> 
> > Is there a functional regression from v6.19 to v7.0 that would justify
> > including these in v7.0?
> 
> Atleast patch 1 is a fix for the regression on IPQ platform, but patch 2 is
> required for an upcoming support.

Upcoming support sounds like v7.1 material.

Re patch 1, I'm not really up on the OF graph situation (git grep "OF
graph" in the kernel tree finds several mentions but no pointers,
other than "bindings/graph.txt", which doesn't exist), so I don't know
how to recognize the DT that leads to the problem.  I guess we must
need a PCI endpoint node that contains an OF graph element but no
power supply property?  Maybe an example would help?

And I guess the problem is that the PCI controller driver probe is
deferred indefinitely, waiting for a pwrctrl driver that doesn't
exist, so no PCI devices are ever found?
