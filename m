Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847402;
	b=QLgkXVOF8uIyH+3IOjSTtYkKP6oXqvvaHdk1XzoBYLM0AS0jFNRQITSda08ouE1c7ouU
	 O12WQJhc4h1uiXm9gDjnuT0ZjtZmz4fgBGwL+YaevbzRW0r81i2t9Ah+0nBC2uSP6WzMv
	 Mrelye9/9Hd5ImcPonLNFySfYRu6lCXntVEcUmh0h/7v1SLCQLXXNpArU4UK2wkF37T0O
	 E0YpTklXaynBNpx3NMuOchWQ6BdASMAqSzd46oSMNG2cEoe7eEriFIh4SktTh3JIGvYy5
	 PasxVDEaaVRGTT5s5z6p4Hpn844frIe7kTsrtwMtfR/SYt3PPazyU7h/1yt/3fMq1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847402;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=E01A/sMxCZeOeHzcEezVbbfFaJ/NuzFNkpDBo1Ss+1w=;
	b=DM/r2sqxpk1QBc61ECgUa1V1pb3uxyoS6/XuBg7TKpvTfI21PmvbyEulHNqP2c6ifhBa
	 ctQ6aX2GQQ+5TcmIJp982xYzEl44nQvz2OksiCGVeaNVhwPRmOwoD/sDp4ge4Sgxy8WnW
	 bEhrVx9+5WvPMz43O0Xe1mam5kwsceXxWSjBj1agtX981SE6aerXwUhkKYq6LoZZ1idwb
	 BZTunBgxFdgqJXCsIEA+lcYjuqdAj/v1Ywle0uL721oTk/BRs1+qwis6yUz8Ww2ZkF0lg
	 4Xp+Sg1fphBB+YFEqlGs3mED+FfOIO+Fs9x4Uv915hwBeluZwrFXPEpsWFsTuQ+aUYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8FA606A323;
	Mon, 16 Nov 2026 16:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B8FA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id CA09712D2;
	Mon, 16 Nov 2026 17:43:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B1FAA6035F1F; Mon, 16 Nov 2026 17:43:19 +0100 (CET)
Date: Mon, 16 Nov 2026 17:43:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with
 PME Status clear
Message-ID: <avsyp3TXjgj8km7T@wunner.de>
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
In-Reply-To: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Tue, Nov 03, 2026 at 11:31:36AM -0800, Kuppuswamy Sathyanarayanan wrote:
> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
> Status register when they generate a PME for their own hotplug event.
> The PME interrupt itself is delivered.  PMEs from devices below the Root
> Port are reported correctly.
> 
> PME and hotplug share the same interrupt.  When a hotplug Root Port
> runtime suspends to D3hot, pciehp disables hotplug interrupts and relies
> on PME to resume the Port.  On a hot-add the Port signals PME, but Root
> Status stays clear.  pcie_pme_irq() then returns IRQ_NONE.  pciehp_isr()
> also returns IRQ_NONE because hotplug interrupts are disabled.  The Port
> stays in D3hot and the new device is never enumerated.
> 
> Mark the affected Root Ports with a new PCI_DEV_FLAGS_PME_UNRELIABLE
> flag.  If such a Port interrupts while not in D0 and PME Status is
> clear, pcie_pme_irq() resumes the Port.  pciehp re-enables hotplug
> interrupts on runtime resume, and pciehp_check_presence() finds the new
> device.  pciehp itself is unchanged.
[...]
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/ara-_IPXV_i90if1@wunner.de/
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
