Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9C139D;
	Sun, 15 Feb 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167824; cv=fail; b=oTvJyTY+hVP1UPDArUSMFOXBlsgYAwB9oWaosE3tyFoR7OhFm5/Snk1/4eWlmKYgFwVLlErD9DTcWfD+i7dOUxZB5NhwGLespuH/wCaN5ygVo/QgMmvPNYUCPKzr/UrivS+gCXPYQydPNeP4hRzqSfsu6/XUFaHu4w11YuSr4jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167824; c=relaxed/simple;
	bh=6YVyVDD2ynywBVjBf+K9EDwe1SMnGsp7clz6FLPpG7U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RR367fgiy/U9mnvZJwXj8MFMjdNnMv9PWV9ZtUA4eK1z1cP5e319DovdQ6hGFJjakSrbGMs7kSu3zM4Yy8l3kLhwvElGAD/pZzdg8RXH2GDp6uaxjPjhM3MlxzZNHuuD5iB0Dlm4LlffSuTEiysxMYCyyMVUAhvqmedohDarc/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=V0YaRojU; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="V0YaRojU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDpXmVYQb96KFF4PoP3Md7Kz0ghXvJMxfmBAppbsXUbarp23jfhxLvkdmx9HwhBPmfTPK5hYDilegdUjFnd/97hYSrznJX5r7yigNIDb7ZuA7xzQNOLBnznZfDawV01MxfP2Z4gQYkznKcb62RYoaI0VVGJMZhPWv8/xF/Piy3Sa4vh1DHd3RjoboiQv5EeDYNqC4ECe0lZPdk4cG1EJfvBhqw05jRrUJDYeTPBdjuuN1NPjO7ewQHqJ0SlI/xuFKgj8nnpOYYxBV6Bec6OOOj+ouR5MsLOd4ZwTZlEfLh0DBqrzFz/zxqwnXNYB8k8YGYwbBaB9Dmjp8Ijmqheqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJWr7KBV9jgOYhjghixt5aPhb8z1px981kkYm4uR9Lk=;
 b=EjM7Vok4UAc5/xSKvaLQB0HUgmIld61G36e/qSh02xYlQx3E8j3TpJjCGOj1odYcPRZxX3sV7sPHUqaO85HCpGgrrv1+zUy43xCnwaa4EMlVZK4upMooiSid/60alrvpERiWDapP0gfzlxEbOPr7y3jrZjrHp3Z3Aib5+GabdT00R0tTy7y2heGjS4SJ9ycIWSxo8URs1aixccrcOOzF6Xi1PqHg2yH5qC1+Qtl+HW+LnGV81VsmXII2JO8fyjGh1FsZ6KxBf93h5Ux3VAn3HR4u64MIhLvwtjIfpm91WE71PclXN8BbZQIzVvl47bwXU53elKaHsOaE9av5MOo6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJWr7KBV9jgOYhjghixt5aPhb8z1px981kkYm4uR9Lk=;
 b=V0YaRojUVQrIfq3FVPcSWQt6KH3pmmouFOZ/5cMp2B83mKbIQszBxk4XnZ8xVs4nnSdf23ynoev7Fy06qSgIrbQhDiNu77LhmNyYXgteLbB1GOtf9M4ssFCk1b/5MjVJH1oOJki/6LorEnIrw6LQ566kqhYvipD1ufPsdCtvmUw=
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
 15:03:39 +0000
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
Subject: [PATCH 0/3] PCI: endpoint tests: Make doorbell test capability-aware
Date: Mon, 16 Feb 2026 00:03:31 +0900
Message-ID: <20260215150334.3391943-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0170.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 62220143-7e02-4c95-6d00-08de6ca366f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EsJHsidGbBh4bXEUjzoLXBl74QsmVY3IChwzQurhyDkk7X2F2D83iOaDOvdW?=
 =?us-ascii?Q?fWRtQNfl76df9LboqnsGmBo6+c1jcnLd/SgubhrmahHAisptqAjEqEneihgV?=
 =?us-ascii?Q?uErZIRpv1LVFdNZxp8cSKtohYHhJw2OCSk5z7oQDZFJ1LYHbWIi94IdS5RuQ?=
 =?us-ascii?Q?ywnl5umUgkqnMnz4XR85h/RKW2pFfrJYkQTAGQn7PsxXwZp60nOkGD84XGzR?=
 =?us-ascii?Q?muLqwVIafjLNdn5Se9v00uXXKKhcItfhr352YKglltKQEyVWXQUhPLI5h2eK?=
 =?us-ascii?Q?nBvsZnRLi8VnAhJcjbrcjElgVjF9PMUVCqdBELsFn13973FaCTHLwkclG8tV?=
 =?us-ascii?Q?x6n4C04EyVci0u2bOzMyJKAak8vb/S3oHqN3GVO6g/fdN0F4ZzTVkeVN5aQ6?=
 =?us-ascii?Q?TY0QN4iiRZD817xv89xtLtpXR+CSWmfS+RvzjHc0SUO3bFiohZXkSVX3Nz8w?=
 =?us-ascii?Q?dFdWRx0SGdek6ZxD1p/sVZ3bBPmmmyxEMLarUo82D3hxeGD7ffcVeuCCttX9?=
 =?us-ascii?Q?V1jvO3bTP/2IZDMWl3WdcCaGDizjuqZ6tWUGJondLK4qFDWZYi0f8k4b6I6S?=
 =?us-ascii?Q?NaK9qCB4qKn/7VK3vfH6xw2S/Wkzt2MHsKhRzKDInHeej8ZLkCSB4X9DOtGU?=
 =?us-ascii?Q?FpDYy9MNtF6pmUgUuyU6HNVfjGhO0dosdZPEHLmLwkhyyg+eoZ9JUBkrr3P0?=
 =?us-ascii?Q?6sn80yunhkKY43Z0Yx7wEzx9aiY1LS6Wglya9FzO5wgAE1aJzvl4SxKKX5qB?=
 =?us-ascii?Q?qjPApXE5pJN5rmpsuopIO/MOaZ2vBHC/w7A4XLRWZMPgIp/Ui3UwQ5oIwYjV?=
 =?us-ascii?Q?mr5O3P0HmEVpU+XkvZNqkmHGemA/KVPKRykLsCEgU/EILON2MaVSNOgddsDn?=
 =?us-ascii?Q?6eI9QTIjnMVk7Z1rTagVhZbWt+uUyrQtk5DaBDnndKStehsCTKnVnZsPmJOK?=
 =?us-ascii?Q?ADg9AS57bL2fEB3fcTNfeM81PG5nM2AlpAuBbOTLg4WXmzKIYZ/+1Mm6x8bs?=
 =?us-ascii?Q?bSDSfuCuTPVteDb/Z0mfuagzwCqVfOESQYeZGoc80t75FJj9QZTs7oTorx+d?=
 =?us-ascii?Q?vX9btC3VcnNE3LMZKrf4oPynaz9sqCdc92nOyCpxvg3poGwKoGKoX+PzhkAS?=
 =?us-ascii?Q?jhiVaXryLKlDUyMb+1KsmD3+1J1MtSFMLVwRWmADFmGHbeyBuVXkUx78gcjH?=
 =?us-ascii?Q?FLa6+iHq1572nmMh/+/vQKGjAxZJnI4lNXztj0SuBzU7rI3PqzZ6PPif2CKZ?=
 =?us-ascii?Q?C4/uTTxLgYVmUxO+ZLEpTTWOjHmhhuQpJK4DTsA/3R9Z2BMGKaABboPBM8ys?=
 =?us-ascii?Q?F86PmY2IcigfKVkSz/z09BuXFj6V5l36AHskzYwec1QlLmGrE7DMkA0s9N0k?=
 =?us-ascii?Q?14pFwwbIHkRB5zaT79i1NtQUCFDjAX3Stltb/u9QVLoC4EdIswvvatZxqEMM?=
 =?us-ascii?Q?0EU1zMUiErfllWOlifLFppmhJSYe8WLdthDjfKBE/34M/ZSL2p1CHnKvHgdh?=
 =?us-ascii?Q?66ZxBmw+CxDOorfiFfn4CtU0t8RlC9RZT01JsAkp4zHY2PVoFMHtAMEwX0A5?=
 =?us-ascii?Q?JQx9MRbzo7WCKzG9qb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+iEWKUahD5NeYH0Cj7ueFvLf0gcZK61TlW3zRHQuSE7Y8nOlAQuq3Gbhkoz?=
 =?us-ascii?Q?yJEz235ITWfUFHEAGn3c3ic4O2JnBzSZevyC+Eh9aag9wcYY0MCVBhe3V8tn?=
 =?us-ascii?Q?0X28NG63XQnkXHCWsCA8U4G4Ury7B5XJ0dihDAmUdmLHlLNJR/i2G4F9G9Oy?=
 =?us-ascii?Q?cr/Zy6OEXmEhSQ8NHUE/VMks5N56dKbNxTZB2CHgu0ye0ckWGRihhYo4UyBj?=
 =?us-ascii?Q?ZYWgRnMxRPPkMNCHhY9bhcRl7+bRQGEAbsVWZJAWhMUXm/5/ZA+c/EI+HZuN?=
 =?us-ascii?Q?+XbRTEs+rYwnVQZ29cY7KPeDs0K/wApLp1MZy2hBNyZxDQM/DfRMu4WEmWuN?=
 =?us-ascii?Q?e3fQ3UOk6uiqJlDdQy+3XG1Y09KFwQzc5mFiQcm1oi9dY/QIMQAmIb/DzIMc?=
 =?us-ascii?Q?Z5Zt0lFk8+KCQIeNF2H6gZ1Ksntj2wGks/ur75wEdax86jQNaxSNG6N2Wf8v?=
 =?us-ascii?Q?WuA6KGLNDzJkDU+4n48/ii7n/CpY1KovAMZnrlIM03WoIwNVUQB+rZaVOyyl?=
 =?us-ascii?Q?IPQcc/58aaIW07md/R955oDHfGKCi7e6JzbAaeX+UPuMX6M3pf3JrbieWlK7?=
 =?us-ascii?Q?1Hm+XVpMW2wbrr5NZ+79zAnIuqQBF6uawJM7hgPlUfhazp5ls9YUVEnG5cql?=
 =?us-ascii?Q?WpJYDOppexFqdLn1XFTa0xB5kJ+xPkrvrN2ZRhqjW9IX26wqd70apyP/AYCH?=
 =?us-ascii?Q?Wg3r1n71SjFeiJu6HRpIlGj4/WcpyeEtx2BcPpCjFi4PpFp+FC9mEtG6+rvg?=
 =?us-ascii?Q?y68qZwwTJjOgo2GaPBGM2ZgmzFtRgXgASDw6oH+FQtpqBHjJq3dJIK/33ukX?=
 =?us-ascii?Q?V2iHeQBJDaWi9jCSqdDfXiRmUedyZIl+XDEs5+NUgSQcpMu4dELu3GGSn6lp?=
 =?us-ascii?Q?eU9BXqMTsKihUYngDVsETsY4loFTNtcnNWeR2w3IeWIBPpj73kBeO7EYwGvd?=
 =?us-ascii?Q?JtJxTpFVz3bv/0YGPnSgaV86iJLinQomP+90T+cyLE1nu1Q4ZrBc0Oodv+qX?=
 =?us-ascii?Q?/NilldEYsKW1oa/taQ+tTydtRkbA9xvLJLKP4eG1DFPjrz3WOvq8O02yFdiI?=
 =?us-ascii?Q?YyqzzJxAXskT1qIVW3im2td5Toaci2pQLibtuQu8hVmTfPyF4aggdIwHUprf?=
 =?us-ascii?Q?zna3Qw8OpRSULWag3qDFb7myoucs0cYaVqC9kE4VKHlAfwdYHLrJxOFr5jW1?=
 =?us-ascii?Q?C+1gHqYzG3cxtDqNzL1mfZRRgNcNFESme+twkSAZcqGBL4TjcMR+aX0sRXNW?=
 =?us-ascii?Q?urrtI4w70uIHXinfl3MVHsYuNqHXDsBChv+9GOk4NB9XO6NVuBobnBzBUe8u?=
 =?us-ascii?Q?Ugc9m/s/34gJqyZmTPdhg9jB3qTynVmWnrSiC3A8S8ucBTFoM/oQCgNgxoqU?=
 =?us-ascii?Q?Tjk1s2/Fz/A/gYhqPNV2ptgszQycOSDoR/m0kJHrvJAYRDTQFtt867vf1Jf3?=
 =?us-ascii?Q?N+xPuEd333hMNP4BKX20zmL3wObQfWxIExppOcaxuwgWLL3UbG4NLjPpk0rW?=
 =?us-ascii?Q?Y6vigEwL/19R/nu699PKzh3A77PVo9dNLSsC0hRwEoXEguZqcojjAgAN0PnM?=
 =?us-ascii?Q?e9JTnu7PXfZWrbNtj6bj/WTxMH7nTlDByyhZGtTkmo+tDIqUQKXeqB+Er+KQ?=
 =?us-ascii?Q?R9fxiPt3nXjy2pgAKlqUrbyucM3C/z4HpcSaDoKGhpu8uqQwMwa2fbuIc20G?=
 =?us-ascii?Q?owk3nfFj40fp3OcWf5BLZma2O1lWAeZTGtK/Nsfzd0TW2eUleR3fjLH824Li?=
 =?us-ascii?Q?LELCl1uNF/Z0FiOawTdGr9ELcKsrJiWk4gKqnFVHPvwhpPgxHten?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62220143-7e02-4c95-6d00-08de6ca366f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:03:39.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9Njd3V4CLsCGIe/6rSZurKqmsTRZO1O81JrzDPGOCATNU10ycxICcoAKtsJLiCHTejrX2zcdY0V26tUy+eh9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

Hi,

The pci-epf-test / pci_endpoint_test doorbell path requires the endpoint
controller (EPC) driver to support dynamic inbound mapping. Without it, the
host-side test can run anyway and fail in vain.

This series makes the doorbell test capability-aware by:
  - Advertising dynamic inbound mapping support from pci-epf-test via a
    new CAP_DYNAMIC_INBOUND_MAPPING bit.
  - Returning -EOPNOTSUPP for PCITEST_DOORBELL when the endpoint does not
    advertise this capability.
  - Skipping the kselftest doorbell case when -EOPNOTSUPP is returned.

This small series is derived from Niklas's suggestion:
  https://lore.kernel.org/linux-pci/aYte-7hTxb7kXNlQ@ryzen/

Thanks,

Koichiro Den (3):
  PCI: endpoint: pci-epf-test: Advertise dynamic inbound mapping support
  misc: pci_endpoint_test: Gate doorbell test on dynamic inbound mapping
  selftests: pci_endpoint: Skip doorbell test when unsupported

 drivers/misc/pci_endpoint_test.c                         | 4 ++++
 drivers/pci/endpoint/functions/pci-epf-test.c            | 4 ++++
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 3 files changed, 10 insertions(+)

-- 
2.51.0

