Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214451;
	b=0/wRi+kOb1BNIJIdb3ju3zYDPMrvlXMDaVvBqGlKWHY0owt+7bQLRpBk609LRRTMAUJl
	 3TP4Rl58iGaOh+qMGg2yIV8NrcXYgnrx1+9+rEbJYYay266E6pXSkILOZzz2XVZ31mONk
	 B26NGPLfD0FGMOMVngqk+Rbz6fBA2+0hUWfbqMzIDMivb/UGbOJXKXnyfTGmYGdwiG5Pt
	 j6x0EKlEnBesXUg0k489mSbs2xmYpUYZ71ZOSPzK8u7PjLwLJFflculqG7YJcJnVZ5DkC
	 vVXS4FwwAM1DUeEBot50L0UeXrevi+i57z5yo/Zq1WpoUbiCgnV3l8pcDqof6JYQ0KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214451;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gI7KB0RIjGl1hdTE3IJAiypZ+0pAl8bUXPk4LbTbksg=;
	b=oq0jOxFlAvTN0KWgJFsN54xQ+1tsBx5xmKTOG9cK5cf0O7rVfP7e9fmWNDZ7lXeAuTXS
	 dRf+UJe5NNJV2VCaSCKTfablOGVsfP9+7LL+pCW8sxs5wrL2lLG6ixM0SS5MNY4PfK9zV
	 Elc+efGnaCcGOb4tvU9GR4MEFSYgYTdNMBn5cjhn/aBdBrl4WklG8UZzt4aJimc0QIO9y
	 sIAAG1daU9WZ9DgqsAryEqhaivNBRffuDQzp6xkjPEZ918QSYJ0FcYLEZ5eph6VA3G2Mn
	 fK2YGMkJtMFgdONaIYvsxoI7nsJ2yKJFRFkqMSzvbdtLuVOljj4i9zNHO6sXVlMxM0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NflxdCMg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FD606BFB0;
	Wed, 28 Oct 2026 19:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275FD606BFB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NflxdCMg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXPuN2x5Ec7JMVTXtZ6mYHYjek5epQkeWbR1u0Krlwh/yU7ACstsSscoC7B9EMFYEW80R+gavOJbL8mzJriaPRTepak4Tgm0pWvEud3jUFW60URs79Jz9r/qxG9d651bQne0P3ux1WkhgSZCOatpQ1EYga1ZGVY9VPqx66lCBdI97MsUcXd1vdK4d/g0wee1nPjdVqRrVkV3nmJfM2YRKxwxxh2Mcu6BBXHKtSuxbP+zz+Z9rDCOjbpa3EaFrL8e1YKgFzEvSjXhPrXb9xH65zvkbCD7Zp9jx5eJWvcfjZVqZFItpdF2wVPqxpDay//n4Aja6jM7toCSyKZ1iCXHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI7KB0RIjGl1hdTE3IJAiypZ+0pAl8bUXPk4LbTbksg=;
 b=v639nn70ONvRbMZw7BBArZon9u/zzCVIk0yKb8wdARkbhT3mvHpra/nJ/1w14b3mhdmpZ7LCE3WZ2h43ZQxiixZHBNUntlGyQZlzJT0vZeQbgmnhcZvEjzxYAiZfzCwGr4HnBlc3iNMRdBrHqO8WN9RdzhISNgs5Lu7cjvDLfrMhMNDPfhbttrsJEUxu/Fx40xlBwps3ELKZcsR/GTZ8tZ9hTLepKEVAH083a+ai2lhFHhyg58iwclaz03G2hQELkheWFuxlKK+nQ5Pb1YM0siBVX9CbtgL7mw+lGuiJWXadwgL5fNhU5UDGsAL4CSBiORYSeiF63RT1PzqJl8dnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI7KB0RIjGl1hdTE3IJAiypZ+0pAl8bUXPk4LbTbksg=;
 b=NflxdCMgl1VeRXNOSbxhXv5ZD8xYzQQsHRwStclkE5alPZC0KgyFINZ1e+KE3U4Av7Aqudk7XdRrjcWxjjdBzoI14uYMpquDyNpYOmtidUUKOpbgMf0a9GDfRAzTjRpaWW1oV7So396wpTk3yawF1w+dlrJhn7Ad55Cy/D35YHxAXHOLIA09bTx+ZogQEN0ryvYJqFmdhBAFEoWPNlnm9EcmEHYxp+u4a9mZXMUEa+7O5NHxkE0HXlzbPYcBN2YayKsza2vQ9qvmvhsvQ7S+RKaZzwP/K3xaHpsoZBh19IbmAgkaXF8KmuepMqNPCZIbpPmRsuHK/0s7QMkiMoZMpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA1PR12MB6945.namprd12.prod.outlook.com
 (2603:10b6:806:24c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:07:27 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 14/16] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, 
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Steven Price <steven.price@arm.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261008055955.4014342-15-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-15-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444125.2412245.8828837302289906606.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1650e5d1-abe3-4a2e-8e79-08df3526b2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|4143699003|5023799004|56012099006|261026121527099003|261022075727099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ObTbSeCr3MKZEvxSxzGEzKetavRj3NjZVC4zNQk15E6ewzRMTPADeT2awJ8UzT6FME0bUSH1MbxxGvfw7v8zu+uahSzHnJ2FAlW0BT++l/bpmapDGgn6bt0zgcJm9W7kDSIZr5ZNTgo9au2Hxv8ZJdF3dZwYSL61Eh+Iir/+r7YzJsWwGhhqNPUyfoAxFLmAYl+MRQQ9EP0yFTvjpx7NrCutBrsXppWh4d2+OVKy99/5XOTEhMDUzn8MMhBRndYbnfntHGjlfblvEYSxH7y9xRlicu7hdweLxJ0OPQMA6kQkTsbI6O+uBepynorDhNb3dh2tRXa0kMivtlvXmeQCQGe2Nut/JjZz3jjw7fBR6viY4VLoRt/ByaimwmbmDD+naZMltZ7etmbOYzbWGxPRRp75tEO/FewnUAQBLMgxtmtoaG50w0bYaVpAzHgZKtkToDPmM2E1dMf4Otr40fsYG2i0QE4aCWRMT8Q8iv4a1cpaDm8dPIeY01xtday2yShlxY8K3rmEdI/Hn/j3C4lInSRfFVMbAno2q3b7u4j2Zus47ZoVn08A1kiptgs2bSCThQM0xGSaRgbbaUWWd+z1NUNhN5vgoF4JCIlOBF+ZnAGOzMnLDX59NEE9h9dggDJZ2Ry7LAou+TAYY9JvUfe3/sU67NoBwK8HUQXUxppUTHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(4143699003)(5023799004)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3pTbVN0RzhaT2prbkpialhzSThmVHV0M21MaHZYRXBFUHQzbDdkMXdDcm03?=
 =?utf-8?B?dDkveEpDYzV2TnVBU1BoWUVQR0hPUjJ2Z0h3SHdWelBhVXhaMTdrYkxGWkd2?=
 =?utf-8?B?N3RFVWFpYngxMXEyNDBldmNYZmdrSGRMbHlxb1RZWXo0OFkwRXFnRFRKQjFo?=
 =?utf-8?B?V0xRaUhjY1BiNGF3U1VndHB3VFpDcVhtbTVONU1IQXFVbkdrendqdTlxQ0Zh?=
 =?utf-8?B?VEdqc1Zmb0x3ajdValU0MGZ5RW01SlZNalBxL2lnNmVvUmxmQ2ZUS3FEQnly?=
 =?utf-8?B?aWxRNlB4enJwMEdzL3JrbnVCNXptUXNTd29XMnMrQ3lNVC9CLzNwK3lqd2ta?=
 =?utf-8?B?V0F1SnZHVFQ3c3IxV2ZoY2s3bmpMcTVhM2N4ZU5sMXE2ZzRweWlIVW12dUxI?=
 =?utf-8?B?STZIcTRCOHM1ankrVDJXUHBoRHpZNWQ4QktrWEVadUg3V2NVRUN5UDVSZ1lZ?=
 =?utf-8?B?T3NrOHovbmM1aE0vSDJSUmdxaXRaZVJBaVZFdEZKZ01BUG5Wem10ZDNaWUEx?=
 =?utf-8?B?T3N0Y2pQSmZrSG5SU2tmUnFSQkcwMUp6YkZCdk9hOEFXTzJjN3JMWStyeU9q?=
 =?utf-8?B?NitTNW9SaGhVWWw4bUk5QUJBUWcrdkdObkI5Z2M3UGhJU2luWGFZNlY0NC9N?=
 =?utf-8?B?U0NzTEQvditkNVRTWml1aTJKTXNDOWFxZk9jQzNoK0pyUEhTdGZBUy9lNmdo?=
 =?utf-8?B?empqamFWaXJFbXpoRHFHem90UjRGSnJyWWxHcGt3Q1NLcEV3ZXEwaERzU1Fm?=
 =?utf-8?B?am1XNGJ6Q2FhUTVjcnhST2kwUmFDUW1keWNlTHhkdzc1c3dFdERXNUd6cXdT?=
 =?utf-8?B?ZlZLaCt1d0kyOU5tbEpla3JFUnRvQ0VHNm1QTmFjZXY1MTB0eEcxOGlXTkpQ?=
 =?utf-8?B?cWFVSXNEZXdXdGdjY2pOUjZDK29GTVp2Yk9pbjZpM3NqZzBJT0E0bzdmTmtu?=
 =?utf-8?B?T3BXYkIxSzVsK0FRU2lEdjJodG9XcnNKZmdkaWJMY0JucDdmQmxTZ2VGdkRh?=
 =?utf-8?B?eTRILzhLaERkSUV6bE5hbHQrWkM4VzRqcEtCZDc5UHRTbmxrclAyQThNZEwy?=
 =?utf-8?B?SlN4Ui9Ecm1KMnRocEZ5VjlmTjhVU1lpRkRuNi9tN1Z5eGpxZ25OZDdGN1hv?=
 =?utf-8?B?TDVoU3Q5R1ZwWlJMTFljY0RJK1hwd2tzaklDVHNvRGJJSXZ6VzlzQjQ1K282?=
 =?utf-8?B?TEtMakQreE5JTFE3bGtXM0F6WTloWkZxelBMcDIwdXZWcDA3UUhJZzduRHkx?=
 =?utf-8?B?UzRpMEdhaGtWWlNyaWw3WXlLa0hyd2Z3elAzZUQ3aDBKb3FXaUkwVjg1aHlO?=
 =?utf-8?B?eEJSc1ZKbVRqMFgyOFhMOWlZM3Vib0Y0WEJKREVRZWQ3ZENsclJiQnBsd01s?=
 =?utf-8?B?VC9zL09BTXZsQnBxQkN1OTJ6bE1uaVZGWm1odUdRWVkvK0VDQVZDQ3NZcDRq?=
 =?utf-8?B?MEx1N0xwWWp1UVdGWkpNUjkyNjQ4ajd0VHUzVXROb3Y5dlhVcWg1UEhReGl5?=
 =?utf-8?B?MytBZHpwaG5rSWdhM0pzQkdwc2dHb2daZXJZczVESSsxVi9YdHdKWHhyMmhI?=
 =?utf-8?B?VzJ6WGlnc2ZHVnhRMjgyZm1TQzJSUGdyWmlKRmpqMjRqR3dXRlhlZDNUMGR5?=
 =?utf-8?B?Z0RmTGtROVo4TTJsRXQySWpRdmdJaUxhak0welhkcGQxYW1nYWs3UHZLZ2lo?=
 =?utf-8?B?UUhXOHYxVmw5ejlIQjRrUnFFMEFlOVZWM2swY2wyS21aZmJLVlVYemNpOS9O?=
 =?utf-8?B?TUFvc2hyc043NVZTWmdHTFhjUkRUT0RkL2VQNmE3dDRGcCtKOHpkc29WVitv?=
 =?utf-8?B?SnR0R0ZKSmhGVXRLaFNHUGhQVktBOTVieTJpazFaRGdGR2N3VjFNQXN3TWxz?=
 =?utf-8?B?WVorYU5tNkxGMmNJWTFPV1MxTnhpcUk4WXdxQ28wWUdZM0dKVmNFbDZPbHEz?=
 =?utf-8?B?anlhRFJadS8zWjBIZUVhcWxEYkN1S1RBNTY5Vk4xZzkzb2Fla2lxZEdSM01v?=
 =?utf-8?B?RThCejhlMmlYajFaaUZUOTZnVWJ1MDhBQnFlOVJ4S2tyVEtNNE12d0I0eU4r?=
 =?utf-8?B?WGlKYkdDaTdnRk1pLzJaMHlMVWNMNTdBLzFzSDRDbXpLdnVtTXpYVHlKL2Ju?=
 =?utf-8?B?ZWJUanJ1dURMWUFTS29LWG0yVVJxT1FuMFQ2aGxkY1pNUC92dXYrOXM5T1JE?=
 =?utf-8?B?N3hrVkdxbVMxd1VLVk1rZmxBMlFwdVFNek4vZ1Vha1lFeENFT1NnYTZLQjV4?=
 =?utf-8?B?WjI5Sld1Q0R1eUl2K2FTdEVIYzcycllyK25BUmlSV0RpSnhwbVlNWFlLaElP?=
 =?utf-8?Q?LHBbFw5QZYMKudYPYv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1650e5d1-abe3-4a2e-8e79-08df3526b2f9
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:23.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCCeLnO7pFLmHIhnl4NGX7UYE9Grqms2gw3dQq1eWEQ1CEg2Doz89grGf7Ne1D+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

> [ ... 178 lines skipped ... ]
> +/**
> + * tsm_get_device() - Pin the TSM attached to a device
> + * @dev: device whose TSM is to be pinned
> + *
> + * A successful lookup pins the backend module. Backends providing vIOMMU
> + * operations must not unregister their TSM independently of module unload.
> + * Return: NULL if no vIOMMU-capable TSM is attached, an error if the module
> + * cannot be pinned, or the TSM device associated with the pinned backend.
> + */
> +struct tsm_dev *tsm_get_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +	return pci_tsm_get_device(to_pci_dev(dev));
> +}
> +EXPORT_SYMBOL_GPL(tsm_get_device);

This maze of dead code and strange layering is pretty obfuscating, I
hope we can delete it someday.

Aside from that, this looks OK.

I know Jacob and others were talking about needing to discover the
driver from id using a lookup table like you did originaly, but I
don't think tsm should use that if it does get created. It is
simplifying to route things this way so the tsm struct is pinned down
by the core code.

-- 
Jason
