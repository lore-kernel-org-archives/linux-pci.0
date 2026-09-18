Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB713E3DAB;
	Fri, 18 Sep 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762806; cv=none; b=VyQNcEtyMsG7iVSbyuhaQrK96D3T/KkChideehqZ4koJtXW6qSEwEL/5rRRu730gUG1L8Mw3Kc1x3uA/dvZq7AD4o1BaJTMA3n60fE9ds4vpWrjtOqaYauihMjF9rxkV0hi5eHshj+mnasRAL7evfxpJnhOjgL2abDYWNtrNfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762806; c=relaxed/simple;
	bh=Cyl7vQEW3LfLjMkgXBXkK29B6dIUdPn+EyE/qOnRRR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JONf2eMDy97NF8+uTTACMtweRmnWwvrHU19mFagjsZujkkvDz8mnviZtshqHHdBheR7p+eIHLAmEmHZb6nfIVQG8k/YXTl38E9zUaQCMJFOOU+Q8AU1SDvppKdJwcWpWW1ZdDb2zwCLYRHuP7k/BV5ljQaAig42WEPLhupBJo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjUAFoYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjUAFoYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AE51F000FF;
	Fri, 18 Sep 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762805;
	bh=Cyl7vQEW3LfLjMkgXBXkK29B6dIUdPn+EyE/qOnRRR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjUAFoYZxPnQsQpOb1L4wDNqgVs+S5TR7L4F5G2tKrnkscbfk4QcfcKxREph+VKZo
	 HU3vZ2CgZGzNL0KHEe0HjGVd/CzNrQI8pyVAy0FTcj2mqPOkLNYCPtrf3ckcj7DhE8
	 +tqrhYnJcft2QiuKOnJYw3zmVc4Hfu4Bv8z2uZRXufolpGJHLAOMy7wLeOoCyIaywN
	 0YFL2w4urvGcCgv50l6U6RJbbLEgs44TDrHqe2wuj+SIUebumCXE7QON4KoF2V65y2
	 ogVEOzaDp5uXgGhOWTsvegM1Tsg/bEtnr51NmkSqpNGRH+UMEc75JUA3+0XnXd3u8h
	 VBiGcEdnQ9wiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "William Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Josh Hilke" <jrhilke@google.com>, "Pranjal
 Shrivastava" <praan@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Alex
 Williamson" <alex@shazbot.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Chris Li" <chrisl@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, linux-pci@vger.kernel.org, "Alexander Graf" <graf@amazon.com>, "David
 Rientjes" <rientjes@google.com>, "Parav Pandit" <parav@nvidia.com>, kexec@lists.infradead.org, "Lukas
 Wunner" <lukas@wunner.de>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
In-Reply-To: <20260918200640.887030-4-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:20:03 +0000
Message-Id: <20260918202003.E7AE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
>=20
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.
>=20
> If a device is found in the xarray, the PCI core stores a pointer to its
> state in dev->liveupdate_incoming until pci_liveupdate_finish() is
> called by the driver. This pointer allows the PCI core and drivers to
> apply Live Update-specific logic to incoming devices in subsequent
> [ ... ]
> as the xarray key.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D3

