Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299117;
	b=TCwA5GBbxLlNqcFyxMeQ3iT8rr4yYXOJN0XoCrH6QtyF+sh9e0T4DBoWjm/yl1pVlUOY
	 gOoDCw69T6xF7RdOAKQqEvKC3/0aDq7Vj6u3rjO96BGlJXM/YW2viBDcJPbqr6IQVAHmJ
	 AKrFAgL4o15AyDAXcnoPIkFK2YouhwkPTcOek15KbawviqWieJanL9C3dvjfBzdWvpbI3
	 xH2qVintHXInoPzzIYONnieh2FLvodN3U6jRD2NqtXvEoa9kl/Kk6EcBDUflTOq7uMm7T
	 8/67Q+Oe+D19QDFySd7yySzU+V94Y5Wt/w1I6VvyXWT7AV/O3BNHEUYZuCymK2VYATQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299117;
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
	bh=OXxQTolNT7W1/jsAoTtSUQsFSqCkQtQV6ZBvANSCGGc=;
	b=AuhPNKiY0McT4qa+EhHu9ye8zc9MGE/KKHLYb4S58dUibI7zMcD3RAyQdGPQfBwIxZZS
	 KKhQLU8ILWJyHRiblNfKf1L4oKAwHcAcK88hWsAsoe8AXB86vFgEJOJnkKEHu9dWC3ZUo
	 6j6fZ2LTprGoIbPxHY9EWKzHZQ2e+5ds6z5qrIqHD3z2atJhGI94gHOCaPzxewwjbl19J
	 j4fFV17lkVtVXxbd4bb8JUXM07dRXZJifuyPvTAQZ64TNILIDix5gHs468FsdPjk+ZhDQ
	 3kpRw9RfVIyKth9zGvvVc3k2QNAfPdZ6rquhzDEKyEk4Fj1opC95uDsoEe9uvZts9Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cFQsHqdL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.111
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30260A2628;
	Tue, 10 Nov 2026 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D30260A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=cFQsHqdL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDtj7548mEIjypYb+UpkOXXAWszzoF3j9T5mS/TpUGBHuyoh+WhiE9D3X+NJVh+tPwLy6s2Ig/kKKnNidd4Z97atlPHmOocfXGRT0O1JkkZhvs4u55eWqLsscsigIAd+vGl6nDqwDidWzJPeRpiXlPh4PE0nAPgmNhacN5El2DwYxtTTpmpdV0GYa33p8QxKhvWCE/Ai1/9qpD6/QYOv+r/tIM/Rmay4wbHy3px3QJLwVcnDax4rX41VKHzffS93NpS6qXxXqZvCQBOWp5urZoPEaZssRlvIY7e+mWj1NLUex2P091nudsnMwN7rgMJyd75K7lIQkGNzp890oh3ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXxQTolNT7W1/jsAoTtSUQsFSqCkQtQV6ZBvANSCGGc=;
 b=HBWXgSjojxd6LO+kOGde4J5GV2R8kNcvOSVb3xdOnOFyqJdG1M40dPFN3fcIkS4BpTpxZTa+zpCGW3jr9QsWeAqGGi6iruPcMnvbHKolEVKFCdDgspGVecImm1aLxXdV5lFXHt1s5ghJiNYWv1BrjzT2VrXfj61T7sAzcz2Rf/fcXAKM+dTRPS6SNmX4jNrJ0Su8hW41KFL4qUl3JTeRvJtRM9VJfJODRFsIpyab2FYb0yfn5ARMlsl0SRKcXYfdQqkC8kB2MsmK4agku//pJNxW9EYfkYwEwedrXz7/qPSMXBEq5QwrBVSedUJ5/9PKPegF8jG6QkgoJhH0RTToXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXxQTolNT7W1/jsAoTtSUQsFSqCkQtQV6ZBvANSCGGc=;
 b=cFQsHqdL9CnhPell2t0Nzpz/vdpqBfFsLUw0dG7JZM/xTPSpuqwDggHSQfliwv0hlfRxW4Q+pkoWt7p2Il7nXJ/qwCu8INLqPyJQ3M6MH3Vd5zvL83tRtnQHu8AaPrzmuOgKNK46g9K6yHqfSHLrJTdTJPwt4ofypkjNIOsaxBY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB3015.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:10 +0000
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
Subject: [PATCH v9 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Tue, 10 Nov 2026 17:24:54 +0900
Message-ID: <20261110082459.1798763-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: c9d94e14-492a-443a-6ea4-08df3f0422ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|5023799004|56012099006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|261022115727099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	117kdvCVP27k735ASYqRjmCSOtniOLijo4x4P7pt9+lAC+J+NUEwI9kt5XH1r6gmb5LAccPrPS738g39dUIkIwp0kVJoESp9RdxmRSWwWBF7VrwHnU1BHXgj3eerDLG62NOreTm+mpjY4B+zdP0YpGX8VqWsFgmqf9nAZxIJ2JNarRLNdxehg3Gfu93IYuZ4UhK/16NtVTdTKht9YWTFm1C2teb7aN+tgZg1heacfB1QWp8+maJZMg59R9uybLjrG3yh+T1AcxzWYFn8BTOrSGCbffGt72qiM0bhp82g2nJR6ip8Qn76siRB5NdfLBTE440UEfePvKOVfBEYkbxtHkc/HTCHe0ClmG2F0ioC1gG0r2G9bnu4CLW6w8rI5E9twponk5E0XCQeXa7Mk1co/aXqBchgxKv9rmJQcMLNHl9gTLuEnX+jXN4BngagT2UQvnDKYE/Kc8N73D3ME9/DCvY4IfNrxk5mq/toVa1sXOFrY7JiecQTq9qVrgWv8iFAeY2BAgznrBHozgEbuZays85uxSyYx0OtkUSXCgosylRlOtNJgtnjOKQA/pWp2jUYlKH/K32kSq4ooTYnV4imptI8xdpGE+YjcCVFFdJ0XMVIm8HZXbrWUvWVAWvSUgEw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(5023799004)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022115727099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oph8MwUHrs454w7TbfQ520RiHPmcWKktnR39beff4M9cxHVzrpuZYQTtlg5c?=
 =?us-ascii?Q?jK7T+4insUFPT/drh6A4gtxn/kWWdQ/wfvcxeVrU0a0rlCcR/4j5nkM4rqaI?=
 =?us-ascii?Q?mbIgn2ZPFY0HztcMesQ9dRl1ZJ4ux78BpETVPzGpa+zy8PSRyGBZnhsSXHDJ?=
 =?us-ascii?Q?xFiuBSU0IQ2TC7Ge5dLSRai0BKiQQKcVyGrdGTAQaBv260UJ2bP5AjsEKAlV?=
 =?us-ascii?Q?hN4zmcbTdlrmuPVj4ih9NujojnQ+4ZnAW/BLRKG/VBiu78ZwcuJLFzsRuUeU?=
 =?us-ascii?Q?Bw7Ipr1etrs9VxRLkAJPKtF6u63HKZpHqTzO32czmm7qz94D55eRpzTADDFT?=
 =?us-ascii?Q?hCu9RZvI6hHl+8adz4piOicYcpJflWFVZFlWK4Cw6NHZBwHMwXYNruSjA8vD?=
 =?us-ascii?Q?7IHoNUfkZZktaWw6affObnOvxXpFIyyRuAldsQDaYk+UO2xELh36xSMCEwYH?=
 =?us-ascii?Q?xv1svTEuoR0x+HKztch+aJVZuo9GPxeouvb9bs8DtFMEZhC2b+wKFZ0/v/Ng?=
 =?us-ascii?Q?D/oI/wGdT8qd8kw9Dwai1cJr0LdKog88cWJzofJaI87ZXzCDJBvCHQdU2oYA?=
 =?us-ascii?Q?ZmHteKZuxqAFS99oCIAsll0xuv6A0AmMQNJ0m3PbnlYxnNhQ2rxwLY+CpnER?=
 =?us-ascii?Q?uihwOfcuecrRSH7ZiIV9/QlKfLQDwWVjkLHFHVb5ZRAWsBpkfuNJ8H3blZEa?=
 =?us-ascii?Q?YoDB7UopKqufCmLr3rL8yhei9yqTwWpR71XuE1pfhJdbryVqR7h69D4yBYNJ?=
 =?us-ascii?Q?aRd2j1NOSxqNz3W1pxpMRN/b/RrwEUIfm9ww4KbJ8zDWRUZd+M3WWi09lUXQ?=
 =?us-ascii?Q?OwCSZn4NunreRbwOpea9qHpcC43BZDxCFdLXp8lNlRsM1pDZ0gLuVaxDyv8Q?=
 =?us-ascii?Q?kjmq9k0VQs7Tlg+K8IYISx6asVPHnUhiAPELIJOWzilnUXH5LqMDN2QR6OXH?=
 =?us-ascii?Q?72oXq4vbhKtxCCHhizVNLUlx9z2jts/hQp7F7OzubgMoePrDG0TLhEDb86NA?=
 =?us-ascii?Q?F8ZkHlrXnJ9CXURGSOGcrjjAzQ3+jVBObLK8Q4ly3LHBfdrB+0GpwTJ5j2Hg?=
 =?us-ascii?Q?GbISs4VAVjBhHTIIfZ8Tl8HefTMQSdHVf4c00HUhuv7Ecv5w/5mxIip7IrZL?=
 =?us-ascii?Q?4MgfKyP3WFUJL/61LL4Tku5PQwq3Yg5H4XkBSHp1KRrVpLgfgZHZtUFPk+9a?=
 =?us-ascii?Q?pAioqQ2TTFv4AxiGXLato859XDCGtucCr5OQVZPPL5IYr4FKADOY+LJOcPAc?=
 =?us-ascii?Q?pDGW6OmBTxQFAnTCE35weYV+5miXUfQHTaRHzV+teOuAxZixSQ82m1MjXDnT?=
 =?us-ascii?Q?+CglmcDYY2kmJygvz6NFKmfSlsAIzC3TCokw/eFGKT68so0R+sfK9ceRwjjR?=
 =?us-ascii?Q?WpTYvFMAwpN5UsCEHGMyBJhoXCG2vCPyAzhimD7QW7+De48/cFbmYC2pI32U?=
 =?us-ascii?Q?MDizHvlGWO6vAa04zuc4kFUpJxni3llyWlkV5WmcI3j5TwqTZzE0dJie3kpY?=
 =?us-ascii?Q?/wfyrk7qUrD+JgQ+wKTlYetbwJ5Txa5fK1sD2dBbPctL0aFgcKGdquiv7YzZ?=
 =?us-ascii?Q?Bc6FzJ3B4iqOSS5590rw+mJsmuuD2xBvDIVnT6HSXjHHAe3w6103KS2opsfj?=
 =?us-ascii?Q?1/ZeykBtjbhUOdJ0iAtDgoUYSP+hVW9W+QVXnKXH7T4/DOq67ZmkG6Hla/Ar?=
 =?us-ascii?Q?ZjBgOskCr6rQrYZ61TpP/tPkXKXG0e3iK9YVxAka9cdJ4h+0kzws4/FKUv5m?=
 =?us-ascii?Q?Qeu70tkA4l/UD9MWQi5cnjRieCPmjxfX+wK3idV2MzCtB9OR7OHA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d94e14-492a-443a-6ea4-08df3f0422ac
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:10.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvxmTfCEt1r7oRdkrrLNOu7FHzv3UmUS9LzeP9XJ4Vs3FhugVbRnecqD4IuBt+ih+t2JCdyzno7RKdkpGcC7YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3015

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. Quiescing
an unrolled eDMA channel disables its whole direction, so reserve the
complete read direction and route its interrupts to the RC when dma_bar
is configured.

Describe the controller and per-channel descriptor memory in a private
control-region extension.

Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
export. Leaving it unassigned keeps the feature disabled.

Keep resources already assigned to a BAR in place, and map the rest
through the selected dma_bar.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v9:
  - Reject SETUP_DMA_BAR when DMA export is disabled. (Sashiko)
    https://lore.kernel.org/r/y346l5tlv2abdjvjqbqitmi7xmi46trm2dvmbgihlbieal4hz7@rc2dcugxd5aq/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 487 +++++++++++++++++-
 include/linux/pci-epf-ntb.h                   |  39 ++
 2 files changed, 517 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3adbaa9d85db..875a7a9e487f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,9 +39,13 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -67,6 +71,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -78,6 +83,18 @@ enum epf_irq_slot {
 
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 
+struct epf_ntb_dma {
+	struct epf_ntb_dma_ctrl ctrl;
+	struct dma_chan *dchan[EDMA_MAX_RD_CH];
+	void *bar_scratch;
+	dma_addr_t bar_scratch_phys;
+	size_t bar_scratch_size;
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap *reg_submap;
+	unsigned int num_submap;
+	u16 rd_ch_cnt;
+};
+
 struct epf_ntb {
 	struct ntb_dev *ntb;
 	struct pci_epf *epf;
@@ -111,6 +128,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct epf_ntb_dma *dma;
 
 	u32 *epf_db;
 
@@ -202,7 +220,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 {
 	int i;
 
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
+	/* BAR_DMA is checked separately because it may share an MW BAR. */
+	for (i = 0; i < BAR_DMA; i++) {
 		if (ntb->epf_ntb_bar[i] == barno)
 			return true;
 	}
@@ -210,6 +229,419 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+struct epf_ntb_dma_filter {
+	struct device *dev;
+	int chan_id;
+};
+
+static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct epf_ntb_dma_filter *filter = data;
+
+	return chan->device->dev == filter->dev &&
+	       chan->chan_id == filter->chan_id;
+}
+
+static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
+				  const struct pci_epc_aux_resource *resource,
+				  dma_addr_t target_addr,
+				  enum pci_barno barno, size_t align, u32 *next,
+				  struct epf_ntb_dma_region_ctrl *region)
+{
+	resource_size_t delta, map_size, size;
+	struct pci_epf_bar_submap *submap;
+	dma_addr_t base;
+
+	if (!resource->size || resource->size > U32_MAX)
+		return -EINVAL;
+
+	region->size = resource->size;
+	if (resource->bar != NO_BAR) {
+		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
+		    resource->bar_offset > U32_MAX)
+			return -EINVAL;
+
+		region->bar = resource->bar;
+		region->offset = resource->bar_offset;
+		return 0;
+	}
+	submap = &dma->submap[dma->num_submap];
+
+	/*
+	 * The RC is trusted with endpoint-local DMA. Map the aligned span
+	 * required by the EPC, but advertise only the resource itself.
+	 */
+	base = ALIGN_DOWN(target_addr, align);
+	delta = target_addr - base;
+	if (check_add_overflow(delta, resource->size, &size))
+		return -EOVERFLOW;
+	map_size = ALIGN(size, align);
+	if (map_size < size || map_size > U32_MAX - *next)
+		return -EOVERFLOW;
+
+	submap->phys_addr = base;
+	submap->size = map_size;
+	region->bar = barno;
+	region->offset = *next + delta;
+	*next += map_size;
+	dma->num_submap++;
+
+	return 0;
+}
+
+/* DW eDMA */
+
+static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
+				 struct dma_chan **dchan)
+{
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	*dchan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+
+	return *dchan ? 0 : -EBUSY;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb_dma *dma)
+{
+	unsigned int i;
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		if (!dma->dchan[i])
+			continue;
+
+		dma_release_channel(dma->dchan[i]);
+	}
+}
+
+static const struct pci_epc_aux_resource *
+epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
+			  unsigned int count, u16 chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    resources[i].u.dma_desc.chan_id == chan_id)
+			return &resources[i];
+
+	return NULL;
+}
+
+static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
+				   struct epf_ntb_dma *dma,
+				   const struct pci_epc_aux_resource *ctrl,
+				   const struct pci_epc_aux_resource *resources,
+				   unsigned int count)
+{
+	struct dw_edma_chan_config chan_config = {
+		.flags = DW_EDMA_CH_CONFIG_IRQ_MODE,
+		.irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+	};
+	struct dma_slave_config config = {
+		.peripheral_config = &chan_config,
+		.peripheral_size = sizeof(chan_config),
+	};
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	const struct pci_epc_features *features;
+	struct device *dma_dev;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	/* DWC descriptor memory always needs subrange mappings. */
+	if (!features || !features->subrange_mapping ||
+	    !features->dynamic_inbound_mapping)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	if (epf_ntb_is_bar_used(ntb, barno) ||
+	    pci_epc_get_next_free_bar(features, barno) != barno)
+		return -EINVAL;
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = barno;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	if (ctrl->bar == NO_BAR)
+		dma->reg_submap = &dma->submap[dma->num_submap];
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     barno, align, &next, &dma->ctrl.reg);
+	if (ret)
+		return ret;
+
+	/* DW eDMA static IDs place read channels after all write channels. */
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		const struct pci_epc_aux_resource *desc;
+		dma_addr_t dma_addr;
+
+		desc = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc)
+			return -EINVAL;
+		dma_addr = desc->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc, dma_addr, barno,
+					     align, &next, &chan->desc);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	dma->ctrl.submap.size = next;
+
+	dma_dev = ntb->epf->epc->dev.parent;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		ret = dmaengine_slave_config(dma->dchan[i], &config);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Common endpoint DMA */
+
+static void epf_ntb_dma_release_channels(struct epf_ntb_dma *dma)
+{
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(dma);
+		break;
+	}
+}
+
+static int epf_ntb_dma_collect(struct epf_ntb *ntb)
+{
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+	unsigned int i;
+	int count, ret;
+
+	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
+		return 0;
+
+	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
+						ntb->epf->func_no,
+						ntb->epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *resources __free(kfree) =
+		kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no, resources, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+		if (ctrl)
+			return -EINVAL;
+		ctrl = &resources[i];
+	}
+	if (!ctrl)
+		return -ENODEV;
+
+	struct epf_ntb_dma *dma __free(kfree) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret) {
+		epf_ntb_dma_release_channels(dma);
+		return ret;
+	}
+
+	/*
+	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
+	 * carries an endpoint DMA address. Convert only the former.
+	 */
+	if (dma->reg_submap) {
+		dma_dev = ntb->epf->epc->dev.parent;
+		dma_addr = dma_map_resource(dma_dev, dma->reg_submap->phys_addr,
+					    dma->reg_submap->size,
+					    DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dma_dev, dma_addr)) {
+			epf_ntb_dma_release_channels(dma);
+			return -EIO;
+		}
+		dma->reg_submap->phys_addr = dma_addr;
+	}
+
+	ntb->dma = no_free_ptr(dma);
+
+	return 0;
+}
+
+static void epf_ntb_dma_release(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	epf_ntb_dma_release_channels(dma);
+	dev = ntb->epf->epc->dev.parent;
+	if (dma->reg_submap)
+		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
+				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
+	if (dma->bar_scratch)
+		dma_free_coherent(dev, dma->bar_scratch_size,
+				  dma->bar_scratch, dma->bar_scratch_phys);
+	kfree(dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
+{
+	struct device *dev = ntb->epf->epc->dev.parent;
+	const struct pci_epc_features *features;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	size_t backing_size;
+	u32 mapped_size;
+	int ret;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	mapped_size = dma->ctrl.submap.size;
+	/*
+	 * Submaps cannot be installed until the host assigns the BAR address.
+	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
+	 * for regular vNTB MW BARs.
+	 */
+	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
+				       PRIMARY_INTERFACE, 0);
+	if (ret)
+		return ret;
+
+	bar = &ntb->epf->bar[barno];
+	if (bar->size > U32_MAX)
+		return -EOVERFLOW;
+
+	backing_size = bar->size - mapped_size;
+	if (backing_size) {
+		/* Back the BAR tail added by the power-of-two size rounding. */
+		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
+						      &dma->bar_scratch_phys,
+						      GFP_KERNEL);
+		if (!dma->bar_scratch)
+			return -ENOMEM;
+		dma->bar_scratch_size = backing_size;
+		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
+			return -EINVAL;
+
+		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
+			.phys_addr = dma->bar_scratch_phys,
+			.size = backing_size,
+		};
+	}
+
+	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			       ntb->epf->vfunc_no, bar);
+}
+
+static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+
+	if (!dma)
+		return;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	bar = &ntb->epf->bar[barno];
+	if (!bar->size)
+		return;
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+			  ntb->epf->vfunc_no, bar);
+	memset(bar, 0, sizeof(*bar));
+}
+
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar_submap *old_submap;
+	struct epf_ntb_dma *dma = ntb->dma;
+	unsigned int old_num_submap;
+	struct pci_epf_bar *bar;
+	int restore, ret;
+
+	if (!dma)
+		return -EOPNOTSUPP;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+
+	old_submap = bar->submap;
+	old_num_submap = bar->num_submap;
+	bar->submap = dma->submap;
+	bar->num_submap = dma->num_submap;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (!ret)
+		return 0;
+
+	/* A failed dynamic update may have already removed the old mapping. */
+	bar->submap = old_submap;
+	bar->num_submap = old_num_submap;
+	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				  ntb->epf->vfunc_no, bar);
+	if (restore)
+		dev_warn(&ntb->epf->dev,
+			 "failed to restore DMA BAR mapping: %d\n", restore);
+
+	return ret;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -342,6 +774,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = EPF_NTB_COMMAND_STATUS_OK;
 		break;
+	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
+		ret = epf_ntb_dma_set_bar(ntb);
+		ctrl->command_status = ret ? EPF_NTB_COMMAND_STATUS_ERROR :
+					     EPF_NTB_COMMAND_STATUS_OK;
+		break;
 	case EPF_NTB_COMMAND_LINK_UP:
 		ret = epf_ntb_set_link_enabled(ntb, true);
 		if (ret < 0)
@@ -488,16 +925,17 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *       Virtual PCI             PCIe Endpoint
  *       NTB Driver               NTB Driver
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
- * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
- * from "spad-count" configfs entry.
+ * Allocate the Local Memory mentioned in the above diagram. CONFIG REGION
+ * contains struct epf_ntb_ctrl, the DMA extension if enabled, and the MSI-X
+ * Table and PBA if supported, in that order. The size of SCRATCHPAD REGION
+ * is obtained from "spad-count" configfs entry.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
 	enum pci_barno barno;
+	struct epf_ntb_dma_ctrl *dma_ctrl;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
 	struct pci_epf *epf = ntb->epf;
@@ -511,7 +949,10 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	if (ntb->dma)
+		ctrl_size += sizeof(struct epf_ntb_dma_ctrl);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	if (epc_features->msix_capable) {
 		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
 		ctrl_size = ntb->msix_table_offset +
@@ -543,6 +984,11 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma) {
+		dma_ctrl = base + EPF_NTB_DMA_CTRL_OFFSET;
+		*dma_ctrl = ntb->dma->ctrl;
+	}
+
 	return 0;
 }
 
@@ -924,7 +1370,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -1023,11 +1470,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 		goto err_mw_bar_init;
 	}
 
+	if (ntb->dma) {
+		ret = epf_ntb_dma_bar_init(ntb);
+		if (ret) {
+			dev_err(dev, "DMA BAR init failed\n");
+			goto err_dma_bar_init;
+		}
+	}
+
 	if (vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
 		if (ret) {
 			dev_err(dev, "Configuration header write failed\n");
-			goto err_write_header;
+			goto err_dma_bar_init;
 		}
 	}
 
@@ -1038,7 +1493,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 	return 0;
 
-err_write_header:
+err_dma_bar_init:
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
@@ -1061,6 +1517,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	disable_delayed_work_sync(&ntb->cmd_handler);
 	disable_work_sync(&ntb->peer_db_work);
 	atomic64_set(&ntb->peer_db_pending, 0);
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1267,10 +1724,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1289,6 +1749,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1847,6 +2308,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_collect(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare NTB DMA export\n");
+		return ret;
+	}
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1887,6 +2354,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 
 	return ret;
 }
@@ -1918,6 +2386,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 }
 
 // EPF driver probe
diff --git a/include/linux/pci-epf-ntb.h b/include/linux/pci-epf-ntb.h
index 0c02d709aa08..5cc0f0badae0 100644
--- a/include/linux/pci-epf-ntb.h
+++ b/include/linux/pci-epf-ntb.h
@@ -8,6 +8,8 @@
 #define __LINUX_PCI_EPF_NTB_H
 
 #include <linux/bits.h>
+#include <linux/dma/edma.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 #define EPF_NTB_COMMAND_CONFIGURE_DOORBELL	1
@@ -16,6 +18,7 @@
 #define EPF_NTB_COMMAND_TEARDOWN_MW		4
 #define EPF_NTB_COMMAND_LINK_UP			5
 #define EPF_NTB_COMMAND_LINK_DOWN		6
+#define EPF_NTB_COMMAND_SETUP_DMA_BAR		7
 
 /* EPF_NTB_COMMAND_CONFIGURE_DOORBELL argument */
 #define EPF_NTB_DB_COUNT_MASK			GENMASK(15, 0)
@@ -45,4 +48,40 @@ struct epf_ntb_ctrl {
 	u32 db_offset[EPF_NTB_MAX_DB_COUNT];
 } __packed;
 
+/*
+ * DMA wire extension produced by pci-epf-vntb and consumed by
+ * ntb_hw_epf. It immediately follows struct epf_ntb_ctrl.
+ */
+#define EPF_NTB_DMA_CTRL_OFFSET		sizeof(struct epf_ntb_ctrl)
+
+#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
+#define EPF_NTB_DMA_REVISION		1
+#define EPF_NTB_DMA_TYPE_DW_EDMA	1
+
+struct epf_ntb_dma_region_ctrl {
+	u32 bar;
+	u32 offset;
+	u32 size;
+} __packed;
+
+struct epf_ntb_dma_chan_ctrl {
+	struct epf_ntb_dma_region_ctrl desc;
+	u32 desc_addr_lo;
+	u32 desc_addr_hi;
+} __packed;
+
+struct epf_ntb_dma_ctrl {
+	u32 magic;
+	u16 revision;
+	u16 length;
+	u32 type;
+	/* BAR range occupied by resources without a fixed BAR assignment. */
+	struct epf_ntb_dma_region_ctrl submap;
+	struct epf_ntb_dma_region_ctrl reg;
+	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
+} __packed;
+
+/* Common header needed even when endpoint DMA is unavailable. */
+#define EPF_NTB_DMA_CTRL_COMMON_SIZE	offsetof(struct epf_ntb_dma_ctrl, reg)
+
 #endif /* __LINUX_PCI_EPF_NTB_H */
-- 
2.54.0

