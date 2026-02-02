Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9A8635D;
	Mon,  2 Feb 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044056; cv=fail; b=ktwN4Ttezgt2dykEBztV9Is+iFj5SrR+PFBAGSa5vaECT0Jsti3Fa1Y10mleUg2HxmLyRFnqlWwaI3mOqPrz7pdq09OnLjCFBq/2g12CYwasDK6OX24wmlgw4pdJvLa1mAmSk20Exg1a5UtFyYk4m8gx1oiq2QBQUKqRyitvJhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044056; c=relaxed/simple;
	bh=UlvMfJC0sqZq24bj+UBnONHZolUYtpar7+AjXq/O9KU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TReS8l7bd+Fi9RQZHif9NGuzv4USLUOyz8kPt9gffxLzGFfOeKKF2pk96Bjvls7nKkpmQjCgHtvQy88q/aesxLg7S8j689dERRBOh65OFLkZkf2mB8aKIsAJD8cYhNf08RmJ4quaxM1n+oYuNnMPjuBDiANiBx9zmieH/GTJ6tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UL9e0tbb; arc=fail smtp.client-ip=52.101.229.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UL9e0tbb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD7Ab2HxVO2XV4D1fYXZd3jCdlJo1Gj4szGtjXkoO/wobR9UHpjGDYqB4EffGjoPE27tGMmFtGHpBETc0xa7lNs2SPZJIyTiA3P4nkWgxYb31buBOrQu6Hogm2PoodK+6BWse9oSAVY4oMO1DR42TsqeCsv6a9vSHa32nBIjwwt+N/kSQW3JG9p1BJ4KabyuoFRySIPXn3MqVZXJR3d9GXtaotfNg+C+VogO8ESK4QgcKfNEnmUOhiTWdSDsekdTNR4kNzQBWdu4PWFj9LElTAdPqU2L97PCwZmnQ2Dz4FkZJ6TV1mYG8dOwDzC3Y6omE4l0Xhx7wSNFhE5zYnlR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpQMstyK+/jwg8tojA4vt85XnToC0X9CSVE0usBe8Is=;
 b=pqCodOTfZvpa6sXZQ1cnANbAqNjC7VPliYTdhzzCgoFakCOFJij7Kj8Gx1YvNV4VabW1zBLV4/elVB8yNx2wRk2Qf42Ioem91nRAruBCKLN4oasW45+7VejStO0t0f9q7DAJrS0b9VvLdFe8iqQ/iMN5s5JsX+P1ocoymBxg4hYNp+PvovO8XibSfaJei+wg3ghnB0X29+gfIDAE7Rz0rifaQF5awqnrzZJssKrrJGYimLebEk+LLZpmTd+KphAe9F+/hNIaX+jUsoG0fJFhmGAx05ldvMP1VDH2yyrUVxP+2ov89uYxWmdkg02nEZupOkjvT7rFOD6f2bu9/KyrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpQMstyK+/jwg8tojA4vt85XnToC0X9CSVE0usBe8Is=;
 b=UL9e0tbbZMNblFyy1qQmU+5pBbwurpb/uX9+YGBrqBHKafXzf5EzTuuEhoJEO0NJnNaK9RADi7p4IEZ+m6vFon9BmwZ/a7/Sid0a9akiyYVl1saU5Gx17f73/CxX70I3FhdCqVbLcfbjKeJ3ea4nNZ+ZzYlCFGNPBzYsEVijvJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2195.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 14:54:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:54:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with in-place epf_bar reuse
Date: Mon,  2 Feb 2026 23:54:05 +0900
Message-ID: <20260202145407.503348-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: ab956624-7bbb-4675-4273-08de626aec4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C22xPdMUajXVuRYwxSK/Lt+/eRgJ+shXziBkF61WMCZ2ZJU0znmZlqDIaMdk?=
 =?us-ascii?Q?1qj7FHLZcKsXNzBuS8bfldO4MOl2XCAEGBp0XNnWT606tlEvX3DP901vzoYu?=
 =?us-ascii?Q?YCFpErPBBFrmGCEmgzxmaYI1x/znKGd2RFBuE2XaS1aifVxY5o2FGtn6g23o?=
 =?us-ascii?Q?mcS+4WsxTzAGY5/3GRZzmJHTgBX+Le0m4XZuJF+/TpxnXZF+xEry6CqtneIw?=
 =?us-ascii?Q?bTIKoBOM/vmBMb9yXvV+uGrYSHK6GbuGdC0t1vJEHox7Z4uYfdsZq9+s69eQ?=
 =?us-ascii?Q?x1OQicnwjEwCh8Bozu7vxH/MJNa/peeEENS+mSG9xuknBcFFRNJC7qqKY/cN?=
 =?us-ascii?Q?sKjZQ0wLrtRa8U+TSm82oaOglBkfHz5vwILoFfFK8uIj0VBYfOQ31armYcWA?=
 =?us-ascii?Q?xrLQk1izTzzkd5khD/4wmNjCq3R0377vgWw0nj3REyOjDrh1jHvHMz9bLaJB?=
 =?us-ascii?Q?Rp/tG2F/zk95QoE2bcizVfY3/bZMjkIP4kMCH65uaO2mh0JfQWizWbTUYfoq?=
 =?us-ascii?Q?X6hwSvVsMXyRvvodm8EDOQqdFY7yWW1vP3vPkKDiNAbeNDRnRmR9Pnvficit?=
 =?us-ascii?Q?mk8wcke0fQNhafK2vpyoROU9mldyW7kuZOd0AMV73z4z+2RxkVMw8HihOpDA?=
 =?us-ascii?Q?HqgdzSV0yGTgUlSBb5BlA1xdSdqoZg1vIm9tcbN4iwl7dminxHuCM81KdX+5?=
 =?us-ascii?Q?7EHvhi6jIRwlxuoMqWDRdyZMDE/oP0hcPL0C1UareRje4DhudHynZ4xN+aVU?=
 =?us-ascii?Q?1fnrZhWOuozjKRVpJtfFtDXBmUFgKVswsh6yP7WgRDEybQsbZ8LpC9Nbbp2m?=
 =?us-ascii?Q?fMzhp6oVFJA1MVSZBKm513oNfry1jt8wynyjfI2N4CS+yrYM44XP43Rvd7tS?=
 =?us-ascii?Q?Q0daqpnFxbP7IoApf4pdytZUtUFVeLol6BiU7p0ryWe289TsfvAM193RfkcA?=
 =?us-ascii?Q?P6+JLirt2S7Pw3oigdU0RVmIQNS36Z9yUAtPiJk970wyc+LBrlbRNKRKfX3j?=
 =?us-ascii?Q?Dce8RVmCO/hE4XyB2jEgbsNg5lsxP8a8qvsuX/Rggs1saZpL2n+PBYL3c8zi?=
 =?us-ascii?Q?cNgD9IvDGw2xSGpDhnPmBKWjCbl6hzawRMtboC5AFaKoz3/S2UEpCvgV7lYv?=
 =?us-ascii?Q?bIprLg/Ntmy+e7gC0flsrqdArFoiWxHGxcIpOCQ3LAxAwMTM3gY38I1hsh0k?=
 =?us-ascii?Q?K/uNMCIz8O/4qGY85luJWXIYCVj45UHMpksxh9nieVha7R1XkhQ1k8nTpoQP?=
 =?us-ascii?Q?mqnytddaBAwlXN9ucFshQlrCpeUhm0vlUXdw2qDdCe1ig1IiG/4kgzJVt2/E?=
 =?us-ascii?Q?19PjrS2lNTIH28Vywid/gBtWOXVhQu0cZOegAlDfweBJ6cvAl/WJLpW0s1+1?=
 =?us-ascii?Q?EKRirvGK6bfp74aaKNxEvWm/k7KssD0rG/MQcMIj2cj0b5h1GGC5uPCP/+U1?=
 =?us-ascii?Q?UHyM887i4SeDJnPEGEtwaisNB4D5XTk8VcSMV3G7g5hL5MM6jNyNZSWs+7Vo?=
 =?us-ascii?Q?OhWgKSV5uuQVUPPkxkeT/wF7zzazg8J/71OxjNzOiQB1y2xLo5EuunLDYnBf?=
 =?us-ascii?Q?Fk1AvUX+hVzQ0tm8ve4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+b7u3D9O0nPN/TvF93pNkOUbrdtxHTildsBR2xk/Fc38FzDZwWkkkPaEv//q?=
 =?us-ascii?Q?LwVwjX0cTQLHdke2CE5yFRHnLtucYWYY1xh/YEe7EcFHyB7Z/NdCPUg02e7x?=
 =?us-ascii?Q?ZrFKsxK/kB5id7lc6ZM2JDwUhfs8KEefPdT2Mo0WVxy3VXJn4bdYvlXCifOr?=
 =?us-ascii?Q?Zzr+nb960nAe1Lgc+wc8riIqYejPnmM6WfaE73Rhyb019lpfxpGQ5+m3yMcJ?=
 =?us-ascii?Q?fIbGW6b+JPhVEPpqvqv6aghHK9RzFSrLhAP8RFDebDTjB+YbeEF6uqA9nYwK?=
 =?us-ascii?Q?m+druJYv9HdG6Ymfs6bL6qjZIuBLaD1qdYCdm1ss25v09R7ozFU8Bp9Cz5dt?=
 =?us-ascii?Q?CAckEbCIWvI06gcL8eo5zt7g+a4QOlvh2+2b/+DAVjen3RGwldrMU6krv0yi?=
 =?us-ascii?Q?yCEbkYNazgEf9pGgJetEGGtgVtJ0ng/XByQHZH5zi8w74yZi+SInqJjAsN0K?=
 =?us-ascii?Q?zZ+Llkdjo/RPwRSz94IMFQEq/gYvRd36uWveZsyLZyszWDI8Vpy2GcDMZbkJ?=
 =?us-ascii?Q?aq/TuqrVithFQ5FLohkmmMGnfLZ2j6vPY5bCZmix4g/3OCI3GtqudCy28ALB?=
 =?us-ascii?Q?hxZiC7HApV4dir+JYfujyDHwwp+VENWBxBRuIlpmMW7p7+V1NmCMSlgs8JzN?=
 =?us-ascii?Q?S8uEb0Ds8YwwluMDLlij/fPSsTG9BnnIjasPHbJNjWQvvTcLGu2ptQgazVg9?=
 =?us-ascii?Q?41c0BoSVZncZ0vJz63o1DZVDhqyAc1pIVZweIO6uisULclAV6QnHllYKscBB?=
 =?us-ascii?Q?yYy2qAyYcRppwBoeAdW2m5zo37boxcBHt2GyRIVvqgrpGBv90QEzwiJ9fxyn?=
 =?us-ascii?Q?ntQ00ZGcAllNLFgkf6M7igiPevvBZlgVoR2At2nIKTx+FxV5VtnSUgon8SdA?=
 =?us-ascii?Q?YyOcY3ee9akjG7Rbfmo3xOdpM9u6NcvL6O10csMSNqcHw+96NIb8gafSuWI/?=
 =?us-ascii?Q?pqep5LNqoDLYCNxWW/56cQEAZBYSLauMXvLUJPAfqhxdVlYCIx0nDGSlJ57c?=
 =?us-ascii?Q?H37nWLj4fU7GLaQXIRtgKNdFQ0hEeCQiElfSW5nwn2D0Z5jsV+dq1HwBq+2i?=
 =?us-ascii?Q?ZhK/ZREb2OVhiKZz5DisioRvgXj5FJZPKgPycmqXQzuP576YEsc3NBeVMWK4?=
 =?us-ascii?Q?qLIqxw8pHbHaxWPGkWQrfR5UkiZ4bcQT3brS85fyCk5buecRUsFjFjf5KWcg?=
 =?us-ascii?Q?h8q3ZSroWyDBp18PlRxeIOn0OEq3v0+MtB+qdHKKJhiOxnhcNUnQ42ayNgeu?=
 =?us-ascii?Q?fpvJHLVWbmzOaZD499I224OTerqJyHYgUrJMxOF1HvzOQD8Hj6BZxGKvEI6p?=
 =?us-ascii?Q?0vMLTTrjPnQ5F30WM2fLzsj1fDYIVuFfR8JHMLiNRykh18z74FPNocVL8D+j?=
 =?us-ascii?Q?O8jb9mynCmAljgU3VWrSBkpf61Th70ZXAEunmutMzosWapQbgXPiCjqwWx8j?=
 =?us-ascii?Q?Bgza/h6q3426owWRdKHjpLusUY63s9hTPE+zVhnIv5a7Ut1WJswNxoP3DQIl?=
 =?us-ascii?Q?4x1c8MtLVG9gskB5jrJqs3uXBkCvN2hboHWBGhK0LdhhPO9GjybXZG5mx460?=
 =?us-ascii?Q?khCDUU15cMtpvHH26w4WdVvFivWWVmzPef/vfDdX3BFgCkFuOLIGY9RUsEGC?=
 =?us-ascii?Q?rFgqHN43WHOzdaHZXGMLyXYwFvrW7czc/FyZKveaMCv2XMHthj3VnSDPrmJc?=
 =?us-ascii?Q?kUNl6YbXe2JkZdzPdtjKCCdP89JsGrCbFVXVg0LHa9pQXsWkCIK7afdTDEaB?=
 =?us-ascii?Q?eCoye2uvEP+19wNc2PePI+OrEVcFZrtRxUhyDVrCYAvw40JkF526?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ab956624-7bbb-4675-4273-08de626aec4d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:54:10.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHHo68OkFz9ecB6PmiQTtl6qcBAEUvZLGwA3AYm3NGWMuE0M7+zwhuZQz4sTxZUeoXtvWD63PScJ23cS47xbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2195

Hi,

This patch series is a follow-up to a side discussion that started from
Niklas' comment at:
https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/

This series:
  1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
     by returning right after clearing a BAR-match inbound mapping.
  2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
     dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
     reliably distinguish BAR Match -> BAR Match from Address Match ->
     BAR Match transitions when the same epf_bar instance is updated in
     place and passed in again.

Base: controller/dwc branch, latest:
commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
                      PTM access in multi PF setup")

Changes since v1:
  - Switched from the v1 approach (Y) to the alternative approach (X)
    that was proposed earlier in the discussion.
    Details of the v1 (Y) vs v2 (X) are described at:
    https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
  - Changed the subject.

v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/

Thanks,


Koichiro Den (2):
  PCI: dwc: ep: Return after clearing BAR-match inbound mapping
  PCI: dwc: ep: Always clear IB maps on BAR update

 drivers/pci/controller/dwc/pcie-designware-ep.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.51.0

