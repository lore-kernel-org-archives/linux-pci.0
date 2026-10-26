Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046926;
	b=OYakJocjUKd9J/crrkCWT5IGSvTrIF7C2pEohoc95B64HsSy4i5d1vzyDIl78OH9mamK
	 ggbee5+TEMAH8q1lVechJH/RfCs5LUbHGx8nyRGZBr5qJhBQytwwDk+Dq2ZhJKSXpo1qP
	 JOEnw9JWoEve5o0iqPwQf2RY06LElaGjszjM8PMDIl39wI7Z844HQtBHuOZtt75Pe24F7
	 075T+cfjHcWct1mLi+1kDPq9O7JCIBGwA15Ao68CnmqoqraPJArXBkVXDM0W7Lpto1SGz
	 /AoDsdztuDDM7tVRX+sXnUI8ZBERKg7KdbhuT+AbQvkP4hWURl7Z+OPdZm9qWP1QD0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MhXJsoBZLIUfs8hxvl5/gXwkAuXxsGm34VbHn6O4fkU=;
	b=uXianW2pSy/zYMhG/735188jqg/0F1IkbA3Oe9wkammVetO6D9p2mu4pXjZWZ3rX+jz1
	 wP3Dbs36P3WYyeC0R+gxiU8sCV5xbpB3ja35/7RdJJLItD/c5ijm3s7CZsyTkt46kL9s5
	 0yRf0MW+2xfV6+GKsLr4S9OGgOkdYeh0a7bZTn0ayBZrBNPQ1eTAhtuTKSo+Q65rgGP19
	 bIK3temxb5tN7q91PsYipn30Pw0LTrTBEQbPAtR6uLRKcRpwgzrxEXwwaOd0Yis6/8JcT
	 PEy6WfvAsLTAOSYbIYdJUsWXGJj66erUqkUm5kS25hGFrk8U0PzeF5vuFW1Wn1KcXQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iE7uGBds;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21243606A31E
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iE7uGBds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E2D1F01825;
	Mon, 26 Oct 2026 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793046926;
	bh=MhXJsoBZLIUfs8hxvl5/gXwkAuXxsGm34VbHn6O4fkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iE7uGBdsSqBSLaaJ9Oy1QUDZx0TAjR9amA+GVeu2d6OHgz/ggBJQnM55V98K34E3E
	 3Ze/PBYl/0Y9h9wvsB9+u8XhvcCUEj/Ndlh/TivHmRPCurUqgHd9U8MluAUBEfHf3Y
	 swxYj83rEJ8h4ncsYx3w3hdpqpCi8TbkYovYpKOlbjmbAx4YsK0J3tvwwPJXc4ocb0
	 832B7b+kcSqvUmVFLDa9awW1ota2IL5WMM6q4CkcpU1eN3vkepCzC1zVMh46J2yVvi
	 RAO8GmnwAXRCypHHr0+SdbzguQDj4SfYeOlWaWCctxVCbunxF4zPNcoHWMNuZalRx1
	 24tKaPEUyoCkQ==
Message-ID: <sashiko-outbox-185731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/PM: Serialize PMCSR updates against PME handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Giuseppe Piscitelli" <ooonea@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261026202647.669817-1-ooonea@gmail.com>
References: <20261026202647.669817-1-ooonea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:35:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PME handling and native power transitions independently read and update
> PMCSR. Config access locking protects individual transactions, so a PME
> worker can read D0, another CPU can request D3hot, and the worker can wri=
te
> its stale D0 state back while acknowledging PME status. This was observed
> during normal runtime PM of an NVIDIA UCSI controller, followed by a
> D0-to-D3hot refusal message.
>=20
> Serialize native PCI-core PMCSR writers with the existing capability
> lock, releasing it before transition delays and readiness waits.
> State-only updates write zero to the RW1C PME_Status bit to preserve
> pending wakeups. Read fresh PMCSR for each PM-reset transition instead of
> keeping a stale word across the cooldown. Keep the literal-zero power-up
> write.
>=20
> Fixes: 58ff463396ad ("PCI PM: Add function for checking PME status of dev=
ices")
> Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026202647.6698=
17-1-ooonea@gmail.com?part=3D1

