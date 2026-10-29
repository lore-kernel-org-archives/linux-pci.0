Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301965;
	b=hNMrYsAo9KhJxc8b7G2TOknJO5ZfgCwQ4t7qGRmUHapWk1NKhhqRTOzTDzrY428PxHtL
	 qjQ3I2uBlZwzTQv8oIFalgQvz3VD++6xfB8vUreZ9O3sJWdENpaIj6v23fd1jhY2H0qYa
	 79NhGqWSzHG/Gp/B+IbIG59uubvGVpXMol6ryVOolbiVQy4KTe7cRd5H4LpqFRIsBsOXG
	 TpbMOmmwU8JgYANf87wIVr8Q2sy5zPaWYzmIfU9QYiI5MC2uQOFaKSK2pfDsAwVU/R7C3
	 rO/AF3zOuI4aP9IB9qzcMBj4ZmiPVdWkF934sQ9k49W6wqqHBgQ+qeADwK96+9pICMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QZ4GEkTyMhYI276R8ZrcVlrXD0GQvtw2Cl2N7klm9B8=;
	b=IA8F4YZKLXvdPPoK6CWb0dj+zBws/a2CHZeYJ+GqzoDFGE8WBU2MRTHT60D1U8cSWVCo
	 +wt4IDdVgEvAZWDoNU+xv3tKGj3BdP1m4w3MCZs2Xq0Q5cu2zI/7NcstxDCkKOcFSR0Ej
	 9TuaVtMzUrDkzubDuarPAY6FRbPAsyVzUE1ulGn7E9QOHKKKWwt72fJpMIMezrSekfPvf
	 tW+SC8De6uMgerJ/WNeaWQLxnCrUuRW49aqqzIVz13AimaGOJWjN/UPl90FHx0dsqRLYl
	 e87s3gyAKgbMe7tvNZNVDC1eNqnZS7WUUY8LWnlZPKmxrIlvRenmwuDa1+z4v46xZSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hkz316u/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A67606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hkz316u/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798EC1F01816;
	Thu, 29 Oct 2026 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301964;
	bh=QZ4GEkTyMhYI276R8ZrcVlrXD0GQvtw2Cl2N7klm9B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hkz316u/1KlFy4d7ULs3CeSzVa5JWIE9747XUI3E32Wa8BgeyraeXQv2zfuz+8vbQ
	 LGPmK4vqRH9rNuc0S/PZ4rYYJ8m+bWEtUiOgkDwPg6t11tyO4liXVo6DbsU4r24Frd
	 IIRMx2kwNkto0E7HMafhFXGHofrSXyAseTOtOdBGRYqe77/560LHs/QvoTJReRwvQn
	 kmpzPvAznUpGp7bTaBwRWeBCf+uNGBD57cQdpVTC0kl7czUHGRkaV40luBGxHTmztt
	 j9RTIrfDr/THo9CxBMRQPwLA5ENxIb1z9Du09pu8hdVbGauFY0uyV4yh2cemfWKukH
	 fvywGgdDUPieQ==
Message-ID: <sashiko-outbox-189876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: Add
 pcie_capability_user_read_{word,dword}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029192032.1325629-4-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-4-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:26:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pcie_capability_read_word() and pcie_capability_read_dword() use the
> kernel config accessors which don't check block_cfg_access, so they
> can't be used for reads on behalf of userspace that should wait for a
> reset (or other pci_cfg_access_lock() holder) to finish.
>=20
> Add pcie_capability_user_read_word() and
> pcie_capability_user_read_dword() helpers, which provide the same function
> using the user config accessors.
>=20
> These are for use within the PCI core, so they are declared in
> drivers/pci/pci.h and not exported.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029192032.1325=
629-1-thepacketgeek@gmail.com?part=3D3

