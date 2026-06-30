Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19647AF65;
	Tue, 30 Jun 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851730; cv=none; b=nnNIge03Hciq7Nz4KFYZ6fYY0lRxLf12LFDDSNLxFfVmRTt1c++CJcfkei0btZNyxjMHlrZEW3LofY8BFK4OeO3nHo0PTrHvhHWD2WaWYjO5FJMPZoB90ktHDQ0EUFg22z/mI+9t+/pSimyz0Kefu+OvFDrv+C5eNW0YYbMZeSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851730; c=relaxed/simple;
	bh=tkg8nVEqqXYX43gEKOS3TMQYETGf6DEjhH+0GmLLeeQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NNYqP0NPlhEtnERyKhcUb4q9HsAcz/qDQlqJLqQgXom1oBUs5VFVnGI9+mbUyTN0rTcc4vI4sEYBXU+Do7tspvQOfLWeWEnT98gUZQnXKlPZgmNDBoWc+cRjm6GTpNiCBFFKuqO/jYE+7JqHhgMQ5ojIQtb7kMfLX86kkS6iEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbXC1NWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbXC1NWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787A1F00A3D;
	Tue, 30 Jun 2026 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851729;
	bh=qftNGGZWrMmchAzPZPKZHnzgN1AhLH5xq12HS7B9G54=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=WbXC1NWDr4Z7ylt3zPbN/9n446x/FYV3nkwEeboT1OX7YrbuwKasMTmEIrO3SsKm5
	 nkj+ylNvCq5QA3JQ49A2kY367+4uH25COxp3yVZzNZUYXMp1gpR3Q5TaJutYUKDbQd
	 wqIgbY9GpM8OZbB1u4z+Y48o8RA1P169YmYRCWDP/Czb+WlgXw86stOnMU6gsOZaZU
	 2m16QZGT4mPKK+vHebttdbn+rBTmYt0w5UkGpp+ebduw+aXwzC7Jd4lYXemLeRiVut
	 JiHO44kcjdO5Z3/icdJn26/nP2i8kUzc82BHOCxD1/Sbz5/0mq0cCFLjM7BCIZKrsx
	 cWxxLAx9YfRAQ==
Date: Tue, 30 Jun 2026 15:35:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
Message-Id: <178285172702.288391.13610342196466613275.robh@kernel.org>
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios


On Wed, 01 Jul 2026 00:32:45 +0530, Sushrut Shree Trivedi wrote:
> Add devicetree bindings for TC9563 GPIO's which are
> used to control endpoint power and reset.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:32:9: [warning] wrong indentation: expected 4 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

