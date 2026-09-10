Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11A3CB542;
	Thu, 10 Sep 2026 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025055; cv=none; b=kbPXpLJ0s3ZHcGCFSgn5l47uM/ZAlkwd4jfY1WPvoFRVfIeYdRwVQeSfUjdDKWpKWXVhyNveyD4Y1pAvUKVVK9ePz7xw1CezYDvmwAkv5b44rkXH14vNTIG21e4ZipRLYu4Wv/8QmDqiDvIIyZg5jYQPwXd2+f/HxuGzymsSphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025055; c=relaxed/simple;
	bh=9y0ucskyS6kC/bOvGUOM3FlpdzRpx8CdKDJDoY9nUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzgISz7phhkvVzk/aJ7rDlfdZR2NsQZuwiyZSNOz9hem4BrJxKObX1Zbf+slQfvDf9mARzLgV7bP41Xz2GOh2Je0/rmlL0NXmFHDI3gQ7rHLuB/v4ouXdRKDl7HWIEfqNEETiCI5TgWY9m/QjVgj6WLwuy4t/73RgD0TeNzcLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2XvVlOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2XvVlOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4C21F000FF;
	Thu, 10 Sep 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025051;
	bh=3K/5jxz2DpMibdRxxyvG0gZi7vwsVMxfXJLuXGz7N8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2XvVlOZWSUAaeddC+u8OBIk5bQwqE+as5bwNIuFFOj/dYc6Ssjfm/8BKro1UaSqa
	 S39yfT0Jnn+dtE3l/gOprpHfY0EwXxbq8V10FLWk92EFnZmPNZGDByFJbJ6oWIHAUj
	 9UyxXgXSuuUa+pcYkRkXA2ds+Crsb++CEp5aYfDPDr/b/9IOdbj1o6KWzotVV9xYfE
	 s/+Bs/ikT9C9giPQsszyOBaJC60fKnMKuYD+WSvukX9pFUz1+yqXZ8b6PeXFfyzW/J
	 PlLARU69dyhMCpuZw8Ryah6NnGtK9B56VJCfnzf8ttaOvmgdsS8HyiqrNvsABPwlqq
	 /fu4NQYUiGUow==
Date: Thu, 10 Sep 2026 09:24:01 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, shengchao.guo@oss.qualcomm.com, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/5] phy: qcom: qmp: Move
 qphy_setbits/clrbits/checkbits to common header
Message-ID: <iwd7bhclrdxjdiq7bfukojef6dzx4ff3xq7svkpsbcx65asmoq@utu2papslzrw>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:18:19PM +0530, Krishna Chaitanya Chundru wrote:
> qphy_setbits(), qphy_clrbits() and qphy_checkbits() were duplicated
> verbatim across phy-qcom-qmp-pcie.c, phy-qcom-qmp-pcie-msm8996.c,
> phy-qcom-qmp-ufs.c, phy-qcom-qmp-usb.c, phy-qcom-qmp-usbc.c and
> phy-qcom-qmp-combo.c. Move them to the shared phy-qcom-qmp-common.h,
> which all of these drivers already include, and drop the local copies.
> 
> This also makes the helpers available to phy-qcom-qmp-pcie-multiphy.c
> without introducing yet another copy.
> 
> Suggested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
