Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713656;
	b=HatPr7kGvEEH41u3Lw0FgPRhowbzPvFinfCxjDzpciXN/yu/mPjpEjqky3vtXFZGCR2b
	 2z+nZRvjVpacHP3N0sNjm1SVjYKhvdCM2ZSauHVAWJ7YMhAZouKKj9mw+SmI1zLz6NLpe
	 mcCCSRyHRZAXmmyg0zDQG6WNn3vIKAXdioe/49xELIlu2axL9EtEiLdoxDgLozfXXmxKc
	 +ozc+7AOrUMQQHLz9Jm/t3i+1b5CktSgIgEpwLGe7bXWrhKhHdXGIKfpm4pji11XNMyAE
	 SVWJsemsivnp1qMVRIqO3VL53S0OpB///S6DrgbxoaEYBTr74fOF5/8iTrvA3A/7geA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713656;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UXzTB7gQh7zbXr6B/PkegdLCNlD6oxxGSmPQZVdL3CY=;
	b=Ud+a6dOdm/xkYFwIpoHRzC4/CgssrTVcrEuXRXrHUkL7TCa1rhQ/UXPNaC3cmFKlX6Vi
	 00jZGuARfyHTR6ei0fm1v7lvstMDljkVwGaRPPUaqYIifnw6zjUBcslMCVSHqmpS/ojD2
	 WcVHBLHXWwIt/QWNgFWmr/0ctz1Swf8mb1qLR4KwTH87OzpB22PhDryGM5rDTXhwsnhwU
	 X+A/GQXafcsnsHfeHsXlBps4+f6GlMphfFkg/op3oByX61VaFVpydmjaJzAMAEAQcOXR3
	 kMEjRP4/vOdgRLCEJbp2xr+nRjSKFXF/iDuWgNJEwNN8UWUiuJfAIkSkNTMxqSS3K+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVnKl0R7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4412606A31C;
	Thu, 26 Nov 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVnKl0R7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2021F000C0;
	Thu, 26 Nov 2026 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713656;
	bh=UXzTB7gQh7zbXr6B/PkegdLCNlD6oxxGSmPQZVdL3CY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LVnKl0R7i/LaW5iHWa3PxWRpXrINDfyA3MNqWWAkePjBGX1RWMHsiNPAamKC3h9tI
	 qQFTEaClD3Pl8KRIdN9W1CVQSfeNbHgKoF5XZmcOZntBud2dKmOQLnSznCbaEgjl6A
	 oTWydRsuzNX44wQY8a+finaZutLxkm0IDxYuatAXNsvlj/D5t2+KjbU0JH1EcnfB+i
	 ONzOuJMg2gk/GwzNC9rgpyZSQX+CUDgqVJaFUlMpqzjvBAH5/ga78e8bV4tjztQls9
	 /f/hnQmlYOd0N20/SpuwwsB6Ka6iTZU/2zpqQr8suLJI3mkDJWwKkXxceMr5ULDEAc
	 8+5H3KEO3lCiA==
Message-ID: <452f2156-2040-4d9b-81e2-6e2b2ffe520c@kernel.org>
Date: Thu, 26 Nov 2026 19:20:52 +0200
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
Subject: Re: [PATCH v7 08/14] PCI: rzg3s-host: Drop nop instructions
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-9-claudiu.beznea@kernel.org>
 <179562566319.5580.8113747221186721413.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562566319.5580.8113747221186721413.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 18:54, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the RZ/G3S PCIe IP variant (which is similar to those used on the
>> RZ/G3E, RZ/V2H, and RZ/V2N SoCs), access to the PCIe Type 1 registers
>> requires setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not
>> set on the code paths where rzg3s_pcie_set_max_link_speed() is called,
>> the writes to PCI_EXP_LNKCTL2.TLS are nops. Drop them.
>>
> 
> Shouldn't you ensure that TLS is written by setting HWINIT_EN? If not required,
> please state the reason.
The manual don't mention setting PCI_EXP_LNKCTL2.TLS when changing the link 
speed. It specified this should be done through the 
PCI_PCCTRL2.UI_LINK_SPEED_CHANGE instead. Steps to follow, described in [1], 
chapter 34.6.3 Caution when Changing the Speed Spontaneously are:

1. Wait until the home node is placed in the L0 state.
2. Read the value of the STATE_DATA_RATE_IDENTIFIER_RECEIVED bit to check the
    supported speed of the other-party node.
3. If the home node supports the speed to which the other-party node wants to
    change, set the UI_LINK_SPEED_CHANGE[1:0] bits and assert the
    UI_LINK_SPEED_CHANGE_REQ bit.
4. Wait for the UI_LINK_SPEED_CHANGE_DONE bit to be asserted (wait for the
    completion).

Thank you for your review,
Claudiu

[1] https://www.renesas.com/en/document/mah/rzg3s-group-hardware-manual?r=25458591
