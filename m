Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846C34F259
	for <linux-pci@vger.kernel.org>; Sat, 29 Aug 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788000247; cv=none; b=hiipmb01ro4jd8QGQocb6O6BiHYPzu5qzp6iVjytHpN+aFiNtj7GVAyBuYeAdZO2Qc+RkkBDijUAimF882kiMHul9OR3D5VSDW53kZuj9uAK4Pw4kWGJy42IHmeZOejSEP1EIVTN02pIMF741ofxrbHwO00ZHhnXkK53bNpfVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788000247; c=relaxed/simple;
	bh=/gKkw35IibtbNzYGDOKTiLAn5QEfZvpNur5m3Xbj3fQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JT0xRzaRQBZQOKirmJgQ49BSs8dqHdM08MvaU30UIK2/WC2g0Y4e+cbbFZlCCBic+Bkwbl5zQ5oWIoqLQMn1o7WlzfHX1hJayEC2mQadRIMMWQKdUoXWGwUYc0nBXjKtFKMgB6gRAqoVPPfgEDvZ+M44qWd8q6ujFnttaY2AjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLVgWUT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLVgWUT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E3E1F000E9;
	Sat, 29 Aug 2026 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788000245;
	bh=CmVSERqrZBtooXvjlzvFe+wqOwPVLe5CWcaGiPdgc3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLVgWUT0zh+Cjy1ejyYFmg5TCBgtmIKTFkgu0Cli/cQ71SBV3SiXZwGadOYOuwnH0
	 tW8Q1IqavNj8n9x5S64/QOIMTs05j4RAYrFzGhN83lAFpkLTTSf8fmX3G1fd1v0HQG
	 UdG2o+CszkoM1ut9QAzvEqAubtn5QEbHGyrl+vFWJw4FaXRlk2c9khu7uklkpdm5nP
	 eklY3kRYalxW07TLdHrYNiuVkZeb9KjUkYWjNJLDNXfBngxfUw6xf+vTGDsjMbZV+j
	 shg0QycCXHq7jJJUgFy+DIX9vC0EDvbPyRM1g4f/klzvau2gEtEhgMpdgQ2Al+D4kS
	 Z+D7/qTIowQvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Only check bridge nodes for PERST# GPIOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Obbard" <chris.obbard@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
References: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 10:44:05 +0000
Message-Id: <20260829104405.94E3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `phy_exit()` cleanup on error paths during port parsing.
--

commit d82e202d67fb9c028268353a2d921329e5f1b9ad
Author: Christopher Obbard <chris.obbard@oss.qualcomm.com>

PCI: qcom: Only check bridge nodes for PERST# GPIOs

This patch restricts the device tree walk in the Qualcomm PCIe driver to
only consider PCI bridge child nodes when collecting PERST# GPIOs. This
prevents the walk from descending into endpoint nodes and incorrectly
claiming reset lines that belong to downstream drivers.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..89a476c370988 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -2019,6 +2019,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *=
pcie,
> =20
>  parse_child_node:
>  	for_each_available_child_of_node_scoped(np, child) {
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
>  		ret =3D qcom_pcie_parse_perst(pcie, port, child);
>  		if (ret)
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the error
paths for qcom_pcie_parse_perst(), I noticed a potential missing cleanup in
its callers.

In qcom_pcie_parse_port(), if qcom_pcie_parse_perst() returns an error, the
function propagates it directly:

	ret =3D qcom_pcie_parse_perst(pcie, port, node);
	if (ret)
		return ret;

Does this return without calling phy_exit() to clean up the initialized PHY?
If so, couldn't this permanently leak hardware resources like regulators and
clocks, especially if GPIO acquisition returns -EPROBE_DEFER and increases
the initialization count on every retry?

It appears a similar missing phy_exit() might happen in
qcom_pcie_parse_legacy_binding() if devm_kzalloc() fails:

	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
	if (!port)
		return -ENOMEM;

	perst =3D devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
	if (!perst)
		return -ENOMEM;

Since the err_port_del cleanup loop in qcom_pcie_parse_ports() hasn't added
this port to the pcie->ports list yet, do these resources remain orphaned
when returning early?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-wip-obbard=
c-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com?part=
=3D1
