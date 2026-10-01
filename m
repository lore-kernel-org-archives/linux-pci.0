Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC14D487F;
	Thu,  1 Oct 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846564; cv=fail; b=u1KCRDHV5sjbNb/5VMDzsmFdPNdfi0+lzq9ZFWIBtH9rtPqlGjbzcTQx/KFKEqb955YRDV2/tdg5cPzvzpRjf2KAL1c+xVOA8HsaJcGBUN6iOHm6GdOYNgUTb0Z0fF/afS7X1kDXXd7RlZfJTdEOV01CNXYv7/rA7O3jH7ZJyZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846564; c=relaxed/simple;
	bh=459InCpTmnTgW01varUkyudLo8kdKoIiDH21mc9Wfik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxIF/QFYX2M+ZckLC2D9JPvp1+fcBrlMln5JlgfgKxwixwmbTHdunt45E8dPxXXFGDmVuCfM2RLJlmAB+EpnWa7C0KEgYYnHfK6bUsGf4uA2aodYO7neznN9tthS+mw3Dsl0PRK14sWu2FYnSufUPvUFfaZoKxV8ReB6R53NNVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adACsXIB; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adACsXIB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9o46RGLb5JBpOUuvw15IRE6OMNpcsAPcfIH4JF3J8YyiUQE9vCUIsQD5HbXDaKZPQaD+Nn4EozOBikIvhYHkfviNNZJO8gFd5+/DYGRxE0YdA9i43eomMpQuXMsg/DuHu0Yl0VC3YAnjCktH30jdyu+pdpD6mTxxqsWuRMXgoqC4ZGnRzw4zBnB7h20dQGhCM3agsth8WHoSE/m80qN4jz+SH5HnNePCBiEqzXLQvjgAElDnWrU5bp0Ixxb+RQKQDsz8qpjXTanQ1Nmh3GPB70LbrF5AV1T0e86bFpA33eSZLKFwmo6ChuYx2smlod31dcXenjgg/XHs2frECXQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMNoD+XNwR9cTfftJ0/nf5NnQp7yOyycPkTleq1pUMo=;
 b=wx3zSGH0UEXy4Z14+f2tMrtoHsiSPwsvuUbduihTqek+dHq6e3xiz4LcNm+YnJi0K56s4bMtgtxAkN9yXvduVYjkoQhncuZz4t4tIbYek4vaBmFWhBouUDYPBh2PW7Ya+dGXPb5eU31O4OGaz2Y/RIUR6dXPOLFO1laPFSHAZ7mRY5q1cADEs3UJq9eCix7Ub3n0Of+VX9JUrlIdAJBzDDOJjaBRetO9nbjOIKjwQXaZ/+sDYpQzHboiLn4scVsJA4WbxFFCmXdHustdwjD8Xv8t8p0G7o5KPk/BflmcxMxJRJp2cWE0MzDgZXUzPx/e8jHPm10tSbkxHDzNs3/iDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMNoD+XNwR9cTfftJ0/nf5NnQp7yOyycPkTleq1pUMo=;
 b=adACsXIBvkx0r89JDe+3nhgygI8dnk+6XiudKLZC5846TQB7GmvwkZXHo9xjxVXIrZP3+DX3Ck567mVq27/IQft1wQCisBR4NnaEP4YNsDwrZgOoAymSUm3qiMe+WlOXdISK0O9UwpSNIdLn3zter6Emz2pmMqBkD7nuetpJu391BKBpwFqWVJ9fZc+0Ju/wW1gn6+LDEccBw3bWroaIew5hmcN+7fUXKpq8iK6scisBZvoig8jwHjSESyfkZh3m8DVh4C3sUh0kUL/kkDD+9/YxTKVrmbUJzubQMexM+a+ul9hrMEq0BgVvYbQpI8j+BRajzcTjFOrAdskhiXnihA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:22:36 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:22:36 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v14 02/16] cxl: Share CXL port upstream PCI device lookup
Date: Thu,  1 Oct 2026 09:22:13 +0000
Message-ID: <20261001092227.3004747-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aafb4b0-8cc0-45eb-09a2-08df1f9d87e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|921020|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xuApeH1WQFOV2NVwcswTC85ncRh+rKuIaJ5Nw6MiDZwqPFvIYDF8phe9rnTYn8+ut5T+QoJddhw3rEmcVYew/na6Exz6mwz9WfNPx3Oiba22a/589qpFmNRVdB+wrHjYTL0pUaf/kkE/pG3NtYaf6M3VXyfuv4JcW2SGFmBGoZUrsRpT8EFe9VVmZxCrS3M6NnaX7jtC5fBbx48iDvfI0hNfH99zEa8yq9pjweE2DiAnZSi1cXYMU3GXngZNjzQ3aBTc0a+tkh0VC+vnd8ppyLy9+5UTWUYrImh6jTznJUoDVrFHhVcCXNDPh3QOUUJHXfrpCtCTPkmfkZLPDwxGwDRVKM+YHdKnsqjdHMNeJeyGWzdeAUVL6FnsEJj9diYSw/rSbhW3vsS5WSfqfiVvQjX2EvM+l2wlkXaru+7Qp7DX7EXBrejSYfTxzutj6orL253sGc1OlSW9F+UdeDIZPKeMePJeSdGuTHBoszxl2Zp+JUZuancU6AVL1thI8tQ6F4kRTNH6lmOO2Vs2/4KKFuJnIJW3L5HWs8P4/jAK0hEheJm0tSoE6YGLnJtslW7eCDG3v+cnVf08Gx+IMyeTs3J0ST5OU9UlgvEX3D4067UvuEfz+EX8mBgcDtLxYbGI6CGcefsQcOq1rxEhrshQOseJiUzm0aGHsebBhEAOg5lt9ZZ2iAa6ivOyGFH97L2vLE0mol/ASv3RzTxoO0S5uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(921020)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFQHvi8gPhL6C1eNm5bgn4Bxmm2aG2jLRvW3Yxae9aEVaMWwa4yDOaQGT5OS?=
 =?us-ascii?Q?dp+WNF3QjaEcIEAmllkxa7iOttxgH7kt7MsPkdhud/b7zdRzZzLG8jr2wUe9?=
 =?us-ascii?Q?YtIUA6aHAXcmMepKZJIsqsQ7Pa36S2wftKdyhRO76yivMHu2uTh4dntOEmsD?=
 =?us-ascii?Q?4onUfq1wCW8Wh/S0CgO5LEHVIxS15JQ0dRzSh1GkxSJmHbeQG2n9QKibDmTn?=
 =?us-ascii?Q?BtfQrpVbzHd7k/CCFwiCAd3w+1kwyD/O/IY8b29jEz/HvyLESShbetESYgkK?=
 =?us-ascii?Q?pzSPYK9nxeCKN6eRboBHug09QwazZ2oX/PIgV51Ig4ZSJBqaEnCiY0SADH/X?=
 =?us-ascii?Q?uqJ4Q6c7T8upQDbfWu+7vSzjOylpOqAv6eUTr61mWEr0DI8MXDuYHZ5+wxUR?=
 =?us-ascii?Q?7vsBC0F9gQ/+4vncqj2Xoz44BOkxW4C+q7IzTPLwv4iZVmkLUHZUOUx3nLdE?=
 =?us-ascii?Q?C+izT1uUazOyRytf8zu+oJJlR+0ygUgVZZrvgBp095cXRSqNsUGkxCIFE1ui?=
 =?us-ascii?Q?FhyorF5ZauNxfv8+e5K98Tyq2AyYEp59SVrvfC3IpmmCqIoYgFwtX37g6Vro?=
 =?us-ascii?Q?PL4TPqjUROlHmjuq2UPzkmWeuPFlHVkLa1Jjo92PuTMd57NPUom6MJm4C3J1?=
 =?us-ascii?Q?P8F05FTKaWqDjT0rXZQu5QutPNuPwZk6nGbGT2BcDHAl4eu1oTWq+psXGJ6A?=
 =?us-ascii?Q?LraSIbKV/YmfIL/LuATy228nNNU2fk9LTrFyj4HiN7lsP9j/3JBSGMUvuBMx?=
 =?us-ascii?Q?wegTXYprLKICZzvVcaBguJZ0PAwtUVLqesnJuIT1qJ4wsXuCJlarj1Ay9Om3?=
 =?us-ascii?Q?0Q8vvmx+fwqLUkVbJEcJgYC1kOntiqOAwxPC8gdSnbtlfd+sxYi965ySbJg3?=
 =?us-ascii?Q?IcEbZiOMsNvhUP/AjsqWq7/h2ujmfAI1cleVJvxT6oT/vE3SO4R3Txa03NRz?=
 =?us-ascii?Q?St7V479ocmKfdzzd/C4+OictBpNIOFBKrstQMySUncQZlWd8y6E+BIzyEoIK?=
 =?us-ascii?Q?A/08gTAMYfJdcJO9NTeMhKpboXRnGy1k7wLpFRRKNWMsnTIyUABwq72QD2yZ?=
 =?us-ascii?Q?k6DrvwS2HWzZMskCyWZVaEW6AMN12q4exPtBJUX3sxpgZsooeQ6B+TXDpMIo?=
 =?us-ascii?Q?FX4O4h9tZTwmmEAsN3ZUfV+iqrOn9xI64XEdsSLMsYcnJP6a7l+ewiOkpeTH?=
 =?us-ascii?Q?c8ADgyhguId6fQKRcqHi+xtZRQMpbvsjPntsh2vjqklL5u+87c7mbQiTF256?=
 =?us-ascii?Q?oi/T4PPlyhahurHQR/gDsSfyDDJvhCIejVR2gmKP3qz8vcgx8K1tu9flJjAx?=
 =?us-ascii?Q?HNAnXdxZRPwNdzjms2ZunTvBT1+1fjZUeooYx1dWvJhLIh3BFN2MzxPzfkwR?=
 =?us-ascii?Q?w1GNARSKcGlxc0VehHMvMt7Z+wbqcExHaV5U0dvPMNmD7Y9QF13H2GF4imVJ?=
 =?us-ascii?Q?nVhqDN8I5jAvX26tysRD03H/a4y2OyLSvwxdEoJnAkllmH5KKqlOAtzeCWAH?=
 =?us-ascii?Q?i5TAqE2ifOIGQUO0pPdMv2lUxkdvZ/G96kJEU7Jt9um37+Rm2HmRKOJ/qzm5?=
 =?us-ascii?Q?91xw8U+QGJp3Eixefb+hjDOG4y8E7dOBOyhd2sAaCO8Tr0P8LgAQJL++w/MC?=
 =?us-ascii?Q?c6mYOWMBpn8PUsnC2vAPJsHtLFD9ztpR1vk9GyJPATW/+Oy+yS/jcV4cdt1X?=
 =?us-ascii?Q?eaJSay2gMveJejvYmgzw3HVtZ2YnhnSlTaU5z0W/tXzMsfIUqRzBI1Aju5p6?=
 =?us-ascii?Q?LrVUETjZkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aafb4b0-8cc0-45eb-09a2-08df1f9d87e6
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:22:36.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ5eQJwTJteF1pSmjUyqq4+eNbvHj3THpwYdRxjePDmOugE38vokVPC61xfARIasgtf5q5OgXFnwaW9MAKa1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

read_cdat_data() resolves a CXL port's upstream device to its backing PCI
device. HDM cache updates need the same mapping.

Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
PCI device to make caller ownership explicit.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 19 +++++--------------
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 14 deletions(-)

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
index 9d807c1a002c..99c8b02d42e5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct device *uport = port->uport_dev;
+	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
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
 
@@ -591,6 +578,7 @@ void read_cdat_data(struct cxl_port *port)
 				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
+		pci_dev_put(pdev);
 		return;
 	}
 
@@ -598,6 +586,7 @@ void read_cdat_data(struct cxl_port *port)
 
 	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
+		pci_dev_put(pdev);
 		return;
 	}
 
@@ -625,11 +614,13 @@ void read_cdat_data(struct cxl_port *port)
 	port->cdat.table = buf->data;
 	port->cdat.length = length;
 
+	pci_dev_put(pdev);
 	return;
 err:
 	/* Don't leave table data allocated on error */
 	devm_kfree(dev, buf);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
+	pci_dev_put(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
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

