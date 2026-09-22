Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66656510F;
	Tue, 22 Sep 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093773; cv=none; b=Wi8f+j8rcKpYV7l3ZE73MN80jV1EksQTfVfgT0WtsHVgjXAdlcar1pGOKZqN5u+6MYDPNfOhmXj+zU125cTZqSpDN7cGjGh5qOuqJ44Bb/88lvPi9ZuuRkxn202lqJZEMiW55TebUN9Eml0vB/m3w4YQXZtp+pJxJchKy1k7Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093773; c=relaxed/simple;
	bh=SyyP6Yj4eMNV/uLzfmA9zYRmUVj3SCY1nSDO8K0XJCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMRN/+LYip9SKiLzO9Nqz7+IWNK5Q7fEI9wRpaQN4Lt8/BUp99JIhQ2+yUcYMWTYTeqEQnOY2ewBUVFDuXzKmxdniVuVwkTCNe7/BPplLZsZcRXquhB+UTEFSeiDtVDqIg0qnx63Xpo7UePYTyW6c0g+hkPRzrSvz3jlcc0RMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCxwqPMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCxwqPMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7801D1F000FF;
	Tue, 22 Sep 2026 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093772;
	bh=mXPEV+IexRRJlhsopmLhfeoJ59mEr8BoLHyDcrHZzWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fCxwqPMV5D9PRR5w4ePUbUsfCUhN/YyrQnFrGuEpiSOwoEA4ZlI2jisNJsRNSxRLY
	 pLGhZIcoRDaXpguIEkpuwq6xL5sFmyY3qjDYi30kZjTMxr3RED0vrQlKjUwJYpkWRE
	 MxEQehUHkfhpVfyCKMjeVBf4jHuotNSHTVl8JsdK5LSURldrKhX2nFynhxK0k5osJB
	 7neVZfoCJTNFwl4dedADvYVKlCyxqpvw/Nj02taZ9o+mNRgIYZNvKszJEs9I2Tlrm4
	 fKJKAWQ8vPlJfkcZ2z1lr8tI+0vNZBFSmJrc1Yjr8i069tJnQpkszKsiEceAHjpnNp
	 Qqsy8eCyGgpWQ==
Date: Tue, 22 Sep 2026 18:16:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Message-ID: <24gudbm3x2zvuvw2slssncn4rjmd2p4z7jjmzxzzwbyyfarlkz@f6qsojoznh5f>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-5-c9b33f56c8d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-pci-tc9563-aux-v5-5-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:57PM +0200, Lorenzo Bianconi wrote:
> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563
> power controller driver and accessed through the same i2c device.
> 
> Describe the switch node itself as the embedded GPIO controller and us
> it to drive the PERST# reset lines of the two external downstream port
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
