Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE3442B3C;
	Fri, 25 Sep 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341862; cv=none; b=gWyK2NteZbxWOWCq9hDyv+/ChLUAxT2ck/oAGTQNwZPQ35yyiSNz33UuYnJ3feiitlx0zCFbHgJu3hqrFT+EhqWeg0H7JMDECZKFOXLFx9ZuOsY0TlRyAeYxNh48iGgXwQeIKav1GtB8sTq6UKlrdlfZkci1iPH0kQJJ904vzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341862; c=relaxed/simple;
	bh=509zKjJim0GG5jL8NdMoH4U8eOJwMUQ5iOysVNkLZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFdfWW3I+j6/lOCO1gI6l5Qv9qRLRvv7UfxZP3Az+DJspuCRNDZ09GQtE6/FHlilcs7DDfz4X5xNLIcNbGQcOKwZ+rENQTyVz8hQUDpO87lbqaIgRY9Jtwyzfppwua4Bf2pW26BcmSSPJihtnulFb0o3lbMEBgv/VeVjdnVCLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGDWvzUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGDWvzUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404361F000FF;
	Fri, 25 Sep 2026 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341861;
	bh=BB+RBucDn7drafKRirY+tsjOIqaMLesM5kPeSmCd7Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGDWvzUz5K7sPSuNwzw/BAgvYQUFyLAagTEKLuLXafBAuYKXiXsSVDgsFU57wslfG
	 6mHKbUEirDLfW+s/HU0+Ed92AOIsp/ezcuUvnwb5+UWWk0h3c2hG55RHLc+ZaAKUsx
	 82kXvNsvImo3Jqqg4vq8elG+OTSJU/RzHX6/hRdFF9I7exrq48mzAmw59u8T5eE+Sv
	 tDDiycX9zsJKK8AexpuXZ1/H9pVFHCyEz7NAlPGRb3qjxq8NOQmjjnzBMNjHx95Hvf
	 Fk1q7+wKkRCcjWzYMElSrJxGDHYrqHup0A7oLF1l0nFwFFVu8HOhmPUQvxusgwLI4D
	 zeVclsXl5v9BA==
Date: Fri, 25 Sep 2026 15:10:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
Message-ID: <20260925-nocturnal-voracious-lobster-3de6ea@quoll>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-1-63c5282fb0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-monaco_ep-v1-1-63c5282fb0db@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 04:28:12PM +0530, Krishna Chaitanya Chundru wrote:
> The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
> the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
> compatible existed for this PHY. This was a mistake, as it left the PHY
> undocumented as QCS8300 hardware and indistinguishable from SA8775P in
> the binding.
> 
> Correct this by documenting a dedicated
> "qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
> "qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

