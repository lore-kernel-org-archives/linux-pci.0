Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738800;
	b=RJwBvckVJs2kdzf/m2tW2///7B1LHGakCyJzlbPiiNaCE04TaCpiT4oBpZhJzSuGcjmn
	 P7CAtPTNUQSiwt1wizhXEqMfaqQ2OGD6rgsJH0uP+LDDbTG6LAoeLBrb6dVAPceOnsopH
	 KQykaRW7rIlRdi8xBUodMnD1wjghfg2ErTwLkZJcYxk3x0HQ/l3mNIE0IMs8ef2p1Wznm
	 SksCCGB5Atu7c7cLciRW2hVeF63hO/JaLEtNdf8fZvW2RDCuh39ofnLLSxnVWznkyrehd
	 NCT1cSAEV+4x2eqsmCjRLhG/967P69R2thJ0B78BHlcvpCnV3FC+/T1s9B8L8cJF1+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738800;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rXgEukCXQ23VnpL4XvqiFxjjqEXWYb45d2+w7FRTOxI=;
	b=Ft1SzNY98gYNTQHN0+Yjy62sjcV7Z7N45rVHpXGPicGTMN5UG1s8oRUic/E1UjjL0oAB
	 43xzRS83FZWGQEM7BgZ4M+qQaOXjJ5oJRyns6NwPG5jX156OClHSos56Q+3Tv9cIF6YYf
	 dDJNnoknbvyIt0/otAflPFJ5RpZ0jxB0Do/dGUGUsqaoncgM1Jvh9KrclA5BXmtHR3Br7
	 Rz+ZeDmr0u0XG56TbCgcS8gjOcWrPUosElJFJmjZx6g071ffpEKZ1G73FmRR3t6d15nRH
	 X05QMquLOzA0rUvOkSffri7TPEANneXvWCOhklyE3tEBFqJ5Fgywu2F3v+gc7JXVFQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tCCZq4sc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.11
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68570606A326;
	Tue,  3 Nov 2026 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68570606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tCCZq4sc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMieqdJQ4voVM4SrQgWWDgSpJoTfOcNn2jKVinCaFYcK4iEy34k2qKAKJKjDNPz/0kUy5OcxKbESqzRGIdTTeDUqww541jn0xBOJx5/gZ89NS6pbDN1KNxAjy+aUaq0P7hmjd85CT291Llt/hryl9tVwiQFvcgBHL7BZOwC8a7p4+fcK1b8CKrBDZYKWZGnaRjoysNX+IpzvSp7JbRKaAaw8K7Lsu2438pknnmPh7sFioVUnSKp8WjG7QRFcS0yFx8hezMaN1L8k/VzYzHehcrxdVHLRs4fL56y64+FaQy4qGb+3siuea4JJ2kEhs9fVsvmzfl+oAOVwLT9Y7LzXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXgEukCXQ23VnpL4XvqiFxjjqEXWYb45d2+w7FRTOxI=;
 b=KVM0ANfKG8KKNIzyoEcBpmeaNB8ywIdRgApjIOCrEhYXWA0d+HqVpRWCkrzDwQrzrJP4GqoxQq0mVMlqF+WpbwZPrATi21ZdzBP4CQNBRGAhiJ04TuYNQ0r6iv3IsP2gotaW5d+lxRk6h/fBx4IVD0pjS2fn2bVmOiVtml987Y0h8AXb9BHQHmCVPEDk8w9Owm/YPnKcqHeOZmDKOkTUoMvooW8zWg1tAamQ+o0g8b9hj1937iK4wnBW+HoPOTNWJGX7p4OEeed50mewlZQyTSwN2uTqrk1mayyOOV4uB9z0RoPtGyIcnSaE9vHywP7bl9eJm9E5B8QC98q3Eu9zNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXgEukCXQ23VnpL4XvqiFxjjqEXWYb45d2+w7FRTOxI=;
 b=tCCZq4scCteJHg0fwUZCRliYvvsZgyUO1yBKnYLz0BO3sFW9Rbxy10yg8V96Y0ZaoXc/IT40MqOdkIKz35cdsYmVtHWHA9oFWIDk595YBV00hmhdEtgbp7HHWyBimCVq3dz/OTBmzDZfkM2iTjgWBVHinG7T4KNpRpLtE/uqJ9I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:46:35 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:46:25 +0000
Date: Tue, 3 Nov 2026 15:46:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] PCI/EDR: Remove CONFIG_PCIE_EDR
Message-ID: <20261103204617.GC314988@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7a908d-9b57-4967-7af1-08df39eb8719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261022075727099003|11063799006|261026140227099003|261026121527099003|261028144727099003|4143699003|10067099003|22082099003|56012099006|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZGEmf/O7gQh58eAfCkbPvSM/0vuZYTAmFYAMnQiQXu8HqvHzA2hRfbJmfBJf63zM3MfIYO5HoMbpAOuSXFK/9t5QMzpvlgT//SiQIozvx7cYX1en14FOwi0WS1MJ82pr11pzabva22h0MuvDh4H6zYsLmrDaz3lq16IWcXbARddVB9gN0XHWFa4ayKCRJWu5k95EXAnEiSKa5tk7RT9oGg4cECHxUU1iUX053VVuK5C3Ythn4i1cBV02Vft8eXze81S8JNcKpedk9HnGv1untE7dXN9y7KarM1GkT+nSkq14ESexVgpi6raLBGOYacjqJjbaUK9LnOu2G1/0BZ6hqWYRICgit54wLBxlazSSMPDZh/is8bL53MSz+nrq87YXngZaRUPSqekxkaF/8pBS0PQpx9EJvQENNNNHOaaqCKJIqj8y+7ysuxFQasrTOwgnH0pO9gZ/kmVc38lWD6VlYgHczexgL5nTEmpCq9Ni3A2o8zTwc+bqCxZT3/s6s4CoeoyCvjc3MD6arqfaMeNChpLQcw8WpblrNVfZpDKSIAF4ghK2u3eZeLuuLdVAb4B4hk6NYqNHu/ivU/Jwr8Uotgepqu2QCD1JJW/PonlY1Q4K2YxcgjNtA0Z8VoWOcTC5uyLIN78/Q0xa/2cRf1rzHgWar0gaTaZKjoJyAdCcHPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(4143699003)(10067099003)(22082099003)(56012099006)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGeEqv2UCf/CCIjE8CqMQN+vWE5EPr8eEckhQyQvYhJPxk56nasPbP26jdg6?=
 =?us-ascii?Q?zWWkJoF2RmWuZICSYYfokSo3aa6RiGtl2rX+7YRI4WhUPGSVC2A2d+8BcA2P?=
 =?us-ascii?Q?qfa/438MJoQUVE5CD7Bgtw9Pgd48UTpyTkIn1jhofOMknUKNLOrHAycbhECT?=
 =?us-ascii?Q?XmUFyBU7jbcWvMqFCy2ltb0cuy743jXKZxPC+PLYC3sYuB6LAYcI/Dc9zlq2?=
 =?us-ascii?Q?InYkggYrIZ3fMmWg5JxxVm9S3O1PPdm9/Dw3BfnW2Zfe7pC+Ye+APg4l3jon?=
 =?us-ascii?Q?E4JmzTatKLG2AoEG92w+KpqhrtIXn8ZHh3kXqGUiEMx/6u6fFCoYjgJZdgf4?=
 =?us-ascii?Q?8+MBppl3ebPu6FHJlasKipzmQ7FV9X11jgdlbj/3UooDnva1yF9QMTI0o6ft?=
 =?us-ascii?Q?2f4ib4hA/eF/e+nTF4wPMBBVUPFj9YFxeitAKK7UJ7KfyI5HUTMCjLdskb6S?=
 =?us-ascii?Q?tCxSwAK4yw8BLT2QANvySJR+AhmSeOvcNG0+8HRsFeKGRh7WBut3ryMaMHOy?=
 =?us-ascii?Q?gtlzYEsidlk6J7rv0or092FkOzKn9gBAGQ03JO/ZFDHGvkdbY9W5+z+E55gW?=
 =?us-ascii?Q?NyvWBt3IPx/5GhixcnCSRKQ2ivGjt4phqSGpnEFzX7gB0bp3vYOZ16EYm9Aj?=
 =?us-ascii?Q?7xpCIleKSMTlNP1iGk1AQuvUBrljzM1YEzl+2Zjn524TYNg8nYyBToeSAGs3?=
 =?us-ascii?Q?yWdbgqeQrbvnwv89jk7pLRW0pLY0p04sSoyJAuvXrRCGQn4GEc+RqAWTORri?=
 =?us-ascii?Q?Ovlcq4e2fo+sQhPhFmdcRXoD18dUH3BSYQJ19XysCCnFEkmKpvvZDs39f6eW?=
 =?us-ascii?Q?vo3psqKiHNSec4JYNbR3Q3vREU420cYbd6YKh7sqz6HdV/mi+Qe0HYfxVOwb?=
 =?us-ascii?Q?FiK+uxEnxJ4ESuaL4dE8nJ4hnwl+mRFTBbwfSo//lTh+CsdBfgWtN+SZ9+oI?=
 =?us-ascii?Q?NT5Mi+U+qqE3aQzs48MC2geQfnKD2z+QcCVoeaZuDRpxauU4aVb2OYJvsltb?=
 =?us-ascii?Q?rbvW/Cabpo6c/ohibS68wCgPtNfIT5qkIKgs/PADmXwtCzLu1onmUjcddHHQ?=
 =?us-ascii?Q?ERgIyIFngqmxFbrr/iweHDv0tkrnEzId5wPjCGXjdfTABRRnw+TDtWrixKQu?=
 =?us-ascii?Q?rjczGcD32ejYsWuIxz7QgtcrPfjp65BJ7pP95c2SrPJRXuQbqS/WxnM5LtQn?=
 =?us-ascii?Q?OLo/mbzVIPTVIEyj7/WiIUtsG454xgQMCBWfpP3PlJatKH4rIyax18UP81p7?=
 =?us-ascii?Q?N0q0opHx6ffNPpeuEKzxcHLejDqNyj2JaZwkkUYOCm+nPbjF9wR7j47in7+9?=
 =?us-ascii?Q?gHbnbp9xlZimPe1uUyYHMS68xu/bbZw31liiqCk0xhpm0IGi0Rg5tVTFnGRY?=
 =?us-ascii?Q?9rVpi2twvxFDqmD4tOx43vS3cp9qmDLsCOg/Ua1I1MSaZPSM/bjboGiMZrZl?=
 =?us-ascii?Q?c9Vwr7XUsTmStELpFAQ2KeGKM7d+YaEN9IqFBp/ipiQhEFGrP/RDFG4mE+ny?=
 =?us-ascii?Q?s6U3bMeJTl2WcHzssplOrqDR2DteDB38oNpcsz1AW8aUY19+IQl39ERv3VUP?=
 =?us-ascii?Q?bL26YIPGPYvemNZLd9lL1aEH+yUpa+x1HNlWV+WNvj4IpsZ2n8ILiGABRdss?=
 =?us-ascii?Q?u8JYCD+Ujr2kYHDJxnyLbsRH7cCfQ0v15/W7GmnfSDQmNbAaUKmdQnWuMJV7?=
 =?us-ascii?Q?O/hjvTateE2Z7A8hjjNP3X+XjLT4s3YKhcUn/7fTl7SDs/b1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7a908d-9b57-4967-7af1-08df39eb8719
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:46:25.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTN7E7jA4CagsyqbDOPvDVBqtoTDMnMVM8kae2ojtcZFcya4DPfT6T0OapFfK787luoId7JNBjPuLzI96nNerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Tue, Oct 20, 2026 at 11:19:20AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Error Disconnect Recover (EDR) is the ACPI half of the hybrid DPC model,
> where firmware owns DPC and notifies the OS of containment events.
> 
> CONFIG_PCIE_EDR made EDR optional on top of CONFIG_PCIE_DPC.  This adds
> another knob to the decision to request DPC control in _OSC.  The OS
> requests DPC control only if it also supports EDR, so with
> CONFIG_PCIE_EDR=n it never requests DPC control.  There is little reason
> to build DPC without EDR on ACPI systems.
> 
> Remove the option and build edr.c whenever CONFIG_PCIE_DPC and
> CONFIG_ACPI are both enabled.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c   | 6 +++---
>  drivers/pci/pcie/Kconfig  | 9 ---------
>  drivers/pci/pcie/Makefile | 5 ++++-
>  drivers/pci/pcie/dpc.c    | 5 +++--
>  include/linux/pci-acpi.h  | 4 ++--
>  5 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index a1a9c06012f8..b0e0b33e3254 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -438,7 +438,7 @@ static u32 calculate_support(void)
>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>  	if (pci_msi_enabled())
>  		support |= OSC_PCI_MSI_SUPPORT;
> -	if (IS_ENABLED(CONFIG_PCIE_EDR))
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>  		support |= OSC_PCI_EDR_SUPPORT;
>  
>  	return support;
> @@ -515,9 +515,9 @@ static u32 calculate_control(void)
>  	 * Per the Downstream Port Containment Related Enhancements ECN to
>  	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>  	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> -	 * and EDR.
> +	 * and EDR.  EDR is always built with DPC on ACPI systems.
>  	 */
> -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>  		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>  
>  	return control;
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 207c2deae35f..de4ea33b4524 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -137,12 +137,3 @@ config PCIE_PTM
>  	  This is only useful if you have devices that support PTM, but it
>  	  is safe to enable even if you don't.
>  
> -config PCIE_EDR
> -	bool "PCI Express Error Disconnect Recover support"
> -	depends on PCIE_DPC && ACPI
> -	help
> -	  This option adds Error Disconnect Recover support as specified
> -	  in the Downstream Port Containment Related Enhancements ECN to
> -	  the PCI Firmware Specification r3.2.  Enable this if you want to
> -	  support hybrid DPC model which uses both firmware and OS to
> -	  implement DPC.

What about keeping 'PCIE_EDR' and using it like 'PCIE_PME'?

IOW, remove the user-visible parts have it default to (PCIE_DPC &&
ACPI)?

I understand EDR as its own feature on top of DPC. So I think there's
value in having the EDR bits clearly distinct from the DPC bits.

Also, it would reduce the changes in this patch.

> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304..46b24311f659 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -13,4 +13,7 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>  obj-$(CONFIG_PCIE_PTM)		+= ptm.o
> -obj-$(CONFIG_PCIE_EDR)		+= edr.o
> +
> +ifdef CONFIG_ACPI
> +obj-$(CONFIG_PCIE_DPC)		+= edr.o
> +endif
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 104ff2b91f1f..71adc0e94bca 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -109,10 +109,11 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>  
>  	/*
>  	 * Synchronization between hotplug and DPC is not supported
> -	 * if DPC is owned by firmware and EDR is not enabled.
> +	 * if DPC is owned by firmware and there is no EDR, i.e., on
> +	 * non-ACPI systems.
>  	 */
>  	host = pci_find_host_bridge(pdev->bus);
> -	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_ACPI))
>  		return false;
>  

This seems like dead code, and it was deleted in an older version.

The conditions seem to be mutually exclusive.

Maybe it should just be removed in a pre-patch?

Thanks,
Yazen
