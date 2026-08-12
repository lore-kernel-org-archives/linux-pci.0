Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910733939D;
	Wed, 12 Aug 2026 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564094; cv=none; b=HvaK3GDE/XwZgK6Uj7SKeV9PhWJVFeq5EUYb6uR4MdDZPBCBccM3BRW1faf7VYn9QjylDTWZLQmfh+GeoOk4G663oS0RHZgiDyp1StItrnuyyf0wnbPgY9Heys91yU/exLg9iTCrH4A4jKtuO97UxL+8ln0uUHtEpzRy2OTlcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564094; c=relaxed/simple;
	bh=hfPp5qUq3UnRpRum4998OSH9p6TQHXyV3JC2811sDhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUs4aUonbXmQU2LUZDGUGiGJLbjTOVnTSW6NBKqHq6JzyA0FwQRFoJL40LxQ12SWqXNPQjtDNj1owpTEqsOyCv2xn9RoMKIS5MLEv+r5x48G7Z/yEheyM2SiDbdUoGgWLoA5s1yFFhFkM52eSUicXO/detSoWf4U6kpkhbuTAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/DwWoxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/DwWoxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E31F000E9;
	Wed, 12 Aug 2026 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564093;
	bh=SRlEjT+ZGm+In+nJ4F2h8m3BhoMao+VNurIbqQqu4xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/DwWoxSp9QKUofmGAS4UwFPVx8cKBMQk1g+Yvbz12ysOUq06eATeNntzShNjMjSz
	 IQYhKNgmjVisd/wISEXpSw5iqPK+GWlz91+M1NAtzEJ0E87PFetszhQMYBryYGlU9R
	 09rqvRqEdR8MlsidRu5GCp2+JMgHh8U5vy/ePwuT6ASFgrhZbkStci7Cuqs2FPbRH/
	 veM8clAYHoFn3fGvrhhREOlwdBP8k614IFWVXuVe9v4HLO89zrE/Zyrg0bqkaSMyrR
	 fKOj70CCPdwbOWzKl+5+jP5qp5AqrG4o9AmkhEldMix5LkeKIVZFfXyBbZZLzM+je7
	 7z7yj3G7azO/g==
From: Leon Romanovsky <leon@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: [PATCH RFC 1/7] ACPICA: Define PCIe P2P latency and bandwidth information
Date: Wed, 12 Aug 2026 22:47:38 +0300
Message-ID: <20260812-hmat-p2p-v1-1-75ac41380585@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

PCIe topology alone cannot tell an operating system whether traffic may
cross host bridges, what ordering rules it needs, or how expensive the path
is. Encoding this knowledge in chipset lists duplicates platform policy and
cannot survive a virtualized topology.

Define HMAT Type 3 as a firmware contract for directional Generic Port P2P
paths, including separate ordered and Unordered I/O applicability. This
gives platform software a standard way to distinguish unsupported,
conditional, and usable paths. The definition follows a proposed ACPI ECN.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/acpi/actbl1.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d824838cb7af..0fc766a8e90f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -2003,7 +2003,8 @@ enum acpi_hmat_type {
 	ACPI_HMAT_TYPE_PROXIMITY = 0,	/* Memory proximity domain attributes */
 	ACPI_HMAT_TYPE_LOCALITY = 1,	/* System locality latency and bandwidth information */
 	ACPI_HMAT_TYPE_CACHE = 2,	/* Memory side cache information */
-	ACPI_HMAT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
+	ACPI_HMAT_TYPE_P2P_LATENCY = 3,	/* PCIe P2P latency and bandwidth information */
+	ACPI_HMAT_TYPE_RESERVED = 4	/* 4 and greater are reserved */
 };
 
 struct acpi_hmat_structure {
@@ -2108,6 +2109,30 @@ struct acpi_hmat_cache {
 #define ACPI_HMAT_CP_WB     (1)
 #define ACPI_HMAT_CP_WT     (2)
 
+/* 3: PCIe P2P Latency and Bandwidth Information */
+
+struct acpi_hmat_p2p_latency {
+	struct acpi_hmat_structure header;
+	u8 flags;
+	u8 data_type;
+	u16 reserved1;
+	u32 number_of_initiator_Pds;
+	u32 number_of_target_Pds;
+	u32 reserved2;
+	u64 entry_base_unit;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_HMAT_P2P_NON_UIO   (1)	/* Bit 0: Entries apply to non-UIO traffic */
+#define ACPI_HMAT_P2P_UIO       (1<<1)	/* Bit 1: Entries apply to UIO traffic */
+
+/*
+ * The data_type field reuses the ACPI_HMAT_ACCESS/READ/WRITE_LATENCY and
+ * ACPI_HMAT_ACCESS/READ/WRITE_BANDWIDTH values defined for the System
+ * Locality Latency and Bandwidth Information Structure above.
+ */
+
 /*******************************************************************************
  *
  * HPET - High Precision Event Timer table

-- 
2.55.0

