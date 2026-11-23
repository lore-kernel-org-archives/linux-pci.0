Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477338;
	b=GL8awv/fE57RgAgk9IIzTCzMeZV9UuPeOglrHaIBYOJR4RhhUkIATSiN3cj9/6ajmVtl
	 ChlFScFFGSn1OqxYFpVm+ol9wZoc78XefZ5nYkHBSV9opJA99gViaPz1jOn8OpIdyPvzP
	 Q81/OektZZPr/yEdl1xbXIBHjOE0mR3FxeoFuMi2RUlcrt9kRb0txHPi5pGYqTW3AXHLX
	 7argehIw2UEKKXENK3CB1tG6HBLMAtflKjXZvDhjtSmkvs5WMJVFYxcAo+EyNUC13A6BF
	 Zz8y4QGian1iD4dd+TBjJjzGHXjmwnbVPlJpQ0fa5ZAMJef8Dzd2bHJfhfBU54sxegQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=fg0tXu1hVUFaqS6DwaYTDlIn6G4vOSL2k3mMwGKArfk=;
	b=vqozruq44nX6cAGAqLQ1p8knwLincyzIUd0l0NyJNVGKViXnVN5x1pEOSphH8gbKW/c4
	 a/daHIs87ObDHElXmRcuB7Tppi87rmxzfbf2h05ATwqjVT5rxSsItEeGn4DON/nwDhPIf
	 vJa4ax2Ht3csQc8bWLhJ3JZZ48TAZ7BU5ddlHpnRJzTvOjnx32QShp9I9E3invK0jP8dt
	 anhJw6NLrgfBkEEaYNhG83AWDht2KVb8lGVQstA59XEo6Js+DAKkIQQcBIhWDPuXt+9Bu
	 glRoBRr4fVTMRARY1hvyPJQCMDyafOTZN4tTLpAqIvw0JkBl2u1h6eIG5O1bOTX4zfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWaTvH2W;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE2606A322
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EE2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWaTvH2W
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49465892f7bso2811103f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795477337; x=1796082137; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fg0tXu1hVUFaqS6DwaYTDlIn6G4vOSL2k3mMwGKArfk=;
        b=hWaTvH2WvQK0Fe/ua18eZbHRadVOMI13PUO18agmTJqMB4Ee7Wry4jK5Bm0cWIHc1+
         oI7RE6JROJdaFFnAersslZHUs/VFmd5LfCLn++EVlhL3IUppbl5KsJcdiQg75nYhIOPY
         yVkcfh1q3meXYK1aNpF34VSxYZg0sIRUuixn1w0IAZdFeXMmJnxKE2B7f4Z1F/lS2kQ4
         csEh3Smr2v0KfcKkT1Rw8azuBMTPsQlVyl4uUyE8UVDk1VdHTHJo4EDKrqGQIn/kaGaO
         /k16dos1+lGtFeW4lKRAGQOvXLya9m50eftp8nWA/G1M+eDknMTwY5mr/v04q+iD0M6s
         RxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477337; x=1796082137;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fg0tXu1hVUFaqS6DwaYTDlIn6G4vOSL2k3mMwGKArfk=;
        b=S+xfCyQx+1s47c3JkupdwYMRBetn1DZc4WEHsKCbqWVyPsdmiR4gwBH8ACyQaijmxD
         UNTmbyTr82uzPBmaVfSXDoUTk+aNwS/eJhDWYkcShMHDtVngs3AcCmDU1ptK9wmTF29T
         9oS9ft27TmomCe7wAkpcF/rVBczXhtO26lUv5ODf0iTIjOcN1CtsZ1TKNYI9RJjcllzI
         xLF1UCQ7+NxBWRlrZlQvXrUm+IhCyz9iU0B6n9CUwH4y8A9qZGgKWVZLJgfGmK8ARNyW
         ezsoKoo7AnBQ5XuP96co7/FNSA2smf2t6hwRVu7rtn1Uk4XCmefZFaKZld8Hvbb8jmFR
         9efw==
X-Forwarded-Encrypted: i=1; AL+hErEBg//Fmb70Hvxl/cMUkkmTa7WTOcEL9BysVqgdH30G/P4Gz/YJij9421TzzB3PUtnyRUGfNAvSH7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I2Lu8BED5dEY8AxTYn/RchmKr8eibe+CIAKz0RXUfs1M+l2ku
	bFH15hhzBdU6hk6bsvOTosb5R4EQJ8LLqT2EGMEoGILNxbQNOzfvVDX4
X-Gm-Gg: AZFdTZcSa6iqfvHVaBcA9uL0ySYoZd4HMDmmf/HSAyMYr0OW/HCgIxdkhpYcMf1QKUZ
	v3TSjCVdlGBgl4s3ZI2Xbx5bfUctL8kUG6QIi4LKNLDuOJprlmCYYOniu70ubwdjaEFIfdCFZG4
	nLqdrTXELtaPDuvK9Mv+OzcKLk8JA8U4iLJEMfvV6NfrL5p9/PgdpDGZPs48davVI7UaeMmEFrT
	I40A4Svj+cJO8kbuTuE80Q04oguFw8dYqsTDk29OfK6WIsr0L5m+YNTkvh/m+auyHb18zAoz543
	hRDLLQ2C3TPlWvZNOQR4bZlHqF4CM/ohjESdc4+Ofwk2yNnOUjy8ATlyPsHqs74mNoCYT/w0R63
	lnT/3G5uJj7jnatjdTqUTZ7/jWLo+8oHxa0yiolY1shMfH/2FQmNZnE/zThldkNe0AfHZo4GKkI
	abDl4/MC6FityqzIl0qxRiXVBps+UGfMtAkr9kwijRVL5wOUM+ujBENClVv5XS2awYUYLapm6YK
	sJLG2ifJpYwoJu4HJqyGmTdrN56LoNqT0uQUr4FZQbNR7ScTj7Pw8oLjS8/R04K4zVCcwFppT5x
	7tpSw1CpRlae7XSSyFJoag3sKWdryK04Ba+gw/3o53EdyG73+plluSo=
X-Received: by 2002:a5d:5d81:0:b0:4a6:f154:b402 with SMTP id ffacd0b85a97d-4abb1baaae4mr25856543f8f.10.1795477336474;
        Mon, 23 Nov 2026 15:42:16 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm23777215f8f.40.2026.11.23.15.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:42:15 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 	Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, 	Jingoo Han <jingoohan1@gmail.com>,
 	Lorenzo Pieralisi <lpieralisi@kernel.org>,
 	Krzysztof Wilczynski <kwilczynski@kernel.org>,
 	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 	Brian Masney <bmasney+clk@redhat.com>,
 	Jerome Brunet <jbrunet+clk@baylibre.com>,
 	Neil Armstrong <neil.armstrong@linaro.org>,
 	Krzysztof Kozlowski <krzk+dt@kernel.org>,
 	Conor Dooley <conor+dt@kernel.org>, 	Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pci@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, 	linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] PCI: cs7542: Add CS7542 PCIe host support
Date: Mon, 23 Nov 2026 23:42:08 +0000
Message-ID: <179547732839.3.15916995856832702891@gmail.com>
In-Reply-To: <20261123222404.GA1110511@bhelgaas>
References: <20261123-b4-cs7542-pcie-v1-7-4cde5201d404@gmail.com>
 <20261123222404.GA1110511@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Bjorn,

I have worked through the two threads you linked and prepared changes,
without posting another revision. CS7542 has three independent DWC hosts,
each currently with one Root Port. The DT now has explicit Root Port
children and PERST is acquired into per-port state from that child.
Almond+ shares GPIO92 between its two Wi-Fi endpoints, so only root0
owns that GPIO; root1 must not request or pulse it independently.

The sequence now asserts endpoint/core reset before clock/PHY setup and
releases PERST in start_link, after DWC Root Port setup, with
PCIE_RESET_CONFIG_WAIT_MS before training. I also addressed the vendor
menu order, include order, constants, formatting and cleanup labels.

For the MSI address, the expression using a CPU resource was misleading.
The retained vendor value is a PCI bus match token for the DWC iMSI-RX
receiver, which consumes the matching MWr before AXI translation, as
described in pcie-designware-host.c. It need not identify CPU RAM/MMIO.
The draft names that bus token explicitly and checks that it does not
overlap a PCI MEM bus window using the resource offset. This is not a
claim that I tested non-identity hardware translation.

synchronize_irq is for the custom APP chained handler shared by INTx and
MSI: after masking/readback, an already running handler can still be
dispatching into the domains about to be freed. The locked unmask gate
also prevents a late INTx callback undoing the quiesce mask.

You are right about the physical race. The v2 lock serializes the actual
config/DBI MMIO with the IRQ latch and software quiesce; it cannot prevent
a physical link transition before the IRQ runs. I have no independent
evidence that Root Port DBI itself needs a downstream link or reset after
link loss. The confirmed hardware quirk is accesses beyond the 512-byte
RC config limit. I removed the stronger hardware claim and describe the
remaining link-loss latch as a conservative no-retrain software policy,
not a proven silicon requirement or a complete physical-race solution.

The revised sequence/layout passed Almond+ RAM testing: all six PCI
devices, Root Port MSI enable, actual xHCI MSI/INTx interrupts, host
unload/reload and actual PCI-device OF/NVMEM mapping. This does not cover
physical cable/link-loss fault injection. I will collect further review
and leave a few days before the next revision, as requested.

Thanks,
Fil
