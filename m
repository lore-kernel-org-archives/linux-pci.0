Received: from mail-m6013.netease.com (mail-m6013.netease.com [210.79.60.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DC4078F6
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049533; cv=none; b=DCsPV5NkHZW05jvVTHBy87oHinlgmDEK5SOmWS3XSS86Hm9ofDUtHYIW7wR1QV5QSQnOpQm9dlON7qqppEtARseubdHDWXZRpyTyh3sTkpUnvpE/giBylSQjK+eK+yN3g491Jg8iqwVoB2utKRlB3x73C3hiJmKgn2XVQMbo2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049533; c=relaxed/simple;
	bh=6/5mvi7rRcybt4IIfOapLz8S/Wxp/llFlbhgFShVn+w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rn4TelAys583oBwkByfjst3BmWiAsNs+YhzhiT5IyXndgjU2DFnD3+XYrJ3zRUs+1uPJM8NOqyDN2x9ZlbpVa81ApUonKrC/vNuWLRhdo2xsCqFxrxc4crfICHvNqMzteHGz302ikyi4Ha7gDxJb9T7M+vbYVbkkClGsDh2movM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=auzjaEqI; arc=none smtp.client-ip=210.79.60.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="auzjaEqI"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 51239597c;
	Thu, 15 Oct 2026 15:31:54 +0800 (GMT+08:00)
Message-ID: <cff4d453-2662-4f6a-9bf7-cb6e34df640d@rock-chips.com>
Date: Thu, 15 Oct 2026 15:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] rockchip: add PCIe3 PHY firmware for snps-pcie3
To: linux-firmware@kernel.org
References: <1792049275-83785-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1792049275-83785-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13e79877a03a4kunm0977b3a83d081f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1OVktDHRlKQ0oZQxlPQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=auzjaEqIgSbusTQCwRD7U3RlyLUCbog7sVcR7MDniUj/ed2CDrj9aiRGotU52uz+OmsaiijmV1OtXYwH2bR4SNs9R9IWrMx6t+JCqSkcbT9BzHaxMNCWQ3QSIuDZMDJhaaV1lCM8NQ4CysIruhEOrQxPnlP+lONI2lXGTcqeHQw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wwCSQGaxxmaXLubzi+C8EqjDQPmZ49ucLYmcq+Jeeu8=;
	h=date:mime-version:subject:message-id:from;

[cc: linux-rockchip]

在 2026/10/15 星期四 15:27, Shawn Lin 写道:
> Add the firmware binary for the Rockchip SNPS PCIe3 PHY, used by
> the phy-rockchip-snps-pcie3 driver. The PHY loads this firmware into its
> internal SRAM during initialization; without it the PHY may come up with
> a stale microcode and fail to establish a stable link, especially on
> RK3568.
> 
> File: rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw
> Version: 1.6.3
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>   WHENCE                                   |  10 ++++++++++
>   rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw | Bin 0 -> 16384 bytes
>   2 files changed, 10 insertions(+)
>   create mode 100644 rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw
> 
> diff --git a/WHENCE b/WHENCE
> index edfb934..079a998 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -6399,6 +6399,16 @@ SPDX-License-Identifier: LicenseRef-LICENCE.rockchip
>   
>   --------------------------------------------------------------------------
>   
> +Driver: phy-rockchip-snps-pcie3 - ROCKCHIP PCIe3 PHY firmware
> +
> +File: rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw
> +Version: 1.6.3
> +
> +Licence: Redistributable. See LICENCE.rockchip for details.
> +SPDX-License-Identifier: LicenseRef-LICENCE.rockchip
> +
> +--------------------------------------------------------------------------
> +
>   Driver: mt76x0 - MediaTek MT76x0 Wireless MACs
>   
>   File: mediatek/mt7610u.bin
> diff --git a/rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw b/rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw
> new file mode 100644
> index 0000000000000000000000000000000000000000..4e3e832b1ef79202ce65dbadd5a32e18c4b21425
> GIT binary patch
> literal 16384
> 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
> 
> literal 0
> HcmV?d00001
> 

