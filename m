Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B73438B0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197780; cv=none; b=pvdu2WolE/MpfEBKityS5cbBCF3VHMQ1y0UW8u+5yq//zS5j1SwuziBBs2zCkTZwwL+LXFeudOfiMLLFslgw9q6VAu3Zgx84bu6um/34QMW8vY+9Ni/3DBjQl8lp/tu4pnP4GN+jh5eM5ZAkndLaPF1xslBgNDmaArJSB4VFd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197780; c=relaxed/simple;
	bh=9ObG/C2jHxFXvOZipr6AadZf8SnH6BgQuUqU375lc1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eud6CLOJLI/WH0YLYfVcP8KV5DYtgwl+BxU4rolGf7pico1xVM8r9kYi5yZlSsbHlXExzAPvNyCu2F4IHuTrMgjTieqUOdqZ6XR1YUkn/hetNn3pLDQgBpe09O0ljOiiEGIxNR7Nigxzz0457ZmsI4bCwE2EsSFUPsOUqSFF/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6hb5Akj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6hb5Akj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9DB1F00893;
	Thu, 11 Jun 2026 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197779;
	bh=9ObG/C2jHxFXvOZipr6AadZf8SnH6BgQuUqU375lc1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6hb5Akj09yoM3oqFKqnv+R1GxYpYt/BJRjgU68d5sv3LxIsgBc31YO3JeY3QeCp/
	 7PLDfn/BL6/4AUNJx5Z8aGTlHLGe1HqnnQIXjI41BDXS260C6VBV915sM/B6zmjGsB
	 cR2qvWZXDCWnLrsungdVBrxoWsBeXl6zjpGMOY0rqpy9SsA0W9kQHauk5JDQGpwt+G
	 LK/G3Vm3+tcvcRFlcDygaoa0KICqKAx5jhnqIwyTaKt1OG7wc5hn/RD4zNOD6nE7X5
	 AxYPLjOcoBepxe2v8mS0H8mj9hRQdNsjzqRDR5jkC2Y4mv2ycoWaa/a98LFUtH1JzC
	 vgHhXG/LU8NgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: cadence: Add HPA architecture flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260611165933.20071-2-18255117159@163.com>
References: <20260611165933.20071-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:09:38 +0000
Message-Id: <20260611170939.1F9DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a boolean flag 'is_hpa' to the cdns_pcie structure to indicate
> that the controller is part of a Heterogeneous Processor Architecture
> (HPA) system. This flag will be used by subsequent patches to handle
> HPA-specific register layouts and behaviors.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611165933.2007=
1-1-18255117159@163.com?part=3D1

