Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EA3EBF37;
	Mon,  2 Feb 2026 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770009827; cv=fail; b=oHa4bye4ou1W45A5pstp+uUSB94wuMcUaogD3XTSuLakW1dMN1QmcZl00GSXi9BnNcHtHg+LlSqyP8MDYf9zZ/lKN96U2PKHwLKBcIvJdsasvrqf/MFlXlnjrVly6i/h/0uOx9TvBUi7OJGEADZ/RTrXZCN1c8/CcLUesXS4c9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770009827; c=relaxed/simple;
	bh=WSN4uAPZnmsN3onq2lVDXEiiWppDVAA+2Y+5XhumPAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4GGbJXBU0NdfDkxSeQ2lrxRG4amZ52EKQOCsIv/kbFAuO7NJnYPoK7jSfPjlxD6B2mz2xBU1cJCDDROvwfGJltPXpct7sM3lEdMxp00enpTzIQb1ZTipttc9XI04aAP3DG8iFNgOFo2EPMcOvTgwBSgXL9vtF6JKiZwSnOJtYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sguWycRx; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sguWycRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLn9PG5WLYRmhb9AvlnI9wo+nMbylSm5ZG87xBmjFGmHGsaIT9lEDGIaP/9uoGs6/SGgo8vgQ1MPEl0RRtbHGrUpBdzG7ExZqH9hRx6T3nxY4kO5MlpmuR4A7t3qTN8jELdLRXS+5E/4z0bkNBwxrr/qOs78AAE+rnlpyLTfrXHeI8B3/qDBSarz3gfYVSf3VrKzZDJYiuQbPo6eWhYBCb1HdwpDTY5/NnnwwskIbRYugf9jqNx5wgISOWfETXz315FsC+unE3y/JozJvkfPFrERb8OaPucl++FlJqXh8ZigvprEhCiO3Vql6qcOnhNIA3FQo3S7pL51cflTcUgXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm1OR6GzILUCJTAdVVfy/LdDvFQk2DpAVcmznSucqu8=;
 b=lCVL5kCKnx+B25D1PQX8D0GL9r2iKzLFj4vvPZzsU/505Q6fViozgc94DUlSn8XpMIiSGyqEOH+pTqaxnPEFYPF1tAPD/mxves4bZs2F7nXKfQZp2FVxyLmzONoA3gG7ZQE+/EKCYRIzouQ82vSI2DTkgMWWvbw2P0a6jCQgTd5ia6GX1KsE3FBXQfQc6PlLJVbRtNMbb6q9S4VEz45AnamfK8CxNhWgZOVREPvC/1mNYNWNDkYfI/YoBSEGQnVpsWBzCJ/XOaW+BCPse772c34BNlV8PdlmAp2kIm6XzevsbHnLS1kcbdTXX6VyoWQE8LdfGFwAnfObESKmVfxutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm1OR6GzILUCJTAdVVfy/LdDvFQk2DpAVcmznSucqu8=;
 b=sguWycRxdVf9zbX5jTaaM1Fezg/HetZGfpidA2jcoiwtLOjZRrzdv2IYF8dQddutAt2Fi/PJAS8tRpYRiDKDVqIm9nvwJANmJdFzb98jiL4aIwmPQCYRj+GPyJpqDqPlSVSI1u70QoGbLrMlRA8yC0tXlCU8UoK8AE/iVF53f9mkZS/dZD7+NLa8w03kRSMjlI4K9hX17YmVRjMDkr58b0IoXWwqyBhtCneW+FNgy+8UKvWxatyOM5QhtgjZZfLHkM0Psbg03JJBAIbEhppS87Zq9DWFR2vv6uoAdcclD55GAVS2AHs8JTPa8EezKX+kKUu6zQnFXQclA0QfHR2uKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:23:41 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:23:41 +0000
Message-ID: <157b145a-9473-46e5-9d1a-d317a2be17ba@nvidia.com>
Date: Mon, 2 Feb 2026 10:52:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/22] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
To: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 18255117159@163.com, cassel@kernel.org, vidyas@nvidia.com,
 jingoohan1@gmail.com, thierry.reding@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, mani@kernel.org,
 kwilczynski@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-5-mmaddireddy@nvidia.com>
 <a39410ec-4054-40eb-a687-0f161cffff2c@nvidia.com>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: nvpublic
In-Reply-To: <a39410ec-4054-40eb-a687-0f161cffff2c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::15) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: f4371b2d-e036-4575-815a-08de621b3a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azdhZXFPaTZCVkVOZEZHZE5Hd1p3NXZRY0RNQ3d2NGNTQTlMT0hoS1dWYS9I?=
 =?utf-8?B?UjBCZzMvaXFmZEJmZlRCR3Fkd2YwaTNkTE1HZWZubjJVcGtJN2ZrT1RQaENw?=
 =?utf-8?B?Snpza2RVYTZxMkRwc1lQVXRiMVlkM2liN3FobWcyNHVYQU1VZWJqaDF5MXhm?=
 =?utf-8?B?dGpSNWFMdFU0K1ZlY2dkSjBqd0dTaTJKcVJIYnVqcHZFSWJNQTZVOHBFejdN?=
 =?utf-8?B?K0YwTWhGU2FpWjl4cWx5d0JiZjJ1WklyZFAzVlpDZWM5cjErUVhHTWVUSlR6?=
 =?utf-8?B?MFJWanFsQVBiMmljMjU3dkREc3NmbGRrUHRQMHBjNUt6WDc0ZnNpQWFYVW9k?=
 =?utf-8?B?Uk1wRFlhWFJaci9YcnRGY0gyM0hwQmptVFJ2K1NwaERmUmtWU1JIbEQ4ME9u?=
 =?utf-8?B?ZC9neFBrSTh4RXZuUXpKT2xXLzEyaGJjM0tuTEhaZHNJRUNxb04vTENXbmpw?=
 =?utf-8?B?OG9McS8vODJqeDh2c0R6WXlST2tCQytmQ29MbFVOSWljUUlyTWhWcWtaMlZt?=
 =?utf-8?B?NjhoTHlKZzdtbDdqKytTZDZZWitHdUlCV0JBSU53d0U4Q09NY0s5NnVhVVVa?=
 =?utf-8?B?TGE3L1FPWnJLcEZUT0J0SWtNeWtBOHN3VWR5MVRhWjdlUmpBNmJ1aEE5K1hR?=
 =?utf-8?B?Mk9VcndnQTg2VWJTVm9JSnQ5bGppbVRqeGo2eTZwL09IcmJhbDdSUExOUmVO?=
 =?utf-8?B?bXNpNXJlUWxxQ1c2R3VyNkpzM1pzRmdSU2ExQmoxc1o2aGdYTGhnczRqWGxY?=
 =?utf-8?B?MU40cWRFTThTOUl5KzU4ajZoZkROTjkrdEFjRjBsZTNvWEQ2WTZ5VzhvMWtu?=
 =?utf-8?B?cktwTEpkVnd6Vzc5S0V5TEVFTmtUUmVBbFc4b0o4Slp1bmczaXBRR2FSdG5z?=
 =?utf-8?B?djZSRXViUUl5V2VkZ21MK2dNT0E2T2J5Rm5PTjB2VVNFeksxTkhmT3N6a2ZT?=
 =?utf-8?B?V2JiMTF3Z0RuUEk1TjdEKzkwREFneStUcWZidFkvN3RTakdxYU9UYklzSjFk?=
 =?utf-8?B?bFIzVmI2aVV3STBwZ0FUSU1Lcit3cFpxSXk5dnk0V3dkUmc3U3JZVDF4dDF4?=
 =?utf-8?B?bk5hQVhhL2tPdjVVSmJWT2Y2YUdMODNHd2VTNFJ6SGFZNjFMTjloN2d5T0Jk?=
 =?utf-8?B?eGpvbVpnRXdSR09mOEVkOU50bTJ4S3c1U3JxZytmUkZ1dEdqNVZ4dFlybkNy?=
 =?utf-8?B?VTJOV1VNUkVrUkovU1o1TEZSU1k5bzk2aXRwb0RseHh3eE5wcFVSZ1dJVXRo?=
 =?utf-8?B?R3I0dFEwRUtQaDdxcktMSjZnK1VjbDhDNkMycHgrREo1RHRRNWJUNUNWSFVV?=
 =?utf-8?B?Zmh1UXdHbUFLbG9qMzRDUm1iL2gwMU8vV1BIM2xZQ1Q0QkJ4a0dDdWFMSGlK?=
 =?utf-8?B?bnJOOFNGNWFCUEpGU3RrOXpNWS9XUjZTWjd6NUZmQTR4anNWZC82SFNCTGxB?=
 =?utf-8?B?MCs4TGxLSm14U0VsTjY0bXlpN0h0ZU96QUFQOWRnQXRXR3NYdnJyYUxEaDJj?=
 =?utf-8?B?UHBya3EzTGZyRjdXUGJScG1KS1A0dGJ4Wm9RdUpiVDY3MmZXaTRNbTROSXFp?=
 =?utf-8?B?TVJjUU9MTmNVVHBiUW5lQ2tuL09SN1pxK3FyemNldXM1N1g4MldvT0QyWnYr?=
 =?utf-8?B?SDE5R3BtUWhOU21kZEVsQUlLeDBtVG1td2ZJL0cvYTZ4NWlwL3dxTGZSckRQ?=
 =?utf-8?B?aS8vWW5RUzdPOGRoZlJDZDJOcloyTi9uL0t3RTJjSnNkUFBMUnpTYU41Q3JB?=
 =?utf-8?B?alJWS2hYK2d3Z2Z6Tkh2amE1MHJsNWorU3U3cDRqNDZCZVAxQ1UzSm9LZktI?=
 =?utf-8?B?Y296bHQzQXRWS1hVSzBiODRYNHoxVnkyVVpDMUdHT1hOSzlRRGh5emdXandG?=
 =?utf-8?B?Y0gvd1U3UVhpZ09ZVUJRWXJDdW81RGVmRkZ3NktEdXJTOEpmQlpnL0RNdnZl?=
 =?utf-8?B?ZzFQaTV5NEU4SXMwYy84dEtqQSswWlBmZXV5dTRNZHM1QnJvSFJuaXE5ZWtV?=
 =?utf-8?B?bllZeW9VRjQ3OXY2ZTBrV2ZSbGNwM084UWVhaTJ1R0FTK3pMRDE3L0p4Nk5V?=
 =?utf-8?B?My9VWnBXYndKd2Y0dko0am1DeUJMV1lEaC9yUk5WZ1Q0NGhOeXlMSVFSc2Uw?=
 =?utf-8?Q?zu1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStkRHAwVVFzcURGWFIrR2VDOFdvS3FRVzBBa1p2bFF3L3VPZlhmZUlwL2s2?=
 =?utf-8?B?RnBsZE9DL1RuQlhvazFBeE9kK3h2MExqNHhGaHJsd1hKaHEydTd6bFc0M3B1?=
 =?utf-8?B?VlpTZlVyUFdOemtIWlRjWHhUV2lDUTZMN3pBUFRlMTYycjgycHJ6RkcxOTUy?=
 =?utf-8?B?bTdBbHRvODlncC9Lak9GeXgrdm9LMEU2RmgxMVFYNSszZktrazdwY2haS0hu?=
 =?utf-8?B?UVhVUnF6dlNFT0FQRzFaYlc5WmpRUGRJMGtGQm1IY3Bab01aM2dOMXdlQnF3?=
 =?utf-8?B?eUp4T0lvNVUvamJLbTZnZ0FHUnlKeVAvM2FvN0pQT251cnhUUWlZcURjanV3?=
 =?utf-8?B?b2l1S3VuYXFCcHhPczZYcEtwUEJlbUlCemdKcnRlU2k0U1VpdE5SV09FeFFn?=
 =?utf-8?B?cHFDUHY0ODFZdDFyaXo4WWM1YTQzd3pLRzRjV0syZDhXbGZsUnlHVmI1Q01S?=
 =?utf-8?B?WGd1OEQ5ekdsQUxjSlhUcnM3Q3pWc3FTemlEZDM5bmMxZDNoNWhLeCs4U3V5?=
 =?utf-8?B?Q2s1emp2ZnFEVUM3S2xtc3ZXOUlhbHMzc0RjOVpHSVVsK3JXcTRPYWxWOFBi?=
 =?utf-8?B?d2wzWHZESWkxVGZ3NnJYajRWU2FOTnBVVW1CWnFsVkkrWmtONytXM2g5bHll?=
 =?utf-8?B?bXRralgrbXJTU0xGV2s5Zmk4ZXJXZy91dytrUkFrK0xINTI1VlU5Q21sTFBQ?=
 =?utf-8?B?Qk9jS1NlNWF1Qld3YzJGd0ExbkdiQmpJa2NGTjN6bmVTbnhGZDN2MUNDS0VE?=
 =?utf-8?B?b0Y4LzgzKzlNYnJrLzdoaCtReWZkTU5YL0RSY285aEpKdStheXE0bWlqVHNs?=
 =?utf-8?B?WFlGWERnN1R3WDhIeTRkY3lDUEFXRnM5eU9JeVFjb2NmUTJCWEI5RTFnWHZU?=
 =?utf-8?B?akFOTGVGdVdhNnk2Z1oxZTlNUEk5dUdBcGVSVm16aWczTEJ6VU4xaHI5bnJX?=
 =?utf-8?B?WUNEdGhmUmE3U21wcHpNMzRzUVkrbGF0WWJsU09IY08wMjIxRmpXQkV1Mng4?=
 =?utf-8?B?QURsMGJDS1F3UG13dXdxOTNzVXpVS1dvSTZQbzZFZ1B0YnJibVhpMXVOYk5h?=
 =?utf-8?B?d2picGozcVoweU4zWWxsN1ZNbEFqUmhVZEJGUmMyd1I5Wnp2OE1YclppTGhu?=
 =?utf-8?B?aTFiWU5EUGdRQ1h0K2E2QlV4ekJ2Z1lSRk4yS2ZINFRNWnZaZHN6Q0t2MDhK?=
 =?utf-8?B?SDJhTGhWZVJ0R041WXFGYXQwcERKbTNqQmRhckdiZjl6N2NrWlVEOEkvSTkx?=
 =?utf-8?B?cEtBOEZ3b3JMRFN1RHFDR1d6R2RWNFAyeno2TE5JWHFBZGloM0ZJd0ZYSDdS?=
 =?utf-8?B?MkdvVy8xenl5bElXM3ZlalBOTENBbCtNbkJ2SndjUG5pTGFYVFhTaFZscmh4?=
 =?utf-8?B?bCtKb0lSNnBmMnNkUmF2OE1TL3dOTmpPcjlDNVAzbGZwSFZEcTNaOFJiaXVO?=
 =?utf-8?B?eXRmNitYNU9TZUFGamp2ZmtSNXFia3pwUCtZaGxtSktYS3pnOC9wYm1hb3hk?=
 =?utf-8?B?M3NzVy9MRWhXcHlJT0c2MXc3WTQ3RWlpSjE4Z1o2c3dBNXpZRWQxbUo2ZGRa?=
 =?utf-8?B?dUlSNit0WGhRQzlyTWpoZDF1N28wdHpRNWt3ZGVzVm1qVkQyOStXalNIK3M5?=
 =?utf-8?B?YUJiS2ZvbWlsYzA2K0ExY1VsMWtYVkRPLzNFVGp0b3dKYWxQNkZFOVpCZVcx?=
 =?utf-8?B?T3I0aFlRQ0NDdC9pYitMbEZXSndYbUIvclM3alJ1VVJxTStYc29VN1JiTVVr?=
 =?utf-8?B?Z0lNS0JTdzl1bXMwL2VNZnZNODlxL0F4ZE9vYndxbVJzKzhBbm5qaFF2UUdC?=
 =?utf-8?B?ZXlkNHR3RUhBRncvd1hPMzlSY3dOMjNWQVN4SGZNNTVaMStSenNkSjIxeHhJ?=
 =?utf-8?B?RVh1b0c2Y256Y3RLa0RESEI4UERYazFGZGprR3hFdzBsWWI0a05zeDQ1SER2?=
 =?utf-8?B?bUlOcFFORGI0aDdPRmp6YWprMk5rdTBWS2R4QkxCbm5RTXE1UTJUcnEvbVB6?=
 =?utf-8?B?a29Wc3B1SytEQ0hNcmlLVGMxMkxRdThDcXhjbzdRSGlNWnpwRHN6N3pTNnFl?=
 =?utf-8?B?SHJnaytHdVVLRUhuTmRqVHRpcDR2Q1dRdzZrYXFsbTc2all2RXZBSEIwdy9Q?=
 =?utf-8?B?bjMzRzJYMk9Ed0UxTWpZVmtDODI1K2ZRV2VoeDM4STVFOU9aZFNSWEpGTFg2?=
 =?utf-8?B?L21MQlo0MXh0c0dWVVIrcjV5U0xKeE9xOTJpRE54aHVJYTRYV0Z6U1ppci9V?=
 =?utf-8?B?a3dUQytRYkVKbUM3YS9LWXNJQm4xclUzVHhqNjRPOHBaSXdhWFk1eEczeTFT?=
 =?utf-8?B?OXl1RUZ6ZU9saVp1ODcrbmR1cVJmMDRNSmtJSk5EUUZCWC85czFydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4371b2d-e036-4575-815a-08de621b3a25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:23:41.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2MxUNGUqCzPm0SFyZ4OKfxtAfT3NVUK2Shy3raDtVQzEDVE16JbGwAkBalFNT675DOr/TrMByP874f1UzuY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901


On 30/01/26 10:51 pm, Jon Hunter wrote:
>
>
> On 26/01/2026 07:45, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> PERST# and CLKREQ# pinctrl settings should be applied for both root port
>> and endpoint mode. Move pinctrl_pm_select_default_state() function call
>> from root port specific configuration function to probe().
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V4:
>> * None
>>
>> V3:
>> * None
>>
>> V2:
>> * None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c 
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 0b8c1a7ca232..04ff211deaea 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1645,12 +1645,6 @@ static int tegra_pcie_config_rp(struct 
>> tegra_pcie_dw *pcie)
>>           goto fail_pm_get_sync;
>>       }
>>   -    ret = pinctrl_pm_select_default_state(dev);
>> -    if (ret < 0) {
>> -        dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
>> -        goto fail_pm_get_sync;
>> -    }
>> -
>>       ret = tegra_pcie_init_controller(pcie);
>>       if (ret < 0) {
>>           dev_err(dev, "Failed to initialize controller: %d\n", ret);
>> @@ -2106,6 +2100,19 @@ static int tegra_pcie_dw_probe(struct 
>> platform_device *pdev)
>>       pp = &pci->pp;
>>       pp->num_vectors = MAX_MSI_IRQS;
>>   +    ret = pinctrl_pm_select_default_state(dev);
>> +    if (ret < 0) {
>> +        const char *level = KERN_ERR;
>> +
>> +        if (ret == -EPROBE_DEFER)
>> +            level = KERN_DEBUG;
>> +
>> +        dev_printk(level, dev,
>> +               "Failed to configure sideband pins: %d\n",
>> +               ret);
>
> We can now use dev_err_probe() to handle the above and this becomes ...
>
>  if (ret < 0)
>         return dev_err_probe(dev, ret, "Failed to configure sideband 
> pins: %d\n", ret);
>
Thank you for quick review. I will fix it in next version.

I will wait for few more days for others to review this series and then 
send new version.

>> +        return ret;
>> +    }
>> +
>>       ret = tegra_pcie_dw_parse_dt(pcie);
>>       if (ret < 0) {
>>           const char *level = KERN_ERR;
>
