Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E53F0A87;
	Thu, 13 Aug 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599213; cv=none; b=a7MD8o86/H2cCLFpgL15T15ySbGREOvC+ouPuofnUq1vI4NRTd+Hs7DbnQ0GI9x2HEXmwUWS8e3BEs3z1BthGXhWl1YpzWQOJ6dgUvHkjQqPRwWm3yOQznMQriivYmgPfb4teN2UZmNlXeUPY4VGX6QugoIHnlBfw8qlnx6eFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599213; c=relaxed/simple;
	bh=TAmsWHq1SIR22M3YCbEDrQRZOfmQdfOnrbKasNpszp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz8K1dpLf2/4guvEjN1JXyjqKzdmQsqMl/zkm21MgCw7YRRmhXvsbeckln3kQDhOnUrMtV9+CL9WL2KkhXlOc1L3Bzdv1vPeNlGzgDibQ1bUaGOWY1uMSv80VQW9rjlFfdhYDSVokjowAdVIkMJiFpNDoL2uy+ghF2Xq3J8ZY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CExkXP8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CExkXP8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5D1F000E9;
	Thu, 13 Aug 2026 05:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599210;
	bh=O+9GszJ+HuZmQHbbHRFt9rwiQlTbDbUu1kZ7vlHwnWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CExkXP8mT0pz+cf7BLkvIL2jfIwOVnJbnnPCTzTHqJRy5cX6w6aNb5oCj+mCK9lur
	 nJMijIw8vxvWpg1iySs03BD3FH546lZrM5jAeJNg3JDCkoo2O0X1GhpjzGVFJySKLX
	 RRIGOK0/SEw/EHplemES64fzor14vMTEItJW1oCq0nFRY8MQCnC+qb3sDL1RenDwbu
	 RQsyDdVmUXLo5OwT4evbLla5rO/IP3WNycNJOpFXEMCib0kOz1iLwS11PfaixUAFZB
	 zyBAzHUY9K1ubwQge/l+oHPRsSc/fxqAsssBjl3zdRn1oTs4O/DJbqVC80V0/C3gnP
	 t37HH6pBOjc8Q==
Date: Thu, 13 Aug 2026 07:33:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/11] power: sequencing: pcie-m2: Report power
 controllability
Message-ID: <pugjugitz7qmwcua4biufmmltmdwe7n4p4ivpwxmxqiefhtg7u@gatoruxxcwid>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 10:04:06AM +0200, Loic Poulain wrote:
> The M.2 Key E connector gates/resets its functions through the
> W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
> When a signal is not routed to a host GPIO, the corresponding
> enable/disable callbacks are no-ops, so the consumer cannot gate
> or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "uart" and "pcie"
> targets so that consumers can query this per instance (based on the
> runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
> pwrseq_is_controllable().
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
