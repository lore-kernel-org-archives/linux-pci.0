Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81F175A77
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203296; cv=none; b=Ozanya36ufp6jRhTrj2umgZE+I8gvHbvDFNlPcNV+Lw0shSBGszChhSddx48uevh0xGH60UgA7bXBJTckLItnNkNVLks9IHSJZZEZJJpCRV7BKB4/zik3TO1qPyPzaihaZyjgySGsQil5nL9JuJRSKLje/gWJK2x2p0H45OWisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203296; c=relaxed/simple;
	bh=JvADbxKuWFwpx3Dol+y7xkplrW6iqAs6vzsBYJ437Kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdSTCV3hhtoNk+XO1BYrFxgCcxkc84XiuLpnFEfhbDPUFzePs+nzbekM5CXUg56XxUAzN19OmVPeV82voHRqYXhqVfkd2B4UoHtuAWdDk6XwnPUubadLVCaPzRNbRS8OcjifiQSmeGnjuGuvuYRAohQai/eXjzhyVrAz1SSbb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkDm12GS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkDm12GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B34C2BCB2;
	Fri,  8 May 2026 01:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778203295;
	bh=JvADbxKuWFwpx3Dol+y7xkplrW6iqAs6vzsBYJ437Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MkDm12GSMGhh/buKXL8p4nPfS07qkkn9gVt3+X8Mk1PeRf1fKOV7ODKfEhhb9xz+M
	 hx7fJqK3nJcPdVO3MSro6ZhkgF8FgJRk8cGo/QVYJ829MoxZOpiTaq8C9AMJ0orrMa
	 181nCi7OUPLubhXPmd0axPt6K9p81C3LCZfGTuclmJAZujDTrDC2TPmLyZKQRAzKzJ
	 MjrL1cf7JpB3ssQl5pRf6bmMAlHflVeK5hLZTxueHuPxbMlCvyxONFig2AJOMw1Org
	 qjVgp43OgkVxjcA4w1yXmSZ/dC4n3WmwnbcX3kR+6Fs5XQjtBQ7zWzUwiySaIvRS5G
	 P3aHbB9wPtyZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Reply-To: sashiko@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508-hawi-pcie-v1-1-0c910906f7e5@oss.qualcomm.com>
References: <20260508-hawi-pcie-v1-1-0c910906f7e5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 01:21:34 +0000
Message-Id: <20260508012135.76B34C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The compatible string and filename violate the established Qualcomm=
 PCIe naming pattern.
--

commit 332996956780b2d8736ee1fcd6b38c1627f71689
Author: Matthew Leung <matthew.leung@oss.qualcomm.com>

dt-bindings: PCI: qcom: Document the Hawi PCIe Controller

Add a dedicated schema for the PCIe controllers found on the Hawi
platform.

> diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/=
Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
> new file mode 100644
> index 0000000000000..154bc88e59694
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml

This isn't a bug, but is there a reason this file isn't named
qcom,pcie-hawi.yaml? The rest of the Qualcomm PCIe Root Complex bindings
strictly follow the qcom,pcie-<soc> naming pattern, such as
qcom,pcie-sc7280.yaml and qcom,pcie-sm8550.yaml.

[ ... ]

> +properties:
> +  compatible:
> +    const: qcom,hawi-pcie

Should this compatible string also be changed to qcom,pcie-hawi to maintain
consistency with the other Qualcomm Root Complex definitions across the
subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-hawi-pcie-=
v1-0-0c910906f7e5@oss.qualcomm.com?part=3D1
