Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F737DE8A
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815505; cv=none; b=ijyrJstC0aIxdgjZDA3kB3w2LXv0S8IWbshU1ueBKwFwbvLY1/7+MiDKxEDquap+TsGZiUDYhvyqAQ/3EKCAjYWg0Dls4/s4knBk8ZICj08fPS4KYQuitnmDOfMvWyEhsIi2S1lix/ZnYU0AT10cjF4R+fhag5YZB/efAgQJaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815505; c=relaxed/simple;
	bh=lIVSpYNXYggwgLGuyXWDQmUidMbwlvbUwtc0BioajXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7jHhAs/bFvYPhAv32lPTNIGETPSQFN5xQ8lf5d13PfbDzXUNxroWGmHwHe1Ms0A55wCctE2HeJLAaR53XptSSGa4y7hupH3Fvfnb830fYgpbJoFHzGVZYRCfKBIl52F9niaRUiWNYWbA+fCvOhdyaqmA3BF72zjOEuZUh7+JKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nokfAtYr; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nokfAtYr"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so458036a91.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815503; x=1785420303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fEvTy714BzLXGkO9IMhH+5Gou32h276dSsrXDfWR0to=;
        b=nokfAtYr4DwzKbzWuwdmVnHUP5pUz8JzXi8u4LlAMo2Cml48lhNNk9go1cHPN5fyBH
         yF90lbj5GFS7O1UPMAKjtWfFmVGPlxIiXA+QBz3ErYv2umCCagKrrgP5Ed8MVZ08Lztp
         GyYQhV4V0U/p63qZxPoww7cF93bHwLLZrD5hRocdPl3AKJ1r8hdC+Hy1rjNd/HNPJyII
         hNjKALAt4Fibrdt3HSRJFzx+/WqhTUmjLIC84u8V0FRyNtPCeI5w40x3+wuMpwDNnnp9
         ipMFJr3T3RJtridtUfy5v+CXmGEtRMVBok+hRTTTTOS4+qaXlakihnEsz4ktt/7FOG7o
         GXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815503; x=1785420303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fEvTy714BzLXGkO9IMhH+5Gou32h276dSsrXDfWR0to=;
        b=EvG9oV0yMRWTpf5Uz+ol/N5DjfjkSwzEtvPoVqun70Yu3o1gr1u5im5GNQ483ru0ES
         YgNFLr/QK8Yk2BnuvSz1kI5GXdgblFRAfwasnaaCY1K5jrhfmdI4yHo5OAlUjEE4JdhT
         rNC477QjhXmyPv9UQbzQntFlAi4SyBz6scqKdkjHfF12+tZddgdJbYed65RXXRu73p5S
         MtDVGPRuz4qR/TiAKs1OMhC4vF/I3XRl92lWGRUcdx8RY3icE68WJBaGmP19IxT0hhg9
         BjLHCK4TEwEC3TruQmsnQSr77iu9Uqp64Mk2x/6sE/c6eX9I+Hd8d2KovGmk2RC+ciJQ
         Y59A==
X-Forwarded-Encrypted: i=1; AHgh+RpPLGSL0afdJgNDwNSLUxYslNS9ksr4eRWEdjD4gAeYhKVGeeczyCArEoOHxJMXCftZSgFWbJE79Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NKwZNwpahZ+9cmPwWJIAzs3LQdbANStXzVebxApiTc1AXCyW
	J7rXC8jFsScTBVhmDZb8oCB+bru5DLjbgUj6dtKPHsw9o/P7ZsED/a9m
X-Gm-Gg: AR+sD13trL0oMl3nKKaCRSYCytDEdwnBIUNaZLfu/u/SEs3BZhxtVqtlMH4gj3t4KTD
	5jnVvxthtvsQaPLYit5GPGJVU7C4JZQqIl3xmJYh3BjHZKl7kUnLbDFucB/3SqNrMynNCuEkjTE
	kg5vfrSnuW2Vmnnh7R0GgUAFTP2cTbNHdczUA8NoAKJwsCPLdbbBV+DmNDwI475iZ6OL9Mugp8f
	3TQVC0cLAWPNugEjrJbVBPtD3IR4WMchSyD5RBmSuWqY3PN8l+n1nuZSfQj1qDECO8hmjnVBlgV
	sMsRjQjMo021/i5341Kkd5HZGc0/SjFczqkYNCNTOE6sFvl6LpXhvAk1rx5BCa2VGq9KId4a0Bd
	hcl7f1oh6nVdneTCEfiQe/0vpkvseUdFK0/yhei9DnWDRQ8CsE2nYxxLiuVa8CU5oDAkujIvspz
	/zSRHARne6
X-Received: by 2002:a17:90b:3d43:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-38ec648a194mr3330767a91.1.1784815502657;
        Thu, 23 Jul 2026 07:05:02 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm17870433c88.14.2026.07.23.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:02 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: daire.mcnamara@microchip.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	minda.chen@starfivetech.com,
	conor.dooley@microchip.com,
	mason.huo@starfivetech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	alitariq45892@gmail.com
Subject: [PATCH v3 0/2] PCI: plda: Fix IRQ teardown and error-path resource leaks
Date: Thu, 23 Jul 2026 19:04:32 +0500
Message-Id: <20260723140434.675512-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two related IRQ-handling bugs in the PLDA PCIe
driver, both originally found by automated review from sashiko-bot
during work on an earlier, unrelated patch.

Patch 1 fixes a use-after-free: plda_pcie_irq_domain_deinit() removed
pcie->event_domain while devm-managed event IRQs requested from that
domain still had their free_irq() deferred by devres, so the deferred
cleanup could dereference an already-freed domain. It also hardens
the function so it is safe to call from partially-initialized state
(guards IRQ fields against being 0, and disposes of IRQ mappings
before their domains are torn down).

Patch 2 fixes resource leaks in plda_init_interrupts(): several error
paths returned directly without unwinding IRQ mappings or domains
already created earlier in the function. It adds shared error-handling
labels that call plda_pcie_irq_domain_deinit(), relying on the mapping
disposal added in patch 1.

Patch 2 depends on patch 1 and should not be applied on its own.

Both patches were build-tested and boot-tested on a StarFive
VisionFive v1.2A board.

Changes in v3:
- See individual patches for per-patch changes.

Ali Tariq (2):
  PCI: plda: Fix use-after-free of event IRQs during teardown
  PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()

 drivers/pci/controller/plda/pcie-plda-host.c | 52 ++++++++++++++++----
 1 file changed, 42 insertions(+), 10 deletions(-)

-- 
2.34.1

