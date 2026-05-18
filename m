Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712D3CF043
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121660; cv=none; b=eOXui4hJpeSIYhtPb8m2Ikt0hgsLtDlJ0ImebFuHZ6lbadR5RfjpPMxsNIzkAQ0iLy7tTZS+JZVCjT6CNqWw9N8ozRlosP3IjJK7u0/n67kCHgH8blHu2qcykYI71HpOWK+teWrH5DWse1X6d7lHYT00wFdE9BF8azAwloF8HLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121660; c=relaxed/simple;
	bh=QgH5hSZosVJg9zMLoNDZvsL0bG+q+SXKOqGBqQAhQ5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCDhfstf33RBt5OSmrP7vm7Kl6ZiIhUtFjdxC1+Hu60ElApl37v7+RiBXPcJXY1BnVcHvFRwmIjk9Y/AEU+Laj/aRwd1lrs4hDZwVkn31ztjZBvSjZB6QpTyFwqGBsh9FHVKD0FYHd14sjp0et12hZ1XJILTuCSkIC6GoEMm2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si11Ma+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si11Ma+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D246EC2BCC6;
	Mon, 18 May 2026 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121660;
	bh=QgH5hSZosVJg9zMLoNDZvsL0bG+q+SXKOqGBqQAhQ5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=si11Ma+/VjdILmVcZ8QkrLwzhwvNPqNMnQjt2WtxIguds6Mv9Bj+e+n6BIkTLtneq
	 p6dcNqrA1fpHYuv5eVXrpkdZgz/wUKoUiYq/HENuKSPTjrpxPeONSaJiiHdHg+z2Sb
	 F3T4/1KrcQvwV6jAzQehCZdwBk8KicvRE4JF2CmFHcWhX2CpzlUxNz0+Tngr83DCeP
	 7d84/yk3eY3CTGYfPEqSlAQ+YoXjI9G+MfBhpRp7RSRAmWtZwIBjTxa8apqwzD3I1N
	 SoYxd/WwepmQsSqWzkq3WHx5wMdg4u7bKiJh3hSbMC9vro9XefokgsogCOAB5eW5nD
	 2eVNn9pkjRTtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] PCI/ERR: Add support for resetting the Root
 Ports in a platform specific way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518-pci-port-reset-v8-2-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-2-eb5a7d331dfc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:27:39 +0000
Message-Id: <20260518162739.D246EC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing pci_save_state() before the Root Port reset, leading to re=
storation of stale or uninitialized configuration space.
- [Medium] Silent failure and bypassed fallback when the platform-specific =
reset_root_port() fails.
--

commit b100b0c0e31e848c799fc6d648ef37421c08fb9f
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI/ERR: Add support for resetting the Root Ports in a platform specific way

This commit adds a reset_root_port callback to pci_host_bridge to allow
platform-specific root port resets during error recovery. It calls this
from pcibios_reset_secondary_bus() if available, attempting to save and
restore the configuration space across the reset.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..651505b3bd60e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4809,6 +4809,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
> =20
>  void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
> +	int ret;
> +
> +	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {

The commit message says "save the Root Port config space before reset and
restore it afterwards". Should there be a call to pci_save_state() here
before initiating the reset?

If the state is never saved immediately prior to the reset, won't
pci_restore_state() restore whatever state was last saved in
dev->saved_config_space (e.g. from probe or suspend)?

> +		ret =3D host->reset_root_port(host, dev);
> +		if (ret)
> +			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> +		else
> +			pci_restore_state(dev);
> +
> +		return;

If host->reset_root_port() returns an error, the function returns early
without doing the standard reset or propagating the error (since the
function returns void).

Will this cause callers to falsely assume the reset was successful?

Should this fall through to the standard pci_reset_secondary_bus() if the
platform-specific reset fails?

> +	}
> +
>  	pci_reset_secondary_bus(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-pci-port-r=
eset-v8-0-eb5a7d331dfc@oss.qualcomm.com?part=3D2
