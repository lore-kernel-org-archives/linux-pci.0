Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C170818;
	Sun,  5 Apr 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775372725; cv=none; b=tgwCO1DvdbuO+vj2uclb99heK053I1VSlU8e8V3eSrmADAVFP/wE5I7IDNMMGVogcJT2pabKoQSCZ4jI57lGdTXhciCoJk0gBzyve1cikMvkFXi2Vw7s0BLHAHWtn+jVjdTsYSgJHA8s/UNhp/UTppIlb349REsHUtZmsbk25iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775372725; c=relaxed/simple;
	bh=kfa4tEekvQKAv2+kDvqO33po8NedO0Q9IC4uwPSe8ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU5rqbSx4Cya/dnPGGWuHpWmyKFIzis9GyFiLXIVbMnYE0+44+zcyW3YhJUkdANfvP2lcRquI8xdF+UbVOR9ti0ZYGsJKg31BzYB3To/zpu+8OFToCUcfkJljRKdz9h+8v1P/hf7Vm6x4bAZU6+wdVJDFhrXJp+18N7Aw7wEY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id ED0ABCBE;
	Sun, 05 Apr 2026 09:05:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B46546029C49; Sun,  5 Apr 2026 09:05:12 +0200 (CEST)
Date: Sun, 5 Apr 2026 09:05:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Joyful Lee <joy@joyfullee.me>, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts
 AMD 1022:150b root port, NVIDIA dGPU returns header type 7f
Message-ID: <adIJqIn76ApoSdMg@wunner.de>
References: <84268751-a128-4cfc-94ae-588de5d98ec8@amd.com>
 <20260403180422.GA341023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403180422.GA341023@bhelgaas>

On Fri, Apr 03, 2026 at 01:04:22PM -0500, Bjorn Helgaas wrote:
> It looks like something is wrong with the 00:03.1 Root Port config
> space after S0ix, e.g., the HwInit Port Number is non-sensical:
> 
>   00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Strix/Strix Halo GPP Bridge
>   -               LnkCap: Port #0, Speed 16GT/s, Width x8, ASPM not supported
>   +               LnkCap: Port #247, Speed 16GT/s, Width x8, ASPM not supported
> 
> but the c4:00 device below it seems completely inaccessible; maybe the
> link is down or the endpoint is in D3cold so config reads return ~0:
> 
>   c4:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD107M
>   +       !!! Unknown header type 7f
>   +       Interrupt: pin ? routed to IRQ 255

The link is indeed down at the Root Port:

		LnkSta:	Speed 2.5GT/s, Width x16 (overdriven)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                                               ^^^^^^^^^

But perhaps that's expected when a port capable of x8 is configured
to x16?  I don't think system software can even influence the width,
I'd expect platform firmware to have set that incorrectly.

Elsewhere in this thread, Mario hypothesized that platform firmware
may behave incorrectly unless the OS requests control of PCIe hotplug.
Perhaps Joyful could provide an acpidump that may help confirm this.

Thanks,

Lukas
