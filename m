Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299120;
	b=Q2XmZYeQwDYWqw8PEd/PjkQNRhiaVkxLnbYHXfIEAQzZnukkX8qPgnUPgDV9I3m6TPgP
	 GA/EMfajlfaJ7/DOwVyDhglMIBr0u/TtFlN39gfeU6CkfHvsw7E7yvvJma9LR+Pqn0xy/
	 Sichn1m+93YtPo62eHhYqhLEAsWoGFnz46feHrPigglAy61hnPp2Y5keYBJE+4Dl2qYw3
	 WfLPvTqqNCGlBN4rv91b6PGsshRjQN3qRopL0oKXPXPghNvq73T5BcgM0rpsQHegBPyqM
	 Hu61TR7ERd+VJ35T9nGH4svNs+NNf2sialP+FdCX+UKmCTiRsdfP9DnCjGL/8osDq+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299120;
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
	bh=sL9yHmokpqwxOZJSWJvOEYEd7VhDb2zTc14i9P0qfr8=;
	b=DZj5Gkwl3zTfSIlhXibTU5cUDSk/zUu5bXdoeErkgyZfUQSEu/Dpx5LKuI1l1NfMOrSw
	 LuiiOxI3+lG5Ti6aos+4xpByZ17fOP1EWXvfexC6Q7hZJxrKZZ2d8w4IBNQSVuFZKFM2r
	 eUcadcl5HMv6GBLvuBR70C0JrcLyuMbAbrGoiSlv3HBJk18gP6FxalemqD/LHFVREi7Eo
	 NNNTWZ868NYO1wctLqGEOZqseF24mono61owph8h2mtcEh8RxJ4kjdUc+nz0pN3iD26YZ
	 /Im5Hrs1tFRJULXLBetRD+aVl66aXveN+kh6XSnHY+vYMx+R1DU/KjCXvraUTmBGLmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=DU9+UamR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9460A381F;
	Tue, 10 Nov 2026 08:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D9460A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=DU9+UamR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Ut17W877kfzONp6NQyNRAOsk/dfLSl9zCk/nkMwgcLS80vTyVm1NKevVF+yLhw4HsfIHWCBqzwEpnFy0I61dUVnJdvhcAN+wvgCNUfnsm9WljfYhljAAn4QyTJqj52yEP4fnQuil6M+kDChBC/Yp3yAfpvkM2OGjyo5XZHOxwQXyvKQ6Knavy3fSDOAQxmfxPCOVYSRF9enfc9ow3bzeXU7Op3PAJT393dA7ATHxPZhvuOz2vR2KbwM7NNymR1pgxsPzS7eeyPHVMX3crFydKuyaP6p2DFCLTPheEdADc0OQi9BS7/b1k95DtEK1q+ycsvJZP77x6By7cWD1GUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL9yHmokpqwxOZJSWJvOEYEd7VhDb2zTc14i9P0qfr8=;
 b=EataZuMTENxLN5+Q9iXx8N5y7Hh2xL9JmAIgTmMWMYrvSyyyTYqAIUr4BM08zejrcpAbPoy6d3tP3t/g0iIL+T6HvPBqr1G2u1TaYED+AaimrULY8aR3Q2OigztLmmHdx7Kbm5l5POeBRKb2zNrLIqumzmZsL7JsrLyBv/7qC8ySWDqCJVBHW8sgCtjd8hq+c79gyHUFP12cVzhMDfgm1tdhh2/RlMDoEYS4IhuGGr6y6EUBNpEiM9R9KK8q8WYB6nRsnxARLitOGO0zFCRT0pAF60NrN5EtM5hndK0c8j0RNGzfnVycE0UmcYMDPwdKUJyzb7wErwQ5O0Aoa/wprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL9yHmokpqwxOZJSWJvOEYEd7VhDb2zTc14i9P0qfr8=;
 b=DU9+UamRIzgm11qZJruOup/JAJRnqdUbMK8OX4M4EcXr/qrrbSnWxehD3cVew+1iSh03PnMuMbAwb5PQB4YHc5vHeoxvMW8CqN451v4GI4kzSnKxlYK9WVBqw5NS5MLhF4rRY9SNSWKxhE4vtaBXt/E17MLhTcRUdxtnvdDWv4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:13 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 08/10] NTB: ntb_hw_epf: Use the shared NTB control layout
Date: Tue, 10 Nov 2026 17:24:57 +0900
Message-ID: <20261110082459.1798763-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB3015:EE_
X-MS-Office365-Filtering-Correlation-Id: 6421afb4-46c8-4c0c-5937-08df3f042443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OPArsRNyCY0w7fDMQp/2W1fq9jwCizgHaqywXIjdlPQvrFZxPBbPdu+w93PEkrNuK/cQAElpT1+e71PRzrDWHVIpwZpZx9kYwSRzWGg4l1SGmUOdoR2T92ixxp1IRJ4owHdZVKs2DfMENj4C3wgnIY1EcjapckwGp+xtKaLPF0l200qzDEkMXNjCzLAv6y1WOCCJT+SvfGHCkudLj+BeoPIeO45plXt0s3tqZ7GQj++Rljt7est6cCFeEeNm3xig6/YD1PuG/QdJtpKg2IQUWF8GNQLbzMoEfpaFBTvnzZXbmfjltep+pgMpu6Teqk/QMEpZzHS16hKS6wIVWmV4/fHR4JozUcluJ7T/WmdHlVJ/IMQYxMLsakAUXAUTM4DYGahxIZ3dIw7c5vQPkYmdOlN4NdkdUzZn3QNQjJMxTygqJBhA/s2NJ4Ep3iYIHi7xMvJQzspRDKyGmA5W0ZHmSD7g9xzDTQ+1Xwgo4/V1ixO/Lt8Ecn5aMBriaccgxRDgFLipCKHS7P7Di2cRWGjR+9UbkjKWAtGMuQ74MAV/8VtQ0bR/QXfVJ04ozPOm8//EQqBUWLhcehUYZg091rGDgoduUfQapfLj3AbUlM0sVOa7V2emAeX2b0TtzMY61mN96ohChSGUiu3lv5asa+9WyNSRbgBUa8PPG1Q2V/yVV8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqzrdTMU6NsODPFmaTnoqOySdBt1qybRrvmrWH9sDcGToB6nTP8ZwL6RMR1r?=
 =?us-ascii?Q?eGEaqzpbMfTtAB0CtzwXRqIkrf4lWJfiuKxEudkoHboJ192ddIP80nFLKunP?=
 =?us-ascii?Q?Lr8yYHQ1nQA1wRZ3sb7W/jHiyJ/+/ytuZRITBfj3KzpDQS4NKtHOFpqx0b86?=
 =?us-ascii?Q?dX+qRD1LzvnjB/qVqNoEoAxFB9m2mIGNWvMeYgfMumVknpzOSykeVV16GmPj?=
 =?us-ascii?Q?0ehrK8UCZlYE3jLV8AKsD0+5GTy8ZqFweMf7luC+h7SyNQ2ql5tTH8XxqzIa?=
 =?us-ascii?Q?4b8g9aC6pFxhrlRCQEbqmwD3Mbr56/Q7Qrgi9DGvyKR2nBSpA2NWKybboBQ9?=
 =?us-ascii?Q?+NPSbPV98ipdoSu25bgyn+soeZdcvnA88zwSpV4lBXDe8i0KNhlaXBZ6GYzC?=
 =?us-ascii?Q?5ezI7Cv2eIhLIRVS8EKJ+CDbMKXCesMapLBbIR3ko4ZHTM/mAhu5SKkDvH91?=
 =?us-ascii?Q?bsBuCfUuEm5oP49xb/ofF07s8W0PDiS7fj/akB9q3kCJ+sJNet/ppqSpceYJ?=
 =?us-ascii?Q?rWN06vxice+QovM9swqlAq4jOeHuULv2ej2gV7O3oZgzGE+EHL9L+x8Faeg1?=
 =?us-ascii?Q?tx9IUCAfCqoFCUyGysmU9iWqYURgTcRaUn+xwPUBikzA+IvyHPf7FhH3USUL?=
 =?us-ascii?Q?PGBWUCo/L7e53L/PJHcj0ylfJekNUtVlsjNZO5PcFZ7vtSHUN4BYWxMAcALV?=
 =?us-ascii?Q?6PM4HUGu9ek3DSBu3zbI6TenUcBx2fcj9nhOkLpq+4KGXjzwC5Yjk5ws27tX?=
 =?us-ascii?Q?Ky72O7CR6x1Lh9omw+260J4RyySs9k3UdVkXiVEH87bxGyqWStX9n7B8cBZi?=
 =?us-ascii?Q?dwXheiAU8H197oNko4stOLzT7h4bJWzZco41+P3/Gl48DZdql0aTAHKStNBq?=
 =?us-ascii?Q?kvv3DmknQLX8Nvo+KrOVqCncZFxqghpas9OXxvs/Ue9jKoq8M/8neDjw947X?=
 =?us-ascii?Q?bMEpixligWygpL74URYCHvDMRTEn8oANumDrJXHXbS/YytjChXrCSEU/MPHJ?=
 =?us-ascii?Q?6IMAxpS0PCOIzxyxcv9RU4SqGbVsSSXBVVn5zwqy2GGfbYPLz8Bz/dGRy3Db?=
 =?us-ascii?Q?EwfhKL4DAzQKlKziKmxp6kaOL/b/iADSfWf1Ttnm72zSeQeVNR59k2GAIkEi?=
 =?us-ascii?Q?B1YEcEKq+rHc829HJjnQ4lH082zT/4NRkQEcw1154SWTw1Tm9US5IR2Djnp4?=
 =?us-ascii?Q?lkQXjbk9o91tGMINEMPh6h9i6IFWAt1BUwi2Q+RXMzjW4RPEfmpBwLjv1THn?=
 =?us-ascii?Q?AyxkWlGmPJYjl0ONzQF8xK3zDbDL4+LuDBpKjyWWjSZTFn+J4NbzPYxNLQOF?=
 =?us-ascii?Q?KvmyLZxW0we6eECxfikPY4bhrgn3dNkr58Sn+UhEG4XC3At7PnXYmdO1r3Ew?=
 =?us-ascii?Q?S81O2VSEvIOcQuqREeDjR9Jkc9joJZ7obQnm94oFX2shVyaWnzisCvfv9aYr?=
 =?us-ascii?Q?KRKErVwkSp3Yp/1bl0LSy4fL032L+7K60TZsNOlDBkApWaNlRGdKE6d9qxPv?=
 =?us-ascii?Q?I/jEB54m1U6AznCykrSjF4fCcnUR+QS8+bTslVfqR64Lb6WGIM+8dMi3sRPN?=
 =?us-ascii?Q?kWYO73JYinvRoFUu0HMmRS2hPn8MS4w7U+TnX5F6NbJV+GawRi39KAhYAb2f?=
 =?us-ascii?Q?HasrZM6DJITlE72xJUb2rjV9MVX0dk80Ui4io9GvrK4nBrymneOixxmBre8g?=
 =?us-ascii?Q?7nTPe/jqN88egLE76rb74FOB/dBAOhXofj4WhsgjX4WGhrluF8/axFaql+9Z?=
 =?us-ascii?Q?ubH/km4RXYEAJUkmYRktOE53xDBOJ9G7B+4ZJx7gafCYXAAh3K5M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6421afb4-46c8-4c0c-5937-08df3f042443
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:13.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRcj24rC+GCnniHSprMBnVBoK/loCjAdEeIHdG4zMnASqXQnz/ymeWxcADEXMEoJX0BrZxxSQJzEnKdjMRmD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

Currently, ntb_hw_epf.c duplicates the endpoint control layout with
hard-coded register offsets.

Use the shared struct and macros in pci-epf-ntb.h and derive offsets
with offsetof().

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v9:
  - No changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 95 ++++++++++++---------------------
 1 file changed, 35 insertions(+), 60 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..ff92c2a61ce7 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -8,41 +8,15 @@
 
 #include <linux/atomic.h>
 #include <linux/delay.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-epf-ntb.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
 
-#define NTB_EPF_COMMAND		0x0
-#define CMD_CONFIGURE_DOORBELL	1
-#define CMD_TEARDOWN_DOORBELL	2
-#define CMD_CONFIGURE_MW	3
-#define CMD_TEARDOWN_MW		4
-#define CMD_LINK_UP		5
-#define CMD_LINK_DOWN		6
-
-#define NTB_EPF_ARGUMENT	0x4
-#define MSIX_ENABLE		BIT(16)
-
-#define NTB_EPF_CMD_STATUS	0x8
-#define COMMAND_STATUS_OK	1
-#define COMMAND_STATUS_ERROR	2
-
-#define NTB_EPF_LINK_STATUS	0x0A
-#define LINK_STATUS_UP		BIT(0)
-
-#define NTB_EPF_TOPOLOGY	0x0C
-#define NTB_EPF_LOWER_ADDR	0x10
-#define NTB_EPF_UPPER_ADDR	0x14
-#define NTB_EPF_LOWER_SIZE	0x18
-#define NTB_EPF_UPPER_SIZE	0x1C
-#define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
-#define NTB_EPF_SPAD_OFFSET	0x28
-#define NTB_EPF_SPAD_COUNT	0x2C
-#define NTB_EPF_DB_ENTRY_SIZE	0x30
-#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
-#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+/* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
+#define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
 
 /*
  * Legacy doorbell slot layout when paired with pci-epf-*ntb:
@@ -132,20 +106,20 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	u32 status;
 
 	mutex_lock(&ndev->cmd_lock);
-	writel(argument, ndev->ctrl_reg + NTB_EPF_ARGUMENT);
-	writel(command, ndev->ctrl_reg + NTB_EPF_COMMAND);
+	writel(argument, ndev->ctrl_reg + NTB_EPF_CTRL(argument));
+	writel(command, ndev->ctrl_reg + NTB_EPF_CTRL(command));
 
 	timeout = ktime_add_ms(ktime_get(), NTB_EPF_COMMAND_TIMEOUT);
 	while (1) {
 		timedout = ktime_after(ktime_get(), timeout);
-		status = readw(ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+		status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
 
-		if (status == COMMAND_STATUS_ERROR) {
+		if (status == EPF_NTB_COMMAND_STATUS_ERROR) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (status == COMMAND_STATUS_OK)
+		if (status == EPF_NTB_COMMAND_STATUS_OK)
 			break;
 
 		if (WARN_ON(timedout)) {
@@ -156,7 +130,7 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 		usleep_range(5, 10);
 	}
 
-	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+	writew(0, ndev->ctrl_reg + NTB_EPF_CTRL(command_status));
 	mutex_unlock(&ndev->cmd_lock);
 
 	return ret;
@@ -224,9 +198,9 @@ static u64 ntb_epf_link_is_up(struct ntb_dev *ntb,
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	u32 status;
 
-	status = readw(ndev->ctrl_reg + NTB_EPF_LINK_STATUS);
+	status = readw(ndev->ctrl_reg + NTB_EPF_CTRL(link_status));
 
-	return status & LINK_STATUS_UP;
+	return status & EPF_NTB_LINK_STATUS_UP;
 }
 
 static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
@@ -240,7 +214,7 @@ static u32 ntb_epf_spad_read(struct ntb_dev *ntb, int idx)
 		return 0;
 	}
 
-	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 	offset += (idx << 2);
 
 	return readl(ndev->ctrl_reg + offset);
@@ -258,7 +232,7 @@ static int ntb_epf_spad_write(struct ntb_dev *ntb,
 		return -EINVAL;
 	}
 
-	offset = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 	offset += (idx << 2);
 	writel(val, ndev->ctrl_reg + offset);
 
@@ -316,7 +290,7 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, CMD_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -331,7 +305,7 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, CMD_LINK_DOWN, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_DOWN, 0);
 	if (ret) {
 		dev_err(dev, "Fail to disable link\n");
 		return ret;
@@ -373,7 +347,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 {
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct device *dev = ndev->dev;
-	u32 argument = MSIX_ENABLE;
+	u32 argument = EPF_NTB_MSIX_ENABLE;
 	int irq;
 	int ret;
 	int i;
@@ -387,7 +361,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 			dev_err(dev, "Failed to get MSI interrupts\n");
 			return irq;
 		}
-		argument &= ~MSIX_ENABLE;
+		argument &= ~EPF_NTB_MSIX_ENABLE;
 	}
 
 	ndev->db_count = irq - 1;
@@ -402,7 +376,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		}
 	}
 
-	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
@@ -494,11 +468,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
-	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
-	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
-	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
-	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
-	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
+	lo_hi_writeq(addr, ndev->ctrl_reg + NTB_EPF_CTRL(addr));
+	lo_hi_writeq(size, ndev->ctrl_reg + NTB_EPF_CTRL(size));
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_MW, idx);
 
 	return 0;
 }
@@ -509,7 +481,7 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 	struct device *dev = ndev->dev;
 	int ret = 0;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_MW, idx);
 	if (ret)
 		dev_err(dev, "Failed to teardown memory window\n");
 
@@ -524,7 +496,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	int bar;
 
 	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
 
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
@@ -562,10 +534,12 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 		return -EINVAL;
 	}
 
-	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
+	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_CTRL(db_entry_size));
 
-	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
-	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+	db_data = readl(ndev->ctrl_reg +
+			NTB_EPF_CTRL(db_data[interrupt_num]));
+	db_offset = readl(ndev->ctrl_reg +
+			  NTB_EPF_CTRL(db_offset[interrupt_num]));
 	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
 	       db_offset);
 
@@ -631,7 +605,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
+	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
 		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
 		return -EINVAL;
@@ -650,7 +624,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	 * doorbell layout, hence -1.
 	 */
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
-	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
+	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
 
 	return 0;
 }
@@ -702,8 +676,8 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 			goto err_pci_regions;
 		}
 	} else {
-		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
-		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
+		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_count));
+		spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
 		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
@@ -743,7 +717,8 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 	int i;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
+	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_DOORBELL,
+			     ndev->db_count + 1);
 
 	for (i = 0; i < ndev->db_count + 1; i++)
 		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
-- 
2.54.0

