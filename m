Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71931D371;
	Tue,  3 Feb 2026 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087218; cv=fail; b=MGUS4onrYgFaCtXJXLAQGiLG/cpDocvQrHVRxPAsxw+DxL9YU7DTBBV9EikdB/kohFD1mXpF7iZYyljXUmMI7Xssc9bMmgqs43naXlEPbRtQbAFc9LCf735GE0+sq1+3uB4jIN57fIKlvpkdUJKPY2FXLx0xoWoiT+LCSRyHhTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087218; c=relaxed/simple;
	bh=/iEz2ReaHrgT/Cii3k+YXRnIS3pYpi0y8Gpzps99CyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ14sQxUaHq8RbvJb9u5ld2E04fC3V93gAwIyjRaIKvPPi+uFWRKaoNYGWkn9sJmjYxkRKXekJi+SUqYgcwxs5UvkF4LqHyK6wRVBDuQQn3Gyfl1yOCFNvEOj2e7ovoa2ZT2gZk90dVso/hTFJT8LoHG1TK3ykOp3B00bx/wH7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1512AdRp; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1512AdRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYBozvHbBxVqiSXGhX46rgsrz52KG8dH0+uNJbGtm+8Vc3p48+ZJPUBnLgvqa7rTf6NcAgYCKU0TVgq6hm7QdDOROB9988fX67xivIwn95XlgqUygS48SDSvoCxNUBAhp35WTmV4D8uibqP1sCqr9khuAQOao/Lt47K3JIM+ofNp05KNQ1A0CiXBv1Ra8cBc6nchW4cSPU1g4LsS4ylC6fUZF57QaeTBUdtJe9pTJrM2RCZzA/KW3wFAuJYRj2HnKtVqxmXySJ/TbIncYCeY66tNCg0B58KnHtvIdsfRktSxKlPZOu5eOthIN3enQwuE0yewjkoZRBZbTazeMoquCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkft4yAa0lmXLUC/AymN4RiSkSUhznVOmqWMIHApiEI=;
 b=y2quki0peFBpTPk5hEV1HBMUDCvTqJXb8YcrKGMYQa29hnqt1RmC0NCzEL12Z37wsA6ebMeAi65wO0akMZOEccSJ8RpLRKcnePV/rlcx1WUV9gAI5ZDYMmAsddx38n64xXu7mUzbJBUUoGCqBdGL9hqo6dG3LY4JGZK1qQU3XY3NK+z/huFdy3XiFTyWU9scAs3muJRIjt4e8Bj/3Thro9tctTse406/ScGu/+3OFOZ3Lo32jqpgP9cVIUnmIDVE2UXcb43rCKUl+t7IHDPtsxs0hPwo10Qz31K7zZ/3/aGFmLYefylBU1LRgFENoOdc+JL6ms0nbBS9tyBZJ3wiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkft4yAa0lmXLUC/AymN4RiSkSUhznVOmqWMIHApiEI=;
 b=1512AdRpNWM8xsX08NUGMe6f+07+XyWQd2SlaGaiaPqWjevTJNCKAIU+348Jv/ItcpDhgSNSzSTwGkmEKVY/RMmbBd4Z2FZJ+IAN/VNTvbLJikLqrdrXLt0DCdCBW7mMMOzoWVo4jjPAgddRvm6YBkDafWGFfYTXr2fRL3bR+x8=
Received: from MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 02:53:34 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::18) by MN2PR13CA0009.outlook.office365.com
 (2603:10b6:208:160::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:53:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:53:33 -0600
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
Subject: [PATCH v15 3/9] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
Date: Mon, 2 Feb 2026 20:52:38 -0600
Message-ID: <20260203025244.3093805-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ebe582-8362-42b7-1e77-08de62cf6bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nslDcFhsRgaJjL6WCNjlL39LEVClyDwBxWHLs+8T48elTjc9idaXi9CiGFPw?=
 =?us-ascii?Q?bbA1NTkcLtSRL9iUIU99hbS3v8qxitbIO0O5vWoqXzi/9r8uAp8AlsTeVBFs?=
 =?us-ascii?Q?yvSaLeNb1rMIcQURx6hE9OKyrA9h/dPhCNLTnJmf3il6LDZ3dEvMjCnU1dGx?=
 =?us-ascii?Q?A20sVVMa3StQ0wRX34rmNqrTwDYzSR+ZtIPGj/loBH9YvfrRRU8iDVZJDjvt?=
 =?us-ascii?Q?CrZD704Vwc4JYeAfpUSHQ4DVySfX7Bn2Jy2JIZxAbY7s7DW2Kg4nXJXB0S/E?=
 =?us-ascii?Q?hu+dFBv1q8sfBH2Cbgmy6cPkSy1lf+8wikx3XN/cDdRO6cfqd9CwhEe5C0EP?=
 =?us-ascii?Q?7lDHT0F0u+n+nU1wHcFKbmDopTXAJL15+yqT03fRHySwZLHvDKvyJdaxZgNQ?=
 =?us-ascii?Q?liQ8GFI93WEXXv+x7y3L+I3kVqqw4XBy32o2zqtUbxr5QMD2iA+YWG3yVgBH?=
 =?us-ascii?Q?e/QFLKrP7O5OVSh7nd/d0HjVF+rJjUcOlQQX4n6G0Ov3wxCHnH59BdfWF8OP?=
 =?us-ascii?Q?JqbSr7n01XvPKl0tn70VUYoF3kSe4ALFuWdt6k4h0z/36wX+6EeH8DADvNHz?=
 =?us-ascii?Q?WixsLLWYxUif/zCy2ersVbyabhyFz/h//X5FUNqr0IfOTZ1UT0u53Ujg3gzI?=
 =?us-ascii?Q?i/YtCZpHPX0FuuHfO5jTZkq1MLOC3PHDWtVJCz24eWxekJyCskk8y7xpo5kh?=
 =?us-ascii?Q?806WpzTgJH97EfZ0x+BRKiUdUMqc2H7b9r3+5ahiEYzVaXu735z0xzdOwCo3?=
 =?us-ascii?Q?+N7/yfVlfM6a/PMPgMB1c42zBLdpcaUoGLb5IJQrgxL2zqVK3FjHQAA8bX74?=
 =?us-ascii?Q?97gRA1wRXPkxCofHjzlBh1CpuZ2XymYrDLZg1kgUybaj2+T9bfda3NQ8bEG7?=
 =?us-ascii?Q?hMtpS96UmRI+YFDBCgT799Y7VeN/msOmQ7badjqAij8L20Hr9ec1B+Ss4day?=
 =?us-ascii?Q?MVJeDRGNDZH4p94GEtqhHFb/0yfd8y3wjeMOMTUWZvZ93rFOdA0HkJMSEigG?=
 =?us-ascii?Q?WuTkT9rYbs5gyOQ9i8ek8oJAW5SPFKxAuyfTmmi7Q6SRMviWttb/ZhtDGwht?=
 =?us-ascii?Q?RG4WPf6ntZeJWqWLP9b/jv10CMxKn6FoDcHe1dPj6toz0tBTU2Mes3wyNVcX?=
 =?us-ascii?Q?v5GZ0rXfTuEXrHY+j6Nie+ZatTn62WZxDcPR+9T/g2sz07NxS99DYb5FY7sc?=
 =?us-ascii?Q?TuykacUWZVllOnQSJ66Ctn5HWSWHR1vF6dbU0aiA9JXEv2EF0ZrNPSLwu9ac?=
 =?us-ascii?Q?fd76pJU6/7sByOmctqQ3HidlkBvn/Fi4abUffOzoLbWDiqGFeKTZZZIsKxsJ?=
 =?us-ascii?Q?zNp8kD83+7wPmsG76v9j04v2YYElNnv3s5iJVJrAXc+oSGg70fJ694aEGIPl?=
 =?us-ascii?Q?hoTKS0e7oM1R9BAdam5OhQtox7WdonUcLnNXn57OqB/mBgXNW9weVkMVq3Og?=
 =?us-ascii?Q?4QSX8lbE18Fqo+zWWn4KSeHOiJ8gSKKgSL2QCrcAOo5Tb8xNVTMWYAiZMrfW?=
 =?us-ascii?Q?pzlMf/s2qA1kw5FSFlTE4MXK5b5zgwdcbEV+R4WmBjZrN3YVp2nwVBIFPZ8x?=
 =?us-ascii?Q?306O7kkVloQyJpm7vi3Z8NaMCcLMFaKAC8ezNEvE0KDM/957czopFLosLXFX?=
 =?us-ascii?Q?T3ANhEFdXPGHn3bqHwgo2k9cUeo15YUTeK5yKTh2pNAl4xPG55EpXiabNDLu?=
 =?us-ascii?Q?9gi6ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ABsI2UZp68cVY/lGOQvRInmkX+SxRlZwcEVGnEcv/tZSbqOCysnG71b9OxG3tlwvEYriZt2eH7JmPGkQA59PYGDkUyV5bLdSE86vrUv9EhkRdxqtkb0IwDumlGW1SkBBu8hVpP8uCnb6NriMuKTUmBz6+axCxIcM3co2HCp476z/9qOWT5Ob6yB4zKBueRDVnwYBrVcDbAE4jBR9KgSzNMb3lpzr6f2uDH58yuJMwPC1pedIoEmqcMC6aD3ZDz0hfjRwN/LW4jkyeczBziIg7PhL2ivMxL7J/vG8c2ZRekxol8Nh5TOReO99wAkkucZBlpv9vLKYrLBtE75HzPhq7gkuA6HmSxhTJUfneNIIBUrbQ0Ab8ZkpBiWbdb+RON8ElKn0hOVEQc2tzQMZ/MbLQ9DcJByD1Qhp6Oj24OIyYa8MpccDLuL1BgKObRdffe7E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:53:33.9304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ebe582-8362-42b7-1e77-08de62cf6bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

The CXL driver's uncorrectable (UCE) protocol error handling will be updated
in the future. One required change is for the error handlers to force a
system panic when a UCE is detected.

Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
be used by CXL UCE fatal and non-fatal recovery in future patches. Update
PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v14 -> v15:
- None

Changes in v13 -> v14:
- Add review-by for Dan
- Update Title prefix (Bjorn)
- Removed merge_result. Only logging error for device reporting the
  error (Dan)

Changes in  v12->v13:
- Add Dave Jiang's, Jonathan's, Ben's review-by
- Typo fix (Ben)

Changes v11 -> v12:
- Documentation requested (Lukas)
---
 Documentation/PCI/pci-error-recovery.rst | 2 ++
 include/linux/pci.h                      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 43bc4e3665b4..82ee2c8c0450 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -102,6 +102,8 @@ Possible return values are::
 		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
 		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
 		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
+		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
+		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
 	};
 
 A driver does not have to implement all of these callbacks; however,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f8e8b3df794d..ee05d5925b13 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -921,6 +921,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1

