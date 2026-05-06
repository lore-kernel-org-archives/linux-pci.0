Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E931715C
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101504; cv=none; b=BJYF1xeQUzg/A3lUI1o55RN1QW5SK8KKCWvHOvyyJ6zdA3la64PwqJvlycS01fT+eE8NckKnBJVGWBNq56HmNhVxRLxnAgrpAOatfHikQCv1LgFJ1pbzJvZNWWR1UWJ73RFiOPIK1xHf8J25vb2qUgJZDu1YoxfF+Q+RQs4BpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101504; c=relaxed/simple;
	bh=X4aYINGejy7k9MwQbm+16AqS58mF7+ak5XVT6q6vSi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nSoCZpSB3U0k0XA2PXUSQJEyKqrAtwIxIWl80SAxqUo6zUmqlNXjR0pXfvqqIbhmcrsYPx58dGkWELZyN+a6gR38TYq6x4VUoyCFAU3qzpjozFyif5uvTIGDB8hHxlZj0ParfjF5Wx1jOIoNopnZdt2zyg6JJKnZ2R9xizR4ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alEFBwD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alEFBwD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9448C2BCB0;
	Wed,  6 May 2026 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101504;
	bh=X4aYINGejy7k9MwQbm+16AqS58mF7+ak5XVT6q6vSi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=alEFBwD3piNx1guIEV3OdBiBD+Btoi25GZ7QRXUOvc35Ymt496P1esgG7gUxksEjG
	 WwwKKgK1sKzX3tciJKJhIOPCFEbQhbGCsuQ2oVTA3b5L7/I7YE+LQho0qtWi8ciB8o
	 3sG4onq/XEZVs1jOaawlhBYuz1fH3txFGEBk3kNiWnNAy9HoiBXiz6IaOgJwqgtFBS
	 7eoajUYiJI2CjBLsV28I82c6ni4wQGF3ccmShzufrne+SfIXbMjXKOgI9+jq14znHZ
	 lRgwU8neA/vT9u8x0lctnmJI5034FYvt/CYqpFHgXlISKlCLmpJtBJazrYtwuStXS4
	 4C8ju91qeLpiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] PCI: cadence: HPA: Add 100 ms delay after link
 training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260506152346.166056-4-18255117159@163.com>
References: <20260506152346.166056-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:05:03 +0000
Message-Id: <20260506210503.E9448C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The mandatory 100 ms PCIe link training delay will be silently byp=
assed for the Cadence HPA path because `pcie->max_link_speed` is never init=
ialized.
--

commit febef6953b8de7d70ee1c2d2e0d894d52ff3e063
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: HPA: Add 100 ms delay after link training

This commit adds a 100 ms delay after link training for the Cadence HPA PCIe
controller by calling pcie_wait_after_link_train(). It intends to ensure
compliance with the PCIe specification for speeds greater than 5.0 GT/s.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/dri=
vers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e88..62e939906785b 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
[ ... ]
> @@ -304,6 +305,8 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc=
 *rc)
>  	ret =3D cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>  	if (ret)
>  		dev_dbg(dev, "PCIe link never came up\n");
> +	else
> +		pcie_wait_after_link_train(pcie->max_link_speed);

Will pcie->max_link_speed ever be initialized to a value greater than 2 in =
the
HPA path?

The inline function pcie_wait_after_link_train() executes the 100 ms delay =
only
if max_link_speed > 2:

drivers/pci/pci.h:pcie_wait_after_link_train() {
	if (max_link_speed > 2)
		msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

The HPA path is uniquely utilized by the pci-sky1.c glue driver, but neither
pci-sky1.c nor the Cadence core code appears to parse or assign a value to
pcie->max_link_speed.

Because the struct cdns_pcie is zero-initialized, pcie->max_link_speed rema=
ins
0. Passing 0 to pcie_wait_after_link_train() fails the condition check, whi=
ch
seems to completely bypass the required 100 ms delay.

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D3
