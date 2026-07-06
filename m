Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253E3E1683;
	Mon,  6 Jul 2026 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320425; cv=none; b=CFF9pbp4ISN+OhcurTmiAjJEgSqoC5UGf7pgwL2whhCiILYUusgAKL5qFZ8TuX0Wpe0WXZYmsFIE1neY9/hayqxjTIP8ydZ4JOv6OHmyDJrx+gUD6GVl/x+jdzpvt5wqNBTsKXVOXJgNFFK0F15NzlfEOoG6092evUqTPE/Pc78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320425; c=relaxed/simple;
	bh=Bnc57kM2hyhiQht2jHHX8P8bXMUi6sOvMlxUcCx9oRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy40kEar+1ICGiSz/WU5nNRnBcMtMMzcp4teq4EtN+XeZlJUXASE+qPdPAsJQ+jz1U7+tQBI22vBotkgyK+rdIrsjaWNNBvqvjhv4LvibsP3NQi5sNrAt/JgcbSHwtmxcoJ4KzQKFukq1kbPQpW3pi4LcK+kZcXJ1AA9NdntDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfgEkCm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfgEkCm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8129D1F00A3A;
	Mon,  6 Jul 2026 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320405;
	bh=YAlwsu7K71d3yW8VkpJJ1Rx369N8TEqX3Ic4N2qqkfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bfgEkCm7VawPLSDl1TRfWPE6bWazrEeu1sJjlV0x2i1b8s99il3rrkHlXdVuUEQ6R
	 LEl2dipgnbgxYCzsxFMLSBm+Ca6dlTZwyp96c8xEkxZhiKkQao/zM5CSONllAjZjTP
	 Q/eHG5XOkeiDFpTEYUzIKfiPGRJlqLUUfn6SoxRHV0JtHoqtylnwKaqfwaBwOGLahq
	 NOmcHX62qhBDt57iXxoAb9BPFK/l1Fqja7sBGxfEWyQa/eDvpRHfRkbZu5gxfrPeqG
	 5+FSpEjOXga0ajR6mxpea6gFg2C6auwIbkFz3Xy7OgE9LwOnfvAmCQ1O1WEgG+gY7E
	 z5B6jSVQ7p7DA==
Date: Mon, 6 Jul 2026 08:46:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe
 compatible
Message-ID: <20260706-pastoral-okapi-of-reading-e5bdb3@quoll>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
 <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 05:38:40PM +0530, Vivek Pernamitta wrote:
> Add qcom,maili-pcie as a compatible string that falls back to
> qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.
> 
> The Maili SoC is a derivative of Hawi and shares the same PCIe
> controller architecture, allowing reuse of the existing Hawi PCIe
> DT bindings.
> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
> Dependencies:
> - PCI: qcom: Add PCIe support for upcoming Hawi SoC
>   https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/

Squash the patches then.

I already requested this half a year ago for previous conflicting
postings.

Creating such dependencies makes it impossible for tooling to test and
more difficult to review.

Best regards,
Krzysztof

