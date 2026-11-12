Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494724;
	b=gC7idwFha9loCI4qGCbfxZRjC5KUkEIHZDSj50IHazvbexr0iCfjp9TTdZT4jeMH2akP
	 i4WzJX+yX1ZhAgiD5uvefv1uKGf2WLjhUZjqcZn6+vtehb874f+Lt7ycs1+GDJBwYCxEI
	 cFGMGoF7kvT/f7JDgsU4UkaFcu3Ye4REaPFV40ZiCktmtelkZHoRJOsd4kxsCklnI3hOg
	 0tcQ6w10QqgzlfZRgBJoLhB80mb7/HzMqmsgtADqVU2w9Ds0rNmaGwCkiamHDABp2AI7O
	 8lwWL/XxmhsXOSW70r4NS7GgiJX52lsG0+Jp6bFNisjszUyI85/8bDOBofZG/hpqnhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kEMvp7rL1O7eTaYfmoVUkTlDy7kXYdjWoNPtMuIJZpo=;
	b=qXw5NaRxvCD8Tr8Tys/s8R48L+djF8FZspY4AUFSDz5sDVbxLAXXwfUuPY5r2aHyT+tj
	 LDey6dLo2sOcKoLHDd/Bftw6/I1agSEsmnoWCuiF3vcK/TkFzKKtGmaaSsHc0bz4Q5hzv
	 n4Rx7m1pfSR0/Os19dKB5EZwOGbCak5cmsaB59pylEKa0L+s9nYWXf/DHUVD/L0uz3/Xs
	 r2X7w0M7vLYVexAER3QnzS6Ru5Iuo4isk2J5T8XaN3UxRvvqVpcLAblF2BWSE5Sm3mJkm
	 sQKp8Accnuckhabixai7PyigTyhW8/BLgHmWx9VANkFdfb30TBJK6UpSWkQzxpCqz2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIjgfv1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC7606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIjgfv1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC1C1F00A05;
	Thu, 12 Nov 2026 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494724;
	bh=kEMvp7rL1O7eTaYfmoVUkTlDy7kXYdjWoNPtMuIJZpo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YIjgfv1PQDoYHdfOMb0xtwUu+M4fl357FbFwNeLxjtkuNkv8lDZCDcM8obGArI7u6
	 N7zn0H/7o/ZEBRF0zR5CXzkBDPoJ3cWj9RDu9gKBNscArNded+OGLcXxV5QkIAJtpF
	 oZLJzms/WapKY6XBBwz6IJiPIxv+F0FSmO1G5LFdy2fiq3M6YE2rbJTWDMMuQ5LUR/
	 xNQhf0VcLifvZen8s5dC2S3YMI61edXsVXmCWp/D2DPK3K3G7gaKOWE9uI4tIYlMiT
	 HfDwBsI2CcdU55oPXkbthyjSF9u9QGGu/AwKo4dB3vpB4y/nYBunArex70OuXzkjgC
	 nTQQ5k6d/FuqQ==
Message-ID: <sashiko-outbox-211374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 17/20] vfio/pci: Complete recovery in resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-18-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-18-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:45:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add resume() to finish recovery and allow device access again. This also
> handles recovery that did not require a reset.
>=20
> Complete deferred D0 requests and restore PCI_COMMAND, DMA-BUF mappings
> and INTx state before installing live ops. Take igate before
> memory_lock, matching IRQ configuration, and hold both through
> restoration and live-ops installation so no deferred D0 request is
> missed.
>=20
> Use the locked PCI power helper because native PCI recovery already
> holds pci_bus_sem for reading. Leave failed devices blocked.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D17

