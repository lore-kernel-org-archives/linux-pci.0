Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D7176238;
	Thu, 28 May 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982179; cv=fail; b=heF42MGWvfmFXQWbVU+Txd96wtWiTcjz8JZiT+jvv7GTkj0LoHzEO7A6F3oMe60Y3w3YKB6ou/t0kpb+a75t2633Gfa8XhtGFY0THiModhTbEIY2YYzxmdL+WF4OZCrrc+bMeKvFhkadF0ByTlwszW+KPPAznr8LII0VXx7UQjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982179; c=relaxed/simple;
	bh=qW5GMJe8qVDzAiO/DJG5L+rD3xpoKfYp/G3p1txJ4dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTvDC7DeDgE2bGeN83zkC27DjnL5T2U/3WBkeY/Vxi627b2V5xoblHdcEJJjkYWMFsSjKY7vGvT7BJMl1oxtOWQ1lwRpfDeJTgVXfuc12F7C20NhwU6ZLnzouM/rJkoGpdZHApWX0PQszmc+H3dzrf9YPNR5SsxT+OCGc6A2goU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X95gSd/E; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X95gSd/E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgnYrgaJSAMbR/tKMh6InRzwA2R3OzQ/2EJa0pStXIYXsx9kP15nB+koDgJfTafJDc+/Tm86MYX0enf3YogZrT/jH62r5uODeLF2eyyzi0XW51iXNpXSvX7eekPJvY6QW2hzIxGdlWwyFMUpuHqDDpPRE7cKEF/aL19AtaYOJUdxzWIZsUfXZ374gtDqf3drjn8N3jvXCiFwY40LT7XkEhzkPOVkvrY0dgjEU3zIizXDudihPr4yhREowP2SYkjrotHG+MSajfCr4nH+dsnZc7TVo2hPBlLeSItwS3kXDV9AowcEe6tzj54wtM1svJGh2rki8ATxYgJBoaxA/Gjv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dNFlFRiJS08tWuA2gJmanMlJh8nkQPLZ0xAGbsMpjY=;
 b=JfM0O2Jzu0t40lLqIaenIG2qgrPdAjD8jITZcM4/joDEp/7m8+Rs1sWK+g1CLIv0u78Z1ndaT0vKCOx0ZdwuPDZCF6Ps+olcW5GEYqw438fHJUWoZ9HaG1T6niMHpHK24z5qpHY9cutROb0u1y1C861Jy5EeYmKYP6WY7zG/ntg+DEg9E8Bi0Rf3gJMxjCZDNSTSSPwzoqpvuKrjb0M6obOHiwr4mE4Eq2hYqaoNsofkupY58AaG6JGOHTH2B/25ccjnGodTHFbWELE5hNPr0MURgbi/MvNAqj7dh9Y2yLFwrXC34JcotU35qWj27JWsBrhypY+j4LVYAsWxT5TxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dNFlFRiJS08tWuA2gJmanMlJh8nkQPLZ0xAGbsMpjY=;
 b=X95gSd/EiriVHlrggVujX8WUKxB2hR9Ed90jlt2+Z6q4lZU3oUsx5W/CnVAeUo1JmOknr1fyWHdxnd96vbQfWJd7pOlwo7QyPP/A0KFNNUxQmlXE1aPXeQeLpSAST8cCmz5svBCS64EHV8GBv48QXejye/TRuT1IMV3A5V1NfJn2p1gAcMYQM3TxnmtwDER/Ixm8uEVVcmY0Quupak0TaqLZNiecuGopT4DzHjrgxMnSG/hsyDLHtsRIGugco1A8iJJzNZpqef1nlfcgY4fX3JoiU0pfrPmmNg/UCzi7Tet30/A+0W898t9rlwewcCnsnQVB8klHR00AU86vnt4o1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 15:29:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:29:32 +0000
Date: Thu, 28 May 2026 12:29:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260528152930.GA3195266@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahheOF8L0aGMttcI@google.com>
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ac0a08-5e8f-47c6-291d-08debccdea57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EjYNhiPSEJESEEbICCrxPiJa1B0GZC8V28nH51ClKJKlrb9mx1oUWqkHX/u12zmsEV+7ZkCY70YAY1lZHNFHmNtu/OxH0Grt+cNm3+OoP7vOY74W329BcRj+FATN8PlvsJpOvDUdcrO85lEFjNTz0nMLlQlc0AFH1WMZvNg22YIBheGy6Y9cX2aw4it4I9osMIwh8H1ev6E/tQvQXvE8O0O/19j0Ctuw0DsTUMMLA3r8TWf1KnC++Gb+n+auB3Nl9D6CZ/1TUfZy8NF+B3mTMS4r4Ko5Q/e+s15Kj02qWp0hnTbOqe99rCo8CojkvabmOCqkilJxxGyewvFpx0tAQhbSGt3TNeNClPcTF/7o8vqtLTYQYGESOAc/hsCR5nboVPVyi+M8WIh7mzxx+/e9KCJOMpUDfamrBR5JOOQ0OCVhfmo9zxd57xqUgPkUGfqvTuPM40CbR+Fs1MnhQrcD6twq1Ob2ZcHkblTxZPT9zs+wIKFpZ1q9DI84htj+TDfXbGTyiG3p/2Uf3nlR9UgFzncjX5MBqigWkpTWrhs+M0yjVgW1LZjnmn0wJFUheJt0sxyAVJzJqj2vrkbzW+H6X8Hc4wnhFcKoOCrchYXw95NfgAtp9I8p7r0+XviCPq+uQeuoSLZnBhHHOmOm4rD4z2+HjDbQ11sD3NwH6GUnLsm1GZ8mK/1r4IQwAqHjTRDV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SqG8gdqkMHewYb8CNGAOxDevcU168QTu97B+uEdBdCnnSWiOJ7Tn1GMX7iz4?=
 =?us-ascii?Q?Uo+NQ7LsBDRB+rE4XsSAqagdlocqaz2D4utwttzzB57OUONvB1qAIddyRwb+?=
 =?us-ascii?Q?AcBpqnjIc6C2FWoMKeYNQqdoSjNY+0XkWSgQCrasOHbwwB/pWneEmEv5+1vG?=
 =?us-ascii?Q?4/lIa6fpRrCu4SW0zjPTM8prJ7vAeux2r4OsLonzGMMrjNXmT5EuasCDflrq?=
 =?us-ascii?Q?UpmM+CzBQFak70uLHqystQrqe0yV1uSystDMueqg3Zn3ZZHHQT1+j8SVhFNs?=
 =?us-ascii?Q?o3UX98NKRAjKskPBcXre9fF/nMH0ReLOFlRoJCBoAOlCGAsEbPBuvASob8Tx?=
 =?us-ascii?Q?H9wWL0ZNcJMS8vLtS9HuHn2XYNVAoUkgsIei3v7Qfz8cAFfCINd7KqANyWBj?=
 =?us-ascii?Q?1KKM/0fu+cloTXzh0jv7QixZMc1qboMVgQKiXMVHPJeMgWbvHAanZZd3Xuua?=
 =?us-ascii?Q?JCqI5Suj/13ZHmaHT8ze+rTKElDInVmkUbpdzZWgAGlI6Hhe7KQibTctSaxA?=
 =?us-ascii?Q?tl4p5NX5UX9qLRQrp1D8OmdHYX0PCojLeO+xp20TTTGT7p4n0DWdvpmabykw?=
 =?us-ascii?Q?0b8oSScyQNcGnlSOuVf9UAp+TfdBnE00Dck0TdG1PrxKoVV+PS4hoWTCqvsJ?=
 =?us-ascii?Q?aZvMZNUECbuYoM9b0vbz5nqX56rLAKphTW5V3A7IjSe6PcqS6nTyn8k30MBt?=
 =?us-ascii?Q?Y2l+WiGaHDmuQMhzWxWfVZDUa/g2fw1O3P5cbxmzewtZVLlrqvLWESyU4SaD?=
 =?us-ascii?Q?6MjbhnERauvSxOX6GnjgL4ujwvauu7TdaH7NVfWMFyCn7wtPg4yEkLSUCXAZ?=
 =?us-ascii?Q?3YLer+PlMnIuf8L/zCSx9vr79oR708FKt/P2z/+6ZLHeUQkKev7T33KXgAe+?=
 =?us-ascii?Q?WJ1eR8sxjQDBNENWgUAyibnznOvfZs4kjZrJ/WAg1WLEAp0tLIdXnPLL1C9O?=
 =?us-ascii?Q?EGMMgg1uV1q4laug0t1LyeYZc9O/kD6ePIA/PDuDaZlg/RR4i6fKYUZb/o9k?=
 =?us-ascii?Q?HuqyXxDObMydpfknDjlSfHmDGI17W4GJO1og4JqEYRgtljlZkvrLCJsDUa7P?=
 =?us-ascii?Q?A8mEd8P3D2hz0mc//hIauGT1Tf4K6yAxBbx0hvNIaEJS7MC4bpxLuKppDZnx?=
 =?us-ascii?Q?65M0oHs1TCC4ngXMOJlsaISQXJYZGTWidGPpldHg235CG3a181gXJUSLNLGd?=
 =?us-ascii?Q?vDMmB/BzpaUh/OIJUDJx2khHdYS32rmWQfJP6hsUcnB3NU4Dr5fLldtBViuM?=
 =?us-ascii?Q?zeeGrzNdnEBciDJ308fnlHMmaSZLfg4UgPsGhgRnKr0n4ORVI5q5xTw7GpYv?=
 =?us-ascii?Q?SXPkVz4M94GrLQ/9kdVSyTZiSChqrYqthc5MszhgdGAn0jOu6oCHU3oVS0cQ?=
 =?us-ascii?Q?AC2xoFzcNzKfWyBwC2V+tU9zck6GHuE+KFEXmBKSrtcsjhkxslYp9uu8mMvl?=
 =?us-ascii?Q?aYuHRjiJG1TRL15jYgbHwHwfB2HqW/iXOSx9oYHF3jiZ8OJwlPji6hVNIDU4?=
 =?us-ascii?Q?mV6yrM5XX+9KNkpeXxFhuav2s08T9SjZVZuBqHx+mOXzDV+0Ub8d+M8GBxCT?=
 =?us-ascii?Q?zPcaw4gawOs5nM9xVnPUaYLV8iBCpvV/hbcED+PccSqJfQyI4f8XlXAGXc6U?=
 =?us-ascii?Q?oMv1qEJR3uvP9U92vICjsDe9NllOSTfz+2vM2hgetw70rAoyCgZpDF09bP9F?=
 =?us-ascii?Q?HVfM/KxLz3hyM14bzVjfiUuvGDohLcYcjz2urUHbxHRpBMrw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ac0a08-5e8f-47c6-291d-08debccdea57
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:29:32.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nos9y5pj0Fiw+zH/MVwgZlYb8VfIfiX3N1d3UQiGQpD1hpOMzTsFRqEfZKvG+UR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:

> > +	master->ats_always_on = true;
> > +
> > +	return arm_smmu_alloc_cd_tables(master);
> 
> Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> requires Config=Translate with S1DSS in bypass?

Yeah, basically.

Effectively the ARM rules for enabling ATS and Bypass together require
a valid CD table pointer.

Jason
