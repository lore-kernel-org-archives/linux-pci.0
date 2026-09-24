Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9E47ACD6;
	Thu, 24 Sep 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262627; cv=none; b=XokNVTaplLUdOzVfQW+q3JC+9sBjjxMB18BpaZw1uaRgbsQJBmrznKQPxDMBwCZGBPc9LCQSMS9vCGzK5an5ogGuLZ3xqdsQyOA9T3E5ei4/S4p5lDVNOa1ljg0NdCe+D56dOCqath+suFyWyx94c3k1V70bQZJAx514WJsb4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262627; c=relaxed/simple;
	bh=XnH/W2lxwYrAwPzJzjgtkiEcYjqDVzzLurQTDKunvqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VW1jtwer/w5hYvKsaovEz1ruyUzPmhOj9WLSWWt5SkNEI5AqAAuBso23L6UOrOWI7IHOMxp9O/wZ/FwrB9l/aS80gfhuiAhGGwEzNWZa8VOCBJOsLN65z0Z7eMT6qF/eaL1MDZ6ssfbEJSP/tlWHIdnO0xbeqf55ZCCk09L7VMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/ZLIPHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/ZLIPHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5CE1F00893;
	Thu, 24 Sep 2026 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262625;
	bh=XnH/W2lxwYrAwPzJzjgtkiEcYjqDVzzLurQTDKunvqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/ZLIPHsJJ/VInVkMu/lxAD5eFHqjtTbc6SzmkLAfLeS+BseoJ6br/3Rc85p8qvar
	 ru9LGtCeqF2hYDDKQSutcwPQ2y1wPBjTJ6HgEqWVOlzbVPxj6T8QHEeWebzE7FZPte
	 K40fqEqnxXDr05xX60Vd3+NncN4kBYQaw4V4TcHqSNbEckFqeRqPwlwLW00JXB0Ufu
	 Xu8VmORGGI7nmSuhC4XMvd9k0+c9GjsuJpPRUbeCc8/DVRf8Jvkyp2pIV1AOWBYWeN
	 0duU7uk9UF7UyhskN1V/HhS0rP3xp2bBr0Utj7vUhpQlXs2Jm0HnlgXbZ8kWjJIvFM
	 r1DNfoDTsyOEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] PCI: of: avoid allocations in
 of_pci_prop_compatible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260924150222.1179235-2-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
 <20260924150222.1179235-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:10:25 +0000
Message-Id: <20260924151025.9A5CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Three compatible strings are formatted in of_pci_prop_compatible().
> Their sizes are known in advance, and the largest is 16 bytes.
>=20
> Rather than dynamically allocating the space for those strings, just
> set aside a buffer on the stack large enough to hold all three.
>=20
> This avoids a problem that Sashiko pointed out, where an allocation
> failure would cause subsequent crash because strlen() is called
> unconditionally in of_changeset_add_prop_string_array().
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834=
622054cdf@riscstar.com
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924150222.1179=
235-1-elder@riscstar.com?part=3D1

