Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360622157B;
	Mon, 28 Sep 2026 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559959; cv=none; b=d4xR1RXjZZiaijkiQWyXwivXch1G4mjSxrD56BRw5Wmn7+8JRpkVXse6Krzj5ic3YjS+6W21O1feTFIEMwcXnpGx0Vys5ctpF4lxFtiaKnX6PtRwjhM3+JVGA6SVJ/WdQUCZdVhYmv9cycrls0CpknJR4tPD29eWjWErCVDsXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559959; c=relaxed/simple;
	bh=XVookCYRmmsXmp8bkMe/A8AoQSSb64DbZ9t1taJC+SY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6E5JRWIh/H6699/zr2g2rS40ljLShYIcyh/PvyBUs4wvUSe1K8IHwGkAoA0rqWxYim5qnFr/6YlivdSOojkbC0CYUUzRLxPL+JxIaNFRavHFwqLZVn/ZucmHg4AHqh6EHphCVNkiLLjRgM2p17LsWq3sItPa5iIlVkKkbz1pnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWNmhKeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWNmhKeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0571F000FF;
	Mon, 28 Sep 2026 01:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559958;
	bh=XVookCYRmmsXmp8bkMe/A8AoQSSb64DbZ9t1taJC+SY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWNmhKeFgzuTWskiRSqfaV0z85S0gURWlq+NaWSsXAULm5EatSIAp6i8nCRAWG5Ig
	 qIkIXuSDuVQt+/tTmNYgcRDkT5ArSA+iNlLCjey+X5kqbh9PRAKLKEIm4eSG1cZSoj
	 27kNzgY35ASdtxFoLlIzJF2by4XDD2JBh9dY2iKhhseBNo5HH9bURIIdd1Z1QrJAgu
	 6uD58/XJxbmQ8CtJNZktbyiUJ8SE6xNGCTUCtZuzPVgcyzcYsNhkiTLxSI5WN++v6s
	 7nLqvhz11fYzaQdREeSaDiQbw0F9B0GbnNHqba7Voc9Bsw46MDm8sxWz7V+8BPeWtB
	 jVFg4ufu4M0lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/22] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260928011123.450800-18-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-18-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:45:57 +0000
Message-Id: <20260928014558.1F0571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support the NEGOTIATE_ALGORITHMS SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D17

