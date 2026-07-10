Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3443F0765;
	Fri, 10 Jul 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672260; cv=none; b=lqLPM8gJzm31kXsBM/8hH54mOBe07OgmDsWtll4CCW2ZdNZk4gfgL5pomKxdOf0UB2d+VzIoqraakpCzH5rf+mEhK7d361VAfBW7Xr5e7/qS94F+f2eY9EguNjDRl175KmR6g4z/mbnvu8RmEwximSUu8eiHNqIdcILz31zCCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672260; c=relaxed/simple;
	bh=dioQ1WHGq2NW3krVf4xyXr9Dyl7orouWW8+1/yC/rBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAhb6fNMOMK5Yq3XrpXV7ZmAQvkE0xVsGSocXxlcJLBQYgUekCaBpzkHXBohGotQbFp47nY7kKem/auqkg/W8jerxxJ0gkBpA+tONPzsydagW4YwgvthjGQmQX5yW1vFi1ht7SM9nZTpDs6Y5xyxHldtnju/t2IxknnzAiaOovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAsfeke8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAsfeke8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB01F000E9;
	Fri, 10 Jul 2026 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672259;
	bh=dioQ1WHGq2NW3krVf4xyXr9Dyl7orouWW8+1/yC/rBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAsfeke8fCcxltDQFaF2VupdBZsiw+ONAEG1UG1GZ8HezjAYneh02Wy3Sfn60mG0W
	 t4+am814sdrNReMNc2gqfBQCvXjHOs5JRAvKys6tvSjC8T+TTvgaE1RXDS4I1eaS0z
	 h04q4aUur+JETJRXfI49LVjjo2Q18Tu3ZNohdNJcoBC7svaNQlwGpmANbotdyBiVRF
	 6hf/os02Q7Xa+gkD8PS7ZVFPD2cM1X0n/U5KOKcMB4H3ixwNn0W9A/sx3nt3iv/1mg
	 UusMTHTr9hvznLNL4Sl+5GhoEJAKo6OJh/628uDaXGj9UiOWo/B3hBM1rUN25OOQPV
	 kIG9Uhp1Eyjyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] PCI: dwc: Implement endpoint DMA channel
 delegation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710082156.2395844-7-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
 <20260710082156.2395844-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:30:58 +0000
Message-Id: <20260710083059.4DCB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement the EPC DMA channel delegation operations for DesignWare
> endpoint controllers. The DWC backend uses the local DesignWare eDMA
> provider to reserve the requested hardware channel and returns it as an
> opaque EPC DMA channel handle to generic endpoint functions.
>=20
> Validate the requested direction and hardware channel against the
> linked-list channel counts before delegation.
>=20
> DWC eDMA/HDMA generates DMA requests with a programmable requester
> function number. For delegated channels, the host-side dw-edma-pcie
> instance bound to the exposed DMA function reserves the channel and
> programs its own PCI_FUNC() into the per-channel requester field; the
> endpoint-side chip func_no does not participate in that handoff.
>=20
> Reject VF requests because the RC-programmable DWC eDMA/HDMA register
> window is assigned to a PF BAR only.
>=20
> Reclaim releases the delegated local channel through the DesignWare eDMA
> provider, which returns it to endpoint ownership. Propagate the EPC
> quiesce request so bind failure paths can release unexposed reservations
> without touching DMA engine state.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082156.2395=
844-1-den@valinux.co.jp?part=3D6

