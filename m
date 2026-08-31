Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5883AD52A;
	Mon, 31 Aug 2026 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165851; cv=none; b=Uh5r8lOa3ItfGkzxDctspZa6+4Gqeg198pUfVLCCXjgF9VSj/1CrK3YwMTyT/7eZ/m4D2YTkBrlRzBT2qOAjxnlWfchCtAAC1ukYU53039zTn1wBSxgWtP+c9vADGE09cJMWzibftANMphRQYXoQIkAZVjqQ5BxNnHjVvmXYpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165851; c=relaxed/simple;
	bh=SwaWKgsflHdP9q6JnN7qO4nrYWHuUTmbpqBZFga1aPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8FlFSnshyx5uxvQnYzqa4R5iuMyuVm3E/ed5g7X9c0fsc13Lc8XOknbpYz2iBcp0Na/JI8N3lb4mwZgflZr7vcl8tytHJqSyoo4lvtjsh5dTIesYdAHfNMo2Ug6Fk/pTakRqdOwgsaCWV4GW73G/MFDwXY5XZsCmdAsitUnipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFANuf6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFANuf6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841D31F000E9;
	Mon, 31 Aug 2026 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788165850;
	bh=H1RgWhyTfBxEvx3kHkEet9cSR5ERPAF0r/ewZQk2l+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFANuf6aC7FSqHRlkgdVvsUh3kaDEzddY/ZsVk5Tp6RaLZe7k8m1+a/AUux8i0l3I
	 I6DnI5VkUJ52e5sbLk4cM2Uj5mEf2ZkKbQV9BmNNbpeZNiCCdNZLRpcRlJ0LQfKWVd
	 a1ATBEwi9xL+4Bxmflh+3ajXshthvTQ8YZ16u1DqHFpNn3AyWnCAFbjLvFUW/cl79Z
	 21Rf+y8Mn1aEysBQ/8or5Z2HUeITicCnS5QMDNgVjUv2oa58s/JmhC7xZmdobN7AOo
	 iJQlP3rsUIDg3Q3Z8DNpu//dcVlRlxWQAxJWPV3Xf+qVsfOehH226mW9UmFRFZeAXL
	 gMolx8M25djhA==
Date: Mon, 31 Aug 2026 10:44:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Message-ID: <20260831-labrador-of-extreme-prowess-d36ceb@quoll>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-2-18bf59d19d6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828-nord-v2-2-18bf59d19d6f@oss.qualcomm.com>

On Fri, Aug 28, 2026 at 02:13:36PM +0530, Krishna Chaitanya Chundru wrote:
> Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
> controller binding.
> 
> The Nord PCIe controller is compatible with the SA8775P PCIe
> controller implementation and reuses the same binding definition.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

