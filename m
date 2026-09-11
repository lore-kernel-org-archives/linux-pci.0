Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF633515C7
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144480; cv=none; b=gndnai9Spl9kZB+x1D1p4v4u+TzPXDbIMuwjuWatsb51HOxPxszvSEcoNwnjTcx2tHoczeBVNMUlJoXvBN8qHrcaN+lO7eEvf1si1vMvkZbzBKV8IeoyICmnY21wR0Dwuuya3Mg6S6CU4Oo0kFSK2KuENkkqL8LeB5OZk4xY2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144480; c=relaxed/simple;
	bh=gD3jFe19iPIkW/xnOGBK3SlEGywoytsNs5pCqmKzsOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZiwjVmO9fYeC8KyU1RdDLP4vAAxvqtu2e4LH2hbdH/Xk2tTfKqWL7J6cwtb/RjYrfirjobhtGtylNK1eFGcz3JJSOSvDXVnm1z2KpZYjDAS8dTRM/j06htbhVDGyvBDmaeI33BQScQmq5Fo0oz0v8L0W11UjePuGcHmMcpw15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTwcaguJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTwcaguJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6F61F000FF;
	Fri, 11 Sep 2026 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144478;
	bh=Rgv9cCAPKQi+o94ruQ3UgbZvP+R/yNu1xWy+HX0bHxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTwcaguJZ7WJSpNTzxKeBbDXgy0lVX4+lHfgdjT7ZV+knI/iQxahMoJl7NX+V5JLK
	 KUJvOU9NxLk+j2eCEKflal2CiCqsF+B5xhfQGQDFki62wrSAGZ1XWc02/v5BnPljRd
	 SwVGOx6IjkXd0PMF56YJHmglpvyHOtXac/JmaFfvqHhhFnNSmEGHzun7Wins+jFRUI
	 VsKMCGfHoL3gphdMXP+o/I/9vee3INyMLgLFjvULT+gbltaM/iCpmCJyVhzkAnp2Z9
	 RkJWbw4EYuDRDZkG8Viuqkn+Fs+vZBarkXsXaMg/n9fK+0iXhqczHXBjEGtjepjGjb
	 +B1+6i652zVOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Align register macros with Synopsys
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260911162537.469018-2-18255117159@163.com>
References: <20260911162537.469018-1-18255117159@163.com>
 <20260911162537.469018-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:34:38 +0000
Message-Id: <20260911163438.9A6F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The DWC PCIe register and field macros are inconsistently named and
> often do not match the Synopsys DesignWare PCIe Controller Reference
> Manual.  This makes it harder to cross-reference the code with the
> documentation when debugging or maintaining the driver.
>=20
> As suggested during review, do not add an "_OFF" suffix to the Port Link
> Control register: the suffix is ambiguous (offset vs. off) and
> unnecessary.  Use PORT_LINK_CTRL, and include the register name in its
> field macros, e.g. PORT_LINK_CTRL_DLE, PORT_LINK_CTRL_FLM, and
> PORT_LINK_CTRL_LC_*.
>=20
> Align other DWC PCIe controller-internal register macros in the same
> spirit by dropping the redundant PCIE_ prefix and using the documented
> base names, such as PORT_FORCE_LINK, PORT_AFAC, PORT_LANE_SKEW,
> TIMER_CTRL_MAX_FUNC_NUM, PORT_LINK_DEBUG0/1, LINK_WIDTH_SPEED_CTRL,
> GEN3_CTRL, GEN3_EQ_CTRL, MULTI_LANE_CTRL, MISC_CONTROL_1,
> MSIX_DOORBELL, and the ATU_* registers.  Field macros are renamed
> consistently so their register association is clear.
>=20
> This improves code maintainability and eases future reference to the
> controller manual.
>=20
> No functional change intended.
>=20
> Co-developed-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Feizhou Yu <yufeizhou201@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911162537.4690=
18-1-18255117159@163.com?part=3D1

