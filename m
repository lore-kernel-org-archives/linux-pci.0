Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634636C0D1
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342821; cv=none; b=WN5DqFIc14Ye1Ef+jBeAcUT09K9Ue8PafWtm0Y3SKjN35aubuo4emMeAh9jiymUKBlIaiIMqk6LWwA+Y8/8EUdE1E1U7TX+/g+84UCBVufDk07Um22/TlA9UkzjNjNkNsYXksckALwrtSH6TFxH0AvEw42jbtfTtq+1CahL6QOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342821; c=relaxed/simple;
	bh=ay9Wt6Ibuo8nK54rsRjwtFVihyzfkYk8X1+hpdmItI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOCgnrAP6FBMYFVHsyLhGDYbILjav1gSfqV35Fv5An6TnIIymXwis8bpBvkXS66dSe8/0jDbvgE4fX/yB0NMERj8aiPlNQQ4icuyb4KllUYWsJgMC0czQ09zDpHs23y8k5hfWmr8qb16qwkthUt81K7fwhr4o1IemLLnnj1uD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bfnTCh/P; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfnTCh/P"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-436317c80f7so4334345f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771342817; x=1771947617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkqHe1XyX/ctvoneyaOWC6ZPxkehSDSZz4eMTlKnIo8=;
        b=bfnTCh/PZ3P/sQPror+VmybRX2ljMM5Mj9G9jRAxj8+nxpT4JrOU1Ar4+RV08D3XcY
         N+TuQTY/R8S61c2tBBsh6HGYIZX6JR+8VAgEniWprqEj18kGYZGPXBXcWOtsikbns9Uo
         3/KbdI7ymNhV7wOroILIdvZTTIuD1MVlZ+LMkAHQBwTAk5sD7Xe1ofwvj/pUKLXtq9RT
         bJP7CiaV9Ddn3jbAmUp/k15ZW7GBexYC+OVz1rmcOHxkLdNXVr9n4jCRfYuagrSLyVx+
         +0MCqnHytKRo4SE8+rY3LQHySANcCP/1ab3c/BkmuIes7hI4EZPAvyfVKkVw6GanKFHO
         GR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342817; x=1771947617;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkqHe1XyX/ctvoneyaOWC6ZPxkehSDSZz4eMTlKnIo8=;
        b=V1RsweelDsjrAazkHRBT65wVjV2O+y6Ep/R3+YMC4sAI0MVN9wQ81XLbbimoXqItFB
         TUjK3kCdIZLoSlNUuaeYEhZthSBIQ1ko8ZkD/CT4Dau6q1Z24y+zGaExNKqK3AWjo0VS
         itSsh95IqDpAoVZnTy4joVETE4ji2ofYYhmIrk1qErwRjfCoIbxmEQge0FD1tgPnzciP
         vZdnsZO+tlg7GVMbAzUbFSp2RSWQmwRiVccYqOsdVbdkkvVJvsdBtqsbPwGpo2TySHse
         yXC1YemqVzrvKjC5xJSwvzfEXKghqBS9NPhfj+gAB9LflFu0r75nUAaxSKvjlMukmHc1
         4AMw==
X-Gm-Message-State: AOJu0Ywo/GOrORBfnd+88DinHAj/qk8Y41zmF/leQZ9LAfKQEkR4tO9D
	zli+1HUCqk3gHYjodLUt/tGvi17NY5Sdx4GkxUDsuq5bd9MSpk79eShFucrXf4bjbbM=
X-Gm-Gg: AZuq6aLz7kYZ9u59nyMGlGqfPDZDl2bWWhtyfJVifIipBrzt8n+bsFZ+sXveaYxIf9/
	OzZi0liAYACrEKsAGfomI75AdUlO24SsGhDM6oawljWpvTC9vn2eSIHVnPnt3gNFvTRlJ4bqwTS
	euAZJA+fHJCe1DBuK/jgxKG70NU/Qz7WMbklQI9HY2byXsph0/CYdoI7rQmNXv1e6cqYFcb6N8P
	8gIzpO+TvdNL05R7jrMauu12bEjl03EmxbHxkT40az25m0Qza02Ro4Dz9FmKs7Sk21DxmFAl67c
	j03y4Zlbwp29DVtv07TM8EwQleYlXVcX96zJx71oJYmBAyQQ0b5ftPTd4fnrNibP9hYsKyS2im3
	pAZztSCExHmbnB0ok9h/6bHWLsXJfgSH/9JNXa4dkcRVvWp/96xGwcPLEeUcBDUlvgFyycMyqAV
	x/eOHZz6qlgGP+0BFsE4Kn/ESvSJiEAYxZO+uyAukvuPFVwQP6nPr7lR0U2QuvRRWG7Mh2/RPwu
	96JnENF3uEkC76f
X-Received: by 2002:a05:6000:2890:b0:436:1405:3ef8 with SMTP id ffacd0b85a97d-4379d5da8bdmr24192213f8f.1.1771342817327;
        Tue, 17 Feb 2026 07:40:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:72a2:f5f2:e023:2a2e? ([2a01:e0a:106d:1080:72a2:f5f2:e023:2a2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm34212046f8f.39.2026.02.17.07.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:40:17 -0800 (PST)
Message-ID: <12f8346f-3df4-4081-a009-7a3ca83e2c36@linaro.org>
Date: Tue, 17 Feb 2026 16:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/5] PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/26 12:19, Krishna Chaitanya Chundru wrote:
> This series adds support for putting Qualcomm PCIe host bridges into D3cold
> when downstream conditions allow it, and introduces a small common helper
> to determine D3cold eligibility based on endpoint state.
> 
> On Qualcomm platforms, PCIe host controllers are currently kept powered
> even when there are no active endpoints (i.e. all endpoints are already in
> PCI_D3hot). This prevents the SoC from entering deeper low‑power states
> such as CXPC.
> 
> While PCIe D3cold support exists in the PCI core, host controller drivers
> lack a common mechanism to determine whether it is safe to power off the
> host bridge without breaking active devices or wakeup functionality.
> As a result, controllers either avoid entering D3cold or depend on rough,
> driver‑specific workarounds.
> 
> This series addresses that gap.
> 
> 1. Introduces pci_host_common_can_enter_d3cold(), a helper that determines
>     whether a host bridge may enter D3cold based on downstream PCIe endpoint
>     state. The helper permits D3cold only when all *active* endpoints are
>     already in PCI_D3hot, and any wakeup‑enabled endpoint supports PME
>     from D3cold.
> 
> 2. Updates the Designware PCIe host driver to use this helper in the
>     suspend_noirq() path, replacing the existing heuristic that blocked
>     D3cold whenever L1 ASPM was enabled.
> 
> 3. Enables D3cold support for Qualcomm PCIe controllers by wiring them into
>     the DesignWare common suspend/resume flow and explicitly powering down
>     controller resources when all endpoints are in D3hot.
> 
> The immediate outcome of this series is that Qualcomm PCIe host bridges can
> enter D3cold when all endpoints are in D3hot.
> 
> This is a necessary but not sufficient step toward unblocking CXPC. With
> this series applied, CXPC can be achieved on systems with no attached NVMe
> devices. Support for NVMe‑attached systems requires additional changes
> in NVMe driver, which are being worked on separately.
> 
> Tested on:
>    - Qualcomm Lemans EVK, Monaco & sc7280 platforms.
> 
> Validation steps:
>    - Boot without NVMe attach:
>        * PCIe host enters D3cold during suspend
>        * SoC is able to reach CXPC provided other drivers also remove
> 	their votes as part of suspend.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
> - Updated the cover letter (Bjorn Andersson)
> - Add get_ltssm helper function to read LTSSM state from parf.
> - Allow D3cold if there is no driver enabled for a endpoint.
> - Added a seperate patch to make phy down in deinit part to avoid power
>    leakage.
> - Revert icc bw voting if resume fails(Bjorn Andersson).
> - Link to v1: https://lore.kernel.org/r/20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (5):
>        PCI: host-common: Add helper to determine host bridge D3cold eligibility
>        PCI: dwc: Use common D3cold eligibility helper in suspend path
>        PCI: qcom: Add .get_ltssm() helper
>        PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
>        PCI: qcom: Add D3cold support
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c |   9 +-
>   drivers/pci/controller/dwc/pcie-qcom.c            | 162 +++++++++++++++-------
>   drivers/pci/controller/pci-host-common.c          |  45 ++++++
>   drivers/pci/controller/pci-host-common.h          |   2 +
>   4 files changed, 162 insertions(+), 56 deletions(-)
> ---
> base-commit: 9702969978695d9a699a1f34771580cdbb153b33
> change-id: 20251229-d3cold-bf99921960bb
> 
> Best regards,

With [1] to allow ath12k to go in d3cold:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

[1] https://lore.kernel.org/all/20260217113142.9140-1-manivannan.sadhasivam@oss.qualcomm.com/
