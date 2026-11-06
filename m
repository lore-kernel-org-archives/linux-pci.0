Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941806;
	b=xTSCVVQa9fgoxnbKjhsIhEs7C8rg4c8W1q7eLfLzbm71p02DdRqcRqT+V1zL3mrpaXDk
	 SHrQpR9PnWoY1Wt74VmzkZus/TaE4u8MMEnzOOxz62KZG4NhKR4CZrdcdluSupeqLAAzr
	 8pwrFgOK/HvLm+u4M2bIlZ5JHOObT+W+EiReh2Gxby9levZT2IYfOGfBGSMzwft+yPRze
	 souuERvNJCYIpMSUOvcousZc9+05I+VmGbfmnnSeK3lKp0exIQnoC4HO17Iao0hYv8RuZ
	 NjIdT9QD8g60K9x8UDPKXLKg/FqZJhgnRVY8Nz/JrxBETPJCsV6WEs3j4a0tdy5xtEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941806;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1FeTAy8PU/bkXQJ7iOcuHiJJNpC3DzGGJuS8JfarDhQ=;
	b=1H6lLMMbnmwflJRXAP8CR8Tp05jS6PIMzQiuTk9MFH+CH+QlVPzJJC/eqKmT+iyKghF4
	 YFK6Qb1UxuBrMzECnFErlv2r7InSzguM7/5wWzL4ZYnsZ5UVbiA9ChI4z+ol/jrIijFDy
	 /sr+qHfY6+oZeMosfwur4fwyI8aWzPO6Wv7i/ovxxXPJellIPmU+g0isVZheJAvzIKpta
	 rqJQD6NVUILc6ApgGE4oi7OZvXW2BjCdvVwlDAUNoSrFZPgfJAySi1XQIoUh4ipjCN9RX
	 nybzvAXCaqCcbM+E3jTmAowI39gjCbpl7KZ99ZOEmY3qh3ixO1UXKaJETpnVSro4VQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XJ9Kfb4b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C14606A31B;
	Fri,  6 Nov 2026 05:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C14606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XJ9Kfb4b
ARC-Seal: i=1; a=rsa-sha256; t=1793941769; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QbwwwzTCVpZm7LIoeNv2CClIH5gvoxd/z7CcnHQAzCY+NU0CXv+pAsHyoEFZy7fAYKt/W/FRHNfWB86wT3J8+XNqKSJ3hZEi4JOs8qokMxbQnjte9pu7dkQBbjZYCIIA1jnEI/BCVbsaK/K/6cn45m7YKN7JkmMFHkVrJIWMglg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793941769; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1FeTAy8PU/bkXQJ7iOcuHiJJNpC3DzGGJuS8JfarDhQ=; 
	b=Rg0/zj4mvRkIG+HSnmn55ERM2kmnHXsNiKytI1AJV2JnIxWuOWW0PeTk0DqSBkcT2S1idKD2CnGUffjMQw0ymQ4e73FF5GojBX5pvPTSoqZg0M7Lbs4jNTSOquJ1FPO6ZqbXPMxkcHGNoCcwsGx2aZ0URrmidPfT6qrK2AefLWQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=XJ9Kfb4bhmA225wM0a2j2oPVIYoacNOLMxmqz4GyXlzqwW4IZJZm2v1PmC0DjDfvxwM524kM5PV5rY/LojSNcO4w+jrumX8rlENPS12zxCVsRAg1+omV3A5UrP33Z6ANtYIhBVYNT8RxkNFg/Z16ZlaP06Q4C7T96geRQJuMMIY=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=1FeTAy8PU/bkXQJ7iOcuHiJJNpC3DzGGJuS8JfarDhQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793941767276243.02218760701385;
	Fri, 6 Nov 2026 06:09:27 +0100 (CET)
Date: Fri, 06 Nov 2026 07:09:25 +0200
From: Igor Velkov <iav@iav.lv>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Enrique Hernández Bello <ehbello@gmail.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Message-ID: <20261106-rockchip-pcie-ltssm-trace-1@iav.lv>
In-Reply-To: <20261030-rockchip-pcie-s2idle-a53-1@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com> <20261026-rockchip-pcie-shawn-reply-1@iav.lv> <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com> <20261028173117.3457220-1-ehbello@gmail.com> <20261030-rockchip-pcie-s2idle-a53-1@iav.lv>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Shawn,

I traced the LTSSM on the Helios64 (RK3399 + JMB585, x2, 2.5 GT/s) by
polling PCIE_CLIENT_DEBUG_OUT_0 about every 2 us during link training
and the waits after it. This changes what the RFC said, so here are the
data and a question.

A failing link bring-up looks like this:

- the LTSSM reaches L0 as fast as in a good one;
- then it leaves L0 for Recovery (RcvrLock/RcvrCfg/Idle, about 5 us)
  every 199..204 us, for as long as I watch: 488 times per 100 ms;
- link_st in BASIC_STATUS1 becomes 3 only 15..47 ms after training
  starts, or not within 700 ms; the latter is the "link training gen1
  timeout" with LTSSM 0x10;
- the RC shows nothing: AER and the device status are clear, and a dump
  of the client, core management and root port config registers is
  identical to a good bring-up.

A good bring-up has no Recovery entry after L0. A config read on a bad
link gets no completion; that is the abort I reported. 200 us is the
optional Flow Control Update timeout, so I suspect that one side does
not see the DLLPs of the other.

The state survives Recovery but not Detect: a port re-init or a hot
reset is just one more bring-up, with the same odds. So the hot reset
of patch 2/2 does not cure anything, and the time the link takes to
return is not a reliable sign either.

Unbind/bind cycles with a bad bring-up (a cycle is one training plus
one hot reset):

  Helios64, JMB585, x2                     6 of 104
  same, PHY refclk 100 MHz from NPLL       4 of 33
  same, num-lanes = <1>                    0 of 104
  ROCK Pi 4A, WD SN770 NVMe, x4            0 of 100
  same, num-lanes = <2>                    0 of 100

So it takes both lanes and the JMB585.

Is anything like this known for the RK3399 with a two-lane endpoint,
for example lane-to-lane skew of the transmitter, or a PHY setting that
affects it? And is there a bit in DEBUG_OUT_0/1 that tells which side
directs the Recovery?

Both boards ran the same build: v7.3.1 with the Armbian patches and the
tracing. The Helios64 DT has no ep-gpios there, the ROCK Pi 4A DT has.

Thanks,
Igor
