Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F18344021
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552139; cv=none; b=nfjkwrZ60+qEyXucd4mwrBXRyrt5tRdXzJixfIvBRq35vzwEuLKVuE7mv3l4z5kBX43G2DCCCREIRly/H4VbeKMjZoVl20onVwhNwLtaV4uuf5V0aL02xLwwDjWndCCeecriCPctiE75KuQ3kA9WO+Qe1/SrDCWpVPrT+Kl6mb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552139; c=relaxed/simple;
	bh=4DBG1Pe2aLoZysjPj+j6Ne+9lyMohfpW2PKzDmPMB+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3x0pYn6g80DYBaSt76oLgRSL4gHlYSg/V0uBIOJz5/Fy3e7eU4ZYwt2/lgHJVUxyu0FqxSYcjhuIM15PoZ2lo90vKOS0JE4KCtHoTqlu5tIqMwtB/EJYBQOD7S61z01XW+vtnKCsuV2CNHsm5oBn//i/nekQhLLbNVMiSYLVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLptwYu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLptwYu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A3C2BCB0;
	Tue, 12 May 2026 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778552139;
	bh=4DBG1Pe2aLoZysjPj+j6Ne+9lyMohfpW2PKzDmPMB+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sLptwYu9mhYv/GBZ9p0gvJqgg3VUWcSICFvEtRYueINLwShJ0r0+OqrOfeT5lSw29
	 ke9A/2yvkKwKk9mTtWBdznMSgraJtcKYcmyRiuRB5FtaP+c/D1j7vfMh7KuxL9Yl35
	 W1cWpbTzc8uNezauIRgulXf2Pgppbk4BlbQTNkHSleG8fBXn5XSRaRUT2qPKGTLagg
	 IGTzC46E8JfrEMLTANTVkjJw4gLs1IKlBasUsz55UxoL8yJPIYU3zJiFvVMmW/WGaK
	 HpwVhHP/ho1ZJyGagSLy8DOV5VkIf70BhpcQoxtHRh+Rh5XJTnUn6VWRXrhmF3Heg4
	 /TtPIqBsY6F3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] PCI: rzg3s-host: Use common
 pci_host_common_link_train_delay() helper
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260511055923.37117-8-18255117159@163.com>
References: <20260511055923.37117-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 02:15:38 +0000
Message-Id: <20260512021539.572A3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The mandatory link training delay is bypassed when 'max-link-speed=
' is missing from the device tree, violating PCIe r6.0 requirements for Gen=
3+ devices.
--

commit afb29b744bdf8f1be85fd9c879cf2af33e736d5a
Author: Hans Zhang <18255117159@163.com>

PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper

Replace the unconditional msleep(100) with the common helper
pci_host_common_link_train_delay(). The helper only waits when
max_link_speed > 2, as required by PCIe r6.0 sec 6.6.1.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index d86e7516dcc29..66f687304c1cb 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -1663,7 +1664,7 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>  	if (ret)
>  		dev_info(dev, "Failed to set max link speed\n");
> =20
> -	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +	pci_host_common_link_train_delay(host->max_link_speed);

If the max-link-speed property is missing from the device tree,
of_pci_get_max_link_speed() returns -EINVAL.

While rzg3s_pcie_set_max_link_speed() correctly handles this negative
value by falling back to hardware capabilities, host->max_link_speed
remains -EINVAL.

When this negative value is passed to pci_host_common_link_train_delay(),
the internal check (max_link_speed > 2) evaluates to false.

Could this cause a regression by inadvertently bypassing the mandatory link
training delay for Gen3 or higher devices that lack the max-link-speed
device tree property?

> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D7
