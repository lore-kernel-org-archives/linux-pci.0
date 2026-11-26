Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795718294;
	b=dV8jk0CWe/wYXGJjr8XBStfZOPbB6EqFtnLqVRsoesFKvUo1HZP14NiAiThscb9MofKg
	 cNfRQUTGrEw+KAuYxHO07KdcEEuxQ+y4twJDJGH1eJFkc5kWVk3h1ZyZ8fPR9zFlDJbuY
	 cVdLHX4zUw7nvVRpLfBrMxfC0kmMm2AERyfgQcb8A906WYUPVc1LdVFVoTwoW0oAEnyc8
	 HC8bCIvF9A1koaUC6IUOIfj4i1jCbFthVyxYl8xcIGy96jEGcA/g1DWJtLuzZ9NxCsfK1
	 iv2eLK5a6xBWz6r9si1p8gHsdpRf795P57v0UW4M6J+/B0Rs9K9gFSiqOAiUe6ARAEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718294;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0JG6aovU53Gj28fQBHTFybyaNfmBaXUxB5wClm6BRjM=;
	b=Ajf3sJXFmBasmL8akVacGKmNsBGSWO17uZy8uuQ5rbwQjN6CLoTkiC0wXya+xfFALKyT
	 4AL5R3UkhA6yI2E98EDuysGx0w1h7D7KOxVE7x7KbsTtASctbcp5EBE14AV4OJywrPyjY
	 2ElyL0b56usUQSF4U7LiAwtrGHJ9VdThDLwNkT6kbgpliobANWSctrXFAMc4YAYotPcdg
	 R4oJz9VCjb+Qc1+Te+gHV8jUsezbv/vfDvSwqU0wGc0Te7qThADcjjBNW+51ZWpC5zylo
	 OnENFWnHF2WixIdBbcPAGE6YsNGkykAXUheNY7fCOlaGu0//aNYtm2vxYcSXXwsz6pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/3vuzP+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC8606A32A;
	Thu, 26 Nov 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/3vuzP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB581F000C4;
	Thu, 26 Nov 2026 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718293;
	bh=0JG6aovU53Gj28fQBHTFybyaNfmBaXUxB5wClm6BRjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F/3vuzP+6n/+79X4tAfOZ1aSAZe4UF9ef3Y85F8LU/Jl9IGTaGLzqvWUbStGYCrcG
	 wGheNCN2HLV7oh7s/OwpOp9KvQbgFUkSb5K95Xl7a56mt3yx58EpmlBgC4auXUbJN7
	 KI5QHihgn0ejBG5k4zg6w50K7oYV+EJo2IdN5nG80l2E+5TUsOu1zcAQOIMpzjA+47
	 4xb/WZqK/0UZIoWsXEZxr+1ZehqXpWThVt3nMpl3aFKuqNnHD6AWtF6pBGdvp+L78b
	 dAJpoo+VJwjzE8jLmF9X4+2LOGuXXl95FyOgBuRTk1TtRbJ2B9EOlisKwr9/9TFwbr
	 tKOpT8Q6EJQgg==
Message-ID: <d125e248-1300-477a-b60d-fc0842103905@kernel.org>
Date: Thu, 26 Nov 2026 20:38:08 +0200
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
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <179562868433.5580.1979396952125967073.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562868433.5580.1979396952125967073.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Mani,

On 11/25/26 19:44, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> Series adds hotplug support for the rzg3s-host driver. This is a
>> continuation of the series John posted initially at [1]. Along with it,
>> prerequisites fixes and cleanup patches were added.
>>
>> Series was tested on RZ/G3S and RZ/G3E boards by generating consecutive
>> link down/up events. The RZ/G3S has an I2C device which, depending on
>> the way it is programmed, it controls the state of the PCIe link. The
>> board has 3 PCIe interface: PCIE_SLOT, M.2 Key E, M.2 Key B. The
>> following script was executed for ~9 hours:
>>
>> #!/bin/sh
>>
>> echo performance > /sys/module/pcie_aspm/parameters/policy
>>
>> while :; do
>>          i2cset -y 1 0x18 0xf4 0x8 # Link down
>>          i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)
>>          i2cset -y 1 0x18 0xf4 0x8 # Link down
>>          i2cset -y 1 0x18 0xf4 0xd # Link up: M.2 Key B (NVMe Transcend)
>>          i2cset -y 1 0x18 0xf4 0x8 # Link down
>>          i2cset -y 1 0x18 0xf4 0xb # Link up: M.2 Key E (WiFi AX200)
>> done
>>
> 
> Given that this series is already 14 patches, you should really consider
> splitting it into atleast two. Patches 1-12 are mere code cleanups/refactors, so
> they can get merged independently and you can post the follow-up series after
> incorporating comments for patches 13 and 14.
I agree. Yesterday, when I got your review comments, I was in the process of 
preparing a fixes series (patches 1-6 + [1]). I've added [1] since its becoming 
necessary for our testing (and Ovidiu proposed it like this).

If you consider OK, I can also add the cleanups along with the fixes series, thus:
- patches 1-6
- patch [1]
- patches 7-12

Or go with 3 series:
1/ fixes (patches 1-2, 4-6, [1])
2/ cleanups (patches 3, 7-12)
3/ link event + reset root port

Please let me know which option you would prefer

Thank you for your review,
Claudiu

[1] https://lore.kernel.org/all/20261029172831.9409-1-ovidiu.panait.rb@renesas.com
