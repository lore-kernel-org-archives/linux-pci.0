Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766631;
	b=PhYdOvdNfgtd6k2P6t4C2GdNCC3qxrPFogqP+Zjmb2PgNHV5DdPvvo1lIdtZ8Xggefju
	 yQsUd3vFcQFKh6vRuluWVlJag1kl7mK/mpXi+k5THoN5I57VHpJr9nTbUdd7BY6IZd5Wl
	 rR1t7rI1QwF26zr7210MJxTtwCH04kJco8Wi4GVFRMGUb/KxS+CTLlJzkFNeThTEEX4O5
	 Wk0A6oILrgJcgOrOqk0+hRJDHhp8fltOF4NyWSWKR3KcBo/Do3c+OB0B4oyDCVMJaVpIp
	 q/K2s3Fd1Q8boBr6jvTQ4KtkVTTsmL23tjpYzEWwlcPfO6zH5Fwb+t7Ra5Q1pqu8tcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766631;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LTSh/MFI8illsCpj54vK+53vKyg+GZ4rpZBFXfgS1F8=;
	b=giMxLKlF1ECX+wLNlIuLFfBsVmgt7bLctzs94KCiGayHiKJF1/cMMDP9GVPmuq3cqHtI
	 YUnLxKTGMqoumueT9jtzbLtkmL/hUwqqhisGRIn9m+hdzDb+Zu4VhRd0IcwuxYXjM8kv9
	 0tcoeYXc7egev79ed9p0oVWNcQ+beGVKfSlUUEaR5j+bzQxHv5EXzQEFwc1MkC4dhoWCg
	 yzqQTZT5sCRo1Tl9Jm/IlvFGBPRodsYAWC2JzRInN0DNIyLeK0qpHPPLsl4smeUffPMJw
	 3CunxR6QRc2k+ZQ3GWlNQNo1GekdH0GJQm8Ytl0gzCCN3EXNidYHkTPMtztuHA2wR1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W3cX7i3r;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841E606A31E;
	Fri, 27 Nov 2026 08:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6841E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W3cX7i3r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=LTSh/MFI8illsCpj54vK+53vKyg+GZ4rpZBFXfgS1F8=;
	b=W3cX7i3rYhcBmYBrJM4zqFyfvBYG2ZVBulzwm2XfbLyzpw7YQy1Zd20pJHq5Eq
	jvcA5dn1a9AoeryYf0UxYQjtAgZzTfUZZ+9YMju2nxFc4osK41REtcJLFso1cHPw
	jpM5yOC6voqQjHc5wpLOcw8+Hyap2oMOFRd11hKwQje0Q=
Message-ID: <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
Date: Fri, 27 Nov 2026 16:02:08 +0800
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
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
From: Hans Zhang <18255117159@163.com>
To: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 bhelgaas@google.com, mani@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127074329.747914-1-18255117159@163.com>
Content-Language: en-US
In-Reply-To: <20261127074329.747914-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3xy4KOQlr1iqXKg--.3525S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3uryxtFWfurWrtFW8Xry7Wrg_yoWkuFW3pF
	Z8CrZIgr4qqrZ7Xw4kKa1UCFySg34kCayDWws8G34ayFyjvr17Wr1jgrW5Wrn8GrZFk3Wa
	yr47X3s0ka4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w1uEmsJOQ0JAwAA3G

Hi all,

The patching process under discussion：

https://patchwork.kernel.org/project/netdevbpf/patch/20261124070753.25972-1-18255117159@163.com/ 
  (include v3 patch)
https://patchwork.kernel.org/project/netdevbpf/patch/20261124070753.25972-1-18255117159@163.com/


drivers/pci/controller

grep -nr .probe_type
pcie-mediatek-gen3.c:1447:              .probe_type = 
PROBE_PREFER_ASYNCHRONOUS,
pcie-rzg3s-host.c:2185:         .probe_type = PROBE_PREFER_ASYNCHRONOUS,
pci-hyperv.c:4196:              .probe_type = PROBE_PREFER_ASYNCHRONOUS,
pcie-aspeed.c:1107:             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
cadence/pci-sky1.c:238:         .probe_type = PROBE_FORCE_SYNCHRONOUS,
dwc/pcie-stm32.c:360:           .probe_type = PROBE_PREFER_ASYNCHRONOUS,
dwc/pcie-qcom.c:2642:           .probe_type = PROBE_PREFER_ASYNCHRONOUS,
dwc/pcie-spacemit-k1.c:352:             .probe_type             = 
PROBE_PREFER_ASYNCHRONOUS,
dwc/pcie-rcar-gen4.c:1161:              .probe_type = 
PROBE_PREFER_ASYNCHRONOUS,
dwc/pcie-andes-qilai.c:189:             .probe_type = 
PROBE_PREFER_ASYNCHRONOUS,
dwc/pci-layerscape.c:422:               .probe_type = 
PROBE_PREFER_ASYNCHRONOUS,
dwc/pci-imx6.c:2287:            .probe_type = PROBE_PREFER_ASYNCHRONOUS,
dwc/pcie-nxp-s32g.c:396:                .probe_type = 
PROBE_PREFER_ASYNCHRONOUS,



Andrew suggested：

drivers/pci/controller/cadence/pci-sky1.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-sky1.c 
b/drivers/pci/controller/cadence/pci-sky1.c
index 82f4ae5c04a8..4448ee3d5e73 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -235,7 +235,7 @@ static struct platform_driver sky1_pcie_driver = {
  	.driver = {
  		.name = "sky1-pcie",
  		.of_match_table = of_sky1_pcie_match,
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
  	},
  };
  module_platform_driver(sky1_pcie_driver);



Best regards,
Hans


On 11/27/26 15:43, Hans Zhang wrote:
> Hi Andrew, Bjorn, Mani,
> 
> I'd like to raise a cross-subsystem issue before sending a one-line fix.
> 
> Several PCIe host controller drivers set PROBE_PREFER_ASYNCHRONOUS so
> their root complexes are enumerated in parallel. On the CIX Sky1 SoC the
> driver probes up to five root complexes. When it enumerates an RTL8126A
> NIC, the NIC's mdiobus_register() runs in an async worker, and
> phy_device_create() then calls request_module() synchronously. That hits:
> 
>    WARN_ON_ONCE(wait && current_is_async());
> 
> and can deadlock, because module init may call async_synchronize_full().
> 
> This is not specific to Sky1. The same pattern exists in many PCIe host
> drivers, for example:
> 
>    pcie-mediatek-gen3.c, pcie-rzg3s-host.c, pcie-aspeed.c,
>    pcie-stm32.c, pcie-qcom.c, pcie-spacemit-k1.c, pcie-rcar-gen4.c,
>    pcie-andes-qilai.c, pci-layerscape.c, pci-imx6.c, pcie-nxp-s32g.c
> 
> So any of them could hit the same problem when a downstream device probes
> an MDIO bus.
> 
> I see two possible fixes:
> 
> 1. PCI side: force synchronous probing on the affected host controller
>     driver (PROBE_FORCE_SYNCHRONOUS). This is self-contained and low-risk,
>     but serializes the root complex enumeration. On sky1-xcp (three root
>     complexes) the measured boot time is close to the async baseline, but
>     that measurement does not include PCIe PHY enumeration or link-training
>     timeouts. Serializing the root complexes would sum those latencies, so
>     the real cost grows with the number of root complexes and PHYs.
> 
> 2. net/phy side: return -EPROBE_DEFER from __mdiobus_register() when
>     current_is_async() is true. This keeps async probing and fixes all MAC
>     drivers, but I audited the in-tree mdiobus_register() callers and found
>     some (lantiq_etop, smsc911x, smsc9420) that convert any error to
>     -ENXIO and would not defer correctly.
> 
> Could you advise which layer should carry the fix? If the preference is
> the general net/phy approach, I can follow up with a more detailed audit
> of the callers.
> 
> Test data on sky1-xcp:
> - unpatched async kernel: the kmod WARN is present;
> - PROBE_FORCE_SYNCHRONOUS: WARN is gone, both RTL8126A NICs still probe
>    and bind their PHY driver, NVMe/root and the serial console are normal.
>    Init starts at ~2.63s versus ~2.79s for the async baseline in this
>    three-root-complex configuration. This measurement has no PCIe PHY or
>    link-training timeout in the path, so it is a lower bound.
> 
> Best regards,
> Hans
> 
> 
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
> ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
> 	t=1795765658;
> 	b=RjoyypZgbZDwyd3QkV/OiZgDapLyNcxzJz6NKIsLEmSYH4sJpIC63er0ybcJN1Lj3V8I
> 	 41xKXM0pKHvgRKEYboloC02uUTTjSquCG/sXbDg4j0Mmr9XhxmdoLkfSvirMa/0YbHzqE
> 	 0WIhxbAEgkwaXtDrNoWtrr3DO1cKiQmITsc5z4TXfQI0dbSYrWUqgiQhWVWNrSK/N2GIe
> 	 5u0s/t7nPwy1KKPEyZycZBzcal2guSmOUsGmVvzh+Oi/X6FCzeElMS3fYeXn+FvJp4wZP
> 	 zLFSHcg1QuTESediE2SSqnmSNB9IIacY74P7lBN9KT+9maBjFl9pPtafck17nVKNrqg==
> ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
> 	a=rsa-sha256; c=relaxed/relaxed; t=1795765658;
> 	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
> 	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
> 	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
> 	bh=FPV4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=;
> 	b=f7V9AxZegDZlT2urAaY66WTPD8oVyDkNf5Byw6Jy2MaV3z0CDfrpQlgw7wj7sEXKsGlC
> 	 O9dHxH2OIuwr+GJZLELrUw0PlOxWvpQ95FtF/ReGvSPfrxwhlh7/lUKeDpMQG/TIram9h
> 	 Aq9k5/HUSWTu1SEjtabOO7IsbV/fM4GlKP9DE7IPTUEV+kQ14xTFXgi6PDwfLj6hxAzey
> 	 vokiqZKIvFfZa/1bgzv/wjHjp7yubJkURFUTotMzspejMzUFuV+16BRg7emFMw1nyWPpA
> 	 Cy5B/RlCvcrL52DNqKz+12o4HvkFxtis25pij0+FgfMU6laoeD7h/4VAvCwJYsR9CjA==
> ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
> 	dmarc=pass header.from=163.com;
> 	spf=pass smtp.mailfrom=163.com;
> 	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbVrbcqV;
> 	arc=none smtp.remote-ip=220.197.31.4
> Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
> 	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
> 	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
> 	(No client certificate requested)
> 	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704F606A31C;
> 	Fri, 27 Nov 2026 07:47:34 +0000 (UTC)
> DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4704F606A31C
> Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
> Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
> Authentication-Results: smtp.subspace.kernel.org;
> 	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbVrbcqV
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
> 	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FP
> 	V4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=; b=AbVrbcqV/0M88jZSTk
> 	SiKRtOelmVWH4Q/Xjy1DmQSjPJCbOl5PNQPy1D4yQoNwSbTSLYnibm9PhTqAmfnl
> 	zG/ime7KojEsB0MXiicY2pRjiBpcSAwtxw0Neyv7RN3Ni2WXuZ+7CYqDdgmnHKxT
> 	zNzLE1W55GiA3gixCsx/oEixY=
> Received: from Precision-7960.. (unknown [])
> 	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD338tdNQlr9DA1LQ--.31255S2;
> 	Fri, 27 Nov 2026 15:46:38 +0800 (CST)
> From: Hans Zhang <18255117159@163.com>
> To: andrew@lunn.ch,
> 	hkallweit1@gmail.com,
> 	davem@davemloft.net,
> 	edumazet@kernel.org,
> 	kuba@kernel.org,
> 	pabeni@redhat.com,
> 	bhelgaas@google.com,
> 	mani@kernel.org
> Cc: linux@armlinux.org.uk,
> 	netdev@vger.kernel.org,
> 	linux-pci@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Subject: [RFC] PCIe host controller async probe vs PHY request_module deadlock
> Date: Fri, 27 Nov 2026 15:46:37 +0800
> Message-ID: <20261127074637.748411-1-18255117159@163.com>
> X-Mailer: git-send-email 2.43.0
> X-Mailing-List: netdev@vger.kernel.org
> List-Id: <netdev.vger.kernel.org>
> List-Post: <mailto:netdev@vger.kernel.org>
> List-Help: <mailto:netdev+help@vger.kernel.org>
> List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
> List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
> List-Owner: <mailto:netdev+owner@vger.kernel.org>
> Precedence: list
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> X-CM-TRANSID:_____wD338tdNQlr9DA1LQ--.31255S2
> X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Ar15ur4xuF1rAr43Wrg_yoW5Jr4rpF
> 	WrWa9Iyr4qqrZ2vr4kAr4DZFySg3yxCay7tFn5J3y5A3Z0y34q9FWjk3y3ZF4DGrZ2k3W2
> 	qF4j9rW5u34DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
> 	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_fUUUUU=
> X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B6BJWsJNV71yAAA3i
> 
> Hi Andrew, Bjorn, Mani,
> 
> I'd like to raise a cross-subsystem issue before sending a one-line fix.
> 
> Several PCIe host controller drivers set PROBE_PREFER_ASYNCHRONOUS so
> their root complexes are enumerated in parallel. On the CIX Sky1 SoC the
> driver probes up to five root complexes. When it enumerates an RTL8126A
> NIC, the NIC's mdiobus_register() runs in an async worker, and
> phy_device_create() then calls request_module() synchronously. That hits:
> 
>    WARN_ON_ONCE(wait && current_is_async());
> 
> and can deadlock, because module init may call async_synchronize_full().
> 
> This is not specific to Sky1. The same pattern exists in many PCIe host
> drivers, for example:
> 
>    pcie-mediatek-gen3.c, pcie-rzg3s-host.c, pcie-aspeed.c,
>    pcie-stm32.c, pcie-qcom.c, pcie-spacemit-k1.c, pcie-rcar-gen4.c,
>    pcie-andes-qilai.c, pci-layerscape.c, pci-imx6.c, pcie-nxp-s32g.c
> 
> So any of them could hit the same problem when a downstream device probes
> an MDIO bus.
> 
> I see two possible fixes:
> 
> 1. PCI side: force synchronous probing on the affected host controller
>     driver (PROBE_FORCE_SYNCHRONOUS). This is self-contained and low-risk,
>     but serializes the root complex enumeration. On sky1-xcp (three root
>     complexes) the measured boot time is close to the async baseline, but
>     that measurement does not include PCIe PHY enumeration or link-training
>     timeouts. Serializing the root complexes would sum those latencies, so
>     the real cost grows with the number of root complexes and PHYs.
> 
> 2. net/phy side: return -EPROBE_DEFER from __mdiobus_register() when
>     current_is_async() is true. This keeps async probing and fixes all MAC
>     drivers, but I audited the in-tree mdiobus_register() callers and found
>     some (lantiq_etop, smsc911x, smsc9420) that convert any error to
>     -ENXIO and would not defer correctly.
> 
> Could you advise which layer should carry the fix? If the preference is
> the general net/phy approach, I can follow up with a more detailed audit
> of the callers.
> 
> Test data on sky1-xcp:
> - unpatched async kernel: the kmod WARN is present;
> - PROBE_FORCE_SYNCHRONOUS: WARN is gone, both RTL8126A NICs still probe
>    and bind their PHY driver, NVMe/root and the serial console are normal.
>    Init starts at ~2.63s versus ~2.79s for the async baseline in this
>    three-root-complex configuration. This measurement has no PCIe PHY or
>    link-training timeout in the path, so it is a lower bound.
> 
> Best regards,
> Hans

