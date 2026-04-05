Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609661E5B68;
	Sun,  5 Apr 2026 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775373430; cv=none; b=rMyUaHPbIUlFXOGQlZA1B408GSDdNBAz803a1XFwsdNfTgtGhP5hleTRFM7g67gy3t+0wp/pP/BbxbwpLxkAX34VEJnQmM1MyN0j8TqJi6guERLdNQ36aZinI8uNByRA5oBs3TudFqNoH4L9mIDGecUnixhvUapHwwIfPTbMpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775373430; c=relaxed/simple;
	bh=GN6VFv/oxQu1oTePkEXrJqHA531yO+kKNFT27nH+PXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwYWg8x+ylekVm26fr1+qh9NgDn0aPZaPDuV9GTuvnB5qiCUBbTSc71Mv/pwFys5nLBrhRyyugNzcFgfxWI7wQ2j5swWRTuJjXOqjMAWJftG+vxOz1PwuLtks6Osk5bvOEYc0W2A/86DmZJ4WWVvYWXERhFKy6hj8FCMYSmyIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 4E22736D;
	Sun, 05 Apr 2026 09:16:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B2706029C49; Sun,  5 Apr 2026 09:16:59 +0200 (CEST)
Date: Sun, 5 Apr 2026 09:16:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Joyful Lee <joy@joyfullee.me>, Bjorn Helgaas <helgaas@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts
 AMD 1022:150b root port, NVIDIA dGPU returns header type 7f
Message-ID: <adIMa_yVLMJZvdLq@wunner.de>
References: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
 <20260403180422.GA341023@bhelgaas>
 <CADj6jrg4YWx+iR0o=JSh23uP0Mb2Mvs-ngCJXGUAwCCUQGHM4A@mail.gmail.com>
 <d0994dad-4506-4b5a-b44d-3bb68aae4517@amd.com>
 <CADj6jrgEwySW_A=-0o947aGg+CmaZD+qR4NnopVFoQptdHz=bQ@mail.gmail.com>
 <024bce0e-5bc7-40ca-be01-278ef9935531@amd.com>
 <adc13acd-4a2b-4b64-9dcc-c622d8b9f3cf@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc13acd-4a2b-4b64-9dcc-c622d8b9f3cf@amd.com>

On Fri, Apr 03, 2026 at 04:28:23PM -0500, Mario Limonciello wrote:
> On 4/3/26 4:05 PM, Mario Limonciello wrote:
> > Thanks - the most obvious observation is what you already noted -
> > without hotplug support the root port skips PM all together.
> > 
> > [24.575705] pcieport 0000:00:01.2: PCI PM: Suspend power state: D0
> > [24.575707] pcieport 0000:00:01.2: PCI PM: Skipped
> > [24.575709] pcieport 0000:00:01.1: PCI PM: Suspend power state: D0
> > [24.575709] pcieport 0000:00:01.1: PCI PM: Skipped
> > 
> > vs
> > 
> > [29.279987] pcieport 0000:00:01.1: power state changed by ACPI to D3cold
> > [29.279991] pcieport 0000:00:01.1: PCI PM: Suspend power state: D3cold
> > [29.280214] pcieport 0000:00:01.2: power state changed by ACPI to D3cold
> > [29.280219] pcieport 0000:00:01.2: PCI PM: Suspend power state: D3cold

Those are different Root Ports than 0000:00:03.1.

> > The hotplug support seems to apply to 3 ports.
[...]
> >    0000:00:03.1 (Bus c4):
> >    - Slot Capabilities: 0x000425e0
> >    - Flags: HotPlug+ Surprise+ LLActRep+
[...]
> OK - so the issue comes from acpi_pci_bridge_d3() which is called from
> platform_pci_bridge_d3():
> 
> 	if (acpi_pci_disabled || !dev->is_pciehp)
> 		return false;

Also not relevant, the is_pciehp flag is true because of the
set HotPlug+ bit in the Slot Capabilities Register, so the check
doesn't evaluate to true and the function doesn't return here.

Thanks,

Lukas
