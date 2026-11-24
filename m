Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516329;
	b=vBNRHJxqKHivgp+RyyeU0T6HjQrgF2V9HxNgZam4s67P6upXY7JwYqbYWIt6Z9MAAGpG
	 H6eHSoOHp1KaP5Vu1h7CVlvYou/yh+K+4rLauBdzFI5nKCju8nfrz2milkgp5DvLrcyYR
	 vBQuS96tmgWFZ382cJ/xZHfGe/2za/x41ePXmINBgbLsyfnOXUurZhuzHCuQ1m+pprIqw
	 //6PanDHEmpUC/GXYCvaKBryZpU3Pm0NhCxdZ5H9/OazXSYZSiN1xWjYMjRNwUVUBepzB
	 96Rc6gx98QSqP10YVzzq3NYi1hTzvDJMU5ifLBsGLTapFntrCdVEnpQNwBgRM2yw1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=L91r7jLCdgBrVDkCLs5wB8S82AZQlItQYcCNZU9WUC0=;
	b=GJqgTV549/reXwdqvFlXPmUViYysYlQ/NojxrJp8WKj82iBb84crW0u/SSBBl4BtcZrP
	 WomDmRw4SwXRXTrggTovxVpVSKWF4SMMiuw5nXw3XEYEqmAT+A5wCV4KOS9A4Kbvnx06T
	 z0efSnVjqOwDJgQ/t2bKhwCtyNXLoZfDEbY/HfIhQfQAgsJjaK1C0G1BJmiIQGuJYRXsZ
	 6FitmWmg56dXGtNRGdafHTrFOiTBThKCkYxUPKw6SvMGMNEb2lVQo7QzAeJT76Z7qUGN6
	 iCFL+dny0PV5UFRVQsX/OXcZ2rNkTZDvcesYEMkV2PDhJws1W67VDlyn2IrYuZ879Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxYtZjny;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26505606A326
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 10:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26505606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxYtZjny
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c10dc41270so4675695e87.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795516327; x=1796121127; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L91r7jLCdgBrVDkCLs5wB8S82AZQlItQYcCNZU9WUC0=;
        b=jxYtZjnytvxvCfLSD14Mjy8gdnPqOnkGAD8oV/RDjwN3Jq1OKzV470i6aqaho1R4rh
         4Z5JCBcHy7QYAFrknXmkiKXtnooQS32SNGm3d+o3kZ4CxPckt1AntXrrsZQA8v3zafII
         dILBm8eyY4rqPoE5DEZJ/d0foS6n5PTS5uZxJMgx561EYe2xox8+Ib+COdeoMEwORsvK
         MnJJgtI+PTigIutZQkV3pJFaRYKImIsbYr+FfeaASJaIfcYsX45nG8700Yq6VBixF8Ck
         njHV6e+E5HJLJNBUTM/UUnfa6gEKDmKlNE+rnTeoP64AIsVFQec+R1Zqg/WCrAOrTqeA
         87wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516327; x=1796121127;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L91r7jLCdgBrVDkCLs5wB8S82AZQlItQYcCNZU9WUC0=;
        b=es3ykNuRQ8nuopNuMAPnFO6dXXeT82YqRSiy3hFhg6o7A+gj371WyPmzE8MlidMq4a
         exCpdOx+1xFPDgAS8JNQr+bKlSwM4iUNb0h2SWCLgFYg+k2s5CWZPYp/c7xZLaH59cMO
         6tsLke2a2KufhXkFfz5sj7/9tuO1gkS9eH4WQfOeoV09F88hNKpD9hSidBwan8Ke/SSf
         YVQv2ScATLHJKuSKPXMcsoJu+Io1CwszWyjJetpGTHRvT6R7WmvGNYk0BDLPq/DIfuZS
         DsjVOR8yDpuR/s2C7Tkbo0qSOT7KoeknjQcwPDlv/4J3qkQcT/uaODkKrZPKkWuHagpp
         oZag==
X-Forwarded-Encrypted: i=1; AL+hErHTdNTVAdjLQr3Xf1A9VK4OZrMZqDy1ACslPp036aglbMyZkLXblC930pc3mJWJVqul5UMvqMwQMJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z82btPPXi9zYD0hEFRMZmo+6QNCKxlHx0BtE7+qDu80ALb76ONT
	HkhSthCn411hvcormklFEL3BFFD4as8/0G64trRVbqEJlgo27jEEmdai
X-Gm-Gg: AZFdTZexOWxQX/HY7Qe11rXgDSIoa6U0rV2PNJhlFYYmNCjiW4RnE8Z0WV7Pwso2kEq
	tc6YWWgJoF7GhwLskkAvbvXQfN/1ryqCjro+CzfAvAN7XJoQQ7ucLv1bAqSxtn330IgGQD4SATv
	glZH1VdgcK/+6Yo409f6SjWAhYRp0t/CyunyVdK9WLN1a9ggiMwm8WnmAeh3ZxGyMm7XiKe3Eym
	595KOqzb4dCnMyW/JKlGuChEWzUEqvUjpQDEbzqSnWBhbKzc06HrIdXNLCJmd/nXBsooTji+V2g
	dU4sa47w5DdkW8WzSBUA9f7WBSJ/WbZSVbol48Qby9hceHz0gufSBgxe9mfvVdrF/kNG6r3N359
	6RCgJke7M56Rpzn5k3EATdeI/sl+tweqFzSv/StCnnOgWTkLDHaNNDRUHxqDzr8YT+pbS0cEcOE
	1JCgCyYMNP9Nvz53f7MUAWtn9CM0rj+VWwCGJH4eBmddrw6UACXEf/ac7mrCSJfdDvGv48qlFts
	+4sCdkt+Ra73g9oRIGn2urPfYdjAjqg+qsoZaFihePyUXvbVPdN7oVNOonDMOaU7+4mEQZJOeYN
	dQLOvN5H4Dr7ZX8iwRBm2sYgH2tsr8t1Kaa3p9keRrSU38Iv1dFY00Q=
X-Received: by 2002:a05:6512:3d0f:b0:5c0:4cb:2415 with SMTP id 2adb3069b0e04-5c1bc7c9a8bmr4202658e87.28.1795516327013;
        Tue, 24 Nov 2026 02:32:07 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcf332c9sm3680542e87.7.2026.11.24.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:32:06 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] PCI: cs7542: Add CS7542 PCIe host support
In-Reply-To: <f5d30781ae9502cd76ee2b6757f96a0e5ffa8b71.camel@pengutronix.de>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
 <20261123-b4-cs7542-pcie-v2-7-f589a9cd0bef@gmail.com>
 <f5d30781ae9502cd76ee2b6757f96a0e5ffa8b71.camel@pengutronix.de>
Date: Tue, 24 Nov 2026 13:31:25 +0300
Message-ID: <179551628581.3.13614361091709904582@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

Hi Philipp,

I'll drop the PCIe host's select of RESET_CONTROLLER. The host only
uses the consumer API.

I looked at reset_control_pulse(). The CS7542 host asserts its
exclusive reset before enabling the clock and powering up the PHY.
The PHY has separate reset bits and leaves the host reset asserted.
I'll keep it asserted for 10 ms after phy_power_on(), deassert it,
then wait another 10 ms before accessing the host registers.

The helper would cover the assertion and hold time for a standalone
pulse. Here the line is already asserted across PHY setup and the
controller also needs the delay after deassertion, so I'll use the
explicit sequence in the host.

Thanks,
Fil

