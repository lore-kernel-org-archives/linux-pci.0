Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69B212564;
	Wed,  6 May 2026 04:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043242; cv=none; b=NVudyFzhVVM3L5FmoNgCnrCw8MQb+MnKM/1ORSpVQ3Q3bxL38tPbHL9/T/dtIIMnzfJlvutzeGG6PzmTS1A56V9uuUbD/3tQPFJ7Uo1b8iiWujXudNf7UBHVF2bkDLEw9wu3SnVDQlFluzmLEAz0DQ98T3tHAxWSmeZVzMjbYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043242; c=relaxed/simple;
	bh=8BRO34wpzSNiRoV/VbBq8/OGh7gD/MEnui+DH2mh96Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbNsTXzA99NNuq9nytS6+p12ffzME6av3/LLQrPiUmgCnTWULV3x1POAeXmtByINf4eLAMWfXuMNhDHM+eSue78AqenfbKx7eZiQ2lCsYCz9WbVIwBvWbB312MisZfxSac/zAONPrJLzSkbYECPSCK8hTGzAnokG83LK5SSCzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFWcbrpY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFWcbrpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778043240; x=1809579240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8BRO34wpzSNiRoV/VbBq8/OGh7gD/MEnui+DH2mh96Y=;
  b=fFWcbrpYvjNfW3A4irCcf2h6rnr+x2ZeApahwhfrrT2gnw4AwYudwjil
   X2W+JlLrYVPVslIh1hWFGZ0Jo6Vb8oVMvSo8iSMkjre2Gqq3lplY4FO+b
   mCVjwa4PELFv8pSDkOHg7uM9BlIJt35tMkM2n1YqFJNNlY8TcWNhhbW/r
   5ylKTtZB/sL4tJJRvHVQwXTxt13bC7cq02sb2r55co6dSWFClgxuhwAS6
   T0/z26Y4RraWNlOyppk6WCJ7KfkCIQxMTCAqz8p+grOSLeN+qik9eBCCP
   qVUsYzzoQqdnmeGY2RyHez34gwZZnY1t3CYw4br3vQftaDf5KyYCz2za+
   w==;
X-CSE-ConnectionGUID: X0oPl+MySQmH4XAKjhPcpA==
X-CSE-MsgGUID: BFcrNopYS7q0znFNzYtvoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="101599018"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="101599018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:54:00 -0700
X-CSE-ConnectionGUID: /+/opNjGRJSi8KRXTdoZfg==
X-CSE-MsgGUID: eVwQtnM/TQG+AWDONTkEvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="236085376"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 05 May 2026 21:53:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 51A7195; Wed, 06 May 2026 06:53:56 +0200 (CEST)
Date: Wed, 6 May 2026 06:53:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Message-ID: <20260506045356.GH6785@black.igk.intel.com>
References: <20260504225246.480921-1-mario.limonciello@amd.com>
 <CAJZ5v0h2NKNU2NTkXbH0FrBsYQJXVbNVxKCMtUUkNcSkFuMQLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h2NKNU2NTkXbH0FrBsYQJXVbNVxKCMtUUkNcSkFuMQLg@mail.gmail.com>

Hi,

On Tue, May 05, 2026 at 08:09:22PM +0200, Rafael J. Wysocki wrote:
> +Mika Westerberg
> 
> On Tue, May 5, 2026 at 12:53 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > When comparing lspci output between Windows and Linux for hotplugged
> > Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
> >
> >   Windows: LnkCtl: ASPM L1 Enabled
> >   Linux:   LnkCtl: ASPM Disabled
> >
> > This difference in ASPM configuration can cause behavioral differences
> > between the two operating systems for the same hardware.
> >
> > The root cause is that Linux's default ASPM policy (POLICY_DEFAULT) relies
> > on firmware/BIOS configuration. For hotplugged devices like Thunderbolt/USB4
> > eGPUs, the BIOS may not have configured ASPM since the device wasn't present
> > at boot time. As a result, link->aspm_enabled is 0, link->aspm_default is
> > set to 0, and Linux never enables ASPM for these devices.
> >
> > Devicetree platforms already have special handling to enable L0s/L1 by
> > default regardless of firmware configuration. Extend this same logic to
> > removable devices when firmware hasn't configured any ASPM states.
> >
> > This makes Linux behavior more consistent with Windows for hotplugged
> > Thunderbolt/USB4 devices.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=221319
> > Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 925373b98dff0..77497d90be0b7 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -804,8 +804,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
> >         struct pci_dev *pdev = link->downstream;
> >         u32 override;
> >
> > -       /* For devicetree platforms, enable L0s and L1 by default */
> > -       if (of_have_populated_dt()) {
> > +       /*
> > +        * For devicetree platforms, enable L0s and L1 by default.
> > +        *
> > +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
> > +        * by default if BIOS didn't configure any ASPM states. This handles
> > +        * hotplugged devices where firmware may not have configured ASPM.
> > +        */

Only L1 is supported over TB/USB4 tunnel (no L0s, no L1 substates). The
PCIe endpoint and the downstream port it connects to of course can support
the full range as that's a real PCIe link.

> > +       if (of_have_populated_dt() ||
> > +           (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {
> >                 if (link->aspm_support & PCIE_LINK_STATE_L0S)
> >                         link->aspm_default |= PCIE_LINK_STATE_L0S;
> >                 if (link->aspm_support & PCIE_LINK_STATE_L1)
> > --
> > 2.43.0
> >
