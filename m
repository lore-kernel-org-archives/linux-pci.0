Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247941;
	b=Teo5DCz8+NpdY+IfnWzpjt1WprWakQKungKH1MUNZ3PzkCV57G4ye9KB7TO/3Xc40u1d
	 obX1nht983b0BrKVo0NiqIOph6Iene3nwXPdpvVmKnRL8D+mT0O4XSJxYc0zik4N7cAfa
	 SRs6HH8++gBxX4weu2VYDTrX02A3drjdvLk3UyZTrNSlWAMlq6vQldOyfHzqxoOguI3cN
	 MQ71abvF14+L1UJIX9BG8f+hM1c8ynj0RNS7ODvunJV97mBj/T6/tPyo/s+oQKuLPkGjt
	 o7K7enLGUtWKKbbWDFSrb6x5zCQOnDXi3cK4lix9kFCDwMhY9Or7qF8SqPvEDlzFdrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E8T6TK452QT1q7vURJik+GibrZi+MDmFhleSHRu4/Bk=;
	b=TBUXwLDAqTYxcMp6fO4UhH+SNkNgecKsyRLxIlvxiWlISYCCkrN1cMbee0Wp/nTmVzRJ
	 tp/d6Uw6o/LmHPtRCey2L2TxD8ykiuq7kbUfu2rx6EctKQ6K8ZD9HzlXYUPQ0svQkyzxc
	 GxO5yw2Zw5HBRa5KAxXkLdKRlvQiRHtc5AyaRFsUBlxq0KNU1dbsj/GqXP4RD1ASLb8JE
	 GZxICrqHSpSwczpFjiC81YEPGQ353l8kIh59Vd8iKsNIp/r+5raPHTH7IudDDj45P2QHU
	 5YhsLO9CjhsP/t2OeJYm6kF04AsIyPu0AaqCgpCp3+eJgau8u5BIvvqjoggj2iZWHoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2DtiWk7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9654606A31D
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2DtiWk7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6421F01825;
	Thu, 29 Oct 2026 04:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793247940;
	bh=E8T6TK452QT1q7vURJik+GibrZi+MDmFhleSHRu4/Bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2DtiWk7LR2yc3aMC0lT9rNRCb6DXXhrK4sJ6zpJVKRRc3j5vzU0R1J+rKBqXZ+rA
	 0Magzsicy1JvnzZRz4huNSCMwCIBE1V71rmw36QKFP6RKC11pt1VUXMipU66crlg+c
	 AB3o5bO/jtUD/htSojHjisCDELQH3xUOv6g0IoyL/wtst4fmlbOFr8s6+VGfWoGILc
	 BrzyUZiwsEIJGMJofwEHZyWpvEwWN3sTSwYEtkk0olbu0rA6e0bBtCusTOj61Od5RX
	 btEi7ByQa9VNypMDIh/KVhnZQipmDFL9RVUa8fxFg6sTaWEef2d4gJFmPGl9zMN8pu
	 +JQyEbfd5b6nA==
Message-ID: <sashiko-outbox-188700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-shutdown-v7-2-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
 <20261029-shutdown-v7-2-3fd7a76a6991@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:25:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
>=20
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
>=20
> Add a force parameter to dw_pcie_suspend_noirq() that callers set
> explicitly to force this behavior, still call
> pci_host_common_d3cold_possible() unconditionally, since it's also how
> pme_capable gets set, but ignore its return value and force L2 entry
> regardless when force is set.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-shutdown-v=
7-0-3fd7a76a6991@oss.qualcomm.com?part=3D2

