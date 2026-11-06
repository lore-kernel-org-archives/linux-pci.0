Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931393;
	b=eYjJA3GTp28KSpo9/mpuYJjUqfqSHCl9vT/vs2TnJstmvItPDO2dRl4e+gaaCfDcg5gv
	 yOE1FrLo3PQ/0ht43K0HxKaCq9kabXQi41GSicPGQTNAym6IyS4a/AX8zEprQCl0FII75
	 xrs9/rNMUx5dRISIeHHPiAgWAxNiRLAUW4//qPAexW8ZhLcWph55nmp2am0ODDySgKpEV
	 zNVRc96I6S7lUQ/iJxbvD+HkbYPCRqZKqqwG8BS/o9jIlXPW3uySsVHHhtPllstX+v+8X
	 uOR1ro/biLengl2N5Z7x2d7e1GQG3eBqBR599a2w9pmMy5MuhN5FV69xJdY9GXhdmRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jUVNPtp2TC5RqYdg+1QJMoJe30qGJp1ZRf6iXM4h3mQ=;
	b=BVBNm2DokH1F+Ed64vORBxcPvtY+CY/bNgUH+0r5Vb/ppYoIJvAUMd6gHJuTbUP1zYJ5
	 euFrSqHIsoJxpDUjaR9JSuY6S/DNI3u8cNdp8WgE2/8moX3n6SoIhji8lEJL0YD5gfsTR
	 /qiWsX6Boud4mnGCDwzSa/hyKnhGi/T5tsNdZbGnJsLvlcw0mA/YcD8nTbjyRNGdRPc8l
	 whqrJI2XaCiOxJWATndhokGNqs/b8dE/RsWUeGj5v5U5GWX/OoyK18cBeu2ZHsmzk3kHZ
	 Ny6cB2pWIoObn7/xuzTDjlqVOZkxDx6ZrjNz/92z4f105Wi+OTzvz48Ws226CzB93DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ88tiJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB88606A31B
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQ88tiJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624E81F0089F;
	Fri,  6 Nov 2026 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931392;
	bh=jUVNPtp2TC5RqYdg+1QJMoJe30qGJp1ZRf6iXM4h3mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jQ88tiJoGrl4/WalWxbhi4yzG8xOQEeXRip8amCWh0ph5uSqIaMg3W0dOp2Zos9G5
	 UTza52PuRXqMktrFacw4mX9Ie+/SYZJMKuriA7yc30QxXA/9c5jJ578+zZxTEE6/UQ
	 x/jWcXpgaZqpQ8vqA712Wm40qr9O2BZgVpsEsS2Iyw1/OK/G8AQC8scYuBFr5XVEsT
	 cB7h6yu/xDKhUScyLedb6jt90yfOBFEPr9O2W//dW9BYZxgrD98AxaLF6kDaghnL5U
	 SW3KRU+b4Xcdx2mYOJcaTWQy3UslZwV2hIWAn9coPg+m8ZOD5loMXISzu3tow/I957
	 WWc7u+piNCQ/Q==
Message-ID: <sashiko-outbox-200585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: spacemit: Ignore PERST# input in RC mode on K1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106-spacemit-k1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com>
References: <20261106-spacemit-k1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:16:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In RC mode, the K1 PERST# pad input also affects the local controller.
> Without PCIE_IGNORE_PERSTN set, asserting PERST# to reset the endpoint
> also resets the RC, losing previously programmed register values,
> including the vendor and device IDs.
>=20
> Set PCIE_IGNORE_PERSTN during RC initialization to prevent this
> feedback. Set it before the first DBI access, since PERST# may already
> be low when initialization starts, causing the access to hang.
>=20
> Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
> Reported-by: Bruno Banelli <bbanelli@gmail.com>
> Link: https://lore.kernel.org/all/20260825052249.66921-1-bbanelli@gmail.c=
om/
> Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-spacemit-k=
1-pcie-fix-v2-1-6d74563b01d5@linux.spacemit.com?part=3D1

