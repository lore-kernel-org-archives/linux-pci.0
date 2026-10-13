Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B224F4036
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909308; cv=none; b=FwVM/WaVIynF02EmRduTGbMINb0PAQg7osANdUjf2aSU8ZtGPN+brR8SfvJl7cMDvLJmr36+BqG4netmnf7iqBVvrmPi9k+jZ62vzlS60eS2PUvkOTanCT+iPkbprikqOa97M5ietOLG0Q7YwEa4mmG+ykA4b1TJM/2zWU2jFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909308; c=relaxed/simple;
	bh=PN+r4VLMhssQCrNV6XPUOMNympjbdTpFLc59Vq+ieEo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U0wCZWQw8nHweO72oM3nbAxmG1sV1Yqh4IFCMli6mkenI7NpXqL3SuGK88+zzOkh2A1+UbPygJKSHDKl9PA7iDgU5QA5E5qBhO1RNCZVxBl/iCTFC/cx+9wNpum2eeS74JaIRfrZbpunBIqNjPQIJUy4mCPjN7XWFZ/kuezPO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igwWydtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igwWydtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE31F000FF;
	Tue, 13 Oct 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909306;
	bh=PN+r4VLMhssQCrNV6XPUOMNympjbdTpFLc59Vq+ieEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=igwWydtP9/RJQDJe8CvfELwrsPK91rw9lgxOoWUSEDo2uGjP5nFxSTefsCkr+437D
	 ThvtAfJOs1wlCkUB7uWlJ95QrPNO+JMEmvT8fP7kn8LoGAetn2I9vUaDWBwn1dldC/
	 Q2PUIECgt4yJP2sGQUPHHwqeV3kCi0NMe10Kka4lNvrp9lbNyeBgl03Xzfig8+mWVU
	 s4IJB18EH1hmTJYoKftGr1cchTn0zcDJJf3BJVYl4AVsqeS2s0BZcqO6gbHRQsB5gB
	 lKpCEpib0iMxGkholpfyROWwC/GFufO37z54hFaoAQNrIYSxkcgvX304iyXdIeqPlK
	 iTkLzhw68nwYw==
Message-ID: <sashiko-outbox-170122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/13] PCI: Save and restore the ACS Control
 register and Egress Control Vector
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-9-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:35:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
>=20
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>=20
> Notably, this prepares the kernel to be able to adopt the ACS controls
> established by a previous kernel across a Live Update rather than
> assigning new ones through pci_enable_acs().
>=20
> [ ... ]
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D8

