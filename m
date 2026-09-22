Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AC51588F;
	Tue, 22 Sep 2026 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066378; cv=fail; b=kZs8wyEnu5UZeNofvyUXae6zIYQidiOW+CQcsn2ejvrLaWC07RA+TgRq4HXuk/rO+N8k9CQIBwYgAe8zs5LlbGbGKpCkoaSn6wnkYKzOni4wbA7CUY/IAeT0CDaxrWM3wcXMMMEtBTeJUCikeQBsrrTpiNsnPFlTJ9xbzWGnT7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066378; c=relaxed/simple;
	bh=mzUFCrE6ZMJ/xWJftkgjaQ3FtanVZvDveI+zYFKPyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXvmT3RCJ+TWoiEFtncyIp7A89vljgTNHhGkHYaF7lqAmyJfvMjXTaRw1PIUj+XdlgLwQyv0XE5t3egvkvfWqR6dLUoJe+kp4xkxn0TwjQ8Mb0xyfKue6cSnvDo92j3KrfQUHBebgyQ5YgRn4/H6C5SnKYU4YHRR+FK2MoGRKMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ay7oSlWA; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ay7oSlWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc7BVmweSOEIIgQjnmzHvvAQAR9MiFu4UbaO/HycYbt3hzHSRF8TY3LIBm3mfVgjXeFtt6BdYttfCwpAdEV6kBn0CAg//AYUYkBRCc52r7zLCYr5A5FnYrbdIUnYL7OsYG8lAG4I/LBPdLOyaWksWCtCqkFcqepWCzcTAD/OTuRa+zuYnAdxtoxbPGO5O1mp8x8aUZQo/RDSMmO6uN+09p1JZP6pSovkQEQjWZOi2cPUuKjH93mUmk3igoasMgu0VyJqDjG/2/9idwspS761JoZ4PnGbxLuvlletJRgvA+vV/cC4aLZ8yMxxuM+Dym4Dt5fiRghYdTfCR94z+3v4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLTWdpSna8gA54bbxIWWZH+g/VgA9DcEvboXx6AVb+4=;
 b=glaemETkCJt5Hxe847xIIOXoqSOP3jOdjxQryg4KtR8lQrZQbHlbfebSjhDBzH82RXjucxcK52NfyR9azBtXqqNM16t5JQbML3v+bhVGovI3dGznXy+Z9YCMnepaNNCh0O0/bxjMja+915XjYzhqo/rj3iXZuCEPHAvz37UjBjviPOlPpHgMqopSysNcDlxE5VZ+L3bp4BeEWwkbAut1ncvRTdl0MHazlrJvC6Syjs6ePbqPhj0zjbvH86biyiUwu1dOhcJUhuOnO6fwJOG3ELFUIrBcnOfdGQhYzuygOrJIfGEWYj1HAO+JWQ+qFmprgrgI7pW9M+fdz60v8UV5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLTWdpSna8gA54bbxIWWZH+g/VgA9DcEvboXx6AVb+4=;
 b=Ay7oSlWA8bH8lllMZ6W5TvAbhXhBaGUN3qVclkClK7AEK0PDKi18ktOO9TKlV1819mzaWtrd88aXE0fnfj2DK3heTG+rOYh1M8lXtMl7b0wI/kBCzsL0qvq5CFj7dIIMGikLr/mrORQNcJj/yuqlMActfLLphXSkRdUfHPH8KW6Ej4kUa4ZsfE/yVve9oRJcl9brudhmFdqvLLjhHh4Ht0M4tZyZ2sWADBbM1U0dkqXOGfeY8Mt7nuJfXdhQ3uB+AtwjZK542/5aZL7Df8CCQJERIGyMBhlratqNnIJNS+mkzWksrRkpOB8cZUmxbLzJq/a7M6H+MRQmkEa0V1+RFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:33 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:33 +0000
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
Subject: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
Date: Tue, 22 Sep 2026 08:39:11 +0000
Message-ID: <20260922083924.2451158-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 614a80dc-a984-4a74-b2e1-08df188506dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oZxjYr1Xq/8HF+IN02DVN6iWpbH1c/Hr9MfqALfn4Pmrvl9NkBF7Pw7wegk+xSLcNna16I4ZF8J+uzX5KlJBnXaRjt3Z0SpsfuqWdfK6m4lvxqIv3/wHKZDgLz9N6I8B+pMQxX69bjmCqf0zPoQBk0A9y9HizMVGISnILQrjb+DkGzDvNlqVaq/ufehKEqYrC4iezt2I+Wq80n5ROVLDv/D1RFKEZsFnJv3cu0/Jzx61woza4nMqj07azltPDSAcTF0Vjtq4xO+/wlzA9o3o0BR9FEdFO9RYsnlwCXubNvjz19GOv8n9csQe3eucFMS1vgihtPZlskOEjm0oXgimbJD60XRvBKnZ3NJPrJQ/b9WbZuYKD/bcFBWzMdphO9G3Pbt1m+1A3jlxF46hT3zgGGBmWN21d17KhpXUFrgoiae/Z1A5z8CpjBwcsokzzP4HCp4zSQDmnY8TTv3nUrHXXpy5vqSzGsLhG/f9Qos7XfD9vyB1bYM3B6BJP2AcY2QkrD/gacJGBE7M3GfTwmbLpG6WhUUtyis2b9VxDO8hA1ezc/sDLGN5fdnSnkM2fv2Mh4CutmtkRX4q65Y9jHHIhwVJadVBllJTCTMaSVC+wwdVOkwu+Rc9UP3C1kWY1vPPQOaV8rpsenill13id9Y0dLnVtunSEFa+BG1nTp9TWivCaLAf+dhHsgcOWV5H1JbC55j4xy/mLMG+/qJNftW+YQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7G0UtvTZstPN+eLSMAQsymQqZAw/exx3n2dcAKuBGsIf6O6V4WgSyoVJ67+h?=
 =?us-ascii?Q?TXZUdpDxDi/QNegpjOzQPFrrHeet1+ioR5gVYMWdAeAWmYfOdjV4yyMRbehQ?=
 =?us-ascii?Q?q2fjm0Z3y97qtIPMZd01y6tEeXj6uVZ8k2bqYrdsfcmijH7NHk6oTAd36CJ7?=
 =?us-ascii?Q?4ooeVMh36UZHMiJdKIhb0v4cSC7HkEsrtQ1sO07K4gGlNdmWc1q/h+5JBXNb?=
 =?us-ascii?Q?3YTlvU5pW4XxXptp/0/mB01qh/KmXCei2fTA+lrHQ8vJvwDjZe19cg7hMglt?=
 =?us-ascii?Q?TgXd7mrm336gXdxch59XXbi9GkG7ScVMM3Wmp7jwjdo77il6btcUkOicnobY?=
 =?us-ascii?Q?Nfs4deQaN5WGiiVwwdZEW+mE2qGXP6PpJ9NaMkpYz4qnggloYJc1eziQYFB9?=
 =?us-ascii?Q?L3yTjrQcxvEiupqGrFQCgpvccI++Ljtoj/cRcIpb95EQFJLfiP4bY4LLNQBg?=
 =?us-ascii?Q?Cxo4+j0uPezw4iEp5mg4cCAGBozHvpAD+fB1tbknpcxHsHdAeAuBO0v1oY27?=
 =?us-ascii?Q?Bn5SiJi2mOxVw/PKGCVac9/fNo5R+n2VqYkQBZ8WViIad+GFIWP23plXno8L?=
 =?us-ascii?Q?tZukTAgmeaOULBVWZ7u5pcTsfOJQXAFMb4vvOZ2f4UREQCn2CJ03EeP3h0JI?=
 =?us-ascii?Q?SgiRrLgEKZv9X2KmROapifvr6iR3mBZce9ojtERM95kxjb8OE/9bJHSF3x7l?=
 =?us-ascii?Q?f/yGhe0SruMWucVCUs4h+pOpD18SBz/GRqG0jiQSuvZflNRqLSUQi9y7GkL9?=
 =?us-ascii?Q?JMPBsR/jogidH/v9sDKd+kV9fkPUAYnu31/R06OaaJXHq/520yZXDGgmvoRx?=
 =?us-ascii?Q?B4lqOPQ0nYvizL/PzLggyJw5YHt2kdizsyYumusgAuk70iuvdJOAFqncvEpO?=
 =?us-ascii?Q?qTZx44vlaCJET9c271Bo7h1hNVkAULqb97E7HtUafT6+7/ZAqeE03larE895?=
 =?us-ascii?Q?Whv++5JlqTQoB8Qb4jZ2B2cZ/xnasAYD/55RR5AgTOkpB6Ytag/CAw3AXsXK?=
 =?us-ascii?Q?ohduBtfzIoIpvofRhJC3mKwKO5eCDWIqnCkk3IEyTSU+RFyOgHSYKwFN8ycJ?=
 =?us-ascii?Q?SpQNUpNbR81D+GqrHXX48IOZKyRFMvcoDv7KTk8nRul5xJLryOKQhEBbG5IU?=
 =?us-ascii?Q?cFBkjTY2cLDPtdCyY5TW8govdUqISO1b+ML1JxZF1vSEaabKxJ6+Ejc+xxI8?=
 =?us-ascii?Q?6aRLivjHFF5+J0BLocKMvhO6MfWY6oaS6mOeAsbcLwMS1blt1IgXrF+6BlnM?=
 =?us-ascii?Q?FYUplx0xjuR1okL5razD8Soy2Lajw9uR29ATp3CIJY+BlXiMFTX2cP4NDwHP?=
 =?us-ascii?Q?4r4JAwm05th/+oGW8of3Foe/14PX2LPQIlZnqEGrL5Z+omuBFVRn/1n00NIa?=
 =?us-ascii?Q?zzc8WbV44z7JdZCAD2CqNsrDEnbJzg8v9aMmyophQ8RDNqnGg/VBTx9es/Lv?=
 =?us-ascii?Q?1sLlZFQk8t3+/RLzuBhqhMQgMTp/hTT1cr0zmVEYlB6SGQG5ixRkpOEEq2Q8?=
 =?us-ascii?Q?O/cHawiL+hUXnHOzsniM8734HTZRwpjR45G5nZCVKpbXu2t6/MN3eNIlRtVP?=
 =?us-ascii?Q?12sY8UDglPl3OtsiOsz//txUP6SUpWtFBETq/r3o7HjyErXqBZx4dbRAtqT7?=
 =?us-ascii?Q?YEaRKgz9bKNe3KVc6noywv7GWJvZ7wPW1uN6VzlmDPMyErDJQZ76F7QcZkyn?=
 =?us-ascii?Q?we4yTrEAD0qL2OV/SBER4iHv60gKQSJqKOMw5yWzqLKWGoIz1qZQK/MeaTvs?=
 =?us-ascii?Q?Nsi7bASxMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614a80dc-a984-4a74-b2e1-08df188506dd
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:33.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqXyWT+CcUOhwspohx49z2q6w9HqZljBELjw4wZDhifmoSWrJkU/zYbNzmuDwkYLgz25aa3bKZQpOGUSRfrk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

read_cdat_data() resolves a CXL port's upstream device to its backing PCI
device. HDM cache updates need the same mapping.

Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
PCI device to make caller ownership explicit.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 23 ++++++-----------------
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

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
index 9d807c1a002c..bf7fc77626d9 100644
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
 
@@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
 				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
-		return;
+		goto out;
 	}
 
 	port->cdat_available = true;
 
 	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
 	port->cdat.table = buf->data;
 	port->cdat.length = length;
 
-	return;
+	goto out;
 err:
 	/* Don't leave table data allocated on error */
 	devm_kfree(dev, buf);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
+out:
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

