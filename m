Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27930C60F;
	Fri, 31 Jul 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506091; cv=none; b=IBcANmlKfAqN0sf2ew9HITAFkaEj9WKia4lL9mbBhd+DIivFmolDuSSlwlE5b+xX/o3EdqTeKWXpWTh7kd4VRN/Q5a+r0pSJ1eCq7clC21OKi3picApoduiTkrJQ5KRT74hx71zo+Neif37qqrTsuq6P/U7yU4RA0P62MnoMJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506091; c=relaxed/simple;
	bh=igOgdqH13xbmDt6z3wbYSgUSPc3rXRUKpKV4vW1FRag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNW+4lf+VLSX6oGkxhNLANxR/wAMbr3KjSb/Fy++4NlM2xcVi88NYHf5HdZ8M/PaTrT36hlkuGpBiY4gelSUQ1zF7Wp4kGVhMZj2GjculAu9A//UhoBVsDUKb8QYrra5R6VCXU7rCTXWy2OXcT1DWhTp1omhq9GkE3dv+XtJRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeOtSHVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeOtSHVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B51F00A3A;
	Fri, 31 Jul 2026 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506089;
	bh=1ou3SE9h2uq0colfS48NXP1RZRwU5DtHH6TqX0zOlBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LeOtSHVUClga111I7sggRAmdnEqTzjzhiWiQ3LDovZ2hb2vHLeLtdjVEzoDaX3ght
	 Bj/KMa0fxleO7PU890DFPVjVe+6McB2oIMhV6w5ZtpqmTb3x4G73+TwZ/f7p1UfJLN
	 CtObDG6+5lZOtzXoUwyio7vEJuN+xETZALwJ6PpqUVacxmdJ+3HWOvG2QXQ8qAXBZX
	 sTAxBbe/gKqFmwF+fqQDpASEEAS9nuvVoqjtke6M/MPAK8TvkrABXqdWH9EqdttEjM
	 id5UvjbEKhFtcJVc4J/+PgvLDs7oT10TR4SYIZ+jNtPnenymg8NLhVrf3S89+d8jM9
	 ukXaq4MvOGjFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Gorlas" <michal.gorlas@9elements.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260731-l1-conditional-imx-v2-1-6016ee9148b2@9elements.com>
References: <20260731-l1-conditional-imx-v2-1-6016ee9148b2@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:54:49 +0000
Message-Id: <20260731135449.7A3B51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ASPM L1 is conditionally disabled at boot but unconditionally di=
sabled upon resume, causing state inconsistency across power cycles.
--

--- Patch [1]: [PATCH v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is sup=
ported ---
commit 7a899eb7e9f8116a0334832c7490e52f71ae751c
Author: Michal Gorlas <michal.gorlas@9elements.com>

PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported

This commit conditionally disables ASPM L1 capabilities in the LNKCAP
register if supports-clkreq is not set in the device tree. It also disables
L1 during resume for platforms advertising IMX_PCIE_FLAG_BROKEN_SUSPEND.

Link: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-a55a57915c6=
8@9elements.com

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..1fdcbcd2422e5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> =20
>  	imx_setup_phy_mpll(imx_pcie);
> =20
> +	if (!imx_pcie->supports_clkreq)
> +		imx_pcie_disable_l1(pci);
> +
>  	return 0;
> =20
>  err_phy_off:
[ ... ]
> @@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  			return ret;
>  		imx_pcie_deassert_core_reset(imx_pcie);
>  		imx_pcie_assert_perst(imx_pcie, false);
> +		imx_pcie_disable_l1(imx_pcie->pci);

[Severity: Medium]
Will this cause an inconsistent ASPM L1 state across power cycles?

During boot in imx_pcie_host_init(), imx_pcie_disable_l1() is only called if
imx_pcie->supports_clkreq is false. However, during resume here in
imx_pcie_resume_noirq(), the L1 capability is disabled unconditionally for
platforms with IMX_PCIE_FLAG_BROKEN_SUSPEND.

If a platform has supports_clkreq set to true, it would retain the L1
capability at boot, but lose it unconditionally after a suspend/resume cycl=
e.

Modifying the read-only Link Capabilities asymmetrically across power cycles
can confuse the OS ASPM subsystem, which caches LNKCAP during enumeration.
Should this also check for !imx_pcie->supports_clkreq before disabling L1
during resume?

> =20
>  		/*
>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-l1-conditi=
onal-imx-v2-1-6016ee9148b2@9elements.com?part=3D1
