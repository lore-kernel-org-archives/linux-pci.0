Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AB4C77BB;
	Mon,  2 Mar 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483864; cv=fail; b=of61IkASBMyDXzSOScvFT8HjxUQqKq8UCfDmoo+tCxWwV3T1Xft6ulCu5MXDGFllsaNpjHR76Khg1sKn+zItvEG7OKDyhfAgmd+gdbGoKYRuJnGIpq5jhaQ6O28z3jZAUq00IX7pbA5vaIscpvcmJ9tmIBehIM3+2HfmzWtq83s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483864; c=relaxed/simple;
	bh=WBfpLdEuKlQhv2uOS0PmDNmF9LWL5aRBmt95glm8j2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQuR5l4nb0wDEpW00/h4rB7Guo+j5o73PHmgb7KX7Avy5jyYRxVmIk3ufxd0K6OY+SX3288J7G50iku9kt/Gbw1P3t8lIKiYRlo0+vx3sinwqjLIGuSywfOlDFV8fqg6A/GhJ4MyhnqBgJ54GILEYtR48W0sxCXxiUuTqrQxX2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c041nLwU; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c041nLwU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMw7coSVHcOExDROFz51KxYJS0I1MkPkmlX2OzZ3hjPw+3MLITsHoU2Kid9unIZfRE2qQQxIAAWTOuEih0QhLeDPM0Y7KhSG4xGAPMYBkFRnk2+NZNLrEpYkswne3PYbVa/BUJIFJcE53U8lICjYxKyRjmTuUTG6dR7cddBWsAnVOYJ0sKRd8D58ZjkAXvqBM80LM3LnhPUc22fsbao5wy+fRCN+m0SEXM+EQhjtkcg3FMl3eJv21q6Pv3gieIo7nfCYV+wGrzlS2pg3tDxpebmAJpwyFLnrcMO1auSQrNBJaZCMUl7Mc/4BBfcQ9tvC0VMxWXVb1ptUmBvdxiIS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdSGGtVG10bvOIEFRtGB9KoiWz+RmXbaxBCjkNXzM5g=;
 b=xctQM+85YdBOj/lKNC+DuiEHb9Fyk3DHPbETUB7pmhhv/5G6rW+hIIWzvJYbSmNTpZ7AbQdQmjXWSRmYcYm90gLVOlIK+NXyVM7WiEwadmI7fkYQBEvDTVdAkeskJi5bqxG5QVhKIBAr+mmREtr2JdNQgVCsooxnEOjES3gsOO7bkuoqSAUW4hSW4jXg/cYwmFLR91ebNmWfohDJC/Z3K1j5RYovmSU+Jf2MBzj8edhsWv4HEO8K7G5WF8x6wgHVTgljQRebahbtnOf1GLGNqECSxepUajGUIj/3eYRTeK9sMrIE53HxprxrlU+HRFwOiChJpmIKsy2iTqXw2/Pq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdSGGtVG10bvOIEFRtGB9KoiWz+RmXbaxBCjkNXzM5g=;
 b=c041nLwUdVObgTn3y6N27ej9vOVFVPoRsOLid7/X1ZZAX5XI7TsDX7qtVNz4BzJyUGE3vs/d93eljuhkQ1naXKoR9cgK1wFyZS0FaXe/hKGxko+ZNiNHFExQGWVj45bWaiMO5f9ABUX34s2G6v1wlyVjXzkPQmdMAzIRvGNFZz8=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 20:37:39 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1a) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 20:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:37:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:37 -0600
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
Subject: [PATCH v16 04/10] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
Date: Mon, 2 Mar 2026 14:36:42 -0600
Message-ID: <20260302203648.2886956-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: 59469bf4-f663-4921-076c-08de789b8b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	OcWD4J5BF6aNWC3gtUlEEQX9GkS82gBnbbxf8YYz2jRe8ee4euzyS+dc57+zIV+EmVb0VLTJ65NmR3ekr4oAaqEsRQngB2mk1SfHOZ+dSpOCfnuv+f1GNadVsoSvvziEVC3g4dGLTm562fNeqMg5CeKVLHdQyIGIcXwHyDXns+hugeUJxv/d3zpZ4gze3RxiYyeu7C2a7rU7fzMp251GDBlFpzXqGRZDQy8P7kdZwY4wcoEpqYZX1t/8gIWHCO6BN+Zf8X5ZncsbWnmGiem6kaCGUzj6RiBzZzxIrMcmIxkBeWXGxqQwXIMVH2uZEOfgZce3xSDlDuKRUMNUewvGoWDPM4omrqlckdhbeV1RNNYO+xtc7cdpV6ukQzMdwaftxr0uUipFDIQNIQdWhwdqCpVRWsbOHu5fuq6vDnVwJKQr0MyaEBxD64q3n+FzhnQyw0vMBRp2O6HmZRBd2ZCzhGfDavkfX9sjYBV5zPj5d7KWVQzM/BECPUMcFxLonPUYovST7U/na2K1l+aMyNlT/W0eG7F0HKLSnt+WN1MSpUyOntMRMo7qzSWe98J3IEEHBXLf9mrPExMoaJvAVNrlGCBCNRgwI85g+0EbWGA+YMsPBWZcu1K9LruY8u9jBwohUB9HWL36bG6kfoUV/DZhCpZGPsgnz1A0+3105WCR3t5YlJS0W01wDrnx6HdRFTFRGYxKki5D+CVqASg2c8Nz41CyXot5gpzENlFRexc6QljdQQVv6ibG9eTBvVIWArlnogRdwFr74Bv9NE4txfmFxk2X3yA8k5zlLKhXQV3spfu9ZUsb2BVRGUsCkqv21YxEjaCRr0PqtT+YdE/sZYq3fQXXTyPNp10Xw8pVw7WSDfs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MA6N+CCRJb9zhnAQjGLyCm+ODshQUZh7v6Yq3LsZLaQNefoXKejOokrasbkypXA2c/QBczsq0p6PgMEfNDcbhNXnHrpqQmUmlP1sjLBta7LqN0g57hJndbQ9qzyDtYCzltSwPvxUd/EWe+0c6ZF/evCEQi+jypVbirVwxf+WvOOGGck296SjoLagTJPnJWGU/QV9QPuF/rBMJP0CB9wDKE8oAZsoWALbaLOGiqo4SOnL9XHtSx3pC/DvFn/yOUns5h1v3WTU2BL1sV9FewpW47pO4gjSHSoKNadsrXt/xRoIah6X1TARm0viEszx7Z22nEKLyeNUkFCfrA9c583oVSk/u0w7yDzZ68SfXnbzU/tu5j5WyqzTHNosAV+PFH0P8MOeUii+s7fkTvOZykxSfLU/drD5zKaqSOwmNK8gGE3xeSteFx1ollujkNSUg3Lb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:37:38.7579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59469bf4-f663-4921-076c-08de789b8b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

The CXL driver's uncorrectable (UCE) protocol error handling will be updated
in the future. One required change is for the CXL error handlers to force a
system panic when a UCE is detected.

Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
be used by CXL UCE fatal and non-fatal recovery in future patches. Update
PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.

To clarify, PCI's merge_result() implemented in err.c is not to be changed.
merge_result() is not aware of PCI_ERS_RESULT_PANIC and will not return
PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v15 -> v16:
- None

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
index 43838723fde9..55be63f1a649 100644
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
index 1c270f1d5123..0d6ad11e3422 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -933,6 +933,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1

