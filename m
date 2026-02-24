Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEF39E6D2;
	Tue, 24 Feb 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940113; cv=fail; b=Wq5KUFyt9sUlKd22JP50tst9pFncYuFpbR3l5hhNXYBwxCzQgxiwKIAiGAx3TWa3KMDm3tF92FU57S3s2ZcJjsE84IkdiUg1v8ShRxImXoZRZE5lBiOiyi4C+a8A4JclXH+PAm6hyVOKrtNYRac4atKpqiV1ZNOgq/10BGT8Fas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940113; c=relaxed/simple;
	bh=hmD/znKTLhHpiGrK0daAxgKNEb8flt7s6kr0jouxe8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dp88TVfkZM3Pztzy5CbZrik1dT9vDNIipTr9SflJG6KOUxHgHZqbePQJAjtQZRuR5/tRCBFT+yfQUU+TIt/OTqPQuqc3P2++4iPQVsR9esNSi3cnPylVe8b0hZRQ979zY2xx866WqsOdCtT9baA0cfBIvWwz6NHlyBI1Ij3IR84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HE8URF58; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HE8URF58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwlE5uK+Fuu7NkHvBL43KDu5Et0/kT4yV/hyjmEKlwXZp3gSxZ+bbepGJQxqJtmy3EjX/YSRnvDU007jaxnZohZsjXrWLyTnIlc7XRSvF5OVe9J0jPKM4y73XPAPEnH9qOVRocv9C33VHVopwANyFnjqftxUrnIJjowBOFZGiaMOlG/DYwkWcH0A8ERt6h3zvUqS1RzDAa3gi8YOJiXT2fm2IvjnTHPkZwdRhb0LQJWyb5NClS4uI4YkyF0kw0wE6p4KM6fQX8LQcOqnNmVmuxZ5nQs8mSF3V6ty3ZtVPTys2oT+yBECJfwjGL2MhH0ZSOYwP4eKEyN8krMhDd02mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLSX2wW78oH27ixUIHz5Mz2sWAcTf6RyMzjguOzdPxg=;
 b=ZsgEdODkvQCmQx/rwsn/7PR4BN7aKJa5i47NskB2JtSosAWNtClWmPnl859eMS8eBxxOdQSVBRgl59UQFq4YypFF/Cxi2YralCtQvPGnJHFOxOb4a5z3tBbBF1ScROKa0t3ocqQHEd7utJzLxpnmgffyJD6fqgA22TCDfRcvpckxitTTpcreZm0UainMknhefpYfQNHt0JqcI5XcWbrp+IHuE8N5ZFixR5HDs9Iumo8KO4QljR3pll+1oriBUmohPdyFtvkzXTiD8vuqHaKodwo3W5JAchmVbZ5OBrGGl5lLbxu1Jqr6QrhyvK6H2LehJWTH7PYZ7Fvqm46eZkP64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLSX2wW78oH27ixUIHz5Mz2sWAcTf6RyMzjguOzdPxg=;
 b=HE8URF58ugY/DRB4+l/UJqkbQKzxSMERDojlqBd3ciD4SHsfCVjj4hb4kQyzOD/4NeV3wRnUOqqeoc1VjPw+hfQfLQtZdTjjlWPrg16WrTN40+cXiHKcNT30drilcLYB0NsHAyjZBeHhANlKFjpfxLB0nWlb3eiqXAg868fV+b0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4764.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:02 +0000
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
Subject: [PATCH 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
Date: Tue, 24 Feb 2026 22:34:49 +0900
Message-ID: <20260224133459.1741537-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:405::31)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f7015b-537f-4d64-382a-08de73a9833b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ga1uw4jkytUxEbFBgbUMA/kn5iB91XPNs+ZXfov3roMU3k0KBu/sqanc+aD0?=
 =?us-ascii?Q?6XqGdFO15VTsBJuSg9zjkzDVkXnCU3Y2Omu1DD2N3eMYWW4N5o9QA5uJnTE2?=
 =?us-ascii?Q?joGDpeMgrjqvyGXyUuZlWDg/+rIL24UM9/M/O8Ugc0+tYNCOfnSpLltqkm7V?=
 =?us-ascii?Q?fQvIBKXL5AguYshGNK1ErZmPfrlc4kogS7/h0a3KFAOJOoA+vHKwugDhDvsZ?=
 =?us-ascii?Q?5/9oWwAZ3JS3YWSSEL2wwwTHlr+nm1lAcipUMD9XutbPguHOBEtJVxjQsBLA?=
 =?us-ascii?Q?iuEuS9djqsub5HJlQftWKVzwFzni3SHRjEEyq7proG9uGYUZVySsD6NfmAak?=
 =?us-ascii?Q?AHT7VT+jmPrXAi5XIZY8aFNS0+XiXMhwDuin0g3/S0sHbNkyyZzNlkyT3lRc?=
 =?us-ascii?Q?+QagIf+f5R4fDx/W+XC5b4oBzT2PtR0viV77fy3b78PvoMwTXrGteL/GqM99?=
 =?us-ascii?Q?PF+8aOSOaW7K2UAYuOrfic0cszvw7783XWYnOlqLq+43vsPHL5h6puYgvhVT?=
 =?us-ascii?Q?JMvGSflE1DFgpgvt+Az2H4Ogk6xvg7jNr/hScZRxlOW/qkO5vauBf9QHOYSv?=
 =?us-ascii?Q?2n7tKqpo8rAzd6iOv4mcR/vTAPdbb7352wNjI3Y0/M7GR8fLLPAbY8YPm/uL?=
 =?us-ascii?Q?jF9sslwM+hLLZV44Ew/RNiZUsOOybQoAKRiIpdbT+g56Dh5jyjWnCvoY86Xk?=
 =?us-ascii?Q?QFYeEDi75jCxcs/Ids/z/m88ZdPuTBUWVjKniUvNUaIVO31L2Hb6GEQwQMrV?=
 =?us-ascii?Q?iq5GtMTyoCLIXo7CdkxzQOjG1jgwhnn8AoK2fvPaopcCsBee9OWPaQXTP6so?=
 =?us-ascii?Q?dLJNDki2kbFbGk5amLHa67WHlZHC009JHFvY9Q8n3l7Om5I0Jv4FWZcCN0Ni?=
 =?us-ascii?Q?1J7qBdBKInhAbs0sPBg0u2J1XiKYDxczdWEiDA4GBuNPgbr0FsE5On9ctL9l?=
 =?us-ascii?Q?3+NDBr9VrGVkR+8hyPPlXisLNJ0L4MkFD3b3rH34tIV5NkqA80d/9UC3TdZy?=
 =?us-ascii?Q?zVjHTdXJRl04HrP/TvKunT8ABv37UIKeVyLx3QXE4dKNCLTVypQurjX1OXqp?=
 =?us-ascii?Q?xkVapsUa+BtJhgGaD+S8wuq2NJwtuB/nSNUPFEQ+4u+jEz/szwQGJZICkPuh?=
 =?us-ascii?Q?/ZyTTxtfuSs0fatc1F3g0eYKW3qQCg51E7MIr3E9Ky48fW1VO4lYjk+gvtEZ?=
 =?us-ascii?Q?zm1W1N7dw+Jv+C7htY4AaBas9ejUdg0QbvKXD8HsUECUWvT9WIAGc/KNlc9y?=
 =?us-ascii?Q?VOilYTZepXSuv5896gLwztWi974fgYfw3XJmFFOuzngivE9MHymO/hN/oUlT?=
 =?us-ascii?Q?/9PFyNEm3YCAOBbrs7uHGoWsmw+Qp9VECu4nxgbTCq/4ytahylE/HgrMHJ9E?=
 =?us-ascii?Q?GY8l6ayUy1dZeedDFbYtOtqX5ur5OO8+JhDV1PxdUVUct4oQFoTxXKKTnqHz?=
 =?us-ascii?Q?6L34lBGA3c5peFSxbhCdX+60hVITNLAFbey3GQ93SbHkFrXwdwCHcMUsREfP?=
 =?us-ascii?Q?yJZlz1ja+wua/vcVseV3KDNFIUF51ZyJnqQLPIojhyiWHoEjCQe8fv3v8mD4?=
 =?us-ascii?Q?c8vRm9KB3Nk6p7cFS5jBQaYdtX1DxeJ9HTFY+bwD18vt6T9eJCrdPOqc0oer?=
 =?us-ascii?Q?cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FrfFJa2u3X3ceE+RmhG32mr8dZiVXCVQ23UvE6cc5I2DozMMBylG8vEDC/T?=
 =?us-ascii?Q?fX9L+p7QgDnSxBwA/NehJ0rA0NxvJrZ8ArxJwHRVbmL9xp4jaAWwSotD6jz3?=
 =?us-ascii?Q?zZ89n0qDFvHyo9jwQNrxQ3N3WKqLsiUH+2g5doEWq92Q/akZS4sH/Ua5gu6H?=
 =?us-ascii?Q?R3LHSmrKBg6dCh5BTprOr8LUGbC70l/m50UUuvAsMLMeKPfYpM9u7/w7FjQY?=
 =?us-ascii?Q?TPprSLyPoszaNDB817EkrYMWUobIYwFokeDb4gvY4SG408/a5VvCJQc1xgrT?=
 =?us-ascii?Q?S1YxcxCrNkZZqiV2UOm3O8mWNyZ+QGtICm2jy/x2kriYD7OzFQIWPycB+Fn8?=
 =?us-ascii?Q?m45m53cNSqNmTmfklYEj6xepwbwHBHuFWyhqvbsZviqkIcy9fIRSUDvrqQI7?=
 =?us-ascii?Q?amSBoQIGfrMXeNhVDr2LuUra74O88dU7vd9OgytkQM1085NjxRGM/XvJPNqW?=
 =?us-ascii?Q?glnOYrdIxIiGZDOsJemrAW8Tjn9+oP0n/YOxJT3YyNRrbGfJM0pF4LYVdpbG?=
 =?us-ascii?Q?3WT9J+5FsyJkz2p58Exk/1NPdpuFk2UIw3ByKica8TqzkFGxq3qIMCmpUck8?=
 =?us-ascii?Q?Y5mzgPTRE+83vusc8WjqHbgH5+U9y08oezeiDfB20DwPwcX/FDStcrLMEqSN?=
 =?us-ascii?Q?hiGbenENVo8aeDMRPym8gO5Ews+eBKHYNfLKSpXfhTG425dsxON5lCiz7LnY?=
 =?us-ascii?Q?Yq8uDngeBqm4jyslqj4Qetr25YvAx872/CfQBHXEP1nIjAT8LdKJd+vXNv/N?=
 =?us-ascii?Q?gvQH544MO6Ki8tfcfsyjkjbjH0A8hF8RPRKM3l4TkwL2gdMfrEvTpDcw50l2?=
 =?us-ascii?Q?iUkXBnzONYwymIhItEV4j/36A0rBDDOCNCfRxD74AcWBL2+Zt4t47MW8VFVT?=
 =?us-ascii?Q?rrLrw/o4rcjrSwZFAc7OG7i+GPwSjIl3MfnZJROpazEKN5cuMKIlNNOB4+mE?=
 =?us-ascii?Q?Y7Gg1fG+pb3pX7Gb5EtrfmfZp7xnp+jU54/iBz2Rrhhy9eJHuyIWAjKNiRYP?=
 =?us-ascii?Q?kNzdXxxQKm+dfrtdxtpA2lpbvCCkS/q521ZA6LILKYSwLlQScpFK41vL5ouB?=
 =?us-ascii?Q?aL58v9Fdx4ASW03W+JCd9HTyHqCxN13JHKYk3Odi6sdV4+joby7j+JJhKJaW?=
 =?us-ascii?Q?pJ342GS8fj5o5URJG/dqtLr/4+iX14JvFy9xEWI7ZQnnAX9CG9wnybQX+GDJ?=
 =?us-ascii?Q?ikb3iydKTX8st/5BW1UqFrOWiWyGOsTv2eqXiJtELr9/i0lzX96FEOFyZLrD?=
 =?us-ascii?Q?77k1+74ztFGdUKhtvOHGS/kmcTCnjRY74pLl3xkxfv+L3v2FggwNZDwRBk9N?=
 =?us-ascii?Q?FqndOuM6Ih3IuMcQPXNdP1tzQWldF2yIRES3wq5M5wQdQxioIDTms+Xc+2pd?=
 =?us-ascii?Q?kQbpQe09ZI7vUqm+vDUof9Lsy7sjYuPcInBBWWuiKFitn5hVpPGoJto9dx8y?=
 =?us-ascii?Q?hQY5xJEdSgj7DpWEW+FkTkpkHPuhNn7DOMURLARcNj+xIck8K2jSvg3UFvce?=
 =?us-ascii?Q?U/hQ+iCKmJ6/HAWEWeEcT4a1pRWIBNtO3ZlKJZjXg/GZBvFrdG8T+5oNWUvu?=
 =?us-ascii?Q?Htxg7ywdAyw6x7o8WObhNCd9xEUYbgDPpypJkrnsDzIDis8XbXHYSkBnMqW9?=
 =?us-ascii?Q?CVaclgVwIKvHF+akX3FzfHgDPTTM42lsfQJof3OI1m2D9m00dt4KdBrss4FP?=
 =?us-ascii?Q?mqNIefF4svUnW4vL8Ocrgvf57R5yu/67FQ1NEfLnDsK2hKISltSkYwmlLCfd?=
 =?us-ascii?Q?WGrtC+7h7WKbQIP0P6exJ79ZidVxbkWoIpGlFW173YAAMbdybNOi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f7015b-537f-4d64-382a-08de73a9833b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:02.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74yHYAQ9k4nzllwbXooYS4n/TmEst5nTPcFAGNCeoFVqZet6fJP1VzVPVoQNVqAAIoqqlfdJSQthRjfXt2m1jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4764

This series fixes doorbell bit/vector handling for the EPF-based NTB
pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
without changing the on-the-wire doorbell mapping.


Background / problem
====================

ntb_hw_epf historically applies an extra offset when ringing peer
doorbells: the link event uses the first interrupt slot, and doorbells
start from the third slot (i.e. a second slot is effectively unused).
pci-epf-vntb carries the matching offset on the EP side as well.

As long as db_vector_count()/db_vector_mask() are not implemented, this
mismatch is mostly masked. Doorbell events are effectively treated as
"can hit any QP" and the off-by-one vector numbering does not surface
clearly.

However, once per-vector handling is enabled, the current state becomes
problematic:

  - db_valid_mask exposes bits that do not correspond to real doorbells
    (link/unused slots leak into the mask).
  - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
    expects a 0-based db_vector for doorbells.
  - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
    it directly calls pci_epc_raise_irq(), which can sleep.


Why NOT fix the root offset?
============================

The natural "root" fix would be to remove the historical extra offset in
the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
Unfortunately this would lead to interoperability issues when mixing old
and new kernel versions (old/new peers). A new side would ring a
different interrupt slot than what an old peer expects, leading to
missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
are implemented.

Therefore this series intentionally keeps the legacy offset, and instead
fixes the surrounding pieces so the mapping is documented and handled
consistently in masks, vector numbering, and per-vector reporting.


What this series does
=====================

- pci-epf-vntb:

  - Document the legacy offset.
  - Defer MSI doorbell raises to process context to avoid sleeping in
    atomic context. This becomes relevant once multiple doorbells are
    raised concurrently at a high rate.
  - Report doorbell vectors as 0-based to ntb_db_event().
  - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().

- ntb_hw_epf:

  - Document the legacy offset in ntb_epf_peer_db_set().
  - Fix db_valid_mask to cover only real doorbell bits.
  - Report 0-based db_vector to ntb_db_event() (accounting for the
    unused slot).
  - Keep db_val as a bitmask and fix db_read/db_clear semantics
    accordingly.
  - Implement db_vector_count()/db_vector_mask().


Compatibility
=============

By keeping the legacy offset intact, this series aims to remain
compatible across mixed kernel versions. The observable changes are
limited to correct mask/vector reporting and safer execution context
handling.

Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
applied separately for each tree. I am sending them together in this
series to provide the full context and to make the cross-subsystem
compatibility constraints explicit. Ideally the whole series would be
applied in a single tree, but each subset is safe to merge on its own.

Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
(not vNTB) bridge scenario, but I believe no changes are needed in
pci-epf-ntb.c.

Development based on: v7.0-rc1


Best regards,

Koichiro Den (10):
  PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
  PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
    context
  PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
    ntb_db_event()
  PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
  PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
    doorbells
  NTB: epf: Document legacy doorbell slot offset in
    ntb_epf_peer_db_set()
  NTB: epf: Make db_valid_mask cover only real doorbell bits
  NTB: epf: Report 0-based doorbell vector via ntb_db_event()
  NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
  NTB: epf: Implement db_vector_count/mask for doorbells

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  79 +++++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 143 +++++++++++++++---
 2 files changed, 196 insertions(+), 26 deletions(-)

-- 
2.51.0

