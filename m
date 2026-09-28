Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A733F329A;
	Mon, 28 Sep 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624444; cv=none; b=HKDiWrBjoqN0satliiGVRRpwSvmnSI1t2zJ4zdxY1ri/JPrwgcQrjIhDYkT7E0xxWkV3Y4yroaLIZ2VY10ntsHXBz5/wNcxhA67L8rzLO0UpHhGrHXT5lMDhmNCGSZ3SuCcx6xh1GUwXsB3glD2dMcmOWMM1cIlxYYcIDk7DySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624444; c=relaxed/simple;
	bh=/I9wUT/a73DZNkgR89ROR/d5RaFiBXsxQ84PJp2nN+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDF2Mtdbd/+PeO9ZIOzV/r3ivdw00vRO/T6hOmwCuDSCXqoT9Q3maBOoR27a0zKSYpJMCBKKbtUT9KNKUTT23TfNuezMhTDHzynvKzv3tAGQSxIk6ByAGVP8hSMIBBahEBp7KLCzYAGul4QojIaWy8PXS2wUIfpmjlOzpApbzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCUiQEZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCUiQEZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3571F000FF;
	Mon, 28 Sep 2026 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790624442;
	bh=3xpCepZjbk+HPBWZeIYa5wSUCmkpTH/xFwZRA1DPzs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WCUiQEZqAHXeH0TFJUhzCGOiPvcDLKRZg/GVrD+nKhPWAtqTKMbr4MimTSDO+i3gm
	 xlz0JQNzt1YMbtwRqxEwWLJ+V2KmpaDDayS7074IOTJ1rdz5fzIFiMSV+UslzcquDe
	 m+6yJhM7/3QhJDz+4orooBWkWk2qmWDeokuvZIocc5nZ99cMVoTRvBbAIeVpCHXVuX
	 pZqq3FMdNi5gbdBXKRw69XwX7TSwlP5Cb7AMM6RNYUZi3cYOFYB/gQQydEU8cuJrtL
	 6mGMdz5LtmmFiL13e9kXpowStoYrkVXVo0jn1mfhSrTUPVfKNXYzP26eTIhGPFK4Yz
	 4iHQwnUFTz4mg==
Date: Mon, 28 Sep 2026 14:40:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, krzk+dt@kernel.org,
	lorenzo.bianconi@oss.qualcomm.com, bhelgaas@google.com,
	abelvesa@kernel.org, gregkh@linuxfoundation.org,
	konradybcio@kernel.org, andersson@kernel.org, daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com, devicetree@vger.kernel.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
Message-ID: <179062444007.434716.14459027711381979772.robh@kernel.org>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152659.413268-2-elder@riscstar.com>


On Fri, 18 Sep 2026 10:26:56 -0500, Alex Elder wrote:
> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
> 
> Multiple internal components are accessed via PCI function BARs, as
> indicated in the diagram below.  This is facilitated by the use of the
> devicetree pci-ep-bus mechanism, and is demonstrated in the example.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v4: - Dropped pci-ep-bus@0 node from the example
> 
>  .../bindings/misc/pci1179,0220.yaml           | 146 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

