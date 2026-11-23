Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478343;
	b=SFFy9ZgXqGIou016nOqOgOcEMC30EUOMnIH8K8Nc2OJLjHmTJ+MIcrA4iRQnXGJIVdYS
	 6GyqzwIYytyWjBSI+OTq7dPL1C9YEqJsFA+YcCCOP+N7da0NrzOMtzy+NLJSZaZFAXFr/
	 pInyGm0hjVU6MJnu/DnZ7MsphxrRxfT4NYpoD4aC/iuhIeJ25Extc9qTm9uBG39+PyoEU
	 BQEud6PgHT2GQxTEY1pE+s5iVEGinDfVkKHifYLvo8azUFjVafL+m//h64MvhodCOWLsx
	 /+fe42VWZTzKQA+L6U3ZHqCKmn3e/akCemsNDBGxSGWEO0OS1icVj6/B5F15TBPDmPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
	b=GqHmF5mxDBKwP3Hcg0Z1/3JWrr0ByXpNZ5DYqk+4nvDtm77+8GDlGjMLUC/f2aiuaiYp
	 zOCyAFcMheARiwLZs5xqCDDDuL6QhoKNrHQeMMH7gJlRJPhguy5Tfc7XfzwgbYn0ns4/n
	 P63wXSq/q300tzcX/JzUoaE/RfHlsJpx+8F/08B7/VY2UgGsXLIpy6tzRLlZiEN0iupy7
	 U//9rin5MbDTbGVdmJbN2CetY1/4bD/T+YQ00ONiFnOg6NlCrrg0pIowuqd1lI+wDRdFS
	 3EwB70LeP55Dk5UAhaHrXMr6dcEptYfSbhCceAGFLu9xvsS89HW9fu9OiN755hWKV8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=STikYJ43;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0637606A322
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0637606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=STikYJ43
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491846221ffso3287100f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795478341; x=1796083141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
        b=STikYJ43suh43QJ8vmzVNSCO6iCeQchd6lx48KeLmIArc+Ky8rT3PMBUz4QMWOruDU
         NcuTTu9xgibmhlmEE2Edb4vyhOWSpekv8xw1bJR5Uh9/3PAywTViopxhnvReTFs/4VGh
         zfnweL6t2DJJlHgkSGHsMmHykvfxa5y5MsbN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478341; x=1796083141;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
        b=AKPFO97d/EomDh0kl5tPaO4P3nJ42sRSWUoAKLRWuJzgM0nCfLMCWZloaw7NKlF4CD
         cKaU00QLy3n2MQ91K7druFOZ9cy/T8jah+tQ1jam+cVN3OSmFBSzzSInJIEX5HekKaVw
         mQihMpvyY81hR/PjCxnUm/+2i7RkyhgVyYY6wIn3+Frvk4xDHzfJ6AS49ax2++cJ1cXh
         muyeijLSIFsM2AFAzRIw/F4zsjX0e3WzA9zYwXNZO3J/nwGjv/zlfkV/cruC9fK/1SPD
         YBtH9NWbAj8gU6mbtR/Ov5ncg7PyancQHUaUvrv797Tv7nietZiOTS/qG1ShESCxxsyI
         JeGA==
X-Forwarded-Encrypted: i=1; AL+hErG7yOcV0HfX7Ap042Z/kK5x/VMx0hgeN1qNQOlH7LaAeQTFuHfZdcARwVZ/khejFG1261vgZT+aPoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l6No3Sxq7HB8uX1y6e3/G178ggUGhCbu8Czs/S2GbPIGPbOOq
	cbaBg+/KpvnW8V1MunZh4aG62eNFxMSPyV6dH/IEwJ3n0nuCFv+thv0Qb8ateZ/O3K4FaiP3TeW
	ep8g=
X-Gm-Gg: AZFdTZdX8nCqLws34P3IHHmkwzyjcJLlCG0WIyiPQc6kNPgR4aHl2HPkuF2vvSJuv9h
	FX2r7VG8ga7EeJUDYQi35+OrNj0XtS2VO54quO5QaYGCxHTeZFyX2EgDmt4Ra+Diq33ax0iFE1S
	3aXc7bdiCjVvY3Tyas0hky2iCmnQLRBob2bR3BjvaB048G9PxlyfL+gDFD9liIYIeey93XMSIJw
	tsRZLZZRDYn9ZerpkM60DqNYK6kwxGbz39eLsP5h8pe3efS4QE7uWfCGzUz/VvWE6Ysg1T2Q7Pd
	mD9oPqyevhcRnSm+idT1kKvIAvkmERQN2IGhpQWN2JQo9xnJaW18oWIa1ShHJtXDPv/vYzKLb9N
	ddoq7b6bvhbS0bLLzbm0L8WyXkHr8SS6+xGZjAAOf5FH+Wlz1M4HqxirKfXTCfgzba50PNIwfUs
	EE/NZJ0uBKIOpFYk9Rfz8uTPbEVqilo5/PNcQ2Nw/gKR5HP2b13gYNm70Xxgqz34bQK/pv/BU3A
	ge/LFfVLek/i7Uvqtc+KL65HFd8Zv8+aXfAHrqQcJQ2xRmbtnydUSWf005isoT+r1D08FiIktQ0
	qSwmNzcup05piJ95kfSVv6H5Hy+rrk3ajlNKldIth1bl3fV76krqLuX2rpSZLJhSAfEeHVcezU2
	gN7uSAO2iPTUL5Md86Q==
X-Received: by 2002:a05:6000:40c9:b0:4aa:f8a3:3cf6 with SMTP id ffacd0b85a97d-4abb3955aa0mr26517246f8f.30.1795478340984;
        Mon, 23 Nov 2026 15:59:00 -0800 (PST)
Received: from dmaluka.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm25727068f8f.59.2026.11.23.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:58:59 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Joshua Peraza <jperaza@google.com>,
	Jesse Barnes <jsbarnes@google.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Tomasz Nowicki <tnowicki@google.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v11 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 23 Nov 2026 23:58:27 +0000
Message-ID: <20261123235845.564027-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Resending + rebasing a series which was last submitted by Joshua and
  acked by Greg over 1.5 years ago [7]. ]

Threat model: An overview of the security implications of non-strict
IOMMU is presented at [1]. This change is motivated by “Case 1” where
a DMA-capable device is processing untrusted inputs, e.g. network
devices.

This patchset proposes using “DMA protection” to mitigate these risks.
This has the following effects, currently controlled by the
“pci_dev::untrusted” flag.

- Separate IOMMU DMA domains
- Use of SWIOTLB if CONFIG_SWIOTLB
- Disables quirks in Intel IOMMU
- Disables Address Translation Services

The “untrusted” flag was introduced in 2018 in [2]. The motivation for
that change was to enable using IOMMU to protect against DMA attacks
from externally facing devices such as thunderbolt ports. The patchset
introduces the “untrusted” flag which “is supposed to cover various
PCIe devices that may be used to conduct DMA attacks.” The patchset
originally proposes naming the flag “is_external” but is renamed to
“is_untrusted” and then “untrusted” supposing that it could apply to
more than just externally facing thunderbolt devices. The fact that
“ExternalFacingPort” is not part of any standard is called out during
review but also that Windows expecting firmware to identify external
facing ports makes it “as good as a formal standard in the Windows
world.”

This current patch series was first proposed in January 2022 [3]. It
originally proposed a new property “UntrustedDevice” which would cause
the untrusted flag to be set. In V1 Greg questions whether the new
property is part of the ACPI standard and asks who is making this
policy decision. Mika links to Microsoft's documentation of
“DmaProperty” and suggests that property should be adopted instead.
Greg objects that Linux does not have “dma protection” but Mika says
that this is the IOMMU. Today, the term “DMA protection” is used in
thunderbolt driver code with the same meaning and in an Intel white
paper [4] describing the technique. Mika also observes that Linux has
recognized several properties documented by Microsoft but not part of
the ACPI standard. There is discussion between Mika, Rafael, and Rajat
about seeking to align with Microsoft on the semantics of
“DmaProperty” for compatibility with firmware produced for Windows.

V2 of this patch series [5] again proposed an “UntrustedDevice”
property which Greg objects to because it is not sufficiently
descriptive, not sufficiently documented, and policies about trust
don’t belong in the kernel. Rajat describes the “untrusted” flag’s
current use, controlling IOMMU and Greg suggests naming the flag
“use_iommu” or “able to do DMA.”

V3 of this patch series [6] proposes recognizing “DmaProperty” with
slightly altered semantics from Microsoft’s documentation. Greg
suggests adhering to Microsoft’s semantics for “DmaProperty” and to
introduce a new property with new semantics instead. Greg again states
that the flag being named “untrusted” is confusing.

V4 renames “untrusted” to “poses_dma_risk”. Christoph suggests
“untrusted_dma” and Rafael agrees.

V5 renames the flag to “untrusted_dma”. Bjorn asks for clarification
about whether the semantics of this flag will match Microsoft’s
documentation. Rajat responds that Microsoft has agreed to update
their documentation to have aligned semantics, in particular “the
property is not restricted to identify ‘internal PCIe hierarchies’
(starting at root port), but to "any PCI device". As of today,
Microsoft’s documentation does not appear to have been updated.

In V6 Rajat updates a link to Microsoft’s documentation, renames a
function to pci_dev_has_dma_property() and uses
acpi_dev_get_property() to read “DmaProperty”.

In V7 (Nov 2024) Joshua re-sends and Greg requests a summary of the
history of discussion about the name for the “untrusted” flag and
justification of the new name.

In V8 Joshua renames the “untrusted” flag to
“requires_dma_protection”. Greg requests more information about the
threat model, what does this property convey, and why we should use
Microsoft’s DmaProperty and its semantics instead of inventing
something new.

In V9 Joshua updates the cover letter with more information from
previous submissions in this series and the “untrusted” flag’s
introduction.

In V10 Dmytro rebases the patches onto the newest kernel (v7.1-rc5)
and applies s/system may need protection/system needs protection/
per Greg's suggestion in V9. No other changes since V9.

In V11 Dmytro rebases the patches onto the newest kernel (v7.4-rc4).
Also collect the links to all 10 previous versions of the series in
one place in the cover letter for convenience.

V1: https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com/
V2: https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com/
V3: https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com/
V4: https://lore.kernel.org/linux-pci/20220320062907.3272903-1-rajatja@google.com/
V5: https://lore.kernel.org/linux-pci/20220325184609.4059963-1-rajatja@google.com/
V6: https://lore.kernel.org/linux-pci/20220426000640.3581446-1-rajatja@google.com/
V7: https://lore.kernel.org/linux-pci/20220426172105.3663170-1-rajatja@google.com/
V8: https://lore.kernel.org/all/20241118193024.2695876-1-jperaza@google.com/
V9: https://lore.kernel.org/all/20250221000943.973221-1-jperaza@google.com/
V10: https://lore.kernel.org/all/20260525224023.2753569-1-dmaluka@chromium.org/

Links:
[1] https://lore.kernel.org/linux-arm-msm/20210624101557.v2.3.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid/
[2] https://lore.kernel.org/lkml/20181129155153.35840-1-mika.westerberg@linux.intel.com/
[3] https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com/
[4] https://www.intel.com/content/dam/develop/external/us/en/documents/intel-whitepaper-using-iommu-for-dma-protection-in-uefi-820238.pdf
[5] https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com/
[6] https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com/
[7] https://lore.kernel.org/all/20250221000943.973221-1-jperaza@google.com/

Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.56.1.831.g720f3f5937-goog

