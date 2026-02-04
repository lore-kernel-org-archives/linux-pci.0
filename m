Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D73F0769
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208403; cv=none; b=uK5Q/6UKh4leM5Bqb3NQpfUw8FLCum6Cqudy7gruR6c5NjlMXj2obF2nBUQ5nY2exNaDQObAb09YsPi35uK0lc/oTgkfSIby01hXPwuzr/s9RA51KnBkgrE9pIa7PhlvvNOVhAXU9VPo5OQR1xzKQDwP4XzZ71un3d/pgGr2U8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208403; c=relaxed/simple;
	bh=3aWb2+Gb2KAFgpNX6m9YjkRl5sjzP1BcDCEHLkg+3Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4+8JZRSh7XpC1/TR0FxOqGtKUZggzLTd+/YCOekkRlJ/MX7CaHz2ijgrbUwIqFD7n5nwUhxYOWtbbobNibNAKtyW5LSkhtUv/ekXLl/Ey44H5BijMSw+oUQdPoTH++OCdNzwxTNiakBjNdury4f9M4rRy6/Q++OlpwC0x0gTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iIftq1uv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iIftq1uv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so49839705e9.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Feb 2026 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1770208401; x=1770813201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB5JaRsNpoCnZepyi0nCuJMBvHsl1mEmdY05cCIU6OM=;
        b=iIftq1uvpAdXK73jmzxj3HRsP2q7UOqb6UEdccllGlI1IdH9UFt6nwhk1XDm9NRJi5
         B9jw+gi21qzZMArOv+vabvbtt6zXqD46JWpLIWXPx414Unabhaq/cKsG9kSmcXQPP5d8
         Pb4QvDVJ6/lnc+uUhXqx/7lECcZsR4LsmboRyj8kPMh/3Z0dpwPxFyhCD6MSXoj5R2wD
         PWV28/PPR9wq2B8g8PYQFfw3yByuHspGe8M6t0GMqKn3RB54K1gcEKr2Ku7l/iyLpHg9
         thEPpl3pDb0XMNxi5Cq9pauS8ddEKBo8icCtrx1ckVTB5GfWj2lgWwG9DaK/lXvWvrTd
         rmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208401; x=1770813201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB5JaRsNpoCnZepyi0nCuJMBvHsl1mEmdY05cCIU6OM=;
        b=nw7VVZG1hcYyICdqFdwAx44+nGgheK01epvJhmO1Oqp4Z+gofH9mPvf9KQIcm4ocme
         4N2C8Ti56Kh1Yz0G+btinRZroj6lQQqnLnmrVxD/wC+eSX82Aih8dPg4IddLrB4JotZl
         6seMGMVrXXz6RjGiZOFPs7AaAoNFlEaPqija2ax6ncbSbUPtgpJYRLcuPKvta6UguYZh
         qPU9xcLEIWRxTgrWmttB1MoTDaRxpaqPklQXcKzrmpUkar7Yw+rAtqYdYafzLbH9TcOa
         DkjV2Vrp6y8Z4t3qv8gbi2rIOdiR1v7ASZvWYI1lBbOMXxzVtRptFLRAalvt+xITlOOA
         O26g==
X-Gm-Message-State: AOJu0YwfqcW/aPrVlT3j3BTPsvZmRL+UXDj8bSY+EpdSdzFtWN/Y2niL
	Xtx/i0sYhHEjzCCA/Jo92hzltkiks32Gpu6biVTmdA4nRKSbHCFA+WRimnSyiOgF3tI=
X-Gm-Gg: AZuq6aJ4Fstgu5HjV0okGJSJtkFeBQQbbO31+cFCV3Uxudx4fwRGfRbRRdaah8vvDCh
	sfSeXoZnAtGIPA/rgt8eWVcYJRJR817x8k82vrT/ErN37+rGA+LYafZqmvO3JOTkMbF4gUjTRWW
	+aZLnlUTvIwBzm+ZimGYe5zFsa8xCD48XBaGvQHfEKChUw5EyR8skud64xN2AuQpGSbJakpH3la
	kGyoVRhvBuRRTvoGOS1p7dzH75lUI9iGJpuspiW9XsP8hpBvTJqlvgjAoNs9BJBiOl/Q5Ma1BeP
	QpQxNcrNNVlZwmz+Zbz10+4IuY7uu4UkF8p2tTCjAMDuhtiW4hRIXz7jkaRnxtSOyvtRjBEWgxM
	t2z+sq2rf3fkhf5OaWR4LPDRp3XlY4NBNEAlva3ZPc7c70ntFHbalEgBxniyz5cfBtDldMc9t+1
	z8Gg3D9kn9ISSz2uQdl7A=
X-Received: by 2002:a05:600c:3496:b0:47e:e2b0:15b8 with SMTP id 5b1f17b1804b1-4830e93ebe2mr36434415e9.4.1770208400957;
        Wed, 04 Feb 2026 04:33:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec4a76esm30285155e9.1.2026.02.04.04.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 04:33:20 -0800 (PST)
Message-ID: <c1f4ad90-bcdf-4dc3-9eae-2a74df86bd3d@tuxon.dev>
Date: Wed, 4 Feb 2026 14:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rzg3s-host: Fix device node reference leak in
 rzg3s_pcie_host_parse_port()
To: Felix Gu <ustc.gu@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260204-rzg3s-v1-1-142bc81c3312@gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260204-rzg3s-v1-1-142bc81c3312@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 18:46, Felix Gu wrote:
> In rzg3s_pcie_host_parse_port(), of_get_next_child() returns a device
> node with an incremented reference count that must be released with
> of_node_put(). The current code fails to call of_node_put() which
> causes a reference leak.
> 
> Use the __free(device_node) attribute to ensure automatic cleanup when
> the variable goes out of scope.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>


Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
