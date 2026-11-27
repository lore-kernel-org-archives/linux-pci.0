Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765658;
	b=RjoyypZgbZDwyd3QkV/OiZgDapLyNcxzJz6NKIsLEmSYH4sJpIC63er0ybcJN1Lj3V8I
	 41xKXM0pKHvgRKEYboloC02uUTTjSquCG/sXbDg4j0Mmr9XhxmdoLkfSvirMa/0YbHzqE
	 0WIhxbAEgkwaXtDrNoWtrr3DO1cKiQmITsc5z4TXfQI0dbSYrWUqgiQhWVWNrSK/N2GIe
	 5u0s/t7nPwy1KKPEyZycZBzcal2guSmOUsGmVvzh+Oi/X6FCzeElMS3fYeXn+FvJp4wZP
	 zLFSHcg1QuTESediE2SSqnmSNB9IIacY74P7lBN9KT+9maBjFl9pPtafck17nVKNrqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765658;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=FPV4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=;
	b=f7V9AxZegDZlT2urAaY66WTPD8oVyDkNf5Byw6Jy2MaV3z0CDfrpQlgw7wj7sEXKsGlC
	 O9dHxH2OIuwr+GJZLELrUw0PlOxWvpQ95FtF/ReGvSPfrxwhlh7/lUKeDpMQG/TIram9h
	 Aq9k5/HUSWTu1SEjtabOO7IsbV/fM4GlKP9DE7IPTUEV+kQ14xTFXgi6PDwfLj6hxAzey
	 vokiqZKIvFfZa/1bgzv/wjHjp7yubJkURFUTotMzspejMzUFuV+16BRg7emFMw1nyWPpA
	 Cy5B/RlCvcrL52DNqKz+12o4HvkFxtis25pij0+FgfMU6laoeD7h/4VAvCwJYsR9CjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbVrbcqV;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704F606A31C;
	Fri, 27 Nov 2026 07:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4704F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbVrbcqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FP
	V4ZeWzsKzafgZAHwIqdOFaSmYfPco7h5vg+lLApZ8=; b=AbVrbcqV/0M88jZSTk
	SiKRtOelmVWH4Q/Xjy1DmQSjPJCbOl5PNQPy1D4yQoNwSbTSLYnibm9PhTqAmfnl
	zG/ime7KojEsB0MXiicY2pRjiBpcSAwtxw0Neyv7RN3Ni2WXuZ+7CYqDdgmnHKxT
	zNzLE1W55GiA3gixCsx/oEixY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD338tdNQlr9DA1LQ--.31255S2;
	Fri, 27 Nov 2026 15:46:38 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bhelgaas@google.com,
	mani@kernel.org
Cc: linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] PCIe host controller async probe vs PHY request_module deadlock
Date: Fri, 27 Nov 2026 15:46:37 +0800
Message-ID: <20261127074637.748411-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338tdNQlr9DA1LQ--.31255S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Ar15ur4xuF1rAr43Wrg_yoW5Jr4rpF
	WrWa9Iyr4qqrZ2vr4kAr4DZFySg3yxCay7tFn5J3y5A3Z0y34q9FWjk3y3ZF4DGrZ2k3W2
	qF4j9rW5u34DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_fUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B6BJWsJNV71yAAA3i

Hi Andrew, Bjorn, Mani,

I'd like to raise a cross-subsystem issue before sending a one-line fix.

Several PCIe host controller drivers set PROBE_PREFER_ASYNCHRONOUS so
their root complexes are enumerated in parallel. On the CIX Sky1 SoC the
driver probes up to five root complexes. When it enumerates an RTL8126A
NIC, the NIC's mdiobus_register() runs in an async worker, and
phy_device_create() then calls request_module() synchronously. That hits:

  WARN_ON_ONCE(wait && current_is_async());

and can deadlock, because module init may call async_synchronize_full().

This is not specific to Sky1. The same pattern exists in many PCIe host
drivers, for example:

  pcie-mediatek-gen3.c, pcie-rzg3s-host.c, pcie-aspeed.c,
  pcie-stm32.c, pcie-qcom.c, pcie-spacemit-k1.c, pcie-rcar-gen4.c,
  pcie-andes-qilai.c, pci-layerscape.c, pci-imx6.c, pcie-nxp-s32g.c

So any of them could hit the same problem when a downstream device probes
an MDIO bus.

I see two possible fixes:

1. PCI side: force synchronous probing on the affected host controller
   driver (PROBE_FORCE_SYNCHRONOUS). This is self-contained and low-risk,
   but serializes the root complex enumeration. On sky1-xcp (three root
   complexes) the measured boot time is close to the async baseline, but
   that measurement does not include PCIe PHY enumeration or link-training
   timeouts. Serializing the root complexes would sum those latencies, so
   the real cost grows with the number of root complexes and PHYs.

2. net/phy side: return -EPROBE_DEFER from __mdiobus_register() when
   current_is_async() is true. This keeps async probing and fixes all MAC
   drivers, but I audited the in-tree mdiobus_register() callers and found
   some (lantiq_etop, smsc911x, smsc9420) that convert any error to
   -ENXIO and would not defer correctly.

Could you advise which layer should carry the fix? If the preference is
the general net/phy approach, I can follow up with a more detailed audit
of the callers.

Test data on sky1-xcp:
- unpatched async kernel: the kmod WARN is present;
- PROBE_FORCE_SYNCHRONOUS: WARN is gone, both RTL8126A NICs still probe
  and bind their PHY driver, NVMe/root and the serial console are normal.
  Init starts at ~2.63s versus ~2.79s for the async baseline in this
  three-root-complex configuration. This measurement has no PCIe PHY or
  link-training timeout in the path, so it is a lower bound.

Best regards,
Hans

