Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F23B992C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277301; cv=none; b=nDg7eyDdgef9aedZYY6hgUbzKt6K5Db93tOZMdxMw6pTWmnTKHhbQBaj6zYUOs/YQbFT3H6+visDFA6CKO1EhQys0O6sBAwyqjgVvcLZpr7t5XftqSLNoIAmz5bVPKoMwb9LEcCVShXb63TW3K/GI/+RikgoT68Bz+TULmitk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277301; c=relaxed/simple;
	bh=MYvPJrVb9DcYSui9vWyC2pUv4NcW/6+Z7DUDDOzMIDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnjezTjsNUUSBWG5QkqsvJQfhY9yEgvbys2uRD02a5w+CYm/wRqjRX740hMpn74xRq2LqY8m3j8hN538dMSilRQEi4oKU1R62MRwy0z8sE/lpkst3lfyqTP7pcBu36Mv8Yza8SOHde+neOLLLSaQQAclTDHWDR5ZKHLX7VEEcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFUXAKg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFUXAKg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E1E1F000E9;
	Tue, 28 Jul 2026 22:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277300;
	bh=MYvPJrVb9DcYSui9vWyC2pUv4NcW/6+Z7DUDDOzMIDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OFUXAKg5vDXgd4OqlbhNxIDYjF+v0SWKZBDZCRf1dNrqm4sPK1B+Gund+R3P6bHXi
	 gsIxcMGJTS1C/yDbRSn/4E847NAaLmZpfsmXBzrRbIpNinYg7nTV+Fl7RUzOolkBSP
	 Xifb09pAiMCVOONOgVieCn+VAvWlOoBcIQcyaVEMHBpKQfuOXpG+6HDelzoyqliqOV
	 5w64SJ3Mda8ygHQVedKZJKSX0kw5pYo+P4nHLickHdF5sEYx5Vn0uEUxxsXIMAenf8
	 Tho+wUq5ub+KJF2hAbbiTm1R3ljICojQZvzhsapX0jjQHHxo7wngB+wV4VAPGc/hwn
	 F6pCDLvaKDaWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-11-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:21:39 +0000
Message-Id: <20260728222140.48E1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
>=20
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D10

