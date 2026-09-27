Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833B42DA3D
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533884; cv=none; b=A8PpZP7AunSS6B86ZQcctJRkjUtzY63QXbjzs36zIFqhyst1vT753apJAQYEyTnzwAIq4GJI9pOprd5WHhw06UBW9/JrvJpPd2ShWUIO5JC/bK6qMZDFP/WuxwRqsrv+3V5v4Rn3lIQl/Z1HZhVg08j88vz76xamMMubxONfliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533884; c=relaxed/simple;
	bh=ZYgYI49JQzsK8yo+3ZKTa+ARAoghhuWdfm3vLxNAG1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z0smPML1AHgxjft+l+weNMFi5mtS03FoxTRtm6YXs1H87YCqNBOq0LkK/vvHrxhDjzaSLl+xAMJ4HFbFy81D+0+RPXuVmaVDPMC+0hKCSk6HwuL3UAyZ3oKVmWjvfudg+n6msK1ODatNkgwaCG/Ek5J5Si/6wAxxTAjCBn/b+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIvzmuMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIvzmuMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3F91F000FF;
	Sun, 27 Sep 2026 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533882;
	bh=wISAszQLsvCHNX5V7PRih78zIr1ySkCkpCUljL1P7SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIvzmuMU6d2vUT5qWmt5lcm/ftldvw8aPp1pPdTzm5Pj06/EuH8wuxz6YqIMM4Yjs
	 1eL0PTYN/LYmVdD6QtDblujxlrzkfdCZ1x9OoXG+2aOiCI++NdhfUB0OE8BbKqy71f
	 l7ynfmOkYaaGAvfptjAY6AeiOHmmKF5/gAQp6TDj1AzBKP2JFTh7Ac02kanmG7SPA4
	 heZhYzZ7Apr/7lx5xx7B360c5FRNejb6WiORdu6tRnkZq7eY+oKXbYyiYFXrEeXYvK
	 RE8iVNdp+43GkIzCQxrgbUPuw20hZXZcMC8IKPNX3ray58mpnDFoXfQFVeVQvz3WjG
	 hF+AULLFrfLpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:31:22 +0000
Message-Id: <20260927183122.8B3F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: stale fatal AER status bits left uncleared on recovery fail=
ure path
--

commit f65c6a5d555f5001060d8335ce4ca73c0130b547
Author: Yury Murashka <yurypm@arista.com>
PCI/ERR: Avoid stale error status bits on recovery failure

This commit clears error status bits on recovery failure to prevent the
AER driver from falsely identifying unaffected devices as the source of
new errors. It does this by calling pcie_clear_device_status() and
pci_aer_clear_nonfatal_status() on the failure path in pcie_do_recovery().

Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=3Dgw=
fYdcrMo-SQ@mail.gmail.com/

> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *de=
v,
>  	return status;
> =20
>  failed:
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);

[Severity: Medium]
When pcie_do_recovery() is invoked for a fatal error (pci_channel_io_frozen)
and recovery fails, will this leave the fatal error bits uncleared?

Looking at pci_aer_clear_nonfatal_status() in drivers/pci/pcie/aer.c, it
explicitly masks out fatal errors before writing back to the status registe=
r:

    pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
    pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, &sev);
    status &=3D ~sev;
    if (status)
        pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);

If a fatal error occurred, the severity bit is 1, so the status bit is never
cleared. Could this leave stale fatal error bits that cause subsequent
is_error_source() checks to falsely identify this device?

Should this failure path use pci_aer_clear_status() or explicitly clear all
uncorrectable errors instead?

> +	}
> +
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
> =20
>  	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D3
