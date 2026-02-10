Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAB2765C4;
	Tue, 10 Feb 2026 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691062; cv=none; b=aOMuuRHhSgfpJaENsokhj1QIUktZ8NRJHPc2LwIUpJTdF/LPaac7j7vNuiPgwXMD3JtL0q+yrSinqckJHWYoKIqUgD4r9zjql3UJ75TE60L+8CCTjX7s5PpUG/jBXQfENZTXWyJ9bGcUYrWL0LE5pVPB8rmBBQhHZ9Lv4ITQ/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691062; c=relaxed/simple;
	bh=1REeQ9bmhabHDdl80zGNRmd69dN2i8Beu8762qMZG78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNV5qC3W+GDFYpc27HlopQRubOFOMH6o7+0T3YvvdA/WpLHgqGficrdzfM+wVZzImoXgJhRjZZUBkwKa9JAy6INKs8wZlXEyAJoguuc4mrKvwcuGhfXbZJiPaJPHJV/VyBPSgnI7sXJntwip1X/RSeJc9QpALPlIC4g+fw1Xydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzRMz19k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzRMz19k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C41C116C6;
	Tue, 10 Feb 2026 02:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770691061;
	bh=1REeQ9bmhabHDdl80zGNRmd69dN2i8Beu8762qMZG78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzRMz19kLrMZbrV3DBTXVa/+qGr13rHrDkrO0kOrH+rQRx3xVGCAfUx8eg5kDB7t5
	 NUMpk86kcujYCLnAMCJAVFxOyd7ivT0mIfpwCi7QpgmcwCGOz27apgBk5bkczTFowB
	 7tXAf9ZUDLAns6d5TPvcY4ddT5xrl883nqI1yZV4XfEMeDgEKk1A5y4aHP/EkRjePN
	 caJ3Zl2YJyjJtisG5K686si4SE0yGjoigQLxdYp1F0LcMqAA3JwCc0TTJ39ci2cFIu
	 ut8uYsbljMZ1rXuIzvhDpxSi0TZJoPCpfZC6benZTLx233CBJF+fRVWVfeC7bvm2ZK
	 wAeLfbB9McawA==
Date: Mon, 9 Feb 2026 20:37:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-pci@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: usb: document the Renesas
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
Message-ID: <177069106017.2372479.10101805621676479866.robh@kernel.org>
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
 <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-1-5b79c5d61a03@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-1-5b79c5d61a03@linaro.org>


On Fri, 06 Feb 2026 15:50:29 +0100, Neil Armstrong wrote:
> Document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller,
> which connects over PCIe and requires specific power supplies to
> start up.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/usb/renesas,upd720201-pci.yaml        | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

