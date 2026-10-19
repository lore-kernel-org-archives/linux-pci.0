Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4C3DDB04;
	Mon, 19 Oct 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408638; cv=fail; b=djVz5RVcG9YG0Iw+4k4071Nf51mkXQlev1I6fLT86rRHmwKrK6Rbx32X6ikua5W9QtOEdNjHGw8hbdZjTWT6q587Ckcyc62Y/jyZp707z0VVp0eJKfLgLGZx2+0RBLCVDLPruDGGeErSZLokyqL673KQXyrRvG1ZVcoRZlivBMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408638; c=relaxed/simple;
	bh=/bBtAjpPTD5ZOFl6srz1+dFFndWg0uFDbyDygUGV25k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W2RqtLKlQhDOE9OwU/0aDSlrnLDcVx8ntGeZfbLni34zDVGaTdH68PcC5995QnIf33gWAgTwsX0y/MtauQ+8ncQVkxDGEr+QgVoHUEGL16oWs2/+oWls1DGCMqLAqVoNlauQXYJKM9sg6x+IqRDLTWAvSGnnDbZF7pOArwI3qzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbRsZuvv; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbRsZuvv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxhZpdECVY9ix6rm7WkSyjqSk502kaGenirqk8g91OcU5CUSIJs+pX4071oE1PY9/xeyhYZRLRBrOfj1xU9TLE/wYO9KpPGpBhiFNIZdyWPmjXFCUP+F33Y1va/DJgs9LAYFb9M1c6Q/vMKp9RV+qvFkkyo6Uiu+dmrUA7OVudbmTSuUKyRe5cGK7nnKqzxa+yffcMMi1yjiI62gKK6nHOyDBca0xL1NYcOcXsyrJPJbRx47k+gtECMvLE5tf0sTjXrNzmQDEnIRbcjynvI2gV2OaL+UOl3mQrnkfPT8DDgSzsomGQby9gmUbxfed9ZbMmuw2u9ND3ISj8zMdEs7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G3GKTn9Sjd31fVfs1gxwCOWHBE6PLh3CYswoBrTx2s=;
 b=w5IpmPyoQxbBB54eRucJbjh0l2lwef05rdAYWp8inUp6KrC6K02ikhBo1gxnXQDOxsz24Rm8/+1b1pbtIXUI+K5HOPle3uGUBYlD7OL4r3duidMThcdRLJmFuV/grNTDu/adA1Z1ArF8fkR2GXWZ+2hsNveDn8z/fOcPmAmdXElD12agn1O1OOSqptctuUHewnTfiQSH8L+XfXeE7dnAETf8ciD2JPwIIkryvdP6ZMOzuqlAFU5YGHg7Iv8WwVob0JDCDpbKlK0vE0YgOTAsdAkluzSQJPd5yekHhZFYG7pr/7tyZAZDVGclcSqvCP5Giohs2MouZD6g6bjTMmPOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G3GKTn9Sjd31fVfs1gxwCOWHBE6PLh3CYswoBrTx2s=;
 b=LbRsZuvvoLkSnqcLqGFQFfS1EL2PREz9BnsV0+s+KipgmM+J8to1knkUDxKmoexAYlNQ4eiTCo4gTP4Mygi5Nr6r1pMZPCY0cP9z8Awor0fXg9CdVx8oPsAxLEICpKNfpzSR4ZSE9ExqXB+GN2UK485tzKsHyIp9lY+s5LHX03WZGrDQ4AixfpdDfy5J/3/epY1v7Io8iS6LOeIBF53VqPjNj8I53/MJj4jgCaRinHmHc4SSUVxPoTM2D1kvHT2KZDcQEo5+vU91W5rpWPgGanmVBnlxbK7kBNNonNJSjcKYh/T5v+yyDTyQyaCgiygFPdfCIf4VPojIaOziKID39w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 19 Oct 2026 11:17:11 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:17:11 +0000
Message-ID: <14da8b54-6e53-4466-83f2-e8a2cfa9e8a2@nvidia.com>
Date: Mon, 19 Oct 2026 16:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: tegra194: Avoid full Endpoint reinit on PERST#
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
 <20260923072554.1141864-3-mmaddireddy@nvidia.com>
 <6b4ffagwiepvhctdffzulxqvkie7rpk6eq47ssel4l6ilrkazr@j76sfnd3eush>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <6b4ffagwiepvhctdffzulxqvkie7rpk6eq47ssel4l6ilrkazr@j76sfnd3eush>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::22) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8120a3d6-c086-4a3a-6e68-08df2dd2853d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4wtgcRI0PlR4/vuxnI7o0nMqHqhn0dsRZeq4+2e4ZuoUz4jK9abpl/ztry/lAb3TxZcz6LSvXbnNPJpW3fsLoPElWmld+N1K0NgvrMCQJgNsZ/5ZQ+3w3w8SXDTCJvPZkTbukdTzpd0+YG9fxMGpdTWcaVOSer8sXYtQLgSO4E+jgdX+LoHvpcPrO0JHxJOPsWxGumAm6SRS46m2mBiNkC0u836rFuO7etAxaXvNB/bQLAcAYZMR7eKqlbyzELkVkFY0/xw7kYhQKs2mtzTNse2OpUBf2APEfEK4x+4OnQRjV2eYf5rLuwhCQp+wCHRVfBHOooU3mAVM8Qi3L76T5XrJM7AIw/S+4OaIIeago1hKlYBDSMtRlowBRergM+oqqj9t19sA1GGi8g3lhbqX0sDmtXSW2h7Ok+OtCWofMShOd+JnTM1Zu596n60T/IpUnXLn3gOJLIIiznOrLX5YBKRD6x0MR/VYYoQcCv24ZnYKbBTi0mfPbIEA30hFTvKK92/T8Ky+/ukT5u+G2g1X3bnD0d6wnseVARPWY+uz62nMyPQUoD+qwzG6S8nIa1zE0/K8WFdbET2Rf62dHTV3GSAQVAD4iR+Rg5aGSPzHfZR3svMq0W+NWFkCpadUZh3u6vPb9VkLR3scz8a+IvX4eIkHNrNSV5Y5bi+deeM0dA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3BvSkVmc2Y5WXlvd1c3RElaTlJMWGFMeHdUNE5SODAvZUs0dlhNNnI1RnU2?=
 =?utf-8?B?MEpkYUVmSDMxVC84Vy9WZ2NJK3NnL2U1OE5nbWxvdVBIU0lkdC9QWWI5WDlp?=
 =?utf-8?B?MjFSR09rZDlkZ0d2aHo3d2RoU25TdlNGanFJN2xQckpZRTE2MzI3Ty9JemIr?=
 =?utf-8?B?a0xFMGxwSUR5RWhpbVoya1pYNWVVN1R6UHMrV241MyszZCtQbnlkYmE1U1dP?=
 =?utf-8?B?TmhBejVnNm0yMjBNM2ZzUDl6bW1uSTlzV1RPcmdmeHdRY1dXOWxhUFhHVGRF?=
 =?utf-8?B?RXhUSndJdVppNCtsTG1YczZhS0kzejdhUEZuSlN3S3VUN2ZldFdaaDNVUCtE?=
 =?utf-8?B?blpkWWFLT3AwT1ZUK2QrT2llN1UyVkIycWtnaEYrbUxSVkluUlo3UXVZOTNK?=
 =?utf-8?B?NXI2QzlRcjFObnFremd3ZmlaWlhHUjlrSlRMRy9sUldkUWtMc290Qk1KM2k4?=
 =?utf-8?B?QnlZb3Y5UXlEZkUza1VoUzdSVWpucDIvQnFjZlh3a1RVZDU0VkovMlViZGM2?=
 =?utf-8?B?SDhsMm96bS9mREwwbVd6cHhNckdIYTNjLzZUdnhtd080Z3ZhcE81V01UUVdI?=
 =?utf-8?B?dWdZMFRmVnRwTDFFd202UFdFR0txdmJhditjRUgycmQ3WThzVEJ0emFrM2Uw?=
 =?utf-8?B?alhIUjZoUmpjSTlsUkRualR3MDh2UnhIQ0tHOWVKc3hDTHJmRzhaUzJUZmF2?=
 =?utf-8?B?cWVkUUQxaVJOZHJtY1VkT3lJTDA3cCswU1RaUE1NUlhBL01uY0kyaEI1aHE5?=
 =?utf-8?B?Z05qTlJPUlVmbFdUTk8yamI4ekUvRGk5ZUt1c2N4QnFpQ052ZFdNVmlVallN?=
 =?utf-8?B?OFBuQVRqdzVXQXpScCtVMnY0OUMybjkzQWRCTHNGdlFSY3AxbXY4VDdoOFZ6?=
 =?utf-8?B?TGtwMXVCNTV4cHYxekNSUHRoL2l2Skg2bTJGUThiNVArRUdOcjFxRm1PMG04?=
 =?utf-8?B?SzJSaDJKc1JES1hPMFlKckkrUTA0WXl2UW9BQjVuM2xBaFozRVd4UWZjWWJh?=
 =?utf-8?B?RE1QL29kR2JPMG40c09qalJQTnJiOXFXai9zWUNjT0NadGtsNWROZWRzMnM3?=
 =?utf-8?B?OFZLQ09oU1dDRzdSOVg3enJaN1NRVGt0Qi84OHZZUjFPWS95ZXk1OHdjMmNW?=
 =?utf-8?B?S25tYm94OGJXT1I3NjJDZ3dlVFU1MzAxakpXVFIxaWp3dWJHeE03a0o4UWUr?=
 =?utf-8?B?VzFjS3VRWktnVWdWV0kzNU83VFk0QnJPeU00c01GZGFFUWkzZ2FOVFNQdTRP?=
 =?utf-8?B?STVlaWphZDZzdW1FZVo5aEtqbXVoa2p5SVZvKzJJYmRSYjZqNm1FYXJlRURF?=
 =?utf-8?B?VTE1aFZRRnAzMENqSGlld3N0RStBWHNJaVV1QmRXNGpwYzEwaitUZ0h5T1Jz?=
 =?utf-8?B?d2FqSDE4ZzdqZVFOVWpqQUlFSWtqTGZhcmFVT0hXYVZ1VlB0VG9obGNwSFln?=
 =?utf-8?B?T3ZEWGVobnMrU1BIdlI2N0NOUFpUSlhFVE92R05LTVowQWVnVmt4WkJLRGlx?=
 =?utf-8?B?eHVYQmJiYUVZOHhrSVNqVEdQc2VVVVhoK1FIUWQybmxYY1p6bENYKzFQMHdY?=
 =?utf-8?B?N01UcUlCbk54QnZjbjZEMDBidUhWYXVJcWl1cit1ajE0TVBxNXozbXJqSHhj?=
 =?utf-8?B?VkQ1N3FZNzd4d1hPUlFFeGVWVitkZHE4RlJEeXlpcGpVRXhkd3ZsRHZnVWph?=
 =?utf-8?B?bXFXTmNZMk9yZ2EwTlkvTkpwTFZ5QmFNR29UUk1nTnVUbzRMNDdUUGJmeVFF?=
 =?utf-8?B?dFU4dEYwMkUyb1VDb1E2cjRaTnZjQmlSYkRvc2NkWFV6SlYzS09tL0JNMFJ1?=
 =?utf-8?B?R1ExbExZbSs0R3pKYURlODlDd1d6Y0lXbGszN1FmbC9GMW44SjhMTkZWRitD?=
 =?utf-8?B?alNranBvdXdzTGEva1pucTZ4OHhXSmk0NzNQcGU4WFhROGxhR002QVBxV2h3?=
 =?utf-8?B?U2JrdWFOVmtEd1F5WTRJRWVEWFI1WXV1RXpCbzlqQW8zUG1ZNU5JaUpKNUZj?=
 =?utf-8?B?K1FIRGRDOG54ZGxXS2JkOHVnVnUyNmlFU3JQRlhmMmJzQjYxa05adGhRZ2Nr?=
 =?utf-8?B?V2hrcmw0bDZHUkM3SXNRL3JTY2lWWkZmYU4rVm1MNGhoWVA1NGFoK2lGbEFV?=
 =?utf-8?B?RHFUZmpMWVJ6ay9ZWmhOK0NaNGtTUnpPLytXeGlmbEhZU2d2ZWNEK3NpeUZ0?=
 =?utf-8?B?VW1GTlhycWg5bGZmcnhtRFJnTGZEZGRDSjRBUllLeFg3LzlZUTl4Nnl1ZFZN?=
 =?utf-8?B?SFg5VzVYZ2R4bDRmOVZvS0JGWGxQUW4zOFNsK2QzTlUxemVCc2NEa29hME50?=
 =?utf-8?B?LzNWTVBUQzBnZ0lyc0g0aWE4cHYrZnNCN1licFVReThzOXhHcnBKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8120a3d6-c086-4a3a-6e68-08df2dd2853d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:17:11.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y+t1ZViB2O0SEVU2XQ2gnB1C33rJiet3w7PU0hMpDK8xqVg0q85kyTMvEpKecpvkSFtXHJUh0T3+zrHEdFgaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045



On 17/10/26 2:47 pm, Manivannan Sadhasivam wrote:
> On Wed, Sep 23, 2026 at 12:55:53PM +0530, Manikanta Maddireddy wrote:
>> Tegra194 and Tegra234 Endpoint mode receive PERST# as a fundamental
>> reset. Controller registers are lost across that reset, but DWC
>> Endpoint resources live for the controller lifetime.
>>
> 
> What do you mean by 'DWC Endpoint resources are live for controller lifetime'?
> What resources you mean?
> 
> - Mani
> 

I mean the DWC software objects retained while the driver remains bound, 
rather than hardware register contents. The existing initialization 
already reuses several allocated objects; the unnecessary repeated 
teardown/setup primarily concerns debugfs and eDMA where present. I’ll 
name the resources explicitly and distinguish their lifetime from the 
reset-lost register state.

- Manikanta

-- 
nvpublic

