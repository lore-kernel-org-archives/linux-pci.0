Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792444;
	b=vL26wWtJzgHkTSHXJ47rh5ZX+0STWRtGk8VIHTZ0iDJPktcBJqNYHKzlEIDonMRp6EXR
	 O8RsjnFYCnrPr9V9LRkAvbtZIxFJktqMPjKgDNanW3HgoYlJKKViO6MV5rK1j2P49pPTi
	 i6IA13xBsWQxTL/xUyBaklCNhOhSIg6q+DJ6IkQdtPAQS7qQzhEe7lMCDBZogDXwiWKgU
	 pnR4VRp3O/GW0srBBShDTdPZvtzrs0w/mFCOKklTXdthFzy0g3a+EJn8EyPHZKrDip4hD
	 B/Ggg2lVBt9fEWfi0ezd1csgwDji7NEpgYphKwIDG1qHbFlm6poVykp2A5VP/ULDwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792444;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C+TZgXFkzo5sX8CdrLFYuFLG0Q9R8EvWY/zSi+BxPr4=;
	b=tVB1/KeZfVyIUgSSKXQlg5RK91ivWJ9PQSJGV7wUNLR/p1h6HIQ5ll97LvMVDad6t+9g
	 fA3iN4fNuOzlXBNxCOsaPQ4vtEwrWnQOvmdkMtojAFC/aS2PqrKYzVg2Fu6DcY4Npm+PK
	 C1PXhe3j4XyBrhDdl0BC9KTl3nOp3EGrNckXT8cWLZ7Hodze9RdI9ZxW/M/MnQ555oP8Q
	 f1bYlOgpgT2dXNo2EWri/BsMIHJByAkiigMA0FiuQI7MBs+OZ7NdDi5sKdNtLfpk+0t/F
	 jokJBl4vXI9a9N5aUr6phtuGeCmyQG/S6RdkcIqC/l0XfVEnS6+CEoJvXCM8g7O9LEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apj5qtKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A754606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apj5qtKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6EB1F000C1;
	Wed,  4 Nov 2026 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792444;
	bh=C+TZgXFkzo5sX8CdrLFYuFLG0Q9R8EvWY/zSi+BxPr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Apj5qtKsx3JtUH9SeH4+OyOq3vT7hJla633yWG0xo0ByBDbRyrAhaLBOSUOrqvUpJ
	 7eTEDehLJ8mnmCD/yILN/CbJIaBZNoKUT/P6y4pHIpvWsjzNRSM/sD6Mx6d3JRBrSy
	 lpLUC/huLfwhxHIxg5FQeIy9Sv1yi/n4ITY3nX4XjEIWNI40RdSybhHRto/kRJaAne
	 NX6SoTKjhwLto0bKt9v+b2LoiiC3YtzJNaC05S0c53I81hUF24fwYQHhTsLq+Lq/ku
	 eXRzt5Np8etKWxHtr7Kylo12kAenWaORHVy92rRtIdMeFRiSDtq7RLNaV+IR+nY5eT
	 YxSas0DQVwT6A==
Message-ID: <sashiko-outbox-197200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: altera-msi: Convert to subsys_platform_driver()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGVuZyBGYW4gKE9TUyk=?= <peng.fan@oss.nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104113235.1634024-1-peng.fan@oss.nxp.com>
References: <20261104113235.1634024-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:40:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
>=20
> No functional change.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104113235.1634=
024-1-peng.fan@oss.nxp.com?part=3D1

