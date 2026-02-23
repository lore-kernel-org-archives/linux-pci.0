Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61983280CD2;
	Mon, 23 Feb 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855855; cv=fail; b=pSaV81UR297iG6I+GK+Ffx5xt0BRgOujadWBHAyE+s7UrEKDL7sLJ6cSLERHMNSoOn00IxousCcZi8kR71gH5ppTXlClE+6jMH1nuOsrjq6WHANpLAUrda3ac8cwVnXP8dPyjXnAAwS5exv2c+n1FDqIno+ZRthokjGrvJaTtQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855855; c=relaxed/simple;
	bh=smb0kO+BowLN5lTnqxa87Ku5WUUpGA48z5OlaRrzN38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I4V0co+7j4oK0UQ6/Xye/W9JEBBPYfucv+WjpTVwLXqNU9bpHxgVFEqlQyTVU5jf5I9R3TjVkqyTK6sd6y/brRrZFQmFWxWqTRfBxjEpH2KaKYhBfiOzlKQpcEEwusiKSYzCGYUTdWtELYm75IDlvOqAWs1YjnDlFsEfpBxk+K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uTxeESpe; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uTxeESpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lROq2hvVjg14PB8FBoRElUs2atxVAdS6H5scTo40l6fSilflUdyFZU1e0+epNaiTGVcdagt2Ez4hB6n70EhhMz54wOUwdsDNPcI29seMA2Jfo/40gEcMhMMPoy7YlZL9YYTb+joVNLp8WMo5svz8AaqFwTLDsHt+rhALr7G6rs4bDeyKMyLkBfvxhW8w1nF3iUh/fWnCP+oN7mgxhxBJ3Af8cNT8G7F28uPMbdzQIaAMFOIxyeKM6YqzUfCMOFZAfnKICHVUBPP2KgvjBbnE1mKXIAgnobqIwLGymTVvLU5wsuE9lbnfKCelsyqkrQvZ6jejZZcdmS+bi6C0dxK3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LEl+kiLgtOHV5ZgXmnOHVZzuqGCRp66BXoWihm4FWc=;
 b=H1OxwzCTAzDpMm4IZIdAuVSPVDW5FQ8QW7KHZPowRG6esdQlZumws1aLTdyOa5+XUn9oyxTCe0Y1tw+7PqtCTCJaXoSwN6q498XQ2QCDcm4wHghbZehZrcxxF07bZKUxw/0swv8sR/VCara6BJjlXX9IqujbE36oIGbS90Tnrwi+2R0yv38aB/sxIKbcYpz896qfc/wFJXPlpVPDhJhyz32OQt3qqu6ult/ndo39rrYzAgrYhYoYKt6cLWs3zeB/vFsf+HpKBOQuyuUgphi3LSC/Fobie9xuY4x2RI/ZhHfvWiACq4tAwEWoOhw0+tI5z6ONl0uUq6rOQH08ah9Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LEl+kiLgtOHV5ZgXmnOHVZzuqGCRp66BXoWihm4FWc=;
 b=uTxeESpe2e/ouC8+HJW9Irf20oNfdE5+SFARu2ZSngnsQTc1XL1jhJxqZ78IeCjzSeZWkxkizfrxpFTdUfi3cawb8+/0MGOWEBU9Ht/WY1xaAF8OKIGbEV4y1Xw3cZZvn244vqhSMQMF84mlw63jHXajKfUCk4SkP81os86rQC2eqXPvMw6AT03H49iPwlpV1gHyvkaxeddXd5G4t5GO4GmkV8senCfNQADEFIE5FmnPFPxvebijHxdtknuyFeg3NtCuakxtUB01xR2tqnWCKupmui7yr+VXI8pqB66H2fe3XDgVzMGhW34GCB/Eb2i7CG2ftXwcxqFjDoBW8Gh9ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:10:46 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 14:10:40 +0000
Message-ID: <0cd079ce-b658-4058-9d75-0e79987611de@nvidia.com>
Date: Mon, 23 Feb 2026 15:10:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Benjamin Block <bblock@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20260203004810.GA14073@bhelgaas>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260203004810.GA14073@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f721d8d-9a01-4cd9-5afa-08de72e55343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkFMUlozZ01QNVZweFVsY3JMaW4wUmR0aUhEUUd2Tm9ER2RMV25kd2V6UWpy?=
 =?utf-8?B?c2JNaGlpdjI2Vko0V2NTRlNubE43aW1rT2crYVZsYjRCaEswSGd1alRsd0FJ?=
 =?utf-8?B?NitzMy81UW1ZSWE4T2s4ZklxL2hWcnBXTDFOdnZ5M2xhTzJKQmlIZ1JEa0ZV?=
 =?utf-8?B?K0dSQ3FKcFNLVWovdTN2blBIbllhdU1hMnJWRzdpSEVIYWl0NFIveG9USGc0?=
 =?utf-8?B?SnNKWGZZMDQra0hHeDFkWnRKNEZSR0dhSktjWndySFBZNFlRTXFpTTIyRVpI?=
 =?utf-8?B?L2VqWGRzSFpJM1RQQW5HaGtqenVNYUtSZGlyR0JNSFFOa3JsZXBFUW5JbFJy?=
 =?utf-8?B?NGJQUTJDc3RSck8weDJ6SXdhTDdlNWZScWRjcjlyMSswRnY4ZkNFY1IyY1ZT?=
 =?utf-8?B?bU9NVUU1MldpTzNRMnB5WkRVR3BNSzhiN01EbjF1ckNueFNXWlRGVi9XaDdt?=
 =?utf-8?B?UlZ6b2lPS3kzRVppYS9mQkdFTEFUVFRLZXRjWThCcGpZRmZMK2NTUXRTelJZ?=
 =?utf-8?B?RFRTUVNuTzNEeXB0ZnlValBoRDU4SVl0Vm9EbDJGekRza2Jxc091a3hnUTJD?=
 =?utf-8?B?bS8rdFVDR0VkSW9jVGR6N3RobnBBcTRVL09OajdlNUEyaVdrVG5XcncrS2du?=
 =?utf-8?B?UnJsZitBcmVzNm1vRVVWRm5ZT0ZnZ3pCbThlaEJGSStpTzJRVUc1NStXZnBD?=
 =?utf-8?B?VDF0WjA4MEJNZ0RKQkZWTXBJSFlld2ZMcEZQSCtsblNmOTF0WHFyN1diM051?=
 =?utf-8?B?NEx3dWRPb0I4VWJxSUY3R3BvRER6amtmTElyMzE2YmlOTHRoOVZ3TFA0SVZh?=
 =?utf-8?B?VllSeEZOWGl3MzNRUVhoQTlLK1pDNjVueTJuQmRtODlyVHF6WGxUNFdOYmtP?=
 =?utf-8?B?Y1RzS3AzSlU3eXYyVkhFNVF6OWJ3RVpsR0pGa3piWDdDYlNnejlvdVl0ZkJu?=
 =?utf-8?B?SWxQc3AxZnF5WGVINU9udE16OHJYQVZmT1pUa3lKdTIzNlg3RzdvN05jYXV6?=
 =?utf-8?B?c2ZnMWFzOEE4cndsNlMyVFJSemRrRmk3YjdpU2x0dlBaRHZZcG05czZVZ2JC?=
 =?utf-8?B?UWVTUTJRTWhCMXA0OWJtMGlkdUtyUWUzNVl1dHl1ZFVNOHlxQ3ZXSGNDZkVj?=
 =?utf-8?B?ZnMwajJlN0thTStobHVLOEZKbm1udXdWM1BmMUM4VStjNTV5MWtQdnJhUDlQ?=
 =?utf-8?B?Zno1V1dScjJDYzdYalpDeGgrR0NpTXVyZjlKNVhvVG1LNC9rb0dkZU9wZ0Ja?=
 =?utf-8?B?QVZaL05nb3cyZDNSa1FDYlNTUkVXT1JVc3Q4WWlTSHUwNTJXSFg2TkQ4LzZw?=
 =?utf-8?B?TE1PZ0FkWkpyb0dPdGNKb1ZEczNZdkxqZG1vRGFyOUIzS29oOTBGMk9NRnYw?=
 =?utf-8?B?UWtFRDBKNTRrYkZZaER2OHo0N1QwbC9Fd1dFeUtRZEIvcHpPUWZCbm80K2ZP?=
 =?utf-8?B?MUVaM0JUWDRCYTVWaDdCZWxudjBNd3JOa3RubkpZeldzSnJOZEF1VlBXNkJ3?=
 =?utf-8?B?QTFMYlNCMEdQNTJXajBHQmdJeHlLaVFLcklwQWtUbkFVUEFzTjFoNFVObDFJ?=
 =?utf-8?B?V1dCN3pEczlGK3h0WVhGaXdtbHd5THhvS0pHYlpuNU1yNDJRREVtc3NyNm80?=
 =?utf-8?B?YmFKWkE5VUx3Z2ZmSEpLUXMva01ZQ0NneVN2azJLM1YvNmtVMk15anRyVWpy?=
 =?utf-8?B?V2dRampFZUY5QnRRL3NVSjJzckI3Q1daWVpuMXBuQ1dEMjNtN1VzMlpncWZt?=
 =?utf-8?B?MlgzMHkzQW9JaTF3WkI2QUZrSkxZY2MrL3hhYVFVMHF0eDBBaFhKYTJESGw5?=
 =?utf-8?B?RS9KU25YTUJWbVRBY2lqVjNYTWllcmFFWXZLVnhaVG5jWldXR2FCZ1o1ZjFp?=
 =?utf-8?B?NnpUdEJ1aGtudVdmQnhqMWtuTy9BZUh1Q3h3dCtPYXliNm0va3NWNWJucXBT?=
 =?utf-8?B?T2EzbjNLQ0ViOEt6Ukk1N1NycTluTk5CdjAxbllld2tRSkFhRHdQMUhNV2hT?=
 =?utf-8?B?L0FWZWlXdllSUk5hVXUzZ0pQcm0rODdJT0tsem1ZRWdsaTRla1Z5TUUwMGVy?=
 =?utf-8?B?aDJHRmdWR2VaNi84VVp2YTQ4U0xTNnYyTkNIUksxMmM3K0VmWWhkNTZlVm1U?=
 =?utf-8?Q?sb1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0VJR2k1OUNrdkhrWGRMa29vd0NVMlp0L2lhZDBaZUhOemMzT0FsU0lUZHFQ?=
 =?utf-8?B?WlBKVHBCbkFkN3JYbDVjaktJOStvTk9abTZaR3NxTHViK2FPVFRFYjJ3UlI0?=
 =?utf-8?B?b0dDaW1VMnZ2RStJWTR5K1B4ekRxaThqOG80dnVxeWVqRFhqdGdxdngyS1Fn?=
 =?utf-8?B?N0Qrb3hhY1BMcEx2V2ozYU5TeDZ2N3k4MHY2dStUbUZtZ1BsMHdXMWN6WGMw?=
 =?utf-8?B?LzhkZEZhMktDSDBnTHhQY3g0MHJLaTk5MEI5c2FYaW9PQW03UlgvOFVBM3px?=
 =?utf-8?B?SGhKZEFLNjYvUkllMVFQUkJDcUhHUkFYWnRNTmpEc0d1Q0hsVGRZQWlTbGJZ?=
 =?utf-8?B?TjNuZnd2blBXcWJPNHo0VUhLNkVIVXBnNWdlb25odGVIakJINTBKc3BlRnFO?=
 =?utf-8?B?R1ErMGFkazlqNGdlTTVEV1FUdzZYaEg3Mms3QXBWY2FtQ0lCOUJDYVpMbnMx?=
 =?utf-8?B?dmdDTFJJN2J0N0FLeFdyVGlTWWFtaUxjU0ZNMFpsT1VGUFMveGx6SlZrNVJh?=
 =?utf-8?B?VkxlbWRROWxXc0tvOElKM0hkTzQ0ZTJyVlRGSEhxSkpCOHJxcEpjdVQvckdk?=
 =?utf-8?B?WW8xS0p0akhjUnRWc09oMHN6UXhKRmptcUFEMFdIemttNWhnSHBvMFAxcXc2?=
 =?utf-8?B?am5Mdmh2Q2xkeHRiN3dhOEQwSlFXZW1PblljUDFyNkNmRU5heVFGY0RWOElj?=
 =?utf-8?B?RGllQ3M2aG1OLzIwaW0yZm4ydVJJQndXUXZEWWJaQ2VBYTg1SGg0cExseTZk?=
 =?utf-8?B?ODVEMVFLK0hlWi9BN0pJclpENjl1aFdEVlg3bmRRRUI3bjdkL2d3bXVzdDRj?=
 =?utf-8?B?emtaOXdicXQ4ZFMvaWpGTTJrWDJudjM3WXFuM0FMeUdMMjllRXp2ZU9CYlBG?=
 =?utf-8?B?VFhOMFFPY1FoMnZVOXQ2bzhGeno3cVU5QUx5TVBRQUhmcWZ5WHVLb2lxUVBK?=
 =?utf-8?B?bUNwdkFwNUc4VHVuT1VlUlZEYlgzUVg0MU8rYjFyTDY3TFVUM3g2Q2xkYnYr?=
 =?utf-8?B?NzBGdFRHYW1uRmVNTEVFNW1CVFptcUhUdlB5bVFiOU5FVHRkeUVobnl5WkpT?=
 =?utf-8?B?bExrMmZnSTdWWXQybzJZK3ZwZnppdlpySGl6MTd3VHZoODhpZWZpNVAya3dC?=
 =?utf-8?B?Z2tqNVRhMk9TZ2dENFVDa01mbWlaNTU2aStZc0lsUWpZZnY2K3hMSmY5eGVt?=
 =?utf-8?B?NGdpOGJBSmZKbWhGNjlzRjBKbU9JQUVHaDBOWnV1NlJ3YVNkMHFFU2VCNGRX?=
 =?utf-8?B?T2lxOGpiaTF1OGgrVmxzZTgrZ2hTUHdaYnZFM01BTkc1aU9jWkRwTWVveUpo?=
 =?utf-8?B?dGpqV2ovUkY0em5YTDd1K2tVbzh2TDhQd05OUnR3aXFuQ1R5NThHTnRPY3pB?=
 =?utf-8?B?dkhzaWplL1lybThYc0hwR1R1Q1pMUWFyclhHMUZ2Z1JsdDdNWTJ3VmlaMXU2?=
 =?utf-8?B?M3ZSRllraG9QMWRuQ1lYMDZoY1Mxc1lJWGhQT3dzb2lDdDBtTUtRRGtsVmJv?=
 =?utf-8?B?M2tsbncwUmFBM3RCa1VobnVjRS9lTktmRERiTC8wNEhLUHpBbVFvdDV0U1Nw?=
 =?utf-8?B?SEFudmtUSEU3ME02ME45ZGl1ZUNwaGc3clZWTFFEZkRpWXFQUWd4ZFRYRm1o?=
 =?utf-8?B?ZmlYblFCM29XTWxDQUxtREtoUy9ZVUdRNEkxcHlrR1prNXJvRkl1YVBTNHo1?=
 =?utf-8?B?bGM4Wjl6Y1BhOVBwZzJPdnc0c3NWZzJRaElmM2pJMTVDT2k3YU5GMGg2Rnk5?=
 =?utf-8?B?akRrb2NPYUc1SlI0VVFjT3ZncUFZTEJDRmh0STNQa20xLzFqd25UWWdtc2RN?=
 =?utf-8?B?UEpUTktIRnllWHN2VkNHTGN4Rm0zYlNVTTlLTWZlNVRoZ2dKZ0VLRFNvWHFl?=
 =?utf-8?B?MktVM25WMFQ2YTBsd1VWbEFZQys4WVVqbFNEdTNQSFpLZjYwb0hUbFdLTnVC?=
 =?utf-8?B?K0FTUEV6cUp5c1lSNEpzelBqZXl1SEVrNnRKYVpoZlpXMk5SR3M1YmdsaG5p?=
 =?utf-8?B?VE9MakdlVGsvVENUQWcyU3pkQk1Temk3UU4xc0hFL2RQTTVvQzNjN2dRSG9H?=
 =?utf-8?B?TXZ2c3d1eU5lYVR0UkhLRWtndE9DeFh0MXlRYTZ5Wlk1dzQyL1Y5QjJMaXF1?=
 =?utf-8?B?QkVRNWZmM0IveDV4WS9GTGcyWHhTa0E5YzlEQW9lU2lYZk1kTkFFVy85L3Q3?=
 =?utf-8?B?VDZKQk1KY3JPcWJBY0lWZzBzZHpSUkFPYjZLMUhCYWcvOC9CK0dnWVlQWkE3?=
 =?utf-8?B?SlhGV0I2d1h3NnhPSDBmSzcxUDE3Zld0bXQ1eXNRV0JkRFNpalpldndqRy9w?=
 =?utf-8?B?MXZVVWtBRjlzQUpZSXRXUWI3OHBSbWZSSVdPcXNPNHhuY2EvY2ZEUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f721d8d-9a01-4cd9-5afa-08de72e55343
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:10:40.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruMkPaoS62+S5cAfHD8g4374Q28/J6/V8rDFFw4ifcywRZmgMUTi9VKqDMWBbp/QYC9mmq1ZUYxJ6Gk2UmtWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

Hi Niklas,

On 03.02.26 01:48, Bjorn Helgaas wrote:
> On Tue, Dec 16, 2025 at 11:14:01PM +0100, Niklas Schnelle wrote:
>> Hi Bjorn,
>>
>> Doing additional testing for a distribution backport of commit
>> 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
>> enabling/disabling SR-IOV") Benjamin found a hang with s390's
>> recover attribute. Further investigation showed this to be a deadlock by
>> recursively trying to take pci_rescan_remove lock when removing a PF
>> with enabled SR-IOV.
>>
>> The issue can be reproduced on both s390 and x86_64 with:
>>
>>     $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
>>     $ echo 1 > /sys/bus/pci/devices/<pf>/remove
>>
>> As this seems worse than the original, hard to hit, race fixed by the
>> cited commit I think we first want to revert the broken fix.
>>
>> Following that patch 2 attempts to fix the original issue by taking the
>> PCI rescan/remove lock directly before calling into the driver's
>> sriov_configure() callback enforcing the rule that this should only
>> be called with the pci_rescan_remove_lock held.
>>
>> Thanks,
>> Niklas
>>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>> Changes in v3:
>> - Rebased on v6.19-rc1, also verified issue is still there and the fix
>>   still works
>> - Added more of the lockdep splat for better context
>> - Link to v2: https://lore.kernel.org/r/20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com
>>
>> Changes in v2:
>> - Collected R-b from Benjamin
>> - Link to v1: https://lore.kernel.org/r/20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com
>>
>> ---
>> Niklas Schnelle (2):
>>       Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"
>>       PCI/IOV: Fix race between SR-IOV enable/disable and hotplug
>>
>>  drivers/pci/iov.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> ---
>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
>> change-id: 20251029-revert_sriov_lock-aef4557f360f
> 
> Applied to pci/iov for v6.20, thanks!

After pulling in these commits in our internal tree we can see the
lockdep splat from below in many internal tests. We are still trying to
find an easy repro for this. We had to internally revert both of them.

I noticed some similar discussion in another thread [1] but there it
seems that these changes are actually fixing the issue which is not
the case for us.

------------[ cut here ]------------
WARNING: drivers/pci/remove.c:130 at pci_stop_and_remove_bus_device+0x39/0x40, CPU#2: modprobe/12956
Modules linked in: mlx5_core(-) act_tunnel_key vxlan dummy act_mirred act_gact cls_flower act_police act_ct nf_flow_table [...]
CPU: 2 UID: 0 PID: 12956 Comm: modprobe Not tainted 6.19.0net_next_e834b5e #1 PREEMPT 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:pci_stop_and_remove_bus_device+0x39/0x40
Code: [...]
RSP: 0018:ffff888164c9fd10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888188ff2000 RCX: 0000000000000001
RDX: 0000000000000046 RSI: ffffffff8307e068 RDI: ffff88816bf4c9c0
RBP: ffff888188ff2000 R08: 00000000000000f4 R09: ffff88816bf4c080
R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
R13: ffff888164c9fd27 R14: 0000000000000002 R15: 0000000000000000
FS:  00007f52364bd740(0000) GS:ffff8885a9019000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005622dbf749d8 CR3: 0000000169132004 CR4: 0000000000372eb0
Call Trace:
 <TASK>
 pci_iov_remove_virtfn+0xbd/0x120
 sriov_disable+0x30/0xe0
 mlx5_sriov_disable+0x50/0xa0 [mlx5_core]
 remove_one+0x68/0xe0 [mlx5_core]
 pci_device_remove+0x39/0xa0
 device_release_driver_internal+0x1e4/0x240
 driver_detach+0x47/0x90
 bus_remove_driver+0x84/0x110
 pci_unregister_driver+0x3b/0x90
 mlx5_cleanup+0x13/0x40 [mlx5_core]
 __x64_sys_delete_module+0x16f/0x290
 ? kmem_cache_free+0x221/0x520
 do_syscall_64+0xa8/0x13f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f5235f2c3fb
Code: [...]
RSP: 002b:00007ffc6ba11518 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 00005558c4278f30 RCX: 00007f5235f2c3fb
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005558c4278f98
RBP: 00007ffc6ba11540 R08: 1999999999999999 R09: 0000000000000000
R10: 00007f5235fa5fe0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc6ba11570 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
irq event stamp: 44859
hardirqs last  enabled at (44869): [<ffffffff814af7ca>] __up_console_sem+0x5a/0x70
hardirqs last disabled at (44878): [<ffffffff814af7af>] __up_console_sem+0x3f/0x70
softirqs last  enabled at (44844): [<ffffffff81430312>] irq_exit_rcu+0x82/0xe0
softirqs last disabled at (44821): [<ffffffff81430312>] irq_exit_rcu+0x82/0xe0
---[ end trace 0000000000000000 ]---

[1] https://lore.kernel.org/all/20260222112904.171858-1-ionut.nechita@windriver.com/

Thanks,
Dragos
