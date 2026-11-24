Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479347;
	b=rPwfqkycJYx5EJY5n3M0yF5BJ7BV/NQDJHLJ3IPUgspMrK9Ws5wRNu1KzgB338yOIhvR
	 3aDFhIBAimmBiJk4zsv2TUFeJj2Mk0SvTyjkLhUS9DSqZQeads1ZoGCv8M+WfgXUDiC3d
	 k+IejLuJsZ4YL80W6g67WQCrgJLMOSybKAHFwoHaHEMbYaYjpXbRyyG4FwPI4EQI1APhi
	 crTg+pi/kLRzRpQr/aSEIXVtSCIW+Tn8uMT9s53z3x7DCVlyjnSwfGymsAmJdr7gbFI7C
	 LFXmzriLpbk+ATuzGKHrbg8gsZ5h/9cPY7z9IdhGbJESwEo64fazP0O23G/EKKLtZVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LJ0/2qphWupBSd4xTwIIcyANm+oENiExFGCC3no/8vA=;
	b=T2sB5UwERsJB1T0x4IdPWJHXFG9KZO7dM9wLQQTSoFDLs3Qbt77ER3SSmVcdM9TtajLP
	 eu83mhBu9tlkbntEl+Vk6sO/ryTDnFDaZNcklncQQxrH9J5lV4GfCt1XbFww1KuvmxF3G
	 1ltlKhjmOGBNPHvzYWVLIadktra7IcLZ0cB/6Lx84IbTW3b3Z+faUWlYZlGNNocOiSpxT
	 D149ejtf3Y80IfqZ77uTQEpkRlzlNqPMkC2fEmpS9PfLP/TLNJuItyrsHHCHuXebF5eNy
	 HQRYb3I0+OMfcbNcI6/Wqy1FiEKPwISayDsmvIXTgFZx26AUsijdMfQFz1lt4fSU2WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9wbuiTN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F941606A322
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9wbuiTN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569B51F000CA;
	Tue, 24 Nov 2026 00:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479347;
	bh=LJ0/2qphWupBSd4xTwIIcyANm+oENiExFGCC3no/8vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9wbuiTNPRsw+3DNwoY9XvuWgoqxA+EjDv+NoF8D9IaVDYXDayWloRWJak+DnBsMB
	 8sO8Glqd6ooJM1SgQkTAhKAxGMaMu3tVG8u0pUZ9XIAXU8lYQypE8vA0lJ7RnvFOWX
	 OOSxSr8DNJhSFEzfZjEFOQdTQYXELzpACqXCmbJi0PdJ295gjYQFYvE1DTPaviQSZc
	 x/HA9o4wqadI7PXdRdoi98S+1VO7I73xyIQuMBY6r40UQogE4HAUvEpckTzHYG00vD
	 RQV8M1+NJGnj3kJp10MQ8NeXHk6Yq9IBldtGMtbuq3oU2oWnVQSUBfFXCSTTfTVThi
	 RodLNJkMU2SZw==
Message-ID: <sashiko-outbox-230248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123235845.564027-1-dmaluka@chromium.org>
References: <20261123235845.564027-1-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 00:15:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 2: no issues found.
- Patch 1 ("PCI/ACPI: Support Microsoft's "DmaProperty""): 2 potential
  issues (2 Medium)

A detailed review has been sent as a separate reply to patch 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123235845.5640=
27-1-dmaluka@chromium.org
