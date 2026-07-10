Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E113F6614;
	Fri, 10 Jul 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679074; cv=fail; b=lAjqQMJkv5/xHpWCDemLOsd6e0VpIVrHHY+8lRplZvDgEXk1Rqch6cqKYrbigIFNDl5cgIS3p9gz0VifJCaJCvjsELuh5MipN9B9MdMP0FbkAppVOUhEOObQp7il1iqtE8QBoWSFRQNR9CnZnMPj0rjiFD+oK6eApBy7nR4grzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679074; c=relaxed/simple;
	bh=jvLqPBAsqlm2KakTba0LtdZE2qOHakdn94Jmsysb92o=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ZQlwhSJGxn6Yim3b612sg/8SANX/56NK1Lwcs4V72fKm9s4z0SY4DiqS1+Y91S4ylEc9eYjGnweOBgiIY+YgtRzEoZQ4VxB4U81u1U0REIpBMxrJ0LYQ6kv4eik8f0Fmk2AEWk9+fg9TD26McfVHsQbh7MKoWP6nPXl/y2LcMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSt6fwJRIA+IBClpEUotpU9SoGtpr2orh1H39xSQfjf4q4jp1Z39otdBRNfwfpiNl0cXDNeNp4kmGRLEHsK+uHPLrrm+wgDXeVrc4HVGvH2MzxxWZvqq9hJHaKxEzWSOXVETS76CF83mvSvG2wlFPqHNe3ylGnxrz0DxFhQRrOBtHAdCZIwUOJgYcQNQrUIIn+4cAozQv3U7eQQ3xUSpuZMTaP70hq+xEAYp5DoLQWixPSssJRjcuAmLabuJYOpYc1OkzPnIoJOW5+1w38hJ+z9QlDI80wHCy+SihISKsQs2fhP/TNvQ+0k4sgPzSnpiCow1vM0Feyy0N6Bm4fewLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USw7k5506HVIZLaHUSWwo5CTsup53pCYZOYclfM3mPY=;
 b=EglFSur8fbEYLi1RTsnznfkS3pbqYZNRBmbANO1+p4EWx+wNiA8JBiGNizOApwRtbVvPTnxW4JcB5HvPWT87BU2WSBQwqQvaZjlG5conoMc3MH9ApUUaCN3oridaNEiU8pu90BysjhaN1zSCNgSk69VQFy9cPy+hBRafE5ABCEo85ST0N1Tya3MpntyDZ3vzoi+3c8g5AK5ufahbXq9R+sgTZmKENDOwYP/0AX8jlJlJr2IxIqeATF/BnHqcRxOyc1sdmr4DHcTXo1odqdLo38EJcbY0ET51W2vySn7dMNC6kQFFGKEjc3iMEllQDMTYugtVP61E2gjEBbMGe1Pmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB0968.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Fri, 10 Jul
 2026 10:24:17 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%6])
 with mapi id 15.21.0113.021; Fri, 10 Jul 2026 10:24:17 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
Date: Fri, 10 Jul 2026 18:24:08 +0800
Subject: [PATCH v2 v2] arm64/pcie/pmu: Add pci id for LECARC pcie pmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com>
X-B4-Tracking: v=1; b=H4sIAEfIUGoC/2WNQQ6CMBBFr0JmbU1b0oKuuIdhIXWAMUKbFhoN6
 d0tuDR/M3/y8v4GAT1hgGuxgcdIgeycizwVYMb7PCCjR+4gudS8Epw5Q8jctDKFfVUbpU3Zaci
 489jT+1DdIEpof7+wdk80y+7YqZHCYv3n2IviYP/VUbAcJS6oal6Ksm9eaOzk1oXm4ZwvaFNKX
 9Upe+i8AAAA
X-Change-ID: 20260710-pcie-pmu-5ef78c56c3b6
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brett Zhou <brett_zhou@lecomputing.com>, 
 Braden Zhang <braden_zhang@lecomputing.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783679056; l=1777;
 i=braden_zhang@lecomputing.com; s=20260518; h=from:subject:message-id;
 bh=fAUROks9DOPGJEcV9XJkUvctmpXE9AgfPJNRJnFVqMU=;
 b=eoL5PEeppyxBsZckjzS1Xg+H/DtBetYufuTHkTAgt14xdV92Ht4lyHKcGPWMPkuPRNfQ2wW42
 A+pYBN2zgXgBHUnocAflugR/vun4JkkmR23KE5Wb+AuFG01Jf4Nzubt
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519;
 pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
X-ClientProxiedBy: SH0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::13) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB0968:EE_
X-MS-Office365-Filtering-Correlation-Id: 07db9bb7-411c-4811-a929-08dede6d6590
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	vducrC1nfzUSsqH/JE3ydoP2+1S4Iw8aAGfisZieAudxXA5axpB4frVeVu4GaLexCY9uWvmWDvxYQE6soVsQiqr8wsZZk/vCOL0oOttxb9Zorq8zLp0n9/u98Mbukwjsho0Ml8n3atCdqwgjbErfrrp8TC6OeroOi1y4/Umr4pWJReGfVb2ANEBstmaIAoFwKKZbTvYEwB2t/tS/O/pyVbXtpaq+NaxwvGdo9o4ijVY3t/sOHBTEfzEO2ppsPUSLZliHUq03IkMdtyNNy8NJbRXsU4XR2suHv7eEc6kKQ6vYU+rgHD60zrMXneT2uSFp7veEOU2Lnbxj2XtncuAkqKsuGSKH1KKo2Yb6w0582Yplez/18gJYMp31X7BoCc4KOvrWQDfAAryFtdYxIf0RQ7/reLEvJywe3f5QkeoKJvcRZ2BuLozIQdJBZD5m1k++Ciq/3zbc9HufFOQS4PCI1sjOsWEyZ3Xc/uHX/5+c399EofIvVoXc1iiATYUIabDLLUjJfgNc+nIkASYqWtsaWdALc2+RIXmhTO88Ha+qjgrVa48M9Ny/PCtzRS8VqInY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09SQ3BjYU5HVCtxNVRDbUdsUlVUOXdreklrTk5KZUIrY3VXYWJWdWZCM1Zp?=
 =?utf-8?B?NGliWThuUGk0L0NUUnZScmh1ZkUvME9YbW1wbDZiRmVxbFdWQWNyQ2NOaVd1?=
 =?utf-8?B?eXV1cDVPdWprWStKNUFOZVZpUjVOOEJoRUZWMHY3QkhjWjAyYUZRMW45aENk?=
 =?utf-8?B?NzQxMkFvTzdBL2dIWnhEcHg3N3YzYUs1ZUtEbUJ2UUpXQ2tjd05hbWdqa2RJ?=
 =?utf-8?B?OXVKVXNrdlFVUmJKczJpVnZLUktRcU9JRmxGU2V5c1FHcFUwTTBtYVRxM01j?=
 =?utf-8?B?VEJ4KzhCbWtWMkZaK2paT2ozWW8rNzkwOEdhbk03aVVQWFFKVVZteDNWYzRn?=
 =?utf-8?B?K3gvT2RLMm91b2oxQ1J3ZC95MGVwS1RQaGdEU3VINlVmdWxsT05GTVpFWjVq?=
 =?utf-8?B?SHFPeDI4WTh4WDZ4MlFINUJTT3JCaXF2RTdKZUhSRzl5ekRhczZqbFVVU3Ix?=
 =?utf-8?B?bElyQnlFaVlBU2Z1cU1CV1dBYnk1K0NmS0dhdnJ1YzRaUk4wY09YQy9jSkxy?=
 =?utf-8?B?UzZPSkpGa1F0ek9OSlVscnhZbVVJR2M5Umt5K3JqdHlmOXRvcDlGK2lpOW42?=
 =?utf-8?B?VmYrMEhkLzFhSkErc3ZvQmxVdmV4dDlRbFliN2wvaGtKcU5CU1R1M05KUzUx?=
 =?utf-8?B?cEZqMlNXSkwwcGw2MWkvY3lsRjEzOVZZOWpKUGt6N2cyY0xGNzZqck5uZDVS?=
 =?utf-8?B?eHBVSHY5dmVBdmdVb0xIN1ZidzVsb3dnN3pWSU9SZkZJMUFBaW1yQmI4ejc4?=
 =?utf-8?B?QnhwdWx3TWRxWEVOUU1WYVBjNmVyRk9DYWsrRytMNFVkdktDZ0lPVXM5WW1P?=
 =?utf-8?B?Y0xLMTFxZDJteVVLTnhYYVIzK1AvbUR4S240YnMzUXp1OHlLOTFGeDFuUkNq?=
 =?utf-8?B?bzZKcmxSRi9HdWtwVG5qY3JEZ1VMT1pCaW1iWDZLSEo3WTVmU0Nwb3g4ZVJH?=
 =?utf-8?B?MThubURRcnhJZS81b2VnQXVST0tlY1lIY21yYmk0SGFXcGw4TEROMXV1dU1v?=
 =?utf-8?B?SFFTS29VK0ZVcU9HMjU2Y2V3WUdjbWFoejM4dU5tYjEwZUJlWE5BQUc1bERl?=
 =?utf-8?B?MjVGcWlLcWdUQXZDMkRpSjlhZE8vYk11bjltS1YweXFIdlJTNVdQdVBtaEJM?=
 =?utf-8?B?TWZhS0tRZzk3MFBxOEVLTFRaQXhhN1ArRFRGS0pBMVdvQ2RldHhKb0cyWVNh?=
 =?utf-8?B?UlBLbGtXOUR3SWl4d1hFeTBOZ1dxeWhHbU9ZUXk2bU8zMWhQMkx2aWpEcDlS?=
 =?utf-8?B?Si9LcngvYjU4Nm5sdXFnNVFoUUpzUEZYNTJqOWlVZjJuNmNnZ3JhaWRJVHJL?=
 =?utf-8?B?YWYyL29Yb244T1VKS2wwdkVkNllTcElTK0RCeVgxVlpKQXZGNFZMKzgzYWN5?=
 =?utf-8?B?REhiZDY2alBOSWlNR25IaTFMRU14REVzeW95dXA5YmVBRTBCczBEVWZHZGcw?=
 =?utf-8?B?WWdMakNiNi8rOHNaUzB3UzFSM0U1ZDlkeXVrQStYTCtTTE4xdXU3MHNpTlRn?=
 =?utf-8?B?S093RzBSTWNQc09wQ3F2STdnRHV1QXE2M25MZEtmQ08raE45Sk1zemExZ0ho?=
 =?utf-8?B?M2YyZS94bW81RnM5Q1pRWStwQTJ5ZXVlTlo5UUw1S3FUbnpCUjZ1bjZNZlJ1?=
 =?utf-8?B?UmhrdkE3MmFCSTExL1VnODMzKzZBOVVBUkxTK3JvdlNpNXR2amtOaVhha2Fy?=
 =?utf-8?B?M0R4aDJLdkxzeWt5d3NSU29HTHY1Ky9xdEpaVjZxOFlDUDZHSkdVcS96bWZQ?=
 =?utf-8?B?SG92K253dUFBQTRMWGlwUkdrNjdQK3J6a01JeElFeDBxUlo1OE1ReVJkK0dU?=
 =?utf-8?B?K3FjT2dZc0F6YUZ4Y0FnYnV4RjhtcnRLc1V6cEZOa1BiTFlBaHk1U3BMTjNp?=
 =?utf-8?B?ZU9GSm9KbkpOWFRvWThaSy94WmgvOWhUVlh3TUhtNDRxdzc4bFp6WnFWYksw?=
 =?utf-8?B?Yk5UeHNsUWo0QzYyRUJnRFFpc0FSOWpzRGRiaHB0VHVXZ25CYm1PYnl0Tk1m?=
 =?utf-8?B?bUpLRC8zK2kxV21WU2tCbWxqcHBmMHdNUllCcC9EZEgvQkY0M1hiMm51a0c3?=
 =?utf-8?B?b1lhWU8wUWVNa2U5YWZJdE5ROG9QQmJpU0F3VGVmc3VpcXRNUTVZZE5talNV?=
 =?utf-8?B?Z3RBaTg4bXVKdWUzZ0NsMU05T2Q5M3QzTVkvTFhSbWRlSXgxSHdnQ1pKOWwz?=
 =?utf-8?B?Sk5RSyt0UVZoWWhPWUM5WStwYjdHbG5ud2RwYUp0ZVdDbmlWTlo3cFowcklo?=
 =?utf-8?B?S0V0ei83SzhLTUJYMHVSNjFZNHJpeFpZQTh5cFcrN1F3ZWZ5aitUTHR4ZHhS?=
 =?utf-8?B?aXZmKzZPNjI4TG9CM0E3N2JZeXBBa3RJa3VlMjZxSG9SZDlsUkI2aHorTzAz?=
 =?utf-8?Q?idSIbjidPH7N+SkI=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db9bb7-411c-4811-a929-08dede6d6590
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:24:17.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I05MW1O7qU1YQIj6USuaWNUkmjbBgWlXnlE+pd9hT/Nlihz+XeZdPqcbuhtujmNyKY68uiT9XppOYTFUY27Sf/sUqnZu3BhbVGib5BKISG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0968

From: Brett Zhou <brett_zhou@lecomputing.com>

This patch adds support for the PCIe PMU found
on LECARC SoCs, which utilize the DesignWare PCIe Controller IP

Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
---
Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
---
Changes in v2:
- Format: repalce space with tab to separate the macro name and the value.
- Link to v1: https://patch.msgid.link/20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com

To: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jingoohan1@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/pci_ids.h  | 1 +
 include/linux/pcie-dwc.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107..eb0020f9d366 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -173,6 +173,7 @@
 #define PCI_VENDOR_ID_DYNALINK		0x0675
 #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
 
+#define PCI_VENDOR_ID_LECARC		0x0720
 #define PCI_VENDOR_ID_UBIQUITI		0x0777
 
 #define PCI_VENDOR_ID_BERKOM			0x0871
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0..1a31fe4db228 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_LECARC,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 

---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-pcie-pmu-5ef78c56c3b6

Best regards,
--  
Braden Zhang <braden_zhang@lecomputing.com>

