Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D984052B6
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198326; cv=none; b=oF9TMeQQmcACipqJ56ZfC2N57VsZsjHYafGtOdw1R6IChWAKH7OuWRXfON1mkzL9RZZBE8kQLOHA7lUIvkG8SbXqBOTqCFdvpgBRL+JIxaqvLRZCgPUGxWUmPFm6geik7ewWID52C3xqp/vVD/Ym5RKBkaz3yWGxgMooKztOB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198326; c=relaxed/simple;
	bh=hZb0ZR3jXmTybcGNRoyDbycNaHxi60Qe8lkA+kOMAcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1l2v4TlMyqL7hCVi48iouCf5OkpTGwqg0U9d1aBWZIDicZGqlKHVmxPdX1VLmLLYa1o/VqGrhoti1PcOgJF24UpczkmNi3b3XKpMmeM/bjiJiiWjd9d5MYffTaWAa/+22StN9ItmOFNX72eiUMU4hg9AHg5zqoyIQm3CLCjTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+HlRsDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+HlRsDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DFC1F000FF;
	Mon,  5 Oct 2026 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791198324;
	bh=z0RJA1li+p3WEts6BE7Rsbxl0CAkWClFVl7YFWAXlPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+HlRsDiNUpxMIAsqdcwQ2JJxXuBl42GRd219c2LbfW2uiltLTVved8czUypsw/7/
	 UOe4lvXzjPu8wcTQh73uZJ0zp80EQukumLrhokFe1OMUTAef8a6HmL6S27MLWqaKrv
	 YnxbX1QgOhRMMmza3rK3BgzYUI4SJjnqYnU+zPWedDvzVZiFG/EMeP2cGk3cohE13+
	 zgvvuCv5xs+FYGdGpXnXqRDkD1m96XPFZst3p1rg1/SSo7fO48Y2wSdIAJwgCaQVbN
	 79IDHnJDT8neukDJd/dZjtZgtjWXUPmsZZHkIm3GmUQcRYOEC0D/ohAaIG7z3AWavm
	 +grhVuH32Rv+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/2] PCI: Add device-specific reset for Qualcomm
 WCN6855/WCN7850 WLAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005105436.83962-3-jtornosm@redhat.com>
References: <20261005105436.83962-1-jtornosm@redhat.com>
 <20261005105436.83962-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 11:05:24 +0000
Message-Id: <20261005110524.81DFC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: out-of-bounds MMIO read in reset_qualcomm_wlan due to unver=
ified BAR length
--

commit 0bf7ebc364dec72a7a29e6f1e5602ff74fc3a191
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm WCN6855/WCN7850 WLAN

Qualcomm WCN6855 and WCN7850 WLAN devices lack working reset methods for
VFIO passthrough scenarios. This commit adds a device-specific reset method
using BAR-space hardware reset registers that exist in these devices.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e72af7d2c7755..e800dd517614e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static int reset_qualcomm_wlan(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u32 val;
> +	u16 cmd;
> +	int ret;

[ ... ]

> +	bar =3D pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	val =3D ioread32(bar + QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET);

[Severity: Medium]
Could this lead to an out-of-bounds MMIO read if the device's BAR 0 is
shorter than 0x300C?

The code unconditionally accesses offset 0x3008
(QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET) here without verifying if the mapped
memory region is large enough. If an untrusted hardware actor or a spoofed
device exposes a smaller BAR 0 (e.g., 4KB), this access could exceed the
mapped memory boundary and cause a kernel panic due to a page fault.

Would it be safer to verify that pci_resource_len(pdev, 0) is at least
large enough to contain this offset before mapping and reading it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005105436.8396=
2-1-jtornosm@redhat.com?part=3D2
