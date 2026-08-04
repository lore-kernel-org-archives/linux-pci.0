Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82A47A0A6;
	Tue,  4 Aug 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871826; cv=fail; b=QjT+8jUoLzkV634XT+zeYiZJ2HzwmOPvz3dHXh+r1BBuY5NB5wXfmm/8MMnzaS0cxiBa72UrrgX+tyZUntTlxIhRwVnABdbvrbcfbVIzvVOLo1kVXAiBhxa2O/bLMiGAZQt75b4wIYXCGFTLn6+X8m7vlUQIpOyiFDcgI9aNnbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871826; c=relaxed/simple;
	bh=fGPNMu2iYZPIVFF2mIVAH/6vjqghjcQgnbb24smJud8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDvnHbeXeK+BXVdYfkm8jioRFmv12ZIDdXEWB36g5oOGlQT1u415kfiAhvuyQh6k0KyToDVPYmq6I6LJRhsD8Ms0iwE5nGgiFvu/ahdobm5BEVyka5XmeFIVcjKtjMen+/ddWWodvgMj25axYKakdugIJFKXh2iJSPVr1p3cqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6/PzI3Y; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6/PzI3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL8x9MZrD93ohr6XdMWBnDhMJmzIwoNflbLLF7qzSIgaeoWfU3tTGTaHhK/9AjU2qXYQuTis23AZelwxTXE++J17qfKZV1TWm2aVcmuiKuz6gHJFV+x+uWwyv3J5Nm3+SSMxP6+BhdsmDpxz6EIslRjlT+Xxz6TrRYA/Y0TNQh3LsZ7CywaYqVbN6VfW7qIna+w8e2WCDAR1SQPzlCw61t+NjrwsTWo0hKsVQrD0Ji43y9RjdHtsfdRFnhXaeG/Ztbfdy/IGhQ2/dkcdwdxEoUGjw9wPpHw5WqJ+6HecuECiAoJrH4yGyqy1Wa+bBHHeNuIPyii7Q52q/FSJXPxWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwP1xHPEOeENavXIULq37QvRoZhlC88QqryLrqHGttY=;
 b=hHyHlt7aAyWS4uGbTVZsdvri1EIJDT+scJUAqFhZRjmW4B5GsqyVfEbxSjeAx2BlnJ3L3Z9GcRJ03uNry0w8MZ3pHpY/spIxjT/o6ikiNUO61T6GX5+kmUQtPnPs+5BuV7lpbkI0tkcwMhtkqDare0kaI83nqUSU1DNvT1JUZe/EdijJ+nmUrXlPwHTTlk7ju5CD6ERmVJUgq4bpGmVKjXlTGjQR72F6seFFjptwCnOSBDcCsh5TOtq+MeM64FOErloSgh+8LI1w0pzTlTyJj4411saYPzKUX5sHHDAGT0Z3df3ZD2xm2FN7lANqIJgxguLgk8bZ+2vX3wk2mU5RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwP1xHPEOeENavXIULq37QvRoZhlC88QqryLrqHGttY=;
 b=E6/PzI3YenCngvA3PwxD+QL1ka33hmpDdNZ9c7KAGRwolWHuDhFm91tFfiOphgbzZJR6UatNGj+CoVdH8Des9sjyCcSQv3EatFHbnQvT6ZbLjKc2BGD8z0jGxN/Q1pNdqVQXDeYUuj7DBTekEWzRzVY9HHC4WeICGNrhEX0u41FkE3OXLcuYLhO5ZzP9CjLYRZ9aZq6qOfU4sG6AlKLJiwFkYTxviBVFn4Zz6pvPfAAsOga3LoKb3BqT3kdj5YlRnIJCzWH1qQ/GNRqKGrmxmRb6JvLXWd047MOCOHdfrY37tLBnyO6WF/W/GC+4hWrT/orksVT56aH7K/h0eUWfwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:18 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:18 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
Date: Tue,  4 Aug 2026 19:29:50 +0000
Message-ID: <20260804192958.1823952-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: f65480a9-0301-471f-bd90-08def25ed0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	fyueg+v8+MmDvvQO+er0tfCylV7oNiFORtH5ZT/oJU+Bv2+HNBv1i4uBUDqigDNaIz+fAAFRqNsBnUFQWbBFJEtVMfEaHJWeb1hV9BllZ7bzpASa8Kt2Q/UAtw6J8RuddXmwpZZ28P95Z33z45Fl+18zIPb44IQC9NcBuztETLqgacGS6orT/GovJLglx20lDwYgGuo2uMLbJoqjO5R6/4iUG+RtBRqVRwryU2AbYvtmH8VbtkPHpCQGco7Vz7sZtsYuTd0k8KXi6JJ1YH4h4IQ8uQ1O2XS++NIA/qpEdGShTUEh6c4PejdA4vLBZvPJg56rOQHesLMj8bXR3waCBd5BB3P4JfRufRLx3xYj9rsDJvhGYubivBmrU3Ri+m4qgS5N9CxeB3vwicZ6axENkjuldFq/9eJXoPm9inqdoVoA8nL+L8hIpLqpEsSVeP5vgwOlfuBIZ/npYvmDIAWhB16qf4WOmPwwQMrkaexf4+tvP7ITnwPEoyDQTlrQoNqQRorZMIcCRBLZRHLJ/JTxKXnZOtikE4etU6UbeSLogvNKXR7+SXc+/wdn5Md7twXeMsgi6vjYV3RGiitA/AASnt19AsacPh+ggyXMME6tbLV/ktW9GNv8qxQDKDSf+/0zen5h+2bVitVDjQbgzlMl0F9SwWLD0KiwvGLfd8SwJ7YIvxozCmqaaAU+eUW394EVmeDrMvfKCh6EXcTeQnLcyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qugtCU65DpxbkISe/spPHIEXrV+kOcVboCI4OarbTRgmXHtYkySluqXLXnRl?=
 =?us-ascii?Q?XgjDeY5DFo8QsEhyIBK5P8y7E+qJYq32ui4JuWDVDaYW3jRVWxxGAwLdNiN3?=
 =?us-ascii?Q?ZqytVjV9DoxPzYEihXkS+RFe3YcD1jOMyJ7k80DWlz2OJubvecs2pZLlU+ZW?=
 =?us-ascii?Q?DFxwXirT+1TYXsdr5XGtn467rUNzR7jZ844QsdHyIy2cJeafAYKbT5p8iEOC?=
 =?us-ascii?Q?paZNon4SsuWzX3bLiqCkNhAy9VsMNW0PhK4+NHJqJ1JIbVmceqhPg9JFAk6x?=
 =?us-ascii?Q?DxswZe/Q42UCOW9ly2vuOL8r6aPdAk+p9W+GTbnCwGJY6GOt+c91kJRobVfa?=
 =?us-ascii?Q?1YSPqOp1QpNbmKA2q24/J4BizHOacZSNVHviyDLIwuGsKuXUxAUYzohZEMAz?=
 =?us-ascii?Q?OdPB4Zm6TGEjbi5Z8WqOo38XkJoZj+uLrptKPlGm6mRbQXWNr2Ibaqnym97g?=
 =?us-ascii?Q?sH4km+7KpFwWq3ptruxNQXe/8WlYs+CpDtJFGyM+fm6zQdXnRQKL3iuIJ555?=
 =?us-ascii?Q?TphpW6fgtYlhVV1ydz33yo/RqtdWpPDUfiyfUv6nQUFjAiLq3kDfbYRYhauS?=
 =?us-ascii?Q?JQgkx/ueqkgHcUUz3xyGmaq4alCd68DU5Ug3RN35ZHYRMs+2oa9V8SNFxZjC?=
 =?us-ascii?Q?hNhEPfwWEY/1p+4LqVf2krL/jh8kfkF4XV4O3y2G4ODtKUQs1JOKKAcfO9EC?=
 =?us-ascii?Q?J4fTWvYjVLxxd9gpycZuiJaNj2dyF5rhBemz0v7rwHt7ToazF0Pqt8BFiSLj?=
 =?us-ascii?Q?BaHhYycpnm4HCFQ4kbuxBBBaSgHC7+mmKXk53KbtapksZsrM2fGo8Bio+QhA?=
 =?us-ascii?Q?NJDjOIASjS+4Dz7vUom/ihsMQUa4kqego6BMo7DUlovmMtn1UyMueJpQMaLs?=
 =?us-ascii?Q?je56sc9CymdWL9iqNQkYdu2BMU3AYOI6ipnkK0NCI7FF5Koo5eicwEnuq+kV?=
 =?us-ascii?Q?PFPGRL4uyilste5fCTIiiG3/RoaQj6kM9hCqnpEQyE4zvTdvF+AhPwYjA9FX?=
 =?us-ascii?Q?yJDlcrTRDj+OzczR4o5/ftB6MTT53JY4UFn5rzwUZPnI1yPAO9i5lMpuZqOK?=
 =?us-ascii?Q?XnjvN54jrlObXtxbXo/UhecT0X3+UgejPfwHOrtS3oaUNONKIIefqYVZkwV8?=
 =?us-ascii?Q?ZSFr03irZb4OfWa076G9QEWmo6z4q916OLEB2pnDrIlksT9uo/0xNJrxhgPH?=
 =?us-ascii?Q?m2yKm+/VKQAUga6iHOP/44fYWWPfdkSlsETvkCAuS5YtWxL6ZNb6xQ1EeQlB?=
 =?us-ascii?Q?SoaO8uB5U6yJIKAcf8wvT9ZxERPkr/x4EIUnrpE4B0lqQcHiIRTrTHdqMWJA?=
 =?us-ascii?Q?f6DLAmbnNWMDJjtAUAOcHsmBZ9peUYy1iZhib9auEG7hvQax2lJa/n5Nt9Wk?=
 =?us-ascii?Q?sDllMmKSFxUvbJa4CWC0muzQfPH56Q6CIi/mQtDylqUYZi3KP+dLMwW8Yw7r?=
 =?us-ascii?Q?LcFVUuY5mWinK6nMHljOh5+yHquu8Q41aBq+VBq1u+ykbXr2C1CM7Hz2zl05?=
 =?us-ascii?Q?GlWd0JkJdPycMIZhYbEeaVocRaoDzxAA2jLTzzKKd+gorEoFJWYds3UXiMAD?=
 =?us-ascii?Q?Cm023Ue4hC88Vwo8hkxIZMZmx7S4HK6X7kOr1sPrTjeX9LdRRSJO0KZ0uout?=
 =?us-ascii?Q?0YP0F3KmROhz5TeGjrnmZEs6rfSG5WQmDbiFR7/G/U07HbPbY6ZMa0mTGlVO?=
 =?us-ascii?Q?GuSC23EE46tNhmkhEjWWcX9p8ohjZOQ4+/rnPkimPnvRUs9wSq+yDsRtTtCQ?=
 =?us-ascii?Q?MyWwiu2Hrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65480a9-0301-471f-bd90-08def25ed0cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:18.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F98GYjlhXtB4HeuhScjH8eO4dXaXPLnze+jf17206ipoyAY6tyldF18fyQv6Ww7+lbM3BJr5Mf8OLICEJ7ralg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Add CXL core plumbing to refresh a PCI device HDM decoder cache when
decoders are enumerated, committed, or reset. PCI reset paths can use
this snapshot to restore HDM programming without walking CXL topology
during reset recovery.

The cache is populated by PCI-side discovery in a follow-on patch. Until
then, the CXL core update path is a no-op when no PCI HDM cache is
present.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 114 ++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      |  12 +++++
 include/linux/pci.h    |   6 +++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 6e132b4f092b..ec988e7b7c0c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -84,6 +84,110 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static int cxl_pci_hdm_info_match(struct pci_dev *pdev, int decoder_count,
+				      bool *present)
+{
+	struct cxl_hdm_info *info;
+	int rc = 0;
+
+	*present = false;
+	down_read(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (info) {
+		*present = true;
+		if (info->decoder_count != decoder_count) {
+			pci_warn(pdev,
+				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+				 info->decoder_count, decoder_count);
+			rc = -ENXIO;
+		}
+	}
+	up_read(&cxl_rwsem.dpa);
+
+	return rc;
+}
+
+static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	bool present;
+
+	if (!pdev)
+		return 0;
+
+	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
+}
+
+static u64 cxl_switch_target_list(struct cxl_switch_decoder *cxlsd)
+{
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	u64 targets = 0;
+	int ways = min(cxld->interleave_ways, cxlsd->nr_targets);
+
+	/* target_map[] holds the raw list before target[] is resolved. */
+	for (int i = 0; i < ways && i < 8; i++) {
+		u8 port_id;
+
+		if (cxlsd->target[i])
+			port_id = cxlsd->target[i]->port_id;
+		else
+			port_id = cxld->target_map[i];
+
+		targets |= (u64)port_id << (i * 8);
+	}
+
+	return targets;
+}
+
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings)
+{
+	*settings = (struct cxl_decoder_settings) {
+		.id = cxld->id,
+		.hpa_range = cxld->hpa_range,
+		.interleave_ways = cxld->interleave_ways,
+		.interleave_granularity = cxld->interleave_granularity,
+		.target_type = cxld->target_type,
+		.flags = cxld->flags,
+	};
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		settings->target_or_skip = cxled->skip;
+	} else if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		settings->target_or_skip = cxl_switch_target_list(cxlsd);
+	}
+}
+
+static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
+				     struct cxl_decoder *cxld)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	struct cxl_hdm_info *info;
+
+	if (!pdev)
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
+	else
+		info->settings[cxld->id] = (struct cxl_decoder_settings) {
+			.id = cxld->id,
+		};
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -767,6 +871,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -839,6 +944,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_info_set_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1058,11 +1164,16 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	rc = cxl_pci_setup_hdm_info(cxlhdm);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1097,6 +1208,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_info_set_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 85e895d9b31c..703285966946 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,18 @@ struct cxl_regs {
 	);
 };
 
+#define CXL_HDM_DECODER_MAX_COUNT 32
+
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
+};
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..a8e5cec96bae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -335,6 +335,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_HDM
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -562,6 +565,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_HDM
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

