Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94275202F71;
	Tue, 30 Jun 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847721; cv=none; b=LhywwcuVjdqxtVEJYpi4VXj968c0Bnsj8NPpBoavOKvBhipeuJfaKInoMdYrQKq/9rSfq5YtbpD9UU8e2jndyLS3XLYpRGlWF3XVMkENGKUAkfBRJhB6z5PPpBRzpEUDNMrp4RO3DCwo9E8h878AU30vBdumWm6of3V3flGJsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847721; c=relaxed/simple;
	bh=/EOG9TUpt3hK/si09HBvt4AMoFa4sGWLRgcVcZAWwzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=opLtwMyPMXtL1I0BTtLb/8xksKAhF6QgfLVhyI22ci6vy/Ea2aM1HH2L77nmVAhQ1xCORGWHB20nDvgmppRSun+7t8u1TtQAW/iKJkW8Ml+mWMnOtHHcTAvYLjuOEIz91i4FaFk3+9+UFJmRB7ivd/vpEfAe8bZFxsKNTOMo/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSJnHV0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSJnHV0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066301F000E9;
	Tue, 30 Jun 2026 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847720;
	bh=3xUokEw784jqQMjsVSWEIlpIvgdkj7DJezvHEDxld74=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lSJnHV0+4/HlK6Dfa3TlgXQOJUzfXRh45Bll5pkrCzjICnIWpk4nu2YnHV7Lwa/yL
	 J25kjic5DcursnlXyfXShrJOlzDW/rurYoFUewp023b3X2NqZGkeWWKRUnOdpJLuHQ
	 nYw6MZjcQacksfZH7wrSO5hWgd/oV9LhKARcy8+68nTPQ/GDz2LkMWuCfGes4NwoZB
	 zYDGKh5uiy8NhomL2Ct1agvdovSbFp1+uQDfWHScdJwlLjZRJVBIS2q+y7NKiQSsLL
	 651919KORECiUqE0cKqyd+SadUX2xnNI7+lyCNiksRDIq0D0GVHCiJCZxBPel0BfKz
	 J0W2jSfOvTsbw==
Date: Tue, 30 Jun 2026 14:28:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI/pwrctrl: tc9563: Add API to control endpoint
 power and reset
Message-ID: <20260630192838.GA223662@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-shikra-upstream-v1-6-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:48AM +0530, Sushrut Shree Trivedi wrote:
> Some platform utilise TC9563 GPIOs to enable power and
> control reset of endpoints.
> 
> This patch adds support to parse endpoint reset and power enable
> gpios from each TC9563 port node in the devicetree. To configure
> these GPIO's during the POWER ON sequence, two new API's are
> introduced: tc9563_ep_pwr_en() and tc9563_ep_assert_deassert_reset().

s/Some platform utilise/Some platforms utilise/
s/This patch adds/Add/
s/gpios/GPIOs/

  Add tc9563_ep_pwr_en() and tc9563_ep_assert_deassert_reset() to
  configure these GPIOs during the power-on sequence.

Wrap to fill 75 columns.
