Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893093;
	b=ynedN+iI/vtq9FTiE07PGLuynogKOn3sPfhgYlklVZLxm7rjaJf6Wd5KohY90riARd7m
	 ethVPOIQC9eOgvUvwRq/Wiy2vg51K2coTKTxl76PVqGvSEXWq0aCfXr3pjuOkmJNUxLmB
	 j0EJMBNE7/X1gx0xSEs/9qprd4dUWJKBDebZeNKTbMwY3VEFuhO196VePwzHbiMrA+LoH
	 vi56lcU2/ZMpGsVlNhoQec3FSimhg5TQAOLjfWLQcmp5O+UDJfzm1fcdWf+3JxW5I21Va
	 yRMW23y0lFcAsVeNsihWR6l4e4slfIY+EOXI+Z1bggs2gjUuS5g8GpmmcfdHsJJtfIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8y4St0IhZwQVyzFdSxU5JacHnztQsqHZO0Wii9zP/Z4=;
	b=WO8dvdQnqTM8OSpOZO4UNqG/EArtDvw59rq5dgfk6HwgM90/ZIbPnTz6MblcWk39vEgg
	 PfnrnmyNFy/ZLQAQgCH9tmLAad0/e3BqlGB3HMuNO+Qlr5/XI/52c3UWLD2QQiGlEG/zt
	 Ryk206iw2QE2PXCyWG4LkUMtAlLeyY4K4R6zdMb39om0d5KtNieIOfbUhHxRxHMwx4Bfe
	 dVncQhR7EQh7S28JxYf/INwXUXb9JPRkhu7PHf746Q9B+XVGxBMMkh4NuxT7zp6hxZugv
	 U9ne0KqMSu6tl1cyW2dykkqfczhOdHhy6I+FvMQm5ZfNsxmeJAgkPI8A3tIZ3QvFj6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=5KN60z+V;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FE606A332
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2FE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=5KN60z+V
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8470d7d430fso860142a34.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar.com; s=google; t=1793893092; x=1794497892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8y4St0IhZwQVyzFdSxU5JacHnztQsqHZO0Wii9zP/Z4=;
        b=5KN60z+VeUPIVPforSmLJZ4fHI39IfjWlQrF0OEOlpgnrL+kFR1BWr2JibCftcnkMv
         UtVTLtkzxm1KGtHU9g79wLkVn5n11rC90lH84cQCCd8Dkeo6bLW9SdmwpfyCEQbliO2b
         jhNxe6IGhhfuS3nmRM5fNugHo2WFpjiNOu9O1flHSluOpaeoVTW2GXoSk8jVDHbzuK+3
         hw11BbX8JGJCNzDELKe/j1/bz/DwOcPmFRC1qJfOaCsINUn9i/sLVUf1DaTT4PuS1K13
         gXGwvG4yTZ3bNqqjQrGoy71RHbtUkpRG9lC3Qic6R6mZk93Ax/Q/N/CQ+ukAnDhgcSwn
         z6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893092; x=1794497892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y4St0IhZwQVyzFdSxU5JacHnztQsqHZO0Wii9zP/Z4=;
        b=ROIN8W//7L9UDu3smebvAO/gZZ52v6iCkSG0x4EJF/2Wun5ooq93dpDADmdFMoHUCN
         8pW9ILwdexXCWtWmXTpkkFfYlAa0heYnjmCTAQiQueqyBu825IWsDX7HhbfCIOyyLFGv
         t2HqZZnS2XUXhHZwaLM/0/xrltK7HhRrkWvSQsjAN/2vP989ecD5JojFEO2oj3cmdzB3
         Y3MTxR0+nAr7DoaO+55pMGLqeZwJtGB0Kasr/zBv3BKqCBzgOkw1iqZw4g5bwhTXnWdQ
         bXc1NM9lHrKpReSu5ZJ+bZVMoz72WOplvEkonCkOaKiDGEfOHe0C44DSoo4X3kJSMTF/
         wALw==
X-Forwarded-Encrypted: i=1; AKwUvBxMcZjlq4+yIX/WWXGVN8c5nWYbjoJH3S5L09hVnWo7BOF7/FGT6N7krrZc0JwgQBw2XRzsNbQ6Y54=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XmfFWSlmWztep4Uq9Oz4zRSKq13xUAIMHwOqAgQOedUf5hOKz
	ChGByJYICWA4WZitctiLJH57k6vBTFZt9uZGTBTfyowdDPkJQv8jQzq9d9eAGGk61vU=
X-Gm-Gg: AYBFou3WvuEyIeq9fYR3VLrfVc9uTrERgllk/eiQkf7tBL6Tq7WlRQ5rdkQUtfj3qGZ
	sjrSHMigqHIog+6vSYNe/7JT7K9WwgYDUzHq8p0qYH97lchliTGJeBAqmMgexhC/njGSNHGpbuZ
	EoGRp+rPqOT97uC439JbhiLaQ0ycgmRXQsg8ZbMUIkg7NRjfRZMjKewF3IHid4Lsmd3zBx4lGbu
	aEieYzcaHLqwEFHoJXcjK/aXlv8nU91Pr42V0PoECbEF0f8bXAJaRunJVgasDCbJefStT3qpPbz
	a7gjjxC06g6H10ScYr0MyzPLyXXIajuHbQNNkOmF0agMOacfptzaOMDQ4p9Emxu6MFvmVCHkoUi
	OixxQqEG1Mvof86KWqnUfFoYU9wIBi1t2D7Z8W5EQvSiBqPxlCjPD863Ln9nE1GlHwd1s5Js2K/
	UbXxl5ye62ZEsYmXVznb6kQwmwfNzgcKTxkAjehaGrmaOwSHqadxeuiGQd8IjPo5alrcHNVPuBK
	Yp4qXbc/Axbl42EMcfxcQC/tqKi+CZFENmVuGO35Dd9pYcHmTyPp5EM6uaXLBn3UR7CXBFJIaxC
	wkLwGd1CuY1QU3vMOFEPQ0ldYRGsNBm8ilo44r01nzCTEZLEJxGH+3w=
X-Received: by 2002:a05:6808:4491:b0:4d6:9283:1bdf with SMTP id 5614622812f47-5640de7a752mr12836651b6e.60.1793893092182;
        Thu, 05 Nov 2026 07:38:12 -0800 (PST)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef6e3bsm4435329b6e.5.2026.11.05.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:38:11 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: herve.codina@bootlin.com,
	daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] PCI: of: warn on bogus device_type property
Date: Thu,  5 Nov 2026 09:37:57 -0600
Message-ID: <20261105153801.435566-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
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

  *** Bjorn seems happy with this series, and Herve has reviewed ***
  ***  almost all of it, but we'd prefer to get an ACK from Rob  ***

Add a check when adding a PCI device to ensure the device_type
property is (or is not) correctly defined when the device has
a non-null devicetree node pointer.

This series also includes three other minor cleanups to the PCI
devicetree code.  The first patch prevents a possible null pointer
dereference that Sashiko pointed out some time back.  The second
and third patches are simple cleanups.  The last adds the new PCI
devicetree node checks and warnings.

					-Alex

Between version 6 and version 7:
- Simplified the wording on this cover letter
- No longer check for snprintf() overflow in of_pci_prop_compatible()
- Rebased onto 7.4-rc1

Version 6 is available here:
  https://lore.kernel.org/lkml/20260924150222.1179235-1-elder@riscstar.com/

Between version 5 and version 6:
- Simplified the patch header on the last patch, as suggested by
  Bjorn
- Rebased on v7.3-rc4; otherwise no code changes

Version 5 is available here:
  https://lore.kernel.org/lkml/20260908213459.2519059-1-elder@riscstar.com/

Between version 4 and version 5:
- Made a local variable (bufp) a pointer type in the first patch
- Eliminated an unused local variable (i) in the first patch

Version 4 is available here:
  https://lore.kernel.org/lkml/20260904134607.1856121-1-elder@riscstar.com/

Between version 3 and version 4:
- Insert a first patch that fixes a Sashiko-reported issue
- Drop the final "duplicate warning" patch from v3
- Include "pciex" as a valid PCI bridge device_type property value
- Add Herve's Reviewed-by tag on the last patch

Version 3 is available here:
  https://lore.kernel.org/lkml/20260901011338.1323243-1-elder@riscstar.com/

Between version 2 and version 3:
- Drop a patch that made a change only needed by a different series
- Switch a function header to use kernel-doc format
- Add a warning if a PCI bridge node has no device_type property
- Added a patch to remove a duplicate warning in the devicetree code

Version 2 is available here:
  https://lore.kernel.org/lkml/20260812172247.276554-1-elder@riscstar.com/

Between version 1 and version 2:
- Check the PCI devicetree node even when PCI_DYNAMIC_OF_NODES is
  not enabled

Version 1 is available here:
  https://lore.kernel.org/lkml/20260807194100.455599-1-elder@riscstar.com/

Alex Elder (4):
  PCI: of: avoid allocations in of_pci_prop_compatible()
  PCI: of: drop the reg_num argument to of_pci_set_address()
  PCI: of: don't zero flags in of_pci_get_addr_flags()
  PCI: of: introduce of_pci_verify_node()

 drivers/pci/bus.c         |  1 +
 drivers/pci/of.c          | 32 +++++++++++++++++++++++++++++
 drivers/pci/of_property.c | 43 +++++++++++++++++++++------------------
 drivers/pci/pci.h         |  3 +++
 4 files changed, 59 insertions(+), 20 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

