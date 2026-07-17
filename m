Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145631AAA3;
	Fri, 17 Jul 2026 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259712; cv=none; b=fWmrXUcp0mrky0+SOTNr8SN+Fc/T0qNRWwJAMI4lc3vMIFQKXbA6KKmRlKmoOI9qhn4X4sngroCVKzpt8RQyDaIG4DQM+bD3A/sZQ9l+IrvDTzoFItg0qF8e3JpRNmp1oWzsXJfdfVju/C07xOdAQuQG4C936AvhBqQ1SbNKp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259712; c=relaxed/simple;
	bh=ETALU7ph05ykwHPzecIXWUaJH10QWzo8nD69Vt5jP8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAYF8/6n1yoXj3qb5/FeksJWER51jY2/SaIhf8lad2/XYl5HjYpmpNE+HbF3uV6FPqA8X3F0BLydO9vZBHRaOPaYxIwzfNZVeJeLajw8oos91B4oFOp+Un3MT1lePdTaEgGjEpExEPKTnJvk9rwhrIigGdFHEChUhsA2U43LhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMfRHPCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMfRHPCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9C1F000E9;
	Fri, 17 Jul 2026 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784259711;
	bh=ETALU7ph05ykwHPzecIXWUaJH10QWzo8nD69Vt5jP8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMfRHPCNtA24jGiQIFPXmd1y3SSiIl2bSlOzpoknwOGVoEgQP9xi9v8OyjXDf1BT4
	 Gyp/VUmhAgZf6qb5giGsZDWM3O2x+btgvRWHxUD8vaEpPopts76xQNu5ycOGWnyhlF
	 Zz+PqiDgj8+aCdzaRDDdJt4zlgGA783V9J4D9yw5TctRAGDRx6adwqP3dp77lWbnh4
	 JjqRt+eniG5hThcXAtRMimm3CefU+l9oBPHbO+TlaSx9cOA0R3UmrFFztX6/S3lNwB
	 mov66M+8lNYFlv1a6FtvMzutmamgEOyXxBV+kAdEhi9Kuc8Rp8NBCHfG3b8eZvl4h9
	 iN7qLgcccPSGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Keep i.MX6Q Root Port MSI capability with
 iMSI-RX to work around hardware bug
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
References: <20260717033203.2965045-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 03:41:50 +0000
Message-Id: <20260717034150.B2E9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Soeren Moch <smoch@web.de>
>=20
> On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities blocks
> MSIs originating from Endpoints from reaching the iMSI-RX controller.
>=20
> To address this hardware bug, commit 3a4e8302e72f ("PCI: imx6: Keep Root
> Port MSI capability with iMSI-RX to work around hardware bug") preserves
> Root Port MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ
> when iMSI-RX is in use.
>=20
> The same applies to i.MX6Q, i.MX6QP and i.MX6SX. So preserve Root Port
> MSI/MSI-X Capabilities there as well.
>=20
> Note that preserving these Capabilities means Root Port-originated MSIs
> such as AER and PME won't be received due to separate hardware limitation=
s.
> Users may need to use workarounds such as passing the 'pcie_pme=3Dnomsi'
> command-line parameter.
>=20
> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port=
 if iMSI-RX is used as MSI controller")
> Cc: <stable@vger.kernel.org> # 7.0+
> Signed-off-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717033203.2965=
045-1-hongxing.zhu@oss.nxp.com?part=3D1

