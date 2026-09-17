Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9724B1D19
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686625; cv=none; b=VhPU4241b7D0vAstgn+Xa0eu43oUvTpA9DasZjIVTEVIXTBAE7k4C8S8WUUYwO1EqnMx1e/S/uZoWVlZbOej6Cf2k947zw+l5zoGj0iWwKGK6QpHE+ltr6rsGn53DemtnqxFzKSpdp1SL72ole2ZewQxy7bo8pvFmRQn4h9cwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686625; c=relaxed/simple;
	bh=vEHbVn6P0NrSrrY6FLsnysBEcMfSLQ4fzCyRpIT6+XU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uef5MCu1VVYuw/2Whh9kWOrA2janOoWH6sb/ShpEvJVQD5HYq7aE8nSe5OHtPt9257zHhR9P0Pxgg2Yvg1H9M4BfTjp6q2uD6IyZ33Xfgj8Ih7GGoYK+jWwXvh4hVZ8/DsaUfMSDU91AcpIg/E8rkvSFnrLRL5tkQnZbJyE3n9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UESgNYVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UESgNYVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA121F00893;
	Thu, 17 Sep 2026 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789686619;
	bh=vEHbVn6P0NrSrrY6FLsnysBEcMfSLQ4fzCyRpIT6+XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UESgNYVsB11abz2KuzQmrskSpbL13t7ApIZNidF+5mUYcniqxmwurnOaZpuZm6YAT
	 8fHl8oos4ab1i4t6HQgy+s3oSSJSzCx5zuA5bTDkcrDiTjBKcxsUBkewUclha0pjjM
	 Ay9PitQdxt9gSjPksj6r4ZqprU+Zn5HrHm3ZHt6wYNAfAULhU7k86BAgctsADg26zm
	 FzXwhcRs9TNm/X/T/oMx0i08SLGre4uEdSSAjigo4sG6mL8Hop0r3Y1kpVKh5o0zn3
	 YeRz8XkBIR+Rr4em7ivLeOLmj2n1AOr+4SgDaBG69aeIqnWWAAhj1lfkohIkGpwq/3
	 tI0my8FFUbmWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Clapinski" <mclapinski@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917230323.3701743-1-mclapinski@google.com>
References: <20260917230323.3701743-1-mclapinski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:10:18 +0000
Message-Id: <20260917231019.3EA121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> doe_statemachine_work() waits for a response by sleeping
> PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served from
> the device's local mailbox logic and typically complete within tens of
> microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> endpoint pays it once per supported feature during enumeration.
>=20
> Poll with usleep_range(20, 50) for the first ~2 ms before falling back
> to the jiffies-based wait. On an Intel Emerald Rapids system, time spent
> in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> 14.0 ms.
>=20
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230323.3701=
743-1-mclapinski@google.com?part=3D1

