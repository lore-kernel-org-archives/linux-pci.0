Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37472D661C
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223987; cv=none; b=VdHeARsRgB/z4N5bwyVS9t4E4jrONZRbkzPjjOcdZGaxaP61Xq5SkOS4jfmQMIRcDsP1K4SBsDmAZ//38FIEe7e7/yBbmmsp1vatGQYElXfpIkLXlXJGfh8n4Xa0DHWPieuWFL3ga4BlySfYGGVWZe/q6ww135CkXT76Bg3eebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223987; c=relaxed/simple;
	bh=3TgbC1nA98Ot6CqsV6X06uFzVZGqk8PPtO0iLJwS6Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgT4eN27kDF11QUUgbxmPUmXGxXMaz/BFdInn7JcjTcut2fyB11Q5XcU91+uQxsRBxbPmEHM3kpP4G8CY2n7e+KfDVK2NfEvLZ2zdnDzoFPAMS+aFO3hCwndkXGllQCUMHp3NV9QR6tcag9iGTK1GKt8KmQHlMgUBvzdgNmjaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD2/yAki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD2/yAki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF191F000E9;
	Fri, 12 Jun 2026 00:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223986;
	bh=QIijPptOsD+7cYslD7oRIim2k5PM6GNXD1qxDAAqOEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YD2/yAkiFF6DSfK7EiqQSuFlMoVq2By4g8A2JNVhJajPySKT5iMTW8VdVAxIMJVPX
	 cLV6spUMkVa5rwMSMYaLptgaOqjcbY2ArENczCW6Z9385rBfJwt03QkCBgDnN0KiH8
	 lh3gH1U0J8aNMa0GssPD/LGdYdnbIytZTDkBkCaxNJ0Sai7gDmMXmPZRmAXlF0gYvX
	 wstpBZLDJ0n7H9AWAG11bM7AXL7uknyT72f1ow5pnX0QMTYU+6Q1h2G5zRuFuPWP71
	 KmUlqgohen1G9HjgvKyHiPLX9AEzs86vDEM5oE0Y3QVH71p0viYydFQmObOjrtrB7d
	 qchyOv/rQdP1w==
Date: Fri, 12 Jun 2026 09:26:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260612002243.GB2633747@rocinante>
References: <20260611150543.511422-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611150543.511422-1-kwilczynski@kernel.org>

Hello,

[...]
> Thus, serialise access to proc_initialized, proc_bus_pci_dir,
> bus->procdir and dev->procent with a new mutex local to the
> drivers/pci/proc.c file, and store the created entries to
> bus->procdir and dev->procent only on success, so a failed
> creation can never overwrite a valid pointer.
> 
> Additionally, wrap the for_each_pci_dev() loop in pci_proc_init() with
> pci_lock_rescan_remove() to serialise against concurrent PCI bus
> operations, add an early return in pci_proc_attach_device() when
> dev->procent is already set to make the function idempotent, and clear
> bus->procdir in pci_proc_detach_bus() to prevent use of a dangling
> pointer after proc_remove().
> 
> Reported-by: Shuan He <heshuan@bytedance.com>
> Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@bytedance.com/

Applied to procfs branch.

Thank you,

	Krzysztof
