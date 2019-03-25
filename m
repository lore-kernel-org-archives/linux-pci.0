Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DBC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3660206DF
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553537773;
	bh=3gn64t/NwZsSLPwMmiq1vUi85k1bnfSws52h5Jvfh3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2d1lu3LqzgnfdbELi6ZJUhWPWWJplVC/DtWjNBXswX+0YHndv18gi4J7bV5NGochm
	 YB4GHHV1FwtIMPWEeylESxF6JcCIrJq2O72FPi3YChO6Ykdj5/qMJMpIK1+pGThDpS
	 nBve3ES31/G9J19FOqgU/eNQsd2hrjyI+J5io8e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfCYSQL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYSQL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 14:16:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB34206DF;
        Mon, 25 Mar 2019 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553537769;
        bh=3gn64t/NwZsSLPwMmiq1vUi85k1bnfSws52h5Jvfh3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sONH9R8OaEJdV27FFnkR3jg+BEuTnwqn5b4wv2LwgoCNVl6vMUUUDPDPcreEZ5jtq
         Sk10rYE0s9l226bRm8DGdL1niN52PvTiJ4ZG1TKs2qD3d+hZDVpE15Vf4cAlTHtZpH
         xffwBVNDr1z6rdbBepOwRlQhbEsN20vDGJQKNyTk=
From:   helgaas@kernel.org
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] CPER: Add UEFI spec references
Date:   Mon, 25 Mar 2019 13:14:24 -0500
Message-Id: <20190325181425.247227-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325181425.247227-1-helgaas@kernel.org>
References: <20190325181425.247227-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add UEFI spec references for CPER UUIDs and structures, fix a few typos,
and remove some useless comments.  No functional change intended.

Link: http://www.uefi.org/specifications
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/cper.h | 54 +++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 9c703a0abe6e..2f361a96dc76 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -44,7 +44,7 @@
  */
 #define CPER_REC_LEN					256
 /*
- * Severity difinition for error_severity in struct cper_record_header
+ * Severity definition for error_severity in struct cper_record_header
  * and section_severity in struct cper_section_descriptor
  */
 enum {
@@ -55,24 +55,21 @@ enum {
 };
 
 /*
- * Validation bits difinition for validation_bits in struct
+ * Validation bits definition for validation_bits in struct
  * cper_record_header. If set, corresponding fields in struct
  * cper_record_header contain valid information.
- *
- * corresponds platform_id
  */
 #define CPER_VALID_PLATFORM_ID			0x0001
-/* corresponds timestamp */
 #define CPER_VALID_TIMESTAMP			0x0002
-/* corresponds partition_id */
 #define CPER_VALID_PARTITION_ID			0x0004
 
 /*
  * Notification type used to generate error record, used in
- * notification_type in struct cper_record_header
- *
- * Corrected Machine Check
+ * notification_type in struct cper_record_header.  These UUIDs are defined
+ * in the UEFI spec v2.7, sec N.2.1.
  */
+
+/* Corrected Machine Check */
 #define CPER_NOTIFY_CMC							\
 	GUID_INIT(0x2DCE8BB1, 0xBDD7, 0x450e, 0xB9, 0xAD, 0x9C, 0xF4,	\
 		  0xEB, 0xD4, 0xF8, 0x90)
@@ -122,14 +119,11 @@ enum {
 #define CPER_SEC_REV				0x0100
 
 /*
- * Validation bits difinition for validation_bits in struct
+ * Validation bits definition for validation_bits in struct
  * cper_section_descriptor. If set, corresponding fields in struct
  * cper_section_descriptor contain valid information.
- *
- * corresponds fru_id
  */
 #define CPER_SEC_VALID_FRU_ID			0x1
-/* corresponds fru_text */
 #define CPER_SEC_VALID_FRU_TEXT			0x2
 
 /*
@@ -165,10 +159,11 @@ enum {
 
 /*
  * Section type definitions, used in section_type field in struct
- * cper_section_descriptor
- *
- * Processor Generic
+ * cper_section_descriptor.  These UUIDs are defined in the UEFI spec
+ * v2.7, sec N.2.2.
  */
+
+/* Processor Generic */
 #define CPER_SEC_PROC_GENERIC						\
 	GUID_INIT(0x9876CCAD, 0x47B4, 0x4bdb, 0xB6, 0x5E, 0x16, 0xF1,	\
 		  0x93, 0xC4, 0xF3, 0xDB)
@@ -325,6 +320,7 @@ enum {
  */
 #pragma pack(1)
 
+/* Record Header, UEFI v2.7 sec N.2.1 */
 struct cper_record_header {
 	char	signature[CPER_SIG_SIZE];	/* must be CPER_SIG_RECORD */
 	__u16	revision;			/* must be CPER_RECORD_REV */
@@ -344,6 +340,7 @@ struct cper_record_header {
 	__u8	reserved[12];			/* must be zero */
 };
 
+/* Section Descriptor, UEFI v2.7 sec N.2.2 */
 struct cper_section_descriptor {
 	__u32	section_offset;		/* Offset in bytes of the
 					 *  section body from the base
@@ -359,7 +356,7 @@ struct cper_section_descriptor {
 	__u8	fru_text[20];
 };
 
-/* Generic Processor Error Section */
+/* Generic Processor Error Section, UEFI v2.7 sec N.2.4.1 */
 struct cper_sec_proc_generic {
 	__u64	validation_bits;
 	__u8	proc_type;
@@ -378,14 +375,14 @@ struct cper_sec_proc_generic {
 	__u64	ip;
 };
 
-/* IA32/X64 Processor Error Section */
+/* IA32/X64 Processor Error Section, UEFI v2.7 sec N.2.4.2 */
 struct cper_sec_proc_ia {
 	__u64	validation_bits;
 	__u64	lapic_id;
 	__u8	cpuid[48];
 };
 
-/* IA32/X64 Processor Error Information Structure */
+/* IA32/X64 Processor Error Information Structure, UEFI v2.7 sec N.2.4.2.1 */
 struct cper_ia_err_info {
 	guid_t	err_type;
 	__u64	validation_bits;
@@ -396,7 +393,7 @@ struct cper_ia_err_info {
 	__u64	ip;
 };
 
-/* IA32/X64 Processor Context Information Structure */
+/* IA32/X64 Processor Context Information Structure, UEFI v2.7 sec N.2.4.2.2 */
 struct cper_ia_proc_ctx {
 	__u16	reg_ctx_type;
 	__u16	reg_arr_size;
@@ -404,7 +401,7 @@ struct cper_ia_proc_ctx {
 	__u64	mm_reg_addr;
 };
 
-/* ARM Processor Error Section */
+/* ARM Processor Error Section, UEFI v2.7 sec N.2.4.4 */
 struct cper_sec_proc_arm {
 	__u32	validation_bits;
 	__u16	err_info_num;		/* Number of Processor Error Info */
@@ -418,7 +415,7 @@ struct cper_sec_proc_arm {
 	__u32	psci_state;
 };
 
-/* ARM Processor Error Information Structure */
+/* ARM Processor Error Information Structure, UEFI v2.7 sec N.2.4.4.1 */
 struct cper_arm_err_info {
 	__u8	version;
 	__u8	length;
@@ -431,14 +428,14 @@ struct cper_arm_err_info {
 	__u64	physical_fault_addr;
 };
 
-/* ARM Processor Context Information Structure */
+/* ARM Processor Context Information Structure, UEFI v2.7 sec N.2.4.4.2 */
 struct cper_arm_ctx_info {
 	__u16	version;
 	__u16	type;
 	__u32	size;
 };
 
-/* Old Memory Error Section UEFI 2.1, 2.2 */
+/* Old Memory Error Section, UEFI v2.1, v2.2 */
 struct cper_sec_mem_err_old {
 	__u64	validation_bits;
 	__u64	error_status;
@@ -458,7 +455,7 @@ struct cper_sec_mem_err_old {
 	__u8	error_type;
 };
 
-/* Memory Error Section UEFI >= 2.3 */
+/* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
 struct cper_sec_mem_err {
 	__u64	validation_bits;
 	__u64	error_status;
@@ -478,8 +475,8 @@ struct cper_sec_mem_err {
 	__u8	error_type;
 	__u8	reserved;
 	__u16	rank;
-	__u16	mem_array_handle;	/* card handle in UEFI 2.4 */
-	__u16	mem_dev_handle;		/* module handle in UEFI 2.4 */
+	__u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
+	__u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
 };
 
 struct cper_mem_err_compact {
@@ -500,6 +497,7 @@ struct cper_mem_err_compact {
 	__u16	mem_dev_handle;
 };
 
+/* PCI Express Error Section, UEFI v2.7 sec N.2.7 */
 struct cper_sec_pcie {
 	__u64		validation_bits;
 	__u32		port_type;
@@ -538,7 +536,7 @@ struct cper_sec_pcie {
 /* Reset to default packing */
 #pragma pack()
 
-extern const char * const cper_proc_error_type_strs[4];
+extern const char *const cper_proc_error_type_strs[4];
 
 u64 cper_next_record_id(void);
 const char *cper_severity_str(unsigned int);
-- 
2.21.0.392.gf8f6787159e-goog

