Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CF22D7B9
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975449; cv=none; b=oJUIuiQJ8pJeJcaIF4EFPG90pAGCoFAxfAlePAQT2O7pt4ddSG8YxlGt8S/SV42E4A5AvG6YQbtOWuE3fpSJCNos/0SiSgy14JVMh5tvN4VtuS5ibgFIWc2/Mks5z6egwrcjzI08cW98GeS9jv/6dKXuRdoYlRkxl/ebf/eNkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975449; c=relaxed/simple;
	bh=BsN/YfuP+V3ZXdEvyWFbfNc+bri8pePm7FvBz1o+jqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rByOAqEa45H8XWER4TLXxOVu2/iEkhl0/DmlyjYBveism3X/ZFimdZzaX7XTJxOAOukbR1S0JnRCIDu4dUahx2TVdOh+NOBHkzXZ85mn90JEohR4Rp4coOjRAqz5IlFJEepEsNJfjuOna+kngwHGskq5D+IaP/baCwkF0yZ+c/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n41QxMDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n41QxMDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1161B1F000E9;
	Sat, 20 Jun 2026 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975448;
	bh=poY5rq9QV7FR+ryURdqsNpsI2HAEvSa54lWzRVpebeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n41QxMDzSYdAsQwvj4V05RgnS6ul83jxvwfZSna5Z+xOBSm/Tdq+2X6rLc8WRLNGe
	 IM2Ajcm6krbE9adfdtDZFCawTuRhz4iXGSwrGeTagNoom27vu/tWtpkGEBhiKdYROB
	 qbCYqie0oUE8gaFPRxj/GgXJNwa3GLE17Vuc7EgH45k1Ny0OLaMeFg9YrEUmlnkt/S
	 Z8s+VesKqGtFetfFOMblg5H5uvQWwLa0mz6Ec6Y8JacRwhZ7oy1a+DE+Jj4LT/sfVR
	 FO5GiEWQjUjGMTQhKpSRvG9w4UD7Ep6c8tFHbSgq3+e5pYl4f1HpnbEkKwYS6jj6qg
	 Y64A1jYMZaSew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260620170438.3756593-2-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
 <20260620170438.3756593-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:10:47 +0000
Message-Id: <20260620171048.1161B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The endpoint DMA BAR metadata format contains an inherent limit =
mismatch between the `metadata length` field and the maximum possible size =
of the tables it describes.
--

commit 8e3a71eaeea3ed7cc589bce08e6fd2a630ca1075
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Define endpoint DMA BAR metadata format

This commit defines a BAR-resident metadata format for endpoint functions
that expose an endpoint-integrated DMA controller to a PCI host.

> diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> new file mode 100644
> index 0000000000000..c5fd7aab2101f
> --- /dev/null
> +++ b/include/linux/pci-ep-dma.h

[ ... ]

> +#define PCI_EP_DMA_METADATA_HDR_LEN		0x1c
> +
> +#define PCI_EP_DMA_METADATA_HDR			0x04
> +#define  PCI_EP_DMA_METADATA_HDR_REV		GENMASK(7, 0)
> +#define  PCI_EP_DMA_METADATA_HDR_LEN_FIELD	GENMASK(31, 16)
> +
> +#define PCI_EP_DMA_METADATA_CTRL		0x08
> +#define  PCI_EP_DMA_METADATA_CTRL_REG_BAR	GENMASK(2, 0)
> +#define  PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT	GENMASK(10, 3)
> +#define  PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT	GENMASK(18, 11)
> +#define  PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE	GENMASK(26, 19)

[Severity: Medium]
Could this layout result in the total computed size exceeding the 16-bit
length field capacity?

The PCI_EP_DMA_METADATA_HDR_LEN_FIELD defines a 16-bit metadata length
field (maximum 65,535 bytes). However, the format also specifies an 8-bit
write channel count (up to 255), an 8-bit read channel count (up to 255),
and an 8-bit channel entry size (up to 255 bytes).=20

If an endpoint were to specify these maximum values, the total computed size
could reach 130,078 bytes (a 28 byte header plus 510 channels at 255 bytes
each). This exceeds the maximum value that the 16-bit metadata length
field can represent.

Would this ABI inconsistency allow a malicious endpoint to craft a payload
where the table bounds exceed the reported length, potentially leading to
out-of-bounds reads in future host drivers if they map memory based on the
length but iterate using the channel counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170438.3756=
593-1-den@valinux.co.jp?part=3D1
