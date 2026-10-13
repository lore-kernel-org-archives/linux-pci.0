Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7C5208A7
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909294; cv=none; b=QyMiEK5YOJkLuXhxVHzBvHyp6qelQt4uW5+lYdenmUQ3yeR/oQ/DqiTZUUpkaAzq0bPiIry97PM+yltnQzIYneN+e2UKkZJkag7AT4sVgpKEO/P5MeXN9GUluYDm74/82nL9/mXAwwt4ZyIYY1LdE59HsP4ct4TNPoyf5fPCsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909294; c=relaxed/simple;
	bh=nE1mkOMZDpT6on2AX1ya/fJXSU9L87RAWUT5ffMU6JE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TQjsNp1tQwjar5FhVIHeG9ofhYAWzlwSTGtLPRCEmiobscp3HZ2clsJKNemrIdyttKxZNIuLfrOBy1VuWflb1u3IzadbEmJKbr96zo7ijZ523MYYVDTxlR7JpVkGoiROekhW6lFlZcW28qPNc2XHKcf7iVhqaJ3VUNhBI4lAm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6IczZAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6IczZAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFDE1F00898;
	Tue, 13 Oct 2026 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909292;
	bh=nE1mkOMZDpT6on2AX1ya/fJXSU9L87RAWUT5ffMU6JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6IczZAfZSrhmBjggcLW7HlWGGSGs1cPWftoiH/ed5+UR7kdvFCgQRQy0JzKXubWF
	 saM1E5QPt8NfHlMwK5tpaVshuhzLdPdYPh61XU2XRuHVcKZoGwHoEwQGY7q3dDrjbT
	 jNIMfEn7EHXOVTg9N+NQVuG6GzEWUbK9faASdq0AmsIaQKSKWI13zzTtXQCldlIcki
	 ck5bgEV1BUNg2cGTDcMcuep71JhdD05WnTZ4UkiP8NsIYyHFKOUOgoJ6Xd9F85qzL0
	 QD2VShp+d0ufvKXtgoHvyx/Dzuo7+HHoHfalQEI2BgPK4rWuHxr0Rr/cXdZ9dQWT6k
	 3hxYj1mhF6Blg==
Message-ID: <sashiko-outbox-170120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
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
In-Reply-To: <20261013162529.1928093-8-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:34:50 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D7

