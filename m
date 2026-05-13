Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE75474F;
	Wed, 13 May 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712794; cv=none; b=ZvbqTdgsVMIDTCU1dJOxvzjaAH1/XNoxKp6cmBfhqyOb8WWWbRvnjc+zcsG4nB/ivZSe6HtlV6GKiLsSeAsfPCRC2oUYu9POaEPySeHrhCn3RGYPvEugj+s9kRgkaPasDsZwyWwtChXwKyUDwmfO//RQ5IowEVAHjRSknplH8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712794; c=relaxed/simple;
	bh=AN1QHTAv38tgebsk9jfG3IihVDBo31haiLN3h6IqvqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1Rp96SMF1DOb5/0rPjECbZ5FmMQxmmi3sSuhF06aZDoLZIIjl+HannYLXvnHvQq0GoC4pHTghyn4cKPeD5jthDPrCFvSjHB9JDWr10d7cCPZ/5GTlXnO547ecn78Xd37KLtoSJqNdnV/8539gznaOKwdH0M0Yw9U2oTYaoTGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6Xz+hhe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6Xz+hhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265A3C19425;
	Wed, 13 May 2026 22:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712793;
	bh=AN1QHTAv38tgebsk9jfG3IihVDBo31haiLN3h6IqvqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6Xz+hheZPhukeOnlYC0B0B6R4FBhjhES3C1p1EasYXobZ9nJ+BSEx8uZDTYgvZaj
	 +wl4/i38doIdA/OI103ZHi+azUqayRhXz2+rYn0DP3oN98KFZEKP2imT+R+4d/P4Ic
	 E8F5s9ezUfDEnIdtwmSU9vKGCOhEUidAd7vK4B3qbnq6TxDwB537YPcFcBSnxpweUB
	 e8e3iuNqwkyjaaWfYgJC4qIrSSobkiYLG37GdDGEEd0QxfKH2yCmjj10Shy4JlkoKY
	 juleDjlmU0kaO0T77Gc3na2ogl1yqv2jFrvTbSPbf97M21Qq9kWROwVnLn2UjcP3tq
	 gdc3DUY8VTgFQ==
Date: Wed, 13 May 2026 17:53:10 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko@lists.linux.dev
Cc: Matthew Leung <matthew.leung@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Message-ID: <20260513225310.GA2251300-robh@kernel.org>
References: <20260508-hawi-pcie-v1-1-0c910906f7e5@oss.qualcomm.com>
 <20260508012135.76B34C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Sashiko is wrong here.

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
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260508-hawi-pcie-v1-0-0c910906f7e5@oss.qualcomm.com?part=1
