Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFF4A7C82;
	Thu, 17 Sep 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683714; cv=none; b=i4kh41PvLYE0/+lcIiYcnBsplygBXhbDrS6XMhGbrBibFothTW/MezpRxyf5O7ftrHYP/6ywymtLCjM8HMZe3PLzxHUnSkwmfEA8hsE2hSKZAj9YP5GM3XajkiITptcqKTdoGWWvgv8i/T9iXFuyrU8VTFeZggqlAHt4vVxQE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683714; c=relaxed/simple;
	bh=J4FC4khpeauWm78bJssX85LNLNuSo8lIcvo7zpH9wM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADlJH2QqORLDDBv8quA4UCdXJ71iP8TDacnnDjPj9oO6CZQPqFl03yJvQjmZI8YJyt7vc7GDh+8gzZNFOMFPQGXxd6AXTZQP29XRORcsjq3a5hSlzs2Fc98A43P8qUVFbs3uy9LI5rzNi3LKM6vdE5n+9fV5YOUtjE61vmSyspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO6zGBV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO6zGBV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055BE1F000FF;
	Thu, 17 Sep 2026 22:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683712;
	bh=kv24bXbWsAIcA8t1uQLZ3qdBM15Z4Ui+R4ZrwqfmtgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eO6zGBV8OH2sh+6SoNrW82MS8trZVYCcqbtX0w9WIAxuhO6SmGSW21LqQqQ6zlwOS
	 zfmTALyq8xRqpdLIbWiW0As3yN4KxsToZpCzPgvSvHEeJAio4E4EOPmezf0UURkzLD
	 UGw/QMqP9udz7vmkqJLepjNAu6jescjbSduu7rZ12YM7GAUxKuo7OouA5T0mnZr3Et
	 A0/lR8+afPUcWhWrkNRVOMhVRxekQH/2OFjlhchEq1pm8kItZhsWupGbkede7Bqbpv
	 JVpSN33zEtu9F1iqTpl9cgnOPfzOeMByIds6HYCd9WPPXTuRGiRqr/mGIhEYcrhjk4
	 TbcpOafrXFU+A==
Date: Thu, 17 Sep 2026 17:21:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
Message-ID: <178968370961.4071859.17924970660402899315.robh@kernel.org>
References: <20260902142449.735168-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902142449.735168-1-thierry.reding@kernel.org>


On Wed, 02 Sep 2026 16:24:49 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra PCIe controller bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v6:
> - add additional constraints for num-lanes and phys properties
> - reference pci-host-bridge.yaml and drop duplicate properties
> - reference pci-pci-bridge.yaml and drop duplicate properties
> - drop Tegra30, Tegra124 and Tegra186 examples
> - remove unneeded properties from examples
> - reduce number of ifs
> 
> Changes in v5:
> - drop unneeded quotes
> 
> Changes in v4:
> - remove path references
> - use dual licensing
> 
> Changes in v3:
> - fixup reference in MAINTAINERS
> 
> Changes in v2:
> - drop description properties where they don't add information
> - drop redundant $ref properties
> 
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  .../bindings/pci/nvidia,tegra20-pcie.yaml     | 532 ++++++++++++++
>  2 files changed, 532 insertions(+), 670 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

