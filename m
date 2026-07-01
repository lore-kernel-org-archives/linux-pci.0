Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FF3BBFD0
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892100; cv=none; b=GqrPuQEdO4icxN5BdC0bqfHma6eA0rcVOghMowMLUbpWlyfs2wnH0znCb5CvGKlOWMIasX7lSPMbZ44+Rveu2sd0da5okPGP/2tH+S9Ud+fDrxy7m4Wae1QyLW3Rc/PGgaZ/+JHUxXtUlMnRD1WBuVYHwcWOwHxD8BSxi2BZRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892100; c=relaxed/simple;
	bh=JM2fpmL6eiAlMozQlG8e27376Z8tgdIQ5tOO668CyqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l5G/FBP6M0MZjdbkn1Oto+DVIg9C8IYxB1yfDkr/HbAHpgNx7lxD5q5mQyqFbcSmzkfTBx80k40XzWmwOGu6OWR1CJPJt4DdQsWVTduuJl4FUX2gW7JC5acvyw+ADnxdt2adLI/Fu20c41Uoq45ibFfH3XRUHrgEVFw1KM0iqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIQEoDc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIQEoDc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F291F000E9;
	Wed,  1 Jul 2026 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782892099;
	bh=79BbTs1+PQtUUAXvPVZYw/UCkc3NAY02zVitl11oTho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lIQEoDc/AzZdfIXT6ggz+yDNY5cPZt+O3MGf+fHiVyycXUdfxsF5CmVOkxK1rPWd8
	 fkWDexipaOS9w/YvIeZKLi3G7tD4+Xsu0IS79pPHcDZODvUq/TRygiunFIljOJbNh7
	 fH+MZgET55kZd36S6/jg7pX05rtNhn26AI2YENLkp2TIlDlvG0NURMuaGaTPREuqGa
	 tja/MP9IrrewwyZrNo+BjO7KzGFXKub2TpZxjGz6dHo6Y6OmCfIHVUAXdmzRfC19HH
	 CQoXyOySOqtRvEiUoh4bze4osG5PSH+BYx9b+4iLYhc9sSTf0p/IRb9Pxl8VlZCR7w
	 I/FWPEDU/sQUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260701073513.1101559-3-18255117159@163.com>
References: <20260701073513.1101559-1-18255117159@163.com>
 <20260701073513.1101559-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:48:18 +0000
Message-Id: <20260701074818.E3F291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Modpost link error when building Cadence drivers as modules due to =
an orphaned debugfs object.
--

commit 98a72e00615e702fb5448b12d14570527e38b67f
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add HPA IP debugfs for LTSSM status

This commit adds debugfs support for HPA-based Cadence PCIe controllers,
exposing the current LTSSM state through a new ltssm_status file.

> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/contro=
ller/cadence/Makefile
> index b8ec1cecfaa88..2cdc4617e0c20 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y :=3D pcie-cadence-host-common.o p=
cie-cadence-host.o pcie-c
>  pcie-cadence-ep-mod-y :=3D pcie-cadence-ep.o
> =20
>  obj-$(CONFIG_PCIE_CADENCE) =3D pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) +=3D pcie-cadence-debugfs.o

[Severity: Low]
Will this cause a link error during modpost when building the Cadence drive=
rs
as modules?=20

Since CONFIG_PCIE_CADENCE_DEBUGFS is a boolean, this adds the object direct=
ly
to obj-y instead of appending it to a composite module target like
pcie-cadence-mod-y. When the driver is configured as a module (e.g.,
CONFIG_PCIE_CADENCE=3Dm), the object is compiled but left unlinked.

Could this lead to undefined symbol errors for cdns_pcie_debugfs_init and
cdns_pcie_debugfs_deinit in the caller modules?

>  obj-$(CONFIG_PCIE_CADENCE_HOST) +=3D pcie-cadence-host-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep-mod.o

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701073513.1101=
559-1-18255117159@163.com?part=3D2
