Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F413A4539;
	Mon,  2 Mar 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483846; cv=fail; b=ZVCZveksijPighX0UzU1YZXDHM/sVx1rlOEPCDKIgV2DG6iX/iGIsY3oxOKeiwp4ilJDdc0KRRqY5j5DeIig1hWu0PUnhWLr4UkqcGcPHy4yf8/ChzRlV+y3MI2Pi25d34xsfs4EjeGYDgoK6WCMXSjL4IehBsvEy6qG7v20DDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483846; c=relaxed/simple;
	bh=r8kX7Dh/zMGt6zv7PhA2Oag8ogqbBz/hQLYQPcf0btc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFpU+9VkFsbaZveuFIoZly/gHpkjsLVZIBh9RwT/68aoy5Et1DQqw++LxRC1ToEaeI0wJYtKFg2zDK3d8x8v7ICpL/u+/hNVa3oDQWC2qUOdMHMKO5rGcTzHTM3dCPojqFWi3WwHpEXDo7bBYb20RWj7nUVCDMMVAq8ETa9l4gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Imy71MjO; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Imy71MjO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz+pYyRTxgPL2nnUZwrJacHZJWo45pVgnRen3KZA9GiDafYwvCGjjVYdumoV1uZdMiUcf1hPUSAf71N10sO0dOqponpU2ZllW0hkhqfkTo2CThDHy6phxJpJbxiTa7MRknC75arFdyjrm1uErmPG0OP+RiJb4iNBryvDSyQ5PncFhV47pZG+nc+UhAZVdZDTLCPodY8ZivI9T4Okaw65ppIS1mlTjglxmQMo3Yn4d95MKHYqzRJ2Ti8nT4JUj5zYRQyQFer2Vc12vdUid8meC4ljx62aVPpWFirIjjNposFDAu7ShYjE5FYVfIZx+rFL+3IEsLveBqHK5ovHm75HMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjikMrQc6Q0Ymiu6JO247slY/oHnlObb9veXCdBHSGQ=;
 b=nRMIOUlNhaDokeP1mxnfKX64d4SakwCSyRfEpYlKCWB5GvYZmknEmi2buRJR4zT+k9QrTXFsnuitfLU4QY3N42xiBSXmBJ5m/floJhwNJIeU1NvdR6cs/8JO1T1i4UseQn3smgf8qHCfhWLDlmdF4V02PAqO6aVuOY8yxPZT8AaXkXYWa6S3mH2lyi05ZaAhgvM9BFV19fWRVdLtTOvAJKrkZ3EgNzsxPOJvbsa2jdgbmXNOiWjY/V31fNDZQzsE9Z0D2D+su5e1nUscGckmSuPKck6gVcYRLuUtwvnxLAXgxJp4cbt+bkKI1B0MjqevQeRq9O7GYO9KREvpuR5u4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjikMrQc6Q0Ymiu6JO247slY/oHnlObb9veXCdBHSGQ=;
 b=Imy71MjOvHMUoTBMQoGwqeGwIgz6bVIthxcqIBpPR+ZQIf0vs8qXDBsifCKkR2Zm1nblccWwc6ckT/6ciOclCUDP+MttEEcxvmtZEB9z+hvlktmROs09fSuYu6yfiNJocwX/jAAcUacnC1nuI5/BXtfNYizBI4prxdZWKymo0PU=
Received: from MN2PR19CA0063.namprd19.prod.outlook.com (2603:10b6:208:19b::40)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:37:18 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::27) by MN2PR19CA0063.outlook.office365.com
 (2603:10b6:208:19b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 20:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:37:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:15 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 02/10] PCI/CXL: Update unregistration for AER-CXL and CPER-CXL kfifos
Date: Mon, 2 Mar 2026 14:36:40 -0600
Message-ID: <20260302203648.2886956-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7d9d55-d475-4d11-4543-08de789b7e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	kzvlSGL05cT3K3n15AJZ06g3/MzgUiZa7JPtJl+/CmWSQXKYnp4jNYY9SBVfSIc0vg7iT9asRFuvVeeFm6A8upUg91O5HpSZ+WWK4/afov8oD1bfu8wi8/bqhu/OvVOcEXXaBfZ62vBmuQQjM6/wdEtFFXrSDSqRoRTiINaadXD9gYUENjblVbU7fQvhvaSdJxoXPT8fWmJNyZLJ0IeK0WHuUzSBacBzUJs41ebKkVubFpyfCLlTNRocUr0qIyOhAUqzDNGwZtxH2DOmwf2otGicLRrVNZkrUS3Q0kM1qFNA3n1adWNWqeBlF5cTEhjjocQiYX6cK+/iA/DK8UjdVPkTj67wGKEQFjjEFcplTPZuqNL0DPz9LMlHprEVIikKIWkPaJZjIGRhe9nyAoXFwpCi9WP+P0jLgF0HCGdtn9o8UicSnnpYfTFQMslXo3Ghx0FeeIcFwR5sy5Sb10OZHyJtqIhgjeOEuA5vFfnh9PFvRAvn7dWjr7IwZbBPJtXLq0GrSBbmI1sm0a15iVjbI7RFIrcJ7I5aMQkL07xudQlXLYp9J7Ejz4aFnF8f/RVXUNSmVwVPJzCWk2gO/b7mvRBaujL5bngf4P1CzngKX/XI6jSB683erYKtLpsX4iWt24T4cCiMzUo+KA5ktXaOv/S/Ou58GteUjpfsXAb6hws0QMQ9kJi0ICpODna5l8AleFEC4Kr6hhCJKyXVF6+/cJapY/Tlg/irBkC5bgfp/TyHMYAVIVioKe40t7jrxswK0O1V/nXD3o4URiSVRISsKNGvbAfM0TViwcl7OpAAW2N6ARbje96Vfar79aNcovBmhP0k6aZMgdl5cIpvkz/HpHahiWUatQbWgd6Xx1o87zc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PW1xnm7wy/iBY9ecq2Off+LDBT6KN8qQye/AYqVqzj92E4+7W2Gq7VpIG1tM40+lkPv8saMUnvodFB+XtHpSWQv7MvnknL8E1XkvFEMnkX4TyjootFf9v18Jplu78t7xZHA8QsG4B6pV1A+Ae4VwAOhBTJ1cGDjWakwooYWSaJJEtTYlFPO0pDnfqbRNSPEVNnzeD/gwq5axnO3Rs/EV8E0g98pC8nQGp6rV+t9lncWgt8Ajl5Hb4Hxb8ulXMNnEA0Em4nyGfo6ZUINpQverZGlAMjzlAIKXHl9/FTODwyJcOHffJ4zoMX38/Ii6kStxzEVzrbq4QUNUJTnJs61BEshfOuCM8dJNhVlVN0f46ECLKJ7fsfVgnTQvWCcu+OMbK6c4KD56R1UKW7Hsb2QVtiLuDorz0EJ88CczDAu77EG9oCtvD5Z2tLTEZ5bLa+fJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:37:16.5361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7d9d55-d475-4d11-4543-08de789b7e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

The current AER-CXL kfifo unregistration does not cancel pending work after
clearing the work function pointer. In addition, cancel_work_sync() is
called on behalf of the CPER-CXL kfifo in cxl_ras_exit() and should be
moved into the kfifo deregistration function.

Add logic to cancel the AER-CXL kfifo's pending work in
cxl_unregister_proto_err_work().

Move the CPER-CXL kfifo cancel call from cxl_ras_exit() to
cxl_cper_unregister_prot_err_work(). Release the CPER-CXL spinlock
before calling cancel_work_sync() to avoid deadlock.

In both kfifo unregistration cases, add the necessary synchronization
to enforce proper lock ordering: protect pointer updates under the
lock, and clear the work pointer, then cancel any outstanding work
after the lock is released.

Link: https://lore.kernel.org/linux-cxl/6982ca54e094b_55fa1005@dwillia2-mobl4.notmuch/
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Assisted-by: Azure:gtp-4.1-nano-key

----

Changes in v16:
- New commit
---
 drivers/acpi/apei/ghes.c      | 6 +++++-
 drivers/cxl/core/ras.c        | 1 -
 drivers/pci/pcie/aer_cxl_vh.c | 9 ++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8acd2742bb27..de935e0e1dcf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -776,8 +776,12 @@ int cxl_cper_unregister_prot_err_work(struct work_struct *work)
 	if (cxl_cper_prot_err_work != work)
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	spin_lock(&cxl_cper_prot_err_work_lock);
 	cxl_cper_prot_err_work = NULL;
+	spin_unlock(&cxl_cper_prot_err_work_lock);
+
+	cancel_work_sync(work);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 006c6ffc2f56..949d8c8ecdfe 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -124,7 +124,6 @@ int cxl_ras_init(void)
 void cxl_ras_exit(void)
 {
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 7e2bc1894395..ebca1112652a 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -74,8 +74,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
 
 void cxl_unregister_proto_err_work(void)
 {
-	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
+	struct work_struct *work;
+
+	down_write(&cxl_proto_err_kfifo.rwsema);
+	work = cxl_proto_err_kfifo.work;
 	cxl_proto_err_kfifo.work = NULL;
+	up_write(&cxl_proto_err_kfifo.rwsema);
+
+	if (work)
+		cancel_work_sync(work);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
 
-- 
2.34.1

