Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670B30FC27;
	Wed, 13 May 2026 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640586; cv=fail; b=M066AXFF+BjsQ1ar2SFDGYjQepkmusLhNUMRGEDrpOegLc5DGzNTgWdLsABdyC0PtaiPucQOavKUge0l7cJ1sgb4X2ZAuZAqahtw3sgFG1+ijZ7hOFnMHSQl9P0WEyX+9rTtPeqpSL06TjmlnPYaZicZ4TcvrAY+rS2JO4O6zGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640586; c=relaxed/simple;
	bh=o5RX6fYr+4rVA+CfuLEggoFr46SQX4wY5aT/rBhEopo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rar+aJ+FQhTXNOD6YgpIuLawzFG+yRIspdLNHgXl4MICVQ2N4TlfwGbVm7Jp4yWph1UHpB9WRv4ayozqK2QsHjU2IWziYm0tTcsu7SZSY6R/PLkiLu1WhN+OF8nl7GDcFS+o2P4CDKmlGpx6S1zYRcFjpSi7YlCTq3ljKWKpYHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oP2R98BW; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oP2R98BW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxhCP0mdWtSaAJo6GXqfPiR30cX5Z3Y7SZp4PEGHDYElzmkckBc7tPDCVXsT+QDvJDGiwGCFuxqYyOygYeeX8MzAkc/HQu8ENLqk9VZEcgjM7TeEFvooRjcY3tiRJUG8InzKOM7DQw+2rEtKmjHGEGYoJXR+GC6OSwwKKRN7btsKy7RdB4+wEdflpQf7VAC3sQSWdU5/zhOLlDdRXARBeznrHuh0xYgDcZe4NFpesU5tWQ9WyXrgu/jFglS1eLE6TdsZW3x87yK8MWpFfaflm37fAeqlyz+4aAfDGOyShYpClsfRQyoREbMGNmOdGYrpyYEKROyhzUCXPNfCwatnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+bm5Q5vWa6Gto/pUzFQmpWoDGzy+Vr3MUaZv76LOxQ=;
 b=V3edoq0jqy1cGfDwiF3liJUDHILHNCODDF5L3Gubh1TtvySRz2CPoRgDEJoIX9gQjUQGwG9dd9mnzO8WxDYdjo1FD8t9JztZo2agdK6YRidSo6Hu+gUVfZsEIvFx9hfOEH50SAfwAlSwNKnN2X4FIadd+WwUT6JlhDo9gLHzWT8LZSskXEHWhAtEukHhiMJ8ezcLYFoC7sajB/lVXcsRoTLDXvMitjpX6DCA9eihvIcIlJJQjtM9785J2g3sMBgsrf7CMCae1tTARXRu3Y8j8E6qqpZXdmIYrQdPV5KLGyMPU1Tnc+SB6ervROC7fJk79R1FlMSVzG4FNsmnyrUJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+bm5Q5vWa6Gto/pUzFQmpWoDGzy+Vr3MUaZv76LOxQ=;
 b=oP2R98BWrtdE5XR5eWZK0pUW3qwIpUdHFodR/M2z55BUXO+PboESoWAYUHhVQQH4DyqhqdUDgYgmvF2eFsL++qPih2J1auWTguDonl6rGVXVerKe1/1WgVGCaZ1Hq2TB64g8dr5p4a+fcFCjS0g8Tlv7+UgRGhTyv8ZKRrXduEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 04/12] PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
Date: Wed, 13 May 2026 11:49:15 +0900
Message-ID: <20260513024923.451765-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 817b5d1c-ce57-4208-4622-08deb09a4182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ESEg5UPoCn3ukaAqD8nyu+KWtLTpUXb6sgQ6qgu2VKBy6Tq09UvOoIh7oADRWeWBkNpf/cUj+Eyal+c7admxm4QPBiY2MDzouY8TRS8qb+uWj8uVFZlOJtFVSMkDH4KJCjEUnJvfb8eIFRApiEpPPAhhHi+OJn3ZZoUrAto+jPRMV4+rq/SFc9PxERkaCxPwToY5nfMR8aZI1XsJkKDN3LUS206jVvh6cBpHbaJSdiMUDgnIB/hlhCS9qtrVU/KD9gQ07/Hbj6WgTE8S/rRkZr/0ms0ILoDt96E7R3eYxE2biFIbXwZq5sUgw1GetDJV753+WlEp3yVCiFsEFDnWsP5yYvWsjEV/inoRe7POGj+lWGZ+QZ2TwHwpEnVZhR19zzTkYZR1HVZ2ZQSOpQpP2Zgf13MPk5a2kuehCffItJkbgoIYPp40jojEVmmgRiu+mcoOXxTHy3xgCvHznlt7pWB1HCWIVknhZno67Oo/LX3Jh6Rcz/er5/TS+Xnl9ox7oPITIc10tCFzSATgOdmLfgka2B6YheFSgN2DoBs6MDUVY83VXXbEwE0BmT75MLgEdvlukMyGnr+LhYtWgBjxzZ10FlQR3FDn8UjVd6qkIud2bEHrBZuXWREuAu1svINVq4cSjlxkxytnOBpwWfTuEgp7upLucjcbdY9asnhGwQ7p5U7dxU2lx1HOsNH32h3vkO/m5r4msdG5eH0vWKm3F+h7AYF6TmduvC1di+dgXR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LnK2/vcoratLKZCUlwKeGRV1U/9F8EQI69dACEVyhXordm0dIyK2HkAfDMB?=
 =?us-ascii?Q?mdaq+MQ0SEDmfZZW9wpzGyjHCWeHdtZrY9z5LIG9bLTnPjxOkdqBpzS9aKlp?=
 =?us-ascii?Q?bftfWmYlqFeVT+ANuTJlr8EoTF9UVfIV0XGdgNMkT14xNuP3WFE7IpzaVU2k?=
 =?us-ascii?Q?TsAI+w6XKqle403EjvYlaU7qiSAUJerlF6Y1nNeoej+weJjXJnL/jciqf4TK?=
 =?us-ascii?Q?rJZaZQPcyBN+5/3SfWYEpG4ecXOTiPqvmmHfZPvqp3udTVoJI1UOVmNZD30G?=
 =?us-ascii?Q?1ev6JaqYyYPmVtpB9ThbJiEjWtQCmP9eaG6q/taNfElrN9S56DXC+ahzezEc?=
 =?us-ascii?Q?aTuvLJpN08NC/Z+4YFHjFCJFlzD79DtU5qj4QGSlHewCaLAM8lRUtXMyp/1p?=
 =?us-ascii?Q?eS1qi1MNI8Nx64J/LFJoqID4gcKAhW7aQ5aq6VWVSBDhRuo6N0cgbu8JOpnP?=
 =?us-ascii?Q?919zDc1R1UVajVJgwZIEjju5eLRennAcP7n9v6vENmJakqJvPyen7cTuk5T6?=
 =?us-ascii?Q?lm+kN9Dyfy4yRRl+VZ0WH4sPT2AWMf9Mw9Iy/7OSh/PUx1w8vpUTlrmVzLyj?=
 =?us-ascii?Q?D3GY1Gsk9zjQDj6H1UJvMLeMc8c6UOCNvFjQWRAe34Yw3MSTIfc9Ca1cpouW?=
 =?us-ascii?Q?ohlxvfy3Bv4gv5tcB7WrXBcgN3rPLFEJ5bSLIgG3RvR0g4iCrAhIDgfmv+9p?=
 =?us-ascii?Q?y07hb4w92PR2/aN6MOkfD4TnR1UU0+fVlTHsXOWG8WregdKdG4y+UmAwI4YO?=
 =?us-ascii?Q?2b28KwF+PAkWd27/pbZZbXetsbVOlxglUvpV1YrnQ578WHmHgkY/TQYbGJQ4?=
 =?us-ascii?Q?q+wKPTzB8LozVFDRGbezHFhG1eIFehSiBpvoue4j1NPfB8W6iNaktbfixU4W?=
 =?us-ascii?Q?4fFiW+rTINavujua+ZPALJhhkF9yCZdVM8D08XjYRB8YfUrocxZCf+Q8BdHU?=
 =?us-ascii?Q?f542ayqW8BtfxMXoKNMHGoYh5aJHQq9Ee20BXy9tKldrj1wCkrU+FRXmbAPL?=
 =?us-ascii?Q?zMRJAEpArTYGtG3RCiEYcX4D6zp6AxLHJInJpMDzZKYWEI+C/FoKzrwFMZgM?=
 =?us-ascii?Q?ofUoThC+2ZW/O7klA2VhP8bNSoAAJ5CptLpQmIsSLuRaibw4rGV+GjGTbSme?=
 =?us-ascii?Q?CVT5ASNjtlDyUxe/Cw4XsPFpldDNDsqxVbatOKAS5XS1ayer4/1Vdi+A8aN2?=
 =?us-ascii?Q?4w5cOQWzmQE0G1IGBL9LaKt6Nw5EmgeQTKGpwwrZfJUsl+5/SsHDcQK3lrjz?=
 =?us-ascii?Q?ceA3OUIAEylQVSIFhABXl0fKWi1VYe9A9QUYmhNiC/HKYU6GHmVMECIsjNYk?=
 =?us-ascii?Q?MLGdkB6DOwmoMF2ZyR6UZ9bi9pzu/DYtStj7oX8Ylb1pLwmVDf1GatixjKYc?=
 =?us-ascii?Q?1+FoTMFo2YBx4GRYbJ7mvwSQq7kE2DDOxd3QCgHjzb3P6ZbinfqtcXKxEt5R?=
 =?us-ascii?Q?QrHmKXOARIg4gNpFEYGW3sJg8c6tANoEaWMFumVCSn6h2PLVVapWWpQRkMs1?=
 =?us-ascii?Q?0OEuQw7k0wQoZvN09V90EubahpTyi14v80b6NA/8WtMYb4wNYpLLzHyLsMLY?=
 =?us-ascii?Q?BNNuPe5+Y7MwIphp5UCTRDftFcJV1cmGjwOJXMAK5BYa6eODTsHRFPeLmXyJ?=
 =?us-ascii?Q?Vn5dN5AmMCbWZCaGQG2joIL8FZQwbKLDKuyuJcHcr2XaW3q7NT279jduqrp8?=
 =?us-ascii?Q?SaS5JAOlcMF9v3QpgDm+Dyv7mAmjq/80/fHQ5LuHJBtX/oQF4288ufgi7unS?=
 =?us-ascii?Q?h1aRk3TOxXW327BwI1nKR56zfX+6blVkU+f1m13c2SHQxLC2B+BN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 817b5d1c-ce57-4208-4622-08deb09a4182
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:30.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeqb/PUmPs27l+vWBmB5vmuOvBlh4ef9BB7yE8OY8Zflx1e3MHtUyiNUWd9YLdNj5iM0RdRVSuVaALkGNf3urQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

pci-epf-vntb reserves slot 0 for link events and keeps slot 1 unused for
legacy layout compatibility. A db_count smaller than MIN_DB_COUNT leaves
no usable doorbell slot after those reservations.

Reject such configurations when configuring interrupts.

While at it, move MAX_DB_COUNT next to MIN_DB_COUNT. They are used as a
pair in the range check, and keeping them together makes the valid doorbell
range easier to read.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - New patch.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d31e2eee0869..818ae5999976 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -67,7 +67,6 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define NTB_MW_OFFSET			2
 #define DB_COUNT_MASK			GENMASK(15, 0)
 #define MSIX_ENABLE			BIT(16)
-#define MAX_DB_COUNT			32
 #define MAX_MW				4
 
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
@@ -89,6 +88,9 @@ enum epf_irq_slot {
 	EPF_IRQ_DB_START,
 };
 
+#define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
+#define MAX_DB_COUNT			32
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -512,9 +514,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
-		dev_err(dev, "DB count %d out of range (1 - %d)\n",
-			ntb->db_count, MAX_DB_COUNT);
+	if (ntb->db_count < MIN_DB_COUNT || ntb->db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count %d out of range (%d - %d)\n",
+			ntb->db_count, MIN_DB_COUNT, MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
-- 
2.51.0

