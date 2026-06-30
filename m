Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3926C385;
	Tue, 30 Jun 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847105; cv=none; b=jTdVN66xwt3QCxFPotibuUHH3sDwSi9Nt/L2/lghZ2kDgZAY3SndYMpZrrk/GgOmN3fE1+xLUAtQDDcpOS2AwgpVK434MKBkgMfTVUOxL1UG7+IuIqvdS2P6LjdceXQF2HUwc1jbM3Og7riQtklL5FO4jDm5ssFv7IPh0cItV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847105; c=relaxed/simple;
	bh=FvdcQDh2kcTuk1K8X+k77Nvr4gLVNosNtb/MQkKwhTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X3rtGX8xMywq4CC9Az5TAEKWsRMFqxV0uEWz6kzEuBi1eTJtvcEGffx6do77b3ZAR9AoouCFX8legiff8oSaVfSWaLfoCpLoSfZORQxIyW1z+J27agPotT0dOawfOsqS0k5oRswiuBHCeNuZoITF2tI0C/DULha5L81k0IyVImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUUPhn7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUUPhn7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C4C1F000E9;
	Tue, 30 Jun 2026 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847100;
	bh=2VwH61PNxnmg27VmPypSLBntbvsP7xtRL4dPPxY7evI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IUUPhn7ghLH7E+O5Y9mLmsf17f/RsZ+peDy3mO6MNoAep1sx07SCCWnT1Y7cEC8+j
	 3G1HNqmo4s5yluF8WlIrnWt3ni+SqIr1uq2IFxCsuA+QTJ41I7OuRiSjunMiRbMBC5
	 HR3Irh9zeFICBQZrzBXGuEzHSwL5jGNF4kQM0MnVnfVSemRQrsqRrAgJ6IgZQTPXcy
	 tnavyPRi7KMZFK68XPOwQ6U9WMrG5fimZBS1qqQAkS9ndpsEyd/cyyQ/TJzky317x1
	 x3U9E4O37zyzp1X0dybhQoe10I6J8xE/SotKxylYJtZWIBZl/L3rL20CVyxT3uNyDR
	 cyKkbAxRr+wUQ==
Date: Tue, 30 Jun 2026 14:18:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: PCI: qcom: Document the Shikra PCIe
 Controller
Message-ID: <20260630191819.GA218584@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-shikra-upstream-v1-2-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:44AM +0530, Sushrut Shree Trivedi wrote:
> Add a dedicated schema for the PCIe controller found on the Shikra
> platform.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 211 +++++++++++++++++++++

Existing schema names are almost all "qcom,pcie-<SOC>", not
"qcom,<SOC>-pcie".

Subject lines typically include the SoC, e.g., see
"git log --oneline --no-merges Documentation/devicetree/bindings/pci/qcom*"
