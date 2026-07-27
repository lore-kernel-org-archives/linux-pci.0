Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60641A55A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167949; cv=none; b=o6fWSRP3zh34pOszkOMiPZqP2Z9gLo/PO/5Ys1rUMNElV3umrV8xeb1L81QhWGZQIn0snG+Abbiu1BYN1DVSHiSUXPNkdDN4w+Jovbqp5oLS6DAMNE82ENgBLFUt1214XCZyN/UqQHWvCprWl8XQBaNE9678MtbUGD3F+PgqEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167949; c=relaxed/simple;
	bh=mEI4glK6xfztzEP9lF9Q8WPdR2CInQcy6A0Y0PatwdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtgw5KH+9XZq5Upk4lcLEHO9ut//pZegg5fWB7egyAj0QPujoXx5g1bQxcqGtSPvaBpze3yB49A8Cwxj8fs9k2tj1mu4ogEuSfpI5OZSUsXeoli2/CBrDMsaA4UoldKbdzUJ6D67pJx2fBXyOYLW045UIcpy0nHf9tcmmhijROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=gcCyrHGo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="gcCyrHGo"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0a81d286so231031cf.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785167946; x=1785772746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDKu6WnYtMuNqoe75mX3em2F4s5qQBDG9OSG0ciyep4=;
        b=gcCyrHGoo0Uld1Lz4WpMiJBf9VealsIm/TKOXTEAgCVuZlc9dHH4ucQPXYUVM3iaim
         fgaABGU3EPcupx57gNPvU5/ybEkpcyVsgwvwaeuT/ZhdEQaiM+XvpPzv2yLUZImYJcPJ
         boOhmHlBVmVJH5GXDplpBj7300+oXbYFlfSuxE1+mpXTsVVdjhlgO1kR/u9JKhXq/elT
         VIJMr5oaIbBqzD04fhAYkMh9K7rWLhh+4Z8lCnELg98XqTaoIb3zD01eWqUXK7OB6H4b
         2Y1q6NwMFjBGe6gq3gL4n90IWivuUMwIlm3FXHGP40Ro1ixs+azwOqwYZJmQdsGFtXdG
         vVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167946; x=1785772746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDKu6WnYtMuNqoe75mX3em2F4s5qQBDG9OSG0ciyep4=;
        b=k/POg5jfvztHDdv+0VMjKlqSR5SmGLWklRJiGlYNNnTvzzkR6gE7DUJHTWxvgdg3oh
         XJWkZEl+ZWy1afLo21sUKfJrBeEXorKLDSNS+D6no9VzjxKOHvWilEpr4WO10Ec89WER
         P/Ke95+hFB/FzLmUa9x9+hu5Ww9cdmLtA/QSx+XcIlzoUnUyi0jNW9hV7ZukjpsBaWsQ
         4m1rwW3OSDe/yzjxAnZyvW9zi4H8F4g2uWkVK9RijgMggXJETrM3bIke7OuDaWKdBy40
         N4ErSaRpLzzuTrPeoavkvq0r6OLwiv4Axy02R7jbriQFxZTdI3lu4G4Vg+rk0N63m6jZ
         MSsg==
X-Gm-Message-State: AOJu0YyvAtLtnx48TsZkE7EymCFbMjoouGFU9IROz2Z8EjPa6y2CBLk9
	xQOgHGsLQqgEisDVXgXedhZ8agUEiwZdGqiXSwSoGSfTbP9mKra5WH4BPRHl0dyT1nM=
X-Gm-Gg: AR+sD10NbGxn9JZQj72Lj7Fdi6eZkFp6MpF1lu0qvoJeizRcjdlYi3kpU0eb7R1eNxm
	7ayORb1WPkidvhIrirYzd4fTrsBY5fjZ6DGZvSDffO43KqFQNou78+RDm1+gPjHw4kNkQwDorYO
	wH44ucSZ/iz/i+tofJ9gDjiUGkq33JmmVFWjxFaBy/GHdmwA80vMaqW7us/QUF40wq1a1vASzxQ
	rYn7mA6fVjbwYzhhINPBEdqHrzsO0xJCZ6m0TROkNYybr34jfC6Q5i1X2ZDWcKEzsjUuXC5kub9
	oJVCN746th2A1R87WriypdwlB0klKsNEomW/LLURTGflIjUPcalIsn2ohnPUtguYFwY12NJoC2/
	HzfXEVQvOrqC4OXNFsUcv6KAwxR2PP3QX9riAf0eIdGWCkS+mCtscnjTefpQftmz/YeBY45vx75
	Ne11NzmkwCotGhb0/xFmA7Fs35b6BjZ/wnfsaY4ysRy2q/I2b6JXllqAyrEoJ7
X-Received: by 2002:a05:622a:4c8c:b0:517:87a9:6a89 with SMTP id d75a77b69052e-529d1d66c2dmr216011cf.6.1785167946403;
        Mon, 27 Jul 2026 08:59:06 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a262fa9dsm56944561cf.0.2026.07.27.08.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:59:05 -0700 (PDT)
Message-ID: <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>
Date: Mon, 27 Jul 2026 10:59:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
To: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
> config registers for configuring settings such as ASPM. The Endpoint
> device has 2 physical functions and those 2 functions share the same
> settings.

This was not clear from the code.  So this explanation alone
represents an improvement.

> Hence, parse the Endpoint node under DSP3 instead of parsing both the
> functions. The existing parsing logic also has one OOB issue as parsing
> both functions will result in accessing past the tc9563_pwrctrl->cfg array.

The issue you mention is that the array has exactly one entry
available for the Ethernet MAC endpoints, so parsing more than
one (if defined in devicetree) references a non-existent entry.
Right?

But this constraint only applies to power control.  There can be
multiple MAC nodes (for their PCI functions) defined.  And it
seems the pwrctl settings (if any) *must* be specified for
function 0 and if specified for any others, they are quietly
ignored.

Is that accurate?

If so I think the DT binding could explain and possibly enforce
that, but I won't insist on that...

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 488e1ec34a7f..482e82e433dd 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -596,12 +596,17 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>   		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
>   		if (ret)
>   			break;
> -		/* Embedded ethernet device are under DSP3 */
> +
> +		/*
> +		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * device whose functions share the same config registers.
> +		 */
>   		if (port == TC9563_DSP3) {
> -			for_each_child_of_node_scoped(child, child1) {
> -				port++;
> +			struct device_node *eth __free(device_node) =
> +					of_get_next_available_child(child, NULL);

I'd add a blank line here.

> +			if (eth) {
>   				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
> -								child1, port);
> +								eth, TC9563_ETHERNET);
>   				if (ret)
>   					break;
>   			}
> 

