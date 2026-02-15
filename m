Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8823185E;
	Sun, 15 Feb 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167826; cv=fail; b=aAohHY9ZTQQjtu5d+eABnWX/Vdo3OTwN6HeADBXlfJyk8CKb5AdQy2cdJjqUOWGcAtWVy4miZXM+AqHlbsnWcQFzn9uCeX5VKsfqs9H4IlGLihbJYkE9shR9XpCTc8tG6xseLIHHeMivO9e+DRB0hI0DoKHQWxGQyhGboEOk5PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167826; c=relaxed/simple;
	bh=VQ2RRN7Uzwl/ykML4Fer3L1FNDaFW36JlUsj7dn25EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TP0B+mbFuc0CSmTILqhXk22pWRKFraIDh5qlLAN0gCyNFsc5ej8IdvDADqVtH4oXe7ZHNNVEsnmrnH0I2DT4/UjIdz5YnmvXpXowVnC9MHJp/um1mf9cDxXtiIgN7dY0X2dyC5I5WkgpJ0A5CVxWbsI5bo/yIDRI8mLfMMV5WkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=keO3O9Sq; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="keO3O9Sq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt82bGZo/FjPhu6/7+4moAt1IQEjGUi0K8ZZmcZcaizXjGVT9lBBhahQaETTZfp+uKgnxfeomysLn2PZqPZG2TcQQKafxrPPakoEJfcUt/fD9h23s0sWSBqxORjwl935IpKv/q8/q/3vZ4rFF21kHyIslIn82eJPfdG1U53dG9jefZ/h+7h2oiW3XzrmwrXp33Xc1vnH2FjW56bH0noKyrxuzZGwZ3pE8JIm38cqoN+OijCqn6pYrMrUiswMfXdO4pdZcwK7QRRSTO5tWNnxOz49NmQIifHyMrTGjYElv/oLhgaJ+wQkkNrJQoSjgDV0xYQZtd5vW9VxmGN37RBpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrR2uLeIdlr3v2FJx/c56hEHtAdxPyxjEy8+4eIVw3I=;
 b=EfXpZIATCOkK2jCNZvXfO03jcRKz87fW+rPaDh26B96PFoRa4JVtlTg5G0FdH0vqq3psYiqTM8lx5hn5ERnIzx6dmVlLOqP5BhpjW1RDAECG+B4rbbzeTz/w0MPDuG1xAGBJ7rrcfcZ9ks5Z8htqGizhdes8EgUInarPhjGk1P56HQaKajHmXFbRr9z3dir6QrUatskSpFi9kFLzOIcueg0JnLffwbxcUA+BmoqyTcrY+NT6fprUON9VVtLgnYTyIqUT/Up1hz0diNBAIOPe+c6xQR+a2ktx6T6dmD7NmOUwDnolrUi9EdC2fCMxta8r0XcBadMVc7eo0E9ODQ1vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrR2uLeIdlr3v2FJx/c56hEHtAdxPyxjEy8+4eIVw3I=;
 b=keO3O9Sq4xsr7erSxoekpY4C7m0kyiKawFSVXH7hxgfLdDoXWky9Rhlw4adeYTLlR1jYGjjccG7BXzWtOcTjkz46vxOY1KrytEoG8eq2Y6ff7v0Qck1RJDJMn0XddzkZd7NXmpQCsxwsOFWmilAdMK+WsUeqI/balep35tsOPcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:03:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:03:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	shuah@kernel.org,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] PCI: endpoint: pci-epf-test: Advertise dynamic inbound mapping support
Date: Mon, 16 Feb 2026 00:03:32 +0900
Message-ID: <20260215150334.3391943-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150334.3391943-1-den@valinux.co.jp>
References: <20260215150334.3391943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d84ec6-5007-4437-114c-08de6ca3676d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDJH0wSsU2JWUAk78tlIz0bIikJoHw23eqKmtSZcWdVV6IuMxEOQjL3kRiH0?=
 =?us-ascii?Q?41kY0cJs2kJ/2UkNFP8t+pkZCmoYFyLSNAip9OaEWfUMbqp+cCrN0j+kbE/7?=
 =?us-ascii?Q?YRCCzcOCJpc4oj73IJ+qkOhVB3h5v/TDRGjSgsahdV36mpoyfbIxVx+AyhS4?=
 =?us-ascii?Q?SbQ6GN+zYfNuOhm92ARJ8JkBipaSnz/bS04drFCv8CJB9HBfSpcwZbrkP0yN?=
 =?us-ascii?Q?WwThurHHKUEHVayXHKzJIYesn9iHHR2gKiRWPVAYV6mgT6t2qxF+yh9Rqrgo?=
 =?us-ascii?Q?WuoJp8COcaGneRrIfrOu1lbPW+WojQIpxZjoRTuMJL/hUue9xNlN7D8CpBuk?=
 =?us-ascii?Q?1FHqrxQFO+wAYZACFnBOgVyJtv2Ii8sibDsUfgAaKA3C7m1fZjc/F3Jk6c3a?=
 =?us-ascii?Q?7nt9iS6yjV1b3hUs82l/JYwcLyxZCwXgP87/6X4pCaJ3fsErGNqgaa94JDNT?=
 =?us-ascii?Q?n3Dc0pSmlPHPtctUnRH4tgMEutX1N7kz0cQ15aRvZXpFLaaYAjCVl5YWadrv?=
 =?us-ascii?Q?6IVtkj6qKfk+Wva5WPeCLiIfaifIKk/oQeP/qAL1W2MXR+gaWFodrAFmWnf8?=
 =?us-ascii?Q?Gk9ZGtqwuM/cZXwYIzLmmmUnT/SZVIlLKed/lkEtxkjBxIrJBOHUgGy4FtNR?=
 =?us-ascii?Q?dACpc7FTOTJWovo85YrAVvqVZmdoaDyLGY98B2s6JuR/RxEvs6ailfz2j+pJ?=
 =?us-ascii?Q?Lf8kQbjhiJTj7oRiXpi+CriUbeuV3oMgKAvRs2Rl7GnnEJHDDiw//kkaJdH3?=
 =?us-ascii?Q?8oh0BoN0+OjnTSsGknLqcJArPO47J2YCoxo0Ikt88BjYiOFz9WN1XtsKa92K?=
 =?us-ascii?Q?Us+XceAkSuKu8Ht/lwy+u4H5091c5Cw9XXPgzsL+emTSWLox2wds5RCFAM4H?=
 =?us-ascii?Q?Wdi5IR9KRjd1YtTcJRtn75RgcnImAzkosdJ1CNLcr3C4TgHylW0SKKFTTRzP?=
 =?us-ascii?Q?7wOb0b7y+PprzqrOZWGD/RFXUmsFwqwBbOpBJvmUo6e6PksyXhQ+YuC2Lyyb?=
 =?us-ascii?Q?eNgkA5uq4YeeqVCBtCIyFqRvMoUyFVKxnljgYPTSCXnhIw/VjT+nX/aE4nyl?=
 =?us-ascii?Q?HXdPTPfkc0pJsoSyET/YOXih60IRxhcdH1vu2cSYkAhO7lb6G319dHXAgxRq?=
 =?us-ascii?Q?h90CpSGrW74pynI3M+vkBC9e0l8h38QxDEkUVZBkjKKmlWPMooTxx0bAM8aw?=
 =?us-ascii?Q?PXnAogrynCdPiH0BkgJNcPL90iGVpbrh7U/BVNv8FoixJUWItNu6WafIK7KE?=
 =?us-ascii?Q?WGQCs0S53SzNglQ0iPpTWC0Bnoq3vxznx9Jum/wnzEBHHThO2H28vr1UfUTq?=
 =?us-ascii?Q?za3jhfs4wYhmReA2XLNvjkhghYgDxgleAqupx/UXun7IqL9EtPGy5TXG4odI?=
 =?us-ascii?Q?EqQHvS2c1irT9j2zgrQB4P1vf0IQQtnrPr/f1nA7mpMsUN9UoT7sfUGKybc1?=
 =?us-ascii?Q?9Yg8DpTUdhWSGVO5JuqXk4MqlN3FMq/mlsY73hVi63Q7U3vjEP8pkns6GFXT?=
 =?us-ascii?Q?R7/Qqc79hgLVXxQ9PigHuHTygr2vlzi8eMaMdsAPGMRT/TCMp1Mspoqx6GSw?=
 =?us-ascii?Q?2KJnYX15JkA3B1rpWaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5a/yb03Px11mf3U9XyFyLBVtq6rdbkrFj15B4vWLkPWM6me+6BYXjquNVmu?=
 =?us-ascii?Q?Y+I97T4oyXkky/BAFbKWnk/gT6OoUY1LAY19E6WviO22VdBWw5/Fujuj6pBw?=
 =?us-ascii?Q?jIAowCKlpMM2JH4dJN0UBMhMvbVvtO6DvxGpLrwmEx2Zud7pey8HjLIhAu76?=
 =?us-ascii?Q?FLIuhhHI6mPamn6XC8XqRAKK3hP/cwujbi7+VlQIOK0hdyEFoquvxbnVQPwE?=
 =?us-ascii?Q?ink7Pb4ZeFKvxKfWdaOodoOqdwadmTz7L60c/RDcLcDBMSO7zuJrYpNeQANh?=
 =?us-ascii?Q?Xug2U9/5JIJr5Hgq66nPr3tUTjg53Q9GpuMAvjXLvqWygHGkRXIR/bsjbu0l?=
 =?us-ascii?Q?glZxxL/Wfz9ebAFDPl5yWPEHXq+t2QSG5U/KQGCuJGe527SbERyIE6+x1tU4?=
 =?us-ascii?Q?EdzMgpwGkT3lfEa3rHn8NB5EMFYb6svh0xIWacgxg0IqyKKCm3fDLWnf7lCk?=
 =?us-ascii?Q?/+9JqkdhYK1pC7lbKpm/4B7biMcObbdD+KThW6CVsB9NNvKiaXp2VamE4Hzd?=
 =?us-ascii?Q?geNw7nS0qwWw3ubiZOUnBpbYOSjrYCPZC26oeSvAbi/o4Xl5BiskPp6Ya3QE?=
 =?us-ascii?Q?6ZVkxV05r1jTDCTEMrdyA+kw3abtxjAUnJSGh3w2MrlXZWVYXGHQ37k/sy48?=
 =?us-ascii?Q?sDrN0FSqKC2JETlX4G4GIDqsEb/NSeQgihevb0ZSuwOphWilOYgAY3Qd8uvg?=
 =?us-ascii?Q?G66OS40p1KKYLj87zyne9mQxu7zlGgzVgxbdkOkIvoE39zO7x7z7KTKSFBs4?=
 =?us-ascii?Q?KoY7XFuH154GL4v5EJiov/c5BNwstqcRBKmGSKqVi4fsvZ4z5Il+9F9wRMgD?=
 =?us-ascii?Q?5PyDL/Op+Ip9Gh1yMfEvBE4f/0boLhrvGlsLIILQZ0HkLKJAr6o+8dREsA60?=
 =?us-ascii?Q?GDcCNbHPwZk4xm0DnGlv/U3aNCuwbyDXMQxjsw5UYDUzvuCYTsJC2v6NtFli?=
 =?us-ascii?Q?yJ1ch1frUXrv51gKzlgPkpQudyiAtYaI4q+Iys07uwdfPS73/XSjc4Dwjhvk?=
 =?us-ascii?Q?yR/AkZnc15+XbubMbKiDbjr/Fm5cr24+QcMs6jmHSCv4JVBuaMIhWb69zACM?=
 =?us-ascii?Q?plLyQvZvNhMAimsizgYedi4r0VSyz0xnp7PEJ72o7SaM/3Otlg16LOAbiGF+?=
 =?us-ascii?Q?klFofC4+hsKwwv5AckcfjSKe8aEjloKa2v8BmRKduKRogU9TUF9joRMzAPJo?=
 =?us-ascii?Q?iGXcjN3AH7sEN8XfjEbnSGm8DlqifF3vZFVe7G/2uejW+mmVonXsU8GxPteY?=
 =?us-ascii?Q?PuYswy+5tHHPjFL/ZTHujDMGfBwr2KfVtLeRp2JTszFzlslB5XPrkbzkOkxc?=
 =?us-ascii?Q?Ugkhdys4aTt0AEh0WfF8+pipJixNdvnFteaPA+Fxzg4UpkmAyVi7qWLRCP1c?=
 =?us-ascii?Q?pMSaEB3Fcroep+kK71VUF/MCcGlF4yaAKiJxncrr9ZvUCjXWTEcqTMXrqvXb?=
 =?us-ascii?Q?mJbFNK6EKh3Bp0TLezO2KjFMzWdaWH5m0qLkEjyBCMwy5n/q930qM4Kb3SIj?=
 =?us-ascii?Q?Qw1LyZ/hKbG3bKn6mQwccD7wIUzJVfputdSrT91KSpN5x1cf5gNf7HbUe5OV?=
 =?us-ascii?Q?SBmAXJZkRHiKLz8ABU71VTnVlr8kTxEf3tQPPZf9QbOrwCgwxVRQgmwj2Fyw?=
 =?us-ascii?Q?r7MoLYNPjkG0xP7AfEN41yQeu6Emv9rdc5TYSAueXKkbQuqvtK+YdJCufeF3?=
 =?us-ascii?Q?mWUs6haMOyte61JDN1QmtTPRaB+TlPKzidHfKkutr0NWupSdKKFDK6/pY6nQ?=
 =?us-ascii?Q?IGlP04AJmNha82Fa2aZmwaCMHIAzWxWXGk1cA0g2S0k9UbETfK6i?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d84ec6-5007-4437-114c-08de6ca3676d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:03:40.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TahlkCE8yRUFpM8z5K5MjDQlzfHWe2p/7YAVajD3WGZ3Oj9c+/y7cD12Pwmm5HXnoXCi36A80gSWdV2abeDa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

The doorbell test requires the EPC driver to support dynamic inbound
mapping so the host can map the doorbell target address into a BAR
aperture.

Expose epc_features->dynamic_inbound_mapping via a new
CAP_DYNAMIC_INBOUND_MAPPING bit in the pci-epf-test capability register,
so the host-side pci_endpoint_test driver can detect missing support and
return -EOPNOTSUPP instead of running the test fruitlessly.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0cb7af0919dc..c0db207ff143 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -64,6 +64,7 @@
 #define CAP_MSIX			BIT(2)
 #define CAP_INTX			BIT(3)
 #define CAP_SUBRANGE_MAPPING		BIT(4)
+#define CAP_DYNAMIC_INBOUND_MAPPING	BIT(5)
 
 #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
 
@@ -1102,6 +1103,9 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
 	if (epf_test->epc_features->intx_capable)
 		caps |= CAP_INTX;
 
+	if (epf_test->epc_features->dynamic_inbound_mapping)
+		caps |= CAP_DYNAMIC_INBOUND_MAPPING;
+
 	if (epf_test->epc_features->dynamic_inbound_mapping &&
 	    epf_test->epc_features->subrange_mapping)
 		caps |= CAP_SUBRANGE_MAPPING;
-- 
2.51.0

