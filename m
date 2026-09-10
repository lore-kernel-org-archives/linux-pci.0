Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386A4B515E;
	Thu, 10 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052071; cv=none; b=PqFTH38cbiVihp+tWrYMVinCneLMPggAlSAjipHbgPlXs8//ItcO3dJtgC1lMM1mHrJY2iY/QDdvEKqaJG8BDxJsKavDDt8dbTlWmPgqrUBTyt89ntogBuHa2fckmPj900WBfMcJth2F7xTQnkM7p4EbBPR2a0satdUFWLMc+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052071; c=relaxed/simple;
	bh=SHywRAVhjyiYdLuDV3sRyD12JjLrn5cULUb9fja5vKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXxU1OvtZf4/7m4t7Hw5n2Xhwk0F+923yTl8ygKWpDN7BsOB0HQ8MLwX+teSEZSsTI6tpHP6q5gxw7VkV5WBhzC/2riCWJigcEHrTRgSX2FDfvFp1aW0Djg1PydENK/1A2FPdKGHxe3r/fRKpgTeW5xS8i5DebRkjYL44Vlk3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGMeZE7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGMeZE7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340DD1F008BC;
	Thu, 10 Sep 2026 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052070;
	bh=2S+7lOb5lQwJunwgugNvj9bFJbnkzgsbNZSE8mE1MKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGMeZE7l1V60yzw4gHb+09kXllETJUroPbH8Vp4Rbu5Kgng1++nD8cNPAKi3gPCZe
	 NPUfE8L3JAYlzKvN1jJDeh8JEiD3AJbUt25O0HKYIOlBTbWRyUq4cncTbHXfzpZxZK
	 7IFCUBQxUTqPkaKdkg+xO8xmwxBfkcUwkxaDeDGrR2VLE1krJaVCsVc8EYM8Gd9bte
	 72bt3nn1ag2ZLomqDSyLLvgUt+A5/D0CmRDszXV/64aRY0VyjKq1mSh86Kr2WomlRU
	 xlC1Rc49DgRjgVew7Hm+IO+VZA78G4RiRsDgtqr0ZYQHHYpJKxNlPmch7a4u0Vm92b
	 qglAok8oF1eXQ==
Date: Thu, 10 Sep 2026 16:54:19 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Shikra
Message-ID: <qesmpyfcl3lszmar5rrpzxc5zp7v4gup5xu4ypq6v5pt2wvqnf@oips226nedhu>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 12:56:04PM +0530, Sushrut Shree Trivedi wrote:
> Add QMP PCIe PHY Gen2x1 support.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
