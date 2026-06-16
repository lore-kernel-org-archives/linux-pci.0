Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71C472798
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626855; cv=none; b=dF6VuqtKNYJUatmsXxihKqfSDIndu+OTe5KT+59+EhDI8SCgITse3E5swHQzx3YTdWrMZ4mADAk9fhOGKL+FBfccItOcBigHsK5GlXwm7T2e7ELMOMwBGqnsNFs4D8yQEKqcTnCrsSt3OP3GlJ1agImmX9V0DjkjnyyucRL5Ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626855; c=relaxed/simple;
	bh=n7i80wyXtlubT1yEvy3vWu5JbLtnFgwU1cimaS1dmBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5/cWgo5jiqAohv4p4F5AQ8IzgrJn60rXUxRRuxfQUxeZ/YgYKBdaEd8WqPPb7stSDqIHPz13T9MKPWjtBLG1z64F9dRnPyKJjScgS4t8daccn2NnAwJdaLd6SEBx+sj2WfBXysoBAAxEcL3QfGh72F1chi+JFTx5+iEIURXKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivtx2rRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivtx2rRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCA01F000E9;
	Tue, 16 Jun 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626853;
	bh=n7i80wyXtlubT1yEvy3vWu5JbLtnFgwU1cimaS1dmBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivtx2rRpVbCXMYTHR3Vf5QHfpg9/y8I/1MDyNCR4oABNcmd9pKbukRyou54nh1nKG
	 CBPcwzQzT0r5hQi+gYrOFukXnmXaBeG/QlUuRqdtCs8H/gZ0Ur7TxB79xfQziJa0XO
	 Init3UgcRr7twzC5JLfL+gsKykRjCpdLOGELNY7WtjvXsz3yyW6J6Snqb351NNQnYR
	 hDwuwRkBlgfB1ybZct+1mYiXHM3ElOpmpiuzxQxAEFDDlJqeuMTkTJUDsgxOUFi7u8
	 y8VKfB5TNJF6iYFgfvk00ewt0hExKUS5BJNo1nUecc2+Xj+YZXtTXDkr5JEZoy3QZh
	 DVXKwpwmf792w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Skip PERST# GPIOs provided by downstream
 PCIe devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616-pci-qcom-perst-fix-v1-1-27600d6ae357@oss.qualcomm.com>
References: <20260616-pci-qcom-perst-fix-v1-1-27600d6ae357@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:20:53 +0000
Message-Id: <20260616162053.CCCA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> Currently, the pcie-qcom driver recursively parses the PERST# GPIO from a=
ll
> child nodes defined in DT and acquires them. But this creates issues with
> PERST# GPIO provided by one of the child devices like the PCIe switch por=
t.
> In this case, the RC driver cannot acquire the PERST# GPIO since it will =
be
> provided by the child PCIe device which was not yet enumerated during RC
> driver probe.
>=20
> Fix this by checking if the GPIO provider is a child of the RC's DT node
> (i.e., sits behind this PCIe controller). If so, skip it, as PERST#
> should be controlled by the respective PCIe client driver implementation.
> GPIOs provided by external GPIO controllers (e.g., TLMM in Qcom SoCs)
> continue to be handled normally.
>=20
> Fixes: 2fd60a2edb83 ("PCI: qcom: Parse PERST# from all PCIe bridge nodes")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-pci-qcom-p=
erst-fix-v1-1-27600d6ae357@oss.qualcomm.com?part=3D1

