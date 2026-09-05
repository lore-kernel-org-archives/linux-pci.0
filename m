Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D80157487
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572380; cv=none; b=RyeWnW7mvjYtl5JriPF8A+14gwXNI7otm82ysJarIlSd1kp0iPyj/h9aEyqMte1XNzIGnQKxEg/fi9/BbfY7K8JVHid6rBQ1oMYN2ZSyn1w7cCSOyiJRzmzfO2Ir5/P9bRVcjEGuSXU1PLwsx92QsKGWO2ky5LIfqq68sRjh0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572380; c=relaxed/simple;
	bh=oqoyXtavYVHlNRtoclHw/Z8ziP5pPGk8EJDMoW3jToI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUgDIrhhajv8GzwblN2/B5WKWGrrqLsvK+96XjwvMQOM7FoPU5/ric3C8LCtBWtqQyv980e6rmSfobJZ8tJ2sbhAkwI02XYW+5DjLgZhFLjJs+yQpO082ZYRnGxoh8dViK4GES536Q6Rx3KI7zXo6g1K1iK4EbX1cxGKs4UZfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm5NPgXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm5NPgXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43E81F00A3D;
	Sat,  5 Sep 2026 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788572379;
	bh=2HzjGhrqrWz1WYGlSASoCG4DeUKPP/ZYXp0dcs5+VLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dm5NPgXAGn8ATejqmQyQdWfTJB1OtXCxGetI95kXx8rzx4W4rwHGDAK5ycv3UGQDd
	 YJhJCvahYl9bPtkHCvtg67bV7sN2ttenkq+2k2aByMbgXm3ncVtgN6rD2nU3kZuqWA
	 VZt4lQpFNb85oEqA0ttVrRnsi3XtaoMmS6CRGCQwbThYgme3VrX0/DzJj7XEU6sDDx
	 om7gXdTufAy+e4udT5H1EX8n8pRDgNNZWB7SGd6QBcWD6LwFAt0jXu2f71T/7mU9jB
	 fWh5LVDPo4Yknq1lOTo5Et2z75o7XE87B4/UB2/H4bdHUCkcfE5VsjNlMDoBHQJpqx
	 JII6ICG0E0IDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Add register dump support for PCIe Link
 Down events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905-regdump-v2-1-f7d34f9d4f46@oss.qualcomm.com>
References: <20260905-regdump-v2-1-f7d34f9d4f46@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:39:38 +0000
Message-Id: <20260905013938.C43E81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent access to indirect SD-EQ registers is not protected b=
y a lock, creating a race condition that can corrupt the captured diagnosti=
c state.
--

commit a1f2aa73e3c568121015c7315eea5b09feeae5b7
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

    PCI: qcom: Add register dump support for PCIe Link Down events

This commit adds support for dumping key PCIe controller registers when a L=
ink=20
Down event occurs to aid in root-causing failures. The dump is output direc=
tly
to dmesg or devcoredump, and is also exposed on-demand via a regdump debugf=
s=20
file.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..ba41a0eb43dc5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -1760,6 +1819,287 @@ static int qcom_pcie_set_max_opp(struct device *d=
ev)

[ ... ]

> +static size_t qcom_pcie_fill_dump_buf(struct qcom_pcie *pcie, char *buf,
> +				      size_t buf_size)
> +{
> +	struct dw_pcie *pci =3D pcie->pci;

[ ... ]

> +	/*
> +	 * Gen5 (32 GT/s) local/remote pre/post cursor status, read through the
> +	 * SD-EQ registers inside the DWC RAS-DES vendor-specific extended
> +	 * capability. For each lane, write the lane selector into
> +	 * PCIE_RAS_DES_SD_EQ_CONTROL1 then read back
> +	 * PCIE_RAS_DES_SD_EQ_STATUS2/3, which carry the local/remote pre/post
> +	 * cursor values.
> +	 */
> +	if (pcie_get_link_speed(pci->max_link_speed) =3D=3D PCIE_SPEED_32_0GT) {
> +		u16 rasdes_cap =3D dw_pcie_find_rasdes_capability(pci);
> +
> +		if (rasdes_cap) {
> +			int num_lanes =3D dw_pcie_link_get_max_link_width(pci);
> +			int lane;
> +
> +			for (lane =3D 0; lane < num_lanes; lane++) {
> +				dw_pcie_writel_dbi(pci,
> +						   rasdes_cap + PCIE_RAS_DES_SD_EQ_CONTROL1,
> +						   lane & PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL);
> +
> +				val =3D dw_pcie_readl_dbi(pci,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2);

[Severity: Medium]
Are these indirect SD-EQ register accesses in qcom_pcie_fill_dump_buf() saf=
e=20
from concurrent access?

If multiple processes read the regdump debugfs file simultaneously, or if a=
=20
user reads the debugfs file concurrently with a PCIe Link Down event (which=
=20
triggers the same dump logic from qcom_pcie_global_irq_thread()), these=20
write-then-read sequences could interleave.

This race could cause one or both threads to read the status registers for =
the
wrong lane, corrupting the captured diagnostic state. Should this access be
protected by a lock?

> +				len +=3D qcom_pcie_dump_lane_reg_val(buf + len, buf_size - len, &col,
> +							lane,
> +							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2,
> +							val);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-regdump-v2=
-1-f7d34f9d4f46@oss.qualcomm.com?part=3D1
