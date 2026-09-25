Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB43A1E8C
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343405; cv=none; b=CmQYBtdG8b34I7+1H5VZTLf2MoaGTyxiPmXamZTZS0CLpX6m25cBe5XOZyr95E05EHsaFn8nau0fJL/wO3iWz7LhZbVpiWuOKL/ULWKmJLItbMznvUhopTEdLfEASJILfe6Gwr8sF30DPeM6/SbptOkpzG/97FDg2E81wwLeU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343405; c=relaxed/simple;
	bh=S1LRFCWaMYr6F3Ct7FaTSIQggp4dPJ7T6QlE5UsYWl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kn1cc+fF+FVXC351pkf2FV1qED1JxN4CewXp2PhTTZx/6vIzzU9fbjHt3ALBzJik/Tf5r8ofb+iLHv4NBul6lwn1o47++AIHpWzA2fXAOM7/52q3ScyO6NiA9+51+VKIT93lQI1Ef45A9Dmr+KmEqBF6mexRQYqG7HxNyYSmjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWkA3JZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWkA3JZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA931F000FF;
	Fri, 25 Sep 2026 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790343403;
	bh=S1LRFCWaMYr6F3Ct7FaTSIQggp4dPJ7T6QlE5UsYWl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWkA3JZdK2TZUkzPq8q5uu6kyzfyK08iESvAbKZsZErLCUZke2urUfvclvzjG8meL
	 hkE43rX2qLBtdZ0SHeANoyozpx0M8MklgOlVwuQKhGSexa6s/jptYlhz5s2iJE5lg1
	 kZl5eKHF6Js5y0Xwji9hIVLm1XPdN4IFqV7vA4z3almLRVwoud7KAETGw/kZ1WPogm
	 BcFPi/KRlCQJ9qzapZX2F86fTtw/4B3wY4RThoIS6LrAcaL2QdUQ/Cr0qgLERAnX4M
	 Fv6BaO04HKpAiOAjyaNoMhFxL9n/U4Eu5CAF55FW3+CoYdDH+Imed3d28XYlo8It19
	 QYNC+qvfOeQ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: pci_endpoint: skip when the test device is
 absent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eva Kurchatova" <eva.kurchatova@virtuozzo.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260925133141.3634476-1-eva.kurchatova@virtuozzo.com>
References: <20260925133141.3634476-1-eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:36:43 +0000
Message-Id: <20260925133643.7FA931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Every fixture opens /dev/pci-endpoint-test.0 and asserts on the result,
> so on a machine that has no PCI endpoint test device all 17 cases fail
> in fixture setup rather than reporting that the hardware is not there.
>=20
> Check for the device once before handing over to the harness. Doing it
> there rather than in each of the four fixtures keeps it to a single skip,
> and leaves the fixtures to fail as before on an open that goes wrong for
> any other reason, which is not something to skip over.
>=20
> The harness parses its own arguments inside test_harness_run(), so only
> the plain invocation, the one kselftest makes, turns into a skip, -l and
> -h keep working on a machine without the device.
>=20
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925133141.3634=
476-1-eva.kurchatova@virtuozzo.com?part=3D1

