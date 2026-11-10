Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334374;
	b=U82uBPrcBlPIbXfk7AtrS02SfmheQk/YB+ZEAqGIsnpZEV9fzucp9OYdHr9svA/MbBaL
	 tWtS1orqS52vH5z4mI6DS06wjjZVXOp6Jkt1kpzA34e7kUgxUUcVlMpw8JVwvMagIA95V
	 4IcrFlN1rGtOmvj1S4rMMFAS97jRvuqFqg3rUyJnmNpR+gdJExQ+ee5FHjUicGvUqancq
	 NJ4esDSkjXYoqfc+oXGnGd2EuQUtnX0xiXZGnqnpY/GuquBzfNg0zoIbTaNgCxAVro8wT
	 pTB3fKBgfy/nS+WGvFzrQebd4VKykTD1bIll15GXoUXGYWxYmAFYFVNBUWCmPCx2QXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
	b=QGz6993oFd8PBl6sftFIQtF3Ye+lFEkMc5ds/FW+4bq+epjaf1Zp8gYDXFHxjHQ2ywxa
	 NVPtbj6D+Js2lELXYrX3ai2Q4j5kOjaNRuVSuLNIeFkME3yn4HS85bsIWp12q8pvjDIK8
	 IA+A8QjqojQijKUnl0lWfhT6OWdbfnY98qYM1jK1zvnnWVKQ+3CfaoYg7l377qJtjcQB4
	 bos5nEp3ItVT7AoY5o74HVcWvb2/7UzOMuSwai3xJiKgHA9v9ZaOQd2zwhPXYnv/WpafL
	 2apC7Qbf/LVmshA5SYTbGNPocYA4r2lPVTuzGPzDRW13WFbS4Zktj0/EUJZFNxMakWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F9606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 18:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tS5pn8Yi
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91eb5559b34so17728076d6.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334373; x=1794939173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=tS5pn8YiT64Zd9lexBBZTQYgUn0ddUenE2ATM8vMaZ1MPspNzyROAIXQHAXOUwIrac
         5FpzRX+iTDtkR0zhccjnG59AFXZKzj5UpgnP1iJEC7nuuC0xu4MQ+0Bd9LfClbfc7uzf
         IMovpPts3lyTygm2Ue1nDT7LhW2xyvsJBoT9t1XlD7OD9gf8XGs245NMk6TLlfaA5Cmu
         xwKxenpVK3Xr4KOyt6vXpwBuiKn6psxaZ0Y+AZf8RVc611D6x4COmbVGw6l62uSOxQp/
         i9Vg/iUhtOmE+rJlBiF/9c4q7ZO9RzeqsPBF0emRYoDIN83Wcx0wOJAbsg56/bI0AvQ0
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334373; x=1794939173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=68pKDA1p2LdEONMliWN80HdZe29k8kOJYDnRCJeXxak=;
        b=AxBsJWRucFObblwqGQbAXmIPxSUAbiUMGlFvYbN9AFIhUcKAwE/bM/fqRtmhFAaQ9B
         jpqKbLVgUl54zzUpfTTMjyGfoW0EVe5Ik/KPxWcLVA+OgmrVctXtyhz3bq+kyWBmH+8p
         xQebfZrvm76TxTFuiwp2U7AxfteIwLzbp1SOp9+KCfNB1Ctz7AFUl9b7pw9xPCw8kVlE
         iBDspCWm30z/U4Rr5d31VJOHwaig9bUOmWziA5XKmcgOUpURGdZhC1dvQ6gOjcR3FjF7
         Qresjjx1APPPblzxpSRkUr1HLSBbWemfBxfsAWtHLrehsaGuohZFJI5FAsPKS3/zSk0c
         D66Q==
X-Forwarded-Encrypted: i=1; AL+hErGcrUV65cld/W8SU/DdqwC9k4FXHejA4bzsCq8eWTyqFFl/dzBKJC6n6thRbe3+DMXaLHlAHUcLYKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R5jj+WacCus/8S/a+1uYX1L/6C13p+fFIXJbeXnmyorrndwNx
	s0h/RferzM3lEPfzqO99AMRKiuOEGQNs9qNafdmDu5ffOmBOU2a2XsSN
X-Gm-Gg: AYBFou3en/4AEOFx3QPB1anr4NLANPSSc14M1HhrJWfg75GHAgdW4SDHXeSbaBJn6ux
	cJcQxokrxzruWI6gcXDeNtLdjXv6KUgP2/wuZyu/aBBuCwB9EiEOzPmvZ8iZSnrrN9SDM4CmTC2
	Af4f2G7rYiP+gM54dJbz2CFtYN9SHKArna4rmw3Wb69ugnKD+X2dhmg5KoLwDKHuU2eJa5KGn9A
	mtVsmp3Y4121s8eSNsEgZRDLMSzWXwLuqc1vbVpiq91IYYkCirFfp3Hrt3EzobBeh4mtrgFt0Ht
	e1Yh42JiatMysc6CkWf6ye2aNNQ/YJyFGS3iHfuNP23zTJ5IsYjbD8c9dArvC+8Ff5iTR37zAQU
	2WbWU1TzfFmkj15vuwsdoZgN9ZpDejaUe6gTEgmIJBhE0eVkRyAUeeo7OO/B3VgWlwIeL1T5Qtg
	E/xTZ8ERZiitFgdApYAfkUTFT0hTkGvNQ19iJpaYSzY6LxzK4oEF2kyx2f+a2SQtvZIq0+yhBQ0
	QSjnHIaZVwGn2/fQvsLSnFjVUdznKRKmqCovdBNqsHtShKTkM1BRiV6KO2jN5qGwwBIqMqJR5NP
	AZDm1xj4T2JaFKlFmMEUCdRXl7F5lltP1pmanWlWFPrTVa6a7BLwZYiGuCZ5FYkfs28csTYUYjm
	B2FvdzcJOWF3emVubHFBeLtrW2zbvZS0vph8RB+vbBTrafDNZvTMZmqSjmrU84HTPtRYPco1rad
	Gy1sOtPeJ5RXyNeq62Z8L1SZARzBi/SJsek+UHyflqxNWx9OlPLk8ZQNSNbxzc8A4IH3srh5IPh
	zTT+Ve9BH+G7Rzfq7xgepXp3sZzW1hOy8QHUJIwOHsfDg==
X-Received: by 2002:a05:6214:238e:b0:91e:9db6:c324 with SMTP id 6a1803df08f44-91f041351bfmr1113006d6.40.1794334372476;
        Tue, 10 Nov 2026 10:12:52 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5024:4b00:940a:c6ea:f292:3644])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f017737a3sm4800156d6.8.2026.11.10.10.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:12:51 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com,
	quic_anubhavg@quicinc.com,
	Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
	Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
Date: Tue, 10 Nov 2026 13:12:50 -0500
Message-ID: <20261110181250.47751-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
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

Tested patches 1-3 on an ASUS Zenbook A16 (UX3607OA, X2 Elite), 7.4-rc1
based. The controller (product 0x20, ROM 0x0101, board ID 0x17) now
loads ornbtfw11.tlv, ornnv11.bin and ornbcscal11.bin instead of falling
back to ROM firmware, and a phone pairs and plays A2DP audio.

With the mainline A16 DT (M.2 E connector, no Bluetooth node), patch 3
creates the BT node, but the card only powers on with Manivannan's
"Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq" [1]
applied too. Without it, hci_qca asks for a "bluetooth" pwrseq target
the connector doesn't provide, W_DISABLE2# stays asserted and reading
the version times out (-110).

One of five boots failed: the rampatch download timed out
("command 0xfc00 tx timeout", "Failed to send TLV segment (-110)") and
the "Retry BT power ON" never completed, leaving BT down until
userspace powered it on. ath12k was bringing up WLAN on the same chip
during the download in every boot, so I suspect contention there.

[1] https://lore.kernel.org/r/20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com

Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
