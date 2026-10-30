Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360614;
	b=tdYQckqtfJ3sMrM8YiO2NIRwo0dgdw5l1qhABv7FhkuphpFHaMByr7mzPLuKCPXjo8dd
	 A4o7/hn4+F/ZC4byg0s8eOrYktnOe8xShVZi0MilK+y0E3zf0RvLFBxXPYLzdbyiVdgHb
	 xb+RD+LGbNf+CRMuNG3ByhA2kc+aL6chxvB1BwKl89cv2Ir5uRtsTf0KgTlBjhMCic/cC
	 dVxZ43ZE4rylsK49f9fukow9xZfFZGIVVvAB6ey4/iV0OBkBNuOQLF85N9NZEoDUVUWGa
	 /AwrwhcMoGWStYtqUvpsrhTYuqH2oNr1XkP5mTlKJaGrE9qC2t7WDgQqhsklnALQcsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360614;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TJmQD5eQngMpl84I/Tazwml+k+hDOh038iK+PnlxpTk=;
	b=nsbzuMXkQjd2RVBCQPCVQO8F4QV/X7X9f+f5RUUTJAPQimAK5MTv2AjabFU6dk9kug/u
	 nlGyXq2vnMMfvpB6dK3zVoC3eYkojJkkHPPjN/+6qYv1gQeLKP6cps/YiRkaYMD4IUaYS
	 PTeFnl6QD7b+15TBg0K63Fyn3o1j2j+FlJ0xxho6Hmr/+52rtXQj2MqkMbNKkN/ah2/n4
	 9lPfFT1igOCi8EOAU1x4uvyMFgI8HTue0EJ9RWOfOqNB7XOu/nPwh+W0cYFm6N8BuuNAI
	 eeBVPdlCH6Q98CwZE0xZXR7JgXuDzVpphblzVL7Teom8SrmcGZTtImEKQ7YnsH45f0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tphxlmcm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA0606A31A;
	Fri, 30 Oct 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tphxlmcm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC4A1F000C1;
	Fri, 30 Oct 2026 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360614;
	bh=TJmQD5eQngMpl84I/Tazwml+k+hDOh038iK+PnlxpTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TphxlmcmNlT/xiu/1JQ7Ce7Hxa8ceCDUw0QkxFMrqsoIphqB1axCG+UYyGTTc8GuH
	 OekkorI/Bc9igWOXBRh4JT4qk4n573BbwJKSkSrKi5gZJlkLFmAw37KoNNGxiqwqy1
	 XZP4gd2eMK73zjlvWi7HCddacqYJ2/bE5y/w5usdK/0J7BxJ3xTayp7Ulyu5vCcf3p
	 FwAAvJ7MBI3SNbArcmKrmTJfTI+g4r9PthtAmG/IxonlZb7sshzVNvXQfR1+U2+d1H
	 4Z75IxeHpXUxLsu2p8uVykq+d60ez3x8Dzz/CHbjUTtpM3ybHRBvZ6eT7jQ90anqRu
	 w5rW13Pkw0Jbw==
Date: Fri, 30 Oct 2026 12:43:27 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI/pwrctrl: Add the Tegra264 iGPU to the generic
 match table
Message-ID: <ppacouwr3kteic3ejouxq6ldtf5iltpyrsc6tuazarhaks5ogh@px3npku2feak>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-3-4d843dda0b02@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-3-4d843dda0b02@nvidia.com>

On Thu, Oct 29, 2026 at 12:32:05PM +0900, Mikko Perttunen wrote:
> Tegra264 exposes its integrated GB10B GPU as PCI device 10de:2b00.
> Its power domain must be enabled before enumeration.
> 
> Match pci10de,2b00 to let the generic power-control driver bind to the
> GPU's platform device and enable its power domain before enumeration.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
