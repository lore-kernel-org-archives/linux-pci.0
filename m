Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833765;
	b=IiF3UWXI+ofSu+h+RDRWPBXomMeRjT6YTkNwuyyS8GjqAKAGbPKt2VLOralWuTSLM8D3
	 OiYWFF4OZ4iCnfq8L/AwILx9xoAfUevZ/+0jVV0iDZ5csB6PPkBreY2SBYCh20sRWfRqR
	 zsvJdZcTcHpsvPC9PAGbf3txd8imTlTMSCNX4ukgVRD/iQ/+zu1tAns3lcNw7lnqIWWIy
	 E6pP8g3jsprXQcmijx0ONSaeihnGmmzmmFA0pTWxR89MD0kZP00CfXdexZaP9nLt+6DR0
	 G4zdFLRHG5Lr7CYnQX/QVdmJucyD+t57TLFh1Y6jnYVKe6au0d+EqvAnDf1jVKXnAHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+MBCipmRIQu9NZq/1Krai2VX4xVRmPWFII08VIA2Q00=;
	b=P1/F7sBNroGiy6fCaUSOKRVX1LEgNp7uZ68whJBJUX2+gvOQE0AEvPIVoF/f6jeyTbMR
	 TcdCU9ClKVZ1A3CuvuR6IicbiRZKSsjNt10m8a8Wv8ZnGFlkQVrxL4/XcruQa7T/NDYj4
	 8NzDYj6T4foGfxoIuOBqvBfthB01dGgJIvwZBqdikA6Ayy9Yilt/aJDjontjh2vE84SMB
	 nTU+h4dJzkynK0OK3VdDwNWfw1LRM4+rd0kH8yW84kJkFCdnpMgeCFz00qkFAVomL7X0d
	 c599HUS1coqTH6NzZq0rJjxQBH0tVDI8XZGntfESUEslc3ajlQTMC2XgHeIZ8OeVUuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd8dWFue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE29606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd8dWFue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEB1F00919;
	Wed,  4 Nov 2026 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833765;
	bh=+MBCipmRIQu9NZq/1Krai2VX4xVRmPWFII08VIA2Q00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dd8dWFueBQLT9Sb7zxlkQTFFypLzqsd9Ni+VyGmPLJOWep/Z3tDj7V1rSg7onfak3
	 amiYZ45JlLU1Q+2uFM9EzWMPt3o4WKou0k5NcSKT3sZOfitKnjZAYG2T/CmF265JYn
	 BZNdeRpzOlyr+495mJcJzfVr79kOmqoU5DEmyjoZ8VfOb1W4KjOwlzYdH8yeG7bOyR
	 qEBkrqKvjalAGRLtNRv0RrrU2hgbfPLSM2u4Q8zFvGRjUhivUe8mdZCsxHyJj9Bupk
	 t3GOCxfHVeofSTfhMZXyPtWOUjoNstdcQSS06jV6G7s9MR/iZJHsQppd6aL4kfVrWH
	 Kh9fxPuZ+LpIA==
Message-ID: <sashiko-outbox-198267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] samples: rust: remove the rust_driver_pci sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-1-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-1-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:09:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The EDU sample added later in this series covers everything
> rust_driver_pci demonstrates (device matching, BAR mapping, MMIO) and
> exercises interrupts and DMA on top, against a device every QEMU ships.
> Remove the old sample in favor of it, as requested by Danilo during
> review of the EDU series.
>=20
> Link: https://lore.kernel.org/rust-for-linux/DJEQ64V8HE19.2DMBHY4XRPMG6@k=
ernel.org
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D1

