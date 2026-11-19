Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090219;
	b=cxr5eX/6kxrr0/wQG11uKwdkVoUVnHo0XZ+ASMoewQ6asinZwp09ZuaPspwa92q9maND
	 lkabi+HoQGM50+s3WVhD6aieHqoMoXW/uMNs9O2nR7t6PEeV54iuCh4BdZluxI0qdE39H
	 0F/njBC5ctO5OwMVfe6N9h68KxZ+JrJ9S93H3+mJsrK249TaBn3y2+3q/8uVY0NW6eoTF
	 Y0nFfAsE5IJr6lwjJqiLqMt2eRFn23sDmquL4BB21LeBVvIHpHELtTNnLFFAE032xa3jE
	 x4qAjkN4DKVkEYxTTARiwfaLjhM4cdV3LIwo//jJ5lEZ74RCBL1MKOCGMX3NZfEd4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090219;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bVOglpsLdk42ZqnvQazF0A2L65y0wwaNXipQaLV5Dy8=;
	b=PAH8b5cTspxbmAPOKkTBewhdEA5/ZMeXOfoNjPbZ4qag/Himu+cibGPGj4cBxyeL7AUi
	 ynGmrJXCjUZ4G8l59BmUocoTExwpL7nQq/4tVmRGZniYTUZGG4jqS5Hpw3ol8wg8zgMbA
	 ApOMR2/2HUnPUg/pQGkCiooYzDFKML7joqTlkd9fZ5JKh+OVxNyWx0Lx47K08kHOAjRbx
	 ecwlPHnnSN3sqXTf34Dhg2WL2Y9GrvQC/WbgO5dQ73F4EEVFJHMuHZ1O1/H9N/C+ywRyL
	 XsRF7toq9tGl30+Uzzqsm9sgj43SzKiXiE0vhx2I9Rlf1O5JWDQv5/KaHb3DgmC5RMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV+nC0tB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2C606A320;
	Thu, 19 Nov 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV+nC0tB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A691F000CF;
	Thu, 19 Nov 2026 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795090219;
	bh=bVOglpsLdk42ZqnvQazF0A2L65y0wwaNXipQaLV5Dy8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NV+nC0tB/l6vhGKhDUnMdket8HGsXsD2s6NkAQ5lTK+pSkt40z12z7xIN2oxvodPX
	 8I0bHapymBU0bV4sTW/P1zFK3RGpPsfSzBxaIKdoF9Xt8FAio0fhSozZ/tCPaNOfqZ
	 1BMAnW+XPjhi/XXY7MHMIZcwyDrRw867CCyrfuLvAZuo4/joPD7lomgVAUabA8ApRP
	 Ql8Xl8VXLXxLqd7ER6L5AuT0Ii3B9Mu6khKMNirs/nSLepiQaMN8cc7zBqjMck/vcw
	 VyLJH1AIxRxeruBK4WrvnVvPoFK6jQxdjkqiyKcNO6T0Y2uSuUFYEwxp3SVw9r3W/v
	 7qOlSSNXpA4VQ==
Message-ID: <0a3b7886-3800-42ee-8e22-80944114dfcf@kernel.org>
Date: Thu, 19 Nov 2026 13:10:14 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: exynos: Handle PCIe PHY initialization errors
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: alim.akhtar@samsung.com, bhelgaas@google.com, jingoohan1@gmail.com,
 kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
 peter.griffin@linaro.org, robh@kernel.org
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261031073548.3916-1-sreekuttan2156239@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261031073548.3916-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2026 08:35, Sreeraj S Kurup wrote:
> Check the return values of phy_init() and phy_power_on() to avoid
> continuing PCIe host initialization when PHY setup fails.
> 
> Track PHY initialization, PHY power, and regulator enable state
> across probe, remove, suspend, and resume to ensure cleanup is
> performed only when appropriate and to prevent unbalanced
> reference counts.
> 
> Assert core reset on probe failure after PHY initialization has
> been reached, and handle cleanup errors during teardown and
> suspend.
> 
> Also check the return value of exynos_pcie_host_init() during
> resume and abort the resume sequence if PHY initialization fails.
> 
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
> ---
> v8:
>  - Fix state desynchronization in exynos_pcie_phy_exit() by returning
>    early if phy_power_off() fails, preventing calls to phy_exit() on a
>    still-powered PHY
>  - Prevent PM core desynchronization and orphaned controller states
>    during suspend-abort sequences in exynos_pcie_suspend_noirq() by
>    logging teardown errors and returning 0 instead of aborting system
>    suspend
> v7:

How many of these are you going to send (even the same day...) till you
get it right? The process is not random punching review system till you
get it past it. Sending random code till bot stops to complain only
proves that you do not understand what you sent.

I have zero confidence that you understand what you are doing and all
this looks like LLM slop sent to us. Why would we want LLM slop?

Best regards,
Krzysztof
