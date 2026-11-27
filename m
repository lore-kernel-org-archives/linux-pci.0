Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.52.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791689;
	b=Y+V6ZW1ZUxAmfjAbR/eQXnquJbWYBOYtdapBLBmAGb72KwurdQKA0pIpbffD22Vnjo0L
	 JGaVZQmDygnhyBHRPNH+5hLoViHjOlVuytr2AGXOJhREy+Bjo4pp4c/wfE8zyAY4I/BRD
	 +sX9UlIDiKOeZUUj4JQIFAMRbGm9ubc/yX2k4Ltn2veVLsIRWzv88OwClfgbsN+rBF5+o
	 7cU292iTBZYrF/R5yPJn9XrhHIbR1H8N+WHC+kkom5e6n4Zpgdf9PhlfNa76moIzkZLN0
	 f7uOUM3k+CpySf2x/Q3cIJTmO/GIQ4CuXKRhqGlXpiQYPJbcEjBM/c+Pa/WIZrAiffw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791689;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=/OoYrZ4FJbi075w0E59L/pYYGI5hPdvmfjG2P0b4xgQ=;
	b=YJ3Yzq2HmUFBukdkjhFN9+DQtnuUA7jodg0z0HF9ItK8DxbU389nSP7G+M3MVw+XyM15
	 IbwP4iLO2zYFavP0zDsN4cVVWD+M8pEArPkpMANdghhtQSVUHw16N3EXeUbpJMqx1T8b/
	 a/uwAyVWc3B4ZiokrC7lncYproMtNDhFDIJd0qlbKL+joP3vPRXd3lXtHPqKQ+uw83QBf
	 zORFySLxUyzf+L6gpU+GUhZG4Bckp7QM/aEhwL+PJT4b152e/az278G2I4eMNebgaYMp2
	 Tgym3x1VmELH2c5MKwlhNKK5AhAUIIOVmk+T5W2NZIDTpvM0FYn09fGbFvVichxMtAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VbtT0NHo;
	arc=none smtp.remote-ip=160.236.52.251
Received: from mail-m16023652251.xmail.ntesmail.com (mail-m16023652251.xmail.ntesmail.com [160.236.52.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3A606A31F;
	Fri, 27 Nov 2026 15:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA3A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VbtT0NHo
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56467589f;
	Fri, 27 Nov 2026 23:01:14 +0800 (GMT+08:00)
Message-ID: <2587e8fc-018d-426a-8459-4e88e733a38c@rock-chips.com>
Date: Fri, 27 Nov 2026 23:01:12 +0800
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
Cc: shawn.lin@rock-chips.com
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
To: Hans Zhang <18255117159@163.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, bhelgaas@google.com, mani@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127074329.747914-1-18255117159@163.com>
 <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa21d865d4303a4kunm4c178f97c2215a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGh8fVkseQkwZHhhNH0hMT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VbtT0NHoBTpqQXDqZn0sr1Eqe3/+6nff1jUY3Q4CDkOOeQ1CeUIv89A9NMx+5893Gm+KkRt7h4C6mi05NqNJ1838fZQd8I9Qgl8lSggHEDfZs1DfnCBdt+N3qrAKbatRzg2E8T9OlObpTpRaXU3CQGtmrRjHHUK2Pe53CvhpAXU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/OoYrZ4FJbi075w0E59L/pYYGI5hPdvmfjG2P0b4xgQ=;
	h=date:mime-version:subject:message-id:from;

Hi Hans


在 2026/11/27 星期五 16:02, Hans Zhang 写道:
> Hi all,
> 
> The patching process under discussion：
> 
> https://patchwork.kernel.org/project/netdevbpf/ 
> patch/20261124070753.25972-1-18255117159@163.com/  (include v3 patch)
> https://patchwork.kernel.org/project/netdevbpf/ 
> patch/20261124070753.25972-1-18255117159@163.com/
> 

This had been discussed for several times and the lastest one I
remembered  is from here:

https://lists.infradead.org/pipermail/linux-rockchip/2026-March/068879.html

> 
> drivers/pci/controller
> 
> grep -nr .probe_type
> pcie-mediatek-gen3.c:1447:              .probe_type = 
> PROBE_PREFER_ASYNCHRONOUS,
> pcie-rzg3s-host.c:2185:         .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> pci-hyperv.c:4196:              .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> pcie-aspeed.c:1107:             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> cadence/pci-sky1.c:238:         .probe_type = PROBE_FORCE_SYNCHRONOUS,
> dwc/pcie-stm32.c:360:           .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> dwc/pcie-qcom.c:2642:           .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> dwc/pcie-spacemit-k1.c:352:             .probe_type             = 
> PROBE_PREFER_ASYNCHRONOUS,
> dwc/pcie-rcar-gen4.c:1161:              .probe_type = 
> PROBE_PREFER_ASYNCHRONOUS,
> dwc/pcie-andes-qilai.c:189:             .probe_type = 
> PROBE_PREFER_ASYNCHRONOUS,
> dwc/pci-layerscape.c:422:               .probe_type = 
> PROBE_PREFER_ASYNCHRONOUS,
> dwc/pci-imx6.c:2287:            .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> dwc/pcie-nxp-s32g.c:396:                .probe_type = 
> PROBE_PREFER_ASYNCHRONOUS,
> 
> 
> 
> Andrew suggested：
> 
> drivers/pci/controller/cadence/pci-sky1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/ 
> controller/cadence/pci-sky1.c
> index 82f4ae5c04a8..4448ee3d5e73 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -235,7 +235,7 @@ static struct platform_driver sky1_pcie_driver = {
>       .driver = {
>           .name = "sky1-pcie",
>           .of_match_table = of_sky1_pcie_match,
> -        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +        .probe_type = PROBE_FORCE_SYNCHRONOUS,
>       },
>   };
>   module_platform_driver(sky1_pcie_driver);
> 
> 
> 
> Best regards,
> Hans
> 
> 
> On 11/27/26 15:43, Hans Zhang wrote:
>> Hi Andrew, Bjorn, Mani,
>>
>> I'd like to raise a cross-subsystem issue before sending a one-line fix.
>>
>> Several PCIe host controller drivers set PROBE_PREFER_ASYNCHRONOUS so
>> their root complexes are enumerated in parallel. On the CIX Sky1 SoC the
>> driver probes up to five root complexes. When it enumerates an RTL8126A
>> NIC, the NIC's mdiobus_register() runs in an async worker, and
>> phy_device_create() then calls request_module() synchronously. That hits:
>>
>>    WARN_ON_ONCE(wait && current_is_async());
>>
>> and can deadlock, because module init may call async_synchronize_full().
>>
>> This is not specific to Sky1. The same pattern exists in many PCIe host
>> drivers, for example:
>>
>>    pcie-mediatek-gen3.c, pcie-rzg3s-host.c, pcie-aspeed.c,
>>    pcie-stm32.c, pcie-qcom.c, pcie-spacemit-k1.c, pcie-rcar-gen4.c,
>>    pcie-andes-qilai.c, pci-layerscape.c, pci-imx6.c, pcie-nxp-s32g.c
>>
>> So any of them could hit the same problem when a downstream device probes
>> an MDIO bus.
>>
>> I see two possible fixes:
>>
>> 1. PCI side: force synchronous probing on the affected host controller
>>     driver (PROBE_FORCE_SYNCHRONOUS). This is self-contained and low- 
>> risk,
>>     but serializes the root complex enumeration. On sky1-xcp (three root
>>     complexes) the measured boot time is close to the async baseline, but
>>     that measurement does not include PCIe PHY enumeration or link- 
>> training
>>     timeouts. Serializing the root complexes would sum those 
>> latencies, so
>>     the real cost grows with the number of root complexes and PHYs.
>>
>> 2. net/phy side: return -EPROBE_DEFER from __mdiobus_register() when
>>     current_is_async() is true. This keeps async probing and fixes all 
>> MAC
>>     drivers, but I audited the in-tree mdiobus_register() callers and 
>> found
>>     some (lantiq_etop, smsc911x, smsc9420) that convert any error to
>>     -ENXIO and would not defer correctly.
>>
>> Could you advise which layer should carry the fix? If the preference is
>> the general net/phy approach, I can follow up with a more detailed audit
>> of the callers.
>>
>> Test data on sky1-xcp:
>> - unpatched async kernel: the kmod WARN is present;
>> - PROBE_FORCE_SYNCHRONOUS: WARN is gone, both RTL8126A NICs still probe
>>    and bind their PHY driver, NVMe/root and the serial console are 
>> normal.
>>    Init starts at ~2.63s versus ~2.79s for the async baseline in this
>>    three-root-complex configuration. This measurement has no PCIe PHY or
>>    link-training timeout in the path, so it is a lower bound.
>>
>> Best regards,
>> Hans
>>
>>
>>  From mboxrd@z Thu Jan  1 00:00:00 1970
>> Authentication-Results: smtp.subspace.kernel.org; arc=none 
>> smtp.remote-ip=220.197.31.4
>> ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; 
>> cv=none;
>>     t=1795765658;
>>     b=RjoyypZgbZDwyd3QkV/ 
>> OiZgDapLyNcxzJz6NKIsLEmSYH4sJpIC63er0ybcJN1Lj3V8I
>>      41xKXM0pKHvgRKEYboloC02uUTTjSquCG/ 
>> sXbDg4j0Mmr9XhxmdoLkfSvirMa/0YbHzqE
>>      0WIhxbAEgkwaXtDrNoWtrr3DO1cKiQmITsc5z4TXfQI0dbSYrWUqgiQhWVWNrSK/ 
>> N2GIe
>>      5u0s/t7nPwy1KKPEyZycZBzcal2guSmOUsGmVvzh+Oi/ 
>> X6FCzeElMS3fYeXn+FvJp4wZP
>>      
>> zLFSHcg1QuTESediE2SSqnmSNB9IIacY74P7lBN9KT+9maBjFl9pPtafck17nVKNrqg==
>> ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
>>     a=rsa-sha256; c=relaxed/relaxed; t=1795765658;
>>     h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
>>      Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
>>      X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
>>     bh=FPV4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=;
>>     b=f7V9AxZegDZlT2urAaY66WTPD8oVyDkNf5Byw6Jy2MaV3z0CDfrpQlgw7wj7sEXKsGlC
>>      O9dHxH2OIuwr+GJZLELrUw0PlOxWvpQ95FtF/ReGvSPfrxwhlh7/lUKeDpMQG/ 
>> TIram9h
>>      Aq9k5/HUSWTu1SEjtabOO7IsbV/ 
>> fM4GlKP9DE7IPTUEV+kQ14xTFXgi6PDwfLj6hxAzey
>>      vokiqZKIvFfZa/1bgzv/ 
>> wjHjp7yubJkURFUTotMzspejMzUFuV+16BRg7emFMw1nyWPpA
>>      Cy5B/ 
>> RlCvcrL52DNqKz+12o4HvkFxtis25pij0+FgfMU6laoeD7h/4VAvCwJYsR9CjA==
>> ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
>>     dmarc=pass header.from=163.com;
>>     spf=pass smtp.mailfrom=163.com;
>>     dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 
>> header.s=s110527 header.b=AbVrbcqV;
>>     arc=none smtp.remote-ip=220.197.31.4
>> Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
>>     (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
>>      key-exchange X25519 server-signature ECDSA (prime256v1) server- 
>> digest SHA256)
>>     (No client certificate requested)
>>     by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704F606A31C;
>>     Fri, 27 Nov 2026 07:47:34 +0000 (UTC)
>> DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 
>> 4704F606A31C
>> Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none 
>> dis=none) header.from=163.com
>> Authentication-Results: smtp.subspace.kernel.org; spf=pass 
>> smtp.mailfrom=163.com
>> Authentication-Results: smtp.subspace.kernel.org;
>>     dkim=pass (1024-bit key) header.d=163.com header.i=@163.com 
>> header.a=rsa-sha256 header.s=s110527 header.b=AbVrbcqV
>> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
>>     s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FP
>>     V4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=; b=AbVrbcqV/0M88jZSTk
>>     SiKRtOelmVWH4Q/Xjy1DmQSjPJCbOl5PNQPy1D4yQoNwSbTSLYnibm9PhTqAmfnl
>>     zG/ime7KojEsB0MXiicY2pRjiBpcSAwtxw0Neyv7RN3Ni2WXuZ+7CYqDdgmnHKxT
>>     zNzLE1W55GiA3gixCsx/oEixY=
>> Received: from Precision-7960.. (unknown [])
>>     by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id 
>> _____wD338tdNQlr9DA1LQ--.31255S2;
>>     Fri, 27 Nov 2026 15:46:38 +0800 (CST)
>> From: Hans Zhang <18255117159@163.com>
>> To: andrew@lunn.ch,
>>     hkallweit1@gmail.com,
>>     davem@davemloft.net,
>>     edumazet@kernel.org,
>>     kuba@kernel.org,
>>     pabeni@redhat.com,
>>     bhelgaas@google.com,
>>     mani@kernel.org
>> Cc: linux@armlinux.org.uk,
>>     netdev@vger.kernel.org,
>>     linux-pci@vger.kernel.org,
>>     linux-kernel@vger.kernel.org
>> Subject: [RFC] PCIe host controller async probe vs PHY request_module 
>> deadlock
>> Date: Fri, 27 Nov 2026 15:46:37 +0800
>> Message-ID: <20261127074637.748411-1-18255117159@163.com>
>> X-Mailer: git-send-email 2.43.0
>> X-Mailing-List: netdev@vger.kernel.org
>> List-Id: <netdev.vger.kernel.org>
>> List-Post: <mailto:netdev@vger.kernel.org>
>> List-Help: <mailto:netdev+help@vger.kernel.org>
>> List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
>> List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
>> List-Owner: <mailto:netdev+owner@vger.kernel.org>
>> Precedence: list
>> MIME-Version: 1.0
>> Content-Transfer-Encoding: 8bit
>> X-CM-TRANSID:_____wD338tdNQlr9DA1LQ--.31255S2
>> X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Ar15ur4xuF1rAr43Wrg_yoW5Jr4rpF
>>     WrWa9Iyr4qqrZ2vr4kAr4DZFySg3yxCay7tFn5J3y5A3Z0y34q9FWjk3y3ZF4DGrZ2k3W2
>>     qF4j9rW5u34DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
>>     9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_fUUUUU=
>> X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B6BJWsJNV71yAAA3i
>>
>> Hi Andrew, Bjorn, Mani,
>>
>> I'd like to raise a cross-subsystem issue before sending a one-line fix.
>>
>> Several PCIe host controller drivers set PROBE_PREFER_ASYNCHRONOUS so
>> their root complexes are enumerated in parallel. On the CIX Sky1 SoC the
>> driver probes up to five root complexes. When it enumerates an RTL8126A
>> NIC, the NIC's mdiobus_register() runs in an async worker, and
>> phy_device_create() then calls request_module() synchronously. That hits:
>>
>>    WARN_ON_ONCE(wait && current_is_async());
>>
>> and can deadlock, because module init may call async_synchronize_full().
>>
>> This is not specific to Sky1. The same pattern exists in many PCIe host
>> drivers, for example:
>>
>>    pcie-mediatek-gen3.c, pcie-rzg3s-host.c, pcie-aspeed.c,
>>    pcie-stm32.c, pcie-qcom.c, pcie-spacemit-k1.c, pcie-rcar-gen4.c,
>>    pcie-andes-qilai.c, pci-layerscape.c, pci-imx6.c, pcie-nxp-s32g.c
>>
>> So any of them could hit the same problem when a downstream device probes
>> an MDIO bus.
>>
>> I see two possible fixes:
>>
>> 1. PCI side: force synchronous probing on the affected host controller
>>     driver (PROBE_FORCE_SYNCHRONOUS). This is self-contained and low- 
>> risk,
>>     but serializes the root complex enumeration. On sky1-xcp (three root
>>     complexes) the measured boot time is close to the async baseline, but
>>     that measurement does not include PCIe PHY enumeration or link- 
>> training
>>     timeouts. Serializing the root complexes would sum those 
>> latencies, so
>>     the real cost grows with the number of root complexes and PHYs.
>>
>> 2. net/phy side: return -EPROBE_DEFER from __mdiobus_register() when
>>     current_is_async() is true. This keeps async probing and fixes all 
>> MAC
>>     drivers, but I audited the in-tree mdiobus_register() callers and 
>> found
>>     some (lantiq_etop, smsc911x, smsc9420) that convert any error to
>>     -ENXIO and would not defer correctly.
>>
>> Could you advise which layer should carry the fix? If the preference is
>> the general net/phy approach, I can follow up with a more detailed audit
>> of the callers.
>>
>> Test data on sky1-xcp:
>> - unpatched async kernel: the kmod WARN is present;
>> - PROBE_FORCE_SYNCHRONOUS: WARN is gone, both RTL8126A NICs still probe
>>    and bind their PHY driver, NVMe/root and the serial console are 
>> normal.
>>    Init starts at ~2.63s versus ~2.79s for the async baseline in this
>>    three-root-complex configuration. This measurement has no PCIe PHY or
>>    link-training timeout in the path, so it is a lower bound.
>>
>> Best regards,
>> Hans
> 
> 
> 

