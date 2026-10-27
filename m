Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079154;
	b=nSXt906MHnZCV+HPXHSV9xERQAaiBkQ82+Dt+TJD0wYKBNIc5pBSuxX0h+beHasc61KL
	 cL0KZOdoQWjH+abKAwl1D/4jvK1hbus2u9OkJhrzlZWb7jr5vk7xrFakiuhi8+RrYKvP8
	 7JiaSge3auWuURBbAN00I+H9yHlKmuImgz5DPmWATZPWNuZp0jydjyi8QTNVBIlLYdlTJ
	 9gN1gT2iZf0IkuevL5fURNv9+ARBN8CSQNq/7N9ZQ+8wse/6uDV8h6z+jDV+BNBEkpHBW
	 ioBwlRHn2GVbOgJPUPHNAxgsG7ENG6KUGjLXPtyqAm2undqyNNWyGn6J887tm/2pJrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=de6SP+kbdgIzJNnr02+RYKSjV+naWw1wroyj6Q015A8=;
	b=KGzVJsR8J4pJu+UBIf+OhNHBtGn4IYo2fUfnlCp6qX+58spdRG3uDciYPCmzv4tmQH1U
	 zileArPH7tFrGzw+QbkhjdN75dI8n4MJbQ5GSeRY+lO6WDQxeWGXK4adAIypqhDx0TVzy
	 pCuFGy+IlUj6OW2i930cRko70cgFGT6sRyNKwuOR7Yj3zYGFGH10kxe1biB+njNUGrJg2
	 LvL7FLXGcPHliJ6Ai3aOJ1lXMtH0FtpFMS0eVAhpzzbdQ1KovQJhQHGkQBRMZnsX4R+hd
	 EmVLJnk5y7UwoMxbOJv2/Y6dyjvZnciE/ONgoXPy4NzXT762Vod3dZKYwDVQPfR3rHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgyQiLAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA804606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgyQiLAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC1E1F01825;
	Tue, 27 Oct 2026 05:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079153;
	bh=de6SP+kbdgIzJNnr02+RYKSjV+naWw1wroyj6Q015A8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GgyQiLAI6B6Z8kP50FaUIJsS3N/2pp3jVkUvDqJrhQXigYra2fk+0pVN+YKsiuMMc
	 CvZ+zuyPmwskORDsvtwYRHMHabDzhkbUcwAijpRtaHwaw9OWbwHmsZ3keiKjlVUlDO
	 0eS/UjpTUonLwCponk4qW8n/3w616cJ25Yle7RL3G0YkuhARkyjadRV0vFi6YZlPgz
	 0Tf6AKX8oArXQNbU3SlPUBk6h2riIQwwYNdtzZvsUQo0hot7wS+2bXJj1VN3aeopl/
	 cYwBiJ9tQKABvjIFiWgm8OLoOxfNT8+8V/lE6l0WmBmHs0aVqwUoHE7siGQugmiJuj
	 4gv5FhuI2ctUA==
Message-ID: <sashiko-outbox-186119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/23] virt: coco: change tsm_register() to use a
 const struct
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-2-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:32:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> The tsm_register() function takes a struct pci_tsm_ops *ops argument.
> This eventually is stored in struct tsm_dev as a const, so we should
> just change the tsm_register() register function argument to be a const.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D1

