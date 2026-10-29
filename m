Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285842;
	b=jgvnhGU3hefUYBLOZ7j8GQC0qSpVrVTO4XgVIhsO4+VdPG3YR5XolUy/aXsBbsTBvu9t
	 u8C9ORqDnYM/vT6uP0lOP3IUkplmo1xo3Q7dF7x5v8j/ycqRx/ju4dW3yDNMb7sH1Mnw1
	 9InNd7XoMGfz0xdBPk8E+6yNX49EJ5/3xOkWMTgKFh0cRpFXuxrViayJADSiSXGGFMTEx
	 wRC9iSVI8l1qcWQr23n1QtF/V6I6T9RjvR4I/Wmv5rvGYCxGB+5L10ix3qcHLVpLlIEla
	 GFsyly9X0dtxzToEDWzkDOoGeC3uSxztCzxpbbKkaFnHPOwfYJ7mxV6m2FMT2Lor0sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=g4y3+V+/dfJOcRoow5XT7oi9n6Fr5eEjaE5kcEHuO28=;
	b=A+7MSSYKuSHF0OrBzaxBOrGMi2qn6fZ6MaeUvJhGSJMu4cUjkS+juin4wgQnjXxv1mKj
	 Jd1A2UAvNZO2cAfpdgz3gU0FLsgIzWADBdSjPb7pLSAXcGoRr7Itkl/mnleFKFQciZmzZ
	 AKji16GycWqE/ifN+8k8n4q1fiM0wH78mtjC93asrg7YM1BY8xjIr2iu1j3iMu3XrpwZm
	 Q5EiZ8S8ZMX5I+Ptu56coZmICfMmjTcL0bO/OZzBpju9nT8F9OFUT+p4rTcdYXuc1+d6X
	 6BvCxZR7xkYo3qCjJJpq9sxpKdn2AK2op9UQXKDKK6wiamv2jWUE3yNyhhsrip4c7Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JCxLr9rl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FF606A32C;
	Thu, 29 Oct 2026 14:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2FF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JCxLr9rl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUgV86cMLjkubL/IkXyddd/X2nTdXRwsH4mzlRXZ1XQGPPcEl9KVrEZqsmgZCtSt7ulRRqWFQAnPhyDtpHhTWHXbm7coM1Dx4RBbCv2sCs0EiPiQGV+SJFQf9/FqAldDHYRUGsNKARC9Ub9BDJJpvLbJOqhP2TamoMKqaUAgd65rtgNPi78es7w6c7sGPpt1BL4xQynW5qN8wsVqdrxKkd/01qMfIJUwpjPW30leUv5onQtdta8fyePOKzTAuOD8p2EhoXuf3rY0CBfx6KnZxU6FVOgH4J0LZL6MGWR6asObZGNRk4PcrvgipttKHC6X59yo2ZUp6OGTR363IwiDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4y3+V+/dfJOcRoow5XT7oi9n6Fr5eEjaE5kcEHuO28=;
 b=HPDi5UIS7AeT0LTrXpj5Li2FwxkfQ4wb9ktOtIqFkUVb5ztbibOyRZr0iAkPgRiQ/tOOeLLpj9hLMPQMwBk0vACpNaW8P7Ff4Fhy1hITxcf+2a/5gkYvTXMarzLxk9e3QQ3rBZQnIX37G9Ll+1RNOjTnOTlHqwJOGNgfquOYPQRfGZWSOXVubdV9OdLU3Y/9d03X7atk4ZaWuwRWzhJA3PhccfQOR9ki7+YUtd5mdKuIhhj5sqNBh5quzqPv71jQU42cZ6pPJ0daoVcNoQ/0tQlP8oIFgvowpr7C3Vr9N+OBErGhGdIESmWYyYYvcZbelGs+9vDRi/eZnrupi3QBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4y3+V+/dfJOcRoow5XT7oi9n6Fr5eEjaE5kcEHuO28=;
 b=JCxLr9rlbMstYFbDGl3RGFXhTBWdh6Bn23kakYnS8ivi/4ClSOENdHFqx93Y/O/dopI+a+8+ix73fqFJWGr92GKzeyrZHdpqm5vQuB2LykHF99Zl8Mz3huuYmt8ctaLfLfP+a65z3d/StNBFt9yKjkHTLO7iVEyu+dOSlgCkH4Ta89K7V6v9H4sHANW/cAAsUfGy2f12lYmV72vokKJSlDlepdO48vblz8Tw9yusOFHYok5wOxDb9OKfsLzNg8w9iE7dz/HNItEeCC4r9GnIk0/Jt+Cpr7l2RYXemyiX4TZjae3E94ZXBa+2ygYIEQhdXkGdGQsfjXxugB+AHn2sVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:19 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:19 +0000
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
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v16 02/18] cxl: Share CXL port upstream PCI device lookup
Date: Thu, 29 Oct 2026 14:56:47 +0000
Message-ID: <20261029145703.2185231-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af2ef2-4716-4ee0-07be-08df35ccedc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NzpAMSSX77vKXdG3R3zf/fd3XvQH4+hbSyYImZOE+dccllH40/aTNtDMTtD4SLCKC5D0cOI6GMjBz/EXY086akbY1eM2HbJw1HWhSu4KTAAxNVKsiw0ssaXSI8EJZgqkRc1nZlbUgxM7IpgobUd8NWj6ua6d6+kJKlZcf2snBRsYJ6Cts4skoDY8bUpsHJwpKqLoQTIbJe/z1dfz5vFZ9npF/vsgqk3GcVXq5pyfnxWFFW86mR05/s68k0esy0vR+AGjxVcpvPHwReEBA8OKRgf3VV4RBgbNBADU2f7KSP2S5MA2ReSaX77vFVG/YEDpI01ccqTRt+G7TVDpC8fgCfzzFnxNpy/JLyiAdETnpvI/ROky96IFRkAjjKxbVXBpGZdUIW29VH9X47czM9rpHnl1Y4mIJZxGLwRHzKXk+5a0XSt5s9p7O2S1eYWMNq2hsir8kOHP+1s0m4AiGzFo1ExJXW0aVJA3+MLrA2yYe5RpXYGCWqeoJrplxKOKoRepSSk2iT/vidMxaUdg40KS3X5iVWw72uYtvGyIlJjM41KVbu3vtg2oyuE0TLPcekU9V4aoq2pX0+qE78jx9uS+fzPLAkdLVvfaVXjXogmxNwH6w9aUjsatdeZ2hfcICGMgETjM5IY+YVyvaEoCalMZmKUBNr+PTu6HX5gHaki02aUYBhWQSznw1VTe34LxXfqK3Es/LDUuAyF5XiLLPeYnEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9wLKDYmy+A2x/QmINoM99czkCekgPo3hv2CJf5TDzwObCIcw6g+cDVvTV1c?=
 =?us-ascii?Q?ph4xVJ3hyJp7WFfgkE5fipfs6WrmGIhbwKgWZqo8eRWADnUna+5e7NYUIH19?=
 =?us-ascii?Q?04wJ4oOJOnwx06SQToJeIfNBENJEVCoLQX34STuONj3cMDJY/cvAcj+2sfBy?=
 =?us-ascii?Q?iiGvATxe2+aGKEkh5jYBReKvWq0C2df8gC1H5khvsf22vfnU8EhiaP4X+qP4?=
 =?us-ascii?Q?fGhDZ+M8rX8xgJMg/wjPyKuFX7rtfz6H/XUY8JJAoSXlDK51Mw8iY7ERPfvD?=
 =?us-ascii?Q?0P8O2wa+2IEmjKo0Lyh9HPc1AO+0cZoi6siyFz+QIZjiri2+7vfyYcUR/E3k?=
 =?us-ascii?Q?FtK6p+mKt9ByrmuzBwHpgWDie2fi9GLrbQm0YPByREg79QOD7+7iK3LLGfIi?=
 =?us-ascii?Q?LhpzBC4pR2B8lekWTOwRq3ti4kc2JlephHmmZE3zsLsGBB7R0X4hZLY1Qu8M?=
 =?us-ascii?Q?BaZKwYX04DSAMnwXVjCzWafZSnvHnRCrVWFQvva3HK7fUSX+3vxd7EgNGHUK?=
 =?us-ascii?Q?Lg2bKxMWmIob4soyezXbSs0UISgcf4cf+nf05uh86hJdt0vkmCy3p/AzP746?=
 =?us-ascii?Q?tDJ2zA2tAghiuJdQ9sYblmEfBhZOeyUgfHSUGdZyWqVh990PQX+Ck0sag+MX?=
 =?us-ascii?Q?GCTUsPbxNIeQWzjehR4IHGcnUc5nXy9YMctP6PziWsxlqZDb6/tWHYTegaz0?=
 =?us-ascii?Q?NyiKF0u+Q84F3LgpDuvgg1+vlImSi9URT7B9fy7+On4njzlTSBLLsrDykGZ7?=
 =?us-ascii?Q?Lmc7cxDv6Ji/Pm0LU4blqFlr4usRqb3xpALQQducC+yMGnYnF3eNgJUIosvQ?=
 =?us-ascii?Q?bqc9es10TMpdKjzEIUW8ZfmDvs7VU1Y4FR+0dawGpDD5vSzIpf8DOR2hdfny?=
 =?us-ascii?Q?baj/4H2y16kEg3mA40uWstveSTTeSazyR8J0V/H+7T++tzJfOTdWeb4UxeSE?=
 =?us-ascii?Q?SOIQzu/Ur6OkKySDd6AQQ0Gq/JIwwQdr9FGO5EOPShZ1lryr1oLEAu+B1+F5?=
 =?us-ascii?Q?r4ZCOaWBp7+xcTiukzCgNcEm5vlIKTAkKvaR3mz/bdVNNGkY9LW6FFzHWFT0?=
 =?us-ascii?Q?5Lc2PTUYLtBqN+JNArtpLvLzdUwg7OfSCQ3NdF0p+Ee47Hz45RdEA3EtUtWj?=
 =?us-ascii?Q?tzZOfv9rpI+AN8RzGtVx2tP+pljPgsJUpxAfKR71T8KLBs60M+D8TAmj0f9Q?=
 =?us-ascii?Q?y+08r5iOKLUuov6R9mxsGDVZ73dRO/Q+owlZmQio0Hb7ZC4iXsSK5BUHPVwg?=
 =?us-ascii?Q?IkamN3+KGOpF4wYReBk+L3A7S73cx1I/2Q0nvC7UwXL+lu4KiXa/OFkGZDHD?=
 =?us-ascii?Q?4N/7zbj8cU9LfT3xq/TkBDZp4GpNwYMK3AouNrBxogYWJBOye/Ddoa6B2un8?=
 =?us-ascii?Q?MzQgoU0x1JBp4xMDYPjL9BgDdsw50PCWHKq8rsBl2oTYgCd4XcZk/DY571ZV?=
 =?us-ascii?Q?dbSSc8EBDpIh89vBwTr0j60JeZJUcCV4zGyOs+C99koxpb/k2ecTnlA5SbGO?=
 =?us-ascii?Q?0Ul/SO9diaCN6RkJuVeU9F1vR+QHMOPApfKfcarFX7yyFhWoMSWBoVvaLSDY?=
 =?us-ascii?Q?86NrUfWRyjjkE2Hq6biY76Dn8O17lpn3aklWCTUwF7a9zBT9PgBfR9qsW+NF?=
 =?us-ascii?Q?VEjRQxtqsQtO1a+i7hSk7WQsK7MY6LIpk/MMuFhnZUreW74/DomtHeWoPmhD?=
 =?us-ascii?Q?VFY/iEqK73XYfx8BJc+rODxQkO9OBIkMIWGdCLT4mxndZPbjdLvuCvAt5NSa?=
 =?us-ascii?Q?Qk8ZVFsaZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af2ef2-4716-4ee0-07be-08df35ccedc6
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:18.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dir83Vb1IyM1dPbp/EfpJIMy7cQNvnGky5LT1PVQZ9YczDijhMh5oNFh8h/Yv/b8W9uDaxzjEfNZNdFVzX7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

read_cdat_data() resolves a CXL port's upstream device to its backing PCI
device. HDM cache updates need the same mapping.

Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
PCI device to make caller ownership explicit.

Use automatic reference cleanup in read_cdat_data(), as suggested by
Li Ming, so early returns release the PCI device reference.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 16 ++--------------
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..983d7690c3a5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..c3c41efae5fd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -564,26 +564,14 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct device *uport = port->uport_dev;
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *doe_mb;
-	struct pci_dev *pdev = NULL;
-	struct cxl_memdev *cxlmd;
 	struct cdat_doe_rsp *buf;
 	size_t table_length, length;
 	int rc;
 
-	if (is_cxl_memdev(uport)) {
-		struct device *host;
-
-		cxlmd = to_cxl_memdev(uport);
-		host = cxlmd->dev.parent;
-		if (dev_is_pci(host))
-			pdev = to_pci_dev(host);
-	} else if (dev_is_pci(uport)) {
-		pdev = to_pci_dev(uport);
-	}
-
 	if (!pdev)
 		return;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..5dc2815d82d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,32 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/**
+ * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
+ * @port: CXL port to map to a PCI device
+ *
+ * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
+ * The caller must release the returned reference with pci_dev_put().
+ */
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
-- 
2.43.0

