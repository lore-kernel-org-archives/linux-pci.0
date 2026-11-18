Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999867;
	b=Z3+jX4Aur10pUCXspGjwsB6wykoX0fFYmwlpz8OQMsLzuFsCXst0uqIlaqoixmwjmPG/
	 WYhY4+/kV8UGCoeGfz5dCZZxPf4yHJmriSLxVFjn1lMRWL+jYql3Z3rUkvN7R1wdKbCi7
	 ihcKRc93KCFGRhiDB7BVdpGhpAh9D9d7SO8bJNvMQVlBycLeu1XnBMzibA+SVn0f+t83V
	 9H3hlhO1sdr+1YVo+5A0PGEjVmV+ovn6ErGlVef246Ke6thzpYdj7WNeHUShx5hZUZOY3
	 C77K1cdhMGHBUU9ZuNfLot45s47Qzir7w9Ut7c900lOGtja0kUofWxVtGRS5D5hPIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FR6IccvFeNzha+2SPbL0ZIoh/U0cDAzeJR+jW/l964k=;
	b=tzatKV1xqUR3J5fr+T22/B5IEthc/Up1GujDEFN3exsgsytNTdEXP5P+qonQz/JjUpOG
	 +0o/q5TdauKSKxQy9/u1P2inmHv39dI+i0Ei17Mox5e+pwxei005GQcrnqRm6xWx11HXT
	 bzYkf7H3RKYJCmyaz/sJOc/UKVe9WyYfRHxR4t82EIiEnt3PSUCcN1zDZt8jq3Y9UD5qI
	 yvGC5ihogQzRzow9LSc0lHTpupD/Qq3yveOhJfqmrshLrUR7WyQhEPDPQIsO32CUR+65r
	 YeJI5Z/7xtYwmeD8iyvjtEuBieK7fsJh+zbRdqF899M68gce62L9oIkZ3bTBJkANpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CG9p2Q5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D33606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CG9p2Q5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8121F000C4;
	Wed, 18 Nov 2026 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999866;
	bh=FR6IccvFeNzha+2SPbL0ZIoh/U0cDAzeJR+jW/l964k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CG9p2Q5jxP/6tPVPBdY6huAghccoBYrzePZuc1dk6LBps2MNBloR6L22sCCr9qhj0
	 rCceZl//WAm27G4A2fL7AdeJTDPipJHaMEIEZVrW3Mpoz+NW3NYbK4qyFpvSiimDem
	 TpagCKqHC40c80mhMyZhF08uBfatDUtJuEKWemtGC+JBi7ijtHPfYvGDisluOQPRkP
	 8yAubh1/y7inUp1rw+lCe4cvL3cZNvdN3G3btPrNc2hRco1wWLU9j4Ok5Dwe1OPwLo
	 iL6mLEpVwmJlN3tLeCezcCebzc68tLr96v4EdEw9WKSt+NukQ4fE7NWPwYAOfqX+tf
	 93zpdjw1bhb9Q==
Message-ID: <sashiko-outbox-220792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] PCI/DPC: Avoid access to non-existent AER
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:04:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
>=20
> This did not cause actual problems because in March 2018, commit
> 4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
> the BIOS") had seemingly inadvertently prevented instantiation of a DPC
> port service on AER-incapable ports.
>=20
> However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=3Ddpc-native" to allow DPC without AER control") made it
> [ ... ]
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
>=20
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=3Ddpc-native" to allow DPC=
 without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D1

