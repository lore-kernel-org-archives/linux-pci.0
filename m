Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511D29B20D
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529773; cv=none; b=FyYr8hFwo4SRck0mijgodemMMgYKXoqkTWM5fv76dfrWw+5LMe1pYlV4ECSsUAGIz+/wIhkYLiiqVzgl9QDT1T69iVCWO3jUMdiuMbAiylBbsn2ROOLgd3ns36nzmDe3Yukm1UzD2eHQA2hzd8QrfytVnds8ePN/Y3wX5sqDXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529773; c=relaxed/simple;
	bh=AOyK9K7He9jaWEQcI0TLML2gpG/QGkSkNBxuQXYT1yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBt/tA1PQDZ69fpc7lymuAD5yPlK9THzJidaCXcSkyOyoiEuvKYVG2C9FKxNf4fs4gbv5gjL+rIMtwSOTe5PKz7ncVLza3g2OgUasMdqNg/yYfEwBiTm+q7kKqk/poGsTAoqPRJn6Oj0kkzVjs4WDOjf9x6BZ+beyNGys5bGtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KQhxWVqm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KQhxWVqm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fb112c09so9564895e9.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774529770; x=1775134570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v53LCrPXAsR6yI+88VBtN+4JZC9PqA7W1DCpmW7oQMM=;
        b=KQhxWVqmIDKZj8pG7iMOWyg01iAWIJGnIXDPbSc6mez85fbhulOa2RfJStsIfd6irK
         +8lwYtZlzdL0gU7qZ53QUXfPbgAFP6dfXE79KezzfGq7S8W6y4ABqoSS0db2Q/J7Cag5
         /7F/uWyyp+jVLrNR9msAaMYwgxNEZ9xYFJmIoOQaMocPtLipWpMRvDx+VgGtdN+FGGXM
         dR69jS4u5fdxISlSdAHLf3V+vym9tyfApJARZSjRSL4aNQfpWV5fBEOzDnEBEMEyvtbA
         k3XsHx5/TuvBOBiBtgr5SGM87HuoE9dDXfAiHtsduian3PpW6BtuDtQMm3cn9lrqG3AW
         4vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529770; x=1775134570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v53LCrPXAsR6yI+88VBtN+4JZC9PqA7W1DCpmW7oQMM=;
        b=ih1pehTBN2iYTv1R4oFD226Pe0AdPDzLCh67sa4W2jsYjxb8OSQpMTBiFZrmz3ravT
         QMWxlANUQNtFdBm/ZSgt0Gg92y8Yq0pOnC5poMvnMo4UvbHdOv+H9A60HrM7Qfg8pFMZ
         eXn47gJpwFnsFe3pENun5ARbh7pNikbjIlVFhXSAsD14l5+Ufpo4sUQy/HVqqwHfowpq
         dM8o3UeH1yOXjLQqm277VBV4swUlDfpMQx8qJD/S9Tm4N9FVN+HZQO7ci/h12hNeBLP3
         bDTBC9X2uuey8wX1hvNuvJ4VvHpJaMXN9x22Re+tbLFyUZn/tlWg1lfrMjIJP0N7VwYR
         jtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZKGEDRzHT9dKY/1s/plo+rrbaRuBud1tXYlkE/TS45S24Tr264MjauU2JkCo0YO5TZsvRWGHrpUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQwnVEsV5ehkfAtXxvyvD+BfdkXbXmHS1cF6tOtr5Nu64+hUI
	5eF+tSHaMbC82koI9+DyLyD/NL7rlt9LvjcmHx7TsHTjzM38h3QD0/+8e/GRinCZJZk=
X-Gm-Gg: ATEYQzy0LjzJTU/e1ZqZLfvRp733bsUdrWZCnrO699NZgfuEbhc/mUy1R0GpS1EvsMH
	fNyvJcujFI9cBY5BWioIH75d4obvWf1nrN5Edwo4Q7OFLFSGsY15srzuoX36s0+TTZUSI8/1alv
	XENeiCZtLx4y9ZMNjEnmBQ4kgzFOvr/6QnBoqiZx0Pb5wOlfwJ97UmXMTQJFfHzUTTF0f/rR2PM
	raB5vtrKGud1sy0ofNUabOC8X0wZteETUWuoZm0CboPJjcVxzebtb+wjYl8g361s5l8ZJygxGlO
	PbRCoUfrPe0kEpSY/W3FrJTAKGHHKi07lbGQq9WzG6uz3uPEcOOI9APAjymmkSffzWSw8iyt8C5
	zn4Rf8AfEiQdxO9UJC+AGiBqWIFOBduvSK0Ik12vNh7wNag/xAzB6LFC1PqFmyE3m++IS5z7tsd
	8owVC96gJihl5FI+wYrEO66P9EYgucPhc=
X-Received: by 2002:a05:600c:3490:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-48716042c08mr111608235e9.19.1774529770172;
        Thu, 26 Mar 2026 05:56:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c789ecsm28316645e9.4.2026.03.26.05.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:56:09 -0700 (PDT)
Message-ID: <693acd52-987e-4018-ae02-386dbd430462@tuxon.dev>
Date: Thu, 26 Mar 2026 14:56:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev>
 <CA+V-a8s_Kv5WwocsKy_qBEtZ=0gzN-YbAz3pYjubf_qZVLhBew@mail.gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CA+V-a8s_Kv5WwocsKy_qBEtZ=0gzN-YbAz3pYjubf_qZVLhBew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 3/25/26 13:53, Lad, Prabhakar wrote:
>> from [1]:
>> "For example, if rzg3s_pcie_resets_prepare_and_get() returns -EPROBE_DEFER,
>> the static variable is never decremented. On subsequent probe retries,
>> the variable will be artificially inflated, eventually causing the bounds
>> check to fail and returning a permanent -EINVAL. This would also prevent
>> driver unbind and rebind from working correctly."
>>
> The other alternative would be the below, where we wouldn't need to
> use the num-lanes property but would need a comparison with the DT
> compatible,

Or move rzv2h_num_total_lanes outside of rzv2h_pcie_setup_lanes() and reset it 
on failure path.

> 
> +       for_each_compatible_node(np, NULL, "renesas,r9a09g057-pcie") {

If it's possible I would avoid spreading compatibles though the file but instead 
use driver data where possible.

Thank you,
Claudiu

> +               if (of_device_is_available(np))
> +                       count++;
> +       }
> +       if (!count)
> +               return 0;
> +
> +       /* If both PCIe channels are enabled configure the LINK_MASTER
> in x2 lane mode.
> +        * If only one channel is enabled check the port index and if
> port1 is enabled
> +        * configure the LINK_MASTER in x2 lane mode, otherwise keep
> it in x4 lane mode.
> +        */
> +       if (count == RZV2H_MAX_PCIE_PORTS ||
> +           (count == 1 && host->channel == 1))
> +               host->link_mode = RZV2H_PCIE_MODE_DUAL_X2;
> +       else
> +               host->link_mode = RZV2H_PCIE_MODE_SINGLE_X4;

