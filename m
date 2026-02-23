Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2697080D
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822695; cv=fail; b=apSFAQ33GsaRoRSoyTCOOL5xHeHZO/7sJA/dJNkwT2IC++ALSnugGxwCr8MMYup+Ga+szqnUXL1flUcTRA10tpIagaiOIg1uzBQIsqwYNGd0lLwHQ9FadffQYOptjAq2S/bB19pl/kJLFyZ6hSio7PeC+JHUk1HPh2Jj3kvcGMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822695; c=relaxed/simple;
	bh=dB3Y1H0wPSIxa1FKBuYNmPhi5lba2jz7RZ4wZ4DUmo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l9sKReQflzZbZwsleAM3+JVSH69ykzvL6dLQAc70en6L2bJyLj52/uLqPuBVtfJhzqoWWmBrJbYbn1CM4TE/zibvt300Kq+ZH3aJqPfUrn4jpup3070d9nKK4c1BJVf7lBJTYodbrUtgp4lXsiPoLQXeiyn3676xUHRbwyZIL2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjM8TeBV; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjM8TeBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLDq3vVc6b6S804SFxNxSdL6UJ1dY8Yt+RnrWRB/nKjNfsx9HM+wqpwcPWOlhKmJYWSGRzaNe5ljliTCTYT4ys2mH/72ceePx9dE2tciz7Ni/esFMiVwKShM6aSNv4fayZqk308Eps5gs3JIt2JgWhXl+7XzlOntLyIiDTH8kDKR0I22QfKSiFoU82QVl6lYcCR4Zqt3b9RsdYSXUXMz4jjP0rbrh8+0C1xzJ0XzzvyBiMibmUxQ+oB5CIJ2wgvlFJJCV2kyWefCyxNWzU43jWFR1zhfNb67eZ+rrTyH/9011ULgVBqthPxSHKRsan8EGMu0Gzvd72G3m9NGTrs0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S59+jQ3S91Cf1r+YSlhk+tp08q5BjYm3Ol7FvVC0xrY=;
 b=SvCtT3W/bEU54Lfuw5DEoabxSEom6pcrgwmDeFZFUaLxCcB+85kTp6xPdLi/TKg13LBKd+QW9iGJoU6CPyb44jY/+SZIFnQ1yIg+xfAlX/dDe0qfi0BNQeaZhT1J+Qd+z8KlpoaWTGnckf+7MbyCYPALl1YUgEO3ZnRRojx5ZbbP5QtxX7s7yXFPnp7UB7Ym8B64c6KoFUT/srDZ3AOCBV0RWzlRH8eveooxeTloHVl2oMtkeN+e+NT1rRRfwWa2iDDIEAK3+OZml+56U7c1+KmyHzDzDR5sRhI5XJ1bW9F6krkQawXk2w6AVPv8fKpJUSPItIQg9Q4vBLpWNIJ6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S59+jQ3S91Cf1r+YSlhk+tp08q5BjYm3Ol7FvVC0xrY=;
 b=RjM8TeBVTM/Y0omNIWBKXEJ6YJwGGfUT9QNv9ImQLrD3c0e7n9pcweuLHiPScqvlN3Bweb+WwDc1b2gvsilq8ojdKclTDyLJ5MUih04zrNoTl/SiITTVekRoQQ+vkLbnh11Rw8tIzAN8tAKo6KL9xbImptxrSBmIXaQdWdd6D6XMg0IXctiLM02taXs6ZC0/gJVr/rqT2MkzHXvSytm7/b6Wym2ikKCBIufSo2YhbiM9xe4P4CmY46pjwEmXplQcv+UtPwoSu2D6ipUK51mTOlrSqHa3H8JtYorf0dqfrVweLgxpd7N/nY+nSia40sO0liEY2AwUCMn9ozDJWLh9sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 04:58:11 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 04:58:10 +0000
Message-ID: <617f1117-7a7c-4fff-a9ac-704dc078e2ec@nvidia.com>
Date: Mon, 23 Feb 2026 10:27:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
To: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Koichiro Den <den@valinux.co.jp>,
 Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
 <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810> <aZWXzzul8xRaDQgm@ryzen>
 <aZXiEWmNEdCfXse2@lizhi-Precision-Tower-5810> <aZbZTyrsrSgcX2Ly@ryzen>
 <aZdEcbN5bXoUS1Xu@lizhi-Precision-Tower-5810>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZdEcbN5bXoUS1Xu@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4940c39a-360a-4e50-7bcd-08de7298246e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkRYUGpURWFMOGRaejBUNnJ4S25pcXhKbHQzRE1ZUjc2VElnNGZ2U1Zhei81?=
 =?utf-8?B?dU1CT05oVFJTNE0yRDIwYlVMbWs2c1NOVzYvMTNJZ0FDOFVsTXg1MWFPQURS?=
 =?utf-8?B?cEpuL05ibUZYenFSQlB0QjU0VjBlM2Z6bTlFYjJjTmozUjJrYnhzR1p4TVls?=
 =?utf-8?B?ckhlS0t2cXkrWEZiZTEvN0VKYU4rcTU3TGxuSU9HSEVMTXQvZXF0NGpiUmRB?=
 =?utf-8?B?V2tqMXdXRGxrYmlPbWZzQXNGK01keEQxdE1ndW1hSTJyQy9BdFdBZU9xTW52?=
 =?utf-8?B?MkJkcUxLeEV6VkdsSjMzUDhySGxhMGN5cjhzVlZ6aXJUT0pLUFVqUFNtdmgv?=
 =?utf-8?B?bnZ3UTd2NXU2ZkprZjlHdVFIdjRUdmhrVE85SnBDaXdHR0xkR0lNdXBUQTRB?=
 =?utf-8?B?dDd0WW5FbzhNRmtORk85RkN2aHJsaWxIajhITTk0d1VPUzlRWG5XdnpuYVl5?=
 =?utf-8?B?cTBZc0hMYngzaGRTSkFOak51bm0zT2MySE5qSXRLQnZZR25mWjJjY3dvUjM4?=
 =?utf-8?B?ZVZOVUhGSUFhUEd3VWMwL2pBaEdFTTN3VzZ5OEJFNE5STDlaTDBPWDBhZGV3?=
 =?utf-8?B?SWpSbGw2MzRHSzQvSi8vWjBZMTRSVjNDaEVKZFNuaHo3ODRVQVBVdVRWTU9N?=
 =?utf-8?B?dC9UaWVYSG1ZV28vdnI5b1dXWUQyejQrc0NVZFdzdExQenBOSFFxOHN2RnQv?=
 =?utf-8?B?QlV3cUZjNVFVUUdDNE1xQ2d5UngwY0ROeldud2pCT2JkZHJGeTFES01ld2hi?=
 =?utf-8?B?QmFIaDZiUy90YzNmbm9KOWFiYXJFamNqVEFya0lzZTc1MFl4anloL04wVjBm?=
 =?utf-8?B?bHM5djQwQWhaSWx4ak1oTHp0TUZtaDNLQmpFSmFCQVFoclkxYWV0cExodXRr?=
 =?utf-8?B?dmpieklpdXNpMzROTkpYR2gvK2RKQVQzUlJ3L1dxbjltSnoranJ6R3BVaDR5?=
 =?utf-8?B?eFlERmR3QUwrUENaR2RHZU0wNGhtOE9lVVRkeVJCT0lrSGlPOFBJZUdRN3dW?=
 =?utf-8?B?T1lwT09qYjRoaTQybHcxTTl5WCtub05qNSttK2U0OU42cS9FOVdWK1hGUXFQ?=
 =?utf-8?B?ZEtnSHdKa1JWeXo4eVpOd3pRZW9wSWxYaHpaQmpLNXRhaW95S0g1dEtVZU1F?=
 =?utf-8?B?a0NtRUhEa1hzVHBaOWlXMUsxM2lkZmZMQUF0SmxBSEpMNGk4WGRTL3JYQjNI?=
 =?utf-8?B?YWxVRUJOcXdORlNvWXNZN1g1Y3ViZjhibzJjT3BuNjNQbU1oN0NtcVlMT1Qw?=
 =?utf-8?B?dXFIMURWUzdRM3JuOEZ5NHB4TWh5d05YNTVFcTI4ZER2VG5HQWE2d2hzaHVE?=
 =?utf-8?B?ZzNYNmRuYlBlQUFOOHhFblhyQ05wam9Qd0JhTnFwbytjNmFmWWEyK0dMQXJa?=
 =?utf-8?B?OFphRjBwTFovaEFydS8wN1c2NVlTWDNCWFc2TzNNM2c0WFhzQk50T3VWYzM1?=
 =?utf-8?B?ZFhEdUpNcFBORzVBSHRldjlGNWMxZFRoeE11bTJCREJsMFF5aDh3NjJ5cWI2?=
 =?utf-8?B?VlBKeEFLQnBkTkFWRGZHQWVkVEJQaHU1aVJ3dDBra01nMVR0Skl0TWY5TDFl?=
 =?utf-8?B?NGxRdURNUDlLUHd1YTRKQmFITm9CTk1US1NYUjl4K1RXdnpDWVYyVUJ0Yk1u?=
 =?utf-8?B?V001OTMrUTg1czBmYzZqaUlwVVZsaUZHMXhoWmsrcjhCcmhPcTB2STJJUloz?=
 =?utf-8?B?bXR4bHA0bmNyb1dmYkJqNDdldExKSHBtUG9jUVYwRFZOcTd6N1JHK3dKQkFy?=
 =?utf-8?B?THljWWRUYW5pcW1DemhEN1VJaHdJM3NUaGNRcmlRRWhVb3Y4VjM1Z0VjK1Bs?=
 =?utf-8?B?OEFacFRKamhaM0FSUGZiaTlMV29pUFZPT3BUbzh6QmVMd09DY0orVVRyTmdD?=
 =?utf-8?B?Y3lKd0thNGtOOUMyY3hJWitPb2FXTXZRejRseG9FNmlvdlc0TW1FRWQrb0w4?=
 =?utf-8?B?ZW5jQ1liUDJZOGN6Vi9PbmozQllSQ0xZUWlidXRqc2lZaUFOQ2p4cVQxVWhr?=
 =?utf-8?B?bVBBMVdlczVSbkNMSnRnMEVOUEJ5YTlFSitMUkJOK3NCM0NvdW03ZXQvM3Mz?=
 =?utf-8?B?QVd3NWpFM1B0aFFQdVIwREYwWXN6NWFJeVpaNkRJWTRmc3pjYkJIZlJselhr?=
 =?utf-8?Q?xt94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWEvVlZiM1VGWGFNY0Z5K1pjclBURldmUm14dXZaR1c5V1BRY01HWmJkSWFp?=
 =?utf-8?B?amFrN0EyTVZqVkwvaU0rczhCSW9CdFVXcUF3eXdtWnlTNXJaYlNVekY2dGdx?=
 =?utf-8?B?UEhveWc4dzFyck93TnBtU1ZNSGlTcmhnVWZkUnVzc3Z0ZWUxOXJvaWJZcVE1?=
 =?utf-8?B?Y05aRzAyaytyTVZBcGJqM2tVak1YSkhYbzdNZXQ2d2J1WXE2aXIxc0E2YW1s?=
 =?utf-8?B?WGsyVlFjRU1aT2JtRFFCemdHUkgwcUlIa2RvalhmWHZDeTA3WkI1MDdYVU03?=
 =?utf-8?B?YW5JWFZYdk00bjY5bGNZTzRqMnM2Z0hxaitkdzcwazFqN0dXZUV0K1liZk5q?=
 =?utf-8?B?ZGo1KzBUd0JSQmxVU2lSeDZBK2lGd2kzVDFVWHZtbktrSE95RmFrSXNGMDBz?=
 =?utf-8?B?Mm8wQ3h2UktVWmJrcG1hbnpyNWFkVit0SVVWc2JSclc2bzdVY0dxYlg3RFdz?=
 =?utf-8?B?OE43bjIyWXhTOXRlSEQ0blY3Ri9WbEpnWUdDSjQxdWoxWXpQd0lhWGx3Z1Zk?=
 =?utf-8?B?T3JNc1BaMmQ0WUFYMDZlQU9nTVJHOGhCeHp6TGNlazFuLzZadXB4N0U4RXlm?=
 =?utf-8?B?RUhCc3dRZTNuWHNxc3Y5WTJwdUhHazhuWkRFZ1M5Vld1dlB0TDhDaW5JSVBl?=
 =?utf-8?B?SWhmcnArc0w2YmwwLzJqS3R0Y3IySnVjQlNDSTlLL0VXM0g5ZTBHYTdwT3hs?=
 =?utf-8?B?aXZHOXh4dHdOVHZFSVRobTdJNmlIQTFjZ3FrRUlaanF1S29hbi9HVHZLOFpO?=
 =?utf-8?B?MzRZODJPZWlmK2xzRXk2MndRUzZidUdkMXpIcU9PazlRTVdUNmEyYnVlck5P?=
 =?utf-8?B?dGJuQ2twRmlYVWNqZEVCQjN5ZHloSm84enlzQkVsdWp2Z1k1WnpDWW1rN2pj?=
 =?utf-8?B?MFhvdC9ZbUNjV3VSMURJZTVDSFZhZFk5c0N2c3hsNnkvMUVuMitrTVJVN3dk?=
 =?utf-8?B?YnIrdE5RcW5ieEFLMWJHNk1Ob1BnMlVpcFQ0VGdYSFlTOW4wK2hYVFhheWpB?=
 =?utf-8?B?UnYzVjEvcmZRUUJEeVdVNlpHMmtaSmNGR29TUDMrSE9PWE5lNDU5ZmdLVEI3?=
 =?utf-8?B?WDhQRTFwM2Vxc3o1TTAvaDZyWWlLWk51dWZwMVlDSVRrTnBMcEJGQ0k1dHlM?=
 =?utf-8?B?U3Z4djFQS3NRM0xBNkgxeXBSczgrQyt4eitSd2VZQ2lLenk5anBxRmdib2tZ?=
 =?utf-8?B?UzhmTFYzV010QnJyVW9EMWpUbkhDLzdUMDZVN3VpMWlQdW92YUdHbTN1Z3Z4?=
 =?utf-8?B?Qll5ZE1wUlpkTWYzS1NUNzJpb1dWdnpZcWhBQTRRWXBob21hdGhZRkVEbjQz?=
 =?utf-8?B?TXpSOFlxdE5PMEIvcmM0UnJYRWFPeWNRcmVCd2VmbE5DZlNUZTFqZFVQK0VY?=
 =?utf-8?B?OENSN1g2WFM2S2E1V3BkSHQwa2QyUll0bFhHMkNWZEJsZDFRK2VDeG5YL082?=
 =?utf-8?B?bmt2ZTZQbWhvd2MwYVduak5CbmdBb0VoQUFzejVSZUQ3OEZtcGZxbHROZWNK?=
 =?utf-8?B?SUtySHplWE5BL0xmelJtL0cxeURZaFYzT0hJMEx5SGtrKzFSaER5cVBvY2RI?=
 =?utf-8?B?SFlyamIwdkJwZENXRG5ubTBRbGxkTHFrbjZJdklnWWlTYXNzQ3hxVGJpc3ky?=
 =?utf-8?B?V2dzUVFvZ2VQdjdvcmNjTGY0VENIUVVyaFB1VVVkZm81L1NnREltTkp0NTk5?=
 =?utf-8?B?VzJ6cm4rNWFyU1JQcGRXbjgxTk9sRVkvYndnNHIzY2pGeTN3QWRsODFIOVVV?=
 =?utf-8?B?NTNLK29RRVlRbjk5UFZZVW90N0IycXN2RDJHTFF1MHBpR0hsRXF1ci9MemY0?=
 =?utf-8?B?b1RUUHdKbmdiZ0V2MWw4L1NGYjFaV3ovcHB2NjVxL2VLNTRoejQxNFJRVEs0?=
 =?utf-8?B?N053dFI4SmVEYTdTV0N0WXZIeUpIckU3OU1PTHZPdVRicGxnV0M0aXhiVVJR?=
 =?utf-8?B?MDlXVktMVVlYRWRUOXBZVjNQUk4xNkRvb3VKVVcyWW5GenB1dmZ3cjVnekJE?=
 =?utf-8?B?VkpVNGI3NWVtMUg3bGY1VmpCVDFreGJpd05SeHdoVWZiTktmUTV0ZjN3aTJl?=
 =?utf-8?B?WUhJbm9uZXpLVVlOTnBvM2R4ODg0cm1TbGVHZ0Q3elIrQmJXdDNJZlJkenAx?=
 =?utf-8?B?Y2JIOTcweE1WaWtKWktyeDI0S2NIL0NSb25RSG9waGEyN2NWbEhjLzRqdUx3?=
 =?utf-8?B?UlQ3Nm9JK2ZsZkZxcStEUkszeGZOa2tXSTQ1S0ZOQ0NYb085YU1CWUw5eElm?=
 =?utf-8?B?Q25TdkpyYjREMnZMU3RRdTJhZm9zbmt2cXFvNmlnREdNN1BCQjVINlM3WExt?=
 =?utf-8?B?SGRtMlM4Vm15aTUwT3NpZ25jYkUrenh4WUg4Q1pGem9VN3JqNFZXZ1htZ1JF?=
 =?utf-8?Q?LS8FzB8g5KUyNDtM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4940c39a-360a-4e50-7bcd-08de7298246e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 04:58:10.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I70ZQbJ7vSZ8DzMMRXslxcBwS8QrwvcmzFm+mjZ+bQqHynUwggZUzSbXCOc+r20ftMAj6BRKWXOmDlVDURhTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>


On 19/02/26 10:42 pm, Frank Li wrote:
> On Thu, Feb 19, 2026 at 10:35:55AM +0100, Niklas Cassel wrote:
>> On Wed, Feb 18, 2026 at 11:00:17AM -0500, Frank Li wrote:
>>>> Thus, we need to tell pci_endpoint_test that these reserved BARs (which are
>>>> not disabled) has to be skipped, because if we perfrom READ/WRITE tests
>>>> against these BARs, bad things will happen. E.g. if you write to a BAR that
>>>> exposes iATU registers, you will clear/overwrite the current inbound addresss
>>>> translation configured by the endpoint.
>>> I see. it actually means skip bar test. is CAP_SKIP_BAR<n>_TEST better?
>> Yes, for pci-epf-test, a reserved BAR should be skipped, but not only for
>> the BAR<n>_TEST cases, it should also ignore the BAR in the consecutive
>> BAR test.
>>
>> Everywhere in drivers/pci/endpoint, a reserved BAR is a BAR with fixed
>> MMIO registers (to e.g. eDMA registers, MSI-X table, iATU registers).
>>
>> E.g. the code for the consecutive BAR test in
>> drivers/misc/pci_endpoint_test.c is:
>>
>> @@ -403,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>>
>>   	/* Write all BARs in order (without reading). */
>>   	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>> -		if (test->bar[bar])
>> +		if (test->bar[bar] && !bar_is_reserved(test, bar))
>>   			pci_endpoint_test_bars_write_bar(test, bar);
>>
>>   	/*
>>
>>
>> It seems quite clear that pci-epf-test should skip a reserved BAR.
>>
>> I see your point, but I'm leaning towards that that it is better if we use
>> the same terminology everywhere.
>> I'm worried that introducing another terminology (SKIP BAR), might lead to
>> more confusion than clarity (we already have RESERVED BARs and DISABLED BARs
>> as enum values in pci_epc_bar_type).
>>
>>
>> So, while SKIP BAR might be slightly more descriptive for pci-epf-test,
>> I worry that that using a third term, will cause more harm than good.
> Okay, RESERVED and DISABLED is epf/epc concept to inidcate hardware cap.
>
> pci_endpoint_test is just one usage, skip test RESERVED bar. I am fine
> using RESERVED here.
>
> Frank
>
>>
>> Kind regards,
>> Niklas
