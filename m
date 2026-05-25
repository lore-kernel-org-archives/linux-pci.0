Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695D3932E5
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748832; cv=none; b=ETAmmTknCoOZKh7fEX42E77tIGbS37tHV0tVd5MOYkSBS3YMD13HXT5rBxuob1prDWJko7MnmBOr4c8hTyRKAmjMxXfvQwSCNbvylX9lG28BaiHbfKFmkXfN/foGzvAVYAanzSGZoxlzrtSo17xRLAyD1INYyGmAbSdtG0fcqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748832; c=relaxed/simple;
	bh=EHVF3OoQ0xcoo1UWUU/e+4tWEOg9jKAhzWorS7fFAzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axc5dI7Rj8lDgFo8jo0sV9EZVTUrkyLP1ANiqcTRQj4agBQx66Eobvdauy5pAGe0i91MuBQ1sI9/xpbpPl1nDnRAbGMove/nDOPritCO0I4iZsT9zJztKdFk6XEAg7/NGTvNisoDfYJjBbgt8NfCQiT+phCSewaZmxf7NAM0ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jPRoFp2X; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jPRoFp2X"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a14580111so7481108f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 15:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779748829; x=1780353629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDF5x9QlmGVwcjggxZgQQzyaoVhgZDvbIBslvHYHL5Y=;
        b=jPRoFp2XdmVamiKavOSys6KkfDqHLDbwA6mlI6KpbardxPRAFwTiIG5J74CQQxgjFs
         gcK34cP8/hHyicSDw73a5J867uV6AznuO3pFw4MCIZ1bKXR6By63dKZbj8b2CKx1Lgsq
         8n4t+rVu9w9k8snQZRs+VMid3MK0vbcjMs1CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779748829; x=1780353629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDF5x9QlmGVwcjggxZgQQzyaoVhgZDvbIBslvHYHL5Y=;
        b=iY+oH+OrndJAlfGIyzZbn6zms7OsplZq9wn69itiDtev+ClakMzQtzUfkGsThncOXa
         9218MT75vQMibb3VdQ4orPsrhbIDo6wKgyzhF6x5tDVhAVLo3dqGI1c9ECH/IMTLspz3
         sME9uOE2A2L5IEndjy34pliPLsQ1XM5n3sh6/XJlgZYSvY1GKA7FIST+jyUFARb9UMMe
         CWeaWdDzrAtm/4jUHMYRJp0Tm9+6UGN0E3EMX4FXdJn5sUv2gNK4cpmMMYEAwe/GUTIY
         3zmpWQp2I2+nedMTmTKHJ4B8hgw5trBDDNhNSBx4Jiy0awQ9YkFNwiDSB6LkKIyHxgfG
         R+Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9n9U/bzaMQj9zdclvIL9YtgZNN5I/fwFI8jNurB+l0wxEgj9ducnp+K41Jf8rtB/QNJxQqAoJteU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgn7eqCMbMmdxd8pdoWxv0IjyNS7WL2RPIWwRY7xE2wqgGxEbG
	JxqbBrRzHqKR7ThiX9p/UQ1hj6MPp5TSbq0FUNF/Pw07iFZ5HFhLjGA/yD/d7ZbG8w==
X-Gm-Gg: Acq92OFJ3eXCCJyRE1ri9+dyYFa7iKHxrqfu2aS09Qaa7K6DAw9ACBFLL5sY3GRkaFl
	ROvvu7NqcrsBPR9G7/3cxTVx0sxo0IRoCqphVB4E5utRwmoHkQm5+UyxCh3Dfiqc1l0EuJ5d/vu
	RfFhdnatzkoQWAg5Dd92eLBX69iK/NRXVO1mIKxWdbUEp6JpCYHTz76/C2IBl82nAIruf639hww
	4vQXuttAoDtoUfMG8xvbr51pC3jR1yd9j6653aJjssKSer7b1nMpTDvjHKnjP/RT0hkx8yVi1ni
	wowDtADiI+hZJIG3mzHes5+wXb/L9g122P8hf5RFWBalq7ELO4c8+jGu7lzKHbxq5Z9PncYdKhR
	COVc+Vw9HHLtj4CgZ+pzklUBvDVga+ZXAYOBLat6y5VE33m57cVzI5XChispc8KOdykjmH5TXXU
	9ZXzMajoRQTqymq0NJqABdIosxzM1DzOv9MzMRsbONb2BDjR4mXHIqQiSMnAmuFlD40NxVDqnUa
	2PMcp1A8fiM
X-Received: by 2002:a05:6000:2412:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-45eb38c5644mr28199474f8f.39.1779748828975;
        Mon, 25 May 2026 15:40:28 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm26467837f8f.25.2026.05.25.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:40:28 -0700 (PDT)
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v10 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 25 May 2026 22:40:19 +0000
Message-ID: <20260525224023.2753569-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260525224023.2753569-1-dmaluka@chromium.org>
References: <20260525224023.2753569-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajat Jain <rajatja@google.com>

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joshua Peraza <jperaza@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..77f97e5fa20b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -56,6 +56,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID [1]: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695..9af1bab27841 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1430,12 +1430,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property used by Microsoft Windows to enforce IOMMU DMA
+	 * protection from any device, that the system may not fully trust;
+	 * we'll honour it the same way.
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.54.0.794.g4f17f83d09-goog

