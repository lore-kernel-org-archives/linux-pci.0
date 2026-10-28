Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203567;
	b=WeJxBNjA1u0OcaogZKH+susuEqyc7ebrtlqDLnK8D8MlLDR8yazgjOlqr6iqOzvNRtuG
	 1rK0yOXX+dGNeBOeibgMezj5OX56jIVt4DC3XiqJdMXQkybYa2lEZ6IhfYp+BdOedG+8l
	 s2I2lCbvQ681Klko5PW1b9vB7eVhcQVst88aPu2GtvxQAzlPVy41bupVlmeGiw4sQO4jL
	 1aMEhk0X/Om0+409RHPn5gkAPVfok6Hgn4HD6vIeeshy4galYBhmVqaHTBjJ5fj9ASczS
	 Ac+A/6axO7LFyO6aDrLEzAO+Y4PYD1/ehLq8VRCqTxTGpYUVCzdUWGMlND4PcoHEvSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Az2Iz6Il86tXJAcYauVd9wcbEFosXPkJTqTupDN+UNI=;
	b=yRmDSNDb0nSJICwAqisb3fLu0PQr85mtIAwz0VeOTeweMxw+Anrw4AnPyI70a7K02VSJ
	 dLjpwJJmXQ+Q3Nva10mo04mWEXVR9YI3v5iTyCWWs5dUvcetpi/YI0eGTJyH8qg7X9fdy
	 S7/j4WGV/zgiCtmPrMgQnZ/q+wzTKKssa40SveDMoU/a0W/IDhyS/XdpOHB3mk+V6XK7/
	 bezXhhTSDHSpDC2gWEZTtpSl+WHi7sU8WgOTkXsWIwSUKCSj0H3ErRAUxsviQu5Dco63z
	 bTD1Rc+pkYOJVE1SQkkXWMWY/y0DrTX4rgpDfg8B4Qpv5SMZLtZd8HyMvtlWDnaSfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fumvXyfW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C92606A326
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fumvXyfW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21391F01828;
	Wed, 28 Oct 2026 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203567;
	bh=Az2Iz6Il86tXJAcYauVd9wcbEFosXPkJTqTupDN+UNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fumvXyfWrLeUs3i2YSxtudFCShGh4lWSLl82eNG5ob1q2T9VFLIj9Km3ZsNVOCOuX
	 Y1WioFQsEXJxQTnrhKCt5tVSNmWq2AJgDUyS3wBOebsvu2x82isMmLizu/4PsBwJ2I
	 hetw2gb7V0RAlem6MHeSnZUwk7gV0iGghra3WrM1ccEzAoo+d78gVzfexyTD4/jU4g
	 VZQ3FOHIo/SE3ZhCESWsAMum4QiOFwEzUQ9R04u18S98BZBlRAnKyVRmkjL7IzBmVQ
	 rPePX0rbRK/ycEXTER0RUbUhC3eVLlwAXCzZJ28vKwYExSAJ6XRlfIoFmSoWtob8qM
	 0+9ixScYGh/Mw==
Message-ID: <sashiko-outbox-188114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] PCI: hv: Spread load across CPUs when selecting
 effective affinity CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028155559.138833-1-mhklinux@outlook.com>
References: <20261028155559.138833-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:06:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> In a system with multiple devices with the same configuration (such as
> NVMe controllers), the affinity masks are the same for all such devices.
> Linux typicaly must select a single CPU from each mask to be the effective
> affinity. If a fixed algorithm is used, such as picking the first CPU
> in the mask, interrupts from multiple devices are assigned to the same
> CPUs, while other CPUs are not assigned any interrupts, producing an
> interrupt load imbalance.
>=20
> On x86, the "APIC" IRQ chip avoids this problem by spreading the
> interrupts across the CPUs in an affinity mask. It tracks the number
> of IRQs assigned to each CPU, and chooses the CPU in the mask that
> has the fewest assignments. Because Hyper-V vPCI device IRQs eventually
> parent to APIC, the spreading done by APIC accrues to Hyper-V vPCI
> devices, so all is good in x86 systems.
>=20
> [ ... ]
> IRQ chip (GICv3) to actually set that single CPU as the effective
> affinity in the virtual GICv3 hardware. As a result, IRQs are spread
> across CPUs like on x86 and interrupt load imbalances are avoided.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028155559.1388=
33-1-mhklinux@outlook.com?part=3D1

