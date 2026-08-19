Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7914432EC
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138093; cv=none; b=QOWxx7eWxbg8cY/wYt0aZVofujzlmITK77SXJzS6ZmHXKChnlMx14wtLPICxMLzwm/lfXUQvLzDmdb4keKUzi5TUpzTq6pYYgO6iNbcviDPOjxuCwA+7RvlF7KzvBBiTzyzJvdgbh8owl31/4OVmqokiBLHMyFwSO+jL3PMLQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138093; c=relaxed/simple;
	bh=pghcZz6TJqFHCteOs9c5p1tFOKLB5wDU1cRCVf2djOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bYZN6HQkQWQA/Td0yK9J41/V03VjPIE8ogj99mCmnzXm8dnrYMCyUXF+ANSe2rhtACGWXeNGsyYa9X6VqADuDuaAWe28TNBF9GISEW5zBAAkOfnvYXx+pETeMGzUjekogc5gZGToRn1uTKC4GN0KqAMr66LTtoNLBr0Lp7wTmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVGXGYkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVGXGYkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B211F000E9;
	Wed, 19 Aug 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138092;
	bh=pghcZz6TJqFHCteOs9c5p1tFOKLB5wDU1cRCVf2djOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVGXGYkqVXeA+K26lBxb9XS90S16aBEnozvdEYvYhl2ofX9PDCx3k9e99FZfDse8p
	 OqGAA9ql2zXFIM3GbVfC2sV7xblvoNsml06nYbJoF6xQQSJuIgte6GBMtPyBYnzw6s
	 LQZWBqwk+SNb3vaLVkx5UPfcG57dq2ucI5WYRdcs9IJht4uJ/50hw3fJPh0hyaTR8a
	 02cvnpS5AAtJmbmmRsbkbyVWY0FE/F5E5ewIlqrkPAhJn8Owg0qyH1wTiE29XWdQ7R
	 uwQqfmmhLCtdpy8PtYXyZhwfIbMfNqQD5ldEi/7IOaMp6cl3C/ZUsKqH0eyBhKWMFA
	 CeURvaA49q6lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/16] samples: rust: pci: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:14:51 +0000
Message-Id: <20260819111451.E6B211F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D9

