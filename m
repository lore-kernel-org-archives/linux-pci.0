Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792657363;
	b=rEpbN0KsZQLMlwFXJE3GN39j363gaQoB0i+hDxWQG3qbxYlIaCfd8VLyZP90vUMMMu6S
	 PFPaGcRjKlll6mhlvN6p8biLurY0q/fni9etTY7ZHqjueZOT3R5M58VzpvdNlwrgvpGU9
	 q/0a/gPnrC99ryF2osEoV1WRS7a+ymo81JMmQNc1LY+uIvTFyAJ5NIg3TcNzo5XJpKe84
	 qnNZi0q7r1DmM6tKNQenlBnIRbfu7I0WVGcsEqkJqSndl4xqV46LOX67tdQfYJxkJ3lh2
	 Zo2YKfbX0uvj+O5coCDMbVEWHl/xENcboxcjBpucoE8iI5/EYq3HR0T4ZtSb0ebqZxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657363;
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
	bh=JF5fXyKLb1O0f9uU4POWGOU1VmSPiRKhMhAvJv/C8Ak=;
	b=cBWrKy13wYvOubUiDqFT/IoY8Pe3RZPA4tuyj8uWSiUkjKihnKkCaYj3IjiDbvzLFk2e
	 sPY1SkCMpf5FRgYD+rpcl2NKWTlW5UtAsCmaQ17bzxKOOL/fAgZTs7P/NjL994L0XOAei
	 brW1Rf0+iE1JFYEBGs3gpedbHMj8EutDEjaDDVU/mVnjVszBSFluxUiuv48ThwMXUJ4hI
	 0A+BIasyCRhJYf2TDREU3aiW+M5tLhgseZFsjwUzkWNfVu76k2yah9NdYNLfzjMwO0FhZ
	 zacExz+X12irziXkdMEbOxlMGa/46c94QQ0L+eqXsnMLimkNeFaW18FDl4JBAapwwuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=AMoPF6qo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.140
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020140.outbound.protection.outlook.com [52.101.228.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92909606A32A;
	Thu, 22 Oct 2026 08:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92909606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=AMoPF6qo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=If7/qhONaTMHdxCkSuxEDhalqCdsk01wWq4MgPaJXDPMxNXt8YBzUySkY7tfdOc/Opn063Knh4NIFsBDC9bA0HY7yzMEOqgFOURhEUxtTwGB87rsjp1X93JofWjwuHmyoZHzlSMz/lGalLwWfC99vOyR4Y1TtC3Foy6/mArnI5RTIhV+u3s2gU3e3ZeF8BagiEjkBZfUeDBR9SZneW6t4oAbkAo+rm8pWmdQ9bqw50x/xQC/JDOg9OWgWuMFTuU3rg+4lEKDqfOxgN81GZn4TChfg8C/qusLbBwojD5yJ0yLP97NiTupXcDz8IYQhqiIlzUT0SvNVGbHL83jo55kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF5fXyKLb1O0f9uU4POWGOU1VmSPiRKhMhAvJv/C8Ak=;
 b=kAJmWekLyqegxxeXcDpImnmWDL8tFX0ndWK2al4WLcKfGkYZMm8mpX+vXcyckJQ/OfDQEzSW/La3YcfmtiVPSnfwyw/FXVPsVeLgFu8HT9G5J/h+unDs0hjqS078M5jOtjV2otOHOBP+vKps/WZfxLVKtLRtYyzvqNEHzPOfn2wNDTiOzEkgeL3B0a4uIa+7QeRNpxt93uzI8KRLA77fcJ14Yl8OGd2l053SVCgwA+dHNOjK9BERPaJUExhCec0EHJvuVgMcXHVKbdsxlxczbxgJtufcelVlC4tDsUSm6z0Uq69Vj0A/FsxLVIU0VcIiPozFbAsWs9T7chUGtG7SoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF5fXyKLb1O0f9uU4POWGOU1VmSPiRKhMhAvJv/C8Ak=;
 b=AMoPF6qo0uZqRGieksowu0G2sNsDvF4JvLun68z+XyAhFSuy5Cv45lPAnNmqaQEPX/7qz2+fbPnXpL+zLZAv6aMEE7NsLt898A9F4K63CVWLMgo6Rq2UyQ7L9PDTUbadXfOFLeF3uCIYEk0/9sYRyAB5Yxr8BVhxs6WXy3Uztic=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7221.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:458::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:22:40 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:22:40 +0000
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
Subject: [PATCH v8 08/10] NTB: ntb_hw_epf: Use the shared NTB control layout
Date: Thu, 22 Oct 2026 17:22:28 +0900
Message-ID: <20261022082230.3164834-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022082230.3164834-1-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e4a320-b2af-4a86-934d-08df3015a37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TRZFtuOdJvLiIYFEtjGdxI0IxeuYk8Tt2PiZaHzzKTB5NJMffCXLGyPJCRoKk7DjHC+399ZN2N6VqqTUc8wQHqq/z7lYw59zx/AXwAhHfiJ2VybsjuIN7nawIkYhlar7KjdLF9JgUklb9pXTU/KoyMmMigkz+QMJj8eyze0kPLH+alLJGaEKilc0/gn3/oXnqIpz9x5Uh2n5cgjrpPqY2OzdCDWHPj3ESSZrF1bMxdA/jPo7ZynHufGZ7fZ+P55Ba7iFAvMiJfeNlssuN61RQWD7wFPzRf/fQp+BPX5cMWGCTkBNvPPsq5iQCE4GzSSsK0jkHug4+oaFD/5BWxAsq5wcHqz7EnRZqw1ejotVAGm61/WWHUm3tQjms3Fz6Xdv72suI71/bTAklWI+/As8C8/ORUiZP4mH7bsD5Dv2+FQmpxlq/czccdD1LwTRm3yzTA3YB4joaUrTQaUj3p7iDaEnJjxaqD38jYgBSh/vZMyGj2muJFr6UfGM61eEpFHyGosxjkjNWjzh6uT+r+skgab2hNdMfNtSVoPaIBi0SsjQbQZEormQ8HPcgyDIF4zP93Gwv3ttr3aN1DEDdJUaFtgJiCrb5UKp++tH+3e3zp0f2DZOUn5KbSxX2g8zdgJuZUJ1MfqxtvXY/HoWz/8+aILLdaKz6DTwJ3mkMoeZTZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUvw3UtnMP3dQ5qlfo6PSQ5HjKVICVSXtYIZ3mpsH97tHMSiVli+Wnqaryld?=
 =?us-ascii?Q?VCm6lI2mmwOJLTOq6cyhJf9jqCiEegwH1CYIs8s6H9kdtvm0Ju57H8LCUi8O?=
 =?us-ascii?Q?m8jX/zn1ORxptt50eB0oXVQtH5LB7z8g+INLooM/0UVsp9IXQCuap/ttgQnH?=
 =?us-ascii?Q?iQcHMGpIV/v7URBGAFSiPjvjGBAduJDxYeAZVCefHqV+Jd8aO+u5zEi5rSa0?=
 =?us-ascii?Q?vHITxX2X80Ht7aDpr+5F5XRga2OjnXt65vvIs2GYnq5AjFfaIKcVN7brUEva?=
 =?us-ascii?Q?fGnA6dE7ZK8lFVsqAAl1QVEEh2/3+dF52XdQ+fqvgz2Z7/XwpU6u2VhsDENa?=
 =?us-ascii?Q?zpJ0VwSAdVj+T92RUzXwn2CdrtBt0o80BAQMhisATJqcGrATAnwLUu1FAs0K?=
 =?us-ascii?Q?CFFGsRZDvkCFWhs2GWdzDfd0LskfSeNEnZrNGl1WHsuJZGcAGmYtlBKMvDio?=
 =?us-ascii?Q?LjB5uT2k2sdWmtKU30rIla7S8lipYNLmBOp5+I8QiLPdv2rWJFtZ3beDagYd?=
 =?us-ascii?Q?07llyn2AD+ANj5AMId6SGkaipbUBJn8K6h30qjU2esUOgOoAOKsSdi9kk1wf?=
 =?us-ascii?Q?UJZ8SIfkpr0Y/u6QP63EOu5+PBf6nmh3ALfD8I5jHtbm422UGQpwRtsoy6XK?=
 =?us-ascii?Q?efsQ3L3ZIHBMLWgQMMWGz0Gt3yIO4/Em4d6NQ1BSHz5iU6ljSgMMtVizpiUk?=
 =?us-ascii?Q?nCAfvgHy3cWx0+PdQEk1/0hn1NoLiQwS9LMkiTSEIoNjyHQ37vz7VJJEm27x?=
 =?us-ascii?Q?CiHQwyRu5zq/APZbbRnOhFxFNfNhQo6uZ40Ds9oG0V0/TEwdcjJjvBdc+pn7?=
 =?us-ascii?Q?Fabt69iRsdvAKtj+xPjuhXBDMQVsl+X41EAkXJWiYx+h200eMSrnF6cD0xLI?=
 =?us-ascii?Q?rBwJtTGuZb4gdbHYg3I2F9oDxKhcmNnFmqmALclwUQyUNJCOeXfnf3pugd+n?=
 =?us-ascii?Q?2L31d2YK8NgWipbxUE8mC+eFbdVdMcUk92hVpDb8sZ853pj5+omf8oUf/jMw?=
 =?us-ascii?Q?MoqYbyLsakE3feSOZ8Rs4aYXmMpdDeM8h7VHBsfNwdC8H3mAqLqrw7ooFyE7?=
 =?us-ascii?Q?K80jp+fevV0V6YGF8bCW/mf2Vzhkk9z0cSBTtHxLjlyzKmVrWuos/BujeMai?=
 =?us-ascii?Q?WFbI+Oon2BrCUJ6YHCRnxXBCoAIPEwiadsISlMnTQFREssCAQK5Ca0/fMJOR?=
 =?us-ascii?Q?jBRXBx3Zt83d2P84TZ1rW5Hh+FjPJz6QrbJl4ru+L2aIpyhI9aeIqdHffz77?=
 =?us-ascii?Q?fwunatUKlyow9B5tbSdF3c1qBs1PVfZB5xHkBX2fJxAtUPkkb6l/KTJ3lx8b?=
 =?us-ascii?Q?flO+qKo8w1DOxo9cxzpEpD/ztWAjUY14QQvSkFrC5ikrWXBZVObH4JbkGd2r?=
 =?us-ascii?Q?G5SmQqvrleOMOCQ3C+MbknfpvmaeO/1e5Tc1gpgPmCxQkKcHJ1CiD2JqiqJW?=
 =?us-ascii?Q?aBEWsOkkGiWpoQK1wXRlloiV+qx8TzFiVt+PQOrTdC80+BzETll/F4ousvgP?=
 =?us-ascii?Q?Y5Za0HqjtTpPcTOuIBD1jxAN0f1cFZWGjm+W6Rb2FVO77PsvZTZ02rkWWK0n?=
 =?us-ascii?Q?ptLewq3UxzeCedgbUf4BCQKPPxxIUijs3uFs5Bpa2tUA/k5DExzMUT68Ukcf?=
 =?us-ascii?Q?BqTz4VMY7JwCijyeDvc1OxDQYMsy9HimZrw0GuEAaNFXyYRHHk3jMlT+tMg/?=
 =?us-ascii?Q?2+TeIvrf1qt1hi4E1HmpcCyRfzuIjMUfljnE7VDvaDhnxHeaZCzkMZbJ89tl?=
 =?us-ascii?Q?DWNZjYKnbBh1mCYMVvqaQNLLHfDrHZirhszHdtihUjarluBsfnMf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e4a320-b2af-4a86-934d-08df3015a37e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:22:40.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re173aakHRcgtiWZoXayET2xP1XiD2Xr9fDpEnUYk7LxXkzdNPDxgL9/T3m38W8DYZBYhpP7pgEiigLUdK+Zkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7221

Currently, ntb_hw_epf.c duplicates the endpoint control layout with
hard-coded register offsets.

Use the shared struct and macros in pci-epf-ntb.h and derive offsets
with offsetof().

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v7:
  - Add Frank's Reviewed-by tag. No code changes.

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

