Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670720;
	b=YuMns+97w7qz/LXyW9wlG1Mq1YR+NTCjUJdEwZV3fLa0mAApfTOG89jR0PplzEARMUmV
	 pFUA77/sFdPtzfljcExPTEdBJU7UdYUdXNiioII0o2L3GlSIoot6TqrC4ZtzfgpKle+30
	 YftXo/jybkrg6yXHiAmmjHoiOAn7PvLpR5ljXZwx/Twxo7sPprpXdQkL7JlL6Qgggpgea
	 UiVWZGa6jw5czn3DaZnHogBpeURsQ37fpNwgoJA9cJd6Jbq6PTPKckvp730fHNEaitNYB
	 9Mw6CRmo05O6UWPFg6sbzCxIGgIkKF2HRP0V/j9fiSnkb98/ryHKV1c5STIITZfxF5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lQ3gpT3994LJFegQtMWuvJ3equkuJtG2n2z4BJmR2iM=;
	b=WvZR95ZES9DtgIM+irdLbcfiSxyxXo7KbdNJRmxxHCp/dVwbN1DOE4/i352h/cHa7Kjl
	 kR0cPD6KdExk4qPYyZKydbtNV2liv9+rMPxR2P8oB+0K8cLgtcsfZExAd7GWDOuPRVh4T
	 kRdc5TP/Gyj82PeC6huGRpkhlBbGmeRjt5lItufrHmCStdrxQSvl+8mAML5WgSfKtkhYH
	 xgvVxNuUVV0RdwS0eFTZfgGImMbfQG/NJAC9CNM0sn9/JV6QjIV4PqNGsXzIdr6fcGCrn
	 PWMVetCvGwoWDteReEhSHArgE3V+enmOXPEqpsjMBwPKxzFz/uP8O3kULzsZY17xzvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvyTpUrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7248606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvyTpUrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D162A1F000C0;
	Thu, 26 Nov 2026 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795670719;
	bh=lQ3gpT3994LJFegQtMWuvJ3equkuJtG2n2z4BJmR2iM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvyTpUrVBy9M0E+a5/NF24bi+BkHq6KhGjRkKR3d/8AWON8GsejjNNBVDsOBN2AeD
	 iImJT8GrKIBv55sEYOkXJYqgFjJKH575F/Opm4B7x3ss85pHJ4R5ZloED1d7pTDIjp
	 XHaZgRbvMVOTnCR9Akj1o6dt6wSsPb5TtZ1MhoXUa9YwjhTK9CjOFYa6C6k6n/K2/P
	 xCwL1hz3aAH6gYvLxdsD9MN9TiECU4QF7g+hUd3BikeL1e2wFKA/JoH6JfwTaPaIEC
	 N/w/h32OuHq3CmQUlknR2h022bq7nZmB6iB+JdpFgnJtZsMMn8GfOuZsbwKiZ+sItK
	 LmG14rtIRI9fA==
Message-ID: <sashiko-outbox-234785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 0/4] PCI: qcom: Implement shutdown() to avoid
 SMMU/NoC errors on reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:25:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 4-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-shutdown-v=
10-0-fed60d9687f2@oss.qualcomm.com
