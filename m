Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475403;
	b=QIHxzGbxA+fJW1wKDxnNpaF5tTABAGE520t8xMcywkhp7t44WEuBwgNsQ0ZW1ocVQ8uh
	 daUgK17bpW32XCz+2IKesRDtEjsbMKKh88lGZVyMK1fQ+2Y/PyDXo2K+5qtHHpyfXapEf
	 qBBnoUNq3fuiM03NYPR6cDyQvI91NCc2zgQPzD5IJ8XuZQTMKxJ2gCalp1rHuKZIcWgW5
	 5XcufLMWCHJgBCNWfBqjHGl1BBCrlKuztTYjBUG8hiZ7z1z5OVdbqbp2eJFWOMgwh130I
	 adkF2etkft0REF8h9X12t4Z6365pwmS9aai6xAe3Q9W0jhiVh31HkuqwCfcCqKl8u3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475403;
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
	bh=h8/BMVxirwtbfiNXrpAfKdNzo6jdSyh5JsEDqplJkY0=;
	b=4t9/vJ3FJq11iesDelm1+HEQ1xwpehi+YtEPXI1TiDKtQr31QH8+3n1J7TPhUIIR6lJi
	 oFkLFVh0RIlUiMqvHSbVeoHc9484GRlSxejqRW9WC4GnF9Sf8tm7FTC+HJI23dZtQLEhz
	 HTfQs+lEu3yweIvJss5T+EnPGfpXBpUdax/E3fYO90RpY4i0pGmh49hJs0JiDDYtfhSqk
	 vdoj56LurdlAoSwfogk+Ikj+EqHyapNfqhxPItiVrICsgXU8oie1kI36x6/05sfZ7Kpv6
	 LE4VG7y8O+vDft+X6TJRCuAVBxP4219Xi6Y+Fa2x3uJPzx4DqFd0pgkKuvC4ba2CQlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=rZxU+zuo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DD606A329;
	Tue, 20 Oct 2026 05:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D95DD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=rZxU+zuo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTlk6BFHj+0kHyyhtSej9De+dY+G1vDcq6zxfHdIvTCRDZykCvsvCx4X9MNvqRO+Tw1XzhB3VDi7zlh4AdkAgyealCFhoqeQhVWSceViv19ltlDfZw27asjVgygE8cwqi3tFXuQLBVQfYrSALeggeKXJRBQ1Mf3eQP9QWRZZb0XjL4HZ6NPru0NOALk+NJrjRU2SabLrWhVc9uS4UwiKl3LJEj2ANLuL6cDu1+Br/mBW6hUJNao0F4v/ve2ODj+YzJAx5FLRTOfyZzTUf3BXyu62Xqp5cLYR7nNVYXYIIB3ALsUZuFQJtuNZ2z1eLT5hQFXyXzz8vSAxnbjpT5fEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8/BMVxirwtbfiNXrpAfKdNzo6jdSyh5JsEDqplJkY0=;
 b=EIww2TBawYCbrxce65MFCWdxSiFp+IoXA19+JqbUiPv93Eak7YspCuvkvNS9hyrUOaXpC+CwqCqBMvvsBoKvCXKGthmdcKhD34/Dqhbb1uZz7T/Wqitz1rlZbYN8H7csAskRe1qImXyXMwd1wpyc5htPYnEFWk/HosSoLxaZxh3vqLl9WnFkSl63Q/L6V6aWhG+DHn4vjevPMNIklTaERZKfryK7+abA0u8pbmLgVvJR+gNRiUS2NTYxvDRBNkyLQ7qfkNZedwTsk2NIOMjp7r4IUa7qq0JLuIlthepybJi3/p4CKtwL5lIvIFIHvgiQWSwcrKghtCMb9wBrniCn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8/BMVxirwtbfiNXrpAfKdNzo6jdSyh5JsEDqplJkY0=;
 b=rZxU+zuojY/zASZXrTSlU0ckQbvPXGqAMZGm1WlOpP6vnlUECgchs5yn9BwKeqQ7231fu3yCuqSjeykG3o489KSmOHR5DKkR1eMMGEqPtZMVd74gwHkigVuZ3OSAwlYE+rOwM38bEtsdpH7mxLc1VH9+rzesZWPNBJMEMaQzh38=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:55 +0000
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
Subject: [PATCH v6 4/8] PCI: endpoint: Add pci-epf-ntb.h for the shared NTB control layout
Date: Tue, 20 Oct 2026 14:49:44 +0900
Message-ID: <20261020054948.1218370-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f254b0-08e1-4605-c638-08df2e6df7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9B5nz8tVnX6U4OIn3vdb5NbCTJOX3hShPgMHctgQWyMgSaHVJJ6Qeucmp5Y+q7ZYoehCg+WLiLO0wRXr5VMhW9f+u9rn0MtjKUhzRjgw4I80hIe5uisJAhMfT/ldxVEG17rUSLCRQCyqKWpUPHE2zMZw4ELeosE6BX7+lWMbqpQicmUCkG8p7kAKjjSI1wD+cEKlbiMKfiGvGknNvWtgEHG8c/X6oV8QJqCmfFioqfdJ8oyPt5ss+jvYfvF6NVqb6okVGgRftaNGa/ipo3cf65JpUprNPW2cqoC0BLDARQv2CY8Dxar1/Txa+UHu8e3gbg6Cc7ufGn3sdEFyD+4/kOXjJqZVWCk4ufn0QMwKugCnf/A1C41YagAnHl9D+Q7Vk+Dg6OdV8j0SZOuCUdTTgYi5Z9PICp19xrC5Vz76zusbZL76Gay2rC6loA/4DzK4OGz/3dDwq8ncibdgX0EnqAXL3XOAuPet+LxrMfbnlR0jrX3dU7l3LXcxGeic9XWpHArF5/D4Jhi+XA3VDJHKLzQOBBVFNBlTwhQMW5cHHvQlYGyGzhFZcVunDCGJSOuB0frYLNwm5tvohsadUtr0T797feqGzpYn7o11NzeoeV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?taYsl1Kj5Zh15sVZ0mZRW0uPAzvqVC36zj8sGT5SjkQMKwOJCx4OLzrJMt+o?=
 =?us-ascii?Q?ZJxP2PU5iiQI6UgikfIQuUZV0qs1XHzrJjdWy5KeF6F4N3sawCadSfPFJmyI?=
 =?us-ascii?Q?7Q9Ev7En3uNpvSPBWW9pDJVew2qH8sOqWx7CZI2+CEMvkl6pSHpOdfHN7gcw?=
 =?us-ascii?Q?bWEjJgTUctVUOuKQ2DJSKgmzY3rI9Bz22g6s8E80ltFvckG+BkvsI94NiPvS?=
 =?us-ascii?Q?NwH+EECKf105kv4QHp1J8gyFLWHu051EXIVdEF9xHM7QVBq6Z4ciJhhSxQWH?=
 =?us-ascii?Q?s9J4CxrNEzItYxO1dr3sfzk148g2ixS0ME+eIviimVeMmZtMQJ7dHBOr1nVJ?=
 =?us-ascii?Q?J1p6wj4bal1J7XvlZnqR7fpitxApARtL2RE+jJjDxzvdNf73Jmr4dob1EhU6?=
 =?us-ascii?Q?JrA9o1xUm6KFSzNB/b56Cl61MPo4kszlgsXvAjA406CRzDZJkbDlth3znbw4?=
 =?us-ascii?Q?HwPH2LOaggna7Pfw3pal5Z0W07OuYS109LXR/3jnTyenjDoLTxmEK4xMJr7r?=
 =?us-ascii?Q?1R9Q/QqmJizY4icIfZiQ4ttxU26LlVXw3hxp/bVKZH9M+O4/SJN0LzeCj0vQ?=
 =?us-ascii?Q?RzoCoUg+SbLfIUHKbhPSKiRHM/MZJb8IQpWwLeXaoEZgh+9I5zyNL2ehekH1?=
 =?us-ascii?Q?FY0KMfFBpwrzRbRE1rfEtCcIaVmFsgT4a9uZqBekUf+zX9mvyESyUTYsw/g/?=
 =?us-ascii?Q?lz6xjILnrmh42bPwchISzCPBrXVQmBR2RqLvw9/i9x8tgYLAf6WUdxYTpldp?=
 =?us-ascii?Q?EGFGtwXH1UOfDjYB2fuzuzDA/mFvJS+tJdaXZeOX9GXC3Fk0ETSPUKXUpNuD?=
 =?us-ascii?Q?Upntpzm2xifFmEy71LywlFt6RnC9IcBUJVO/GjkM15jld5ko45iLODSv52wS?=
 =?us-ascii?Q?DZLkklYaBz/lC2/zEa3SU10Mn4UriS3o8C+ng4s5Fy75lTJASAbMQtXAMNJY?=
 =?us-ascii?Q?V5/TFNKfp9yVSs6R4Tj0rMoVQ+/cgRhSv94tdGpDdbWgIAQ45En8fKXxz0T3?=
 =?us-ascii?Q?7MRDiGBTh/8t6lTQJEvJasA4eQ70UCVyRr8/R3CO8eF/fr2J4AFyL3Ddukf4?=
 =?us-ascii?Q?/O24b21bN/4bzu6lXTeVAVj2EYmcyF6gGRAmc5sIiLtPnNGfDvCJYKwAYeaM?=
 =?us-ascii?Q?EGKTb2j4bTxk1SnYILX36MBrBRFpYcUUj/3OUFNDdMHD/EgugtacgHS6Y+Vi?=
 =?us-ascii?Q?9lW3GW+KjmNxdFvELMpg/nELENgRjQ/nPeP+Z8NWGszLMOU6nidrtRm4PImj?=
 =?us-ascii?Q?2ftTABG98sKWoezXQ/y9sOx0G/9+8mGxS/RNqY7BuIydsL6CdKfhDbzfxsdL?=
 =?us-ascii?Q?hdGa+8UhPgxZCRfKcv24Y5kOXKIRicsNq5MgqvZ3LCAFu4p89S403BMmwnh2?=
 =?us-ascii?Q?PYqK6Pt5UWySVsIkF/HRdaAlRo2zX85zvEMIC7/yYduBM7QzF1sTVsm/f4Tp?=
 =?us-ascii?Q?5jqf8y+Kk69www61rr73Av24pgVJrUA4/cIHRgl12qO7Rmye3tMWXsymj1fH?=
 =?us-ascii?Q?TvcJDSqIkXtcAvIGEvhM6l97TQefin35gk7x136QzzloWb3MMN4Q0ZfVqd/U?=
 =?us-ascii?Q?5EElGmAQPe1N0SIXHH5NJ33w/umFkHNHcKshDGwfzMSlasWU9rEs+Dj0AshS?=
 =?us-ascii?Q?ItTEKgw/OY5jxBk7YnHsVbwIiYqovYw0yAOBAAuULCCz889in88x8H5g3wEk?=
 =?us-ascii?Q?Z4Yy0hrivO3qZ9trk/k3xhdE83kS+m4YwxvTFl1H4DiBtmve3woxDePZ36QX?=
 =?us-ascii?Q?CPODKhd9PGvB40FJwuJYUCzCwnwT+3vXasHIN2B+2L9X7O+nz3Ca?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f254b0-08e1-4605-c638-08df2e6df7d7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:55.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaxmrUzTo3YdC54VxBoTBdd+oL2wzTC8LC/NTi0HkN8fF81JwGAoro+mQL6EuLyYNZt7FhxAOAYB4yzlbrChBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
register offsets.

Move the shared struct and macros to include/linux/pci-epf-ntb.h, and
have ntb_hw_epf.c derive offsets from the struct with offsetof(). The
vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
what ntb_hw_epf.c reads at that offset.

No functional changes.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - New patch. (Frank)
    https://lore.kernel.org/r/as5F0EQB3owMYmFV@SMW015318/

 MAINTAINERS                                   |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  95 +++++--------
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  85 ++++--------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 +++++++-----------
 include/linux/pci-epf-ntb.h                   |  48 +++++++
 5 files changed, 163 insertions(+), 197 deletions(-)
 create mode 100644 include/linux/pci-epf-ntb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 160304cdff7a..f192be243435 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19882,6 +19882,7 @@ F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
+F:	include/linux/pci-epf-ntb.h
 F:	tools/testing/selftests/ntb/
 
 NTB INTEL DRIVER
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
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..925cf46219d7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -41,27 +41,13 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
-#define MAX_DB_COUNT			32
 #define MAX_MW				4
 
 enum epf_ntb_bar {
@@ -104,23 +90,6 @@ struct epf_ntb_epc {
 	const struct pci_epc_features *epc_features;
 };
 
-struct epf_ntb_ctrl {
-	u32	command;
-	u32	argument;
-	u16	command_status;
-	u16	link_status;
-	u32	topology;
-	u64	addr;
-	u64	size;
-	u32	num_mws;
-	u32	mw1_offset;
-	u32	spad_offset;
-	u32	spad_count;
-	u32	db_entry_size;
-	u32	db_data[MAX_DB_COUNT];
-	u32	db_offset[MAX_DB_COUNT];
-} __packed;
-
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
 	.deviceid	= PCI_ANY_ID,
@@ -156,9 +125,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 		is_msix = ntb_epc->is_msix;
 		ctrl = ntb_epc->reg;
 		if (link_up)
-			ctrl->link_status |= LINK_STATUS_UP;
+			ctrl->link_status |= EPF_NTB_LINK_STATUS_UP;
 		else
-			ctrl->link_status &= ~LINK_STATUS_UP;
+			ctrl->link_status &= ~EPF_NTB_LINK_STATUS_UP;
 		irq_type = is_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 		ret = pci_epc_raise_irq(epc, func_no, vfunc_no, irq_type, 1);
 		if (ret) {
@@ -562,9 +531,9 @@ static int epf_ntb_configure_db(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	if (!db_count || db_count > MAX_DB_COUNT) {
+	if (!db_count || db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(&epc->dev, "DB count %d out of range (1 - %d)\n",
-			db_count, MAX_DB_COUNT);
+			db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -648,50 +617,52 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
-		db_count = argument & DB_COUNT_MASK;
-		is_msix = argument & MSIX_ENABLE;
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
+		db_count = argument & EPF_NTB_DB_COUNT_MASK;
+		is_msix = argument & EPF_NTB_MSIX_ENABLE;
 		ret = epf_ntb_configure_db(ntb, type, db_count, is_msix);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
 		epf_ntb_teardown_db(ntb, type);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, type, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, type, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ntb_epc->linkup = true;
 		if (ntb->epc[PRIMARY_INTERFACE]->linkup &&
 		    ntb->epc[SECONDARY_INTERFACE]->linkup) {
 			ret = epf_ntb_link_up(ntb, true);
 			if (ret < 0)
-				ctrl->command_status = COMMAND_STATUS_ERROR;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_ERROR;
 			else
-				ctrl->command_status = COMMAND_STATUS_OK;
+				ctrl->command_status =
+					EPF_NTB_COMMAND_STATUS_OK;
 			goto reset_handler;
 		}
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ntb_epc->linkup = false;
 		ret = epf_ntb_link_up(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "%s intf UNKNOWN command: %d\n",
@@ -1298,9 +1269,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	func_no = ntb_epc->func_no;
 	vfunc_no = ntb_epc->vfunc_no;
 
-	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
+	if (!ntb->db_count || ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (1 - %d)\n",
-			ntb->db_count, MAX_DB_COUNT);
+			ntb->db_count, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1a0ce31e680c..3adbaa9d85db 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -47,27 +47,14 @@
 #include <linux/pci-ep-msi.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-epf-ntb.h>
 #include <linux/ntb.h>
 
 static struct workqueue_struct *kpcintb_workqueue;
 
-#define COMMAND_CONFIGURE_DOORBELL	1
-#define COMMAND_TEARDOWN_DOORBELL	2
-#define COMMAND_CONFIGURE_MW		3
-#define COMMAND_TEARDOWN_MW		4
-#define COMMAND_LINK_UP			5
-#define COMMAND_LINK_DOWN		6
-
-#define COMMAND_STATUS_OK		1
-#define COMMAND_STATUS_ERROR		2
-
-#define LINK_STATUS_UP			BIT(0)
-
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
-#define DB_COUNT_MASK			GENMASK(15, 0)
-#define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
@@ -90,47 +77,6 @@ enum epf_irq_slot {
 };
 
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
-#define MAX_DB_COUNT			32
-
-/*
- * +--------------------------------------------------+ Base
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * |          Common Control Register                 |
- * |                                                  |
- * |                                                  |
- * |                                                  |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |
- * |    Peer Spad Space    |    Spad Space            |
- * |                       |                          |
- * |                       |                          |
- * +-----------------------+--------------------------+ Base+spad_offset
- * |                       |                          |     +spad_count * 4
- * |                       |                          |
- * |     Spad Space        |   Peer Spad Space        |
- * |                       |                          |
- * +-----------------------+--------------------------+
- *       Virtual PCI             PCIe Endpoint
- *       NTB Driver               NTB Driver
- */
-struct epf_ntb_ctrl {
-	u32 command;
-	u32 argument;
-	u16 command_status;
-	u16 link_status;
-	u32 topology;
-	u64 addr;
-	u64 size;
-	u32 num_mws;
-	u32 reserved;
-	u32 spad_offset;
-	u32 spad_count;
-	u32 db_entry_size;
-	u32 db_data[MAX_DB_COUNT];
-	u32 db_offset[MAX_DB_COUNT];
-} __packed;
 
 struct epf_ntb {
 	struct ntb_dev *ntb;
@@ -195,9 +141,9 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
 
 	/* The link is usable only after both sides have enabled it. */
 	if (ntb->host_link_enabled && ntb->vhost_link_enabled)
-		link_status |= LINK_STATUS_UP;
+		link_status |= EPF_NTB_LINK_STATUS_UP;
 	else
-		link_status &= ~LINK_STATUS_UP;
+		link_status &= ~EPF_NTB_LINK_STATUS_UP;
 
 	WRITE_ONCE(ntb->reg->link_status, link_status);
 }
@@ -368,45 +314,47 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	dev = &ntb->epf->dev;
 
 	switch (command) {
-	case COMMAND_CONFIGURE_DOORBELL:
+	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
 		epc_features = pci_epc_get_features(ntb->epf->epc,
 						    ntb->epf->func_no,
 						    ntb->epf->vfunc_no);
-		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
-		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+		if (((argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msix_capable) ||
+		    (!(argument & EPF_NTB_MSIX_ENABLE) &&
+		     !epc_features->msi_capable)) {
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 			break;
 		}
-		ntb->peer_msix = argument & MSIX_ENABLE;
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ntb->peer_msix = argument & EPF_NTB_MSIX_ENABLE;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_DOORBELL:
-		ctrl->command_status = COMMAND_STATUS_OK;
+	case EPF_NTB_COMMAND_TEARDOWN_DOORBELL:
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_CONFIGURE_MW:
+	case EPF_NTB_COMMAND_CONFIGURE_MW:
 		ret = epf_ntb_configure_mw(ntb, argument);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_TEARDOWN_MW:
+	case EPF_NTB_COMMAND_TEARDOWN_MW:
 		epf_ntb_teardown_mw(ntb, argument);
-		ctrl->command_status = COMMAND_STATUS_OK;
+		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
-	case COMMAND_LINK_UP:
+	case EPF_NTB_COMMAND_LINK_UP:
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		goto reset_handler;
-	case COMMAND_LINK_DOWN:
+	case EPF_NTB_COMMAND_LINK_DOWN:
 		ret = epf_ntb_set_link_enabled(ntb, false);
 		if (ret < 0)
-			ctrl->command_status = COMMAND_STATUS_ERROR;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
 		else
-			ctrl->command_status = COMMAND_STATUS_OK;
+			ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
 	default:
 		dev_err(dev, "UNKNOWN command: %d\n", command);
@@ -518,6 +466,28 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
+ * +--------------------------------------------------+ Base
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * |          Common Control Register                 |
+ * |                                                  |
+ * |                                                  |
+ * |                                                  |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |
+ * |    Peer Spad Space    |    Spad Space            |
+ * |                       |                          |
+ * |                       |                          |
+ * +-----------------------+--------------------------+ Base+spad_offset
+ * |                       |                          |     +spad_count * 4
+ * |                       |                          |
+ * |     Spad Space        |   Peer Spad Space        |
+ * |                       |                          |
+ * +-----------------------+--------------------------+
+ *       Virtual PCI             PCIe Endpoint
+ *       NTB Driver               NTB Driver
+ *
  * Allocate the Local Memory mentioned in the above diagram. The size of
  * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
  * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
@@ -602,9 +572,10 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	if (ntb->db_count < MIN_DB_COUNT || ntb->db_count > MAX_DB_COUNT) {
+	if (ntb->db_count < MIN_DB_COUNT ||
+	    ntb->db_count > EPF_NTB_MAX_DB_COUNT) {
 		dev_err(dev, "DB count %d out of range (%d - %d)\n",
-			ntb->db_count, MIN_DB_COUNT, MAX_DB_COUNT);
+			ntb->db_count, MIN_DB_COUNT, EPF_NTB_MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
@@ -1258,7 +1229,7 @@ static ssize_t epf_ntb_db_count_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (val < MIN_DB_COUNT || val > MAX_DB_COUNT)
+	if (val < MIN_DB_COUNT || val > EPF_NTB_MAX_DB_COUNT)
 		return -EINVAL;
 
 	WRITE_ONCE(ntb->db_count, val);
@@ -1456,7 +1427,7 @@ static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
 	 *
 	 * Report only usable per-vector doorbell interrupts.
 	 */
-	if (db_count < MIN_DB_COUNT || db_count > MAX_DB_COUNT)
+	if (db_count < MIN_DB_COUNT || db_count > EPF_NTB_MAX_DB_COUNT)
 		return 0;
 
 	return db_count - EPF_IRQ_DB_START;
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
new file mode 100644
index 000000000000..0c02d709aa08
--- /dev/null
+++ b/include/linux/pci-epf-ntb.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Control region layout shared by the PCI endpoint NTB function drivers
+ * (pci-epf-ntb, pci-epf-vntb) and the host side ntb_hw_epf driver.
+ */
+
+#ifndef __LINUX_PCI_EPF_NTB_H
+#define __LINUX_PCI_EPF_NTB_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
+#define EPF_NTB_COMMAND_TEARDOWN_DOORBELL	2
+#define EPF_NTB_COMMAND_CONFIGURE_MW		3
+#define EPF_NTB_COMMAND_TEARDOWN_MW		4
+#define EPF_NTB_COMMAND_LINK_UP			5
+#define EPF_NTB_COMMAND_LINK_DOWN		6
+
+/* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
+#define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
+#define EPF_NTB_MSIX_ENABLE			BIT(16)
+
+#define EPF_NTB_COMMAND_STATUS_OK		1
+#define EPF_NTB_COMMAND_STATUS_ERROR		2
+
+#define EPF_NTB_LINK_STATUS_UP			BIT(0)
+
+#define EPF_NTB_MAX_DB_COUNT			32
+
+struct epf_ntb_ctrl {
+	u32 command;
+	u32 argument;
+	u16 command_status;
+	u16 link_status;
+	u32 topology;
+	u64 addr;
+	u64 size;
+	u32 num_mws;
+	u32 mw1_offset;
+	u32 spad_offset;
+	u32 spad_count;
+	u32 db_entry_size;
+	u32 db_data[EPF_NTB_MAX_DB_COUNT];
+	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
+} __packed;
+
+#endif /* __LINUX_PCI_EPF_NTB_H */
-- 
2.54.0

