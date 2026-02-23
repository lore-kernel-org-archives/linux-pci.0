Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D944F5E0
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822866; cv=fail; b=YJs/ZhXPswas0SXI2x6/DPjM+ghqTVJ0fEFR+y+fS1mGaRSy89wE7nvEhUrfxFu8pm9sTvFoaoSLgtll05YHBZLVoQL8MkgWcBaF0ZCwTrY/uqc80EUlbuSC1QFb5o4KsR227w0StniuXcFw9C8UDcRtyIr0vQUHha1+jHCN3zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822866; c=relaxed/simple;
	bh=EmurJwBnpzlwNZYZR/3K6OO7dONL8E36QJG3+jz+Kj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCTzgopKma7E6/AauKcg0MSN4kpCoN7v7w5EGl0Z260nBcYTTCMjHDVjb8OuMOdtu1Fh4SovI9PTMd/gdOG9MOI9OGTKIIMHQyBRxacYpDm7BwqZ4VffcNybGzjLTgNGwwPTnud5+kMp68njtmgZKW6PqNCUTvozDeX5Yp6zWi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQ2QEIe5; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQ2QEIe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpsXmk8u9swBsZLsTidniAx/FG5bEV3eBuDseFmdzq/9H11PytC0/3dhVxAwed2xr5MEmTYGh6eppawm7ZrWUrJ6IjgSJQpjXxdp0EH77mK5swvP8+jgkx+zdttAOkYJ60bC5ISMR7HTjUyrzoL2SSFSojlaSlxlSInBcczUxnhni6ZMdINZATD/8I6juxtIc2fve/u5F6luETo27xwo79dcsAI+Flq6KI91xGQy77kxYJXWuDNmFg0dx47aGRED8WHUxgn0KCo2iRgk7BS1CRfUk3K3mCBYyzEbjYyPX7n5MS5niXoJkNHcgYmcSR+UhVpOExfCUIDQ79ZCVkRp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwbOq+tgm5zjRXqd7/HfdMrKKAAMpHFn9d3oFTjT1l4=;
 b=SlWvkoUON6qEDNaX8BlF5PJIiZQt/tJOIJpqmz7YOg/eGV+UMVYiLO5NtaISkKlpjFbqqRDccGUz2yooNHLOFUZO29yxthvPT+KQTndj8oJ0ozn6WCBQsmWOcrERTY5QFMBHBhCtwWGnRYWVl5bmIYxCO6FnJTm9T/7DsBoghNg/TuCfDK5nn1noeqJBGFtFUww3rQu+yUqtFcj6/f7Of7OY0v/ofFFhF3iAgRK+eKmLCDjqyPPvpl0ZhCNvyhWwt0QVVWMEPDkkM5sRi17ZWKZ7DB61W+1rIovFZM2CVGtIepT3UJX4zV+84RHxhX5MzGiuNbtyHZSeiLXTHHlaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwbOq+tgm5zjRXqd7/HfdMrKKAAMpHFn9d3oFTjT1l4=;
 b=OQ2QEIe5icJpFLu0vT6oZiV3MEoi9tHkv+THRDQpel5WVsp3ggXJVYN+7tRql6zKYVTKVCPvC0Df2zv4OXk2RDuR7FPKk5gSBBYcJkO2mNWmOIZsIn7vSf7lp+Pji2BOT7amJ7PREB7zBbK4WiFKuFU12Kq3KfU/Et9xsn1FKoLy8sDT+EbAU9GmfxjA6wDCbbOu9f6X6tit9JW8Qd0k4QQpuMgpPZZnozVQjkFo9atHxRa0lGmZ/KN56+MA0au8xVANybZHLWPdlVtdeTr2hDNaLfEH+QVBDLy7pF1xMauSODwKNG0s97g+Ed+WC2NVD8u61JuPZFjJxz67WBNjQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 05:01:00 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 05:01:00 +0000
Message-ID: <a8151b84-d312-4cc0-92b1-55afcc89fd37@nvidia.com>
Date: Mon, 23 Feb 2026 10:30:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
To: Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>,
 linux-pci@vger.kernel.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-19-cassel@kernel.org>
 <aZT0R1Iy_i0j5GGB@lizhi-Precision-Tower-5810> <aZWYBbkBeZbVhJ8z@ryzen>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZWYBbkBeZbVhJ8z@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::27) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca617ce-f985-401b-2d2a-08de729889b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHF0Sk5FU2V2YTkyY3o3M0tMKy93VktDSkIxblJsV2xpaDFIZjR1TlZJRkMr?=
 =?utf-8?B?YURUbnQrNXQ3UEM3QWNhUDQrK29ieFpDTVY1LzEvZmVrcE01WDl6L3E1NkY5?=
 =?utf-8?B?eTFkb21CYVJwQVBVQjZodlVLb3kvU0FyYVVFZk5xalRLcGhUODJneDZvRDJZ?=
 =?utf-8?B?ZWtDczRCWjhMaTZYait4OWZKcTNrZmhVMCtneitRekVYbU5YOGpJenRQQk4r?=
 =?utf-8?B?bWdUOEdSVzdQaHloa2ladkxscGNXdUVJTXRZTk9CVTRFaGVad0N1Z1VqRGxM?=
 =?utf-8?B?RTFvR1o5dUFwMHI3TXErUGJQNCtuL05wbllrUG5kVkZLQVN2dDZGYXhRdFJL?=
 =?utf-8?B?M3FDYkVGbGtLamZwZ1dML3hFVW5VNm1yVnprbmRROCtqTjhPYkdoQkQ5NE9q?=
 =?utf-8?B?SkRnaHA1RncvRExySDc2dzNWSk9yTW9kSzY2ZXFHZ2ZkaVpZNXFYSEhRc2VG?=
 =?utf-8?B?eVFHV3AxM3g4a1RwSVl2L1lBZVVxYktDeG9Kck8vY3Y5bllMZnhRTTAxU1c5?=
 =?utf-8?B?djErUUNnRXVZbS8yZlBqb2NMQkxBaElzQ25YSFhQZU5NcHlnSjJreXluSkhK?=
 =?utf-8?B?S3o4bHozSjIreVp5WFordDVuT1d5V3FLWTIrWWV3VEJvTWtVMjc0T3QyTERw?=
 =?utf-8?B?a0ExeU5RazRvVWF5VHdIVnhPNXkwN3htajR1Mm9DZGN2dzkxb2xFM1VCZzFp?=
 =?utf-8?B?bEtKVGRyM2w5R2NCcXNpVm5qUUxoZ3NCTFIyaEtpeEdoMUZoSFNCZzh2UEhT?=
 =?utf-8?B?azlnMnNHSXFTSEZQMmUvTW50L2F0Z3NtaGpQQWlIY1pEQXhlWHVaNEZ6L0Zm?=
 =?utf-8?B?NlQ2TXhSL29NK3Y4dVBtSUpEMkZZRTA3am1YRGdqS29FME5mNmRha1Z4Wlll?=
 =?utf-8?B?ajhuaTUwVStDVGlVRXBNMGQyUXc4ZkExYWgybU0vY25rMzFSS2JEZTNOTGFU?=
 =?utf-8?B?NG1wMjFhMGVJWFJKNXhBb0hMeVg0MzJrRjRDeGxRUmwvV0lubVlYY2gxL0Y3?=
 =?utf-8?B?NW5CQVQzWElXR3Noc0xOVVRYNnBzemxpdFJPNjBjSXM2WnBmT3NzVTdyR0Iy?=
 =?utf-8?B?OHFKSXAyRlJpa1FjUkNLT2xyUjdSTDlZVjNqTXpwS09QbzZwVUU5ZTdWNEtQ?=
 =?utf-8?B?enhMb0kycFk5SVJramNyOWdhcnZRVzF1UzJ0eVlhc05zTkVPekgwa3hkWk9S?=
 =?utf-8?B?bStuK1JMSkU4V2VLVjhlb0FEeWZxUjgwMElFaG0wZzlNQ2pPTFhUSGFreHh1?=
 =?utf-8?B?UmxyZldxdnBOaFpsM3JHNzV2RGRmL3laa0s4bWVQaXdIQ0NPRmxmQ2Z1ZFl3?=
 =?utf-8?B?Z0NKTzNZMDZMaUs2Ly9ObHh6NFhvYU1LNENpUHZDWTNtWDNjWkRPV0lRdjk5?=
 =?utf-8?B?d1Ftd2NoR21BQ3kwajVSSjQzU1c4Ui92Nnd2UXl4dHVwMlhtSzRzV2dMcGow?=
 =?utf-8?B?cTMrdUJYTjFFN2txdGJYdnozK2xEMk5iaTc3ZVYvUFBFTUtPS0lKZCtKdEFK?=
 =?utf-8?B?dzdEWHZuOTVLUFFzaGZiL2xiOU00YjdqUmdGYkU3cXRjZWtIV0JLbEpjSFE1?=
 =?utf-8?B?MGtNWXM0Nk1iL2twQTJVZ2t6OXV2aG1XbHZiWmlOdEJSQmZDRGtpNDBNYnB5?=
 =?utf-8?B?VFZtSDlTWG5pMm01b00yLzFqdnRRTGkwZFQyaUVsM0tvSWFmQm11dVkvMmx0?=
 =?utf-8?B?dGVLL3k1VVVGTkxMcDNaaFF2cmxtUnpMdUNVYXovTWp3dHJiK2ZIMEJMNjJC?=
 =?utf-8?B?MTNaVnVYTnIvd2kweHl0b1BjT0tuakI2amsweUpMTEVES2Q2R3lRWVVoMStY?=
 =?utf-8?B?ZERNVkxVRGRJeCtia09VOUNSTE1jZnBtcVlvcS9INEFnVXlVVDVXMFEwMHF4?=
 =?utf-8?B?OU1Rd0NHRVMzMzJ2VXpEbU1PNE1sYVpLWnVDNjJtMk1EVmFpZS9OTVNJSkJU?=
 =?utf-8?B?KzZOOEFWTjg3QkJHaFV0NEFVckdjZjBGVDIyYURadW9ld2lZd3diTnZoSytT?=
 =?utf-8?B?Y0ZpN3dWOWdRZk5NVk11d3RKWkViYjhSbVR5eWtCRVF3MitLTmdBMnlFZ1U2?=
 =?utf-8?B?eUM5dWF4bG9RcnIzZEZabzllWklIOENJemgrL01CeTVVWEtCbVhOeTFONzZD?=
 =?utf-8?Q?B5fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZOYzJHOFJlbm9xSTBvWlVsSnlRbTJKbWJ6TU40WE9tNlBCQk5FeXhZWGJ2?=
 =?utf-8?B?Tm1ldHgyNTFncTNaZFRqRlh2a081VG0xV2o0eU96UTRxb2QxTkoxVDc4cWEr?=
 =?utf-8?B?TmZkT2FwK0lUeXA1TXhYRDVIT0dsdkFjNlJKK1czeCtEYU1DN29ZYUp4azV4?=
 =?utf-8?B?MWpNOGJwL2NJWWhIMlJVNmtCY3VNTTJpb2N2Ykx2UjVBZ3JYVkJmNFJJa2ZN?=
 =?utf-8?B?NkVacVJDaEhVUGJYUHhvejNvdnZFd0FpOTBqUnVjd0pkd3Yvei8wQVN6WkN2?=
 =?utf-8?B?YWtCTHF3UFlvdTFMcTRSRmdXckdRUWFvUm9zUWoySGRMOVFnRmtyYk0vWUNw?=
 =?utf-8?B?eGxMa3J0bjROMzJVY01Dd3VnZXU0RTJNcGp3R3NxUDVaY2F5bDZrZnZjYnNr?=
 =?utf-8?B?TFJSWFg2QWR3emNjcHZCRTJvdkxTb1lodVUwdHI1NFJsTUk4dFFEQWk1azNL?=
 =?utf-8?B?QVlzUUhIcFRHcFhDUyt0SVNmK3lwdjdadEp5S2J0YkZrT255ZWh1VWlMdGlU?=
 =?utf-8?B?L3E2VExJQTh1VVZvZUMvYnhuU2w3MnZ2ZWFJVjdCTFdGYUt3cDBIVjUvaVk1?=
 =?utf-8?B?MVNPWk91L0VqNk5HSUd6RmVBRjFCait0cG9nUVFBb0I4cTJJYnRkMXFMc09X?=
 =?utf-8?B?YjFWT2NkWEhLdkU0ZlJ5YUFwYlAwVWFPWDFoL1RmdlpLa0NuNisvNDNSLzFD?=
 =?utf-8?B?dFd3bzN0M2syOEJBTGZLbTByUXY3bVRzeDZDTEJJRlBQMXM5WG5BRmpGYStt?=
 =?utf-8?B?bnNaZVp5VlF2ZFhRYTJJTWtBWlo5YjdBTTUyZFQvTkpqajFTSnBpeFdvVXpW?=
 =?utf-8?B?NHdBcVVjOC9Nam03SVVTRUdJRUdLZlRMeFU4UmlUUERwYXNwa2JyKzRadUJr?=
 =?utf-8?B?ZVB6U2NTZU5uUVQvY3hiYmE4UllBM0NJWFJmeEJRM3pma3VlTVZqTHM0RXBL?=
 =?utf-8?B?UFF3aGdUbGlWWVNTcnBGT2JEczF5bDRBa2ZjY1dIQmZtWjFMS0MrcnMzNzZU?=
 =?utf-8?B?R2hxVVBXbW5qUFpCdUh1Y3NmazRxNlVEMmdraVlCOXNIdlJrRjhwMW9QbXBw?=
 =?utf-8?B?SWplTEUySzVSOTk2bkp2Rk9IZFVDNUhSa25mKzRSMGVueE9GcjFiT2U4SFF2?=
 =?utf-8?B?aExySzZDZkN5bldWRVlXcmdBYXRXTVBGNGdaYmNFSWlxZ3NPa01uRlFzZkVl?=
 =?utf-8?B?UHZjcHIyd3BLTGpBNTRaUHNWelcxUFgrZ091b2ZMTlROU0JWRXYyVTQxK1lC?=
 =?utf-8?B?SEZvMmRZdUM2SVZ2MVNaaEFSU2J5TWo0dW9KcUZLbUFzeFZkUFRWWnVSaGNC?=
 =?utf-8?B?ZEZnWkNBd1B1UU9qK2tLZ21iKzJNbW5FcDduM20xOEt5NUNIbFE0Rk5jQ0VC?=
 =?utf-8?B?cmRkdjNzL2hYTXlBbmRhblVNbC9kNVNHS1ByMmlkdU9iUkIyN0QwRVN5YjZQ?=
 =?utf-8?B?eEtobDJRekJMUHBzQjRwT0lqL3ArOW4xU3pQS3lQYXJMZFpOblJzMzJvcnB6?=
 =?utf-8?B?SFdVcEluMk9wMmlsMTlGVFIyU2VhSitmOEErcWVFVStGLzJvU25VQjFNYTNT?=
 =?utf-8?B?encyZXQyVjZWMzBjekduVTk3VWY5Q2JQbnUvdUkvdkRCKzVMc2hCOHVuaXV3?=
 =?utf-8?B?b1ZTOUp4dlpIb1JpOVZHUHNYaUtEcXZhOUxxcXNYZmx1UHkvWWFrNFdVWXlF?=
 =?utf-8?B?dnpDSC9Pb2EyN0pUMElBQ1ZydHQrTm9hVXFJSWVMSmhldjkwUnRCYkpBWjJE?=
 =?utf-8?B?a1U0amJTNkpnN05kcXo3NHc1Rm1tcGJpWnhrUGtHelZUNU9RNTdFU05RbVFh?=
 =?utf-8?B?dFhHQTNRbUtZZmRBVjZtRERCdWNieE5JVXlqZERCbGRnMnNXbWZhR3ZQUFhI?=
 =?utf-8?B?OE1xa3FMZnRKc2drYVV6dEdML3JQT2VpZS9qbE5FUVpaTGdDSEtJMVNuTVNv?=
 =?utf-8?B?dDdSTHJna0trSEFiWnh5aXVsODJYSzhESTArU2t2cTdtcUtNN0RQcUI2ZmdY?=
 =?utf-8?B?d0ZXNjFzVkd5YUwyT2R1ZmtzdEw4QTBTaURDRWkwbVkvazE0Yy9veGN1VFJ6?=
 =?utf-8?B?YURxV3pVenIxZHpzdkNWbUFJelh2RFZMYjkrQTVhQk9UQzUyVEFQdFBKNGxS?=
 =?utf-8?B?dHZJM0kxK3NiMkxzYUVDbGVXVHNRWVRtL2tjNUY5S09PeDV1QzBOMVlHT3o3?=
 =?utf-8?B?UUN6eFQxWGs4L256aU5ITHpaRXBVNXhrbGRLSXhoQ2JCWjRpb3E3Z2RQMlF3?=
 =?utf-8?B?cnFuaDlPWjJ4NGNvTk1jMVRubFZkdlExRXcxVTFUS3c4dWVDd0hlcVBVU1Zs?=
 =?utf-8?B?aFAxcFhRUGtPWmhnTkdjdjNPSGFWOTFEWEx3MmMxY2llSTNXUzh3TWVSRjhP?=
 =?utf-8?Q?dd39yUYmYJDjj/hU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca617ce-f985-401b-2d2a-08de729889b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 05:01:00.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOoWm2x1pPYP5mXiD/M7A9QUi7wWOyxfwL67aYZMY4Ool4/qspS4QWsh1Wwi2FQZUAgrGuz46uUYveOGFJ6xOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946


On 18/02/26 4:14 pm, Niklas Cassel wrote:
> On Tue, Feb 17, 2026 at 06:07:30PM -0500, Frank Li wrote:
>> On Tue, Feb 17, 2026 at 10:27:14PM +0100, Niklas Cassel wrote:
>>> Give reserved BARs a distinct error code, such that the pci_endpoint_test
>>> selftest will be able to skip test cases that are run against reserved
>>> BARs.
>>>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>> ---
>>>   drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
>>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index 74ab5b5b9011..7cffb6e77c4d 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -84,6 +84,12 @@
>>>   #define CAP_MSIX				BIT(2)
>>>   #define CAP_INTX				BIT(3)
>>>   #define CAP_SUBRANGE_MAPPING			BIT(4)
>>> +#define CAP_BAR0_RESERVED			BIT(5)
>>> +#define CAP_BAR1_RESERVED			BIT(6)
>>> +#define CAP_BAR2_RESERVED			BIT(7)
>>> +#define CAP_BAR3_RESERVED			BIT(8)
>>> +#define CAP_BAR4_RESERVED			BIT(9)
>>> +#define CAP_BAR5_RESERVED			BIT(10)
>>>
>>>   #define PCI_ENDPOINT_TEST_DB_BAR		0x34
>>>   #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
>>> @@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>>>   	return ret;
>>>   }
>>>
>>> +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
>>> +{
>>> +	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
>>> +		return true;
>>> +	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
>>> +		return true;
>>> +	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
>>> +		return true;
>>> +	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
>>> +		return true;
>>> +	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
>>> +		return true;
>>> +	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
>>> +		return true;
>>
>> return	test->ep_caps & BIT(bar + CAP_BAR0_RESERVED)
I think it should be
return !!(test->ep_caps & BIT(bar + CAP_BAR0_RESERVED))
> Sure, will use that in V2.
>
>
> Kind regards,
> Niklas
