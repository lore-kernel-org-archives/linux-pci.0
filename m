Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF437E2E1;
	Thu, 19 Mar 2026 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942784; cv=none; b=Gv+jFDZxhgabIKfTc/BtBlSUdv4+QW9IUC2slJmzF8EryCG6JMjDiq6mRhsC2k9cOA3ld7Da181a8SrXCxOjNEHNzHm/xEg9AogsFDaZg77VVzvbofPWq1ekuWL3HZhuyGjIIattryCgv4OLSULV5I/P9ypNXeeYyxm34WuMON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942784; c=relaxed/simple;
	bh=c21EifNlwYJaihLzK5u4w0PXJg2QU1NqwXOtwKF1aVM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=M3vxWYESc57zhgQtOfdf00mZHNRA7ap5LSF8gwDkwwyge2UqzrZZVCGavVkIGDY6bcAWXQa3weLzNhDmH6eqTjVZzsbRoVQtodxd5/I8XKzxEVeihYeZ4W2QNP9viXBd65YX74OJgYxu9ePzDnoh3SMnDaUFW3CzA0yoEN3kfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2+nUQXW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2+nUQXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35033C19424;
	Thu, 19 Mar 2026 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942783;
	bh=c21EifNlwYJaihLzK5u4w0PXJg2QU1NqwXOtwKF1aVM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=o2+nUQXWJ79DgKrMZPQ+FlGFKHKqyHXI+35kzq5yYIxONjo0GWxUtZ2FoRgbLdEHA
	 vJ2CbRHNws05thzpJP7ggMevc4zqxRPHWA7Of0uUsSx7CU5WKPZquUJv7s+ppSQ4Xn
	 AJBxub0fpRaikxXvCr5yHjB4xDFEIwjkZDVhH4ujaowNuvmJzgxeG9Lcen7Qw7HlZB
	 tFxFVvYgmm9T+RGzCXm88NahH+CEWnY54NWRyomRQd6dPR+51OHYyP7KY0FBMQ8LU4
	 pIjGW3TlTSQucZSQdpY5+ABzWvk0RhgwwRhrpGAnQVDPcdXZb5iC7jKQIIAgyIVJ8t
	 EdtfQosZEcU1Q==
Date: Thu, 19 Mar 2026 12:53:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-tegra@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Hunter <jonathanh@nvidia.com>, 
 devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org
To: Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20260319160110.2131954-4-thierry.reding@kernel.org>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org>
Message-Id: <177394278234.2969412.4041012673880757411.robh@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264
 PCIe controller


On Thu, 19 Mar 2026 17:01:07 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The six PCIe controllers found on Tegra264 are of two types: one is used
> for the internal GPU and therefore is not connected to a UPHY and the
> remaining five controllers are typically routed to a PCI slot and have
> additional controls for the physical link.
> 
> While these controllers can be switched into endpoint mode, this binding
> describes the root complex mode only.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml:61:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260319160110.2131954-4-thierry.reding@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

