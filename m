Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380875;
	b=JMjMMvXSBXlkKiFnEILfWgeVt4IB5L/HZePTuw0REyIN0tOef3wCxsVudibHL1UXK5EE
	 hjniNo//tLDEgiXKezRIqQ9MFHBcjso8sSy6F7t4HQ9Kuq1UBHPWfFwvHbZkvoCY+S2AQ
	 /oinPRRZ3+XSMFoAXv0UgDPacxoWrhJ7kMF6brP4ZRvL6SDGGuJpcrQrksF0jCW7Qy3vn
	 wCzKBSGmUCXa2Oc7BjflePkDvL5k/BdrnmOsBaW2i8eQnuOBbchjrnVe9noLCQFv6lhJZ
	 se+MzEp+4HGr+0PcXNh7/G3gL2cA+6Yv2x0kRqMjj93GgyFzmfPJg5TJQayQjELnFdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tSjYtagDGZf90fTfsum8acP8Ymsgz4wsxQboW18GK+Y=;
	b=xtxKlyktCc0CP2Ry4yrkW+P6Ky9gEV13KxXXXYhsaM2vxmRvF70V7T1UedFUhqtZ0/Q4
	 vJucze8G0JZO5BeYn5EaUjm8au0XoXz9uxodpmbmKNGMFAtypkLSxmrqsQXnQjYTQg3ls
	 DZ1WhJN0JBAFRCeGWWkou7CMmzpS2shsLnDqrtK3GM+kI4tAGTpCokcVKkrHHYqL4HOjA
	 V4218SFFet8OzElvY4bduEhNLisJbN9XspE7xfCkJ503CtCHVnMECUW68hz4zUVSHWbDW
	 e1mwDYBxhrsDywDE6e7pTwNUmKbgV2bnXfe9M7TOrQZYoeztDEYHHiV0+oUYqxXdG6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifTq4Kc0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E407606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifTq4Kc0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDA11F0093A;
	Fri, 30 Oct 2026 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380874;
	bh=tSjYtagDGZf90fTfsum8acP8Ymsgz4wsxQboW18GK+Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ifTq4Kc0nl2Yfhdjl2Lp1SkdjglEqopyQmFxROAv4zPTOEHDOjK9lKU5H9NCnKFBl
	 kmSmePNrOMxG9drMZWGjmbqujLdKgHPEsQpgnLN4ut67yj4yOQeQYb+4BM73HnJkkK
	 MOh2yxMBB9lD4LjKXo3ghkvRTPx4cWhOu3mdsMG55BhibG9d0JareP3du6aRfGWuKT
	 sm8gU6S6eyWYnPP4e69S2Heua9OG8i0ikdOf5NawaqcUOm2fNRKtG+FdUMyl8KkWg+
	 I38M+eoSHj8ndikce6QFeC2T/FsP7fy1K8vVaM0IF7n5lmlAOw4541V1BLi4x8HuYj
	 2NVN5a8mfB43A==
Message-ID: <sashiko-outbox-191328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] rust: pci: add is_virtfn(), to check for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-4-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-4-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:21:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: John Hubbard <jhubbard@nvidia.com>
>=20
> Add a method to check if a PCI device is a Virtual Function (VF) created
> through Single Root I/O Virtualization (SR-IOV).
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D3

