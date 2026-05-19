Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4C285CAE;
	Tue, 19 May 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198084; cv=none; b=FaRFsKMMy88nNQzEyx9OwC5ViW/Z+EZkMaKHja9QjztUY5tWf67pLcn4cmSD228xYQ8FaJ2lP8dtXAqbI8NblpaUgKmCwdjtIlevoOILPweXED5mjGfOiVuVG2MVKf0v1Oq02l9IhLrIWwQCzgzRoVsg35mdtykiqVQR4OkcXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198084; c=relaxed/simple;
	bh=1WRhix6BgaKOUWaMb5YbwQ1MpXy3E2v5sqDQZ1RmoTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arc9H2ncEqueVtl0KjCO4ZWMUzxOEQDQMVgYw3F23FKAFN9zLnDL8b1BTA5OOD8504ubO0kSE0jbr8WPao+7yCyeeMhNrpg2a0tBiwoNBNBr7roHda4R4Xds8Q0qrPA7R8nBSd0fnwEF29TQAOwIzLXWwEPE9XE7BeKusiTKqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Cuo6pQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Cuo6pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505DAC2BCB3;
	Tue, 19 May 2026 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198084;
	bh=1WRhix6BgaKOUWaMb5YbwQ1MpXy3E2v5sqDQZ1RmoTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7Cuo6pQ4PYo1rD8QqjsaGGxboIMfh5SR4/UGAevg5WDLph8KJ37SHWSjosVn1Y0h
	 iRB/dGWOH/iIiGXIAQd+nKIxasGXTQyTghKcebXw/QMPV+ygHC95W4A5c0WbeaZhSH
	 PKp3+v1vsnBQYFLe1waPs5GASUVc2y0XVKrnsOTdlLbAlmtZiBZoi3aRAO+uUY0b9Y
	 9ATbeKpC85VEU9P5iJMXP2CTQwD9zib+Vp23PUnkAWeN82fH4HvxHi8sOFuk2R9GPI
	 tilkIJlDk92OtZTiHewjlnwmRXRrnphOzn6++9i7Ea98ZKi9oCMsxvKyhf6N7mTUMo
	 rheXUSibuoodA==
Date: Tue, 19 May 2026 19:11:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko@lists.linux.dev
Cc: Matthew Leung <matthew.leung@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
Message-ID: <7gl7nidvytiu64qwssp55jpcetagefsnwb7ylq54miegmekdyh@rjhietvwqntu>
References: <20260508-hawi-pcie-v1-1-0c910906f7e5@oss.qualcomm.com>
 <20260508012135.76B34C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508012135.76B34C2BCB2@smtp.kernel.org>

On Fri, May 08, 2026 at 01:21:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The compatible string and filename violate the established Qualcomm PCIe naming pattern.
> --
> 
> commit 332996956780b2d8736ee1fcd6b38c1627f71689
> Author: Matthew Leung <matthew.leung@oss.qualcomm.com>
> 
> dt-bindings: PCI: qcom: Document the Hawi PCIe Controller
> 
> Add a dedicated schema for the PCIe controllers found on the Hawi
> platform.
> 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
> > new file mode 100644
> > index 0000000000000..154bc88e59694
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
> 
> This isn't a bug, but is there a reason this file isn't named
> qcom,pcie-hawi.yaml? The rest of the Qualcomm PCIe Root Complex bindings
> strictly follow the qcom,pcie-<soc> naming pattern, such as
> qcom,pcie-sc7280.yaml and qcom,pcie-sm8550.yaml.
> 
> [ ... ]
> 
> > +properties:
> > +  compatible:
> > +    const: qcom,hawi-pcie
> 
> Should this compatible string also be changed to qcom,pcie-hawi to maintain
> consistency with the other Qualcomm Root Complex definitions across the
> subsystem?
> 

All other IP blocks follow the 'vendor,soc-ip' naming convention and only PCIe
differs from that. And we already have some SoCs using 'vendor,soc-ip'
convention for PCIe:

git grep -r "qcom.*-pcie\"" arch/arm64/boot/dts/qcom/

arch/arm64/boot/dts/qcom/glymur.dtsi:                   compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
arch/arm64/boot/dts/qcom/glymur.dtsi:                   compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
arch/arm64/boot/dts/qcom/glymur.dtsi:                   compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
arch/arm64/boot/dts/qcom/glymur.dtsi:                   compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
arch/arm64/boot/dts/qcom/kaanapali.dtsi:                        compatible = "qcom,kaanapali-pcie", "qcom,pcie-sm8550";
arch/arm64/boot/dts/qcom/sar2130p.dtsi:                 compatible = "qcom,sar2130p-pcie", "qcom,pcie-sm8550";
arch/arm64/boot/dts/qcom/sar2130p.dtsi:                 compatible = "qcom,sar2130p-pcie", "qcom,pcie-sm8550";

I talked to Krzk offline and concluded that to align with the common convention,
we should keep it as 'qcom,hawi-pcie' and use 'vendor,soc-ip' from here on for
PCIe.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
