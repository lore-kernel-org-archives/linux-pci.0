Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BD44B68E
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485620; cv=none; b=gzDIvJ1Zyvo03Hmua9Rmp+yL93pXyoBH8i4Ybvw4eHFFJcRllNwLP27gT0ocGbL0/B+FScc/KBqAmg0WAMfypj4IsaBXhV3ljJqiL7cSUBiWzO+wK75ziPp1lCdyX1Gas/KVVJDIsQEOpznRMuLDB9dBTHQwsHd6l+DOd7OlPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485620; c=relaxed/simple;
	bh=hc3enqvCeEkFHYyExA894HQOy2nwzFdWRp7DcL4w3xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLd3RfiSZ8JspJsUEPvphdT3w/LA+yysk4iSA3HC0B2UQLc1tgGHNmx1bqGxePXFyLg9ElrUQ+LlqP3XTRTjKvdM6xuqGDHn6SEH6vH7o68H5k0RO7wmKrFMDl6aw5ABuVj1QZtSO7Miz88HKWRvxlQVACpPbCDMwDO4rr0/8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbbELx5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbbELx5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA41F00893;
	Wed,  3 Jun 2026 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485618;
	bh=nvRa2qTx4zwd7RE5TvFMCbmz9P3TG0GOfQaswWRmpik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbbELx5w0LNilXBfmm5ADA3peeRaLNtLTaVLslWRCjDtg45P0fRjLUg1D6ptFoUw5
	 oF15dPKIbc1JP8upuEc2F3inghUTahf1jjRY05IwdI+U1Tm7XzPHoN0QLHbqXWEGyH
	 S5SjVa+R/84n72b3KlG/Ddmkg9XMwr61B1XxzpJjRC7WmLKb1RP++Xixv0l+3B/0gg
	 TZsftpmXhnFPSXndcUte7KdF5UnZv/yuELTHrTiUOQn81Hvyo5fX/X2PTZcdGihXX/
	 ji2UsXx8cm5d+Yp4Mv6cL0qM8diQIPa5Kqp9vB2MknLtbWNx+2wmMVHXQUYSVJ0LGb
	 KHIA4xCLxR1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: Add d3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603105853.326290-2-jtornosm@redhat.com>
References: <20260603105853.326290-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:20:18 +0000
Message-Id: <20260603112018.97AA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci_d3cold_reset() fails to wait for device readiness after transi=
tioning from D3cold to D0, leading to immediate config read failures and st=
ate corruption.
- [High] pci_d3cold_reset() does not prevent execution on single-function b=
ridges, leading to permanent state corruption and physical data loss of all=
 subordinate devices.
--

commit c7a8523521475c131fd83bc43a00b0cc028fc9a1
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add d3cold as general reset method

This patch adds D3cold power cycling as a reset method for single-function
devices via ACPI _PR3, placing it at the end of the reset hierarchy.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..096868f80cd4c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +

[Severity: High]
Does this allow execution on single-function bridges, such as PCIe Root
Ports?

If pci_set_power_state(dev, PCI_D3cold) is called on a bridge, it recursive=
ly
updates all subordinate devices' tracking state to D3cold via
__pci_bus_set_current_state() and physically removes power from them.

The subsequent transition back to D0 only updates the bridge itself. This
leaves all downstream devices tracked as PCI_D3cold indefinitely, and they
lose all their configuration and BARs since the reset framework only saves
and restores the bridge's configuration state.=20

> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (dev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	ret =3D pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		goto done;
> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);

[Severity: High]
Does this sequence fail to account for the mandatory wait time before the
device is responsive to config space accesses?

A D3cold to D0 transition acts as a fundamental reset. pci_set_power_state()
internally invokes pci_power_up(), which applies power and immediately
attempts to read PCI_PM_CTRL without waiting for link training or handling
Configuration Request Retry Status (CRS).

Because the device is unready, this read can return 0xFFFF (Unsupported
Request) and cause pci_power_up() to spuriously fail with -EIO. Should this
include a polling delay, similar to pci_dev_wait(), to prevent the reset
framework from blindly failing or restoring state to an uninitialized devic=
e?

> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105853.3262=
90-1-jtornosm@redhat.com?part=3D1
