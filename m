Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039572;
	b=LjPFlRsU/Kl8oPaEUsLL/znVS5IabN1mpehs1jZRLbhgGlnQ0XHZVu0UH6y2/YmsaXN0
	 J4uKlkTfiF8Sficekxog/aqcmXzIFPE+wHzFPsSfUV8ZdpBfPMPPkKBAgdIq4GwDy3nJJ
	 l2PJDlYCWmu8KQHv4PTbw3IyelUnlw6pmzU3zhhR1qKdp9lCd0U+laBL65+QkCq15NLFd
	 /qROvLMxd5T33lGvms0acoMA8ZVEc6wMtLm9WBR4R8IOQ4jPHF5r39/cR9KXtV6BMOT25
	 nY1C4UUMXpbR3h3zkjwZql74XXgmszdhgKd30wwNJkLPgZ0Qq6ipoOEUC1aZ4pHX8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039572;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Y656h6emly7vQtOx07lZuRhTn1i7lVTDjqa7PpKqvx8=;
	b=pHqO351CqjAemkOwyFMq0ojWqF5HcEQ74siN62EgG0iPIW5HCpiufShZocQLl3sM3fB0
	 7l1p1jlks86PHCwqMMAZzsSIRpOjLSkiAjhyZpQg8zB5GxzHh5eAo7D/CDh7gneE3iJCD
	 SaOFrg3Vdy+SMqXfZLpTXlOlIiX69T+Q4tSPqe1WgrRsBQ3WGW4W9McWNy3ljPs03HrR2
	 78wRar906FTn49b46omKVtM4hbIDnEDeJjKzdSwsrn6+7L0o08/9xThY9/Nm0iXzK7AYM
	 KilCsx9MxKhVzekwmYdTQ65OBct8RKo30gfIcjbqwHKEr07z91PzQvOYcalwhTIfGBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0Ekg354;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA787606A326;
	Mon, 26 Oct 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0Ekg354
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C71F01825;
	Mon, 26 Oct 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793039571;
	bh=Y656h6emly7vQtOx07lZuRhTn1i7lVTDjqa7PpKqvx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=k0Ekg354iaJT6YupxoOlPphuD8uLZIHh6yvGX6y5eiJKkP3CpDlxXHxrmx+WMVNGo
	 AqQzXiYfZjysQfb9/soz9Lg5eCnaDKeMAyxGcYkIznG5+jn6Y/HsYpKczSFfos0AEW
	 AcCuT/O2qp26rucfEjQjkO25murjqyJDtWsvs8RmDZYDBC1JQ3bRa2h4eW/RAgKots
	 VIA/U0mo61RYJNx+ie0Jjoj8w0THxCAuPESWlCAmZCKuV5nFepDpGoz0WH0vMKYODl
	 8rnN0AUOIm/XML9X2IXfwRYZLJxvMI3n5sjIgjnkW25uwQ0fkYw9woURAPGTBql9/X
	 DplKslTuXs0rQ==
Date: Mon, 26 Oct 2026 13:32:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: Skip nv_msi_ht_cap_quirk when host bridge
 00:00.0 is absent
Message-ID: <20261026183250.GA332821@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABr+WTnD8RXfth=MT562uPT5qn6VefvcF0CbEn+Ye++nFRji3A@mail.gmail.com>

On Sat, Oct 24, 2026 at 07:52:02PM +0200, Nicolas Chauvet wrote:
> Le sam. 24 oct. 2026 à 19:25, Karl Mehltretter
> <kmehltretter@gmail.com> a écrit :
> >
> > __nv_msi_ht_cap_quirk() runs on all PCI_VENDOR_ID_NVIDIA devices to
> > enable or disable HyperTransport MSI mapping relative to a host bridge
> > at bus 0, slot 0, function 0.
> >
> > On NVIDIA Tegra SoCs (such as Tegra210 on Jetson Nano), the PCIe
> > controller exposes root ports at 00:01.0 and 00:02.0 with no device at
> > 00:00.0, and the root port's HT MSI mapping capability is already
> > disabled (found == 1). Looking up 00:00.0 returns NULL and logs a
> > false-positive warning on every boot:
> >
> >   pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
> >
> > Return silently when no 00:00.0 device exists on the domain, matching
> > nv_ht_enable_msi_mapping().
> >
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> > Observed on a Jetson Nano 4GB (Tegra210, p3450-0000) booting v7.3
> > (c03c1a14507d), where the Tegra PCIe controller (1003000.pcie)
> > enumerates the active root port at 0000:00:02.0 ([10de:0faf]) with no
> > 0000:00:00.0 device on bus 00:
> >
> >   pci 0000:00:02.0: [10de:0faf] type 01 class 0x060400 PCIe Root Port
> >   pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
> 
> There is this patch that was well tested on the tegra side (but likely
> less on the older x86 nv cases)
> https://codeberg.org/libre-tegra/linux/commit/63f7810994f4d2866a27b753ec8d5bc36e84373c

If anybody thinks this is better, please post with the appropriate
commit log and signed-off-by.
