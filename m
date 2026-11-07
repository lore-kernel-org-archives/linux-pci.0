Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018919;
	b=P2j28abWbLvU+QA+sRAPUFZCj0OPaA+rJWI/J8T99Ltusiw2dI1t2b6CBcLUX3usEO6+
	 YghsApAAzaFY05lyCEc5JYM3vmDJFYb/8P9EuBqZFokzRVZJAeQ5viRXjkShRY3mzwB0+
	 ONonxrZSjwgV6LEc0Qst6UUGHaRnpb7DPE65iyhOjJQut4nFB3BPSxKj8BkzfHNEmPX+K
	 zwYv7Vis+BFhUdLUiJ7Xk+IAAR+tA/zNgwIWTWUOo7hB152aXmWmiR9C9Oy71CK1QbB+c
	 /ZwUrwZ0anR+DO3agy+odwM/t53uHvD9soj4yDm8R9ayYvHuMZzAuNtcwSqnfWcBW4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018919;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=Z8Cc7N+D8LwMYtORpVehAaXnRfBR/5w4HT9eKf1jaIE=;
	b=u0WwJ2uXkGyOXOmmWPvWklgFBKdVEpsnx2cEkyJwRIb46o48U1SlXs1VVQSJhVRqdM/v
	 2UoLfXqD+O5MAxS7QKQjLt7Pxf9Tlc83X+clVhxLCMCGs4VAn8Ee8TOUndG5drSXy6iZk
	 eO0LxeuXZBezTzRJwci24JfqWm2sXyI30pEUow/HOj4tUiaiH3XHYnS7fNaPA9ce6BqCZ
	 oNRRfgRz0iZx/1qHZwDJ8DXgWxq3gGRadDdXzY98Cmw976WUnPuwxjgLgYCFy4sqYoeco
	 8Fz9TKFU4rwdBJsBEmKbH/CMtjtRStnZ3wpHCXFPXd++p83ttqJ65wCdpEwCZYL9+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hvJR7mQK;
	arc=none smtp.remote-ip=210.79.60.77
Received: from mail-m6077.netease.com (mail-m6077.netease.com [210.79.60.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E950606A32D;
	Sat,  7 Nov 2026 02:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E950606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hvJR7mQK
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53d327815;
	Sat, 7 Nov 2026 10:35:05 +0800 (GMT+08:00)
Message-ID: <6c9adabe-d632-471e-8fc1-aafe62115167@rock-chips.com>
Date: Sat, 7 Nov 2026 10:35:04 +0800
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
Cc: shawn.lin@rock-chips.com, =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?=
 <ehbello@gmail.com>, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset
 a JMB585 on RK3399
To: Igor Velkov <iav@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
 <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com>
 <20261026-rockchip-pcie-shawn-reply-1@iav.lv>
 <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com>
 <20261028173117.3457220-1-ehbello@gmail.com>
 <20261030-rockchip-pcie-s2idle-a53-1@iav.lv>
 <20261106-rockchip-pcie-ltssm-trace-1@iav.lv>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261106-rockchip-pcie-ltssm-trace-1@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1b3dc0c7703a4kunm35aff5ba43fb5c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH05IVkodTkMdQ0MaQ05DQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hvJR7mQKfA7FUkt0VirpverykUfmFAKCqEGfnoaFE19hYtPSjIDT+bQoNAzsni6ZjJ95cow7WggmSs3Gwjfm/stmx3uITTnBYv6AeFs0jQ/stl/IBgUbjN5LMFgjxQuqQuh+G7tvz2bLzeP3wYkGUl53+ShdslJ2whRbz7l7gWA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Z8Cc7N+D8LwMYtORpVehAaXnRfBR/5w4HT9eKf1jaIE=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/06 星期五 13:09, Igor Velkov 写道:
> Hi Shawn,
> 
> I traced the LTSSM on the Helios64 (RK3399 + JMB585, x2, 2.5 GT/s) by
> polling PCIE_CLIENT_DEBUG_OUT_0 about every 2 us during link training
> and the waits after it. This changes what the RFC said, so here are the
> data and a question.
> 
> A failing link bring-up looks like this:
> 
> - the LTSSM reaches L0 as fast as in a good one;
> - then it leaves L0 for Recovery (RcvrLock/RcvrCfg/Idle, about 5 us)
>    every 199..204 us, for as long as I watch: 488 times per 100 ms;
> - link_st in BASIC_STATUS1 becomes 3 only 15..47 ms after training
>    starts, or not within 700 ms; the latter is the "link training gen1
>    timeout" with LTSSM 0x10;
> - the RC shows nothing: AER and the device status are clear, and a dump
>    of the client, core management and root port config registers is
>    identical to a good bring-up.
> 
> A good bring-up has no Recovery entry after L0. A config read on a bad
> link gets no completion; that is the abort I reported. 200 us is the
> optional Flow Control Update timeout, so I suspect that one side does
> not see the DLLPs of the other.
> 
> The state survives Recovery but not Detect: a port re-init or a hot
> reset is just one more bring-up, with the same odds. So the hot reset
> of patch 2/2 does not cure anything, and the time the link takes to
> return is not a reliable sign either.
> 
> Unbind/bind cycles with a bad bring-up (a cycle is one training plus
> one hot reset):
> 
>    Helios64, JMB585, x2                     6 of 104
>    same, PHY refclk 100 MHz from NPLL       4 of 33
>    same, num-lanes = <1>                    0 of 104
>    ROCK Pi 4A, WD SN770 NVMe, x4            0 of 100
>    same, num-lanes = <2>                    0 of 100
> 
> So it takes both lanes and the JMB585.
> 
> Is anything like this known for the RK3399 with a two-lane endpoint,
> for example lane-to-lane skew of the transmitter, or a PHY setting that

I didn't know an issue like this. But yes, there is an option to disable
the automatic deskew adjusting algorithm by:
phy_wr_cfg(rk_phy, 0x6, BIT(1)); // dis auto deskew
phy_wr_cfg(rk_phy, 0x4, deskew trim value); // deskew value, 0x0 <-> 0xf
phy_wr_cfg(rk_phy, 0xb, deskew magnitude vale); //Default 00 is 2x, 01
is 1x, 11 is 3x and 10 turns it off


> affects it? And is there a bit in DEBUG_OUT_0/1 that tells which side
> directs the Recovery?
> 

These debug section lies on  Appendix section of PCIe chanpter, RK3399
TRM. You could try to find some clue by dumping DEBUG_DATA_OUT info.
Most kinds of these problems should be obvious to the PCIe analyzer
but might not be easy to check from the register IMO.

> Both boards ran the same build: v7.3.1 with the Armbian patches and the
> tracing. The Helios64 DT has no ep-gpios there, the ROCK Pi 4A DT has.
> 
> Thanks,
> Igor
> 

