Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131251;
	b=QAg8I0P776M1bA4lgBi8+JwTcF9CFZnz+TqLvRsfPQK8sw1DW3klkScg2/0TufJv3R4z
	 kyfocH3ZFx/0QtAnK8NgMaQCsLBDHws9gisysTxlNFq7Q8/TROd2VFl09L51dwTbGWJCa
	 fEjoEUFOq4yO+OSOy3GLKeBNOrggN21JRyY93Vjhsfcd4zhOsSqFONpf6I6dOtLhu6Rgs
	 jyYpZgziFrbf2kiWi1qwFAWyKrJ1EFSI9XT8DP5qFoycH7Ww1FBYtqTQYnMvbT+cgh4bY
	 Ca6481JEr8LuWDdkO5Tl2ApoCRsLVu7veVblNKnArObA3d/5+I/1W52itGoYd8K7n+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131251;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u7Ak1d6JkjdXuhf73CoOYbPyuJOQD4leEhLpUs7AXQ4=;
	b=k+4fKFh+7xqJmBlJgIfK6Ug2ponT4Z7tmneQ90uFsjw+xZhRnLDYjaMQW22TKtV9xf/s
	 m4K8kYl86UZD+2cABswpMIqzq+3w1nVz0GLpvsWYBJJNjPsfhVzQbwxvB6FihuaVeEe9k
	 v/8d/fWV7Ldk4WIPlnmeQWBRElRnq1Od2HwD2ob6nS3FXtFxkdwIrv2ASNt+MqLH9U2FQ
	 2HCMl8EzJxph7wxveQwn8dQSiG3Cx8Nf3z5n1rEaViTVT6x71ZHpQ4rtRaoiV2IVqDPfm
	 j5JUurL7zB3clkoQNtHit1O5bmPJO45aeMzwa7itPETbOysl8bkEW1dd07YRTqST4fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NqPPGV/L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F6606A320
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqPPGV/L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663641F0089F;
	Sun,  8 Nov 2026 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794131250;
	bh=u7Ak1d6JkjdXuhf73CoOYbPyuJOQD4leEhLpUs7AXQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NqPPGV/LmZ6o+16gwuH9yBnlrG37L0N7o/XOoWytEuJ07avvROFMuYT+b3y0vRjkx
	 0wpVivPQidd5AmrEWAEs4oxyd4vhTUBb+KuoLmRUJp+mcvIdH8dvfhuRxwzjpXscQ+
	 q4NLxS2nbNttRN/49RrQN9Q5/ZKpftkq/5bckzIcB8T85mNWiDeQwOxX72sf/jB15Q
	 Tvn2wpEjDY+i4CoDPX28lksKndEpiaX9mFEf/Bkoe2xs8e1tL/RPQzNK34dAKQV5VO
	 bgb03KlhQsYcH2ogxNKkMWsVVbtbHP8lPHA7xunZQcuNHjwELbDc9CY3MLDITM2YUl
	 HuEPDIyWRVACQ==
Message-ID: <sashiko-outbox-203670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] PCI: Convert remaining core pcie_link_speed[]
 users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108094034.679945-3-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 09:47:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108094034.6799=
45-1-18255117159@163.com?part=3D2

