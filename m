Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD14378833;
	Tue, 21 Apr 2026 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798274; cv=none; b=K091V26c7OjJkRs/DbtKhNSXRnzst0mabz9ma7ujpHErVoRHZpi72yMff20YfDpLXMTHewsLpQVGZFl2gyNp5x1heFVIt/NCKYMkBL76r0DMrIGxZ7izjE1N13Ub+S0Z6nLW3i2NtJza2S3XRB7i4IXwDUK4FWJmDKGlQDbjzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798274; c=relaxed/simple;
	bh=vGSgEq6cM44uhUC/9silgJZjUUvHJCLOcQcCNCOCDlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skQki7hPN9cr3vt6C/hFFFxsfY6tuQmhfSlSFG2/UsnfDCtRYfAJ8b47KLF4S3thSH5mc4jIg+twSEFsYbLyufYwsy8YpQA+QaTNgOxO/jhp5BmP35BUAmc2WzGxb3Yaisw57T9Qp1uLMw5zXvmphQbCo4U0Gq8HbU6/+sBzZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhAj1nGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhAj1nGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85788C2BCB0;
	Tue, 21 Apr 2026 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776798273;
	bh=vGSgEq6cM44uhUC/9silgJZjUUvHJCLOcQcCNCOCDlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhAj1nGuz6WY7aJUeYuqDmnWbP9IGCnZG/4Ug24MBdaW4laQ72NFSIc6/2yzE6awY
	 y4y/gOB00aiHLFdTZMcgTwUJbCCoHQcAT0XrdfpEdogNNGwBk1jIsVoWBaN1XrvCy1
	 c9Yr5ea1cdTRZ+It7R98pEoorAyxPLg/S4LWKCy1fk2HAxTUtWoPs7E2uX9b+ivL0C
	 Tm0Bc4LgC2gPEew6nQVXckoOfv/T65b7dJTOm0mdUaxD0g/+LpryBtkA8w1PU4mQBK
	 oKMSNdcXeQQohMnCJPN/pEW8txVzU5pSLd/h4BRDKKZr46Ni+t7mP0T3uAvljLmoXx
	 gKFZJGmIkSq/w==
Date: Tue, 21 Apr 2026 14:04:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Eckert.Florian@googlemail.com, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, ms@dev.tdt.de,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH v5 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
Message-ID: <177679827099.1487027.1375609169442766749.robh@kernel.org>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
 <20260417-pcie-intel-gw-v5-7-0a2b933fe04f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417-pcie-intel-gw-v5-7-0a2b933fe04f@dev.tdt.de>


On Fri, 17 Apr 2026 10:35:51 +0200, Florian Eckert wrote:
> The 'atu' information is already set in the dwc core, if it is specified
> in the devicetree. The driver uses its own default, if not set in the
> devicetree. This information is hardware specific and should therefore be
> maintained in the devicetree rather than in the source.
> 
> To be backward compatible, this field is not mandatory. If 'atu'
> resource is not specified in the devicetree, the driver’s default value
> is used.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

