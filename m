Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021133.outbound.protection.outlook.com [40.107.74.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D442765C4
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690895; cv=fail; b=R3A/bEYQmJHllk9TJcw32alMyFJvg1mXzlargKe4veq+drnnGaBpKXqslZloTZ/hCASWr0X2pGPVz4ErHJKbcCWhsO7kGWpkIJEaNQHpuhacOGD3Q8AvJz0O9gLQ39HEqhxN+X7aQGNVuqqj0ZRM+RdUVgDSLYysjtav6LmStbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690895; c=relaxed/simple;
	bh=hy8629eYP9TYgMEI2yNx8ldEchRPtuvcF6yae6aDV90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8FKN8SLtI0Lx+qq/C5lq2XnhKsVu1kKFvys/SGoddRzwSIVtvCqWViDGZ+YRvQr7OEjgfl5oqtGzTKo+07tFtxmWljFNR95P7MzGir8A015P/847aAHKpFTOHmnAd+CNcqMXIKZuVaZ87A3R3sXsBH/sh9ATpeRzl5FgbxJqTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=reBLobyf; arc=fail smtp.client-ip=40.107.74.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="reBLobyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc9zLgGzKGPLxinjSZyuNA4cHVMi2zvJK/zi6mG+uoM+8yyA1hT5ewXgMXixNqOD7+tEKPopgxuNsv6sk2YEikRrQLK/TWPiLnCKzcN9Z3Yh5Sqat7dpnob1vKuMcHPdapLuM1xIxuovpCDcjBlINmdz0j+3TvbSPxmB5fyb9HGUCleLoqTMBkvg/LGarn1mFMueG2+SJrMelgNquX7vKBBHAF1aXW3KA5T4Irn95dhhk2jaqRCn2h7Xj2UOewAJ4iNo/FGbGiV3n4lLqa0ltBlavXBkDqWKcQ0A2B1ro08JIC95p0pJaNB8x0wFRgXl7osR3K2sbkwoqitj0t9mKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntb8rEx3EezVuD3LxBuRmgMqXvCZktIPzC65+wPc/Ls=;
 b=vL5dU3x/bnyW/R2DsMIINUA7KJX0tBDSXtVmQ2tttCmMl4AoHU0YjhBKxkBJy7Wutv7VLZr6cRe8b/AejDO13aalAP1h7v/ZrLzUYTc1n8HuFE9vZHalaJz3NfhZSK6+3Z3rEkVJXD18yEEv9PkY/1hq0RxrpRp4YGXhOFTDYmFyzeEPFQZA9N50ZobG5D5o/WcKyI5pfn/xY75i9waIP8ND/ACChRIujttZnKbXVtx7h2Ge6fLDeO66xUeVfcoGD/DEc0XotL4Kk0FoxM8Ym5mfA1m0g2AtfoyIpvd/rWrjMoB0ERjBgUaWq6LvcqnGSQYJT+f5YYGCUsHqdXfWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntb8rEx3EezVuD3LxBuRmgMqXvCZktIPzC65+wPc/Ls=;
 b=reBLobyfxJD/dT5px+ZXZx+iNUnLsZr249cardjcCKcvsals/CbIasp6L8EF/aMr3D582gPUZtcaZw6UHw2bu815jpw7A0LPGQu+zFtHimsMQu63RyqDswpVpM1nGx+iqM6UsdSuumcKSDpMLNFSzrySRY9bzXSflw30HZ2FvNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4906.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 02:34:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:34:51 +0000
Date: Tue, 10 Feb 2026 11:34:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, jdmason@kudzu.us, 
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org, kwilczynski@kernel.org, 
	kishon@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] pci: endpoint: pci-epf-vntb: fix num_mws in error message
Message-ID: <zcvr23kmmxzsj6kuiztgrotpncsprx5lynzviz7udnq5mwgcbd@3nspaqkkcbcu>
References: <20260205113040.240354-1-alok.a.tiwari@oracle.com>
 <aYWn1n0l6cuogxqU@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWn1n0l6cuogxqU@ryzen>
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0506ac8a-f3cb-4214-fec2-08de684cf764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9fvjGsnktC2hqbJQqzU5Kx7SFFaPn++i5/DTgWRWatZwtv4cj9JcG8pmh0J?=
 =?us-ascii?Q?lrVOQAKIA1Focu/SQvTvCw/n6/QuYOHYb7SvhbAeWWKGOHXYJ6rScPG5UBjO?=
 =?us-ascii?Q?elmsvckBONQ5IGruOIpQtXjZf2EuBN3fMTx0/dbh8NEn6RYzoP22+HtZudkP?=
 =?us-ascii?Q?2HkNq7TFES9Xqf+S659icfx5gg5Ai6qAv5QeT5MJpn4dk4XCOtrvpULoDVWP?=
 =?us-ascii?Q?gWOOU17mOXRGgl6BhdQqIRyu1BlcngdbtYmvfkwBw6l1ICN/+Mnt4wKziuZV?=
 =?us-ascii?Q?TRYrADddRUkq2DwCqjSr9JwjtIAFEtHjHWRZswR/efx/6D7Rv6Fhp7QUgBy4?=
 =?us-ascii?Q?ENFWCuqZW30SiRl0bWAMqf+wEMmLAdXP0DQkE0xiIe32exWq95l5bWpXfU55?=
 =?us-ascii?Q?TZDBzEbrptfj9oy3xX0yC7bdNufPZY2NZxqyzl9tFeHrqwOIonJRqHxswgnl?=
 =?us-ascii?Q?zE2qe7e0PKBxIXM7X+RZA9pT3jWXtzVL7fdp5aIgRfaq6Z/tx9gY83nZUHTb?=
 =?us-ascii?Q?zZo93MQO2nxc6JbG4DuGyvU87ho4QuvlfwQ2ay1+spIU8sb18FTW6FTrW90t?=
 =?us-ascii?Q?uB0QE0jB8oErXwjGojlxkR7pJEQlSmrsEKOIr67v2qNfUqicbQ7XZESxBP3p?=
 =?us-ascii?Q?gslvvJQO4qGplYO3ZGl5rwC87JVR4bQUbXgWIAH2DLYxd7RKZGnciYUbURWB?=
 =?us-ascii?Q?Jhukuh0ovmH2lvSAjCNoylC9v/PtEKkCU5oQsxJquZjA55pGugYhrAWS7DFl?=
 =?us-ascii?Q?BWEK2n4thdvJy3cYSNm1uBZucYLiZ6aH1wmF4h1u2rVD/V479jZQ2SAd6nrc?=
 =?us-ascii?Q?uuM0LjoQ5VEni1Kdjs0sFKQShg5oEqII7fUtY8sQitlnL8Q6Ct+v9xvZkVkt?=
 =?us-ascii?Q?Cskd5qK6tzvU8u8i8iz3QRwYrz4u5evI+ubpGJOtGUPwfcNiiSU3h6bPHPL0?=
 =?us-ascii?Q?8df5eKWyKbe9I+Uq+1ySwvlEWwRE47NucQBgBj02+jsPTirX+aTD0DvSYD/9?=
 =?us-ascii?Q?OkwZvywfYlwPQxPeY0CE2o92fpgLiUcftjVdHNZEn3m6KjZA8jjqVcjBJ47P?=
 =?us-ascii?Q?/bTb2myyS/XvxY368bHHwW9P2rBeSTVFNDEljyUFYup0MnoVgbQ39EbSypsj?=
 =?us-ascii?Q?ehz+S21BrtYnx42Fb6i+G394Ww8g5L9U5nSzLU9GcIKA3EpUPYQy5UPDqJ6W?=
 =?us-ascii?Q?4yqd6NKeSd9ilU3EWaDQlQoDMoBZCIV4/T8xfvTv2pRJUJRguFU2m+G+mcZy?=
 =?us-ascii?Q?moChes4qzF3AxOzqDNiIdvOWpCxYRPbbNcJGSYR5uXsktspdOk3AXJWEQU7Y?=
 =?us-ascii?Q?FixkoYMohjsEfjXPDFfwCgSD2f9tsfeq72P30cEtqPTOPwp1jE4Y2cNI4e0w?=
 =?us-ascii?Q?4L1abKJOAaKq9hpybkELUa1z5AzDSR0qMfmpoKI7Khl7g5JuuYsbJLAxkm3k?=
 =?us-ascii?Q?Pj+Ky/WpVmEpFoWog+ratwef68u36UxGTa1VDfvYgp2lgX/JcM5cupLAG2VT?=
 =?us-ascii?Q?9EtMPeT4pUVVIEUVB6GiJvyhLbHikAiTVbqIV37Z/138a03f6CK+BtLxfjgl?=
 =?us-ascii?Q?Mb6mu3/whvNPnxyzdbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBxtVMbKsEfBCZiDZAzxH0whrHEIh0h2MenAwOG8/H42sHqObS4KErLm2Dsf?=
 =?us-ascii?Q?ZtXNQ1URx3nLVnGIFaNfjfmZAGYRe+lfSBKaEEcATmjrsEJLPcH9OZ+nAxeo?=
 =?us-ascii?Q?wjBTCVwfsRFa2HqF7M387JaYm8diI9FQoVqU7OwTcwQSY+kFbZWZxOHwbyHP?=
 =?us-ascii?Q?7CmCj4dnLtcDwt9efT6Qojj25DCfzy21yJScn3PKQvAcbNVjlgyrt1bwJtKX?=
 =?us-ascii?Q?x7y1T5pq024/n73XRrmWw9G+CTGL3y4vk3nuNroQ51883lnaXdlKNTBsSikA?=
 =?us-ascii?Q?ck2+e3gcApHHBs4aaZ2wrjUbw0sorbexBgMI5A9kNMBAk4okD82iwyC7Vnxl?=
 =?us-ascii?Q?RwoZAcrDe3mOjQB3DwBRfGeleNQ7lFzq4oo5QJMhclAMIHvlI5wTcsavCL9r?=
 =?us-ascii?Q?9Uc0lky/3TxPikiI2FBti9gJ43or9Jh4nSJ58cBvrJutQyYgjweP2CbM4wI9?=
 =?us-ascii?Q?YMPYRrnBlqDGrhaEIcJUze89BiEAqB+4oDJWLos/AhOWUr2L45GzfAXQgNxB?=
 =?us-ascii?Q?7AAs6OmaFjT32+QToIxh8LSvbU6n+ihX/yId7XZBOYqiwtw8PKW2arrWubFM?=
 =?us-ascii?Q?Iy5QH8G61c9H6JfpxopaAfBqtp/TIBjwvHafa9M0hrsh0QdMYux0HNXoqCZy?=
 =?us-ascii?Q?We7Omb4e6F9Ciao3xW26VyIXwx7DjXI6lnBBDbnPN+hMG9xyHFzP4F2izIf+?=
 =?us-ascii?Q?NrXtwDRZcZSx0j4tUEc76BApHR51r6KKa9mcXr75vKkuMyZvgUZxq+jjg2hK?=
 =?us-ascii?Q?HjQ5V4c6zl7lIyMKbfp1OUUeAVpUH/35d/Dd6jvZuLKjonDc5K82rDxT+I/C?=
 =?us-ascii?Q?VgCLmYJjG6hwkFE9Tv4fx1zXyrsCZzg370N5/YR7LeUMgrVL7B/2pKLrCznX?=
 =?us-ascii?Q?wpNkDvpCpVzRNEqQKBDsri6iuavtAkw480IERyk0nh60+VITlDg6aW7uFsTN?=
 =?us-ascii?Q?yMF8b0MWs2gTyW8io2x9t3NM8w1TiC/RlBCYJjiPlmbHOtL5dZP9COo6fnw3?=
 =?us-ascii?Q?C6P8hv+S/7SX8ZGpXHRDZrJ8ocfw/ehZ7nufU5j3vfdijdkCOMDAMnlcMrgq?=
 =?us-ascii?Q?+VgFK7YF65QlWzI2BzEZ0ZryGnYILocryNWzlwJyWgeMnk+pwy3AifXPgXte?=
 =?us-ascii?Q?FQnhWELql4z6TAqTVDofU5LLrxuErZI/IONe8YAzvsvKTbps+08vDOANLkvw?=
 =?us-ascii?Q?I3IyNdEGluw8jzAUNHU3H7rmTofcHgtnd8ppi7eJjyTZZ02Ee0DVlbUExw3/?=
 =?us-ascii?Q?TUmInr/eEZ1DfJ9bHTh2Zn9YisFxWHiBCdwq8eRVCA9n5zs0OSbg1RIbIeLT?=
 =?us-ascii?Q?WtHi06rBluIkakjikNFcAO2rZ+SUj8U3I6TAiuFH7KiqSf6nfjulXXWuf7ET?=
 =?us-ascii?Q?Yb3OcWA0+uTb3G9J/LC20RA2CXxi0TEQoazGAFg65g3hd16iGujZK85c8QLR?=
 =?us-ascii?Q?1hUeO78AZ9EI64mcEIiDWQE19xXFT9jvtCe5pQdPzCapcUid84qbwl81UGEk?=
 =?us-ascii?Q?vCMfgsYM6azhyzB8aj12ZfqrNH/NN5tsi37OOj3GgmpdktyiL1GB38SSNMhW?=
 =?us-ascii?Q?lzT98JMag7wHEqNE9TmljFM7/fvjGeRRmO2zXeEx4jEcZaODdU3oarPjSFXR?=
 =?us-ascii?Q?axEIkTP6aNVMgXLr5bfUV4lnSQfonhy1d39Ev+dgUJ7+lynuIZhhRnjkMa5w?=
 =?us-ascii?Q?rLbsbykrafQ3GWASSpwbc0tfTtixi/br8POtSPMcTRG0iMjFoqpIR9QfGwsM?=
 =?us-ascii?Q?J5ikCwGZi4ZXVqg7QQ098O9qlPV0jE8UWsMZ+TuEwQvL+WJKFRDG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506ac8a-f3cb-4214-fec2-08de684cf764
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 02:34:51.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1acWeDRvyR99VVSLV3CYOLuKCdRmpYDyIyoWBsB/D9GMtWwuQaAhDhOisf0VKv7DDfeW5ml0dyze2+XZx98KoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4906

On Fri, Feb 06, 2026 at 09:35:34AM +0100, Niklas Cassel wrote:
> On Thu, Feb 05, 2026 at 03:30:37AM -0800, Alok Tiwari wrote:
> > Correct the error message that incorrectly prints "num_nws" instead of
> > "num_mws".
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 

Just for reference, there is an earlier submission that fixes the same
issue and has already received a Reviewed-by from Frank:
https://lore.kernel.org/ntb/20260105075606.1253697-1-den@valinux.co.jp/
I'm happy with either patch being picked up.

Koichiro
