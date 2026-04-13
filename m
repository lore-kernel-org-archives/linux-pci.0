Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D8382384
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087349; cv=fail; b=IlHX4QLzj+QR8kQTa6UnQsKTC30G2J4ATv6JbuwsgkqIIITmJBJH8KJskzC6Whod28G6zhuoCq6Y4EqEZwP0RQJlhZe5lWStpmjPSycYbCWdXi+NPNKxfG9zy8VMkeUpeoJYKDKctIUcHatgfibKHtxBLtLf2pHjlHe0qbYC458=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087349; c=relaxed/simple;
	bh=dJp3OfZp7OQ9YIhRl9v7gka+rVse2NXafosKzHAYSy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O/0YD3nqxZYFt0Jz+iv6GMBUqLiRNQ/T2c76XZXYsN8wroZsLD3+/QOwyvgaiJuLE782us0Khv1iV/aXfV3imPGlkjt+/O/+DXaZw0VmWybxA2KmmbJWrTJxRGNk7RMgNgPgGlDi+fZlVEROth66sckxPyxZC4MnKlnXDMHe408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9XG2nqu; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9XG2nqu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbCGZUBOCGfRWFyDLEb6TDEqmIPTJ0Pk1HCmxpTYmNNYb+xjIo1ozu9g5ZFj/e/XKCeDk1t+JwWP/jqdCZmgym1qYHohpRaULPSOM53H13y/Gijfhuu1X1tZkmUO/gZd5RM2FITe3E0CpSj64hcNJ7Cx35R8xLIFOuOZ+idwHHn9T8MBC2LtD26hmk16FkMGYsesCRbEnmHDVw9Ph4wzepbs4zrux2rXmpA9BQVMDXECgmUbh1uM6H/vnTxVV20E3qoFqoP1JgZ5PtdZyOKm4Qhv/zqbHi8dmC1dEwtfZn1+fkcZrUuaqXNGT8MpI9QOw3sUKKJAgsa1x6LiHZnd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJp3OfZp7OQ9YIhRl9v7gka+rVse2NXafosKzHAYSy0=;
 b=I8m8mXqtu0IQfqRHaDFdOB5RvhDJxVp7qZ03QMUmdiCZ46SIO9i6G3NXgd9IsWzV3l9Zy9lLEXBPMFxaI4WgpMejXXtdIfHEMZRTosHHacarl801xp4h4jEfhj+f+QuctbBAubQgWwDh2oRrxHryJAFCK0ZXJzdE2Q+oPrE04hp5exiaNL4chSxXOWDuMeV9A+TCKW3wCzd+70LR280ZQH5MkeLg+8pXs+MpIFpH55Vg+7wvLibVq7Ys34tfSeTXXuOnGXTLFwn9Jqby7jmZWS+H9ALs9oGiQl54aylYImToot0F1LCQykiKY2k99oHYIakFpQG/NNYy0RokE31Nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJp3OfZp7OQ9YIhRl9v7gka+rVse2NXafosKzHAYSy0=;
 b=g9XG2nquA/OFOXOeLvdIrR3mfVGWeEaB5yvhOeVWj5hFnieA21EAryaDNMERpnoqrdr1Y4D99uZC8AkBG/FdC9bNoYR77YbXq0Ov2j5xEVfsEzEDzYJAw2TdLkDuILddsgKmO841tu3lUVa7UliBds0LFkJh93nI+d4tgD5acs6UX/PtgTO9f97zivFLnP5zhHBT3Gvj5VPafWO0Mu2qHNr415ur/Z4N5MHDlgApvFVOpAyZiL7zpHxgNsktSiyzKDxOSLsZkIxe9iieHPL4qpjgV1Jh0Ts2gjBJgYDt0eRxAmaIF4FyPJ9V5LkJpcNB//DTw/Y6Llt/a3Vwf2V/og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 13:35:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 13:35:43 +0000
Date: Mon, 13 Apr 2026 10:35:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260413133542.GA1233417@nvidia.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb841b0-996b-4ae7-fb53-08de99618fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	H5f3gqySY3iOeDAbo1rxZEK+D/C7k4T0+QLOFozdfj1wQRMQdcgUys9ik74adcou7Emx5dY5T3gAkbvg2Xwqtqb6xmrTI4v2BZabSr08nQnkbDN8Ap6xQlhBiNm7qmisoB+g4encFH+95CTwiEteL+WfymWb/FtXpOoNfPYDVcgZtmX0LzwIc5hJ71LtfuErpSW4WoSVMCGmIS9+xImMTsL1syyAFNPozVDqYa9EUGkVwMQPXGwf8nHA1xiD+6YKkRZu9wFEqQXrWJa6w+ern07FA9WU3ouQMlVxhPRJfAJC2Fd5zvSBmGjkZKaA3EjhNP1bjlNph2NmWfHgUR2JFR77bqYDMnfm80gwDA4AcdSDaeEvvjn9BEcULjUVwqD3Z5TZr9TtTxLxOvJyAP4LTsAnYdWkOAyn9qNY0Xcof8Aw9G8OmQ0NYJX2HRdZGY4Y7AXYgLO7OHvV3wGsyPCyyak1KpidGAVUTSr2S48tcnJdFnmx02UJmjNBcuWmCm7qu0Ui/pzFwxJHJimqX34+A8wBBqXVthrJ5ZMfcwi1yXJ3w/Mrwb356Gu4Ewa298t2Lejbh7gJsqyOPdnxz6B6R6QIzBpsDBMs0ZaxU7jOLTjVqSHYhmDLQnDhDdcjn/GDvquhjJibWtZJXACU3NneRaRl3Tkna9Nm8fuDE619wbrtOcmlF2djbleNPamv8GINmC5P0CIUwRc/qH7asY3nUpxlruHuIw1okKtPYJjSCvFetFDH89JERPiUV6UnwP9pHrL366xY018xsg7GruuqW1JBKvv8x/Q7QWM2I4frG9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmI5Ymp5TldNcHcxclg5R0xKb1NUZEVLVFAza0ViVVZ0Wmt5ZVBlR2RwT29R?=
 =?utf-8?B?UUhUcnd3S3ZDaytSVmpQQ2ZLSXAzNUhsT2l2RHhybzVsYkpnY012NENuQkV0?=
 =?utf-8?B?bUdrOTFHUkIzMGpFMnhyMk5TYWFwYzA2VjA1QzdHSktURCtpS1R5TGhUam1l?=
 =?utf-8?B?amU2TlByUDRlT2tIWU04RjVRalpEcWhLNThuemM5a3dTdy9ZZTdGY05vWmJG?=
 =?utf-8?B?a2lxQU5nZ2FNTjlBbUpMazBTVkR6U1l1bDd4YjVWUXJZRURSeXJyUDRPQzVh?=
 =?utf-8?B?WlNsb09rWXRvdEE2QjFpV2J6dnN3dnIwcHdnS0FabUtoaURPS3dSeHR0V2k1?=
 =?utf-8?B?Y1IwUFpKclVtQmttRTVma2l5SHRpZU5XVy9xbnJEdXhWaHF3MkM0VFRMUUlN?=
 =?utf-8?B?cTlWS1RJY3QwSitrUGpseDVUNHJ3Q29CTEMxS01kSnZCMEZFUi8yMURlZUVK?=
 =?utf-8?B?aXFJMUxqM3NLQ3h1RmlYaEcwTnVTeVNua3ZoRFRRNEl2cFQrUTBVR3JTdDNr?=
 =?utf-8?B?QTNTK2k5dU5SY05oWXdraXVHbk1EMDBwZDlMK3BqMDdXclpEaWdwbHc4enpW?=
 =?utf-8?B?dEZkS0p5VFY0UmFobDdENlI5NmZhMUtUcWJDM29LNFVlQTlWNkNNVjNQRFFJ?=
 =?utf-8?B?dFdDSVEwWFNlT243V2NQSnNOeHpuc0g0Sk0wZWViczdJbTVWZjYyQ29TWjJE?=
 =?utf-8?B?RUwrbmFrK3RoRWdFZThQcWJ5UlY0MWF5YlM5QmlvYnRXS01menlaSmsxYTRj?=
 =?utf-8?B?cGwrNVpGOGhmMUl4aDBoS2JMTVl0ME80UXRGaWV6bzc0amdOQlM1V3ZUWDFJ?=
 =?utf-8?B?UG5RbElCcHc4THgyUkQvWHNFVUpFaEtucVhiK0Y1R3U0ODVLQnNycUVMcEd4?=
 =?utf-8?B?QVBOMkRkQm9PdERNbnZ1MWVTRU1KVkhpcFFBbjdiY3VRd2RiZ0hENlFaU1Vj?=
 =?utf-8?B?V3FVMitJcU1RUVUxaU1FUVg1ZFU3bWV6dWRLckRheGIzejlsQ0cyS0thYnRn?=
 =?utf-8?B?UW1KOFZWWXFlamZVeVVXWjNVeVJmRFRaYUNUc0trTlE2Um9sTitpWVNTL1Ey?=
 =?utf-8?B?R2tIdjdsNzRFM0I0REN0QWRIdEtuOUxyODhDMmVyelg5VDBMYmRNcXVTVFZ0?=
 =?utf-8?B?SllLS3NLOEtqYWJhSUt3M1BCbHNUUXhRYTJvTm0vMHc0WTZBb0dBTHJadW51?=
 =?utf-8?B?KzFhV1FyZHZlZDAwMW9mRVVwNngxVTZidnFYUHVSYzFTL0RqdTA2bHdRdFk2?=
 =?utf-8?B?bHVJZkVLZzZrSm5tby9FN2ZscUdCdW9tM1ZMTFkvbXNsTTY5SVhoSjQ2R2l4?=
 =?utf-8?B?ZmFtQzJBMFVEdVU2VzhRa3cwa28xZzBtSkhydmltR1J6SW9KWWhnTGcyb2pN?=
 =?utf-8?B?UERSL3hjZkgvT2d6VmRkRWNyWnhsMC9jQ0RpVmN1amJiUE4rTDFXRWg5RWpY?=
 =?utf-8?B?czdKcW12MjZwM1liRHZMU3VySm1RMjFtU1U3ZzkvbU0zY2tndUd5RWdqSnor?=
 =?utf-8?B?OVMxUlk1VHJ3Z3J6Uzg3SU5OLy9ZcHVVcm1uZmNwUXA4M2lXNzI4UEREUlNx?=
 =?utf-8?B?Vnl1TVdlWlRHM1JhRUNiTHY5YnlZOWFjMlFKR2JXeVFtVEhnb2JmelVGVldK?=
 =?utf-8?B?cWJUalA3R1RLLzJVaTFINXdpN3FEMWx6WE1ldWxNcFRNTUhDNC9Nb1ptZkFI?=
 =?utf-8?B?K2o4MlZrRTBqUUdkT2R1SHVqYlJnUjJqaGdOT0F2aDVnSkg3ay85M3lxaVJk?=
 =?utf-8?B?VHFmQ0JlRm85WGhTSnZtSkpvRDlPdzZzU0svRGQyVFRjSjVOL2YyWEpDdFdK?=
 =?utf-8?B?d1JFcEdSRENLMFYxM2ZnMzhhR0Z3eFdRZVBLNEM3SHNueStkcS9zdlRYZzlX?=
 =?utf-8?B?bHpjc2h6NUtDeVIyMTJmOHV3bENxWmJJMkZIQW9CTjk5YnloQUFrWFNxUWZk?=
 =?utf-8?B?MmNqVUdSWU5UWXJ3STNRL2FybXRwUDBtNDAxUVprUEZJbm16MGhpWWJ4WVk5?=
 =?utf-8?B?d3hFZklzMzhONTBsREZuSUkzelNnOUxDUU80TlZrVVlpTFVTSnBtYU9nRk1N?=
 =?utf-8?B?czg2cURMK2pTeGpFRlVRUEJsaElCTlk1VjRMRkxjOTNDZTZsdEVXUEpDTmpp?=
 =?utf-8?B?U1NmNmZ1WHZtZWhUUTJZUmk2bGFRVjNGOU5Ud1FzS1lkelhOYmN0NXQxS29W?=
 =?utf-8?B?ZS8yQ1p6TE1PZkpXMFdHbll0MWtvTFkwMEJaK0VCdEdzVDNGUTZRUUMvbC9W?=
 =?utf-8?B?WENJRlZqTHdjeVhNbEIrSzhDUzBUdTlWdGNxejcyaWNGU01MVUVuTGpaeGpL?=
 =?utf-8?Q?iTx3Ayn2uTgBgr19b/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb841b0-996b-4ae7-fb53-08de99618fb9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 13:35:43.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITk8po+jkkchGX9WIfW78V0qh2etKzTNAfjoBZlJCb88JRmyVRRMqta8gML8pdL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

On Fri, Apr 10, 2026 at 10:30:52PM +0800, fengchengwen wrote:

> Background: The TPH Steering Tag is tightly coupled with both a PCIe
> device (identified by its BDF) and a CPU core. It can only be
> obtained in kernel mode. To allow user-space applications to fetch
> and set this value securely and conveniently, we need a standard
> kernel-to-user interface.

There is no reason for userspace to have this value outside VFIO.

> Proposed Solution: Add several sysfs attributes under each PCIe device's
> sysfs directory:
> 1. /sys/bus/pci/devices/<BDF>/tph_mode to query the TPH mode (interrupt or
> device specific)
> 2. /sys/bus/pci/devices/<BDF>/tph_enable to control the TPH feature
> 3. /sys/bus/pci/devices/<BDF>/tph_st to support both read and write
> operations, e.g.:
>    Read operation:
>      echo "cpu=3" > /sys/bus/pci/devices/0000:01:00.0/tph_st
>      cat /sys/bus/pci/devices/0000:01:00.0/tph_st
>    Write operation:
>      echo "index=10 st=123" > /sys/bus/pci/devices/0000:01:00.0/tph_st

NAK

This is all low level details controled exclusively by the kernel
driver. Allowing userspace to mess it up will break drivers.

There is no justification to give userspace this kind of write access.

Jason
