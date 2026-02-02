Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABC125A9;
	Mon,  2 Feb 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034851; cv=fail; b=HIAPxOkScouFxXP/P1ZtsTSTs10Of9fDWIeTlLmQwDZ1uFgxBCfFGfPv9Mm5wwxbvwEtGE32B/h3lx1UPrR6B/eZ7zv2EE2KW/+Szec31pT5whQ7aLcApZJnidoTkGg6SmDg2/YWGulV6bqXZs+4IxEAef2D5lw22bXOcQE652c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034851; c=relaxed/simple;
	bh=THtIm94K/pghKuWGsoHfKamJdVHOETubJeAxxlamWeI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CthT+7yIrWAV54UOLhZPILSFuQxUE0KNzZWl1/D2Fz+cj0p/l8EehLwMSXP3gm3LlXKhTsASGnBQH/m+IZaaQzuiOxjsW2vLdX/ijGq4olCQ9VjvjYHtARSvHqElzGDD8SniwaLxykGMfXYm0fCXg99m20lLCvH8iJUGsl9WPYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=eAesfVyL; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="eAesfVyL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taXKssqK66boRUdvMl9h7JNEc6oVcdUiOPMnJt2++3cj/gu0F1ePYaPpdsOq478OooUA2zSolmUfTuHzRd867eboa0pMfOiZ/HhVf1t/KzLM7sZCQ+QHLgm2Rgv3gaFwXZx+eNxVxyHiFXSOHWoLTjCoA1OJgKlnL1k/D6JauDMdpjVG4wrALgMIzxHAHM7RV9iP4cbcNtwqfhtTBeWsdF++cdWw5WvjSjYwqAB4Y3AZr6wTsAXdErglwsqz8H3rfBeq5K+XNlXsqv9pKEmj9u68jplJPc8adJp5VvMoiI0PZUXQyKiRMb+fBcNXxqtju9bsVFK4LazVA1fgmIQtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da8ZFA7sosjmR07CEya6w4jwR3krvheaQcvrZtNJSyI=;
 b=Z4rkz2bHlkBbC4Wg8xHuu7v/Vpdf8lBK7e7Vi4fCa+HllNJLNYqgJUagzU4j7AMhYosMWnzI+PKJEKgxmC9s/NEBUBi6JcTgd63FceGIdjFfUqKmfrZUnhzVJaldqVI0hnoy5gQXHi7gnM00aO6bbhTGaZWsUbkQ9Ot95yA3S8Z0j0BgSVDlB9t7KPIFRGQLTUwewDmhb/ZYV2AdxfXSiTc6H6WZuV9i8S+3nO6v7+eDcdDL+qbRZ4cPSRYZY46Wx35VgLrSJCYMutOrTHmeNfK+JU5y+CA0l27lB0u2/LDHdy9ZgjfEJQ+i6179tR486jLQHOJI9b4wJOSDHycTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da8ZFA7sosjmR07CEya6w4jwR3krvheaQcvrZtNJSyI=;
 b=eAesfVyLSQALsZCMcs6sZjfVA3LKyV9jhjCm49E81SP9gkmOsgXf2osXwOV9ABcV8JxFPKeqOsvQkFLfl03je4azY2q0K1UHKjtOpE9ri6fsq+cftRQJTUs346ehTAUPHj/AW47dWFkjLm2MXPHgOnfbYx/hilmzvPYoxCAfIv1nN/GnJwgHkdS3XY1DY7BCw74nTeTZCYZ2U0EFc4DOwt7sHrAKia43tpNe6FfjgECxTq9z08JTtj+ut2j8TY1KGrABgo1EXmlmXSEwPjDhIgRclvwBq9Dv0LPulaZB0wokwK2RhmMpkNtVlp1Pt+Egzzyk0+rPCUkQpKqE2uCwqQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPF3728B70F7.apcprd01.prod.exchangelabs.com
 (2603:1096:408::318) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 12:20:44 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:20:44 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v3 0/2] PCI: Add support for ACS Enhanced Capability
Date: Mon,  2 Feb 2026 19:33:33 +0800
Message-ID:
 <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260202113335.3096675-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPF3728B70F7:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d4b2b7-4ab5-46e2-7c04-08de62557caf
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j29AnTtbLKjpqQ4tPEUmeMtbugkC+Tk1Z9G+A9fDl6/tI54pAigTK64AE2GLm0TOWzT0k/BW14nrTGslhfkNscMdyl9z7GWkIbPG9/wxO4Yx4r814L2Lq5zigImvlSZAv64oH1+2sBb7NB0cnJnBw4evQAXYbUKqwc1pe3B4UV3Vwk0pQZKXG/eINAbDnnzeB+DFZyXQmiGyGpdlNYCFi8tVhENKvVnH/f/7kaGTlXzv985XurWUPwJ+xcClzD6ldhTBMm5nYRHqcUEfkWuM8g7QgAttWeMQOBI16ZpzF9jP4GPgxD/Hg6D99rwuHLTr5e0h5ktJMtqk+q/pnH9u/ibnO0wWWj1p1TSMJDP8WOVpp0H7C6l/ehXJ1SP3Q7k/ALPSE6+qug5tceXQJEqt9FqOMYzNoj/1Mmj/lEIB48nlkTAmZE4KcX0HU1zpddijUkgfmWkugzjOblc+z592wdBivpkPYOucKSwMLjhAQewYw501AE/U3oBNYnVWZMB+z8QYWbAYM91Sc7A6WUKuya/zznAc0eZOvjZaI3XO3tMgxDsM5aU1cOXlCVxDTi3PvmmAgMRLvASJm3PSLemXRZ2LRZ+QVe49QRsWIIHOxOsQnRMwNjyLBPlDpBMldSncKoDB4TPPMI6UFCaVl/jl8XMq8p4NwYyfar8ygAjxBewmF5TF8SUYHA09Wngjt1tRI8/SmR1o1pPjlAEGYzFoT7WRwz42/Rh3pl9vMBFAyEXYbbFtO3mLyjFq6NiJZrUsMupktQ991QSZd7aKd8esr9uyx08Bz0v9MZl9giZ94PrR8/DHCyGlHpmO
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|5062599005|5072599009|461199028|19110799012|41001999006|37102599003|12121999013|8060799015|23021999003|15080799012|10035399007|440099028|3412199025|4302099013|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTc2Wk85dnl0dDZ1Q1U3bUJXWWFZQ3RFZ1MxSFpQakd5eWZ0SmJEZWZyaG82?=
 =?utf-8?B?a3hlOUV5UjhEU2dUdVpPc000a2dzTi8vNFdVRXJ0ajR2ME9aeU9RY3ZiU1lT?=
 =?utf-8?B?OHI5NFAwSnBFWERabEEvQlBJY3Z3NElrcXJseHJaZy9kWXVLK0lQTEI3aEhJ?=
 =?utf-8?B?dWVoRU92M1daVmlESTYySEc0SXFWRng3Y0puVTR1STA5Vm4zcE5ZM3QxbWh4?=
 =?utf-8?B?OFJKQ2x2UkFqTkN3Vmx4dzBzNkIwOTM5UlhSYXJ4T3V6NWNIUnRBNmNvTXVN?=
 =?utf-8?B?TW5jWFhjRDdBMm1JMXVmWGhuUzRYNllhcER0ZCtWS0JJNnQ0cklvelVMazVm?=
 =?utf-8?B?VFo4VG1wQzd5MHQxWUtrbjZoV1JsbWRuUlVFb3ZqeUVkdUxISUY4OWhWbnQz?=
 =?utf-8?B?bVVCV1VMZSt2eWIyWVlpblpDWTFIYVRlOEdOdHNpbDBuamI3UU95akRwZFd6?=
 =?utf-8?B?aVA3VnVxL2xpSjZXMWNjajIvaEVvbDRsU3BEd1lLSVVyT0hpSllnOS9hY0xJ?=
 =?utf-8?B?NnJNYjI1VUJHUC8xK2ExQWtFdEdrWDhMZHd2YVg5dmJSS3JwekJ0V0NUTkZl?=
 =?utf-8?B?Y3FRN2FoNFpzZEM4M2syOFltZlV2NmhNc3hPWFRPb3g1T21abksvL0dYUGIy?=
 =?utf-8?B?Q2lVMGhmd2QxS0Z0bnhocE9EdWJMNDFOemU3R3dZSmV4czA3UUFFMHliamdv?=
 =?utf-8?B?Z1NsMEEwcGlVUkVqVmpwUnJ1cGRhUnFFNzFkWkQ3VGpSa0ViMnE2MmUwRzdo?=
 =?utf-8?B?TWN2Qy9naWlzRC83M0ZJTHV6MHN4SXNhS2hiY2c5UHJHQzljZnAwWnpvMXIw?=
 =?utf-8?B?KzFoV0pZZ2V1dzZBQ2dQWEVPMVhIUGpRM1h6SmZBQjJiaU83MWpaMThMM0lI?=
 =?utf-8?B?QzdjeE5ZaHRJZC9hZHFqZkFJZXVUL09UUmljR0FLWTF5bjRLajJ5NnR3bXhs?=
 =?utf-8?B?RWR2QWFZektVOWg1dEVyNTVmMnhvRkhlemF6ZVVhc0QyNFEvMFlFaVNBOXVG?=
 =?utf-8?B?K002VlZ2dWJnVFNrdloyTHBrcU9pTldZRXU5Q1lPY0R1Qk0xQlNPK2hGcG03?=
 =?utf-8?B?eHVGS285Qm1pTHRRbThUdnYvMDlSUEorbjdCQXVncHhFZDZ2N05mZnpoYTVo?=
 =?utf-8?B?QUkwNUhjWE8zazhTcmFaYi9Kd2o0end0T2JBY1hhaXBkNkt3VnlPeTRoZVZ0?=
 =?utf-8?B?cGFINGUvVmZwWVl1czR2bnV2Z0tzYUVUTitZYVBDcjNEbUlmdmpjY2ZwSXg4?=
 =?utf-8?B?aU96d2ZhSnRkN2JERTRNSHc5amh0S1NhK2hDYjJJcFQrRWNJMmgyeXRVbklO?=
 =?utf-8?B?MVZteTBqcmRBOWtDL0FlS2VJamZZMTluSytHRzFPS3Btd0U0Uy9vM0VoVi8x?=
 =?utf-8?B?MWo5THJFd2RiQ0RvVWtaMnpVM3hqVE45bkZEbGh2NE12TzBrbVhLNENjQWdT?=
 =?utf-8?B?N3JHZExWQUlGVTk4TXh6L3ZpRXd6VTEzYVluKzRmNWpZRGNBaFd5ZE5FNnEv?=
 =?utf-8?B?VFlQUXdla3Mrc1IydmFNM0xmWnZNcWd1bkUwM25BSVdYYWh0aERiWEt1bGlY?=
 =?utf-8?B?enJpOWpCSjYrV3kyc2s3S2pQcElpcysrMEViWEpZR2pEb2kwaFhrdE9nQTN0?=
 =?utf-8?B?c1VSWFJoY1NNR1k2M2JiOHJ1dnU2OUwrS0RrQzlqWU02ZDVOUWNvWkFITVRp?=
 =?utf-8?B?Z0xrRlAwSWREeXlxWFVOSjNGR25ia2pVK2dpbWRLdmVSRTR6U3cvL3lkUkZt?=
 =?utf-8?B?NzMreU5SWEJyNjFHUCtlWkxBVjBYa0RIVFdzZHBnbDZVVkpkTnhQN3RHM3FC?=
 =?utf-8?B?SHNUSkdqbzlWdDd0N2lWRWFDOUk2T1I5L0ZaUm8vM2VlcThjYUQvN05sWkJo?=
 =?utf-8?B?MVB3cEJqSHNCOEtDbmhpVDFMN2RHaXdYUmJsakJYSkhXakZNNHc0NGtwRWRn?=
 =?utf-8?B?em80LzBpdmZWRGlGRDlGZGN5NVRadjIrUTZuZkttRHdCakF3RVZqQXBmcW9Q?=
 =?utf-8?B?UDBmWFNqb3dUY3J1OVhRSWgrd1FBNGdWRzdUQWduRWt6T0F5cHVPbzEwM0xN?=
 =?utf-8?Q?FoyElI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHlhNVd4SWpCVVlrbjZoL2FLZTFOVEVpdkUvdXBTdFNRbW0yd3NsWWdkS3dM?=
 =?utf-8?B?YitOSzlzWXNodFoyT2FHNjlUZG9rc0hidmNYdVpoS0xiTHF1WWszWjNCR21y?=
 =?utf-8?B?NHkwMHB0VXArTkRYY2JtVnRNVjNsZ1pLU1lBZmR4d2ViRW4zdDVEc25QM2Qr?=
 =?utf-8?B?K3NtRnZXaXNSdGhja21TWGNONUh2SDNYSGN5S01YUnZjNGRtQ1pXWldHeWdi?=
 =?utf-8?B?TkNrOFFBWTZvd3B1ZzhBMXo4RWxyZk1NNnJsdnRXUFZpMnZycGxKRjVpcXdH?=
 =?utf-8?B?ZUMxZ3A3bzBJZmtGOFFtb2JDMmFvK3JUaGZpMGZCbGtuUTNWd05iWHRsc0w0?=
 =?utf-8?B?UkF4ZlUrQ3ExWVJ6SC9ZRm5DaWFtWXAwaDl5VDd4OVhOeDNmSWtWaUNFWlFW?=
 =?utf-8?B?ckczUVg1ZGd4bEg0eC9RNjgxSGhhUTM2ZTRhSVdJUGpDNmdoYXRkcmFhSnE5?=
 =?utf-8?B?Nk9wQVRQN0lhNWlUL2FIMTE2SUt4ZTZBeDY5Tk1LK1dYbUtPTDdnK2YxSDlv?=
 =?utf-8?B?bTJlaDF1WWFRN093bG5va0NUVGFBZU9BZEllKzdHeHkzR1d2OHFaOVFCb2hs?=
 =?utf-8?B?Y1ZTMmUvQVlCdkgvK3FWRFFJcWkwUE1WQjhnbGo1Sk1CVlNXeWNTM01RUURN?=
 =?utf-8?B?Mm1paHliVEFaU1NyTkZkVzZZSVVFSDc3Qk5QcGl3TmpjeFV4RFVLR0dObUNM?=
 =?utf-8?B?Rk8rZTNsSWxDN1N1QkNUb0RweDQ1a1BxWU5LaXRXVWtyWnd3eFY1WVlVeE9z?=
 =?utf-8?B?WkJaUTNkajJnVTl3TGlOREU2Z0xkVmYrTDh1SzUvdE9TMFN0Z0lUL1NQdHEx?=
 =?utf-8?B?TlRFbG0rNXV5dXIzckxLamdQd253bHdjKzJiaHRZQmI5Y1g3U1VhUWRTUGRM?=
 =?utf-8?B?bm9xUERSS1NIZUhmZk9PUlJVeTl2NWF1c0NNUHJrM245Q2ZLeDVucGlYZWtM?=
 =?utf-8?B?SVJoYkczSmR0T2VYd0NlbTd3OGRPYm1TZE1lVXRXVlFFeDA2WXhjdUJNSjJp?=
 =?utf-8?B?Wm9YUHZreDF2K3lOb2pIM0wvc0xTdSt2cTNlQzZBbmh0bUl3L0syTjdUdVBw?=
 =?utf-8?B?NTZGaFRWZ09SUnVxNS9kd3owaDZBSysyeVhKNzRNb0FzMzBYbU55aHphT01G?=
 =?utf-8?B?a3pEL05mL1NFNTRIK3hXQVBHSFFUek9IUUF1RWdNb09yUm0ydC9aYlhVOHNM?=
 =?utf-8?B?NTFHRTdiUGZuY0hYaHhmVmRGMW9xbDBGKzIzdFh2M1U5ZFYvVHA2b21PUmdT?=
 =?utf-8?B?U3hCemYzZUtXc1cyc3daTng5RkFiSVNLd0ZyY0psWDhFeWFBcG9wRjZ4Wk9y?=
 =?utf-8?B?Q0dQaURwZm1xcXZoZmpFS21xdjRMcWovOVNDZjdiaCtxQ1JiRDJGSGkveWdp?=
 =?utf-8?B?L1FSRVNJWng5OHhEOFpyZkx4Wk1qNjNUMEdvMXJwM0daN3lqSzNyb1prM3Fh?=
 =?utf-8?B?VUVlOWtnTktkREtmYThTTG4rc1NXbGRaczBORzQwUVc4VHBwaDQvY29IbXpC?=
 =?utf-8?B?MUJjaThCOTFkQmhhZnB2MU10cU5DZU1hdW9RL0dpVFNnb2NQMVpwemhXUS9y?=
 =?utf-8?B?M0VYUzJoN3hnaUxBaGRDd2J2ZjZwZXgwNDlOU1pmMkYrV1J5RTRuOGw5R0VI?=
 =?utf-8?B?S0tLdkVLRzhUOThkYyt2U0VpNHM3cHplS0R1dzh2RmVZQXV5R3NIa3RCRmpF?=
 =?utf-8?B?MkpXT3FDOExVUGJWb0VDWjR6S0pWSkRSUHBSUjRDMDJhTHZpWVM2akgzc0Uz?=
 =?utf-8?B?RXA0WDI5alUwWCtHVWFob1ZSUUJ1cWgxQ1Y0K05heTBLUVQycnMrRG80R1gz?=
 =?utf-8?B?TUt5NFhSd3MyS3Uxb0dpVzdSMk9KcFMwUGZyd1RIRXVEcWJZRWpzSVpuRVpi?=
 =?utf-8?Q?acGCB2sk92lQ+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d4b2b7-4ab5-46e2-7c04-08de62557caf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:20:44.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF3728B70F7

This patchset adds support for the Access Control Services (ACS) Enhanced
Capability, introduced with PCIe Gen 5. The ACS Enhanced Capability
provides additional access control features that improve device isolation
— particularly important in virtualization scenarios where devices are
passed through to different virtual machines (VMs). Strong isolation is
critical to ensure security between devices assigned to different VMs and
the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() simply skips the check.

v2->v3 changes:
- Drop the warning when a device has no support for the enhanced
  capability.
  v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered).
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe for reviewing the patchset.

Wei Wang (2):
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         | 23 ++++--
 drivers/pci/pci.c                             | 78 ++++++++++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++
 3 files changed, 100 insertions(+), 8 deletions(-)


base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
-- 
2.51.0

