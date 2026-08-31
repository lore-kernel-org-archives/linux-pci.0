Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A0388879;
	Mon, 31 Aug 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207703; cv=none; b=ry7reQmXWdIq3C1L+AT2ly2Bmq6+Z4xOQiS4McxRXYGY3hIlIURfuzutiB2QxyvSjT/H+wqFO3v1OYhlnpHW9HADZHfo3Cv3s7s57DGCJ9cGXXYmp4X7VJHvTkM1i1KCtGlRFz2GfMPPLPlXc8q5uGZUcESbhrX6ucJhavYa244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207703; c=relaxed/simple;
	bh=XurowtO06U8Aw7Fm1KH5LvPHuNiKbK3anO2uAVzxjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMPZNQga5mPp+DUG1AcH82Tj1cTdoYXaXGiSnRlmrUL2q/D569g+fc16J+znmGuyo7oR8in3qNY7zdqLKV3VOxug7M4uztGKoH2mSstWtAI4EalVO/HCjSM0u0PDOF9hSy2Zavp2GsE/vgGQ/2+COSP9nl7pjyRd7ZH82dLD5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clOZWt61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clOZWt61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E701F000E9;
	Mon, 31 Aug 2026 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207701;
	bh=OOKF7tUXCi5ikEhu2FlHAXW9zvzpSMnU5r0cL+QJIe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clOZWt61PRPuL3KCw9Qs8yNi0yutMS9Gs1FsRW4+f9F9e3IjBsyrSQ6nmet/2TEl0
	 LS/EDCik8oFKKgWnpPnd5bqrquloqLZ8HyZ6A9Vv0aNf6rgpWhqH3KlRjyUFn/moIY
	 EvW/rTMEhiS4JkSPHIbNWjS1Fv6lH+8ottm73Lpsh3zUSW8qxYAZPTaymNvfkXzuR6
	 mOY0341Cg0vS0eXYnGJutC7fTeo8/3A30eFc6YhqEzqKD/s635zpPLuzmFiIbNvOwe
	 kPCB4cK2RFMOY5sYqNqlgO024kiPyav2GG4BDcpzNMkWChs3T72LeLA4RyvPBSQXem
	 qtJcT9P7yy07A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1 with M.2 and TC9563 switch
Date: Mon, 31 Aug 2026 15:21:19 -0500
Message-ID: <178820768627.1699313.17548578412208976636.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 08 Jul 2026 11:47:15 +0530, Krishna Chaitanya Chundru wrote:
> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
> 
> The Eliza EVK exposes two PCIe ports:
> 
> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>   modelled with the pcie-m2-e-connector binding.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      commit: 073c6a891eb39578ab85d8a1ccff156ad1d8a98f
[2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
      commit: 9439277347656b22957a8b9156b0e33c446b490d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
