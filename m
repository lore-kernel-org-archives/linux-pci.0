Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E793AFD0A;
	Thu, 10 Sep 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024809; cv=none; b=KkZ96A4IngYbho0LDauZ2/3oHPurbFi+BZ2mTV3OdxSoZr95Ic0Lv+cz/TzSGd+xFiBKadezjbGthbkGeRJpTCGDzzGXp600R3jx1LLpJxkXV5LdnDnkcdzmSqZ3W6eJlVSy2hTjNvAb2+LK3GQE1Ot5ZKy05wAo0imbxhKeqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024809; c=relaxed/simple;
	bh=A81o5CGuRbkgAj/lFBB9K484UJGOkRgyiNZ26Wu68+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rygoYP5Df+oQAqgxukWQR9SSzoHuj81PY8ybmvi1MCUoWalxLaPvM0ppnFHOEqe0KTQHYNvrA451diNmHmBdxW5w4uCp/a5Cw3SZ1VqOf78ETdmd+RJWCabFD0n/FXHRdkNRYNM4sJv67DBn8hIKGjIIy/j2BOmt5xVtvW0sUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXS2shTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXS2shTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059941F000FF;
	Thu, 10 Sep 2026 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024804;
	bh=A81o5CGuRbkgAj/lFBB9K484UJGOkRgyiNZ26Wu68+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXS2shTV0VNth0SyoOd39+7Ls5EJaeLVWT5qJLtcG/wWob09Q6PZi+HXyMnU4Ye+g
	 6xX2juiWWIYdXG27Bs9kyPVNT3QDdDMvxZeuM7BPhdedScgcKFUO9JwYkBUkV32HBN
	 YJ+Yeuyek3eiKtkHSK9IOjREKZS0CUFyYR88rE/AK9Gf81owvLsWQAt3xsGaTwrm2G
	 MLB8KkTawwsdn5XJj+xdtA6z6LQ4bHVpJmzWRmNlPSSTOCSRKr6TUY5wnbUJOhaMQs
	 BXdjnkPFRRfjl+lsGd4bT3J6AKRFD/RH9pBhdipfTTXQA7uZIdaRcIFbwMusXOxVq9
	 S5DFZhc8XAmYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/12] PCI/CXL: Reject CXL Reset on multifunction
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-9-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:20:03 +0000
Message-Id: <20260910072004.059941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
>=20
> Reject multifunction devices and devices with enabled VFs instead of
> trying to infer reset scope from sibling state. Check both conditions on
> each invocation because VF enablement can change after reset-method
> probing. Systems that can prove a multifunction device has
> function-scoped CXL Reset can be enabled later.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D8

