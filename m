Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736639B974;
	Tue,  5 May 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002316; cv=fail; b=Y+mq/mtNaZjrIjfYN5BE1fjELMJhOFk/7vbpemesZxZNcfg51knYjYZCDYjqNac97JB2rhb6xq8oRAMqCPAbQddjp3CTJyGtzFJVSM4LxSHfSkuqRc+JH1Z9u+Ld+TpeJJFbztiP9252HahOKCvOtan/i91FtKM89MfCLHrWnL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002316; c=relaxed/simple;
	bh=Ds8npAzcar3Zthao/TznG16aKCxu94r3PlpaCA6IdEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOz498vNINBxKNlNLZAdl1uldM8kmdJo3iO6V27tXWkJEEZpJSkxWr55VJ/BK5CR1U1MUJfgeNv8/8jFd+1fhd5FzGRXDYkxF9TglP7/5gDhzPihtMytHbNf/bumEqX5MfkH2a2R7fR7HUwuDNb3W9pkfpVqtoStNv54eGnoEdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhvfOfqk; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhvfOfqk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPhEk0I4gyYiW/LgVJMq66lhZRwAo1mS3kKoyoSj8JLZTafZ3macIJcY3gaC7HYEY/a8QF/iAlbUpLxih+1wi9LMuFxHatvReDtUcPIyuHZ6PqK1Nx53PPM27wSTg/58i33Qex1S+lKnhjXe3CyTNh3A6/nEDgEoKl8dTlzadn2KXJFxiKHkC5YIQDk1umNe/tKhamvROb0Gk/Tiu6IoUvl1dCZDtqn08LectjVkiTVmUfaN1Ail3LbDdegREKrQ/BXm1P1ivquI7PbQ1BhHoPhhzpHJH2/sTRT9gnccA5n8TRL1wjrT2G+tOXVfOOf/gCgStdvX+82t0KkyML5HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce6d5W0LDGWdYjVJoI2UFND7KzvAlS2yojimPS77/yI=;
 b=mvgQ+lCPU1Nt05Sjv2rw5zWa2oVfZW6lW+u3vevjqVoxjsYftp1HwhkLERZTgg8yDjADkbWDDPNQ5j+D9Zso3wBi70r/w7DN3s3oqHvYtYpkxAJxnrhml7F2RnjnQL6XxPUjC2rJdTIXwhCxAkUbfRdSH7R8bekZuCasmZVO3Ul5UNMMZhV6/AMOucYpg2rbAVxYhMx9fqTO9C2blxJHv/0K9rNo2pmau9lCpS8Psj7wLQ4u4+jebBNdXqC6ZmCvfPu0FrdmDCBt35oGUk+pozY5TWVvk/tbp4Lvqq4LfOjy9s2SJTQ012PGmSS4ZnH+CQyms3x6atR1aUvfUlDR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce6d5W0LDGWdYjVJoI2UFND7KzvAlS2yojimPS77/yI=;
 b=QhvfOfqk74POlWC6DLhUrwrrUjW8AkAn0bfSBBO0FyySmMLiZRsjd0IMwJWtS2Bl9uX2Dw3wntMDy2Anvr0Ftt4I6dz1Lgf2tedcabX//6q3BIx2gg1+aL4W46IIKagcPL6Np8Qt5Gq+ntHQUYYtYr3BWiszZuLETaVmqCa1iVo=
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:31:45 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ac) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 17:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:31:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:31:43 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 05/11] cxl: Limit CXL-CPER kfifo registration functions scope
Date: Tue, 5 May 2026 12:30:23 -0500
Message-ID: <20260505173029.2718246-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8483fcc4-f35c-4a5f-4b29-08deaacc2db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7gmflXg4nqnhhkNSOiuXSkQ6oiIg29O/Hy9zoV/rxicFwEWICtRQHYEvHE77gRo4DICEjZaACwBcI7qo0HZ2r+frSDxr7cFhej/zpbivPm8fGv/yKGm/5t9oGmQjBoIINn4bBk0jmn7k9dXVQ/gTbYv4wOH10dtauPMUiPDg+I85hjjDOC2xfumIN61jIHbqSar2SWJbz3nDEAEbPcCSEmyJAEmU3Y4TINP2ziGi1RCsCP8UXRxaCuut7pvQfpUel6/4qZQlmE25f4cxmjEaGRlIdE9aTtbm0Ah5p/TysjjJzTOv1ydkffR/MH1WcVl3J89n405k2LbEd4O+NBVhgSDN0jI7B0n+QgQd4+4OeR5f+Isl/+Sg+06k/dQzzLfREo9jBM7Tg9L/LtE4FGx5mr8qPx/oV0jKEmtRUOCySl/9gY/DPbG1WaTfiM0+hWMMCuWkV61iwAsEuL14CkOhh70aqqRYL6n6P7gV12Yuxmz/WkUGAHUnZ9LT1dzRXMmxpUnklXKYtcblI5hI2rS6Ic201kMua7TuJDoKmXIAufzCG8YNRU6YDk6gRUPkQTI+BCkz0JON0nKmvM83bhgTWOe0MNplL7072DdbxPDAPMmY864Rb7d0Gcof/3VKVrHWJViimDh0mLu5i9lyrfAW52UpxUI07QtIU9HDZEo+UTEmD6ijjQa/XfQpT06wCWywhrwUm4nldjggpvfouYhw7fBwAvw0HjadrIbHBCP1mQkJGAnWd0VCri2gO4q8Y+Hgh44GoZOD9JxpjOOJivieiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J6K12YN6jQzE5WGKCW+i27X9iVhEhY2eISEqfbAr5jXy8ogRUATZHN8fx+VqPelPIhV1z8SW1PDMgZSo+m7XqWZuFts+WnpNfeRqee495/oEv0le64NNR9FO2eccOKg3Gv3sUTZVJ1Ah8J75f8EcsBY2O8gO/DK4wLzYa/VQFpkl7FpWkuXL/3AU7IQ63+CvvWAri+/qVbsi2kCmjeBp5pzYgdaIwRWfGgxFvvXFKWgPaNpUQ/tawXXLlIT2SmB+JyTCDto5jKpVg8ikk2CiIIfdg4b3kexoMhDcd7F+r3PJ+w1Fu+5DuvCwH2inQkYy+OFpfKk6PerJqDIiqgcAmzE5/N3C2SUSKDwNtPYI3z48IyMbAnc+PlykzxQTe0iYUkYFNeBtSa2rb0wZk/6DFY2JJRTaot0UHEL7fyWRdYUM2hnugzbpwyo5SQ12Yx0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:31:44.9220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8483fcc4-f35c-4a5f-4b29-08deaacc2db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

From: Dan Williams <djbw@kernel.org>

Some CPER functions used by CXL drivers are exported using the
EXPORT_SYMBOL_NS_GPL(fn, ns) macro. This doesn't provide compile time
enforcement or visibility of the consumers.

This can be improved by using EXPORT_SYMBOL_FOR_MODULES() instead.
EXPORT_SYMBOL_FOR_MODULES() explicitly names the modules that can access
the function. This provides more precise control and visibility of symbol
exposure than the namespace macro. It also provides compile time checking.

To improve control and clarity, update cxl_cper_register_prot_err_work(),
cxl_cper_unregister_prot_err_work(), and cxl_cper_prot_err_kfifo_get()
to use EXPORT_SYMBOL_FOR_MODULES(). Also, update the register and unregister
functions to return void type.

Update the CPER kfifo unregister to cancel work while using
synchronization.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v16->v17:
- Split from v16 02/10 ("Update unregistration for AER-CXL and
  CPER-CXL kfifos"); AER-CXL half folded into v17 01/10.
- Convert exports to EXPORT_SYMBOL_FOR_MODULES("cxl_core").
- Change register/unregister return type from int to void.
- Drop work_struct argument from cxl_cper_unregister_prot_err_work();
  it now cancels its own work.
- Remove now-redundant cancel_work_sync() from cxl_ras_exit().
- Add WARN_ONCE() in cxl_cper_register_prot_err_work() for
  double-registration.
---
 drivers/acpi/apei/ghes.c | 27 ++++++++++++++-------------
 drivers/cxl/core/ras.c   |  6 +++---
 include/cxl/event.h      | 10 ++++------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..dd0a073af93c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -778,33 +778,34 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }
 
-int cxl_cper_register_prot_err_work(struct work_struct *work)
+void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
-
 	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	WARN_ONCE(cxl_cper_prot_err_work,
+		  "CPER-CXL kfifo consumer already registered\n");
 	cxl_cper_prot_err_work = work;
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
 
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+void cxl_cper_unregister_prot_err_work(void)
 {
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
+	struct work_struct *work;
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	spin_lock(&cxl_cper_prot_err_work_lock);
+	work = cxl_cper_prot_err_work;
 	cxl_cper_prot_err_work = NULL;
-	return 0;
+	spin_unlock(&cxl_cper_prot_err_work_lock);
+
+	if (work)
+		cancel_work_sync(work);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
 
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
 	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 56611da8357a..9193dac4e507 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -68,13 +68,13 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
 int cxl_ras_init(void)
 {
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	return 0;
 }
 
 void cxl_ras_exit(void)
 {
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
+	cxl_cper_unregister_prot_err_work();
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..51acedb0d683 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -289,8 +289,8 @@ struct cxl_cper_prot_err_work_data {
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
-int cxl_cper_register_prot_err_work(struct work_struct *work);
-int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+void cxl_cper_register_prot_err_work(struct work_struct *work);
+void cxl_cper_unregister_prot_err_work(void);
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
@@ -306,13 +306,11 @@ static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 {
 	return 0;
 }
-static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
+static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	return 0;
 }
-static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+static inline void cxl_cper_unregister_prot_err_work(void)
 {
-	return 0;
 }
 static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
-- 
2.34.1

