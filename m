Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2F355813;
	Fri, 30 Jan 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793694; cv=fail; b=mCxfCXfLN0twsgyKrxU/J8XNtdzA2hBnqam5Rbi9wDFhr+bPaM48neq9PWa+lYca5Q2X0dLye/ekhzDfNwB2/gm5oGKB+yFsRDX/gvRpKBaSP2uslVnxDAiXUXmO4lcCNKDHvIv5/edC+9s2Bi+TW/CFnQPsTiac/amZZA4ydrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793694; c=relaxed/simple;
	bh=H4ojoODjC4Sog03DgJM4eHWM7gxnY5SNQYjEBTBrbuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FB8VXE/CiqG3lp5mn96Thd65EPYtfY/EzRwKMwWr6eBudh48OOQvJjdDMFz21AJXB1v8qI5fhJu5m3fsFVrYJpxd3eJesU2mbBwI44EQgWC/6PbUEgWZnOkbG+wTcfTKhLGx7m/5sksPTKdwhoqrqKAXgfFDdZpEc87hyQ5iotc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P27NSv2U; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P27NSv2U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdHP6LRiaw75Y/WCqfKlBzFsI6lJz4URvZTBpoWvdBIsq5XyephM1fqSoZb7hjTcN69/G809YWTdLRzC9ugVXEjCpkL1cpOB6YEEPzAd9GDox+iJHG+6Be3SHDRYjd/kJcL4ZJuvIRBizwf6w0Ur1+9O9NTG84D9L6Row7iYK/WEckzbtT6juyUwOF7eZRGtKla7qPHVpDDoXmw3SZgBJCs8xdboV/WpBZHivKB5OHzq5sVvOjpPWUf28el42ZU7Z7NfLsZcmAJvHxLh94UpVH2XZcFc9i3LNy52AZUzd8OpokYk+YeexnJKxA7Kz/WUeXjp4uE+z46VmpSWx93INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB+3/S+iB0E2/7jjUyHhSHxcbBlNI152yR5vEisncuc=;
 b=dKptJQc3Oqup5Qs+TxJJt75FwKfKjkIy/+k//mC9FgoR0HWyea/Zh1lemQhn2N1eTEN+lrKAj5AKnDlQpbDUFlN+HubQnkg6+kBHyZ1PSQVIExGQQHIKLBbPOsIOq1C6KldjQvLcvfByNNINMogavFchvxnmqZ8HMdOna5saksC2u7PthvtxzlKVSr0yFmvybB0bgfEIHugECUd9+OjemFHRs5qRqtNs/pajsUJMncUDnr6shxhZiyMczxQs3yLVoMpzl6BKQl8mCzTY3sgou/YtbdLS6yULzGHoWiD2grDDkNSvVvxwyqPg0+hya05ffWuEa6peqhQfxZ/KQgdm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB+3/S+iB0E2/7jjUyHhSHxcbBlNI152yR5vEisncuc=;
 b=P27NSv2UPGXIkQOTyOnsCfEyZa5gKaUhQOPVhwiSmcZXcP/qpoipHKlxiHCzp5oU1cFSFnuhJSpwpgE3WHSKsCVSLHjO7uEBDPmzF5+nuy5R7U+cCYKCELpWLz8ZmzY2XhFkvqAispJMWuSeGS4Ist8H+IuDTQKyjqHFCwKGU0i2IbgF+w7ZwLn/ivFyAI51T4Y+vqMl7hC6gdsiOsmPgLPzWKo7gNrVSMuIuvlM3Bgwud3I5cQbNCU9s8sr2LXYN9n9waxKkwpfWOO3Hm0+HApIEWqC6zvTKMLDygPp95CGf8sBSnXvbI5DRIe3oU4iQcY5SL3iY4HrfdpmzAfIfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 30 Jan
 2026 17:21:28 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 17:21:28 +0000
Message-ID: <a39410ec-4054-40eb-a687-0f161cffff2c@nvidia.com>
Date: Fri, 30 Jan 2026 17:21:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/22] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-5-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260126074519.3426742-5-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 101b2fe7-700b-4620-d578-08de60240097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm1SMDJNV1JCZTQ5TW9EWGZ5T0wzSk8rQUJyNDZzOGl5ck5TbENvMjNGVmxx?=
 =?utf-8?B?L2hYWjR2QXE5dXZ4UC9mOU5Tc0FiOEpVUEV2R29TSWh1ckJwZERnMWpGZ01u?=
 =?utf-8?B?S3k0YXVMZS80TkdKTVFSV1pjRHRhSzdnWFFzeTZuaDlmRmxTMHJ2Szh6c1h6?=
 =?utf-8?B?Qy91NXVvMDJjSitIZnJSbmZNcWxTRnNYdzNDd3JKUVpvWDd6cG9xcHlPVnN1?=
 =?utf-8?B?QVVnUWJrbStHanB2Mld4R1gvdGFPbnBtakFLVzZNS1AxRTdNWDRBYW9IOC9r?=
 =?utf-8?B?c0tOclRlRmxRWmUyd1ZvazZOUk1iaVdvVUNNbnpEbFFORU04ckVqTi9xdmtB?=
 =?utf-8?B?a3BVRXFtNkQwNDc4N0Y0bzdpY3dZazZoVXFWL2lsQjEyKzIyeGVrRFFFZDNa?=
 =?utf-8?B?cnRjdFdIQWdYQ2VVSU9ROGg3bXlmVmpFYUlUK095bWhEY1VFUTkrenE4TjFj?=
 =?utf-8?B?d3FMelFBbFJPcFlOcWlVREZiQjB0azk4K0JqWmtmZ0QyY3ZHSmt5VURGNGlm?=
 =?utf-8?B?dlNtMjN2RklpQWkydzdUREQzNEQzak40VHpqSDFESnNqMGh4TzF4eDlVZ1ZZ?=
 =?utf-8?B?QWYzYThlQkhnVzBCV1h4bmpwaG5PVldqTHExRUlGVFlPQXZZWjhXMUJYa2Fx?=
 =?utf-8?B?RHFKMDZ6Y3psSWdXMWVvbU41S05pdjl4bkoyTDF4MUJKK3puakxhbkpkVXBI?=
 =?utf-8?B?L3NqS0pXYkIrNFc3NW9EUS9JbjFEZ2wxRDE2SW92WGhnWVhqM3JpMWI0K3RL?=
 =?utf-8?B?MVBBUFFqakZ1a04zZzBGYnlpeDl5UG9Rend4SkV1SDhqeGZIRDR6ak5WRzI0?=
 =?utf-8?B?d3huTjBnVmJxOG9IVWlBQ2lJUTRYTG1DeWw2dWFuZnZnZmpvM2MwTzR6QWR5?=
 =?utf-8?B?VEp3WGxLWFJCeFIvVmVSL2x6bExXRGd5cERyeGFRaVJPcHNNeTJ5eDVrakhh?=
 =?utf-8?B?STJBSktWSnF6T1BSWlBZNFpjSWVqV0MzMTcrRS9yQTMzU1JaeVQzSEcwT0s2?=
 =?utf-8?B?M0hBQzZGcWsxSkxOTHdtbUJYaTU4aGY3WWJZdW44aW9KN2RlY3NZOTNsS1hu?=
 =?utf-8?B?K1BTbDhUaUtMZEthY2xXUTVJQ29WOHR6OUdxQ3NGR2EwTGU2Z1R1OFJ4aWMy?=
 =?utf-8?B?amFBc2lZL3hkT1pZMXk1ODFLb3pBMm1keEpxN21QanQ3Yk5NNGxmcXdsTW8v?=
 =?utf-8?B?c1BvNEt6Rk0xd3VKZ3Q1Q3J1MDdDKzZWTGxPcG9ldXFWaC9TS2xIMnFXWGRO?=
 =?utf-8?B?bE9Zcy9tRUVhclB4RS9WUkhMWXV2VUh3eUk2bzFPcDhzeUVFbWEvdEgrNDJn?=
 =?utf-8?B?eHA1ZjRyNThPZXNLREJIUm1ZQ0lQeXBPZUQ5WEpOcmUyT0lVOTF0T3ZuTE1S?=
 =?utf-8?B?SGRSMUFSUjRQeUtoUnlWVmhjcWllK0NIMGdWWkQ1bVdRU2NXSllkUW4yL2ZI?=
 =?utf-8?B?bnloT2tPNkJScW9CeHhZTDdqRnRyWnBDUzBlNUMrUVRZR0ZuQk9UYjg4QlBD?=
 =?utf-8?B?czZsdmxVdGx5TlhpWVRzMkZPMzhiSlZoaUdHK1lJNkJPSi9SS09zYnBYTFUz?=
 =?utf-8?B?ZG1MOTk3eHRzQ1lpd01tTk1URG80RkloVzdpd2J0WHU0b096ZlpqbDRmUGVJ?=
 =?utf-8?B?OXp6TkorY0dNdSs5d2RSU0JkdFVHM25za3ZDYWtSQlVWQ3hZemZ4bC9RQnR2?=
 =?utf-8?B?VWgyYzNzTFY4R1JZaCtHc29ZdmZlMWtUeFQ5cFgrTTI3RjExbk5xMHhUaXBJ?=
 =?utf-8?B?YUxreFBjTHV4ZERWdzdiVk85NVNuakVlbkJaWlhLUkg2UWRxditIYitKYk5q?=
 =?utf-8?B?ejBsTjg3SVR5QnRXdkY0MmFFb3FsWjZhcVNyODlyaEVWWVZZcmxLbXB4bjBM?=
 =?utf-8?B?RTM4K0x6YWxldThWV3NtSFE2K2JhTHJlQ0xad05UUHlKM0s2SHpaMUpQalpU?=
 =?utf-8?B?YVVaVTEvNVVmRml3cDZJSDk5RWhpR3pmb2p2aU1MNEM1NWhtMGxXcEtkeWpE?=
 =?utf-8?B?OEY3SExJeTFob3lGL0VrcWFnSHd0V2RNclNicDBmWFBBSXFIV0VIU2JBczd2?=
 =?utf-8?B?K3NERUpTdVVERmRvd1lhY0hMZ2JyQVpadEVwaE51Q1dzN21XUXFML21Bb3Ez?=
 =?utf-8?B?SVBBakQ1MFdac0cvSUxYV0J5MUZlVC9HWWJFRmtSNTFOUzF2TVRyUUJuRnNF?=
 =?utf-8?B?eUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEJKN0xIUGJUZXNKYU1Ta05Td1RjSDJZTjR6NDlRdzEzQ0o3cCsxZzYveDRH?=
 =?utf-8?B?bG5mdysxYnNvZEtkMzBoYXAvUkRmTW9HdWcrejY2bGU4T2EvT2t3Rms1a1l0?=
 =?utf-8?B?dXVCb09uMWVjbko5OVQvN2ZKS3J6K3VDR1lXZkYvTysrNFh3YzdWZURtc2RB?=
 =?utf-8?B?S1hOM2JKaHVGTmtkWDJaZ25MTFFNREl5MktQZTFiY1pON00veVJ2cWJxMnZu?=
 =?utf-8?B?Vk50aG5qb3VKTk9abW52VVdkQmM1Q0RFSkxOa3VhMVgwTXhtaEJ4V3FGVXBW?=
 =?utf-8?B?bDk5L2hQVlNJM2cxQWh5MUR2MWJCTHljVHRYeFZjNzRsZ2g3ZDY3K2lwL3lG?=
 =?utf-8?B?Z05JYXg1WXJCK1BBWjI2c2RDNzd1Y3JSdWxTbnVOUnpUOThhNS9tTENmSzVi?=
 =?utf-8?B?SGZFMTBDNFZBWEJUbm45NFZ0UUlRbHdhZkVDb3JXU2NFN2I1aTFDdEREY3dI?=
 =?utf-8?B?TlBVYU1id0FrZmx1L3hYN2xML2RlSjFUeHpkL3F1cWo1ZXZzRkp3OFhETnUw?=
 =?utf-8?B?ZjdjSjlodTJXOFArb3AxVG13eVRZdGYzOTc5RHVjNWhSV2JXRFBwdVE3SFVV?=
 =?utf-8?B?eWNDTHZRVDBOZHZ5bEQyUVR2eDZKMEZYQklIM1Q2S0U3OFByRHd2Z21JZHJD?=
 =?utf-8?B?Njd6bTRqK2lyZDRDblNDK0lvazJkRkhmYTI1MDRMNzJrREJQWTlPOWFKQUFZ?=
 =?utf-8?B?MEo2UnlzZDQxbjVabDlNWloxR21wcFBUTitaT25jbGtnT0NYRHZWZ0docjNT?=
 =?utf-8?B?YVdUdUNoMXJQTkpIY2JjYUp6cHJvcTRXWHpnYXk1U1k2Z0JCWGJjTXZRL3lW?=
 =?utf-8?B?Lys4d0dFdWxzQnExTUJleE1YWmV1K3BVMzFRbkFWUzh6VnJhQnNXcnpyWW1D?=
 =?utf-8?B?cklRZjBnY0NKRnhIbk1yWlcxWERlSmRndUJKZUI4NUVpQXg2T0svMlgrYVR5?=
 =?utf-8?B?c1l3NHFBcEVzemJ5N0w5enptbjJyeTJ2eThvMnhRUUdqUnBrdDdkd0xFWE1M?=
 =?utf-8?B?R0dhc014SVVYVU5kY0dSZFVIRlFXUDNBN01ZY2FhYWpmYng0Y1RQa010Mkhp?=
 =?utf-8?B?R0tOTnppcDZMR0tBRkJhWnZYQ0orYThLZ2RMZFl4bERueXFKNXh0VHI5T213?=
 =?utf-8?B?ZnZvRktNdWFZTFVGSTZWRmFVeS95dXI3eG9UVDgzcnpLQzF6OXVNNHVRRW5M?=
 =?utf-8?B?ZzhwUW1aaUMxTHlrQVU4RHlsNmZxTC9RZHJTSkFHUlRORVUveGhaNFlPaFU1?=
 =?utf-8?B?NWZKZVBOdjBpcDZuNmpSUmRNWitHd0Q2Sko5VS9oSGVJZXFhazUvMU42WWlo?=
 =?utf-8?B?UkRPVUtxNElkVk05bHhRVy9qMHl1VGtzYUFLOTdVb3VnaFMvUzhmZ3RSeWhq?=
 =?utf-8?B?K0ZCZWJaRlkwYWs1enZSeHJxdEJpcXN2Q0tmVEZhWnU0bXJLZnBiZWQzVVBa?=
 =?utf-8?B?VTV1Rk83aU03MWtBRDFTZWhxNURMeUFFMXdEUzlVdkhxTnNSOGJBWWtnd2pX?=
 =?utf-8?B?NGJFSXJ5ckQ4TmlXeUFHdklVSXlnVXpiNENyUTBCcmlQQndudmdkWTVLZ3lz?=
 =?utf-8?B?aGZUN3cvSHhsTGFqNjY3ZU42NzZWWVNEVGZTT2VhMmRmYWJxSGdWSTJtZWMv?=
 =?utf-8?B?NEhVWUpHUkhDMVZaeW8zRDd5d1pSdUR5K05DQkNjSG9jcTB5NC9pTzYvMHhq?=
 =?utf-8?B?QjlhQTZqZzNDaGJiZ3VqOHJGUzBJVyt3Ym5GSWlBSWRGZTdzMXZqNXJHanRD?=
 =?utf-8?B?THNtcVRBK2VoQW9VeWFqRWZnb1dzRHdtbkN4UTF1dXA0c1B4UHk2OHYxRk1s?=
 =?utf-8?B?U0NTbUlDK25qeENieUQzTlF6NHpDd1lZOVY0amlvbUhEeGQrTkNJR1Y5ZUht?=
 =?utf-8?B?VFBlendMNE9GaEFIL3o2eW96Z0wxNXdPTzVtbHluaXg2Vm9sdlE1MG44S2NT?=
 =?utf-8?B?L2ZOWm91azVEQ0tqV0Vlb0ZZR09iWjl5K2ZVMXRFbVdETXRweHVkZ24wQWp6?=
 =?utf-8?B?Y1VrMk42RlJiNVhDSkROWm5rdEhEb05Dam8vMWJmMmpJR3VHZWg0TjgwbGc0?=
 =?utf-8?B?dVRjYXVUemR1aUQ0Z2laTXV1bTRhWjhHanAxbDNqWGgyTXdlajBVYWxlb0F4?=
 =?utf-8?B?UGsxVmNXZDBvVEd4L0JVVnhCbndrUWxVUW1FUU1EamZHemltOUlGb3FXU3Bw?=
 =?utf-8?B?SVB0WmY0bnBWMi9Lc1NGS1J3dGpxYmoxaEtLUGdSeXdtRWxSc25mNytwU0hP?=
 =?utf-8?B?dnBzUDV1Y1g1SG5vUHZRVnJ3cG96TmtvbThOandKeDk0T05TSTQ2KzYyN05H?=
 =?utf-8?B?Q0ovTHF2d1RmaXpmd1dFTTREVjd2OEJFZ242NUNOV1hheURwMkhkc1JXZ0pY?=
 =?utf-8?Q?p0ksA8MXtVZGGHurZqNMz+3bmfjdT3HvqxG56b9V++vlm?=
X-MS-Exchange-AntiSpam-MessageData-1: pSfEVu7/8M8MRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101b2fe7-700b-4620-d578-08de60240097
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:21:28.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00yWOJcfZNbgppW/l3htOf3wXAzeDSqzHF0gGfcOIeyjD5xcxaFeZafV9YNbTS2ZhfSGyMIPw3wmA9nmpNVp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779



On 26/01/2026 07:45, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> PERST# and CLKREQ# pinctrl settings should be applied for both root port
> and endpoint mode. Move pinctrl_pm_select_default_state() function call
> from root port specific configuration function to probe().
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * None
> 
> V3:
> * None
> 
> V2:
> * None
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0b8c1a7ca232..04ff211deaea 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1645,12 +1645,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>   		goto fail_pm_get_sync;
>   	}
>   
> -	ret = pinctrl_pm_select_default_state(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
> -		goto fail_pm_get_sync;
> -	}
> -
>   	ret = tegra_pcie_init_controller(pcie);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to initialize controller: %d\n", ret);
> @@ -2106,6 +2100,19 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   	pp = &pci->pp;
>   	pp->num_vectors = MAX_MSI_IRQS;
>   
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret < 0) {
> +		const char *level = KERN_ERR;
> +
> +		if (ret == -EPROBE_DEFER)
> +			level = KERN_DEBUG;
> +
> +		dev_printk(level, dev,
> +			   "Failed to configure sideband pins: %d\n",
> +			   ret);

We can now use dev_err_probe() to handle the above and this becomes ...

  if (ret < 0)
         return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);

> +		return ret;
> +	}
> +
>   	ret = tegra_pcie_dw_parse_dt(pcie);
>   	if (ret < 0) {
>   		const char *level = KERN_ERR;

-- 
nvpublic

