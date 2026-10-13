Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7A521894
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909301; cv=none; b=H6RCOKgN+8RCv0cBMbTH74A5TKgVH8d1OvX64xY24IAOC+H5u8z+qNXpY1fF5JXXfApDRCzVg+nerB2q2sNbYJuETywpAQfQMJ1yqhaOpc4Cq29siosKyBLOI5ZIhP1l6VAMt+oZgIaFXamFaDboQFyKtBa0s3jIzq6qyiMgEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909301; c=relaxed/simple;
	bh=eamPwVaY6pN93fvXHVUmbGw8UIldf2fAJBG+vjxWeX0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o958+Dc7n4O/3GLTjaCLyMIrwKvBHzOb297qcGbJ89rQTcnCUEagBFRaYDdXQ1KCvcQrqKUKtsC6+YRqRJhpXAwEM32fAGHVivLxahjYrfeKekLLY5KRryxv5SXEMEznK+5IMYcmI/bDulpt4NiGcGWxksKqC7XWkUfHgR4p2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntzT+lTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntzT+lTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E5E1F00898;
	Tue, 13 Oct 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909299;
	bh=eamPwVaY6pN93fvXHVUmbGw8UIldf2fAJBG+vjxWeX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntzT+lTWTbiwjB54PNqFtExJY9KfCBZ7v8ywXVFdy+3XeENbQJJHy4A6HxgL6Ocf1
	 VQXQmrazQPQcsiKYDJhacBSS10a0pSCPGHZ+ZSnIiTsATvr2pfNg4kOtGJOda8cJQM
	 aBPVEgxyJS3L19ckKyuodos0UkzVZ9P5BURVIJ1cjze+2Fbm/RzV9N54qdS1JswAJG
	 4ijSneeCb3WJV33vGKXNxmYt1RxfHHImXdVCKDTnt5e2VrS49q4QCZWQkhViaKJvS9
	 YSTWg2eWZm1zOeywqJZ1kBZGRtsa5rZPteR3LOTcXeSA3mktO5PJE+oi5TFayg6a6V
	 ckUqz0cc0j7JA==
Message-ID: <sashiko-outbox-170121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
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
In-Reply-To: <20261013162529.1928093-10-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:34:57 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
>=20
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D9

