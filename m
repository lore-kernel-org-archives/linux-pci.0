Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301826;
	b=eDVROpNkR6UJXQ8y6m695zpQtWNqc0rYdiOEemc6Gsf4J21/VxObJxp8iemnm/N1LRJz
	 Ke3fpDv8mng2C2+/vOl3bzXtXOEsPfBhV24uu2N3y1U+hIrVWLaOQ1SDEPZFGWwjNWxiX
	 QzsSeqB6jf5sYe8hFIn420IGD36VUKq9GS5/4m8NWqroLsVl9PayLM2e2aqCq+Qhd/qor
	 RhoGVIOEv/F1esfo/szH7KOBseKXKNLXCQdEoUHxcQuWiCR2lcL/Px2m6uCqQal1J9Urn
	 ywaeFBTvYqECi3/TVTL4BxfJTxK1vGYHW24+5X/GKw4yFFDwKfS4rgAvvoQigL6B/0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301826;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U0MnDcS0F68tJghOjoFSdRtkgWNAsbbz1cqyjVtvY74=;
	b=C7zqWKa6AfUb2TdDO2XSEYMDSjaRXcTv3Eyu7+P/WRt9LYotLVPnEdGj7BYgPz4YaWN9
	 o5MktZE3al1lwktA+nD33NIghAEtU2lg2jgCXY0gl1q1YB2N9T1MiCijGJ3fGpqYeezLm
	 Qi/v9p/1mjUapH+Q5Djn7cXl3k6Fg32hkIi5wPwtr1MWwNmqhZjvfmx1mdjahYLzrdiyB
	 kpyfN2IsG0+CH0OL52ID0Ilmcc6GXc47DfLPUZyl3BqMmYUXVfTqIVIJ0n88xY5oLWhOK
	 F3hTtXtlkbIbS07Nf1OpFPPHESczphfwIXzmeNQB88czT02UBKGAcI9s6QnHj36l9UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyRXmeaW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA273606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyRXmeaW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8E41F01829;
	Thu, 29 Oct 2026 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301825;
	bh=U0MnDcS0F68tJghOjoFSdRtkgWNAsbbz1cqyjVtvY74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyRXmeaW+ftIADb5GPVnIQmhP7wSvTozufjSefmtXnSsQUBrMx5of1LJi3I+f4qbB
	 d2rpce0jqjACKnzc8MdIs4oFaMQtgEixLFCRwCeGFC3vgycoGNZRoYOJ8DpKlkVEtQ
	 tKqOSpNYRlZZrTezsT+U5Kf2JBcC+aPTHn6j/zx3mA7iq/umwd3OcOFtMBSm//3PjW
	 T3BdKHNqRRMHiTNq09rKQOpLvAgD1Esai4TH8FaAU/hKXCvU3RS0VNS/dL19O8wGdd
	 lfrXiKR9MvEUKPXYX1f+hWKfKZmVyAQDNHbDNgnrvpEatu3n5aTur7rtK5OyzHXsjM
	 51fVITkPwBbrA==
Message-ID: <sashiko-outbox-189870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] PCI/sysfs: Use user config accessors for bus
 number attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029192032.1325629-3-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-3-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:23:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> secondary_bus_number and subordinate_bus_number read config space with
> pci_read_config_byte(). The kernel config accessors don't check
> block_cfg_access, so a read that races with a reset goes to the device
> mid-reset and can fail or return a bogus bus number.
>=20
> Use pci_user_read_config_byte() instead, as the "config" attribute does,
> so the read waits for any pci_cfg_access_lock() holder (e.g.
> pci_reset_function()) to finish.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029192032.1325=
629-1-thepacketgeek@gmail.com?part=3D2

