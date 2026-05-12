Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7F2874FA
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551171; cv=none; b=e9g+C5zcgJtAPusBwVcQg3IUTBh9lNW4SseEQZqMe6SG4iyMNOjdTDjfapx/NruLQU2Zi3t+Vx5/SwLapiq0qGlbo50HNLOIUcUwqUSd5ObZr3MVT5eK2Yf/Y2cQQyfXYwdqx4ynIFYXTEPL+u/C/2SoklGsUuYxCa/2/rfWm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551171; c=relaxed/simple;
	bh=RfGnhIIWd/UJHgmPBVgf2MRr29ie/pidJ3D2fqWNoRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTDEN7m5w0yRkcvVH/Zu7bX5erhUmXSKrwv5VzBq2EcKFpemJqYiIBdtGBOYtrv6qC9m+RDWkCZsXAdFyjpTrFB/G3AXou+FQ3af4idQcbBmYK4RhKXMHo7HfSVRHtojFnF8f3+x4dmIyGZmkeXr0ebpuKswDHcgr2Kzhx9Fx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNC4qVoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNC4qVoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951D4C2BCB0;
	Tue, 12 May 2026 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778551170;
	bh=RfGnhIIWd/UJHgmPBVgf2MRr29ie/pidJ3D2fqWNoRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oNC4qVooYNIR0qtq8i9QvtfqMzTbTmsi23bUCghqHInjxpqW5gAL5LLOMZfUeSLkW
	 EVALoavTk51ocp+Hh43pypWb+WD4LYJIGcXn+KdTRZhhtkY7+F7cH7Qy/SyPQqGpfA
	 tqFsGbimklRPD7PNYExV19B0o0habsYUcpouhEPbjW6A+xZUn8NSm2LbWBYu5Ad3VO
	 lBGMfNKl/I36MjhMwwKZY79DkRhDg+FZVSmEWt0iunGX3X03eNazOCadYG0/AQEfJI
	 +qWpR5HRzXVv0ecXz1bIfNDlw9njum+fSkdByTZjU/IGs4LWEozW9GDYLEnbQyetxF
	 b1OxUhN/0V9sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] PCI: mediatek-gen3: Add 100 ms delay after link
 up
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260511055923.37117-7-18255117159@163.com>
References: <20260511055923.37117-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 01:59:30 +0000
Message-Id: <20260512015930.951D4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch completely bypasses the mandatory 100 ms link training d=
elay when the 'max-link-speed' property is omitted from the Device Tree.
--

commit a93442038658e8edd35c1ce148da1ebe3644bfd1
Author: Hans Zhang <18255117159@163.com>

PCI: mediatek-gen3: Add 100 ms delay after link up

The MediaTek Gen3 PCIe host driver lacks the required 100 ms delay after
link training completes for speeds > 5.0 GT/s, as specified in PCIe r6.0
sec 6.6.1. This commit adds the pci_host_common_link_train_delay() call
after the link is successfully brought up.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index b0accd8285892..5abddec4e9bec 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
[ ... ]
> @@ -570,6 +571,8 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie=
 *pcie)
>  		goto err_power_down_device;
>  	}
> =20
> +	pci_host_common_link_train_delay(pcie->max_link_speed);

Does this code bypass the delay when the max-link-speed property is omitted
from the device tree?

If pcie->max_link_speed is 0 (unspecified in the device tree), the controll=
er
defaults to its native hardware capability (Gen3). However, passing 0 to
pci_host_common_link_train_delay() will cause its internal check to evaluate
to false and skip the delay entirely:

static inline void pci_host_common_link_train_delay(int max_link_speed)
{
	if (max_link_speed > 2)
		msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

Should the driver evaluate the actual controller capability or pass the kno=
wn
maximum speed when pcie->max_link_speed is 0?

> +
>  	return 0;
> =20
>  err_power_down_device:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D6
