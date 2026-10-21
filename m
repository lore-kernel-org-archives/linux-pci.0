Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564737;
	b=2wStfud88JDGzDgN0RhlKBGLpbLodf8RifdQ3OrjZmFvOPCTrel3hHXTHCoazD16EwF4
	 Noft8nckmztpP3unJFhUE/PKZcYYXTOQrZLr9tjgXleyptQmwXk1m0DgtYLFzjtTqysJZ
	 j/CKyTk0dw2z8VeHpGOugvYsrIjt6e2wEbIDbu6CmQ58SoDCnWcNcmdUYH7m+cvZbYJkw
	 VqsszpECvNnIwuWGH/FONRfs0J33LODbyVaNN8HMiUVLfQjmAQ+qomfOyDh6+jXgAliY7
	 LJXitoZDqZV5CcMpvcxPt8/iC71NvCTXNfGjbWrrREXdjr+/bESYlxn1bpkYZ5ELTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jVorjYn1x+10unNuTREhPqIsFDfUYtophZLVLZiawG0=;
	b=ml46bIpGGo3kTd8qSXfCSzqwU5HjFZbpAS3GUQ1K8/DDiTzQ4I+qoRdcrpWd7hrvSxxG
	 NrN1U9/dRKvZ7bJXdAKLtXx2zrHb4xdj04ikCChC1zkyu+0jDPqSAGBuHL/SENzpOsIYq
	 HzKUt4Ngzi0RNXvSKhDid9feZXlVu/TDQhuBgIhjx9pYfTSWXYOBPgNpkaWsaz5x95ZYB
	 T9cvaHiC2cDYn+wtDbnRnc6FoztIG25xKCnKW6zY9vueiRXl0Mzo3tBkv6zS7TszYPe4y
	 n67JdAvn8gTTqaxVQfgPbVo3GalDY+FIAzibq7vB3b15F+POQeFz7tE8THXEMWhDlbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrNAIVXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED4606A31C
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrNAIVXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3841F000CA;
	Wed, 21 Oct 2026 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792564737;
	bh=jVorjYn1x+10unNuTREhPqIsFDfUYtophZLVLZiawG0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HrNAIVXqIjKjCvS9BFxz0GImNaKIQ/0Vu03tYGxe1YnRGKhcrMSMsRrXNiyCl/4GW
	 l3/0Fs43FidvbQVUYDY5qRbMYQLoCVRWPJD6jf1pVGN185cG8+m8V+wiJIPh6BiRqz
	 ytA54qd8ppcsDa61z82iCMtGKO7uZBbMlqj9wCnD+1bSRbUBaMDNZbM1E2GKWIbgv4
	 a4/WzVM1XohDbX6Of3vy2JRu9jdFbR8W58nc6GIWCLsTvL4QVGPzggF0iN+hryL0fp
	 zS1n0zArEElrJYLoX9w/UJhYBJDmHsQ6CNiDL2ErGKa/cbKTUqLQMJb9nZwZeJTtrU
	 v4c262AlYZoSw==
Message-ID: <sashiko-outbox-179835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: Reuse Endpoint resources after
 fundamental reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021061903.1269605-2-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
 <20261021061903.1269605-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 06:38:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A fundamental reset clears DWC Endpoint registers but does not end the
> lifetime of the bound driver. Each full cleanup/init cycle removes and
> recreates debugfs entries and, when eDMA is present, unregisters and
> reprobes the DMA controller. eDMA detection also allocates managed DMA
> linked-list memory that is retained until device detach. The
> inbound/outbound allocation bitmaps, outbound-address array and
> per-function descriptors already have allocation guards and can be
> reused.
>=20
> Track successful resource initialization in dw_pcie_ep_init_registers().
> On later calls, restore the platform-specific registers, BAR defaults,
> PTM and non-sticky registers without repeating resource setup. Keep the
> register restoration helper private and use the existing public API for
> both initial setup and reset recovery. Clear the initialization flag on
> full cleanup so a later call performs resource setup again.
>=20
> Invalidate the outbound window bitmap, address array and MSI iATU cache
> after hardware has reset the iATU. This resets software bookkeeping; it
> does not disable or unmap live hardware windows. Document that reset
> recovery requires the hardware reset and quiesced EPF activity.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021061903.1269=
605-1-mmaddireddy@nvidia.com?part=3D1

