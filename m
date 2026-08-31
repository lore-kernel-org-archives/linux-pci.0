Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95F3955DC;
	Mon, 31 Aug 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207704; cv=none; b=rZ8nZ3iRpbLHqtYYoMmWgyZUPmp85FE33zU55Kj81F3E+UcPz+XS7IPYRgBbN4RUDnUyskkK+r4/Jvf2dpvRUcFmwAI+cUk6/eoqi+i2aNKaJPAK1Cfu+1PmL86UiSE/wjBekINSlp3svuIlg4Oq65Odpk13J9Lk56Mo8hONocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207704; c=relaxed/simple;
	bh=mWd+Mb5Z4+HSOwmsDqY0t200hb3Jq63Kx4MbFS7HBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RR2kwOZVulaJXudia8f5zN49fbkT7JE31O0n6Zu3gUheeWJakm9WSUhT9PM+Wd2ZSTbTTF3iCWx5lOzfhpgtD4L8qoKSsQQkQ/XerQmfjZ+otuAhvb//M6r4n2cFZNNHVHjz2U4LonRGByRZGPyjbrG+dn/5s1FeFqo9em8lnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxCH2VpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxCH2VpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D71F00ADE;
	Mon, 31 Aug 2026 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207702;
	bh=sTN0Gf9Aj13nHFatd/xmnH9hA5RP7BLUG26PmGdZLWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxCH2VpXNbIUrT8A2Qu86ZHI6OZtFMLvED4eNaBumxVRTziZ9eQTKLDAM7wJph67O
	 ts4HU9w2fbAJYqyS7cEw2tqsNx/u1CXP3Du11W4gTrTP6UJd0V52K4Td/1Hn0tsSZh
	 PH8XOEpurbEM4bRRWFtF6AptscF5P3cMAm2JTZcjLOuiWQcZ2hJycHaSK4DQCWRVtD
	 TrfbK5nbOmK+rccqhWCeJYL6lVkaEBQxPWr6KBz3ZrNQ1c+WaFIvrVIL25J/tR8SRn
	 q/Ryjf7zEWsQygov/5kgPOjjx7tDQ6JmZydCNU+14jzvMXB9yocY1O0DSRJlc/UABg
	 +L7dAzZlTeZIg==
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1 with M.2 and TC9563 switch
Date: Mon, 31 Aug 2026 15:21:20 -0500
Message-ID: <178820768644.1699313.8603462826395094258.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Jul 2026 17:30:15 +0530, Krishna Chaitanya Chundru wrote:
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

[1/3] arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      commit: b47be235dcc5b512b5af4ee0e1c014571155edb2
[2/3] arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      commit: 073c6a891eb39578ab85d8a1ccff156ad1d8a98f
[3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
      commit: 9439277347656b22957a8b9156b0e33c446b490d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
