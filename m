Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057139FD4;
	Thu,  5 Feb 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307665; cv=fail; b=R2NAVUR2ekjJkCTUxu/igMLnF35wZuiVNjzIGt6BzNZBvWTSb45oKOdyZTk+W/6sL593etWL+910ZQKodiH+NUB8XPbeqkZYuLemgIEdJcgArRff/SuatFvQThuHIq2+hOc4u5ERaG+BhXklD/8i0ySWaVI5Sy4kgi/NmYqJ4WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307665; c=relaxed/simple;
	bh=zUlZRPQZpPB7HwdQgR1wAJT4QHVnRHmgBDQhOJ21JYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GH21ZTatmM5V++0hrjjfScfTLGtpX4dgaGOnD7XfdIdBz2Y4iUPKlmaXK8PBh3E+Rnh/kMvIYuyrSHmKPY3pCxmQ0Beyy4qkQ2/xflUp9SeEmZiihq3nsXCPWY9j5cSXR0K6EjVt4a6bZwHUYpjiNGOCsO7X2Z+B7e/lqrX+vxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdA09E/t; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdA09E/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyrrQuoH5jIHX5tQfoaYLnLnb18M6BVGZ4FZNy9Vg7eH7i7pp5sp9ZKq+pI1VOZAIDjdbA+RcVSj+4x3HVtpt5lwXD4kYwfPe5a5DmhfHXu82052bbjYRCnAaSjzxiHvUYAWQK3+Y9yi3x1kvWL2w5l7BrdZ6ZtIbgwJZoi1YjDck8nD83lsT+8upRnjc1Q7Z005sThXb+oarMACcymL7qNvqUoO7YcwleWvn1p3brYDttMd1SrNPiDmdCCpaaRMYQx3o/1hQLaFJLOgZp774F+ebItbpGtOsM0DN/tmDidxHRkX7VMGZUTPnaxBjl8SAj70GExAIwjUyjxuOgBdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqYT7GfIu29Xl0Ho3pKvnRo5faTcn4HiglYXDvBpaBk=;
 b=jZZbsxlZVIXP+LrEthrnOWCr01NQc71GCmFwzp+LBS/MBWAAeoT4sVMJTB9jSRlg1lWThFWoQB8WJoQLqCZk5F/GTfoNeOOj4FiclmZrQdXrA6KLmx90GviAqrVCpz0pT2F78mb+hYax/w9NrXTRwkqS2gY1x5fTuFgNL8n0dp9S8A7NYK0E0DT2FMkbCfavlsPEaBnCd6//ITO2Sv4C/dP/Yuis2UQgT+c2ABxWH7Ru6kalUPw2gA/S/YwIpG571RFDbq3lsf6SkgrV6QFIdS50mLoXojqnvcvo68+FLcqHbMNp9ejUtXqu++MFHDt1E9sYzy4s+6lqMS/tuTbLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqYT7GfIu29Xl0Ho3pKvnRo5faTcn4HiglYXDvBpaBk=;
 b=IdA09E/tawUrm0oWRJJ4upT6xR32NFz42hqK+FJt7Plm6w1Ey/T0LMG9Sy6oN25bhLvW8Od8oSZdNiOE9ULbTQMAI3qIGnzlALr78VpuxumzavEYkclm9VGh6m91cmvDDMYuzLDlRahTttKQIMsqof3o3dpwaFiDWadHmtVeL00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:07:41 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:07:41 +0000
Message-ID: <bba0a5e2-c4a2-429c-9577-c1b87ef04267@amd.com>
Date: Thu, 5 Feb 2026 10:07:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] PCI: Establish common CXL Port protocol error
 flow
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-6-terry.bowman@amd.com>
 <6982d468e42eb_55fa1002b@dwillia2-mobl4.notmuch>
 <e6de891c-e1e0-40de-978b-15f60acea92d@amd.com>
 <6983b885a31cc_55fa1002d@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6983b885a31cc_55fa1002d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cb4cb0-be30-427a-9024-08de64d0b07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1hXbDF6cGQ1T1h3a1llRnF5RFBsTGVHUlpSSlZCeGFhWGtoYUlrWmYxV0pO?=
 =?utf-8?B?RjRDK3JIWU5wMWQ5clpDeEpoZnA2TzlqaUpNSGJhbmpleGxzQ0FtQXpiaENh?=
 =?utf-8?B?azRKYU1VNm9nMnFIaHhkUzgyRnRHN0RxSVMrcDZheHVTL2FhejliQnhyQytG?=
 =?utf-8?B?eDJJVms1dmVMRDYzVWVTdU5zSVVQSldZckNiM2IzSG9NMmtrbzJUdVF5b1Bs?=
 =?utf-8?B?V2NGSGtlbTBJOGQvMEZMMHExb1ovUlhaZ3UxYUM2VlQ1MFUwQkVtakhhNi9G?=
 =?utf-8?B?M2kwK2NaNWdhU1poQXNQWlM4Ui95M2tFREdTVmJTaTUyOGZ6aDd5dTFKNHhK?=
 =?utf-8?B?S1IzbWdmbHd5ZVg1dVhFTEtGWUQxT0sxbENQZWFKQTRRSGhTdGZYRmN5WE5y?=
 =?utf-8?B?YlB4dTZ1elFrOUxGQ3EwaUNybm85cU5vRTdBaVNqek1meVlVdWlyTFBJMWR3?=
 =?utf-8?B?Q0hacmRpUGhsbmxncDFqUjh4ZXdWNElDY0J2T2t4Y3lCZDZXaGliTS9PMmRC?=
 =?utf-8?B?UE91REZLbTh4QkVGeTIvUlQxajJtbFhWRDZ1eEEyVURFS1d1WDcvQ1hSRmRt?=
 =?utf-8?B?R3o5cWJRRU00Tk9LaFBOTTlxRXZ3UllycGRhVFMrYjF1RkljOTVteHFKbGNZ?=
 =?utf-8?B?ajFXcE5lbjI3cWdWWnF5N1hsU2dqdGw3MHhhMVREVTBGTHVwaDZHOTFIM2dt?=
 =?utf-8?B?Sk1xaExmY2NUYjIzR0QzVDFhV1c2bmxONW0wem82dC9lUyttZjNXc0RDWHVD?=
 =?utf-8?B?UmtDZHdOWTJsZHNjM0RjbVY0MzV2ck1kT05VZzI3QVpNWlF3VzlHOXB2Nzhy?=
 =?utf-8?B?VGIwNXJMdFI5WHNFdUZKTHV1K0Z4OEZjU1hzTlpuQ1pvaHMwSG5GT0VBVVpY?=
 =?utf-8?B?R1I3T2JIREVIUmdmTWpxMlI0RUpsWitQeU9STDRRNGNZN0grVE1rY1NYbjk0?=
 =?utf-8?B?NVhjZ2NSSWdoZUFkckJrSmV6K25LVXdVU2U4MU5FdnRtdDdaTUd2b21ielJu?=
 =?utf-8?B?ZE5aN2ZNdURMZkQycUE3ZVJ6cE5ucUlmdEFRdUN3TUNkYS91Mk9QbE1TTGVN?=
 =?utf-8?B?ZzF1ZzZISy9XWEpjK3dKNm81Z2REbDJTQW1nKzNIZHdFWTNicnZ0ZHV6UThJ?=
 =?utf-8?B?bURjdTVqT0ZMRllOWGRjUXdGVUovNFJqajRuVVdxa3pZa1J4RHoyTWYvczZJ?=
 =?utf-8?B?c0ZqTXQwN3o5cEFsNVBMaWF5Q3gzMnFYV01jbmx3Y3dJbytTUkl2eWJIQ0t3?=
 =?utf-8?B?NVZvWW9CYS9BQXFpUTJUWTdSSGlKZnozVys5emVGYjU4Y0N5SzY3dVlyQ2lK?=
 =?utf-8?B?YU5HUmdVakNJZmxiamp5dkx3NjhpczRQOG45REVjSnVleEI5MDhzWnFtdjY1?=
 =?utf-8?B?Nm9UcmVDZEhjQVV4MmhXRHJhVGduVW9ydDl0RjZHeDkvWVlDNm5ZakxHZDVo?=
 =?utf-8?B?OGFPeThnalM2UGVrM0dUVDN4ZGtqQ2lsK1RRaHY5a0RTYlVTRkdiUjZZMzNC?=
 =?utf-8?B?V1RKYVpUM0JmY1ZkbWowbldvUDJlUDVPRmVVV3ZvVlFDSTEvVVZ0K2lkTHpl?=
 =?utf-8?B?NkNvSmVWZjJnREFyTTJyYnlTZ1VhWDN5L1g1OXh0L0ZvMW11UDlzZnVVY1NB?=
 =?utf-8?B?MmU1RUNHalBUTFlqVkVSNkFCUExIQUNqUmVrLzNzMW1IQW1SN2FGRDMyYnRk?=
 =?utf-8?B?cWtLR3hGRzg4TXpOZjM0bXRGNms3U3ZUWlp6ZlBYL1VkYW5sUHVDK3RTTEk1?=
 =?utf-8?B?U2JaM3BGcDlGKzR1dVdJbTc1NzdZMkZsSDJ5L00zRThuK0RadExLUzQ1dlUr?=
 =?utf-8?B?RHJrSlhWdXJxN0d0dm1SMVR1N2wwanBIVFluQlo3VkZDTmYxU3FaR0FiRUNT?=
 =?utf-8?B?MTVIcDdJdjQ0Z2lHZDhTNVVkazVqdER5QkhIUnJwRTBXQjlvd1YwVG5MU1Er?=
 =?utf-8?B?WjFLT3phZzgwZ2pidXFjcVZXTEl6K1plREVZRlVKYlZqdlU5aEp2dFk3V1Jh?=
 =?utf-8?B?QmxpMlJvL2pMMjdOdHhWeU5SMnFUcWNJSEFicHFSbE9pakVCYkVMYWNHdVpq?=
 =?utf-8?B?eGUwZE9LQXNSQTV1SUt6SnpDKy83MWNoL2tlTXNyYVRvVEUzejFBN3VyNnhI?=
 =?utf-8?B?ZVprOGtCNHNobkN1TW1aSUp1SUNjUnRsc1BCa2ZSTmdaR2NZL21JZkFkSjBU?=
 =?utf-8?B?S2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjdhRXd6TFF1NXBBNnM2aHZPYS9FeWx2akdEWFN2Rm9YTXBMS2Uva0J0MHNt?=
 =?utf-8?B?RlU5L2ZHL3Y4UlFSTExhZzVNRjB5eGFCQXgyY1pYT09QU29pMVZQQ2dVTDlz?=
 =?utf-8?B?RVJDNDlYc1ZMOE9FZjQrUlVTY3BkWXh5YUI0czQ0Z0hkVUVUVm91YjRJRGtx?=
 =?utf-8?B?NWYyUkYwQUVXOUNUcFMvWHdlQmxCNXBWb1VtQjZSWFhGTWQwU3RjVHVyUE1k?=
 =?utf-8?B?aWUzL3IrbVh6N3ZyQ3psQkJZaE9scE0vSU9DSlJiVWVrWXpEdGtLcGduNnZO?=
 =?utf-8?B?dWNJV1l2MGlzcjJKUEFVaXFFc2lTQUdzSEVnekt6TDZFLzJORmNtcWJkb3pU?=
 =?utf-8?B?OWVGTW9CS1VqZmhmT2p6dmM4MzBBSEFMUTFjbmhsaEQ1OXVWV1hoVXA4M0w5?=
 =?utf-8?B?UUVxaWhYQmVOZHpmTlp4cmZUckZFdEZnaWptRTlaclpINEt6bmlybWkzTWlB?=
 =?utf-8?B?WGRRWHZaZnBhNnU5b2hSZTVOMHdNZGlCc1lLWEdHdm1ydGNkU3ExS0JaeTZI?=
 =?utf-8?B?Y24yVy9QUHFNSm85REpua0hsYTJnaFN5L29qSVVzbWRvck5FaVJ3STRpSzNp?=
 =?utf-8?B?ZHNvRTZidTgvUU5aTUNZUkNLQmExVnJ4bnlXMDd3T1dybGxzUEx3cGMrNGZz?=
 =?utf-8?B?YVdPcFBrbkRodm1iWWVCUldnQWlXMWwvaml6YndkbHlrNjlucmR6MllRT1Bq?=
 =?utf-8?B?RG03M0pzMXdtYkJaajdsdTE4bE9XNWUvRnI4V2JTWUFISEV6b3ltTnFuSm10?=
 =?utf-8?B?UTFNSVBzMU5udzc1NDJZWUlOSmRnQkVFdmJzZCtSOVdTV0xXYUI5ZVZnTTFC?=
 =?utf-8?B?eGZyWWliQVFveUdvSU1UeVhFbmFVMUdsVERGZEJvR2xLblB2eEU0SUp1QWNX?=
 =?utf-8?B?OGpFSGtDMWdTR2lRZm5QSjJCamJzbVFsZXYvSWw0MDQ4K05mQlJ4SEhVNG9J?=
 =?utf-8?B?SkZoNWdEWDlZS1c2SjlCaUR2T1VTK1ZtaWN3NzNJVFNhUjZjSkNvSVoxWmc3?=
 =?utf-8?B?eVdaUFB6VlcxK1p6RG4wRWdRbzZLZHk5SjhmTGpodFJlQmlaYnpXVU5NT3Ux?=
 =?utf-8?B?WGVWcWVLdU9aUkVrOHhaU25WVFVNQzJvM0NoZ0dpdVJzUm9KK3VUd2hKc0or?=
 =?utf-8?B?Q3l1RnYzR2tnRlJXNXg5cGxzM2pScXdIOXhjL0VPVWRJR2xhdUgyaWJNRmtQ?=
 =?utf-8?B?Wi8vdFV3dkVFbGh6QlFKOFdjdnBveEZYaGZjVEhVQWdadzNYZEk2RHhyUUZt?=
 =?utf-8?B?Vjg5VUsxQ1Q2UlNiQXlmSGE1a3ozdXBCVjlwcjQ4ai9NM3Q4ejlKYkZBWXY3?=
 =?utf-8?B?VFU0TTRHTEJXTGNHUTEram1Vd0VaYWk2dUVqREorVGM0TzJOSHcxR3ArZTRq?=
 =?utf-8?B?RTZteEc4REFTbkNsNmQrRHdjeDhPVXZyc1VDRUJKYmJpdTZhVDJOcU1ZUlM4?=
 =?utf-8?B?aGtoYzh1OTV4VTN4a0wyb2NzU3JGMVk0WEhTTU5ncWVzd3BnYzVCZlpBOXVl?=
 =?utf-8?B?RDNTQXlOMEFJT2c4U2xHSENLWUFSa2RtVzdZN1Y3Sk1sWG1LWktoYVlYa0Fs?=
 =?utf-8?B?bndXWnlhT2l2R3dDMVhMTXI5VjlubzEySjd5Um9pU0tUWVpmZ0I0SzVWRnVF?=
 =?utf-8?B?WDd6RDUyMHhaOHdqNTVpU2JpdmFPdDNOOXhiTElaQUNQNVU0TGwwYmcrK3lD?=
 =?utf-8?B?MnZiR3NlUHhjMWN2UDF5ZFA5RG9QRnZmWVEzRFNuSGVFSEdZT0lSY2RUN1Ew?=
 =?utf-8?B?bWw1VmR3ajQxM2ZmY0tDQ2lmVWJJTlprWUlWSDdrdXhkdkZWTW9iL0pzRHVF?=
 =?utf-8?B?a1YxeG95NU1XSUJXWXF3SU10ZmdmWkF2cXM3VURuTnJRTDQ0YVNyZlFwN1Qx?=
 =?utf-8?B?RXRCdFlrc3FSWUN5OVN4T2llRUs5eGYrT3ptam90TzhuUkRuSlNEemNHYU54?=
 =?utf-8?B?TUFJQ0VYNy9EdnFtREFSaG5HREtBUWJGVGdCdWlVNHUwMzg4V0d0WTdFOWlQ?=
 =?utf-8?B?WDRCY0QybEFqdFo1QUc2dFpTMUpwRnNrejd2MFJVbTNhaUd0UUt3OHQvMlhM?=
 =?utf-8?B?Zng5ZW8rN0xSMUlDYjZjaFBhekRWdjNEeng0a1BOZkhuRFVlbjhkSExCSWVV?=
 =?utf-8?B?RWtSZ0FhNGY2OUpTWGhwc0FJMitJN0JkQjhpOTBrOENWMXNzMllhZklzUFRH?=
 =?utf-8?B?SytKZjRoMVh1WEpqU2d3d2tFSDVOSDJaRjNyVzVJOHE3UGhDZ0J0Q0FvdDNX?=
 =?utf-8?B?Uld3M2hEZUQ3MEpFcDlNMVZEcmVGL2h4aGl2eUc5WEo3eHk1WE92S2FXSGk5?=
 =?utf-8?B?TUx3T3lvYnZrRllvK2lFc0ZVUHF2MnFLajRmWlpFeE0vdEY3S0NaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cb4cb0-be30-427a-9024-08de64d0b07f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:07:41.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDW3QKWeDRwkVWRdm6Wm96qi0SODZ+oMRW20WHr6+FiuHYPGHH/RrX+R6ZVk9Ln7FtS8wsNFky1ld9WZgWtjzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

On 2/4/2026 3:22 PM, dan.j.williams@intel.com wrote:
> Bowman, Terry wrote:
> [..]
>>>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>>>> +{
>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>> +
>>>> +	switch (pci_pcie_type(pdev)) {
>>>> +	case PCI_EXP_TYPE_ROOT_PORT:
>>>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>>>> +	{
>>>
>>> Nit, clang-format puts that { on the same line because coding style says
>>> only functions get newlines for open brackets.
>>>
>>
>> Hi Dan,
>>
>> Thanks for the note. Would you like every switch-case to be upodated
>> to match the clang recommended format?
> 
> Yes, please. See "git grep case.*:\ {" for all the other examples.
> 
> [..]
>>> Isn't this dead code? Only VH topologies will ever get a forwarded CXL
>>> error, right? I realize it gets deleted in a future patch, but then why
>>> leave dead code in the git history?
>>>
>>                             
>> Yes, agreed - I'll remove. Correct, only VH is forwarded. My
>> understanding is the cxl_memdev guard and driver check are no longer
>> required here. The memdev is only used to source the serial number, so
>> I’ll refactor accordingly. Please correct me if Im wrong.
> 
> You do not need the memdev to get the serial number, and I note that the
> serial number is only mandated for CXL memory class devices. I would
> rather stop worrying about serial / pass 0 then add endpoint special
> casing. The consumer of the tracepoint can always get the serial number
> from sysfs, or this can call "pci_get_dsn(pdev)".
> 
> Overall, I expect that this generic error handling is device-type
> indepdendent. The aim is it does not need to be touched again when/if
> Linux ever sees CXL.cache devices without CXL.mem or the "serial is
> mandated" edict for memory class devices.
> 
>> I see an additional fix needed: cxl_rch_handle_error_iter() in pci/pcie/aer.c
>> also needs its callbacks updated. The RCH/RCD path previously invoked the EP
>> PCIe handlers, but with RAS now handled at the port level, those callbacks no
>> longer reach the correct logic.
>>
>> I had a coupled ideas. One options is for the CXL logic to make a
>> callback into a cxl_core exported function such as
>> cxl_handle_rdport_errors(). BTW, the CXL logic in AER and the CXL
>> driver's RAS are both built with the CONFIG_CXL_RAS config.
> 
> That destroys the modularity of cxl_core.ko.
> 
>> Another option is updating the CXL PCIe callbacks. The cxl_pci PCI
>> error callbacks currently support only AER and could be updated to
>> also support RCH/RCD (no VH) with something along the lines of below?
> 
> This continues the abuse of PCI error handlers for what is an odd CXL
> aberration.
> 
> The answer that feels consistent with unburdening the PCI core with the
> vagaries CXL is to include RCH errors in the class of notifications that
> get forwarded. Arrange for cxl_proto_err_work_data to carry whether it
> is an RCH or VH error and then dispatch either
> cxl_handle_rdport_errors() or cxl_handle_proto_error().


That approach makes sense to me.

Would you like to keep the RCH's RCiEP traversal in the AER driver for now? In
that model, the RCiEP PCI device ID would be passed via cxl_proto_err_work_data. 
This would be a relatively small change — updating cxl_rch_handle_error_iter() 
and pcie/aer_cxl_rch.c to call cxl_forward_error().

A cleaner long-term approach would be to move all of the logic in aer_cxl_rch.c 
into cxl/core/rch_ras.c. In that case, an RCEC (reporting on behalf of the RCH 
error) would be passed in cxl_proto_err_work_data, and RCiEP iteration would be 
handled by the CXL driver after the work item surfaces from the kfifo.

The second approach improves PCI/CXL separation, but it may be harder to land 
late in the series. Would it be acceptable to proceed with the first approach 
initially, followed immediately by a cleanup series moving pcie/aer_cxl_rch.c 
into cxl/core/rch_ras.c?

- Terry
