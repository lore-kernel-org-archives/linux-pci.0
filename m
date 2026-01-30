Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519F2E4258
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781174; cv=none; b=O30qa+Nzz0pdQ3rlHpsUISeFNiR32euRGaThYRvPTqp9hN2SXXaat57+wK/zyfwVomSBd5FxcD8qFDvHaemo1fFEejvbCFiP+vEFoEz1VLHxbaZo+K3rX4y+1YP9VtShlYxy0jjYsyyBhkBGG9vVcJZ1BCrDhWxDdhw21FSS1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781174; c=relaxed/simple;
	bh=7BkjoQJU+ia2PMS1t5wmpNqwQAEhRIVS+TW+cvlD5bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bG0s7ocHk8nZMfE+1FTlUpFbhZKZgJxedCJooIGON4Lqa2nGtu6txK349QLEMiK6rj6HwaYODozliiUzE2JvtEfc1qiuUPmUlCvivhPdqx2uszrcJw1elDjhyXQCgiPmtiz3JF3V9P0XQMZa4Ks1mLyXA9+m0hQqgETZI4k+h2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YIMR9XBi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YIMR9XBi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48068127f00so18250435e9.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781171; x=1770385971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INGNfIhX3cdl2idoxtcthwbVKbbQU48P6iBpGUwnFNY=;
        b=YIMR9XBiyiyxl12ahO49Vo1+a9wJ/8o0FOrtTzKlFIy0cBvSZLlgKl68Bl3jMQTQAq
         TcPbphZkyRtS+IyKrc2XcNpPTxQRBX15D1Fz+m0rgxLg4C4ZLHvvhvVPaRI46VCqygju
         1Vlok839z2bk6I62wSyA3QQf1+d13NOwShX4+xeu9A1284RfcO0k3JqvsBp01axcAbgG
         eP6r6zb4Qn4t6k5nVC4umGHO+yfybmicUug6BmV2pxKxn33xv8DIxm8KCJvvOZR/sfRg
         JfZJ1QjoukAL1R8BWPzMJoQXENPh0tO/LvBC7Zh1BsDBWLsWrqh0aCUkYfOgZ0GFOM+5
         ACWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781171; x=1770385971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INGNfIhX3cdl2idoxtcthwbVKbbQU48P6iBpGUwnFNY=;
        b=mR/lZNm8sVflJMyuU8N8Bb0XiO2NPjzrGBp6BW2szG4cWAexJW8kSewG0C+sIOLLbO
         nWP5GzSEtp1XN4hABiLy8oAY2+yG03mKi4b3CWKxtqcSI4QwsyD3kpcXzrL2PnwWY/Vh
         5C3zl3QR/Xq/X2ZDSDqSE3Zc/sYN6fapvJabLU2+E23AGzAPj4TOSzmT3br9RnivsUbe
         UyTcbavOEQBd/5KSvJgOSfu0hDWiihnZRYNf7cmLpYtWiPlh93+/4TifPPEmr4WtN1ZG
         y9KowSD3xQfiqV46FmHp+3M7Vr6fX5qW8/M/ETZlUWxsd1ECzyCBj8FeYW7JExmkb7rA
         pB3A==
X-Forwarded-Encrypted: i=1; AJvYcCXFi+YhaEwvkPD9TS0Nv6itvB6RMz8CgQo5STmVW3mnEfv+R31YeIYDyI1jrSUY/EGAaHpDmIqY+zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHtbXSKnX8FsaE4TWBK+42w47a3gk1TE5Usm2D7ErZ4b4dNPX
	WDF+cQIkMPI8d9iGGn3muw4AQMzv1WJqtwlpuhB5kXYIk78eKoh+GvhI/w8dBrLfpvQ=
X-Gm-Gg: AZuq6aLumloEuzXEVtP0oom6Dq7dPieYrOqOLSDc3i4X/Q/t4VA5qz9BcYrvkH7mLkC
	NomUjQ39a6R0dO3DAxZgmbaXedVyoSICoRJqRRk0ZQYX1vnc5nsi2X8rnZLAkpTAYsGLuyi8FYE
	5ioKcBijiuIlBeyVTcnPoSzGuaWhJ56UP+S5fE4c5VRpv2VYDU9B9krkgl5XBpaa9rJN6l5CpKa
	RGoxxUR2Xzvt0gXgggQZzIChPGTbvFgT45Pja32nvd0R+o8f2c8+VqU9ihLUCnZxDw6XJXpgc7Z
	Mvt2fHoXiHjQaR3s5Vc50nAILR+BInqfE43LtFjyh91PoKKNNl8rGJOwfXePp99lRilJDlrvBPw
	gN1fZm3nH8sMTlKPcUgxBQIVSzmJucjrhpJr5dOtJmwu+9hCpl6gLiGCL03/5K3PtXL2jEZnrHi
	/doQGvutifk0CurNzwSozvF3+O61ze
X-Received: by 2002:a05:600c:a306:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-482db45ded7mr32976715e9.7.1769781170326;
        Fri, 30 Jan 2026 05:52:50 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e047e644sm16278305e9.2.2026.01.30.05.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:52:49 -0800 (PST)
Message-ID: <4b4ddd9a-35d1-43d7-b25b-5101f914a68e@tuxon.dev>
Date: Fri, 30 Jan 2026 15:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] PCI: renesas: rzg3s: Rework inbound window
 algorithm for multi-SoC support
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-3-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-3-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/29/26 23:41, John Madieu wrote:
> The existing inbound window configuration algorithm has two issues that
> prevent proper operation on RZ/G3E:
> 
> 1. Over-mapping: Using roundup_pow_of_two() on the remaining region size
>     can result in windows that extend beyond the intended memory region.
> 
> 2. Alignment violation: Addresses are only aligned to 4K regardless of
>     the actual window size. According to the RZ/G3S HW manual (Rev.1.10,
>     section 34.3.7.6) and RZ/G3E HW manual (Rev.1.15, section 6.6.7.6),

Section 34.3.7.6 does not exist on RZ/G3S Rev.1.10 neither on later revisions. I 
suppose this had to be 34.6.6, point 7.

>     bit carry must not occur when adding AXI Window Base and AXI Window
>     Mask registers. This effectively requires the base address to be
>     aligned to the window size.
> 
> While RZ/G3S tolerates these issues,

I don't think it tolerates this but I haven't tested more than one window.

> RZ/G3E strictly enforces these
> constraints and requires precise window boundaries with properly aligned
> addresses.
> 
> Rework the algorithm to properly handle arbitrary region sizes and
> alignment constraints by splitting non-power-of-2 regions into multiple
> windows. The new approach iteratively selects the largest power-of-2
> size that:
>   - Fits within the remaining region (__fls of remaining size)
>   - Does not exceed the natural alignment of the CPU address (__ffs)
>   - Does not exceed the natural alignment of the PCI address (__ffs)
> 
> This ensures windows never over-map beyond the intended region and
> satisfies the hardware requirement that base address + mask must not
> cause bit carry, while maintaining the 4K * 2^N byte window size
> constraint.
> 
> The reworked algorithm is required for RZ/G3E support and remains
> fully compatible with RZ/G3S.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v4: No changes
> v3: No changes
> v2: New patch
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 53 ++++++++++++++----------
>   1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 58e78fc52913..7b42f9415d3a 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1270,50 +1270,59 @@ static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
>   	u64 pci_addr = entry->res->start - entry->offset;
>   	u64 cpu_addr = entry->res->start;
>   	u64 cpu_end = entry->res->end;
> -	u64 size_id = 0;
>   	int id = *index;
>   	u64 size;
>   
> -	while (cpu_addr < cpu_end) {
> +	/*
> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.3.7.6) 

s/34.3.7.6/34.6.6.7 or 34.6.6 point 7


> and
> +	 * RZ/G3E HW manual (Rev.1.15, section 6.6.7.6):
> +	 * - Each window must be a single memory size of power of two
> +	 * - Mask registers must be set to (2^N - 1)
> +	 * - Bit carry must not occur when adding base and mask registers,
> +	 *   meaning the base address must be aligned to the window size
> +	 *
> +	 * Split non-power-of-2 regions into multiple windows to satisfy
> +	 * these constraints without over-mapping.
> +	 */
> +	while (cpu_addr <= cpu_end) {
> +		u64 remaining_size = cpu_end - cpu_addr + 1;
> +		u64 align_limit;
> +
>   		if (id >= RZG3S_MAX_WINDOWS)
>   			return dev_err_probe(host->dev, -ENOSPC,
>   					     "Failed to map inbound window for resource (%s)\n",
>   					     entry->res->name);
>   
> -		size = resource_size(entry->res) - size_id;
> +		/* Start with largest power-of-two that fits in remaining size */
> +		size = 1ULL << __fls(remaining_size);
>   
>   		/*
> -		 * According to the RZ/G3S HW manual (Rev.1.10,
> -		 * section 34.3.1.71 AXI Window Mask (Lower) Registers) the min
> -		 * size is 4K.
> +		 * The "no bit carry" rule requires base addresses to be
> +		 * aligned to the window size. Find the maximum window size
> +		 * that both addresses can support based on their natural
> +		 * alignment (lowest set bit).
>   		 */
> -		size = max(size, SZ_4K);
> +		align_limit = min(cpu_addr ? (1ULL << __ffs(cpu_addr)) : ~0ULL,
> +				  pci_addr ? (1ULL << __ffs(pci_addr)) : ~0ULL);
> +
> +		size = min(size, align_limit);
>   
>   		/*
> -		 * According the RZ/G3S HW manual (Rev.1.10, sections:
> -		 * - 34.3.1.69 AXI Window Base (Lower) Registers
> -		 * - 34.3.1.71 AXI Window Mask (Lower) Registers
> -		 * - 34.3.1.73 AXI Destination (Lower) Registers)
> -		 * the CPU addr, PCIe addr, size should be 4K aligned and be a
> -		 * power of 2.
> +		 * Minimum window size is 4KB.
> +		 * See RZ/G3S HW manual (Rev.1.10, section 34.3.1.71) and
> +		 * RZ/G3E HW manual (Rev.1.15, section 6.6.4.1.3.(74)).
>   		 */
> -		size = ALIGN(size, SZ_4K);
> -		size = roundup_pow_of_two(size);
> -
> -		cpu_addr = ALIGN(cpu_addr, SZ_4K);
> -		pci_addr = ALIGN(pci_addr, SZ_4K);
> +		size = max(size, SZ_4K);
>   
>   		/*
> -		 * According to the RZ/G3S HW manual (Rev.1.10, section
> -		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
> -		 * 12 LSB bits to be 0xfff. Subtract 1 from size for this.
> +		 * HW expects (size - 1) for mask register, e.g., a 4KB window
> +		 * (0x1000) requires mask value 0xFFF.

This change is unrelated for this patch. It can be dropped.

With those addressed:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

>   		 */
>   		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr,
>   					      size - 1, id);
>   
>   		pci_addr += size;
>   		cpu_addr += size;
> -		size_id = size;
>   		id++;
>   	}
>   	*index = id;

