Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A28145A1F
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488039; cv=none; b=D2me0EGlYqIVjh4lc3PBe7rioDA/VgnXqdJMJw5N6HrfvB822XFCH4CiNLo8Cu4dY2m8kHR13hQ5wLHvSM8Dqd5E/Vlq8BLgJyw1HcX+n/t47Euv0mOaqXxwxfGjz0uhezGp3Ui/3euWW564yxhTkgBFmZlLm5ni5v7QSJio2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488039; c=relaxed/simple;
	bh=ujI/NYAB9OOzdOsJj9e5KNlkon6zl20h5L3UN/QVFdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ReS/ISatpOFkXb2oG6PEc1OPysFMDqBi5WnaaxlRBNzdRc+IjkZYV+L2OFt0lgzJrlBQmEzS0yU8xEVh+qUkM5UZ67/+dvqIHrrJxVFLWEcSlN1tS6m7+O1DeInaOtnOeIDQODL+OTvBMrP0YfaGYec68opZ6OIgvJqLJiYhLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERZwJz7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERZwJz7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147A81F00893;
	Thu,  8 Oct 2026 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791488038;
	bh=IJJ5yNSuhj+U00DAS2C+gX8mlhxc2VewJrIizDNf7kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ERZwJz7N+wX+TSPIf81a+BxDW1Dxx9hAtAu5MOJanUYuVnpOb6vidAmt2wvz365Zl
	 C784VjqrHPX4XdPzEWo9ccbMmlZK8gnp1oKGEYqM37qw1jow+UVdIgBKyPbCZe+01m
	 CGLuEqD25+SlNvnkAlreiu1grazNfH/DEXsfm2guZSDUjiH2VYlcU9UUYriBWxYDMf
	 9v5biTK+W/Gtc5ynAUk3sLfeqty5EEpK59LReGV4u9uNlGd7O68m1WyzyeI7yTfwVw
	 r23cgM7Dd+3vAYmV2tD4CBua+xcomr1P3prDxmHhnw2hDkFX9aLVIPN//yGgYXcrtR
	 dSO/H1gH9VrsQ==
Date: Thu, 8 Oct 2026 14:33:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261008193356.GA920772@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>

On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> On Thu, Oct 8, 2026 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > recover from a Firmware First reported Fatal Error.
> > >
> > > However all status registers in the Root Port's AER Extended Capability
> > > are blank, so apparently the platform firmware raised a false alarm.
> > >
> > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> > > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> > > Errors causes code paths to be exercised in platform firmware which
> > > were never validated before.
> > >
> > > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > > actually signaled.
> > >
> > > Note that this will also skip recovery if both the Status and Mask
> > > registers are "all ones", as would be the case for inaccessible devices.
> > > However that seems justified because it would imply either a hot-unplug
> > > event or a Surprise Down Error further up in the hierarchy.  Interfering
> > > with recovery from that seems uncalled for.
> > >
> > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222095
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> >
> > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
> > since he hasn't tested this change by itself.
> 
> FWIW, I just tested this patch by itself and it works as expected.
> Feel free to add:
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Added, thanks very much!
