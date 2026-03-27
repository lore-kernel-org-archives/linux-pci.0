Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2B3F54D0;
	Fri, 27 Mar 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628618; cv=none; b=aEdcy2UUohYJ7vIr/NGfpJombAbkuUh0jLsqklRH+sJ4obhPsjMf+vvE0KlfS+bCp9ewhM2HoA6XkB8LREsDRKBkmatSORjthp0kOwYQgWoyT25FIrzof4ffrws32zXAYhbgZREu91QV7N/UVxrYNNJEzhp9n2XX3OJCZqZ4Di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628618; c=relaxed/simple;
	bh=Yw2arDmH4MgdmE+FoKrycqUBPwKxZLL2Da+EzWHNEjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsyQbobnExCA3v1zUlUzCPYOwqouMDWkrma7P+vcavRLhUaSW2Ddq/8iJtae0JhF0y6GqVF2TT72W5N0KYBfm8yifEUCdSPBCy77KLYJIC3HbJb42dMe5c+Q7AL9UqRBiq34TOZ3VdffSw6HtKd6SVwo352PcZtk7rasf5N0OVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTRGge+t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTRGge+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628616; x=1806164616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yw2arDmH4MgdmE+FoKrycqUBPwKxZLL2Da+EzWHNEjE=;
  b=lTRGge+tzqKYuhJEbM9GHlTcPH31e+jeAjxtd70B5oOH6v1isTJhj3B1
   Ub8mrfgSD9150GNm4Rb/J0XT2S+KNnMsEr7C7fWnOo8TrbY+8HNOahfI1
   lnJeOUg+59tYuNoUqqPIMkf09yb5xwz5aETlvrgnZGBxEKJnvkwgt1H+w
   tOY7VVpsywCYRNIzYHCo7hpKrzOStK0wV2wCo5zhZp3ZPaSL5awaqwKCp
   rIP65x1muGAulY1ie7ozPHCu3Z17/AN8urzqdsJj7oLVfhvMT6Q3awFFW
   /bs2uSuwKsBUIuz/P/8zRhLPoNHXALEQrIKrSAB9dzcaqEVqtjTVm392d
   g==;
X-CSE-ConnectionGUID: 6wM+xWjLQr67XmYzX61TPQ==
X-CSE-MsgGUID: hVbxGcS7QHekOE2/X4HKpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565611"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565611"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:23:36 -0700
X-CSE-ConnectionGUID: OzketJJZS/OmPIQa/DKplQ==
X-CSE-MsgGUID: dFqNlNTTQrixRH4N3fGZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516280"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:23:32 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com,
	x86@kernel.org
Cc: chao.gao@intel.com,
	dave.jiang@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	zhenzhong.duan@intel.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org,
	xiaoyao.li@intel.com,
	vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/31] acpi: Add KEYP support to fw_table parsing
Date: Sat, 28 Mar 2026 00:01:18 +0800
Message-Id: <20260327160132.2946114-18-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

KEYP ACPI table can be parsed using the common fw_table handlers. Add
additional support to detect and parse the table.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/linux/acpi.h     |  3 +++
 include/linux/fw_table.h |  1 +
 drivers/acpi/tables.c    | 12 +++++++++++-
 lib/fw_table.c           |  9 +++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..e5b51bd46600 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -247,6 +247,9 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 int __init_or_acpilib
 acpi_table_parse_cedt(enum acpi_cedt_type id,
 		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
+int __init_or_acpilib
+acpi_table_parse_keyp(enum acpi_keyp_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
 
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index 9bd605b87c4c..293252cb0b7e 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -36,6 +36,7 @@ union acpi_subtable_headers {
 	struct acpi_prmt_module_header prmt;
 	struct acpi_cedt_header cedt;
 	struct acpi_cdat_header cdat;
+	struct acpi_keyp_common_header keyp;
 };
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 4286e4af1092..8dc60632faf3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -299,6 +299,16 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 }
 EXPORT_SYMBOL_ACPI_LIB(acpi_table_parse_cedt);
 
+int __init_or_acpilib
+acpi_table_parse_keyp(enum acpi_keyp_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg)
+{
+	return __acpi_table_parse_entries(ACPI_SIG_KEYP,
+					  sizeof(struct acpi_table_keyp), id,
+					  NULL, handler_arg, arg, 0);
+}
+EXPORT_SYMBOL_ACPI_LIB(acpi_table_parse_keyp);
+
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
@@ -408,7 +418,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT, ACPI_SIG_SWFT, ACPI_SIG_MPAM};
+	ACPI_SIG_NBFT, ACPI_SIG_SWFT, ACPI_SIG_MPAM, ACPI_SIG_KEYP};
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/lib/fw_table.c b/lib/fw_table.c
index 16291814450e..147e3895e94c 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -20,6 +20,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
 	CDAT_SUBTABLE,
+	ACPI_SUBTABLE_KEYP,
 };
 
 struct acpi_subtable_entry {
@@ -41,6 +42,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return entry->hdr->cedt.type;
 	case CDAT_SUBTABLE:
 		return entry->hdr->cdat.type;
+	case ACPI_SUBTABLE_KEYP:
+		return entry->hdr->keyp.type;
 	}
 	return 0;
 }
@@ -61,6 +64,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		__le16 length = (__force __le16)entry->hdr->cdat.length;
 
 		return le16_to_cpu(length);
+	case ACPI_SUBTABLE_KEYP:
+		return entry->hdr->keyp.length;
 	}
 	}
 	return 0;
@@ -80,6 +85,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->cedt);
 	case CDAT_SUBTABLE:
 		return sizeof(entry->hdr->cdat);
+	case ACPI_SUBTABLE_KEYP:
+		return sizeof(entry->hdr->keyp);
 	}
 	return 0;
 }
@@ -95,6 +102,8 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_CEDT;
 	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
 		return CDAT_SUBTABLE;
+	if (strncmp(id, ACPI_SIG_KEYP, 4) == 0)
+		return ACPI_SUBTABLE_KEYP;
 	return ACPI_SUBTABLE_COMMON;
 }
 
-- 
2.25.1

