Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974578;
	b=3tzMnMHs/zuHmxHGaL4LoNDPvn/lwwKDD+i4/OvK48Gkt/YrXU2TnyaiYX1uRxaYmUC8
	 ajJMDuoB9wSaSNNSWDXOKuH3D2MHm4PuZ6F3nU3MONCt9ff5AU9YPS0ub09IHWFpiAbxF
	 MvPJPR1iw02OzrRe5IUEMqdh6bta1qc/iXmKCPUFt+PHeu8OpAiBan2t2UJ+h1BpW9byu
	 iXIqfEvrKCQh5Sr2dVfZpDne3MjO31hW5Eak2IwnQ16+95tQkD+gcIkJiHEfKk55sls89
	 ckNFbMNQWzzyvQg8mhR9UUz3A893KJX6NAIlwXNTu4WnqfKq0m0lf1Br8WwX4CmwAfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DPqAuBS4T4u4zMA5n0n3Wuyb1m4HV99Rxc7qJYm5Ofk=;
	b=Qlezrr5dxskKol/6WuHR4qmBj19B5dufS+RsCdpG/pOZXkJ/stEj1DCwMcB5EksFXKWf
	 upb1NoDxyNt7DAlhSwNZsWw242wURjE6gPJpKbswBzBakl3YB2zzZTPZn+rtsrCqtJZT5
	 jA2hcK9hAjgyxy/cHPUn/cB/nfeN5PIV2sh5oD/uZxtZkeu/DiRh1shGnLLnMH9CE3E5k
	 7S12D2JyXJjoIylavHQRK3XdVNt2W39WuCdPSi4fwnAEgitQ6UGzQdUGsa3xrSs8Lh1qV
	 yx0uFtu5kBTJ2NW+1zUGE7EfvG5Jw+V3FkJWsQwuX3TVmfu10uTK6ijW/sh5759GwXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A28606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A28606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so268292a12.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 06:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793974572; x=1794579372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPqAuBS4T4u4zMA5n0n3Wuyb1m4HV99Rxc7qJYm5Ofk=;
        b=YV68Sg4ZigcQlikDz3E+vtM7SUoJ5a4xGSQq4imf9/vqosq5Z/Hs0hA/JuwqoBkGJS
         FdS99OOfpBVDu69p9yOotk3pexEVK+H8JKlPLxvAWr51JUQlR7mIeZIj3lCL2v5AivUw
         w94puA56j6QszR37az4Z7r7bR0vP0O4WiVlGn5x6IxyiCojDpt3RU8oFEJ0cPCfmTeb6
         i3NOTJHcgNrkVO6zhJ4j7/54jUgNCMOm0HjpKuUlsCziLgGrGX9Yf46UBLlt4uwySWJE
         YPMyykDBbLNIuF5V7UtOv2WxFXVvZOi+AVISlwNgK1EnOfz3bnRn1NH1cDYiWbP4DoMX
         I9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793974572; x=1794579372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPqAuBS4T4u4zMA5n0n3Wuyb1m4HV99Rxc7qJYm5Ofk=;
        b=YOh6Lsv7NbKbf4SnzMt+foPQDG55gkS2weWzZbwpZHfQ3mtJ8FDhi0S/xF5E3NQdeQ
         SZCR6NNutPr/2uw4Ht2kF3ZM6bENROiepI0QsYNRDNHwZvszfbdd0mcw4ixha5ls5sme
         gxe4mAvTnEB8xA4Q0wblIBr/eiD0NzbAPKpdtWBrdVTfwj53CeeVd7cH4BMRp5Lrkm/K
         E9aORRiUJWmLU8GdKDQNDUjDRTEWpTzpQipztp46eP5xS7coo2L3cNq6ervbfDj6OB7Z
         etL5EN8kzGNxDKLR/B3g6Y2okXGTBbkZiW+S6RSQf9mLcWDeC62mvEHV/cgVWv64lUXw
         TICg==
X-Forwarded-Encrypted: i=1; AL+hErH52qYIkBu9FK/ov6r7IwP1ErDgNA8RoGTqnRDh6d8S+HOSsRJYot7/BPTnKUfGDKIrv7C9/lDZer4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r5wWlXMVTqQx4nAU113EgBuje41F1EmhM7e2latynztpp7cTl
	Eh3aFyKs/lnsr4TPQrPw4DkcfVvXfQemfIz9Pg5rBGTDiUYm7HQh0K5Q
X-Gm-Gg: AYBFou27GmScEP1+fw+2Z93yH6wGadghWj1dtLuiSX7UYQpYLhJXSpZm/iVk1BKt7kS
	hnGiSSqr6EinJC4kPNBpnkjmxY1GFEqsz5KXBU11Xx+mQt5dZhVWY0l05wHKrj+vqOq1c9UP23T
	1qi1cCUqgtZSY7JOsoHWpZSXbS1amfBx1Uu84B+eWCoH+zFYyPEBgZBbU+clG3XpbSM+Nubev8K
	n2BRqKfh8XKhi6ggDOlnnCAKcNlqMkniEZwiAIAESnFgVl2lTSnU8XUhW0/c1kqyCxr4W53i/nI
	e1F9smIQDm7um0guI2Ky8griaXNz2J3SCq49SfRCLogahSM2cKebMSNkTqow51ReuaugnWVMmEc
	UEfLM5mqC/7GQDQ9OxGPRUKqi1PIOmdZ0xxUDxOc8shSn3mBBrm8K+HPkW0FWJRB9wpzk9cUW/7
	fM2YJtxv9o3uI8qFxMyx5u+dt9AzAQF9hKEza4qXqldVhWJ2dvwWgd9zlbkVlXmYY6nyJqs5PoS
	KzVnJenuWCdqq3nnyXHyPNFOyjvnqfu6WE+SUWDkFQDMaWJdjRvqbHDkDhzE98mVJaSEAPGlZQc
	qKdoQkmCsdikRXvCzkLxpeou5ONG8dqUcl0flq37Vuqxag/52wMGWQ4f+cqHxs/b6HEm67la6Fq
	dEX8rGRvpa1HzIo9UlAA9p1TEKQTKbFrQ0pUXe884
X-Received: by 2002:a17:90b:554d:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3b0db5edb73mr2783616a91.7.1793974572380;
        Fri, 06 Nov 2026 06:16:12 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm8057305a91.3.2026.11.06.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:16:10 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Slark Xiao <slark_xiao@163.com>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: bus: mhi: host: pci_generic: DW5930e does not come back from D3cold on a Latitude 9420
Date: Fri,  6 Nov 2026 23:16:05 +0900
Message-ID: <20261106141605.2918662-1-sammiee5311@gmail.com>
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

Hello Mani,

On a Dell Latitude 9420, the Foxconn DW5930e (105b:e0b0, firmware
T99W175.F0.1.0.0.9.DF.015) fails every runtime resume from D3cold. I
would like to ask which way you want it fixed before I send anything.

The modem sits under root port 00:1c.4. The modem's _PR0 and _PR3 and
the root port's _PR0 all use the same ACPI power resource
(\_SB.PC00.RP05.PXP_). When the modem runtime suspends, it goes to
D3cold. On 7.4-rc1 the first resume after boot gives this, and the
modem is gone until reboot:

[   24.704019] mhi-pci-generic 0000:a5:00.0: Unable to change power state from D3cold to D0, device inaccessible
[   24.706039] mhi-pci-generic 0000:a5:00.0: Unable to change power state from D3cold to D0, device inaccessible
[   24.706667] mhi mhi0: Resuming from non M3 state (SYS ERROR)
[   24.707418] mhi-pci-generic 0000:a5:00.0: failed to resume device: -22
[   24.707731] mhi-pci-generic 0000:a5:00.0: device recovery started
[   24.728030] mhi-pci-generic 0000:a5:00.0: Unable to change power state from D3cold to D0, device inaccessible
[   24.730020] mhi-pci-generic 0000:a5:00.0: reset
[   26.742093] pcieport 0000:00:1c.4: unlocked secondary bus reset via: pci_reset_bus_function+0x1a9/0x1d0
[   26.885444] mhi mhi0: Requested to power ON
[   26.885794] mhi mhi0: Power on setup success
[   47.157078] mhi-pci-generic 0000:a5:00.0: failed to power up MHI controller

On 7.3-rc7, Ubuntu's 7.0 and a mainline 6.15.11, the reset brings it
back to mission mode instead. The mhi_pci_status_cb() then calls
pm_runtime_allow(), the modem runtime suspends to D3cold again, and the
same failure repeats every 58 seconds (7.3-rc7) or 79 seconds (7.0,
6.15.11). After 3 to 20 rounds the reset fails with "Failed to reset
MHI due to syserr state" and the modem is gone. On 7.0, and in the
first rounds on 6.15.11, the resume fails with "Did not enter M0
state, MHI state: M3, PM state: M3->M0" and -5 instead of -22. These
kernels also log DMAR write faults from a5:00.0 in every round. 7.4-rc1
logged none.

Setting d3cold_allowed=0 on the modem from boot stops all of this.
There are no errors, runtime suspend to D3hot works, and s2idle works.
But then 00:1c.4 stays in D0, and the PCH never reaches S0ix (SLP_S0
residency 0, SPB not power gated). So disabling D3cold looks like the
wrong fix on this machine.

Is this modem expected to resume from D3cold with M3 -> M0 at all? If
not, should the driver treat a resume from D3cold as a cold start
instead of going through the recovery? Or does this look like a
platform problem with how PXP_ is turned back on, in which case I will
take it to the PCI and ACPI side.

I can test patches on this machine and send the full logs.

I found and checked this with Claude Code, on x86_64.

Best regards,
HyeongJun An
