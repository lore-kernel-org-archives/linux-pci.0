Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859781;
	b=boCxzndX46J793khzY5h2uy29w0ojQNdbgPZyIHXrlpVpUnczvSnoA/sRDPKlzStgtOS
	 OpeLBgCnpmW8ZEKIhof8/KbTwVT/lzqZKBCQgMwvi/CL1Uah81NzYKgZ+Qg1Nj7G05EfV
	 LZOXTeh+NdKK5TPf96sWv/rtC9twQEz22F4rBLmUy0Whumscvy0GzYTTC0hxkLbFJt6yJ
	 E703n+yREmSllfh0g416bkw9w4rHx9wBbpHU47AWlOpOuQLgO0sy5tzZyH3YU2nRroLFM
	 nRxFTt+FDWrNztkNKE/fTJyu+WA/JJZQrSuhleNmEzo2ryH6XzL61Ru0bOMkv9I7vKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wWKgu+mFgtlwrDE3M/qikiFkywyfILm386oFvXBqykM=;
	b=EfjAguBtr6SBcT5zLVBtGnf8D/jozvXkIYT/zGErpytNNSdqYQjPWjewwPGUrKWFIUNS
	 rPeCeECmazw7x0Hsw7BHstgkKE3uItTnZKdRfOhyKK1a7BnX7eZzjCjHH+bN1WSbaIm0C
	 5SeRYA7brQ1BKoVyGblQbbBcIndsXlMfRJtnKZrroXtPfPpsiCqRGc94KxaA0q0MSA1ZC
	 1yescZIF6xo7OhTZWdTAHI5ufFxPo83V0xyCcY6rW3TQRksrYzEdW7YimHtv0CGegaUv6
	 FBPJOzZIDTN4gziJ3HBOWsYG6yhMH3M99uexNni7o6fT8u0MyPbwEniI4yIBMKzg6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vI5o/umH";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1062606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 20:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1062606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vI5o/umH
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so10118387eec.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859779; x=1795464579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWKgu+mFgtlwrDE3M/qikiFkywyfILm386oFvXBqykM=;
        b=vI5o/umH5Q4SNsvz7EoLsCg5rfgEIiTgcisAYDX2M+rHXRIOyYWUw84Cz7020VYJbA
         e0GWk+Znh3Rgot5o/ByIoUqRM8XULzybHE8aF9R8aP1UzGHds2HNlph0X+fy8yn8wmo3
         HWkGrRM5vmMWN1/RdZw4/pm1jSoIHdyW9FnKJa1fLkHrY2NjSRr35/aa8E5ZLqyCEgMS
         PUpsyenaCMxWnnZG2ebtlp+7FazM8ylbg5xF4NdFnp7Zh1ffYsWvNh0xpeRZKg5rXzWC
         qkDs9mtekGlB5TL3htqNsDIb7RfaD2X/YZJCvXB3JzxdlpV+2gRsoGpBOA43V9kwAzzb
         xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859779; x=1795464579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWKgu+mFgtlwrDE3M/qikiFkywyfILm386oFvXBqykM=;
        b=cnZKtbKP7nIlVNKj0PMEHirmU3XpZOGsi/gkuHzhxof0a/EObwl/Z7D8LZfXwyYOjT
         HpBXJWyj9L2E0/puTxJeRi9Zej244Ly+r/pZqhZ9oaBTtjIqWoKi0Uj6rV5MZwHg5fV2
         XeZhkouJro+K+eOOpC0/dKNWNXkz8ugyeZAHR/4rJ68tW4DaspKjd4QLRMdHXavoQN/Y
         hNCabCrBaxIRNgyM6hQtW0mzvSXOC1MycR6n8HjTZWVeprJ9eBpOw2VPc9DSla4Yk4xE
         l0mGZxO7+tLWKOc+WuYW2s/2RvzsfyorgOzhbmN4Rr/+PjpQcij7J/ZnT99GIGIKZRHW
         K/QQ==
X-Forwarded-Encrypted: i=1; AL+hErFYh8FlsncttGu1XIqYgRqDYtxljdX+A34jYl452k80R3eETx72WrKK/6lgh6WB1WOQA+3N8y8LmMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z//s54heFNQQq2PWF3t9v2xrfwG3HBy1ozWlSznAX0htvFMGIw8
	wKMB9IuXuuShO0ncIrt1Fn9aFFESitUazcSmw3/R1yhvKW+cI57rxXqz
X-Gm-Gg: AZFdTZeqQvIWjz4mV2d7BGIGg1Ez4Kk0fiB2uEmfYvwy1UkGF7Dvfcdre3/6hSEktHa
	FHRLdcnd/YFJ4zG/cNrkgoakTruFeUTMlLrfdJNitJV/9teAk01Z17uMEchj8qNdBANQFIeZrqV
	XxvjlfFCrW3SYg023Hz+e6XgObLvhFsuWchb8f3KpyDFqWEmtitcfeWPB68ufsq0fcA3A7R6ZEr
	ukqk+ff0dJL1XGJMwgWvtIFCAzC59qWcDFun0dUX+0TdRXmAxKRd5QIxyuZiRZwOnuVcMDRTPmK
	AcA4Rzr8cLXCW6Ga7774SDNpHpifkL00tuFXgCcjgHWM5jcruBdpDnFg6gZDjLvUykPnYXbfFfL
	pMl3hlnEcjLiznheiiRU7EQQISJLZwLz3BLKMKN1dTgPpU4mg/EWm34Vvn1rglw+H9ak80XeFIl
	1eieWAfgCizjwHngf8FE0OEPbsxu54Gc/OETvFRm6ez7dJNVXdI8av1KT4Yn5HCPCzY+0wOwV+F
	9Kt6LIzyMwB6urseizZcoGtnsRUQBohLSLLnuIzxrZvOwbE7534+rqm0XMrPvmf991SyCoLsVy6
	ZCu+MTx/NQqf4+FlBlIAW4qrq29QMYvAt1FhFdyXvlV2Vio9yxSyxWvLZWhaRL9FUqOfJiNVVxL
	CfWlpmo3PFynkZwc6
X-Received: by 2002:a05:7301:11b:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-37967316395mr13071358eec.25.1794859778068;
        Mon, 16 Nov 2026 12:09:38 -0800 (PST)
Received: from hp-OMEN-Laptop-15-en0xxx.tailcef561.ts.net ([122.172.81.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm66737021eec.21.2026.11.16.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:37 -0800 (PST)
From: Jayaraj Devaraj <jayarajdmit@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jayaraj Devaraj <jayarajdmit@gmail.com>
Subject: [PATCH] PCI: fu740: Disable pcie_aux clock if reset deassert fails
Date: Tue, 17 Nov 2026 01:39:12 +0530
Message-Id: <20261116200912.156500-1-jayarajdmit@gmail.com>
X-Mailer: git-send-email 2.34.1
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

fu740_pcie_host_init() enables the pcie_aux clock and then returns
without disabling it if reset_control_deassert() fails, leaving the
clock enabled on the error path.

Disable the clock before returning the error.

Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 00ec69a09164..2355243da793 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -260,6 +260,7 @@ static int fu740_pcie_host_init(struct dw_pcie_rp *pp)
 	ret = reset_control_deassert(afp->rst);
 	if (ret) {
 		dev_err(dev, "unable to deassert pcie_power_up_rst_n\n");
+		clk_disable_unprepare(afp->pcie_aux);
 		return ret;
 	}
 
-- 
2.34.1

