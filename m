Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022089.outbound.protection.outlook.com [52.101.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C423BED61;
	Fri, 26 Jun 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503415; cv=fail; b=CcmeQ3y/zdFoYWHtrA9/8WYfq/8936gArx/ED8VvSA5StXAHmMc03yNRts0BwyKRLo3hspU0v+4qPxaN8SALyvQx3pFQok+81hQNwFqILaVtXhTVuZeES4M47QmUQ6MFwnvZYM9mQxhiVbIxYhA3CeUVGlVuW6bAld6RpgfhecE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503415; c=relaxed/simple;
	bh=Cc8OhenOnMvbqeEeblxPlYbDU2m0tHT0CrCZlcEY2D0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=I2nBG/XDVBjQVxRC6vvHhzIxctJ/tijvmcfvSXOCFF/jfGnf36g1wIKX8NiLoD2yvQcfm9i6H5MUWHeYtYyehOjMMpl0YIRfCRY8T4XimQQCgkElgu54AeNyzasThIOPRUM0PNMYQI0jthejeL/iYtDW4ci2bZH73TnTPigORyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MSNRW41n; arc=fail smtp.client-ip=52.101.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MSNRW41n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qolY0YfqKkK4yEToXRBim6ZZm/JEmirjMLHIGEqbltZTlhmJDzLkh1wEOtdhdIhhMuZUKadZI+OdGMH5hlb656pmFcbdmnAvLuRwwQaMIeB8uwHd3/RQjfyWKpbyunDGEZobtoNwsEACnZM3zujnlIGMRhAwg4yQiE8KpmrVcteay14he1gTL/+HxdlM8CSh4eM4KkZx4oeWpzeWlY03TGCT8EjWgiMug5YdSILReskbBaRw3sRrh2ocKfDdR2THVBd9nZonrdZKWcdn/gFF8F0yNYRlo/HSYW+lGm/dUGqfQaUENdUrjgZTubG2hDpW6C50aAz+oPPjx+CCyu5fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+U5tpsnZVZ8aKBVUD8UVsyihBivO5zxuytD8ymygXU=;
 b=J+ipZJBvRUK+2vG5lJhTWnfQeZ5t2WYKDYnc1WVYONs1Nfu1roNRYJ+DhQgjP1QqhpimIxryrWARFYvSIzGKfdrzSbZMqsoBH5QkxxhNReg3TpyXoXlm5tLJMDXqReQZAytlekXFu4GxZsfXkERYzGUhI5/9GK7CvQH5rvc5rjiNI1lWw0TgfuvfCgDYN9wTI53tSo/kSc52yCZKYtheVhl1GZF73Sp62FgZA6+wmK5/S5MONhMvCPBEK0j21pid2ZI/SbQYiDFWe6vYsTSEVAXoAqu96pdWOylWyqM6SU5vZhbs+wYUKcITWEcllPNlHdJBpEz2DUfUkZ2d0dNrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+U5tpsnZVZ8aKBVUD8UVsyihBivO5zxuytD8ymygXU=;
 b=MSNRW41nMubrRVc1ty9tSWIoYxQfwaXzcnzxQVlUAcvIH9og81ISOEGFZb60jecqUG+/TSnCeB5JGv/Ce6zVTxXOssull+XtrebPd3LH8ZSzCHktfDHND145sTD3R9O1rKXIoyRGFQiguiLni1oh/HZDVAxWugZ9OTWODEf59Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2905.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 19:50:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:50:07 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH 0/3] pci: fix UAF and TOCTOU related to dynamic ID
Date: Fri, 26 Jun 2026 20:49:37 +0100
Message-Id: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLXPmoC/yXMQQqAIBCF4avIrBPMwqKrREjpVNPCRCuC6O5ZL
 b8H778gYiCM0LALAh4UaXUJecbAzL2bkJNNBimkEkoq7g1psnqkk9cF9miEqFRVQjr4gGn+Ym3
 3O+7DgmZ7C3DfDwc2YbtuAAAA
X-Change-ID: 20260626-pci_id_fix-83eaec007674
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782503406; l=1348;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Cc8OhenOnMvbqeEeblxPlYbDU2m0tHT0CrCZlcEY2D0=;
 b=wLlEcIiWubLtSHH093DsXa5RS3MpbuvUeNuE0vgAcZ6K6wx4fT5nreT+GSiy50dRtYTqzI7bh
 fgjpJ9CALW5CeNIdAna7e4NdkFGupzv7WwTHptbrh6L+U2aErVTLB2k
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eab9d2c-7785-4d05-ffe6-08ded3bc1f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qHtE2QUGYbthvcjb/9tP2TlkawNRNsBtsc5BPEmzHi4eMOUCTqphfQc5hxvDyijY5SL56b1iuzT7V+ub92R+K5L1ecMPuwCPtK9Jul2UVzUBk6LEkz9BmGNJwOr12pSHzbCMYxjcHb/7TWi9CzrjJNJK2e1+e9y4dkrMxCexZSpVQovtTHXE7h+FbOri/jiOyUFF2Mv931voMwTPrJf2kYXcGGvYbygNIDVDCQvXGy9Q4N6016q6NxxL7B7KuU8teocQj1R6BfY3IxI1M14je/YnA7M3kKjEPLYpggGLi13FZZRKQzupYZE8tVsM4b3pjLLLtWntrTEUAkXjZ4v5VmQru4VOefWddrkBcBsBOj1jd9br6A6fO+YFhaK6jkV31mzMvi8MDTaEEb+Fsr16Lk5hGdMZq5v8J+AHeYo240lqR3vzmJx0jRW5B6bWnXp4Ex9V47DUVj+u6h4duzRh6U56ugmo+lsfX6+JcvsZjQHCbH5ZE0YfvcMHfxF9WgUB9njCKHH9+UKEjhap/81IBUgtrAUt0/kaEmj4144R/PBwlJ10s8ALxcQYjiIllDm8EMw4KJJSGV2KVxmbkD3w02J5T/p20ij6zBbvvtMTddY1BahGeSviykh2Q44DLclX4eIunU4ER9yD3pb0kGo+Gaj+hdDSZn0Jl/ZOzsQ+WNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3I3SjMvYUcvNHEvcDBYUTlZcUpvVEdJUGlaS0ZSbXdUaVIvU3lCR2dYVVlC?=
 =?utf-8?B?TThkREJqTjVEVDZXTjhaZGVaeHNXS041MXlNTngxWjhLVldEeEZTS0RySkQ3?=
 =?utf-8?B?UmNxR1VHd0xvQWYwc1YyNjhkTEVpN3VicThCTkpiV1VqdEk4MUlwVCtrdE13?=
 =?utf-8?B?ZmlBUU56N3V4ZWIzWmJFKzF3Y29TMmI1M2dJMHhwcjl0a1MvUmpBQmU1OFZD?=
 =?utf-8?B?WEJwenppSFV4T3ltZWtzY1VidllpL2VaODgvdi9QdEFGcndBNWNBQkhKbWtX?=
 =?utf-8?B?bEU2ejBOYVBicFNDY0FyWWVtcmJhUFJUNFY0RVo3Rms2dzdmazRSL21EeFFD?=
 =?utf-8?B?YUhzQ0tna0Z3bmZFbTNOL0lhVXd5bU9kTUc0T0lXWXFpZHQydWN4ZEh1S0Ey?=
 =?utf-8?B?S3RHVXdMSUJ4cklVSHpmTXl1Wkh4YmhmaXRYWlp2U09hSmJyQzRwWDZzc1Ry?=
 =?utf-8?B?UmZ1VENNd3RIMWpOL2FlQmw1Q2sxNURPY1poUm90bVhvMFhBVTcrRGZXSkJ3?=
 =?utf-8?B?UHdRL2tEY1N4ZVFQRzEva3NlNndHVm80RHR4QlJPMjlYdVB2TCtXeUowSVVX?=
 =?utf-8?B?NUpVOEhOWVVBcVBOS3dRZXFPSWZZa01vYW1BZk9TeTBuaXJnbHFNZjhTSU1v?=
 =?utf-8?B?VzJoMUI1S0xUZ2k1QUMzZUJCakwwTFF3eDgwc280ZDB2YjRUQXpWbEdNMjlk?=
 =?utf-8?B?WVh0UnU1ckZaeVYwQjY4eWthSzVWa0t2b0FjWXJwN3oxUUFDQmw5QmtRV1pq?=
 =?utf-8?B?Q0JRa2hFS0xjWUp0eXZRVFVsZ0FZMllFTXRpTXBsN3BLaERJYjdpY2lybEVM?=
 =?utf-8?B?ZlNwRzQ1Q1hsekZmd045bEIrbUtpanZZeEZNdk9OSU85S1JNNFU0UkFaYklB?=
 =?utf-8?B?V3dKMHk4dVljYVpmTkd5eVZYcmZkb2MzT2hDc1FpblhYalpZQWNJSVJGWFBw?=
 =?utf-8?B?TUhwL3hIbnFjVnJ6SGM2ZFFaQVYyNVVQQitWY2pQdWdEc0FMRFRDWC8xZUxS?=
 =?utf-8?B?K1l2UHFURzI4bHN5TWFHaWp0SmtmYkY2QlZMT1E3STBzT3ZsOVYvZHJBQkY1?=
 =?utf-8?B?TVMyUEU4bkJVM1hKMmRET1RwNXlKb21QT2tFKzZrOHh5N2NvNm40MFRDYzFn?=
 =?utf-8?B?SklxVWVpb3ZIMHhhblRKa3ZROStscHhrb0dueGlMZ2JBZXhoSTlLcFBJQ2x1?=
 =?utf-8?B?U2FuTkdEWDR5TnNDZUIraU1mTTFqak1oQzByQUtidmV3SXhGbERYSjhiNGdT?=
 =?utf-8?B?KzhsbE9YSEtId1BPT2t0blo4clhVak5GMXU2ZkUvcUhwVUE1V2tzc1ExNXlu?=
 =?utf-8?B?NHUrOGdhQng0TGR2eVh6Q05CcW9QUDcrQXN2ODVnWHV5M0xEVHZ5ZXlXOFN1?=
 =?utf-8?B?UUhXcDlQZkpQZzZ1K1MxQUFlZWM4ZkJqWkxKOVZaL3g4eWFod1BaejlyRnpV?=
 =?utf-8?B?U3dQUnpIbVdpK0pscmt6S0c5RndwNU9TOW9KNWtyWFljUmZmNWdteVNaZXY1?=
 =?utf-8?B?UklHWTV0V3o3OTNsM3E4eXhHdnV1NC9lQXpOTkdTdHNsTTRsOEVSbFd3R0FR?=
 =?utf-8?B?ang3YTFqemhCQS83Y2M3ZDBuc0VIcERhcSt2VWVOd1pKYzdYbkh0WmhobEtS?=
 =?utf-8?B?eVV1U2U1cHVoMnd3ci9veGVkZmdLWVBuSDQvWUsxR0I2dVgxb1hjb0xSMU1C?=
 =?utf-8?B?djkxR1FiSXdLcEwwSEFZdFJzQzFVMFBDK0t0S0hBV0RHZ2VEeVNyS1FteXR4?=
 =?utf-8?B?MU5MS1RZRVZKVUNUNHR3dzlyUG1Rd2dLUWNXMUlDZEI4Nm5tcEFHNEZnMXA5?=
 =?utf-8?B?TkNvbzJ2aDZkNklXUExlV2FrT2xYaGQ0Vys1TlQ5dVhMNklMcnRHOXFSL2Rj?=
 =?utf-8?B?UTBUa1NSWTVudlB6TW5UZ1pYNGxSTDdycXpJcUNpQmZsVHR5YkJLU21jenBQ?=
 =?utf-8?B?T25QaTVscEd5Rzd4bm8ycGdPcCsrU3dGandZa2l0M2g5OU1ka3FhaWY5RStH?=
 =?utf-8?B?Mlc3UG1vVXNkRjArWDJJdGtoSWtVMGhXUGU5alh2bkl4WDNQK3g4ejdPM2ZK?=
 =?utf-8?B?SzRyUDVsUXlVa2R2bHhaRnFtUm80MElyVzVDVkhxTmVmT1JtQ3plRVZUNHZ5?=
 =?utf-8?B?Z3pkZUdieVlUNk03b3p4SytiVzgvUENEZjlVMHdTVHdzSS9sNnBjSlJQK01j?=
 =?utf-8?B?VG54TzFmbHRQTVlDUHRXMWd4L3RhNGczZGdiNDhOOVlDR0R6ZkZxbWwyYnZT?=
 =?utf-8?B?bytZbldBZFczYTNDdlhHa2J5TWxEVUVQcUlUZFFFU3RBc0pDNytWNFRrZ0hW?=
 =?utf-8?B?VTZKOHJlT0Y4dXRBNlNjV2pUbTF6Y0Z1TkFxTFpSMXdET1dPSHFBZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eab9d2c-7785-4d05-ffe6-08ded3bc1f7e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 19:50:07.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsmtaVwsGEUchs4lt/zoSTe5d/sjqbwR+F69htteos88qsI7WuGOMsxlA90xqLuksP2+Po6BvJe2DMbr3uRjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2905

While working on improving the Rust abstractions [1], Sashiko reported that
an existing UAF issue related to dynamic ID, which I find to be genuine.
When taking a look at the code I also find a TOCTOU issue where the
existence check of dynamic ID happens in a separate critical section as the
actual insertion. This series fix both issues.

There are two exported functions "pci_match_id" and "pci_add_dynid" which I
have to tweak to implement this cleanly; I created separate "do_xxx"
functions to keep the existing APIs because they all have multiple users.

Link: https://lore.kernel.org/all/20260618-id_info-v1-0-96af1e559ef9@garyguo.net/ [1]
Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/ [2]

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Gary Guo (3):
      pci: make pci_match_one_device match on ID instead of device
      pci: fix dyn_id add TOCTOU
      pci: fix UAF when probe runs concurrent to dyn ID removal

 drivers/pci/pci-driver.c | 208 ++++++++++++++++++++++++++---------------------
 drivers/pci/pci.h        |  36 +++++---
 drivers/pci/search.c     |   6 +-
 3 files changed, 147 insertions(+), 103 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260626-pci_id_fix-83eaec007674

Best regards,
--  
Gary Guo <gary@garyguo.net>

