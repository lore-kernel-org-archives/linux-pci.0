Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478348;
	b=vBd54toJYYqfMpMnjSKIZM1LRmQ8Tnh5Vc0QZurwbT8F+ObUhYiadQz9kMMQCBSLRCsw
	 qPwwsvvqTemKNtnqSXEd5xd4Jbi7/Tdq3fTuPHIK+UwSmaBeej8+g4YxH2ymc3btx1ZEO
	 cmxxkZI4Lo/T0AhDkQCQQOXXaH/tOz6pg/5hXdlmlnvdRkt6SDk8g0x12DmY3QQF4p+hk
	 G6l4Jga03hPkGdUdAnfIDJun57rS/SFD3yzX/Ti+yvhrP+YzNIVFVrA+qFdFpkoY5+m29
	 DiH/RQVeZKhtJuZc41oLhZW4fiHL50fEn9PelenMVWscawdlE+Vx0Om5FhXqWS7cOXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
	b=P47JsGWYOGlyI0T4VTv+8e4bBpzxSBLHAy0X7LAkYmwN0oqWgccitS+YHKxjxU0810iE
	 Igp/7Gcoa8kXdFr1rhMRqkkjN34WfnI/WYjNrDYvSGc/LI0BgvZWJ+OLPEK/4ODxvbHZb
	 NRIs6eLdGoyNqLbKQ2hvXm9VOPS3EUnOZshrcN3RnU+aDXX2E6VDQlZbjvZx0DxSgKn3b
	 HZoWTLp/Mqgrf8KxuXONPKg7x7ACP30MK3xa5YgTvgk+OMnz96beOZoUB5SCmv2b36ZUO
	 0st4PwU6QWgeC+AG+1xF8y9jtpUTCFzdpMT7ha5mc5iZ9bN7iduAzBxKvgKdC2VjuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZON0xTWL;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA9606A321
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01DA9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZON0xTWL
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso37519315e9.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795478346; x=1796083146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
        b=ZON0xTWLk3IMYJrca10pfovxXM0iWKflq555uqbDInVwekW26ykkAbQNj+OSeZnURI
         /CFZSmxIlyHAhDAI5IJDwxRCG10B5kLMDhOVXPmEhOcu3FsX8vv3g6ge4+eVpGVDrx1n
         jiOohaGRUB00c4q8cmxAX1bICo18wEg6Ijm0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478346; x=1796083146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
        b=T30PXfYtHgHBVPqm7mAOmp534qRhyQ70NIZd6ciASAk4grMvK6airTHbe/dz6x1vUd
         3nm6YyL6H9PafS9VcOnFR/qp3DXEnK9diFCcgny4WD3MHDB2b1XDlWp0V83air2S2U/F
         Omc3zMTFjsLQMZqdGfI9w+bXYskAgHt1nKWBzE2SvUg59dR+pk/YDdmA3Lnm0RRO9EVb
         cVKnNp1EwPOg1TQi2lK/eZjZo4bW4OKUAwhyHu3tJq19B6lxAlf1QMxHQcDFm6tuKBBb
         tX4pZBRAnpeA5yy/IqbEiGdFnJLYvFP3KEBJqx3BzjYMgLAP4AdxFMrXA94B/srVyCkd
         WaBg==
X-Forwarded-Encrypted: i=1; AL+hErG1uhkgklXUVIuH7x6B/v+SLmerK4A3AI8x6sN/U65CjLZ/dpeEsPYzHPwMiYNkek4FSju9xJ884uU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rwa5Wwl412mNCdFo7gvIZo9gbKWXtCYmZokyJVGhfjg/rwba8
	yjJloKz5WtGjzy4MNS4h4A4roC0l1SGJAYzPBb0Rs2kfpFW1O42Dy8wvhm/CA2SB7A==
X-Gm-Gg: AZFdTZf7T05XYYzqSr3coAHOD8tVD8TSqoPU1BmsZKUgeDAunUXrcpQZ4A3odBxy+hY
	jNe9vQ9QAE7NUjD+SDFz4vfw/PdVuSI7Zf2/FvT7CfukM+aruxKzXrd1EQu9gy9Sos5Vj29qgZE
	HLhuvS2eb+86fEamJJoqPoiVYLUtLbjGbdBPiYNsVl4Lt+sRp9ssh7wSUEsZRTqrSmNcwNEcLG4
	MY0kWNtjJ189Z2Gc+aI/8Lzwv7m+SwF3qVlDKZ6m0C+f411uK1UaDC3J6zwVh1QGDTqMOkZMhk4
	klevhcpKS0ae8kaypefanTGGDW/In7M/K4XMJ8t9iPeOQqQ2e9ZBIliofKUFPDzB1WwP+pG4kwu
	Sw5Bx1sGCoscVzwKIgw9agCaTLOSN53uKImo3cd8qjxm6fZidxz33Tjh5q7fmeS8236oOzM6cYd
	5Q+tRyT6iEyg7tgs0J0BK4Dp7ah079iSd1rC57sua8OxzjikcLTvhJ4IEP2pmOxwnxdOf7nDTaM
	KaHqV1K+GGUagFxKMTfJU283ydbp3guOTbpb9DOZ0BIj8QI4x/dXhSvPPbQWLTYkWHb6ZfXVsbQ
	CsMJp3+emGbL8KBbZAhvpfW4U/ywT364AKWzzsCf7nFSARiEnaiwOPNZ01RbsBQcMIAbzcSqWgU
	aWUYbVS4UI6KqZarOag==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr271555435e9.34.1795478346401;
        Mon, 23 Nov 2026 15:59:06 -0800 (PST)
Received: from dmaluka.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm25727068f8f.59.2026.11.23.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:59:04 -0800 (PST)
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
Subject: [PATCH v11 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 23 Nov 2026 23:58:28 +0000
Message-ID: <20261123235845.564027-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123235845.564027-1-dmaluka@chromium.org>
References: <20261123235845.564027-1-dmaluka@chromium.org>
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
index 1150f2fbabf4..5971ffc2a375 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1427,12 +1427,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
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
2.56.1.831.g720f3f5937-goog

