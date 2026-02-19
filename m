Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53233710C;
	Thu, 19 Feb 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488813; cv=fail; b=Czihm25m3J9rysmxvRN9CAMVhAeFr8zaA7swwBLJGjWlhi0v7F136VBG9BzmRIOuJaYsAeUAOowtHQkKnzGCkbkuxfzZhlHCh2HnsBNCy587yx9x5Aym4KnSmjZNm3CbwqFrQ0G1YUOrCXZOLdTinbhssDq/3PExBcRli2Czp0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488813; c=relaxed/simple;
	bh=GIZflbkhZO07WX+TexC5hedbkstS7lKC0uH2gTWfi4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6HO+jc8v1EskI/JVf1LCxKdOmQpk3CSe7h0gIt7CUS9g/Ne2YoFqVHpcauRk7buo2hUjD6xxksZUsJLuZI3KGQN42dFbgnMqTSwFzovtB1IKp7tpAD1wGUX2c1i2tUhe9RbnqRHxMkFBjg4OnWE4blWDtNhLVhu0DvQU6K1RJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Nb3hNzfz; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Nb3hNzfz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzTqGgUQh9D/DpB4z90iIRDl/kq8gLMxsk51MuzCWvWE/B6iOX9UcdFDrQGN7yWqtF9jAgYqEussFQGYq6n0EPSp3YpflGrw1ik/FJAAvlQ5sd7dmrnsB2Js2bfuJIW4ivt7Ifu9y8GNSmnP6VCTJ1BrfOzsO9zSZ2Xz83CqIeuvRtFHog03fhMjGJ9gDBc5MliduGVzi+x6b+Kj8RVHjkPs0WaZp/16KR44hi3ruqPa1vzE+HY/tL28PlS06uyHkyx8/svolEwB/oGvVZTNsAujI8QQmVpNn3q6J8YpfwAgsD1ALAvVZkAqgYd7Z8FkfJi9GykZ7/I3PDMjoPqP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0dVLl8lUOYxnuiRAP1lS0amupJvnq3+JfboBNgIObs=;
 b=iJYINrHjQKxb+5IoKP/aa2KGA6osu2TC2EQVq/IXq1ekV8OtvoyGbEwzv8bd0p5IkzXPtvIkwliDXEwr2i2f3b5GoTvMYt9ggSVyJi7U234HNuBlHA+82WjFFO5cs0NdJTho8qWHjEHkQ9lfW0aqX2wD5q58GpjVbJS1b6VrJfJ2JUq4EvS75cpuXCkekh2mL4/5IUz9AHaX6glIBlnVD6ZAbrdGvaidfxaqoh6OC+QPoUa9RPzroVyMc/IBIah5iwtcZZe5FS1AlEKLpI2s5wa6HNULS613buyo3k+n80ehekYYIOwpPt2vNxPs0o9wxqQXBhtYaFvjGUFgPkZTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0dVLl8lUOYxnuiRAP1lS0amupJvnq3+JfboBNgIObs=;
 b=Nb3hNzfzXCiU6bfFjQ7g+AgOGV3k7KrcPdVLwselIzRdwT6SV6UMNTFgGYO7qAm27fvr7NOrSqvf7Vg4H6MotE5c/NdEcsQdHUVxLTcRW0qA2VaNCKbSnKDpnUXP2Ym0zoIv8ewrVqzkumqblG4Aa3Xh5sp3yzce4Wn3IuPXtIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Thu, 19 Feb 2026 17:13:16 +0900
Message-ID: <20260219081318.4156901-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b15d97-2d01-4a10-dce6-08de6f8ec18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICTEPz/jbCZSdgH0jST9tJ3ZUXz2M0iGY6PWZRdILU3BdFlHKcQI59lwegG2?=
 =?us-ascii?Q?mX3jcPM8nTVSIuQd9QZCTONd0i7YJBhn/CQW8TUeE2qNljTB5u5Sqx0iuCMb?=
 =?us-ascii?Q?3Ik2k6z7sfq8VdiQd7G1PDG5t3JCJIKID38G+9OYwrljDhmGAmiIV92xKU4W?=
 =?us-ascii?Q?YqjtHGkw2h7cLLZD38w4o+sOfvT1r8xHfQZwP6AkMYU4s9VQ3sI53XwW7bCU?=
 =?us-ascii?Q?9gUVt2IMwF0X7uo6JZCBYbHYfRbEiP4cF8hJfJrW3CO/UMTeWDwXKsL/6GNQ?=
 =?us-ascii?Q?eryUmiBUg+jdsPjI/wCxsyJF8AncwE+pbi9J+twfy1Cc4iZebmGNZrRCSSZj?=
 =?us-ascii?Q?SVJr4Xn+e75/1ch1g+10w4hpDNUwwVMb353a9wNNGcvUPcw2oy59A6MzZTYa?=
 =?us-ascii?Q?jWz21fYfSCbUZwAt50lzAPinksgQc9tUEJViaU3sEyUWWN6lhgV3HXcAdloO?=
 =?us-ascii?Q?pzKcTFJzfQlrTHlPetqO7bfhIf3+uSQeL02jL3ZR4gdz8pSu5dWbhNh/dAE6?=
 =?us-ascii?Q?GsqHhR2YqMzpS20tnl9BdaTFDklo+Poa6So53KWzcM1qvOxg0/9hIiUYCwyv?=
 =?us-ascii?Q?6izRQY86/YYZRz3N87NI+G0d7/HG4gD2Bj98zR6BpNgem88OspkOUMhekfu0?=
 =?us-ascii?Q?EZlAHxuFZz1B5ogBuAr54QWjOcCQCU8RaNOCkhrOdIboZoQ9f+FWxIsBhAD2?=
 =?us-ascii?Q?fIIlBm7IkGHHRDXRWGjspqNjKYZvvfSYeCoB7ZGRttass+cMnfTQ2BgIxaS0?=
 =?us-ascii?Q?T/mGmvmoWDiMbGtwM6O27fD3yBX3CZj8sCG0oFsPwQwsgQdEBskEs/+uNemX?=
 =?us-ascii?Q?qsDPZPhecWMm6jpcpeakNDxMPAYPJO6ss27MFRu4RBvgh6la4iVmU0uW/SNz?=
 =?us-ascii?Q?IqTKLQ4apKDBa1a/QSKh6kZRHVRpmlp26nMqbpMeyuFMtFGjkW1D6UEM7PFB?=
 =?us-ascii?Q?1y2dirCrDvGUDVtbaA+tGQNd7PENQ/2zyq3HB27RNrRG72DddZ9Cwpgki1fA?=
 =?us-ascii?Q?+8liXlMTo9KWXNuZuJsFp/N912XVjAUjpRgzOVUBqtohubxaakEBRvbA/nHs?=
 =?us-ascii?Q?4tI3ICtoKibpR+l/nkG9nx2EBfAWXB9tuKH3Bvk2IAI449+rtvNucvT7GpUR?=
 =?us-ascii?Q?C+E067FKrbzYcK4QPWuIoanMHFMiXTqq+AuEofqEgNgaLk6bVjB/mTVljVRq?=
 =?us-ascii?Q?tVh989eEP8EzfXl17/Z8rVV3sWSwXPFFgUo3NImg45JmeGB0tsM04DP1Y9YO?=
 =?us-ascii?Q?vcJRN81zenCv8paWZO5pP74gPt7ORf9eUURQNt/1bIOzo2dZYjLhw4leW2K7?=
 =?us-ascii?Q?IYpJnu5kW0MNBEmwengpnr3ir693a+h1tdnGAXgpRg7RXNdIoKJm+aikzOg8?=
 =?us-ascii?Q?UzdnENxpAm5N2g12xJx83b17IsFKmoSWcPv6NX+1Y4kl+aRoW7qNOirbt4sB?=
 =?us-ascii?Q?vh+U1W/ug24BTsYeQZ2fyIAhv6V25thkK75y9P58ZwaTLFFIKFUXl+PcFXJz?=
 =?us-ascii?Q?g65wbVTZzUrXeoMqQAs916QJuFqf7Uto/32rCS4ookbSR3pXDP3rb6+5TLSA?=
 =?us-ascii?Q?2n8+JWOPBFxv+z7lqrrNUUm6qjyslspHRTbxnqeZNnp9S9Unq/xS6I0FYANh?=
 =?us-ascii?Q?1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxYABPKKIHtUNLLHjFmS9GltZ2nTmp6E57Mi+W3tclZLBrekzqJBVs+Ml4cJ?=
 =?us-ascii?Q?869G4Y/AGD8QdtpsT9vIXhuMGze4lrdIpeT0Asy5WGRtRusfqwPO93zPK3nx?=
 =?us-ascii?Q?tPDMVtonpP5RAdOLQAgz87HjRkiny1gk75OdWPv+2UgF3DypAvbI2oburWCE?=
 =?us-ascii?Q?vEEMpaXPig4A6GknznHMv0ncK+Qu+NMuOLvYZEqa8TxcR/rzMeyqwQlV3g/P?=
 =?us-ascii?Q?SFe1I1WgKqTdMBCvKmBubkTcoAHEBJOttIYHhCvSg3Ml33KSUDJ0oWk7mLFH?=
 =?us-ascii?Q?mdvUXZh6g4ZxWxBdFFIwt6+HnhV7JSb89hQXPQG9MjNp+kXt49z4EsgP81kt?=
 =?us-ascii?Q?n9xRjFNbDpbuzthlHYn4ig2VhUR8QQ0Es5e4KZvC8NnuQsarU6APPuwRnm0I?=
 =?us-ascii?Q?wQd1usZO88kplm/5NioLTFS8FoOErjcay+h3kcfLD4+OWXPYSPP0abDkOJr4?=
 =?us-ascii?Q?VXCJ/s0urxXcU4f03UjBvQMV/vVkDtZkw2Z4px9FShXG1/1kzCJOKTp5vQ3x?=
 =?us-ascii?Q?9J4Dw8/t9Ze+sY9e0DUdoBpBIQxVGeGHbqk/8fQX+YnTeJ5T6mrtm5HrUErp?=
 =?us-ascii?Q?dAQdax+pJ+pJR4raEOmuOHO13KICYdpYwoWMfXPyN6w6Crl9zSXBIXfJjoUF?=
 =?us-ascii?Q?HdzmJ/176oCpdjQ5Ifn/QJjQQQvAvWQk9nCN6DlDtCgFdBNIPnJ1sKYlQqOd?=
 =?us-ascii?Q?s3qWxl0dw/oFmgZ90+GqejHg3vLI4rRwaJ1JXoWfR+eou1FVCFVFrRVSUkeE?=
 =?us-ascii?Q?1FvOHt/ayTbjWONx9p7lsU9tZDkwU/RxfZCTeWDFcTdzWhYzU9V753CTLUZ9?=
 =?us-ascii?Q?zg1pafO6SJi4czE5b/owK5fe6C9C13R18sRj4OArG1SMXY1T2FaRLne6MYrx?=
 =?us-ascii?Q?vcq/hJGIWSFiApjFiESPOd0uo8XiH2huhcmlwze0wqHHj5uZ5vw49mV9648v?=
 =?us-ascii?Q?T4AmdwDU5Ay2PNE2KJ/tlqiHGd+cdA7tmDrz1m8fsWslxX7En+Keif0Q/hdG?=
 =?us-ascii?Q?UiGiKdfB0biMPJVknUjOoY2VkC2ItuyfndiuDkv34H78HzqdjGC+0F1p7m9r?=
 =?us-ascii?Q?yGSXodtHZULOH0fXa432pOPC7vvssBfdI4svcxFG9uqTMaDQyXNW3bhOxgZp?=
 =?us-ascii?Q?cnmLpXl+kkBAZZ6IpqPFVyl2+dm/JkFh7MLQrb2Z1mSiK5gHx8cuuPpOTGtG?=
 =?us-ascii?Q?IXpzLZVXjo+63kvWy0vYl06ZzC0yi4GCuvfAM7JVcP1MCIjQ/VSxmJvqeeXS?=
 =?us-ascii?Q?GUgkVb10fLxL/pQaYu3Z5XvHL1Fx/ZlirB60c9VOFPbRd2Pl6tNRzZ5pY7Pp?=
 =?us-ascii?Q?Ilbf4a5siA32TvlhVVipApXp+2U9LW5kLtALPsbQAScQxREHxL5lzIDu5Tcr?=
 =?us-ascii?Q?YE9Dq8V8GX2sqx2qIoIM9OFm+PDetKBmAl/NrcRi4IbyOGPQq5CzKXC8fwlr?=
 =?us-ascii?Q?015hyX2rGH7fjWQyjH9Z2UQQ1xTb+bgk+WnYiTGdQz2hwbyFuzS+7QRMT5Zk?=
 =?us-ascii?Q?CqyPD74WBDbbDFT3z6uO0AJpqqXq9zwd5Q30sudTNLLxklpYHJztUZNOTsTl?=
 =?us-ascii?Q?lV5BiwM5ZwSl81a59i7m/U369+OBSIGrvnqMcLgX+8CSdTCvPAaDwrreWyuw?=
 =?us-ascii?Q?jrDMfcrfo3mAbd9R1t1K1+lY9CtBB8TC+bvamHb0yTkjzq0m8ebb3fJYXMVx?=
 =?us-ascii?Q?QF4IW2OeVaqJ+o9VimZIYRZj6Zui8BxmW5Ku4e3wGr+ClZmfDIXE9RZHpEzH?=
 =?us-ascii?Q?wZV8Y0QpiFOgN87H4TJut7ex3w06CVGJjLlIF+keQi4sUZc351Df?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b15d97-2d01-4a10-dce6-08de6f8ec18a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:25.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMNYcO3ShqR5yK5Q4RCz4m0FGbUNxbBmvwZtOksMs7v94PdFEDhSR64fcFHM/D5KDGbxWC/ste6zNiLK0AV27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

Support doorbell backends where the doorbell target is already exposed
via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
must be requested with specific flags.

When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
pre-exposed BAR window and skip programming a new inbound mapping. Also
honor db_msg[].irq_flags when requesting the doorbell IRQ.

Multiple doorbells may share the same Linux IRQ. Avoid duplicate
request_irq() calls by requesting each unique virq once.

Make pci-epf-vntb work with platform-defined or embedded doorbell
backends without exposing backend-specific details to the consumer
layer.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v8:
  - Reword the last paragraph into imperative mood
  - Rename s/epf_ntb_db_irq_is_first/epf_ntb_db_irq_is_duplicated/ and
    invert the returned bool value

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 52cf442ca1d9..7a27e9343394 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -134,6 +134,11 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+
+	/*
+	 * True when doorbells are interrupt-driven (MSI or embedded), false
+	 * when polled.
+	 */
 	bool msi_doorbell;
 	u32 spad_size;
 
@@ -517,6 +522,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	return 0;
 }
 
+static bool epf_ntb_db_irq_is_duplicated(const struct pci_epf *epf, unsigned int idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < idx; i++)
+		if (epf->db_msg[i].virq == epf->db_msg[idx].virq)
+			return true;
+
+	return false;
+}
+
 static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    struct pci_epf_bar *db_bar,
 					    const struct pci_epc_features *epc_features,
@@ -533,9 +549,24 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
+	/*
+	 * The doorbell target may already be exposed by a platform-owned fixed
+	 * BAR. In that case, we must reuse it and the requested db_bar must
+	 * match.
+	 */
+	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
+		ret = -EINVAL;
+		goto err_free_doorbell;
+	}
+
 	for (req = 0; req < ntb->db_count; req++) {
+		/* Avoid requesting duplicate handlers */
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
+
 		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
@@ -545,6 +576,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		}
 	}
 
+	if (epf->db_msg[0].bar != NO_BAR) {
+		for (i = 0; i < ntb->db_count; i++) {
+			msg = &epf->db_msg[i].msg;
+
+			if (epf->db_msg[i].bar != barno) {
+				ret = -EINVAL;
+				goto err_free_irq;
+			}
+
+			ntb->reg->db_data[i] = msg->data;
+			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
+		}
+		goto out;
+	}
+
+	/* Program inbound mapping for the doorbell */
 	msg = &epf->db_msg[0].msg;
 
 	high = 0;
@@ -591,6 +638,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		ntb->reg->db_offset[i] = offset;
 	}
 
+out:
 	ntb->reg->db_entry_size = 0;
 
 	ntb->msi_doorbell = true;
@@ -598,9 +646,13 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (req--; req >= 0; req--)
+	for (req--; req >= 0; req--) {
+		if (epf_ntb_db_irq_is_duplicated(epf, req))
+			continue;
 		free_irq(epf->db_msg[req].virq, ntb);
+	}
 
+err_free_doorbell:
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
 }
@@ -666,8 +718,11 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 	if (ntb->msi_doorbell) {
 		int i;
 
-		for (i = 0; i < ntb->db_count; i++)
+		for (i = 0; i < ntb->db_count; i++) {
+			if (epf_ntb_db_irq_is_duplicated(ntb->epf, i))
+				continue;
 			free_irq(ntb->epf->db_msg[i].virq, ntb);
+		}
 	}
 
 	if (ntb->epf->db_msg)
-- 
2.51.0

