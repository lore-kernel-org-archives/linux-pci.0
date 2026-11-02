Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619191;
	b=bopUdmfn49Af0xwMlqr2xwV0+TxNl0J2KWelUwBEBGpgCDQt4qIg9j0LYOFXKhCGrZus
	 f5CVc0ArsrXyFAKb530yrWA+4MqXd2kdtHjud2h2tMobqlnX/U0/7VOWB+L+w1RNWhuvi
	 EMocVDaol+5JvLLpAfgApShD8waUG5gW2EUMeVgvVO6F11CTx61XY6/D1oDUAYZ57ywc8
	 UCOuYxFtBfdDFqZ60Aye3zqTSZG1WAQ+Y9+pA14i8q1+xImBzI3XSBOHxLF7Zh4uZoWdi
	 wGF/wh+Za5T4iIUSd/v7FtpipwrTseT33SvoNIrzNMB+iNRv8mLheBcBuoBA4vrEIkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BNCtS6fGCl3GPdSfVEKnR+H5gOKJknrG4GxOPaudLWo=;
	b=VPx5fxvwrX84Mh4tIdclEoJEzH2bk4R06eoVjA4iY/zRkg+XbWlP8hb1nh/CLd2OufhD
	 nQEHfu5UTxIghkIRQFtpOQN+Hf9J9R6XDEc5cDZr9XyJHDcwD3r9Ht7ZQ42NqG7HTKaBk
	 N7IgWzI0a6oJvNFobcnm+CZ1AjEUVkUGvlp09ulCkB5vJwJHqgpNUIa+7vPVPRvuOMtdB
	 CByaf9y4zKLUcaR7b2MlaAjKneSyK9Ei451jhxpmDOOPmW6pq0U1qjNTxrIyBEqHbBNJg
	 yOgYfGM0Hz36BzcnZ5tIawL3hLS/iZkLkTELX+As1lwyqz3cW7nk1abxG/lAZNxe60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTwrjfBl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426F606A333
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTwrjfBl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B61F00A1A;
	Mon,  2 Nov 2026 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619190;
	bh=BNCtS6fGCl3GPdSfVEKnR+H5gOKJknrG4GxOPaudLWo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aTwrjfBldRe5i9s8UZ8hDbUasblRX9JpBy0lnsJxj80HJZJDI3U3nIfcGUr0Tzlyw
	 BadG5JKsthqJdFo6Nje31DKOJi984euwM6DIVnj/Q7nC16PtzHL99q+8ZLLj6I539k
	 KTLpv21Mt1ikY7jmVy8OD3sduTl6GY+USnoX2gdYWynHEolDssPG15n+pzl7S6LDxt
	 dA2apIG2qX1fNTPf4SZS1Qg5Q7gjqWc5cGtw+OJ5MbQcF6c7yd+GKZHMIxOvb8JpBP
	 VljTO/BYfDCADHK0rdFkVgMXQN7IXXAC+RSFpxdpwDcun50GpLtvzsKzNA68vRc3gC
	 LPec0EwkapXqA==
Message-ID: <sashiko-outbox-193336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Clarify only_64bit for reserved
 BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102112306.4018464-3-mmaddireddy@nvidia.com>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
 <20261102112306.4018464-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:33:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The only_64bit documentation describes how an EPF driver must configure a
> BAR, but BAR_RESERVED must not be reprogrammed by an EPF driver.
>=20
> Keep the existing configuration requirement and explain that only_64bit
> also describes the hardware width of a reserved BAR. State explicitly
> that its following BAR register holds the upper 32 bits and cannot be
> used independently.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102112306.4018=
464-1-mmaddireddy@nvidia.com?part=3D2

