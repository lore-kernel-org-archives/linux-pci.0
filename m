Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D4191F91;
	Sun, 19 Jul 2026 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784422667; cv=none; b=CJRexJlMM1pHQziuMScJU4oLhfyhDkn+vhXy/2zb0JD7KTP/+UlLToEz/6uJjXDlj0hb8TCj19wVf8uSkUlBi+gpm90reONP15SA99TaFXK9eYq1LKq96KqDCP+e9AT374reSv09M26OnMup26aqMaHM2DL6myR7u5Xqx8aQTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784422667; c=relaxed/simple;
	bh=NQ8Y6HxS0zfUsirZlRVgVNl/V+KwLwqFfyb13Eh7COw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uMMERoxI2HhavdrvJima+2vnG2VSrVnOdy22X4cmacWpvWk999kkp9BBzhm/CcuT0nseRRUXjAzaUMypfJlwC6pTAy8A1ykWTbJlMzekJtnRyVd/ppBTCvXGvrqD8yoNMqoBijvXxfMGYgOYYZRhhP5F95Jd95KId9wBgqfVtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjUDdFzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjUDdFzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C271F00A3D;
	Sun, 19 Jul 2026 00:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784422666;
	bh=Z+0D008WLzyCuLqsm2yqdnQFbPI+/XeqXTrxuvEAdAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjUDdFzQpsiUQm1nexD92FS1O+jr/Yx7wsDSeEV4OZgerXRY1pHMzkMTMoIRiNk0N
	 q3npfwwcij0rkd1HyQ/Wt3S0drPtcLHah9ltx2mtKKt5qu63pUc2hZLxXRcoI+miQ8
	 n5/dJ4PKCYSCWUMto3Kj9btfbyeyu80LmhnuJFfIGZdO5wPnRhzx0Q9qLSOnTCbX//
	 YoWIc5ZmUPJbSDHodtXotjF8cMrCnV7sasOm9s1qYbXSrPI1+VMn3WX/vAet/QTiDs
	 mXU/kHRfONF3iXxcGQiAu4H2Q0jZ5Qu4JgBpkOJZpaUJrx2s2ODy9abzvak+IoCgfJ
	 eZi21Q6SApQCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Gorlas" <michal.gorlas@9elements.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
References: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 00:57:45 +0000
Message-Id: <20260719005746.31C271F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing state restoration on resume: The patch disables ASPM L1 ca=
pability during probe for platforms lacking CLKREQ#, but fails to re-apply =
this hardware configuration during resume for platforms with the `IMX_PCIE_=
FLAG_BROKEN_SUSPEND` flag (e.g., IMX6Q).
--

--- Patch [1]: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is suppor=
ted ---
commit 35b1dac6afa595d56fd03bd1c31c2ca679682abe
Author: Michal Gorlas <michal.gorlas@9elements.com>

PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms"), ASPM states are force enabled
on all devicetree platforms. This causes PCI devices on some iMX SoCs
to enter L1 even though CLKREQ# is not supported, causing devices to
never wake up. This patch disables the L1 capability in the LINKCAP
register if supports-clkreq is not set in the DT explicitly.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..7471501fbf043 100644
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

[Severity: High]
For platforms with the IMX_PCIE_FLAG_BROKEN_SUSPEND flag (such as IMX6Q),
imx_pcie_resume_noirq() bypasses dw_pcie_resume_noirq() (which normally cal=
ls
imx_pcie_host_init()). Instead, it directly calls dw_pcie_setup_rc():

drivers/pci/controller/dwc/pci-imx6.c:imx_pcie_resume_noirq() {
    ...
	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
        ...
		/*
		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
		 * root complex. This is why we have to setup the rc again and
		 * why we have to restore the MSI register.
		 */
		ret =3D dw_pcie_setup_rc(&imx_pcie->pci->pp);
		if (ret)
			return ret;
    ...
}

Because the root complex is powered down during suspend, its configuration
registers revert to hardware defaults.

Will this allow ASPM L1 to be re-enabled on resume, potentially causing a
device hang?

>  	return 0;
> =20
>  err_phy_off:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-l1-conditi=
onal-imx-v1-1-a55a57915c68@9elements.com?part=3D1
