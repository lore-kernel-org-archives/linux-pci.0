Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EF283FE6
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208177; cv=none; b=Euac73wgNRBRjYlrDO1uCsJrNUfvzkQbtHdYJL2wTg6fllI1+FmKhPvjOzKOGcXoHEXLxVFsM4h5s24po8M0H6mq+RWzRmH3KGuvMcH6VNdPItYZn6gzaNvO4RJLkfz23juNofa7xMRGSqrV8FgkhZbqfAR0uW1cPGnnQiphQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208177; c=relaxed/simple;
	bh=hPq8RZlu+XAeKlpUQ33iZFr2XG9G0rR3S53DfzohcFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=owRHGf5YZrclxcschUazerAxeYWtPk14culauZMeZ+zhnyY7TngfYrWABLvd1YIGHQ2+xpPdXBFgZNtEj/aiVEMABBV1vVEIYslmlGtMq2r6SK7bVoiYrNqHQ3cB+mNjklqZYseLJYhErOfTqwqlUd9NbIPqukBdeX0ZPeoHAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHaQ8s+t; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHaQ8s+t"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d8091533bso146325eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208174; x=1781812974; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zd41XiatIhmkg77GVQHRQLalQhR4rQLqWbEQKAVQlyk=;
        b=UHaQ8s+tAfDMLFmO2nDkxMfKxq7flKtTYpCHE88yrya38L8HbTZBruf1n7GnPaEjP2
         6gk0LwTC9EtwdBFwvjxYdab3JzwNpHQVRMvsfmj33EfoIssATDdfDyjRxwg4PymiIO0P
         jRfcCGG3zXoTt6KVf0z75ES6rb8i4QX88vV9KnrqHOWHnetyg37Wd+vBihb+5M63h9vw
         c2DeVRXy9IaV/D8cyLfsFFTN5Mik+5Y0LycjTnWpAwlfLmTWrQo2Sj041/UyU6ETjHKy
         bg+jjCjfdypaYujiVvNHO1kGJHuOT0TOeAH8sHNWGLMMIReLRZKWmpVQyK2RfIfJbuug
         jfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208174; x=1781812974;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd41XiatIhmkg77GVQHRQLalQhR4rQLqWbEQKAVQlyk=;
        b=kI4GGDpMvJeQ14WdgnExPupX3yFcQBye43dBJMCc68UhrsUQo0uUk7TybKus6CbFi/
         0kUyml7rHTa3p31rb7OacD8dz2Bye5SQVGDzIT0jEZ+DKcjQFRCud3PoMzBwho29UAM2
         lTRDADGBPYqTJNf68oHnd3JgWqMxSia3hsxjCJS9yAbW4XV3UFXhVJ8/FugR2qgmEb/O
         mTp8z27IdEz8K1vOjkvdV5aOG5YlRIhvvgDwVxzBLbJAQXQqQFjwMeSwwC92sgW6QjfV
         y95yAJN+v6F/ssPyuJKY3AIjzngHNVEB6SDUbJfOhDOWVDkLLFrGUbFIPoynLAjtA1Ko
         FHvw==
X-Forwarded-Encrypted: i=1; AFNElJ+bQQoVoCGBpEDJLOOQKDy+YrtHsavu5El3Tnm4tlvf5py1JkyuYT8h0E+FG+HFVzH3n3nWsJbnPBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGljigRmV2K7JS1KH8sRBdSAnumjI39IBi4VjqZrVdveTlRf5
	6tAdi3L0vnPjYOfdgBIM2bx9MLrjpbmuqyqmOHDVu8z1CsRMC2XbMAaZ
X-Gm-Gg: Acq92OFvNA9DJPQ6pdm7C82zGhDy2pXt0+p0j62E1pJZ4PleAnTwVOhb/N4tAB/YXlY
	TmqdrcpomrbHZzQBoAXLwSZfKxw7akDEhlPFd970FzxPzRHw3sKiDmmsDx2ahp7c+9Bw6eSwMRR
	RCRM76rVk0/FGdYggTb3WchOxwHu6CrrGxpMad8PF4Y8ydfpTwjWWU1QiQF7p5Uji7JHCHTdRHg
	ZiBK4D2VeR/AXfgxkjrpaS42Z41MWt4ZYlmREYMNDWGM5YjL6ftpTgaVWFQRYKrbECKK/Jipxgk
	fPVgGextWGyrCmzhcVSGm4z6wyZIf/ToJb4ulrIE0YrwrrQ+O9b8FlM5Ybs4LxWViiy2Nj/SQWf
	Ysmgo6vkdSFvb5BrBy7GBABL+8wBg1/uYUBFmZoOaHzEH846IVoz4r6U/FTRuQeqxauydcftkgh
	fNHU+WiSDJ
X-Received: by 2002:a05:6820:4b96:b0:69d:e5f6:cef5 with SMTP id 006d021491bc7-69ecb060dcemr2957697eaf.55.1781208173971;
        Thu, 11 Jun 2026 13:02:53 -0700 (PDT)
Received: from geday ([2804:7f2:800b:f09::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30105fd9csm3244376d6.10.2026.06.11.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:02:53 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:02:42 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [PATCH v6 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
Message-ID: <cover.1781207474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dragan Simic already had warned me of potential issues with 5.0 GT/s
speed operation in Rockchip PCIe. However, in recent interactions
with Shawn Lin from Rockchip it came to my attention there's grave
danger in the unknown errata regarding 5.0 GT/s operational speed
of their PCIe core, including data loss.

Drop all code related to 5.0 GT/s operational speed from this driver.

Endpoint Mode driver was not tested.

---
Changes in v6:
- Squashed patches 3 & 4 together as suggested by Mani
- More formal warning message as suggested by Dragan
- Set the 2.5 GT/s bit regardless of if link-speed is set to 2
- Link to v5: https://lore.kernel.org/all/cover.1772239598.git.geraldogabriel@gmail.com/T/

Changes in v5:
- Changed commit order to not break builds and adjusted copy pasted
  commit message. (thanks Charalampos!)
- Reintroduced behavior to force 2.5 GT/s in case there's something
  non-default in the DT. (thanks Dragan!)
- Link to v4: https://lore.kernel.org/linux-rockchip/cover.1772169998.git.geraldogabriel@gmail.com/T/

Changes in v4:
- Incorporate suggestion by Bjorn and refined by Dragan to drop the
  "catastrophic" code
- Link to v3: https://lore.kernel.org/linux-rockchip/cover.1772057799.git.geraldogabriel@gmail.com/T/

Changes in v3:
- Clarify warning message even though Rockchip won't disclose details
- Drop DT changes as they were applied as subset by Heiko
- Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogabriel@gmail.com/T/

Changes in v2:
- hard limit to 2.5 GT/s, not just warn
- add Reported-by: and Reviewed-by: Dragan Simic
- remove redundant declaration of max-link-speed from helios64 dts
- fix Link: of helios64 patch
- simplify RC mode comment
- Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/T/

---

Geraldo Nascimento (3):
  PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
  PCI: rockchip-host: do not attempt 5.0 GT/s retraining
  PCI: rockchip: drive at 2.5 GT/s, error other speeds

 drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 drivers/pci/controller/pcie-rockchip.c      | 16 +++++++++-------
 drivers/pci/controller/pcie-rockchip.h      |  3 ---
 4 files changed, 9 insertions(+), 43 deletions(-)

-- 
2.54.0

