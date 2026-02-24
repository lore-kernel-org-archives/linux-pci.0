Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B53A0B13;
	Tue, 24 Feb 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940115; cv=fail; b=b2fOQhlKvfBWIJ4AWuNP4BczfW5G1/ktqmwcFcFcG3m8rtdS/Mrm+FcHAol4BH/BGQtzYY4Q79kAIeW4W46ZXTybDPgmNCME0LBp94XhjIoxFwhpgAFIWFNVdFnXR2ct8DmjTOosl/M5buig36aAk2USQ2E6+g5hj/D/Di0rC88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940115; c=relaxed/simple;
	bh=O08hWp3BIB6M8Ka/MsUK1C5LJRpIBFBsGIcmkk3g63Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RaRr12X9NX1eqwGhvwHTUGme5e9NwI4jJ6S+a42k8oxvs3vvoH2Emka9SW5FqCtEMzxUqNOJtWh98PoPjwlTuhSNg+7OnSWeZ+SSeQvFBIEnBJE66gHwzMGcTw/1g1sEz7Nxdll35FeKh2quOytxB2dauIfYMryudy+5W1xjfCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iBINAONj; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iBINAONj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8KRJi6+CRl9eLUo9XxtiWiXBc5D2E8cUFu5u49SgQk18jzIuxH7E1KRiqGsfzMxzBtunpgWy8+Q6IKjBgUU7AUtRUNv33yLghFq2myqtbj98qDbT22TX323BWX6XxQcBrF1xkGBXFESne3DYbtaLwpDkkYtALU5OMusFJyHwC4xAoZSi4qU9jpwXjfKbHbncsWeFVQpz2APTL+onxVXHMD0jNZao0pTKmdcje/+vrY5BDYWcjDOkgoO9YAYPOogWUiDDR/Xr62vDQ/zmZfCNv8r8DqU8JRFQhScfF1o5sB6Qk2P6ECWrojVkVpmUKb1BemP/OZQrHFyk5qq5vsYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yvHJQBSw5c6hytcxNk6l6FrR8LVkAmPCIP5XzHV0k4=;
 b=P7m7cdNxcT2SOPgQBD0ig8ESxVmRIc9pIVC9YRV+TuxFqNNg1rnXU/Q8eC17vUqdVA0eGyTnV651P9rOltzDBPrLUXy8JuVR/415OlSuRFrO3Pv3NN1I737ocsHpppD2hqDfAN6J9ynv5nHJ4D9tBrsWtqw7gl90qmNHRrS6EzJHN0fP31bCe7h344Q0Tzbohf1VR1af5dsbErVeZT9vP30rYkd/j40hyAV4BXWys3KhyR9Od99B6U6dVuz4bxgWpQMlGUcZudL7GkTOUG5owV1AWwXUIT3XlGSMhGWn8Dw3OIMQXR30BQBKvbMWmilDym9giry0SKSh9uWnhr6f8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yvHJQBSw5c6hytcxNk6l6FrR8LVkAmPCIP5XzHV0k4=;
 b=iBINAONj/yQT1Z8as1bpHY1jMRK5ZHhb73elVxagzo/iz9wCuATkoxUK0yo6KAZT7Pu9SJkzqR43cX0B5LBnjlFh7n8tdgHNfhapiNAE6FNBdnJOMWkfhdgsbrXMgHh7hOGHr5JRBk9vmlwV7m0tFCvVzEh8YR2vF3/QmGpwaiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4764.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
Date: Tue, 24 Feb 2026 22:34:52 +0900
Message-ID: <20260224133459.1741537-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:405:379::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd71405-6578-475b-b0e5-08de73a984e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rM1wUpmlO+/ggKVB3/Evyhpi3S0iuvDmBuGWz1K0A8+mp7fKxWSBn09QaoJ/?=
 =?us-ascii?Q?cnBzvyxoEcdavqqkOwOAWoGxrZ5UpqE6lDBkrn5GcNtr05QncJOKoocbve/p?=
 =?us-ascii?Q?dOyIOV0JWXW5v5avgjpp+JPcbnShaTxNUUH2dQ67ve98zUHp9TZ/TO5W2yTQ?=
 =?us-ascii?Q?pNCiV2F770xMzH99PLrqhROrTT9Ghi5JQV7tdVG8iw/LATVxN/MaBRS56/gC?=
 =?us-ascii?Q?OAYGZY3YK/Bgwn6cOUFBYWtXynSLYYjfQA5qB4fnWF5HiROl/QZ4OZfjECO1?=
 =?us-ascii?Q?v8mPnZoPDTtqArvAxnUanz+UdQZNhjrZfRuvVU7XDda6jv4cQYHTIiaUzWAJ?=
 =?us-ascii?Q?2oEw7ukVewflbvjAoTvAQ9sarVc23dHAS9rQqs85/LCk1EfwTw/V5rx86BDG?=
 =?us-ascii?Q?ZlzYyxCcdVWazs/+C1NQha5bJm+G03omcX96dZT7P2bk0OtYbbI07mQk19cL?=
 =?us-ascii?Q?93p4w7/1ZT04g5qkud2Ro+vFJW3YFo9cdE2BlMfiql5QnZDPX0sSYwCoSd1v?=
 =?us-ascii?Q?HavkauokRfy9KCyQGmFZDDDNVYPoMwRyboS+3+oryz8uhtBU73E5M+rVh2EY?=
 =?us-ascii?Q?iiaTIOiODIHE873R+PhVX9QV39LKmzwAfc8ssEg2hkCZb7KM+Ns+zB01iWXo?=
 =?us-ascii?Q?DFTxvJuS9QhQoA6xIUu2C/nmJWFLWtqI2uu1prmOPeq/gZkP6YbeCm3JtIYR?=
 =?us-ascii?Q?fsa/wJ1zr0Zlw21D0XnUTKrWj6YgsTLcG5Kz6i0iSGo8fyB8uQmdZ95Qq8TK?=
 =?us-ascii?Q?YwCj3xBBeVN9nzjPYTMaeKnYnr0m4DvCUfNXE2gNb436za7DtR+QaOnLP4JY?=
 =?us-ascii?Q?WM5SWKpnCxLSqSR1vXxnViDwn+e/VKkuzUO4K3zEM7Nl55JimtJ/DFKnxf7v?=
 =?us-ascii?Q?6IpVeffsqS4NXyNUHaQnnehpJgMBhAafqWzyXqEOkHA/cuQ4sCYehVnfGUT/?=
 =?us-ascii?Q?gqqMVlMXRz77KK6zv9dHSta10TIpucjuvUdzR3ALuUD73nFg3SvmO1C/awcD?=
 =?us-ascii?Q?rQV5C2JtUFEVrSXHJU9o5LlykneIltvWud8GdDffBa7scwo/efJHPdIFoAUj?=
 =?us-ascii?Q?F8i1Rxkmm/OZcgdk7nGIOL09gx7GgazGUY73JSs/cqsPWWjO90qHaNe625XS?=
 =?us-ascii?Q?dOZVnV6e7HVdOy14GzVE+czeBIMEhJXs2sDKp42AB8rMccB18ZMhza9dWrgC?=
 =?us-ascii?Q?NzHUbl5W4nIQ8/jZbKjnStY7R7LijCJHvvrhexl55Ou6MBVlHtGaNzhlRn7z?=
 =?us-ascii?Q?v77aiQfE9M01Qi9ONDGjlxkar3GjVVSRDLdPgDPIk+TH5wQ2UqlqUcAoac8j?=
 =?us-ascii?Q?+Piund3tQG3x4hc5N54ONxsRo8TTUjA/g7x1ZooiLaPQCSZ+Bbx1Mj2vwCwZ?=
 =?us-ascii?Q?lIvri4I+sn0jukN6B3OJUVXlf69LAJE7+VDLVjXTxhoAOsvEPbM0cVDUpXTA?=
 =?us-ascii?Q?o9xQD+AUWYEMyAAnazcnwcw+on18eU5OAirYUoNRN4pAYpZYEt9lSSEdagic?=
 =?us-ascii?Q?Xx55HbiT+FpRRfNGFAqkUxg+XoLvXuXZP54sWNwa35pAViHpYCc7ZKoSHIOd?=
 =?us-ascii?Q?mavSxF0mLzk7Zw71SYYvhldPnxZdpOUUhkYxpEKxDvfGFy/bKz01LRpO9BmE?=
 =?us-ascii?Q?3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bl/2JYfkS1dp6ljcqn8kM5BbYVmxXmSbUy4klp6yoVVtR70AjbIFQKL8pc46?=
 =?us-ascii?Q?sq1Hj5dXG+NztkOaj8fFGR5Ny1XPwZCKu8qrV7dCz3K5UWROfEuwSKMTybLc?=
 =?us-ascii?Q?rhtjQXGz+ehb+m14pC5y5U5qKLUOned7fRfVnlqYyR6lsymQW5Hzax8JRCLt?=
 =?us-ascii?Q?ixQpzPZ4vRafWe5Se2xA2aa6AZ3ovDfFW1/7wqOHB/TpXBmTn8Bm74kyaQro?=
 =?us-ascii?Q?JAok0I8dfYE73kWqtSGMs/4T7YR6/TbBMvF080Bs+mbI3Ff/0BLAOsT+VaoK?=
 =?us-ascii?Q?ghdKrLw6d0vMgfF5PfLn9A9qZQVf9Zzp++jgb6nRVHQmfycIYrE+MhlpBPt+?=
 =?us-ascii?Q?DlmCSJ44bKCwNJvH1oNgxA9r0sSEgpAcsuF6B+LIKvhIjYfqv1jhGcQkGxf9?=
 =?us-ascii?Q?TzXWKuL+r3+926O7/E4geifZDc537nkELgtpdrtq+VCULCHV7811rKwYhD4o?=
 =?us-ascii?Q?xGIHy1yuIEMB3ENUU6LRku+Vka19ofZm0xvZ3RR7bldVsqouLwMR4K7CzhyZ?=
 =?us-ascii?Q?+965OiM33t1s0DvCemjbbXZVdCyu+7ZV5YlDG6YPPfb/DmhMsfjAh8+OsjAg?=
 =?us-ascii?Q?VjBRx9XxewHjgp2qg5OQaqaLivRdy9Tz0t5ouuNxsVpiIbNusRp9v4TEO/OG?=
 =?us-ascii?Q?xsv9zd7LYPwDOEwsQDyP5rBO1B+nd03VXs7GeBKox7yvsl9jXo1XzYPr6C58?=
 =?us-ascii?Q?iNwSq7ZDJ53z4YGC9Vuz1LTOLTcgJddB6NCflDuxmF2ZiySEkxTd76UmN+uR?=
 =?us-ascii?Q?hAblb5bZ42Tgoby9H95UP4Z1h4EYV74FFGQ/NCX8dyeDquU5AJAvFn8UfOCd?=
 =?us-ascii?Q?YbstT1/QYJB4WprBGpIF4aGHZA5iXfrwiNAnESm6nmcSARDg7jKLD4XcwexS?=
 =?us-ascii?Q?3v8LRYAjCXsqOYx16TfTy8dOQNB1QZ5VqSMCHovwHKrrkMgM1SdbtkKrqiI2?=
 =?us-ascii?Q?ZJAevhWUAVJzJqiecF4qsckzMqq2DQpoPfY1CzMiyZA52oNS4yr/+U//bwyV?=
 =?us-ascii?Q?8eul1K13kgNn9QW+SS05vRPWFj6BRsOv22XYQXdlzcuVCvR/aOwXRKeT1N43?=
 =?us-ascii?Q?t/7CU+xIcO08OkdIKdXj3DmTcnG2NypFnf+RqiitB3TNSiJ+bXBQmWp+UIdx?=
 =?us-ascii?Q?8yctITaPHJ/1Dyu6ikCVqoKJvhnI+A+ZMZzSjFbcoTB81cJaaortd6DLNZYj?=
 =?us-ascii?Q?48lal0ZHf74FQHrM3ZeEq6FGTiEjRGDpFUYZlUCK0hYk5vShauAMVQH6MUZk?=
 =?us-ascii?Q?KCvDBgMTonXXlScjY8WcZLDOq5vjNZnT44FQsya+RvYrbuRUqKhmVza7N904?=
 =?us-ascii?Q?BYHCg2QNdrYWoulql1Dr2NlhMxewGKTPOjqsODR2vNhmXTxtxBUXZUMhGB/i?=
 =?us-ascii?Q?EZ6fHNr0SOUzSV8ytfAQiC9Ql58XGbJDo9MOmrtC7ogUY1zzmGQpUOP4i8eV?=
 =?us-ascii?Q?KHPFavbXMPh7MSdnBHW/5oWPcrLDEk7J4ulUP1r25iucaoZW6cgMv4yX4s2l?=
 =?us-ascii?Q?kY2PZhYR+qMXWxh3QXZo8k9RegdbBJu/H4zJ6fQz773X2qKBmsIsFf28APcG?=
 =?us-ascii?Q?oFnfzrh2UEJzITkWMG8XjXMrp8e4W+DqynAPpoVYcZvg9EiP7v98Ks+aSJC4?=
 =?us-ascii?Q?nh32jrsPXqTP2P0cw1BZAdT7AlwDqaCx/txcx+Bqz4ihQf2tFIzsfk3erCYL?=
 =?us-ascii?Q?Y1K0lxit3rekFoTxbSYdOxDfm2eHSyjDqj0OJMvUbKm4WHgcANDBKweOXCVy?=
 =?us-ascii?Q?yJy/JShvzOZSUyA++bYzoPdjpGGcKybkQr+H4IyO1DQV26uPyDYw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd71405-6578-475b-b0e5-08de73a984e0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:04.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGbz5vZiRqRQS2tF2kWqUH2RmmSyMm6HCASAf0hIqiasHa6G9tuK/3wzGJqRiO2GHVOFWyCANgQ7i0P+dEjY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4764

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

pci-epf-vntb reserves vector 0 for link events and uses higher vector
indices for doorbells. By passing the raw slot index to ntb_db_event(),
it effectively assumes that doorbell 0 maps to vector 1.

However, because the host uses a legacy slot layout and writes doorbell
0 into the third slot, doorbell 0 ultimately appears as vector 2 from
the NTB core perspective.

Adjust pci-epf-vntb to:
  - skip the unused second slot, and
  - report doorbells as 0-based vectors (DB#0 -> vector 0).

This change does not introduce a behavioral difference until
.db_vector_count()/.db_vector_mask() are implemented, because without
those callbacks NTB clients effectively ignore the vector number.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c00898ac8269..cbce50afc4dc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -266,10 +266,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
+	for (i = 2; i < ntb->db_count && !ntb->msi_doorbell; i++) {
 		if (ntb->epf_db[i]) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - 2), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - 2);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -335,10 +335,10 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 	struct epf_ntb *ntb = data;
 	int i;
 
-	for (i = 1; i < ntb->db_count; i++)
+	for (i = 2; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - 2), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - 2);
 		}
 
 	return IRQ_HANDLED;
-- 
2.51.0

