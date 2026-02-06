Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D53126D0;
	Fri,  6 Feb 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770413759; cv=none; b=YSVRZgElFkcfMFHgRglGo4oHx5sCGrqKTpduSIU1oXQ/Iv87aL2Sd0tkgkv6tcPj3ecP90VZh1Qiw84RT5dBu9oz27FMUG5IPZvNu7qyNuyEO/AKB3zpSeP5J6XeJZdKB3BWYgNPMMFr+iqho46rDp52iA9LuXVoO+21nNxRlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770413759; c=relaxed/simple;
	bh=dpuixKPaca+z8P7KSWpyhbK+TCmFkMQ2hPyCbIIOrUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uBmOtBQdfT9X/pGfE0x6OIHyzoesmBGjnNu40Q5CWo1x9HiojJ5pcq7We+Gh2+4uAsF+xDDM3+t4b0fjA956TSK5jHSm+6zdf2MISlDjQsvjbpIx6J24htmqKP+dmaMKJGmnduWnREYzri4Y7ZN/BpANOpedx+Ulj1vw6+d4FeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKiBd6UV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKiBd6UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72974C116C6;
	Fri,  6 Feb 2026 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770413758;
	bh=dpuixKPaca+z8P7KSWpyhbK+TCmFkMQ2hPyCbIIOrUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BKiBd6UVFOmZNUiHi2ArQZp6AzI1ZrlrM9SNXzmgl+t7WJuSArxlD4FdOYc8AJZo8
	 +qwQK2mdyhRYbUeTqdcA5JpJteLTkmd7BFXnLWEiHJEezOTF9EVR/tW85Fgd3cJ/OP
	 oOGCr+4q1b62itZFKe//qgBpokRzQNPb868MGVL7u5Hkeitnsaan4ZL+peh9jF5uXE
	 TqN6dWn4shdcUlyC+ibaZyhlP/4nZlnGjGfFqfh9bpvTb6Lb2OTcjnhohyaeeFrVuU
	 RJ9cfFcYrLy0mWfjAhoF0zvMOQSjy6Na61f8PCbosimTIttf5kVJxqgfZTYJEpVxIQ
	 GK8hVIHYLXexg==
Date: Fri, 6 Feb 2026 15:35:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: Add support for the Ayaneo
 Pocket S2
Message-ID: <20260206213557.GA83922@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>

On Fri, Feb 06, 2026 at 03:50:28PM +0100, Neil Armstrong wrote:
> The Ayaneo Pocket S2 is a gaming console based on the Qualcomm
> Snapdragon 8 Gen 3. It has an internal UFS storage, WiFi,
> Bluetooth, gaming buttons, SDCard, 2K display and USB-C
> connector.

>       pci: pwrctrl: slot: fix dev_err_probe() usage
>       pci: pwrctrl: rename pci-pwrctrl-slot as generic

These look fine (but please update subject lines to follow past
history).

>       pci: pwrctrl: generic: support for the UPD720201/UPD720202 USB 3.0 xHCI Host Controller

I don't see anything here specific to UPD720201/UPD720202.  I don't
want a stream of patches to add more devices in the future.  Is there
any better design?
