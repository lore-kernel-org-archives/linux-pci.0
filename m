Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450650;
	b=zl3NumlRIbn1e8BrFbpmi9QbReLsmTGQgYRLw1RxYX+T6gjmNvJNMYSrZFqXVLne9Hkd
	 Aun9rIsqgkSBRIB2gfKlI92X0bQM/3F7TDS9g+j85A5MQoPGxkpn0z6G1O1wAFBwfM8Dw
	 hF3i7h7s3HB1bJ8DE2MbuuhPRty/kIREn+MIlXmKIFBdAUv+FVjq0uAViTr03SkTDbdDP
	 GMLL1XAtDRz5QjVio9Cce4hWmNJGm5CS0rDY6NLNqPcfR/1/IybfLiZA2S+ECe9FGmH7y
	 JSWUWhTU72BWYmWUVcJsBpzANpOY31dCegnVsaVnxtaRLHscg3p2MluAoztCy5ebTyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jWxy8H/uCBSCZJxYMrsu2RiOKcLFAHu+tyqXLoa3+Us=;
	b=5ofrUYTxcAvy6nIVvb5OAQvaSrQa3/ETNt7ejOGe+GQF+JqBj8Qm/0lN+Xe5TArAnYMu
	 T5Cc9Zy6AEYVQaE5aWmqkKlLH/NWHnzK2ymvYiWMbzfZ2hNBenVLcEm42srvWMEhxU/PD
	 unQi5vlvmaelGDA8L6plWvENTYo+Q+5vrU1ixCb1wgnqCzYPblMobEp5dUDP9t9ySFYG6
	 Z9YWo5ouMAWJS+KdY8B/H92j6EmRGA9SHp+fdwGRgo+TggQ/x3tg/UWyX21xQ5KYoM0DS
	 Xu/omE1cWktiaeX5DStDWHgmj8j8/tVrh3iapDDu3TPHXMPX2SJZhR4hnINoVOfo5HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jiin7mHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95769606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jiin7mHk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D561F00A07;
	Thu, 12 Nov 2026 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450650;
	bh=jWxy8H/uCBSCZJxYMrsu2RiOKcLFAHu+tyqXLoa3+Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jiin7mHkBD7MPjQ/y0bcEYKiyOWlN2YivzimoRBP+1zt2iYsA3XQSKMkqP58rdad7
	 Vn15HBbvsXoLuEFSftNVcTZ/Ca2K8rjRX49+0xagzYrYIX6+7HwkjOGb1XYxBvjXBG
	 2lu+UCWQDCc1DJZGnZcDbZ6aQ/a0XwmhwKHACTY0smtlUB34jAuosi6eRdE+6eg90x
	 x5P7Q8q/+pOkTNkFA0wfPrKxL2IwlPf9Piv9dVHFa11Ott4oNo0N7PAC4gykrXDVV0
	 Z7MWGBMm1ebPQRG98qlBKMcBjWdgYy5KLnLdEepL2f/x720SiI4HsOILiC87TcNOMW
	 cbsCwNRV/bLBQ==
Message-ID: <sashiko-outbox-210198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: Convert remaining core pcie_link_speed[]
 users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112022405.1230200-3-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
 <20261112022405.1230200-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:30:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the remaining direct pcie_link_speed[] accesses in pci-sysfs.c,
> the __pcie_update_link_speed() inline helper, and pci_set_bus_speed() in
> probe.c to pcie_get_link_speed().  This includes the max_bus_speed
> lookup that was missed in v1.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112022405.1230=
200-1-18255117159@163.com?part=3D2

