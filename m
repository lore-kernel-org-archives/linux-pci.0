Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836552;
	b=MCMPcbnY0z+vb9UFRBstQodSO2iezpqo8Hl8OU8LVYjt3JME+aN+JIkOOu387o+NOBxt
	 53y2/CtcohMKpvhsjb18FbSx+6P60/br+vt5471tgxglrRR76vrRbyP3k2T+7kFqb1PoZ
	 sBUDh1+D1w2I0NRY7tEz6+T4eWrHpeFPsG71p6BV6nRD9pC+Qk/8ZNU/b6otaiddbYjeB
	 Wk6G8YMWF85nEpHVsSibJQb7g261/jabEe7UjMx8Zd07gm0VwlS6Qpj8ERWCWrzUCMMaT
	 obEQoR/ThVHHo0C/tI2AGocJ7IDK0pj40WGk2XrQX7Vu24aA3nD6qVX54YK519a6eYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vk7ZAT3bD8bwjF91g5YJgUgfpnbYVS62VFQox2bx7Bw=;
	b=Agj0uV/P8owa5Jt/8j9E06dA2iqyZ+6q+aNM6rVb6qSQ2DNyjAG/YcpeakvSk7Ps43Rw
	 5A/MFBWC4g063KWAdfXvZ7YNmlG7jzjiLYYGIV3LG8YvsB1Jj/AB7rlVwNGTL4XRDHnYc
	 Ars5xoB5UL4yWMzvrmAmDsi0Bi1Nn8Bd3DzlpWRQo4fh8yb9TE3IenRVw7sREzRQaD257
	 XogqrwFFDNB1WEITcSQWS6Sie/UXZurVmE36l8UuGWklITRwSpJkN+s/YWcgm7YhYZyXE
	 /x2Kc9adOPwcPV+Tzi10BZMRdzbjmtstROlT5cMv27QY18K9Wigma5cWUkRqip1v/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdvvqNVv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312B606A32E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdvvqNVv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB41F000C1;
	Wed,  4 Nov 2026 23:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836551;
	bh=Vk7ZAT3bD8bwjF91g5YJgUgfpnbYVS62VFQox2bx7Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdvvqNVvBzYNxTzZ/bPP1tMENtfwm0kcWTlRfP1o9jivpQ77AEaLKk82mhCnHdpho
	 U+FO2wk53/I7H4inb9cHtWbYRhS2GLeVmR4COvL6G4WAksrmLEAy8X9j1GTR0sHP6m
	 7gXQ5GyxW1awWyHAuvUOYYy+uCTAX/brkDzS/vPd95G1So/Il7PW3oO9WIri3+QOhO
	 6wnfruypP0Sv9BnAIgwdsitzeomVhdSYox4bIQHK/a4MkhQQbacJpND6p5F5snvYlO
	 wELLk5/BFb6j1g/Ioz2IJzYVl7Z0zm/z3uqx71DH5w0x0n1fu+SEWs9xNaQ5hx2lvi
	 z/PIC0NWly+WQ==
Message-ID: <sashiko-outbox-198321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-4-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-4-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:55:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Remove code duplication and improve readability by introducing a new
> function to setup the enhanced LTSSM mode.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D4

