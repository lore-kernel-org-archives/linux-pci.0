Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB73171CD
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067240; cv=none; b=q0PJTQio6YHvjAmeoqzszGyMm8XB719F0XgqmbnCAK2oSPk5Ac0wbzyDQq+udXj5lfYMP3EXvVhf7/oO4p2i4Gf8Hx3PlZ6hdUMhA0lLz50rl9KknPNHEqkTlZnOVLdgrIAA7H2Krgd/bh6vjGWLiUKy36vh9Phhsxuh/QtDbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067240; c=relaxed/simple;
	bh=O+A2I/tGZmPvS5HsMN6JY/a4N0JB/+7b/rbcDgB76M0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LFZ40cpioa+YIRTqqEHnge3TZk7VtqV3mlYj7RUuSZM3Pxl4pdoVib3NpIvOLR28kxuXmZpArLzoX+NIQ2yHr6HVhCouv9Ba84QX6qMNriM6CGgXubX5IpQFmkmrgqHZFUQhVJV+EUIzHcVzbcxsdB22cROiYQNVEtUgKYume2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTTYOPoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTTYOPoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36796C2BCB0;
	Mon, 18 May 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067240;
	bh=O+A2I/tGZmPvS5HsMN6JY/a4N0JB/+7b/rbcDgB76M0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FTTYOPoIpMrak1O4jNm1Tovwn0zUv5ludg8ynDoRNFFfyu107P8KyacOuH+6gqjD0
	 oWY8MhVXKUu/do+K225HB4syQNTDeHXgr0tY7JJe1E2OJaPz6rzqpOLR5F6oRsrfF5
	 L7m06p/W4VxDpIjucnl6zHjxJ2bK3jGN5kOGbhrXMKFOKTbjylwyrV21fUbEPQLUL6
	 M/q86zhUnuCdVnZKBi6GwtuRCPM/qg9KjHV2DnYUjQG8cdQmtplHBrP8X9pIBiep4s
	 JB9WsmOuQiHdxIqmveEUGYBmEOcTJl04S9ZVmyu9kIrPqSkr1qq5XujPHv5yygK6re
	 xmv7/v2/KlReA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] PCI: cadence: Add post-link delay for LGA and
 j721e glue driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260518004246.1384532-3-18255117159@163.com>
References: <20260518004246.1384532-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:20:38 +0000
Message-Id: <20260518012040.36796C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unhandled error code and failure to enforce mandatory PCIe link de=
lay
--

commit b73c41b22775891786c97fcc245ece6f4b38b290
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add post-link delay for LGA and j721e glue driver

The Cadence LGA PCIe host controller is missing the mandatory 100 ms delay
after link training for speeds > 5.0 GT/s. This patch adds a max_link_speed
field to struct cdns_pcie and inserts the required delay after link
establishment.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers=
/pci/controller/cadence/pcie-cadence-host.c
> index 0bc9e6e90e0e0..058e4e619654c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
[ ... ]
> @@ -397,6 +398,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	rc->device_id =3D 0xffff;
>  	of_property_read_u32(np, "device-id", &rc->device_id);
> =20
> +	if (pcie->max_link_speed < 1)
> +		pcie->max_link_speed =3D of_pci_get_max_link_speed(np);
> +

If the max-link-speed property is missing from the device tree,
of_pci_get_max_link_speed() returns -EINVAL. Does this code handle that
error correctly?

It looks like the negative error code (-22) will be assigned directly to
pcie->max_link_speed.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/=
drivers/pci/controller/cadence/pcie-cadence-host-common.c
> index 2b0211870f02a..18e4b6c760b51 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
[ ... ]
> @@ -115,6 +116,9 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
>  	if (!ret && rc->quirk_retrain_flag)
>  		ret =3D cdns_pcie_retrain(pcie, pcie_link_up);
> =20
> +	if (!ret)
> +		pci_host_common_link_train_delay(pcie->max_link_speed);
> +
>  	return ret;

Since pci_host_common_link_train_delay() checks if max_link_speed > 2,
would a negative value silently bypass the required 100ms delay on
platforms where the device tree property is missing?

Could we instead fall back to querying the hardware's actual link capability
from the PCI_EXP_LNKCAP register when the device tree property is absent,
so the hardware trains correctly and the delay is enforced without requiring
device tree updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D2
