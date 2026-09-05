Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E93812FB
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616441; cv=none; b=e+MxJjujMdA88E0QPcNIWAD4Ti/n8TbCAI+kPkACMayHvBxA2Ih9EL9+k6INu6LDdN1FcaW1xX91RMKdIjWSkipvWMRLdFpG8xgBSmJ9DU4GeCePvsVR60oJtjzfd9d3Cwd4PCWBv9x2sYoDCW5T6DtXb0turot8wELQy1e2TuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616441; c=relaxed/simple;
	bh=e1nYJCXLz8r6758eTINKOhEwXYxdjGmNmbKTcJLX1mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oCrEIw5ipRtTw6Y/B2VuqeYUG6uj8b9NTW3mNtDR07B3oPNAX+vdw1qY3ii0VQS7u3mKzeNhcOovbOBLEg7ibzfCPL++RLmp1zDQa110r1oozQ7k2G7A0D2IvQqEWaHvMWCQ7c4EniiCDmLkjyp24Cl7yP9oz/qNEKipSI3mhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE7z/9Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE7z/9Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECC61F00A3D;
	Sat,  5 Sep 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616436;
	bh=wa3wnDFq/Ci128If0Spg/OrTZS5HXnz3zzIhgB/I2KM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bE7z/9QtoYKTZ/fGiH7d2oikmtAkAzTmgt1ZMKcIdTEatDwOPyE9cGSH4b+T8UxZ2
	 02pgVmKYgPGUXD1F5S1gORf9ForSDIU+uzFuS8UpFFNeOEUJCs9azKsddIQrnafAq+
	 dKUE808IUIdX/1SRCYJTSyB9gEyQHCpHn9j/I+QgL4WA7fG57fzqeq4cngSCTqmGZt
	 WWDGuHmttiAJWr8mYlMTkBqjhupS5MTQhNZR2TSId49EQswQTvT3/MC5+y7UY0MoZz
	 IIz1qx2iIwke7uxQfHCvZ0FZmF+MmN24WFrKBeNXGYaBGsIAK3sfsrOilw/130n8AM
	 jQpQ0zyS/44hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Reply-To: sashiko-reviews@lists.linux.dev
To: hpp.iscas <hppiscas@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905134251.67210-1-hppiscas@163.com>
References: <20260905134251.67210-1-hppiscas@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:53:55 +0000
Message-Id: <20260905135356.2ECC61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource leak of `perst` reset controls on the probe error path du=
e to incorrect label ordering.
--

commit 086b34d1058711efceb6e05d5c137e933d166d8c
Author: hpp.iscas <hppiscas@163.com>

PCI: eswin: Publish the platform driver's OF alias

The ESWIN PCIe host controller is a platform driver matched through
eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
published for OF module autoloading.

Publish this platform-device table. Do not change the RISC-V host
initialization sequence or PCI device matching.

> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/contro=
ller/dwc/pcie-eswin.c
> index ce8d64f8a3957..1bb44696057e4 100644
> --- a/drivers/pci/controller/dwc/pcie-eswin.c
> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> @@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[=
] =3D {
>  	{ .compatible =3D "eswin,eic7700-pcie", .data =3D &eswin_eic7700_data },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a pre-existing issue in eswin_pcie_probe() regarding error handling.

When dw_pcie_host_init() fails, execution jumps to err_init:

	ret =3D dw_pcie_host_init(&pci->pp);
	if (ret) {
		dev_err(dev, "Failed to init host\n");
		goto err_init;
	}

Because err_init is positioned after err_pm_runtime_put, it completely skips
the loop that releases the exclusive perst reset controls:

err_pm_runtime_put:
	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
		reset_control_put(port->perst);
		list_del(&port->list);
	}
err_init:
	pm_runtime_put(dev);

Does this leak the perst reset controls?

Because they are requested exclusively via of_reset_control_get_exclusive(),
would subsequent attempts to reprobe the driver (e.g. module reload) fail to
acquire the reset controls until a full system reboot?

> =20
>  static struct platform_driver eswin_pcie_driver =3D {
>  	.probe =3D eswin_pcie_probe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905134251.6721=
0-1-hppiscas@163.com?part=3D1
