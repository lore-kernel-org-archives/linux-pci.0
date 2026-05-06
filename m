Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC53B52E9
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105695; cv=none; b=f9ViHjF4h8NEtjPuVcm834AQe/cfwDcWHLWa2suj37SR+9xbi4u6K/JVOcSrWyoIctj2jokDeBO4Cuff/u3HTKbfCXdpaVqE1AED56iiXODdyprhjxTTVfguIID8zqsaNQhtwm1bPFydCHbhKpK2jTbbjI0hFQRmAOzZObYNxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105695; c=relaxed/simple;
	bh=1DgVoJamFNhWSleFoz2JxatQgf5Jde4qMkyMmIjZKzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/NYJEi2yZlfpfyzUUt3MZAjjPsB57qlQkIUSFGL1mWmZaoCyvkIfsIMnoW5fpL4hL7WrybpRwxekEcFtTxuvaom/iLbRKI+V7ITQmj3dzTsHBty6DDnMVvCfSaApbSZpb0D98WgA6WJGtKwAaIN7iSftQTbieH39l95t31Fnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBV9py3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBV9py3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE6C2BCB0;
	Wed,  6 May 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778105694;
	bh=1DgVoJamFNhWSleFoz2JxatQgf5Jde4qMkyMmIjZKzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UBV9py3t/EEwxo6jktprvrfQbBoqZjj5/7kpnnx9Krfoj6XQJnpXEYno+vmuzumEG
	 qNA83SU3NvXfWGBI+XHELagNbzlhcPmqvhPn4Tc/4Jfxu5uLSuCaZ7RoVEMavXm9vv
	 Ec7ToXE6Me93iom5iPRDCkRMPEdD4P4dhwT8m394934SqECfToiWMrOFnLu+WP4W4q
	 alX3PAX80cU8KIFy+CgayBFSl/DbNmlazZboMeodUaIr/fKaCOxgziHEkS69rTHIAT
	 lVoCgWquDZ7hJx9wIh2PFYgHaHlK7cduDE0zUovcQL5Be3YEQnhMc1EY9q8jld0Tnh
	 sgROsWo+W5yKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] PCI: mediatek-gen3: Add 100 ms delay after link
 training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260506152346.166056-8-18255117159@163.com>
References: <20260506152346.166056-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:14:54 +0000
Message-Id: <20260506221454.87AE6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch fails to apply the required 100 ms delay when the 'max-l=
ink-speed' device tree property is absent, rendering the fix ineffective fo=
r default configurations.
--

commit 10a23926b0b81ebd001326cf3638896f24f80c55
Author: Hans Zhang <18255117159@163.com>
PCI: mediatek-gen3: Add 100 ms delay after link training

This commit adds a 100 ms delay after link training completes for speeds
greater than 5.0 GT/s to comply with PCIe r6.0 sec 6.6.1. It uses the
pcie_wait_after_link_train() helper and passes the max_link_speed from
the controller structure.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index b0accd8285892..7c5f2ba7157bf 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -570,6 +570,8 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie=
 *pcie)
>  		goto err_power_down_device;
>  	}
> =20
> +	pcie_wait_after_link_train(pcie->max_link_speed);

Will this apply the delay when the max-link-speed device tree property is
absent?

If the property is not specified, pcie->max_link_speed remains 0, but the
hardware defaults to Gen3 (8.0 GT/s). Passing 0 to the helper skips the del=
ay
because of the internal check:

drivers/pci/pci.h:pcie_wait_after_link_train() {
	if (max_link_speed > 2)
		msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

Since the hardware defaults to Gen3 when unspecified, does the driver
need to check the actual negotiated link speed or the default hardware
capability here to ensure the delay is applied?

> +
>  	return 0;
> =20
>  err_power_down_device:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D7
