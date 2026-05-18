Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AF1E25F9
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068174; cv=none; b=CW3HWMfDhQMqnJ8dIqpFFxj6Cb9tui4E7sos3Ldm3Q3adeL73IO4s3KQs1E4j4ikYmp8majBrZ8SpbA/Ok3LR8CGruY4DmbzbGhEDaFe3nXrLAUrmciTnPT22XMtzOgU6YjTpTwdRxMFPm3PlkcvooIzGUodK/Mcf7Z6CMJsXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068174; c=relaxed/simple;
	bh=T2X3VVh+Zx+OGJ4v6YbJfkBw/GT2R8dVQWYYi2J+eSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Urz9VjaVLxpCVgYBxbdn5PaN8x/541+ydd6wWyCby4dP0pa2sXr1zVZoggFd3JCsivdyUHIYsBn+iteUjdu7eXZAgUXSMt8gMWcX3r58W18u2dF/2mZr3A+gGsBFFWV/CsAnetuj3GOvdHhg0TTAcDYhGEnFMqSD8/5t2C7YBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPyG7/oO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPyG7/oO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A291C2BCB0;
	Mon, 18 May 2026 01:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779068174;
	bh=T2X3VVh+Zx+OGJ4v6YbJfkBw/GT2R8dVQWYYi2J+eSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fPyG7/oOQnE/WWgS9oaLH0m7zvsdEcc/gF8CzLTx0BPr25MrgSsAHtQz86DJQpdV5
	 3M64QOrkcj7JyQAc3zrPh0vW+oAUW9GjoWxBqndo78tWTrYo6ckG5TcwraLUWVfws6
	 6UX5Co3nDGhJv3BIXsv5V18F748qqrJvb/zgAe///a7nGJTovHVkS4YB8Fxvs6XWJf
	 X6j4c8eqjqKbtI0olyeULo8HyQtdtMb4WDqowfVr1t/te1m1BP1GcXtewhcmJynqPZ
	 stqvn1F/JQxd5C+HPjY76oe279iLwFAY5GNVoy+lGYrVj2kHlMz1IojO8tTWsbAryW
	 yeEaKMBYGTVoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] PCI: cadence: HPA: Add post-link delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260518004246.1384532-4-18255117159@163.com>
References: <20260518004246.1384532-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:36:13 +0000
Message-Id: <20260518013614.2A291C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked error return from `of_pci_get_max_link_speed()` disables=
 the mandatory link training delay when the DT property is missing.
--

commit b05c1e9fe77d90401c0d9f6da4d6922526b3a553
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: HPA: Add post-link delay
   =20
This commit introduces a mandatory 100 ms post-link training delay for PCIe
speeds > 5.0 GT/s to comply with the PCIe r6.0 specification. It reads the
max-link-speed property from the device tree to determine the appropriate
delay, defaulting to the value from the glue driver if set.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c

[ ... ]

> @@ -304,6 +306,8 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc=
 *rc)
>  	ret =3D cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> +	else
> +		pci_host_common_link_train_delay(pcie->max_link_speed);

Will this delay be skipped entirely if the max-link-speed device tree
property is missing?

[ ... ]

> @@ -343,6 +348,9 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
>  		rc->cfg_res =3D res;
>  	}
> =20
> +	if (pcie->max_link_speed < 1)
> +		pcie->max_link_speed =3D of_pci_get_max_link_speed(np);

If the max-link-speed property is not present in the device tree,
of_pci_get_max_link_speed() returns -EINVAL (-22):

drivers/pci/pci.h:of_pci_get_max_link_speed() {
    ...
    return -EINVAL;
}

This negative value is then assigned to pcie->max_link_speed. Later, when
pci_host_common_link_train_delay() is called, it checks:

drivers/pci/controller/pci-host-common.h:pci_host_common_link_train_delay()=
 {
    if (max_link_speed > 2)
        msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

Since -22 is not greater than 2, the delay would be bypassed. Should the
code check for a negative return value from of_pci_get_max_link_speed()
before assigning it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D3
