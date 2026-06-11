Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D510785
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200885; cv=none; b=ZW8hn77fww6ShVUWZKoILZPlPLzmA/fZFMGqVOTPnNcWwvqZuaTBU319vsIDUwaQWGN2diobtvKKkUOEkJANPJejhlixpHAHSJg1fJIEUVYRLPDCk/Q7EH8b+4JNFveUhwt+M7fSbi8uJAgQQPhuAWeaEWxK6IYZsaq1C0eUbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200885; c=relaxed/simple;
	bh=+c25jnHGJMWv7saIkdGgkjW867NiEHLTSToJmZ/zoUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVViCsPuEPE96IcBMHsrRLhAJiG7Sy4FiggS5RLwC//YgM2qOg167JLeDCanVq8Vfniac2DLTr6KVbNdX8x8BqE8hfhZ9fzxcwVburs3oshqjdtaxwXHPNJlpXm0Q9E6KNlCL/Ad8hb3TDnTM4iw94aRo/V3aPKydnlfa3aeX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtNoFAyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtNoFAyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7F21F00893;
	Thu, 11 Jun 2026 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200884;
	bh=+c25jnHGJMWv7saIkdGgkjW867NiEHLTSToJmZ/zoUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DtNoFAyfU3FTXtgRAycER9b4XPn/ZKxdXWOW8jHPTPKHUcD7dg2RsAXeuqe7x8w9E
	 1SPDZjHtS3eQMwmq68+5jButKfvUXY2v34PBfUdI0a1dEwR5vDtzGm1adVdHespvoA
	 LDmBlcOVriSVKg9pDmerjHG8as1/kWKvwqYbazLkaDXwEKeTAV2WHPtsvQ40S+W4Bm
	 IpV4laEDy87EB6Hx5AvfrNlJ9GZNUTQmw9UuuR+al1V4wSUeg6E2BiFAwalaVc/Z6d
	 yIHPghTGPds7yY9pOzNkL8Zn+ubFXPYM+YkdW5bIuqFpZwlJ3vp6HYx0KhjWxJev1l
	 od5/60IRg461A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/20] rust: prelude: add
 `zerocopy{,_derive}::IntoBytes`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-12-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-12-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:01:23 +0000
Message-Id: <20260611180123.ED7F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In order to easily use `IntoBytes`, add it to the prelude.
>=20
> This adds both the trait (`zerocopy::IntoBytes`) as well as the derive
> macro (`zerocopy_derive::IntoBytes`).
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D12

