Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09E3D3337
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653408; cv=none; b=WdEqlsN3gF0c/b9cqLKE0QaEJ0FjtowDv/c1hg/8+8gxHC5jRHG4JqvgQCwJQM9fW3WS/jBahYH7dK1PCQN2fqC6eblF8AWhFYa15Z7OBVc12MyBwkjRagUYdW+drb0ErNmm7lRARej9m/5gP/TBub/jhHq+75sjI6/Lc85ISeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653408; c=relaxed/simple;
	bh=nVM5/Rmwhu+NMf7YEReFDEo7Z+8m4fFKgeWCnR+YVr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6MIUXpAiT26kusy+wlUZriKfacy+dyXbCZ/8WjA9+jELVmKHZTQKjKOYnwqp4mCvJSINdj4Y+zgrAULxhL2rtI29nq8ihmbof/Mn8RFk4As3Ljgc4/A4ZvAqIIfmT09lSa1Gf+8SgW/W0FQqn+oAeYyTDmfFd8HjSUKts8xc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWjMloHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWjMloHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBCF1F00A3A;
	Tue, 21 Jul 2026 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653406;
	bh=nVM5/Rmwhu+NMf7YEReFDEo7Z+8m4fFKgeWCnR+YVr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWjMloHutDOfzFk0Rhfi0wKA3DxbyS579XYFQiEbZlUoTiacJF2jnXDavwy0WGo7V
	 aGYPXQ0FDWKHGpXXM3lEgNoA11ew2bdZO53FsSCoQ/d0IcBo/6qfitcBwFBw1ttGRn
	 Pbwf/lsTdu6T8Te8VgiDvLXrNqfLiQei3Gh9sLVqI/nKD4obhYJK25nkJdCuJXQfMS
	 VAY2XklQp6gSu+4lKtv6xMYu6CnCYU0LVMtmdq6FDPzSQd0lia4hYnclcKThTYnhEz
	 d8YOuRYiFMTRIOwHs2sa5goKoT2GcivThDreK2fgDP/WBhzjQPyEoSdCStH1NOQ87Q
	 wFM9XpDK1kntQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] samples: rust: pci: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-4-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-4-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:03:25 +0000
Message-Id: <20260721170326.6DBCF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D4

