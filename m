Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131169;
	b=IExs9zRkByzXEi5Q9cWFH/5/gNKika1wJpWJSBcsUy6PBjbxf9iH/JJwhc+GK/YOTaYl
	 d4Q5eJ17H/184uEhwNoE0JQKFH7MoKIGmUtDuQ1oB+o/Ttd70GukkVYiCFW+ITfqdsKmn
	 GD9boXTHnV8MnJfYM2BeaHyW5LVCl/wp4ruh0nOU1eW+mKAnKSk8Z8TUd/jUy7ZQxmIRD
	 gsGHibHY2LEz34aV+bk2MKlSa3R1xouigZzYCHTuWu601gtUk1PpeV/TK7a2JOD6NXPRK
	 lQbDTFNrHpDWDeJCFqSCu7fNNXPr/Cl+ou2CgbpZslK3RnTFgd/NcTGxuLs6voXpyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W6bKswh3zjHxFLPfU4xfleSJqcwonnDkB6dWLzeZRlU=;
	b=him5fejPNdu2fi5QdXRKNFC8CbswbkW6BtDVf4WsEGUya6281dGceFjC1KQG3VBmHJGB
	 fpeTdQJVQOT6mi0Z9W29qMbZV0XWmMdMUdvYnUM9tqQ8XTGLFomFL5LUJsJsCmSWCt2bN
	 Ingl6eZyjYwpIK2sLPvZGt1+QT1d5+Qs7Q9JgfSu+RQMW+DHH7KE3CMZU1LipAECJP8Z5
	 gDyN8PiKJgSwiUGtON36ojxn3F5a+r8oA2YbFqY9qlk+cTCuXp1some9ey6KCUZKF8C8L
	 VOJ/6YoGHAv+SMXrJvXH9x/0Cz5dYam3epwupBUNHHh9UwUviyHgcsl/G00jEtPW26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLrvpT6t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F9606D811
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLrvpT6t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5456E1F008A5;
	Sun,  8 Nov 2026 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794131168;
	bh=W6bKswh3zjHxFLPfU4xfleSJqcwonnDkB6dWLzeZRlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLrvpT6tyO9PovHSycqNEnYqXqMgI1Fnc+SMOvCl18+8Rv8TEh0mF4xaJxEjgsx/c
	 FzoS/N2j5BDwK9YXerlUjCfeQHo5Eud186k8FhhtlF+vLVxEwxfWWJcAA73ElYMoZo
	 UMphOIXedXYY00LCKqf670qqiwJT89DGX1wl6xHjYcqHd6sAn/VC04or+wXbXO8yEH
	 2BXKSjEeK1cFlVVzixuViY65jRGRa/1DhkovPVwMsF7Rt0fZG2yI6xFwQjQBSaH5hT
	 aArNHKFcd78/g0WYUPPg5/3xfhUu26tDRKjI3nht0+WEbAeAOUol987MrC+SZ26rS1
	 seybI+p1o1ddA==
Message-ID: <sashiko-outbox-203668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: tegra264: Use pcie_get_link_speed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108094034.679945-4-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 09:46:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Tegra264 was added after pcie_get_link_speed() was introduced and still
> indexes pcie_link_speed[] directly.  Convert it to the helper so it does
> not depend on the array being exported and cannot go out of bounds on
> invalid speed values.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108094034.6799=
45-1-18255117159@163.com?part=3D3

