Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37A399008;
	Thu,  5 Feb 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289209; cv=fail; b=VSxqeWeAJdjmfsMKklFEvQ/f387YvMqWVvBWctJ4HDERN7quNmM03ouOaXFcBTs+rd3yJXnaQ048GoaMKaHmy46X3dd7AuYFTkPD/32N92ISjbZWERuVbYFbdVq6dIkpIq7OUjQRyr3O5hwfYi0MvJdkJwAWOlHAEkxVx8/4Cmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289209; c=relaxed/simple;
	bh=Xz8K171YuhEF3d/LPPQofUUSKNmt8zuQk4rPU9a3YzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NrlCsurBHvQbCJ8SQSb77mNMeO9GVWMKraQ+OLvY9EeDnd24O3/9sslUPU1s4LnIDMu1CQEtpqG9/XCkZ9pxQYSQgIq4DFR6lglThSAiblCWIRaUkQ79JmS37bKKYdB51rDJbLBiPeKjwV8jh+8RH+1lwJz3FZVB2qYmjepsnvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EdtPmUvd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iCM3RzRG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdtPmUvd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iCM3RzRG"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6150CFFn2399728;
	Thu, 5 Feb 2026 10:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jXiPtG9DsuYFhk0Lq7DZpClagGv57NDxUruGJA+0GaE=; b=
	EdtPmUvdRjse0h7uUEE6kO6FV0yOXBIatHPX7yWRAkDqSrUgVD+y6LLMIaM+tMA5
	8qTjnqyzQNCC4NFUcFi67gHU/iZ0OyR5gvM4jER6OHK/NxePoi+W0XCWx+XlizBO
	KeVN90lWVHfrFUKUrJjZxfACqTjcK4fwZWSZgiNB8/jlMYCwYK/DhEbUGxWspvlI
	NiBbjTmucCoihguywCGs8MFP9PMUfkdHTOSBaMgALGamAtXZwS/4/0vAcyQ7fUsv
	/wUZUSUrDrw0LAj8URisqgvaNuf0ps7v2wgNXH71f9SpKumiIvjubtH0+XWRrmjK
	UGodnRKfDp35ljol8TEL6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g3b3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 10:59:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61590nHW034752;
	Thu, 5 Feb 2026 10:59:46 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186cymp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 10:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hA1sbEDssp6y/FZqq1eysR/aV8dWEAg5NUbHRkIiiBBCbPyTjqaW6bHQKwa0e02w6meieb8iWOusCKJfor0CbcPY9BVzukv9GwlETTuHn6mR2g5G36MmfIn9/0pU4aVP5hLPBUfrdHEA32haSoGFAWjBdOLfCfJNJZSQzz860ht7qhKPFZ2SnVIf2UcJOCY89WxVTc22RMuF1dN2g9td17srV7Uh7KaE9YgD2w51I79bWhoDsaSUhlRkpPvJbW+GC7N3+H7vDtqI2l0zOiMGz0ZC2vGzz+ZP4K/ln0o92Y4TsA7Dx6V/9LdlvwyIjwGH45bZosIlbKmcR4cDgY4GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXiPtG9DsuYFhk0Lq7DZpClagGv57NDxUruGJA+0GaE=;
 b=eRLbW+0ro1hPpWmuR/u5lz9GTfRov4UG/L5Htnp+u+3XzvLctCQflcULjKdGKG1lvhY94QMN62roOuNFF+yzkAGu7tp6R0wMjOWz/dUwG4HnAKoveYvaA6qzqo8wdGHchkPoYmqECiU1hTcaERp5sxLADuX0CYI4DcmWIxfJb6je9qZkcKZYE64tSUfqJaO0FwP9kQQ9n6tmwzx7eba5Oj4IAb04fgCDutp0sgYaxyA/yqtOLnCAoC0bAzzG4I5S8/YaDgcFNF7CIfgfV6d1RDcCCQouO8KHBc2Bt9h0m/PGRM1KFvzAdBjiWCRtqgsyGmWqeuR6gHQIEkRO1ab3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXiPtG9DsuYFhk0Lq7DZpClagGv57NDxUruGJA+0GaE=;
 b=iCM3RzRGPRCk19WeWGhma8GqXEp05F/VZbIhL08SHhM/H5AjFDRgPw8zm5C1USY3StTvOG//yqoRWKnfRnsZlYJ17g2dGGOwEImFoYkQhvQmwfFX8zul3vf//XXhaVDqsPQXa7EuQgyBauxdVLVj72iLI2O04DPr/V8Uf6UxkdY=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by DM3PPFEC98198CD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 10:59:43 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::b110:3df0:e927:dd53%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 10:59:43 +0000
Message-ID: <ed2af765-0e18-46fb-9b0d-175caf189c4d@oracle.com>
Date: Thu, 5 Feb 2026 16:29:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2 2/3] PCI: Use pcie_get_speed_cap() in PCIe
 failed link retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
        ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
 <alpine.DEB.2.21.2512080348310.49654@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2512080348310.49654@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|DM3PPFEC98198CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3db850-6cce-439d-3c54-08de64a5aaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2FlNjZOd0d0eEZNVW9XZC9mMWhEZmxsNjRmNWdhd3dRYnhOTjR5b3lBMWx5?=
 =?utf-8?B?a3JFM1AzdHRXZDErYXJqMkpjWHZ5cDBDcDdUZjg3RWNQSzFxNTB2RUs0MTFm?=
 =?utf-8?B?cHdYZ05acjRBRVFVQWFHd09seCs4KzFIaGxoeUovd1pRRTY4bDUyS3J4T3JK?=
 =?utf-8?B?QW1OZmlZUEVSY2FNQzM1UElNVFpBRDZIUXdmTTBDVXlTZ3RUcy9nV0hyYkov?=
 =?utf-8?B?Nm5UZE9MSzhLVVNGMUIrb05xT2dLbmRIMXN5NXhRTFBBR0hMZU5sTnhjVTVX?=
 =?utf-8?B?UC83d1gzZmVUMkI4U1RFK1d4MnhScTJ2bUxQcDJPeTZKRjJma2VYTjJibHZN?=
 =?utf-8?B?QTNlNHZOMWpUQ3MwTVRHY3J1RFViK3RtRmNxaWh0NmdhS29xYVNJVE1TT1V2?=
 =?utf-8?B?Z2N2NkRBNzVtdTZ6bkluNCtRajlkTVNtbm9kNG9pbk1ySlBGRkMrRXBnMGVo?=
 =?utf-8?B?b3Zhb00yNjUzWVJYZDVRZ0xma3hxdWdCUFl6TmlacHpkdTgycVphQTZSdnhC?=
 =?utf-8?B?ckljbVdLWFdOMFN5S2U0UHFOdk1vQVlQUzBrUU9GNVg5cjU4ajR3TmNnWnlN?=
 =?utf-8?B?aWJ3VFBkeTZMSURiajVFeUNvY2xZMmJvRDNJcGhYOXo3WS94Sm56S0dnalZ3?=
 =?utf-8?B?OUZ4Z1FoUTcwL0pOMG5OcE5PL25WTzJ0OGt6MmJUMnpCWm9mcklJQ2FMMGps?=
 =?utf-8?B?N0xMQnM3SlJiT1pROWlVVWFoN3ltNnFsVWZqVEg2UnQzNXp3a29OU0VISDZD?=
 =?utf-8?B?OGRqeDRvRzBOV3Jtd2diZld2ZURSWTZYSkdvWDZEdFNnaUFKMVAybCtUd2dU?=
 =?utf-8?B?QTdmY1YzVW5KdHFYTkJta2xJeXV2K3IyUnhtYzY2RWt4TU04Y0dBd2x3bTA0?=
 =?utf-8?B?MUtJVHRNaVBaMHBXdmk1QVJlL0t0ek11aEhRcTl5dGpmQ2FTZjdUQW1GY1RE?=
 =?utf-8?B?amFCOGxCQUc2di8vNFRTaXFtNkJ4V2pyZXdCaURyZ0N4N2Nuc0lmRnZ2R3hV?=
 =?utf-8?B?bG81YjVGOXhLZDNKaVJoOXF1ejE4ZXB4WHN6bFpyRGtVdGhJSVBjNVdESGg2?=
 =?utf-8?B?aklIY21BelFIQUgvaXhrcGdzdk9GbnA0ODJ4ZTFmK1ZaZ2VDdG0zT29ZeUdD?=
 =?utf-8?B?TG9iRHhKdHZBdC9SZXJQUGtER1lQWlZxRlU5L1h0M3Yzdy9YVVpncDhlM0My?=
 =?utf-8?B?TFkzcFZ2NnJmV3JLTHRPQ1FYUWlwdUx4c1VPTlR4aHFQUjl2M2E3TGpRalph?=
 =?utf-8?B?cERpS2F6V2xRMTd4M3ZwYnQvcndWN0htcURPc2lWWEV3aFVna3hOVnpzcENI?=
 =?utf-8?B?TlBFK3J5Z0dFRjhQcSs4U3NHdzJTc2NVUWtneW5aU25ZZEFoU0FzZFMzT3Br?=
 =?utf-8?B?SURETUhpa0FCcTVIT1hKV3V4a1lLLzZ5OFh0aVE1cXBCQlE1aHArNm5DNmJ0?=
 =?utf-8?B?NExzcVJyaGZ3Zm5CWUtCbXpVWDFBRFRhSlY2NHByS2dFQUhRTTJzQkttUWhQ?=
 =?utf-8?B?U3ZnRUxLbW5GMjFoRGF3aGhtcVZuREVXOGhUdmxzRXd4OUlOaC81cUhwV1dv?=
 =?utf-8?B?QlBKbUpqeTc4ZUl2Tk5aT1loZ0RDYWFiTk82V0c3RGt1UTR6bE5DZCtTbVU3?=
 =?utf-8?B?NjZ4TVEwdUJWbm1NUWxWNzVqSDRKV1ZLM0cvUXBkRU42MlBlbkpzbGN5aVVV?=
 =?utf-8?B?THNkNzg2UFEvdjFIbVpaeGpiNG1RVFdvRERJeGFMdHFjWUtNOHhJVTlQU1dS?=
 =?utf-8?B?N1pCTE8ySnVvN0xVZlpKcEZaOTRmNDZXUkpBM3g1U3N4dWZoR1RXeHo2Vmlp?=
 =?utf-8?B?NlRlQkwrTTd4cU1pZVZ1U2dsTDVBamlLYTk3N3JyNkNRMUNRZ0srOER0RGsr?=
 =?utf-8?B?MzJESGN4dnhmbVdGTWI2NUx4Y1RzdmMvTE5wVVJhN0t2eDU3bDlFNnFhN2JB?=
 =?utf-8?B?QjB5WWZTaDRhYk5pVXFRR3dFVnM0bCt0TjF6S2dNc29RN1pmVlhDdDhMR3cy?=
 =?utf-8?B?VUtFOFZnelNndDUyZklkZVlCamRyU3U0eWZvMTFraFNPeE1iNE93aDBLR0FZ?=
 =?utf-8?B?WWRpenZHeWR0Q2ZsaFlWc0JCQlJEUnhJZzREMEtvd3VpSFFYSEZCbmMvWVd3?=
 =?utf-8?Q?onxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXZ6RlpPdmpqV2RKbnBXZjQ2ODVZQnhGZjcwVTM4d3U4TmxLdmNQcXVkN1Zs?=
 =?utf-8?B?RkpQUUxOQUs1TU15QVQyR3FrRVptOXk0a2VyUzcwOTQ0VDl6b1p3dEdnSXZT?=
 =?utf-8?B?MUZTME4ybStKUTV6NVZBaEd0N2taR2twWW83TFhVeXQxRjhkbWpRU0VyaWlP?=
 =?utf-8?B?T095b25TektGaVBLZ0JJR3JKSUZxMG5ONXVVRnZKVnhrRFZHZjVmUmNPVWVK?=
 =?utf-8?B?UVphbEx3MnpPOTI4bzZ5NTdCVXd6YU9LU0o0RFltQy9kN05ZNDlCaEwveHZo?=
 =?utf-8?B?RHZPNzU3SmI4ZWNUQS9acVpUd0J6YlRWNWlsb1RvcEl1Wm5MZng2QXliUy9Z?=
 =?utf-8?B?dFFmRUtWcEJxV1hyZ09sVWx1MUVIc25pOTVZQTYxcUdLbVBiRmtwQXRvQ3Jr?=
 =?utf-8?B?QytraDZuRlQzYTNnVTY0dDc5T0hSYnpwdWlLWFVSb1U2M1UwS0d1aUpwWUgx?=
 =?utf-8?B?bFp0YkhCVnRhVDJ5NVB3aUtNYnZReERHN0ErTGRRZlFaTklsTlZHK21UUmlu?=
 =?utf-8?B?MkFLYUNSZVVvZ1pocnY1dmtueFBYZDF1emVBZk5GaU05eHd4cXd1cW1FQnhu?=
 =?utf-8?B?dlNadUY3MDVOaXRPdmxrZzNuMEZZTzAwT1VpNWFVdjFCbWZvVEN3bEZWZWtl?=
 =?utf-8?B?VVZXcGlrQ2ZkZUl5NEs3NExUNFdrdkErZVpVWHpiSGJMWG8vM2NQZjFNZnNM?=
 =?utf-8?B?WkJJdU55aHFzYmExTjVKdDRuN2FwQmdNNVY3Vm9seXY3eTVlTmtKVmlWK2dz?=
 =?utf-8?B?TWhzbWpWc0NJSk11MDc2SUQ2dHJCZ3VPODRyMXFRYnROWHhmRnZ1L2c1bDlC?=
 =?utf-8?B?aUErU3gvQmw5dW1nMWtCTXRQek85TEtoTHdlekJJT3FNZEErbnhoOE9pRjdN?=
 =?utf-8?B?V3JKdEM5d0ZxeDJOQ1hsbERubXRDLzBHdVBGOTdBd2JIQnFCVFpZRE1sQ0NU?=
 =?utf-8?B?VkY4OGdFQTBKK1JQdjdSUUVsQ3FlOU5FVnkycTFzdHJqdG5JNEVJd0JRV09K?=
 =?utf-8?B?RnZsVGlidHJHMXhxSHE2VVp1eHZpSDRJV1pHSXdGQmNoUzV4OU1lcnJwWlFD?=
 =?utf-8?B?dnJDaEJCNUdLMzdKdGVmQlZzYy9DN1h6eU82NnlSdWRLNkl6enBqMTBzajl2?=
 =?utf-8?B?WjdBZ0F1eDVscUhOZUhrM2s0MDJmcDJnT1BLQUJ0R3VQa0pOSFN2MlZJcXhz?=
 =?utf-8?B?YUZqSEpiUGtyTmV0LzVzSEEvaEdHWFd6TGlaZnZtNnRVVzJhN3R2QUFraExp?=
 =?utf-8?B?OWM5UE9GWkh4bDBGRjBud3p0NUpGeFhKbzJjQ2Yvb3h1ckdkMXBSMmZkcm90?=
 =?utf-8?B?dUhjMWpMTFlVY283S1pDR0FtRmw5NlpiWWtSV1JlN0JWek1LS2lUaVBqV01x?=
 =?utf-8?B?UXNxcHc3cGZsL3NoQThCS1pJOVY2ckJ1WkZMR0VKMmRZVFpadHRHK0RlMFlk?=
 =?utf-8?B?eXRXRlVmZUM1MmhtajY2Z1Qyd1VWY2FHbUltYkdJeWhJT1BGQmcydHpkcWRP?=
 =?utf-8?B?ZDVEMW1uTEMybW91V1BEa0U5clU0V2tOOHNGL3J4N2d6UUJYMjV6QXExN1BM?=
 =?utf-8?B?dStVR2FXQ2Z1azh5QVY0RDBsNmtmQTNoblB2Mm5FSTlXOExqZTVJWFJsc2hv?=
 =?utf-8?B?Y3dwMGhUSDN2WWtYcDAwZVpzWFBheTJGenlocXRaLzljNFc0bUloaHVXQVpK?=
 =?utf-8?B?YmxvTkhlNlhSemZiK2p3cUZmR1dpVUI1WFRmR1lIYUt3d3pLSHpYWXRSaW14?=
 =?utf-8?B?OVNPSFFrQ1M3bnZ1TFhVcGp2SHZBMVROTU5scWpuRjRkWjF0TXBOT05vQVM1?=
 =?utf-8?B?RFh4Vmt1ZFAxWW1FWkcxdGRWVVRBUVNWdnNDVk9XVVNJeXNyVENFckZwOEpw?=
 =?utf-8?B?MlNOTzgxai93UjVlRG0vY29sR0UvNHUzTjdhWlkwQmRBcCtTMGZtRE5HaGlI?=
 =?utf-8?B?MkRhYXc3MGZxR1hvUFEwRGpwZ2V0TUx2SUZqWWZwS01saElCb2Zvd01uRFFX?=
 =?utf-8?B?bUhQMmdXMHhBeWI2dTQvN1NoUGJCb2pYRHZZK2lRN3VTbmFaUXF5Sk1UUlhH?=
 =?utf-8?B?U2FTR3RBU1lvQytnQjBiNkhiVHpsYnptMG9qRHJUUTlSbzVDWGxhcUY4UHNr?=
 =?utf-8?B?OEE0Umk2SllCQlJldWdrZGcxcjZnc1lhZFhXWUhQdUJ4eW4vKzBUQXpjMWc0?=
 =?utf-8?B?TThZVVFlS1hWMUlZamNhOEFFb0k4WVFtNnNaejRnMjZjejN5ZnhyOHlFSzlj?=
 =?utf-8?B?Skp5Y0F4VGhaYkQ4c0VtUFUycjlzbmVyUDNwRFBDRlNYQVo1eHpHSjF0SU5t?=
 =?utf-8?B?ZTBwQ2VidzlSMmZ5K3ZEd011Mld2N0ZkRDhJR0ZyQUE0OEF3SmRjMkNQUGZU?=
 =?utf-8?Q?VwK7qnj98j/+HJTM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	coN+hXlmS3LLdCmazsCI7Lt4I/JbuG9cOZdcHdGc37Et69N7tp42gTv2cy8+dGGF9atEjn6CfC6N5Itpy8FElz8Ifp6/Hmhs6oWGJd2rbFEuizZhUarpQbZ8350b3J2tpjpJKt6U26nyK/DVZlgeRbGIo7Si1Ex9/CfTC7FqoICTft6zGQmNH5v8QuUJUmWiqqTqOaHZrLLgyQfsjYYl6Fq6RcCj5RemPx0m7Z39JBjfkRIh0XcQrtSNikhwA3BmFNnEMVYgdsk1EyDZ+Bx4nvP0DPAkWMn6X7YbXA1gcn0ZWIGnT6zSE22bfJid1gnaM1XuD7VnBw2GGG/XHue/j0yDEpiXJxArusry6dEbVcGldmymTzgkthVA7Ul1ttxAj8QpdhFeGZwNmcHyLh3hp2DIdyEL9ikFtmHQs/GZ/erf3WQUD1fhFNYX8crc48C0lSqBFapEba7iqt0UiC+tDhx5Xwz5yFUxDGlS0ZVJxNCHlMgcbGfOKfn7v/CSxIKyqiqewEmtp+IHxwhGFhwQGv3zzdUp/ew9mYgVPQrZWetKurFF/NpxYowsFKSRHiUqLtk1j322EocjymoHlhSh3dd8yHJoOfwll2DuUBFGWjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3db850-6cce-439d-3c54-08de64a5aaf4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:59:43.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aISfLWNOCq/i3Ck4zhMyF5xvFVJzs2GS1mowfhGas3lShLr33HbkGnc8tnUi3n0SQdrF8SP5fHdJIZrtHa3HK4Yvo7VKM7FcXuwN6r7ds+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEC98198CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050081
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69847823 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BcPKCTjPAAAA:8 a=yPCof4ZbAAAA:8 a=wuvde47IKfPYcoNzQSMA:9 a=QEXdDO2ut3YA:10
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-ORIG-GUID: n6sODGIx-dIkxeNSUCRrcZkqnqkGF-AL
X-Proofpoint-GUID: n6sODGIx-dIkxeNSUCRrcZkqnqkGF-AL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4MSBTYWx0ZWRfX4jys5E8M1lf1
 TfGcX8rj6VSaMnQZ6+2wLUctfYFmDLnBW4s4rY8xpm0VVuNW58TzpIEwWCoVAQ4ihsAnnBXS2OD
 AVqCxwCjV2xKens4BH/GYoGCQh40A7jVrQoLU2K1aG+3GXTJ92lOCOKHHUt21J4DUV2N/BFYsWZ
 MVgYCBNV0vWEAdo2YhYGoy4h7xMnshqQmRxAI97BAX5AaSxcODoWgkR4WbJ/y2Lwypmaltr/Z0o
 83l1C83wtpqCGQqpYtY2sJDJWjl77mtK2Gx8UBiSi4gzonz2rFdwESXjoLXWJk5HYuGTtVo6ETd
 GQrgLrSGdllBHYf67t6g4OyEXnwK20n6rnvZqABAUOFI1dBKjhmDl7EYxRboGZCcMRq0jePsZk+
 BMFccZV8jprARgZN2T+kMlspKxw57paPV/TbKu1C3BQ5BkKbU2zMf6bKOPsC5zT4DPwiCPtlE+R
 LdzsNlqCxmMpof0Lgxg==



On 12/9/2025 12:54 AM, Maciej W. Rozycki wrote:
> Rewrite a check for the maximum link speed in the Link Capabilities
> register in terms of pcie_get_speed_cap().  No functional change.
> 
> Signed-off-by: Maciej W. Rozycki<macro@orcam.me.uk>
> ---
>   drivers/pci/quirks.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Tested with LTS 6.18.

Thanks,
Alok
