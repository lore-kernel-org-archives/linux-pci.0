Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4623183B;
	Sun, 15 Feb 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168165; cv=fail; b=iX2eNqqSy5u4Zoc+TJZIc7WtAe0Fuvu1PXMO6xs5zj9WA3hek0weLwSd/dS7d6u3TuK3ripM2XGhiPcTrxF5yJ3jn2gNcNaVV4GO/NhWgxV0ALbhBTMYgQOfiF0TyuyWZNBRzZbSVm5mv/PaVqjncZlaw3t4Jsovjq8TGbTMsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168165; c=relaxed/simple;
	bh=T7qU6Q6xHCSNmH4rMdrqkyxqygTUO5pktKl/r2kx4MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJ7QvtTiUlwdTFtnnm80+3HHq1sNeKdUNijW/3Y9IPvPxRfUIQ9774V6lix9vR8rNW3cRaySmOOYZyIu2pUrLIebAT7jfsJQpZJxSLE9RLLG5o2bo3SKaxNhbSS2O3QsieFLp236B/8f0/pA6+2hKOTJBjZ0U1Z526XDTw2AHeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=n3jvmMMo; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="n3jvmMMo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GM+oLFGumqJdlSFeldcDuH5A1mZIf551pVUJ3RRwaXH+HmrxqUM24PQebymMtkEu9zkDZ/m7n8kMwKub//LyQVCpb9ZEbLqLl20c7mClXDg75l+WvaV3NpiL9PRY7wSU27S829CiKpo5AGVShjigkb4GVu7aSRdqgy+B2SMoK+4ItCtq3/aohkbUcqAqRNnpAFzQutGaQ9jGHNJNYfYlZiyql9Po0N/a1CfOYzRit7iizcjJgJNMu0l4PRdF8FnCekyb8nTG/boiRNAnDYu5AkbbWG0l/AlFD1cqGjp4jP8lT4dbhw0YrCJZVQUX4iLNinOmLsNfSfVzddoANjxTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU1YP9BEMHSlKcyAKta0aktQuHLC9v88QPUq3UofzbE=;
 b=j+S3nnsg2G73dOV6ffQfWsMteJk/nVyZb4VwM2Rlr8ORBvFnI7ycqmp/zpDQYrwO4OStAbg+pNwmD4P7IBW0MJ/4qEugFmV/uURUb1FpsLGtY0zgAonkvOUXTdhwdtnnaBJ4YhRWrcFpIfq20FnyPmiSBiDEDuly727+I5Fktx0wVjVgDcoDpp69vJ9rAgo+QL5BgctjiY3Dqhk2bsY5ClXw5pJuJWhUYqs3GMwjRlNDc+pk5cwIMF6Uqlkcdh09C6l8Gexy6aPKLhXQq85+KgMOntbE5YC+DPxnKyj19MLZ+EWIQc71QWEGkSiPi8GiMzUdNQcAC09qg8iNxRP5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU1YP9BEMHSlKcyAKta0aktQuHLC9v88QPUq3UofzbE=;
 b=n3jvmMMot+jJ0qqecHccmrKapU+QRoyUy9k+4EEoakrZg6uMo6kx6nUrtlWOMrQ6mJoWpvoZdNM/ds5pnqHEoWQ129khK+Ingw/2mvk4V+IGd7E/0a6MaJW/MeCFU15KXc3yZXrLdO5C+utyxoCJVqlFP1paCmdCbIFjetg28cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:09:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:09:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
Date: Mon, 16 Feb 2026 00:09:11 +0900
Message-ID: <20260215150914.3392479-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150914.3392479-1-den@valinux.co.jp>
References: <20260215150914.3392479-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 26573c4f-1ea6-4a7d-9d15-08de6ca43283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F48UO+OGU3gMhxV4cnM1CgTE7BibE9Pts97qjPzktW06gP5RU7Rn2dfYjfcl?=
 =?us-ascii?Q?d/mDqu9PMhmtbiIMjs1zhrAzoFI2Fz+J6j5LcV4M0D0pPiwk7FOjZnMZUtXI?=
 =?us-ascii?Q?x82UiaZYnmgdvS1MOKcx08PkeCsXpEQ+3XQwBV8prIH9wfhBz2hQ6r+R/f2g?=
 =?us-ascii?Q?LwUd5JaXgBwq/VR2NO9OW678FZke9wpgPxnfPgnfFgcGA1a9JZSQbUl/KUNm?=
 =?us-ascii?Q?6tkyNBaKV0dgVhRNKRnKENnoHth3LdxqpQJnP0/bTSpTdyTQ5ACEin/qPqI+?=
 =?us-ascii?Q?tBxIfRlTqoAFFqCdcsYx/v3lRRdQmqQapuVm0fiuqRkw9Dd6BclBMjU+FW41?=
 =?us-ascii?Q?y1FG85hSIV7dVIbenpIofzhDjK+uo2kJKNYPSVvMEjifnBvMQkxUOMILn3le?=
 =?us-ascii?Q?P1KRrgTH5sGCsOe8A7iwEMgOSDD0yDF/aKp4bxolNfFa66S79mBCWdHGJYxu?=
 =?us-ascii?Q?8OWigu5ntIUtgOfyRK3k/AJYWRnscpfjGwEW6nK98gYqBKJgNu1YUe7r726N?=
 =?us-ascii?Q?dwJc18WxxahEEFLE4cvZ881GY9GJaDk5GGtjaGQLuXe/bwaJ/52pG4B8j/AX?=
 =?us-ascii?Q?pMzWCx7KAErAXy8thlwsOQ/XSP89XX9S4wLBMUAaehrvYrxSr2JdzYjznLL+?=
 =?us-ascii?Q?yvA6SK9HV9wHZew7gb1qCV2d9HX5hpE4xqLeIYiSUPUwPvI5tt0PLtkLNnOr?=
 =?us-ascii?Q?pHGE9fbanN5Vtd84rlGZrjPlwk39lhjhrYXbh+S8GQSGWHfy8KLqfKLxlS7h?=
 =?us-ascii?Q?xB8CnL68tJr2j84oxI7/eqnErqkhx6KxH0x8WgdHbrS2679Uy8M4NYJw+nBz?=
 =?us-ascii?Q?xnkvdVpfVLJzcrpEnQ9wwz3DJyhW9UjAOhHzuRal3vtLISZEFIEae+JBObqE?=
 =?us-ascii?Q?uHQZX64zDFTQPVWCGcOHsJWN8PK58EN7ax7/XUGKBhC2z4eAIx9ZlENxZzjv?=
 =?us-ascii?Q?DrKA/Zw1gCse5UvKD/PITKaSCqgTBuD8Qe4BY+a66Vf5lJGVggTqhMjNOW0h?=
 =?us-ascii?Q?eCy+oMs4qL8aqDvp63ab+UmjtW7vljbFC+TZRw7lO4p29VMx6CX0ubujGg3f?=
 =?us-ascii?Q?eJnfm6T93g+agw+mkukJ2zhNjkFVlp+Lc4uhLlsJThfM0/HU8y8q/C3iclfC?=
 =?us-ascii?Q?w8FXBc0Msr+YXmsFGJstXIgGoSyuoxlUn6fIcQUQhnIULjRbaeEHSX/WzVpf?=
 =?us-ascii?Q?O33643fsG5V7PzZ8QSXtke6PV+GAVJesLA1ibmW+0i1lvJzm66pD2Fq6LkMP?=
 =?us-ascii?Q?gAP+VXHOKuqeAcZdNT1NxyTDv7bQSvKO5wKxl6qLJWIgg8Ln5hZFIaITLDgb?=
 =?us-ascii?Q?sDru2NGbWg3Fezr6zZSC/CnZa4szBvphxf7SHxM+OV2WiaXpKRE6FKyVmTxG?=
 =?us-ascii?Q?kdftUkTNbJXSv6WbUnVoFhMwV1bF4h12rx5CDlnyU1ZQref+LZr7clBlCTL2?=
 =?us-ascii?Q?7f9+pNgbj6/NxVWyJ+Uf7n/auHFJHk1A/rlsg0TDXr+P/sNTvCKY4N/qbPCM?=
 =?us-ascii?Q?nJy4xZYP6QW4hgxlWrhJqzK+/Cr6jJYX47KqAa9g8hdi8gfo91+I0r5L8SVj?=
 =?us-ascii?Q?7YLVuuwI6WdTBH+Ab5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhxWScVkdQZul/gB4OyUJgJnXxHpyXav/sNgxxeNbqAAWm7sGhV6GgOG4QLN?=
 =?us-ascii?Q?NUNPtd4bkP5huf6XZkN1rsrzoxC8dMhOS7SlnbAD5uqE4Y4QeSZttOILWjOw?=
 =?us-ascii?Q?2AaVjM6x/c7xk+4iAa7Vmcf8b6Ah2p1NKxlJvfdNoplI0QJdt79RtX6e6FH/?=
 =?us-ascii?Q?R0Ye55WAEXXcpoQzbOIx3iFld6eaOsZ/fz03SpYzZpGxIpG6jhuK/wZQc712?=
 =?us-ascii?Q?aCJg0r9VK6ApEIhaHjENFr1mKaJT3yfpf5pfvDjRxx71wsU1uFCDDT7hr2nb?=
 =?us-ascii?Q?4nTmvcilzsca1pwNsTq9ixDYRx+qj/ZM+P8GWZpJ/q+LC/YZAP+d8W3K6k3s?=
 =?us-ascii?Q?xNcqgbxzjbEDcXkJEBitRCjE1jLddaINt+nuFoS+SRCR7Myrgo7bzQpcX+Um?=
 =?us-ascii?Q?Gm6UgRgPqKeAAR26xBbz/Xw8gG89oy7OsaYDwk1gUOrS+D1xBRN//wdrzCxl?=
 =?us-ascii?Q?6cMzilBNcFsYUtJOvITLhb3Ei5y9kIY5TQashcxMlLfpcpXThVf0IvfjdB8K?=
 =?us-ascii?Q?tdB9ECQHUrjYi5PgA3KbyDbq5JgpLUwP7DgQMmTGm6KGuJcN+IqrHnpFUydt?=
 =?us-ascii?Q?1gGZf9Nt6tQaBdElsHnH7wsFRUndxGdIwpKH/R0J68/Cpxe4CJ+yNN6qPl38?=
 =?us-ascii?Q?joCKAaREPvBiPeEbGKX1S5dyDAZretes1+/mJh7b4Ml7E2ELfW52FgJ/Ckww?=
 =?us-ascii?Q?N1gWiNnQzhjmi56ctMsbPMZ7oy5Eep6V1KUbekttEEx66AxyMzvkotr3H46N?=
 =?us-ascii?Q?1XRvN0tl54ByHqgvgs7dK/se4+Cvj8GUR5YQRXd0aE+cv+4+VraL25A0SENc?=
 =?us-ascii?Q?DZFR5KH6v3TWHZpVAR9vZy7RGdUtMvjqVPdHwP3mGsTG4l5D2I27U9LQSJ4S?=
 =?us-ascii?Q?tpGwA8tSEQCp9J+Ah6t1Jodb77KS5MTOKe2XuUUqzVID4oVXn3NXmKIMDOwS?=
 =?us-ascii?Q?AzHzXt8EXb9wZH9qm5TVe/dzG1eWxhYroewJu1onIoSQH5Iu5FJiCBiVrblT?=
 =?us-ascii?Q?ivst5AXe5F0DCam01Os7elTmXybDhVuWFEDVG7EqKe44FzgBGgKM5nK/GUwc?=
 =?us-ascii?Q?+x5DuOwt315W4eJaUg8c7fgZ9Msg/seKF6dQwUP+WpUCdlgaDyH8nBSgIsSd?=
 =?us-ascii?Q?8j+LjHonohCvLbvxifmRbYRc5GWCX5JGOXnNiNG6xJwg1s704epSULo3wsBt?=
 =?us-ascii?Q?1hBk30bB1njCzzr/GWjaihUJ6Z9aewcczvJJI+GzWBmGs3LNG4rKNDsUg5m+?=
 =?us-ascii?Q?zP+GqJGqiQJW+vyNWoB1Txh/M8K1Xa0pJ7SxUTWmyylMmc2r6kUTxcLPRwga?=
 =?us-ascii?Q?1WN4loxBqMbtJIKp74s2dQn+X9oO+ZBSG9iOPoPQsSbz7F5Ud5u02mgU7yvW?=
 =?us-ascii?Q?t/j01FMu30Nk6mRM/dHJu2bX0SerQRQIZtaZ223b0FR4Ik6gM1inYSBNtyQ0?=
 =?us-ascii?Q?SAy2LkXfEl5cViDHMuKoYNlJyTQofHl2Se+5G4yQHpKBVV6pS8dh4QuzDcv7?=
 =?us-ascii?Q?HSB0h5KfCl+QwMA35OAb59wVOZJfJOQTC5EgO7tjDi3VKZGJ6CxsV1eucFAH?=
 =?us-ascii?Q?8yArJp0rKhkHxsTSFNGjNChrbZBV5RTtgYt/RG6/QCPKFRcdF2Xj7o+eQV9N?=
 =?us-ascii?Q?OlqIcn8hJ770JJCw1zA93TJ6go9uSutcWcI/r/kNNL3jnTgdarOk3/B4h783?=
 =?us-ascii?Q?8gZaY1iCVg97r5B8TE3mQn5gcRIltLhue9VOStCwDy6jxzwjoPKZmLp8htLl?=
 =?us-ascii?Q?Ia4XwSg77vIj1NqxH/PeTlJxUoLtce8OhYikf4wLT0BHrHHfluCn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 26573c4f-1ea6-4a7d-9d15-08de6ca43283
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:09:21.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiNXDCE8XK+cEmsD7Vwy0ngXIukyaumhfDavT+FlftkY4AylfvP+4dnI2rPuV/5W1IqnK7FgLf52IHGgZMSiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
and then performs additional MSI doorbell setup that may still fail.
The error path unwinds the requested IRQs, but it uses a loop variable
that is reused later in the function. When a later step fails, the
unwind can run with an unexpected index value and leave some IRQs
requested.

Track the number of successfully requested IRQs separately and use that
counter for the unwind so all previously requested IRQs are freed on
failure.

Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..20efa27325f1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -523,6 +523,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    enum pci_barno barno)
 {
 	struct pci_epf *epf = ntb->epf;
+	unsigned int req;
 	dma_addr_t low, high;
 	struct msi_msg *msg;
 	size_t sz;
@@ -533,14 +534,14 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ntb->db_count; i++) {
-		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+	for (req = 0; req < ntb->db_count; req++) {
+		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
 				  0, "pci_epf_vntb_db", ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
 				"Failed to request doorbell IRQ: %d\n",
-				epf->db_msg[i].virq);
+				epf->db_msg[req].virq);
 			goto err_free_irq;
 		}
 	}
@@ -598,8 +599,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (i--; i >= 0; i--)
-		free_irq(epf->db_msg[i].virq, ntb);
+	while (req)
+		free_irq(epf->db_msg[--req].virq, ntb);
 
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
-- 
2.51.0

