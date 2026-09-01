Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F038A70A;
	Tue,  1 Sep 2026 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251757; cv=none; b=qGgKOSkCPlsRdj8HRQO/A8ElhHgi4QYkBMzlY4DVy1lft4+VAfYHBd3JF+i8P2IC+juDParm7nlhJgQS7Bb5WLmDXYvRSDF66Di1b+MUtRg7jFfvsmyVr2uTahQ9hdvlJbPcCwWBH16UlDe4lo5J2MBh9umgq8/ZyGl167N9A/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251757; c=relaxed/simple;
	bh=ejXM4o2eI398h9BwbyEux6vqf6ahTS4ZsFS89gTCLtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5BiQftQV+1bRRBjThdZBLHRlA0FcoiVnQiSAcRSegEsIxU6SflQVyjHMd3LlHsIFYauo3u1Ccj9lQOwAIeyWloT1tF2jy+rGpg388Sz3idTuNaL6daBKmenCMFUjiIITQKeGUEOjCrQ8xJxj06qZDoeEqDA/rfu/G9pOmwW304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSKetnT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSKetnT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA611F00A3E;
	Tue,  1 Sep 2026 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788251756;
	bh=LRg8cOH2yhtMK8xZKKhCpBpPzrE9IMBjAJzTWQG2Iv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSKetnT14/y+tfagfPCRYIz/L4Ya/Fn7azc7kL4rWqMC3MA2o6kU+2nOC7Xe9k6OM
	 sXvkQp6gAI6yWgMdSCDgW8gTDXthFDHZ207jfVGMej22lTZxBK8nEGEC4e1sCAqCnN
	 YQCbh8YusX+SoPCF17q+0t+1ey36mPWwDaEuB4R5zPQf3xu5z06V8SrtjqRp2E5+fm
	 mqUDk4wQuS/rcdzNOqr77UlLXCFQlLkmdYeptK8d5vPo8AB+BoLkS0h2bQ4kb8uvNk
	 Ql4lSWyuqg2ykVUOo0Mhks6VvZEvncZ8Qr9PX4RCVZhzMjylMGiQQfA68TqRojF4JR
	 OEhn6HaLU9rqQ==
Date: Tue, 1 Sep 2026 10:35:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document
 Shikra PCIe phy
Message-ID: <20260901-statuesque-radical-beaver-d00f32@quoll>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 12:56:01PM +0530, Sushrut Shree Trivedi wrote:
> Document the compatible of the Shikra PCIe phy which supports
> Gen2x1.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

