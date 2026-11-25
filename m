Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625136;
	b=jJnrc5dCTLi52+xmIQaXvYzxzSaawMuybCgeNMSzJJvFeMf2rnib1IxIkRqG0L0OWTYu
	 IpV/r7lKv0PJ/+P7WgHFkqqXBSZHjMQs7jAHsYPXduBNtTpHVIMkCzII9AP+cOg/xudwo
	 bSLQfe2MrJtOjghaoxMH8N+zJFEuNWp8o4cKxvDkiE9mTV6wtHTkFfaNjM4AEJw4euyY1
	 kimAasv7ezZ8vlSHuT9iTO1vA4MzD0uIUx6NOSaDb6b21zQOEbbKAUlTW0YKewQdvgpPG
	 XQFLj5oNx8DbsTTP0/hQjNsyFQdMo9D6iIUrGucTIpM/hfAJpeaQej5fbH0Vkj7Ihmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625136;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MYisWCg5t/umOzhA3FS/AXzeUQ7QzGatCxZGPN8ChPA=;
	b=KU3oSyvUHVoBH7uyY5sZxQOST0+IkdDbhTX/ul17iWpHsdesGKtgzX7gmHPplofLTte5
	 CrLOY0mgxThbcBj1HpjgaI/HAllJeca9fu2dujDbM6x0PkKT2a1D8RaM9OwmAjgtoOQEe
	 2T4WK96SHh5uqDj2gK6UMpwPs0xf9O17udsBffIiOeYN0ioBpKWQopRkHwAbPwyuo4UBK
	 7VtP1DLZrTRvbNVKrB9bDiIe2p6QxSGxtN8QGAAUn395vLkRE/3XftcDIEoZJ/NcXrsTd
	 FTHYI3nHBvnWVCax4Fy6DfX7aJqMypzZ3pJ5wnZA17J+eVUjkCJCAQzNYDL6y5ounxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B043606A323;
	Wed, 25 Nov 2026 16:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B043606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8A7B610DDF;
	Wed, 25 Nov 2026 17:45:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 75763600E3B0; Wed, 25 Nov 2026 17:45:34 +0100 (CET)
Date: Wed, 25 Nov 2026 17:45:34 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <awcQrljZYEuCZWGA@wunner.de>
References: <awVV71IbFuYAJDzh@wunner.de>
 <20261125000838.GA1194450@bhelgaas>
 <awbF3MrVWm98q95O@wunner.de>
 <20261125162258.GH2156781@yaz-khff2.amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125162258.GH2156781@yaz-khff2.amd.com>

On Wed, Nov 25, 2026 at 11:22:58AM -0500, Yazen Ghannam wrote:
> On Wed, Nov 25, 2026 at 12:26:20PM +0100, Lukas Wunner wrote:
> > Hm, I thought about this some more and realized that at least on x86,
> > the kernel may receive PCI System Errors through pci_serr_error() in
> > arch/86/kernel/nmi.c.
> > 
> 
> Do modern systems still do this?

The reports I found are for systems sold in the early 2010s, e.g.:

HP Proliant ML330 G6 (2010)
HP Proliant DL380 G6 (2010)
Intel Server Board S2600CP (2012)

However the reports are as recent as 2024 because people continue using
the hardware despite its age.

> I don't think the reason and CPU give any explicit indicator for the
> error-reporting device.
> 
> I expect there would need to be a platform-specific handler. Or do you
> think a brute force search across all PCI devices would be okay?

The PCI topology of these systems seems to be fairly small, so a
brute force search would seem okay.

However my point is that there are platforms which do signal System
Errors in a way that may benefit from the statistics and ratelimiting
knobs exposed for AER.

Thanks,

Lukas
