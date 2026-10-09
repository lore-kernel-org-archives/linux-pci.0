Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020085.outbound.protection.outlook.com [52.101.228.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE33DA7DB;
	Fri,  9 Oct 2026 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521711; cv=fail; b=RvcwIpybT528vCSBRwB/Qz6bDpmPLtAjq8I1IR9qGllmaGHOfU9E+Ht5g61vHUHR4yxWqrsfoZWIrhEF1q78ZrH2BFbgi7j2dhyOnJisNjd5cwQekqst7urlYSMJnBKAP0Lk0ILjC2eLAsjzJ2UMP3F8H7o8EIFJfdtQExbHr+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521711; c=relaxed/simple;
	bh=4erfnXx7WqyWY3h7XTimZuNBALGdZuxBA0xp4GTTCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKDnL4t7SpDXjOjP+wT4GuphgjtMjTVfQdw+Sb7Mc6RweCMAr4jkjVyXSJdyZruIEslwGGSAs4NVGX0uiXRTtzQtQCvPVS1HnWd0cDy34KFjS3GDK95/mjBBS4CT8KTIto8ZIMOc3UDQp6n+7NTWhU8QhHe/y6aP3VHslwAS6LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RIBcN0Hp; arc=fail smtp.client-ip=52.101.228.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RIBcN0Hp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQEO4hcbJtCKWWSwy4+rRBc3cZAJaP7ZE/pxwzEwRsKg2k+9ao3BdVJSBEWwl/iP5HrLKYPNgGFAKVmltsOfneoU+nOJCyMATZ1RLVVtaogwo3uSJ2YU0X/+ERwhaW/m0LcDI88Ymb58va4I5c2fmVwliYdFnlPm/NIM7MhmZkueYC5QQMXJngWs07RttDZEgkhFT6iVEtFbBAJ56OHyPcCdmrjHiagoEpGcPUvCNTky39ugEQvEThXGzIklAnTK+SO/BnWEcpL+EAhPXUmeHYYjhSW4W7swWjevZGeM9rMcwb40zGJbps0wKQJRzRmpFdijdMbuusy9okVxlcgLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7KTbo2C0/xY34mZ0kt3bOa0LXo3m+6moWzqtjq79oQ=;
 b=qII6f56d8zLgjjCb5gKvpsnO9v81X80SANa/zpdwBpMLjzm9wXHith3L433Kx4nOtlhJlbXqnnzhu5xzsc2hRTAgITxOB/RxV7E8ewQ3iIy3dWcRFSoh6neTqOCPTf8bIXg6WqMpWUIOMT2/c7SDnyUOsQDaSLg1UwMyhuIlL0bDiEs2rH5NXqKnlzOkNCrQoz/Oj3JDzXciicXbZgDdM8D9Nok0UW/ZjkWVum+EYD5RNr5ieZQ3EsuuoeUKWItyJRIAtY6C7YfvMCpci6Yls0aXiysWJZ64d/MP1caCrSCdLFSZcmPj1CN4nP82fiNL+v64WnfMh+zjuee/AhYqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7KTbo2C0/xY34mZ0kt3bOa0LXo3m+6moWzqtjq79oQ=;
 b=RIBcN0Hp6GZq5v35HluA1CuxHCJkWsDUuxM0e1bJXrOJ6wrv8hqvByKBCa9XH04Wcv0vFb7GRVp9LLjXGFikbYh/lIyQxFKrAJ6eFuwagEYhnckF4Lv0zJBc3TEFEy6rTXLU37lumtn1sI4Wokcu5xOjCABmlFiWC4t/L3U23WY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3079.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:55:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 04:55:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/3] cxl: Account for link width in latency calculation
Date: Fri,  9 Oct 2026 13:54:51 +0900
Message-ID: <20261009045452.1107921-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045452.1107921-1-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee010ee-5dd9-4e16-1ce5-08df25c17be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Aj/Hu4G2erxO/obS2eAWbDvbn1VVexRGyG4wPNJI126YMPuhlRh7L0F5gNE0VBGPDmnQtfMn7Xhx39e3UedOyFxYbwBGEY9IKfszerCReK1gzDtXGm5LQRbvpY1N930dQS3MLtcyV65653WSJ80aF7GNRRKxGP4tNYUhuEms54Y4uv+qDE+kp4ydIjDbZSexN252MSCw3uLkjNn9T6ROE3gW+mjdQttQv7+dvj1Pc07xHX+1buBhynJK17XYlRwaUGZayT7Jgod04rybEKpw4GLOHn8bvKVs6Dk+OkhlpQFH65sbHpdCMRwdEzZDnU8eZJCbX77Gy56FlWG1A49wtBp6v6XOgIBwTDoOuxtjDo2Qy39vxZvetd7lPF7psb5G8kuvkD/2DtDn8fcospXajPPkuWXlYsqJntIeBXTfgb8FEYmRG/pnoEKAlBwq8NbyvCLDRKZDu2W3XRyWtH8YR5gC8dCup4ymQM6ZYygh3/SdDpVlCh2wSQSEsUhczQPZERWjz+Jx+zKOb5bJ4sfLuIkGDrPi+o9shRwmzFXHTdTJPdk0sjuJ4aFAR+zNZLTiK/G+V/bj4Mwdz0tBywTzXvHYnvaJ5GKxxt2nTJmbPi8ap+FzXaJMDOC193EYwu1kHd8aPmd5a6pnN0g3/RDt7S/w1DSlTAremWEPx/yU1ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJFH4Uqa0k0E6fSn63AaT6kTbfoi/hubVfhREIJCZ5bherHxwCu5LG/f8AwL?=
 =?us-ascii?Q?GfZi00yvmc0m/GrtGcXEYObaW0FCyiYy0BRT0UsqLBeBEvh3FigH7GhPWl7a?=
 =?us-ascii?Q?SeiuFb4uKZZPhpgK+zTZ487D+LDLjtZ9jGy+Q12YGf5XcFRpmkJbU0Kcsif+?=
 =?us-ascii?Q?Bq3xnDAwZCTxOQM7ZM8/45Z8wM7Vs0H9Z+uudsJcN9d5ngBFNHJg7CscZahe?=
 =?us-ascii?Q?RD/uHv1Lzn9JhDoZqlYlCHTY7TIPGgcmAc3pEBWkh4g1kUqja/wOfyNSHjHS?=
 =?us-ascii?Q?H6iwmMMTxUDjEtVz5/33dACmQ2yZM43ROAclroWCBE9XKnEap3wS6/o/h1tk?=
 =?us-ascii?Q?vf5dVolvJdkJzG5zpBJM3Eu/ZWtUblaGmPp7vsDezmrXNjWaD0x6HTkymwXH?=
 =?us-ascii?Q?aDmS+hFDaXpODMkjBx5tksRZt75w2VzQ7A7y2JlleRJ2WNC7a/lnrH41TjGj?=
 =?us-ascii?Q?YxqSAcrBR0u3UoLMlbaIuud+sQ8aLca72CGiUhgxD7sj7GhVy7iBLQEPgzoo?=
 =?us-ascii?Q?g5Dz2eWinANPqsrYPJ5QrBiZ9dnO3c4fbVP+AHtgXBWxBX1G9O0LEK2yQsUJ?=
 =?us-ascii?Q?/k7hKswHlEWuJ5oGhYHfmoBxtOJSEbK0tW7N1WEIuY9AAU22uzH+roL3ss2T?=
 =?us-ascii?Q?mnaHiTNFcySEJfagXoB6I29v2b83uEn0KuciKoGeOvsPDTCochMQM0QfBn77?=
 =?us-ascii?Q?1o/IpGhotN3vV1Ldu2YOP4NrBAJOpE7P/XZgyfxqvKqjlZ3HQp8XTbMXmno3?=
 =?us-ascii?Q?jY2mvmiLxU0pxmPywKvnPZ1uY8XBvuvSbeqpI+Uf8bWjZZ7A+QTnpqhA/V60?=
 =?us-ascii?Q?ypir9crRQItV1kIvZciel8P9Vf4VO4cwOJFkeBeaLmj28ad8MYeiosO5uMi8?=
 =?us-ascii?Q?GzmqFwr5VELs1psEW9w4hgHBiqUS3aWkqgoZtxRY+4+9ApHe3dIfpmD+puK7?=
 =?us-ascii?Q?Ix9lUa7HPzYKNyUnu635Al2NToasTqeUiZy4MtHsVqUuvERNXEztS9n9uvRm?=
 =?us-ascii?Q?ObhpHJ6E67UUWkPqbG+XUHqExklV3xvBY/1RM1N8+EDaYDtaEtNvGydQsDl0?=
 =?us-ascii?Q?FGxawLjxZsl8zhweHy3PNz91imow+pcXCGTwxLSojgCJcspn1Bf6u43xp5rA?=
 =?us-ascii?Q?ZKFwhZsC3wRm8Wqlz3Zvip8mdJmjvu5hWxo39S4Ro3ZIM+Mi91RXSbN6AvuV?=
 =?us-ascii?Q?rdUCWhSecnm2loIzm5lvYPHri2dHVN7xWYff3A9okWbrvynHfQypG4Fag5NN?=
 =?us-ascii?Q?3o8jOLgbnd8k0cU3paTYHlrNGdvlSN046ZwDFDEz5s2ll4+hO8uNL2/D1jIP?=
 =?us-ascii?Q?m7qynhGvXcioeT8IUdvGaKapgnBxmPqfMnCHBkEc22iszoDt5ZyMjCXgZaL8?=
 =?us-ascii?Q?mz6E03zQpx7mF/AjsPY7NObxBsA3QaYSCq4gH3UwplYQ3sBH6C4D6ttwTFcn?=
 =?us-ascii?Q?H5TIiejx4Ljuo4ctjig72Wy/4QSAauyvbzUunHEX6m3qVVejIfsAxhxIPZEw?=
 =?us-ascii?Q?Zlrc/xatL4aEQMVTO6RBScmP6Ee0EAF2oqcoqJE5ESdgY9MLCNRcGDnUAj9Q?=
 =?us-ascii?Q?GhPh4Djyznq+YUv7IcO2xKm2lGj0CC9ezK6maBXAkaanueVCPVuq5TuiP0mC?=
 =?us-ascii?Q?RfavIvdQan1jqDvx58Vp0XzPzZCJHBBABD7+uLPLh/05lnJd5BrIo0KfB6/6?=
 =?us-ascii?Q?Es0JoO4yCRK6AzNvIROzXUYK6VE5MsrThWEcGimnAUcAVfeZdXlj3dHDwMXv?=
 =?us-ascii?Q?s6njKwUkK6gyDA3PqHepmAzPiU80BAIusfBKIwrhsNW9RN+BaKqX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee010ee-5dd9-4e16-1ce5-08df25c17be4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:55:04.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfHOdKBEgchLy/3ovlrsZYZsMQWRlaHDaziti1LStP1CZ6n/YKvYFerZuqWEMZT7D8lWUooAFzyPLYD3CsY44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3079

cxl_pci_get_latency() derives bandwidth from the per-lane speed returned
by pcie_link_speed_mbps(), ignoring the negotiated link width. This
overestimates the FlitLatency contribution for multi-lane links.
Sections 2.11.3 and 2.11.4 of the Intel CXL Memory Device Software Guide
describe the link bandwidth as the product of the negotiated speed and
width.

Replace pcie_link_speed_mbps() with pcie_link_bandwidth_mbps() and
migrate both CXL callers (the only users of the API). The new helper
obtains speed and width from a single Link Status read. The CXL
bandwidth calculation no longer needs a separate width read and
multiplication.

While at it, make error handling more robust by converting PCI config
read errors to negative errno values and checking for zero bandwidth
before calculating latency.

Fixes: 4d07a05397c8 ("cxl: Calculate and store PCI link latency for the downstream ports")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/cxl/core/pci.c | 22 ++++++++--------------
 drivers/pci/pci.c      | 23 ++++++++++++++++++-----
 include/linux/pci.h    |  2 +-
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 43b9b7afff29..8b52621ffea1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -660,8 +660,8 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 {
 	long bw;
 
-	bw = pcie_link_speed_mbps(pdev);
-	if (bw < 0)
+	bw = pcie_link_bandwidth_mbps(pdev);
+	if (bw <= 0)
 		return 0;
 	bw /= BITS_PER_BYTE;
 
@@ -765,18 +765,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
-	int speed, bw;
-	u16 lnksta;
-	u32 width;
-
-	speed = pcie_link_speed_mbps(pdev);
-	if (speed < 0)
-		return speed;
-	speed /= BITS_PER_BYTE;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
-	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
-	bw = speed * width;
+	int bw;
+
+	bw = pcie_link_bandwidth_mbps(pdev);
+	if (bw < 0)
+		return bw;
+	bw /= BITS_PER_BYTE;
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		c[i].read_bandwidth = bw;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..aa3d180de56e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5980,18 +5980,31 @@ static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
 	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
 }
 
-int pcie_link_speed_mbps(struct pci_dev *pdev)
+/**
+ * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
+ * @pdev: PCI device to query
+ *
+ * The bandwidth includes all negotiated lanes and does not account for
+ * encoding overhead. A negotiated width of zero gives zero bandwidth.
+ *
+ * Return: Bandwidth in Mb/s, or a negative errno on failure.
+ */
+int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
 {
 	u16 lnksta;
-	int err;
+	int speed, err;
 
 	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
+
+	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+	if (speed < 0)
+		return speed;
 
-	return pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+	return speed * FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 }
-EXPORT_SYMBOL(pcie_link_speed_mbps);
+EXPORT_SYMBOL(pcie_link_bandwidth_mbps);
 
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..bbfb0b98ff46 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1477,7 +1477,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
-int pcie_link_speed_mbps(struct pci_dev *pdev);
+int pcie_link_bandwidth_mbps(struct pci_dev *pdev);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
-- 
2.51.0

