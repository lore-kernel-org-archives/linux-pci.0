Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983758;
	b=CUz3o7GVLBJ2rHSfuNYShav2ZN9Ur3REIy3mtLdGSqtBTjnQLlKpyhABr1M1R9Lh58Ra
	 /XtuTJBrucofkKna7M5a1joYmGo43VHINlZJQN3pMcSUOktl3Tg+oS51/JQ2R+WscApHr
	 yqV2ggu49GIo963HBlSRm264wuaKOOti4L2W/DgXmccfWrWgebBtAukCKY+rd4CBTJLA3
	 q/9pByE2WUNIyrVqkdr/+YVY0zX9mzIyTDp13+B0k0AUj3IdNXczLaHQR8WGrtYpRGvfi
	 k/wG7yr2jSdYdmUXw89PA/rs54oEZcGK8pMssfuF7OWf580bcDznDvAu4XvVzo6+PgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983758;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3y5lDxz8nTwG2yrROH3NfsvQdh3/mM7R3Fks0GKMy8I=;
	b=NRapKKmnm/mNZe9P3CpOb1SPTH8aPQp4JOuKJ1Fe4rafENJv2MU4m+rc5yIEMkuU2NT3
	 FPWz3fC/rtwqp4Va0KIhLkKVTSno9unf6CRvi5Rmxct6du423hVNJhKzUDkBoxc2GIhQN
	 7ZYhJYwpoYks1JfhIz2L0Ql6zRoTWbOq5HbX5+sco0CjOnHvxHg0D8IAusVRrnwr79x1T
	 hskzQ8NjSCYNMM93C5cQGRVKPwHJ/fQg27A+qmrDxDgO8vkGVeI8O+ImwdjwEjxMv1ftH
	 GzyzII+C4IZEtergHam+81byLSmGHnQYJtTo+m6VueHFFszq2S9EFDwyS4nqugxCIFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aB/BBfTE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A70606A335
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aB/BBfTE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4101F0089F;
	Fri,  6 Nov 2026 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983757;
	bh=3y5lDxz8nTwG2yrROH3NfsvQdh3/mM7R3Fks0GKMy8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aB/BBfTEayzvtf43O6Z6qr73yPW06nHrLutBjXm/z5zjaDfYSWRpe5QdjhbqNpT8P
	 rSOpMdg3JM0YvvshnHNYJmYjh7jrggD91Gan0yNIfdF7TcxLWqcnfABySnHRbG70Tm
	 jbmJ7obLf+j0MK+sXSrbmeBmyDMdr60JywKcDj053610x8sxFA3S5U0l8Z62G494wv
	 12zF1RjO23j8gTNYzccqWO/h4PxgSu+6RxgxRq6bunXjWEu3/gNBxX6yg2Duand2Zp
	 WTZVXjzwgLgpCBjyyz94EqxHJt72nH5teSdHriPLhhClUfCuyY71LJbsml+eMJJWrE
	 b4anJHoj6Pj7A==
Message-ID: <sashiko-outbox-201861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/7] PCI: vmd: Add vmd_create_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-5-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-5-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:49:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the VMD bus initialization code to a new helper vmd_create_bus().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D4

