Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563743;
	b=fXwABgk1hBg0bBr6hyW1J87ZERSAztCLXbM+ztAj4XNhiGym4v+GM9kf1AoEXhev5IC4
	 cgAxqqOr6efowgbjXwkj3ZFO3xQjM5DXJTP9xigRbzpWy2FcIHVfDkzmjmfmbIEpmyqKu
	 d6FhN/d0VhU79QE0xZSdAsJoWfTlJt9eWqVJdI0DNDnyk/whwAxflHTsxd7/RIdIOgO4Y
	 BDViOdnx4DBLMzIJxNj1ByBsZJApxss9DljyA5l8Svu6RQ3xjEKonaaDcRrodpsOA/S0N
	 og414hgcZ/oOvHWeLLa5d8vcKhX7n9Ra5OJ+EOwl13SUBqkYbVdcSu27GgswscUlcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563743;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=O7SKCVB4PMXbdqrNEiBDGYQ9dYqNfd/aoujObYmzbmg=;
	b=KV93QCmS5AmDmmbfG53C5e/x5IwyRp1ksdpKZSiG2wAIbeWAuSpSs9lHBvaKeHzdqTaU
	 DFmfqZBxFqYKcpuBQjV35iXAR224HXwlkiY8AaOphJ2Ul9+q0d+cBzlmMr5G71sVb3zmz
	 uqQHtPQRf3Pf0ZoTB2oQ3bVNaxtxVMjtcIPwc/eJBVzsO00bV2AQUWUEGeulgdL9ceJXr
	 L7crO2G++C6Nb3/14Igmsh24tE4SCzgCmfXplALFICB2zmj6ep/8mZ3JWzijf8u994Whw
	 9yZkdR53BFVajNytmGqNUxo5TwiZZQxKsQtcbkog8b5z1AFF/hs1echDMJH3xOBndtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hBCS76Q+;
	arc=none smtp.remote-ip=103.209.128.108
Received: from mail-m128108.netease.com (mail-m128108.netease.com [103.209.128.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE731606A321
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 09:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE731606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hBCS76Q+
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5495af5ba;
	Fri, 13 Nov 2026 17:55:30 +0800 (GMT+08:00)
Message-ID: <4fb5e43c-93c7-4284-8e9c-af403cfe16d1@rock-chips.com>
Date: Fri, 13 Nov 2026 17:55:27 +0800
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
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/5] phy: rockchip-snps-pcie3: Check more sram init status
 for RK3588
To: Alexey Charkov <alchark@flipper.net>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
 <1766560210-100883-5-git-send-email-shawn.lin@rock-chips.com>
 <CAKTNdwFfQyMGJQnFU5cwQyOsXvEx4NowOT6n-jPkM4b0zGX50w@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAKTNdwFfQyMGJQnFU5cwQyOsXvEx4NowOT6n-jPkM4b0zGX50w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d4556b3903a4kunm237a15301760be
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUtIVkxOSB1NHk8fShpJGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=hBCS76Q+d8V4O4Z3p5xbAYHQNvimilnBft09vdrZ6Of7g3VHStYkGDR2mEgv1HILwMravYvVXplN/vTWdczG7acQm7JzzBO8YLJCCFrp1vx4WaE3RpT9SzQcAJ3bc54azR4o5m6ceEhMmXlNKm05QhbBiCfSpw/6h9jz4+ImO6s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=O7SKCVB4PMXbdqrNEiBDGYQ9dYqNfd/aoujObYmzbmg=;
	h=date:mime-version:subject:message-id:from;

Hi Alexey

在 2026/11/13 星期五 16:46, Alexey Charkov 写道:
> Hi Shawn,
> 
> On Wed, Dec 24, 2025 at 11:10 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> All the lower 4 bits should be checked which shows the mpllx_state.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> index f5a5d0af..6cc38e3 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> @@ -43,7 +43,7 @@
>>   #define RK3588_PCIE3PHY_GRF_PHY0_LN1_CON1      0x1104
>>   #define RK3588_PCIE3PHY_GRF_PHY1_LN0_CON1      0x2004
>>   #define RK3588_PCIE3PHY_GRF_PHY1_LN1_CON1      0x2104
>> -#define RK3588_SRAM_INIT_DONE(reg)             (reg & BIT(0))
>> +#define RK3588_SRAM_INIT_DONE(reg)              ((reg & 0xf) == 0xf)
> 
> This breaks PCIe3x4 on my Radxa ROCK 5B, which then cannot find its
> NVMe root filesystem. Sebastian's rockchip-devel branch carries this
> series, and kernels built from it fail with:
> 
>    phy phy-fee80000.phy.13: lock failed 0x7, check input refclk and power supply
>    rockchip-dw-pcie a40000000.pcie: phy lock failed
>    rockchip-dw-pcie a40000000.pcie: probe with driver rockchip-dw-pcie
> failed with error -110
> 
> The RK3588 TRM (V1.0, Part 1) describes PCIe3PHY_GRF_PHY{0,1}_STATUS1
> as follows:
> 
>    bit 0     sram_init_done
>    bit 1     pcs_pwr_en     (reset value 1)
>    bit 2     pma_pwr_en     (reset value 1)
>    bit 3     mplla_state
>    bits 5:4  reserved
>    bit 6     mpllb_state
> 
> So the lower four bits are not all PLL states: bits 1 and 2 are power
> switch enables, and the only PLL among them is MPLLA, while MPLLB is
> bit 6.
> 
> On this board MPLLA is off even on a working link. With this patch
> reverted, PHY0_STATUS1 and PHY1_STATUS1 both read 0x47 once the link
> has trained at 8 GT/s x4: SRAM initialised, MPLLB running, MPLLA off.
> When the check fails they read 0x7, so neither PLL is running yet at
> that point, and checking for MPLLB instead would fail too.
> 
> Reverting only this patch, with the rest of the series applied
> (rockchip-devel at d7436346fc31, v7.4-rc2), brings PCIe3x4 and the
> NVMe back.
> 

Each port has a MPLLA + a MPLLB. In aggregation mode, MPLLA should
always be 1 once done for both of port0 and port1. But in bifurcation
mode, MPLLB will change. So basiclly, Rockchip PHY team suggests to
check mplla instead of mpllb for differnt use cases, during calibration.
That was done for vendor kernel for quite a long time. So I was
surprising to know in your case, rock 5b using it in aggregation mode,
it didn't work that way. Please let me ask interanlly...

> What is the check meant to catch? If it is PLL lock, which bits, and
> at what point, would be right for a link that runs on MPLLB?
> Otherwise, sram_init_done (bit 0) alone looks like the right condition
> here.
> 
> Best regards,
> Alexey
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

