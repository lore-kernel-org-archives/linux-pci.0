Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462809;
	b=psbMnx21AXxgEf9ZE31qDdLV9shtCuqtI31yHKCuTrldTHOABQvYfTTS3pw7XplYRoVV
	 Q9qpf/OMN8UuqNBnAzZVaYEKXZ1TXgJKr4X/gZ0yv1DZekMtiU8X+BsgrUoLeENQJlJ1w
	 qjC1Wvj2RfOnf8SBgbvnz3FMp68SMwKrelVDtYHKttEf9qX7RnvXHF8gQNflKxWgxNzmP
	 n7c5FIrbSP/91kNMmRydRtoR368nFaUv62VyTGHcJ0ilPTU8NeQYcwP/FbF5+Sl0KtCNG
	 dAwVTungyo4ctNatISdSXkKN5R1M/H7afVBO1GsOxHHkNP0B4cvBDoDRzZzjQMWpf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GENkBhjt9jCQL9ztMCG1lg3AsyAfCt88HgVI5C9B0qU=;
	b=j7DrObTorOtLvpJ3pBNbz1K6gkDgwtI8n93WAeH10QYzxc98lBLMPI2VP+GropmAgkZM
	 wpWrS3nkDIMbzHEge04MEVey8qxodK/HYXQ1oaXOZazhFaWBvfOsfrOGyCgx/mJq2erLN
	 Cg7eUdTCqwr16qfTblIZrTYWVd5hhDnXGnmeWp9+HqpnF6ZH76w6GpwNU038ntqXnSBRa
	 jXzSSrX/mGjrIYalue1mh/VKzWhNTv0/ECP99tuhuGVh8q6pmyBW/TMfNr43XkWTIeyLV
	 iVXHxPEsMuixI4POX0ljoFLYl6CKdMI6V2a9UDgxLw5iFcmN4J0HbuKTZA6UChFRfeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0cBGp6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785C606A31A;
	Mon, 23 Nov 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0cBGp6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7A71F000CF;
	Mon, 23 Nov 2026 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462808;
	bh=GENkBhjt9jCQL9ztMCG1lg3AsyAfCt88HgVI5C9B0qU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H0cBGp6ZHsm7VRxM/OEEGivd1KW31o2+Vg/7savaCiwopM0qP+GuWSzMMifgK5Cid
	 y5nrkGqUxQ+KVkzgVcHa+8S9crSPrDrhH0/TPYBkepn/AKJ94abJAETKoB5n7jm8mk
	 Cma42wRrtnBqPkUL9jKKx5hI4yTHiauLBerwgZL44EzKy4adx1ysdnMmMQg0F23Vvc
	 xvfffr8j4ix3JkQeQwsWGN+lXCtTYEr8wMDkveQrvk6lCPEOae/Hkxc5imRArXqaud
	 IxuaXXcZYOWVfy1ZkMSxUDu9HXdERUTDVr8sTE2cAgl29EO8a0uRTva9pQ3kaV5PMq
	 ZuCQnH6NN3RlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4447392EE3B;
	Mon, 23 Nov 2026 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/8] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546280752.3078240.14805483957076909592.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:40:07 +0000
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: mani@kernel.org, brgl@kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 manivannan.sadhasivam@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
 jesse.casco@gmail.com, krzysztof.kozlowski@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Nov 2026 14:56:07 +0100 you wrote:
> This series describes support for the onboard WiFi/Bluetooth module
> present on the Arduino VENTUNO Q (monaco) platform.
> 
> The board provides LGA pads for a wireless module. On the VENTUNO Q
> these pads are populated with an NFA725B module featuring the
> QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> the design is functionally compatible with the M.2 Key E.
> 
> [...]

Here is the summary with links:
  - [v9,1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
    https://git.kernel.org/bluetooth/bluetooth-next/c/7fea07497112
  - [v9,2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'
    https://git.kernel.org/bluetooth/bluetooth-next/c/139c8e574116
  - [v9,3/8] Bluetooth: hci_qca: Set 'bt_en_available' from pwrseq controllability
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9783ebd40da
  - [v9,4/8] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
    https://git.kernel.org/bluetooth/bluetooth-next/c/a482935cee71
  - [v9,5/8] Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
    https://git.kernel.org/bluetooth/bluetooth-next/c/f6fdb04bfc1e
  - [v9,6/8] Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca2e671a82f0
  - [v9,7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
    https://git.kernel.org/bluetooth/bluetooth-next/c/d10bd5678905
  - [v9,8/8] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac2cf809626d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


