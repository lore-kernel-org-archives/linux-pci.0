Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49E19EED3;
	Tue,  1 Sep 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283961; cv=none; b=QbehJnzmNprkFCMwEvwDsZVIPae9x2u1cxW5Kxv5aV5F/5HVVI+I+GYDvs6v3bU3Ke6kHiiqp8PLexqHfjwHRYiZgDFc8SWgCWLLPJu1q5cmvuDSDl1o8qTbJrMFW3m3xlUWYNfrhdYxvYMCMGPsRlycS3zEV5oS5jVLGuiT7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283961; c=relaxed/simple;
	bh=lhcNS8HdrMUKLaJQdrysjQ3Khp0Fj+aQU0JSwJfuKss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVwz1QeUkRyQ2GA1TXvJbGEzgyFMePVuggdeQ3AY2HezgnhGCGstt6SYeHDdhvPhUkx1VCVwPCRs7jrxQDjjykVRbPptSWGvkVyeuOIEMyeBZBm1U1uqO23iVYBsLThLu5edXUNS5Zo6a3Olp+OOlLsOq8wctZSk4VC/7TFQ0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrncpitu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrncpitu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F21F00A3A;
	Tue,  1 Sep 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283959;
	bh=OYIXfgFsfSXI0RZ+i5kGKg0qWPpf+cwBkjbiLUlDwFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YrncpituYluk1i4dsaoYys5Yu1EnjNEIwGgRYjr17iuMUYeGSXs7nSpqiabq0PGbb
	 s6egdNRTZMzrQTXsYcwfIgYArs/k52CtGSpp2c1MAHMNdF7s2D0oxCmRzm71WAdwOr
	 5GLsbI+mcAEy/MAmaYSFqMheIn0JAG7vDsFa4JuM0yJ35fA4K3jR4zS4XOirRekKOZ
	 6lwyqymRPgdVqulASnPEtlnMVR060prUzcioKdMiod7CY2yLduN6Md8mQVQcOnq8ms
	 U/ofstfBMPIJid8xTu7W94jYMmS6lfmOvB0LVEdKblB5vItuLmcNCtQCfvli7sf06p
	 56kJ9uP9jG4ig==
Date: Tue, 1 Sep 2026 12:32:39 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] PCI: of: introduce of_pci_verify_node()
Message-ID: <20260901173239.GD1244140-robh@kernel.org>
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-4-elder@riscstar.com>
 <20260901012128.2AC6E1F000E9@smtp.kernel.org>
 <cde3da8f-933a-41ef-b7b8-f78317ca2d67@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde3da8f-933a-41ef-b7b8-f78317ca2d67@riscstar.com>

On Mon, Aug 31, 2026 at 09:42:46PM -0500, Alex Elder wrote:
> On 8/31/26 8:21 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The check in of_pci_verify_node() falsely flags compliant CardBus and PowerPC PCIe bridges as having an invalid device_type.
> 
> I was unfortunately not considering those types of bridges,
> and don't have experience with (or access to) either.
> 
> In the devicetree code, of_bus_pci_match() does check for
> device_type "pciex" but does not handle "cardbus" (at least,
> not explicitly--the "default-flags" bus type might do the
> right thing).
> 
> I would love to get some pointers from others on how to
> do this correctly, but in any case I'll do a little more
> research on this before I post version 4.

I'm willing to wait and see if anyone cares about cardbus. I doubt it. 
Maybe there's some old PowerBooks with cardbus?

"pciex" should probably be handled.

Rob
