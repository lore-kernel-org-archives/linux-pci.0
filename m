Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807878;
	b=3nLDMYJIHNj1gMpJIGJiZHfif2F6/JDKkBlqTmToSI7sYzcgWCOAT2VLC5K/nSDKevZm
	 VWym7bKd2wL69jvIcYAMzc75aF7lsoqOnAeqPGM9F40tbq6fWuZx70TJlpZlHyU4b605l
	 aUCENDprtAdmYfEChsWzqdRICjdVsq/MDUDiceQCI9fFBwwyd2JqPvV0LOtnTfHwrBZKt
	 BGH6dGYJQ1mxsZ8OtcGJEFTYiV10RlGVRLJkXycQiXJTHv/ngMt8KSqmzjMS9XD0dE5k0
	 hxXOIajKBGEwtOH2zh5LjWVUouYYoNfQCQuNVVKMStqA/rDfbKXuAB+C6cU4TolzLDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807878;
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
	bh=mdDjmwV4nsuObnRbMtUhN55P1/GkXe+VX/rO020BwWY=;
	b=eKSt5xlEffZTsQ+y4cgAOTKnE30kdPg/kvu61oTQzwvLGVAr5mO/K9wHkOXhnOTfQoWk
	 M0IZf6bzbMOnMWfJLSSMgVS9Q27nV/EP6CpFZB9V8ti/kaa6ghU1zvBKmX0lrb94C7GET
	 AtFBhXXOUgSgJdvX1i1OTaY5Nb9ZqIThCnCeJkKgooLlqNEmqs6rZ6mvoIrED2jwNAiXp
	 zKae5yV22q2n9uwu+kBitXOz3v0D8BrjDpqUZAQN8YJ+um+XP99e2fywx64k1NCxvMSX8
	 pg01cTBYCOIkIIS/LMORFEDuBtPAyI6+fdgd9jMxjx7lAOt9hwGm+eZn3OPKXrgG1Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=33VnZZmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.64
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E376082BCE;
	Wed,  4 Nov 2026 15:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E376082BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=33VnZZmd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehURpujvsMqFDfPbid0hlF25/GlSLGflYwRC0oTdYXeMQlsSB8/dURrnAZm9GWl5e/wZ/dPyw8nYCuVvFIK7295wVIxlLWkVLfVSr1d/gmJSfJJVrPbd0seJ2L2/BkDgULz8r5SWZrmrvLh52UOjQKG/Pysd0MRmgstMBsS1suzdHOgUpJtEjFnNAs7QGno+e8puuf9t4NkMsgjmjcB/fbyfVBAYZbzB0eTfPY09e9yfwiocUZM3+LzVX+l5yULA6DIzWhEJ3aQmpXBnUcARi32mcf5/01R+3cdYaX2usYfL/Dp7/5W2WYwfVCSLZ4b3Z4ZmwtTBeNMXSTI6u2XKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdDjmwV4nsuObnRbMtUhN55P1/GkXe+VX/rO020BwWY=;
 b=fSLOqybFEt15LroGYM1haq0R+86DrgIxH2AjjPwOv2VUrSNwJAarKz0b0lt1R2CWLZpy4Ags/C5S5sEBDqJ1AM+srasVL1nesBOyfq1AXol1qzb5u9voP/k+5kHApeNJfoU3f4FvGn3rCTr/NTJWVPffH5IHvcIAQZZ1Z2qiNE3rmuA6Dvi4taIyw7CfCfSgasrKTs5yMtsu0rx3F96n4tJ29ct1XqoQSwYWXVaIVrEK7atSNSIhWt4ZtXH6UwEsmzh+n4GZ3TkTk7KzhKGEZsUxM4yZuhSraxCfwNLRuwYZkhegICANBkbD7NkRLijptUY2glHgTZThPpIXbQ3Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdDjmwV4nsuObnRbMtUhN55P1/GkXe+VX/rO020BwWY=;
 b=33VnZZmdcbgingqSvlO1yHQhetgT32zTF+w4BsD1YvK1kHnIKElpvfWoMbQbZq3KBHBHoUVlJCT81ljuQu24oYeUSA9CEvsDLFl3XYIrn4AEPOzjym2FU3XxUMLwGE57MkqDhBraUpWJ5odAQAEsc3h5PoByrt9tefDfIX6doAM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 4 Nov 2026 15:57:53 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:57:52 +0000
Date: Wed, 4 Nov 2026 10:57:44 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] PCI/portdrv: Don't require AER to bind DPC service
Message-ID: <20261104155744.GC716491@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To DM4PR12MB6374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c886d40-15e5-40a5-a331-08df3a8c61c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|4143699003|261026121527099003|261102123227099003|261021123027099003|261009223027099003|5023799004|261026140227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	A+IWFCo1jDmBr+Ex03bo2OOKjoKzUn5obwARECGtRF7zII3zxvNXigWw956UUOwftAylVfdARpo1jFh/4utDiUpGFa/zKDXMj3Ll98oO35m5+Mfi7mUgmcGMTQPn8EULT3q3nUz4HPaLCjpPSaMKfHoNlCur1z+cxLzo6DKxkXaZSwm7seD5cA079c2UL7IfhcXfusN/p0wuqLp+fwzq6YSqAco6JS9tQ3ilsU8S/lNm+H9vlooc7BftUy3UIIEPbyV2hhfnR3g2HoKVcz5vH6WYeE4pP5U0BEIyl1kvEUVQAtdv35cYK+gMRocvHvcpM/VftMQkRHziwROnBqevVuLfX1qucnVN7BgKSCWAMJQ7qqHhjZzKHgddvWPaQiJcNdLs5D4ysf+O+U5Nvacw4GQ1nb7vS6+XvjoBB+82K/YEob49WT8dv4xa0G/57TtGb1adVZ07Zj3+rmyQopo1PcmS7Jz8Vb0ctCWY0aUCbH3fWQKFzskbeQLFz+tOaYQE+zBn1xSbOjNF1jB/cTqwKTOfFlBcj8t/6SAK6R2RjmhuTFrZajLiYiFSTLheerOD+APt9aj4GYzSK6Wso0XKgjPRhINNKF50lev69MYHmoyjHyNhaEiaB6v0+JiF11XeOMH2oRqgO5N/H8qRBBl5Kr9YKTHYdmVTVpa20mxPJW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(4143699003)(261026121527099003)(261102123227099003)(261021123027099003)(261009223027099003)(5023799004)(261026140227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X9xInb7hJ0gbc0+5KzhyQQJ6lpA5r9jStutnVQG5V14NWrR6N//4diQ85BR9?=
 =?us-ascii?Q?gVV91DMOhwTDJcIuOe0Q/QO7nx9wt1fWZ62ebJA9AZhM2TQUJB2JsftYFPmi?=
 =?us-ascii?Q?zUKa4W8+/Nv7pbV7uFdTc3jA80P5RNoG9Q0Kb460mGcrCoSjYeuhuu/XnFRZ?=
 =?us-ascii?Q?TF8rR8Da6KdPBVnkVXYZKhS5Bi/I42buAyM6PuT1sbumsv4MmhQxV1fjaMkr?=
 =?us-ascii?Q?tE+WUXnJDXXavfEbO40ioACcD98aMhr/1aHvfvewtL8t/aMX5PMrSd1mej0S?=
 =?us-ascii?Q?LozK7IT4KrA2jW0EVC6OZqEi1SMjijoDbCGhhUW/AdX4naIBK+6kTUqIsopw?=
 =?us-ascii?Q?7VQfq0SsRt/RKMcCotacBUAs7zZA790Bho/hug64JjcZPjBZGq/AU8IPJYJB?=
 =?us-ascii?Q?e5EGLrbxs0zWPoZA0DSGGJjnIb3VZytNasR2JWGXIxHmgEVftVPl8ltfkUOO?=
 =?us-ascii?Q?ibFVQ+XZxS1pCfGsWu7kcH0db3c6F6gSE/acwmuDGdFpzHpyc/Xfdgspubdk?=
 =?us-ascii?Q?dHw/MgFKMCk5llmN4QY2coxpngPmLSBxPcl3tKs3Xkn6542feJsMW/KnvM4U?=
 =?us-ascii?Q?g05VMRpeAI0mAgBXHC9YcRp8WRT0HqvRWwik0UAMlF4nGOJ4HUK5z6Uw4Vqi?=
 =?us-ascii?Q?hscRYMwKOJwT35qysNVza3aFQaNDX1flk/TDm1Cg2qLO+Kr2C5bm4LHiDn7P?=
 =?us-ascii?Q?jon2QLMxdPHrkB4Vs0ig/xhXQNiXgxTuP21xT+bL7wtySCkCHdrkBV9A8GJi?=
 =?us-ascii?Q?YYAm+wTdqIzXoNBKhQqrZ7Viwb8X02HfxBNQHcZHCeh90Lw/gE7iq455BDXH?=
 =?us-ascii?Q?/egZtNlNNtLpPcrsUh1TjVCsmdvJxvDJE8QMzxOXilCEBPXjaccLa6fM5QhE?=
 =?us-ascii?Q?05z/51k68AxX4+KudjNs/hxN/9AzZCbEZcGgJzEz4CtJ1BX0Yj44wH5/Nl/o?=
 =?us-ascii?Q?V0biEkYmEg4OFt4SbadHNM168Ct5fr4HBjWPqimeM201079pxAgehrLl5TGD?=
 =?us-ascii?Q?niTh8onz5j3qZgT8XyyAhOW1i7jWt7Nj511GC4l/Ovhv1qack2jEuKeYTYWw?=
 =?us-ascii?Q?kwuOZVrklju4AwO/D2wSvpXrA/MvVlMRNfGiJhGL8v/8flVAob/tNAHmOQMe?=
 =?us-ascii?Q?tD88eyT+hROON2dF40utJ5Z8myAn+hx8RflT3K3tLYC94OUdl6d+uOcC0jfR?=
 =?us-ascii?Q?+/IA+FqKIlR4yPJn64tbRyfJEe3a7dmmtg3xbH+LHrXYS19Sjto6w3BP0Z5O?=
 =?us-ascii?Q?1Ctkwv+BkY1OflZofckWqkPdqSN42ufs7Kvo2+U6I4JeM2CU/B66vvPuB6jc?=
 =?us-ascii?Q?E6IYFilhr2aC7GyFxfnxPWp9/br0qpIkKfVW/IKH04EpOYbybmXYEKww+E0G?=
 =?us-ascii?Q?ZaGVc1OaOanDILcvr5QVXsBZod4Id0WhwcSH+/vbdcH+s/Glcl0r+lBMXvG0?=
 =?us-ascii?Q?QACJPBCywjMSnZIs9Egzns3IPfCx2v+uRG+1IZ/sHo/uM9USxWCSPiHvLmye?=
 =?us-ascii?Q?kN23mTyq/JqfzM8ny5aVhJvkni7+yBvqEoU4hNw3UHMpoXCXLeNxJMKxxIPS?=
 =?us-ascii?Q?rgG0GbdynkAUy+23Sy0J0/iuqkmoJbqciroeEyWA048b1bqorrQDDvtRRe/h?=
 =?us-ascii?Q?7yBxfgXzLxTR6w5PKjnfwozRERrwFgafp71Ml0I7EU8MtJBWiNZcm2mCRz9Q?=
 =?us-ascii?Q?aXSzRoae+DDzJaL4c0hzskPYLgY7/YYykxTZziUI51ZjN534?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c886d40-15e5-40a5-a331-08df3a8c61c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:57:52.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsKWMW3mjY2VjG3hxMuoRESKnxDPgQUu6HpLdcSnKquLPPCaR84y315U7ZRfBJ15a8Ej+9wbfx1nPgyamtJ5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

On Tue, Oct 20, 2026 at 11:19:21AM -0700, Kuppuswamy Sathyanarayanan wrote:
> get_port_device_capability() binds the DPC service only if
> pci_aer_available() is true.  pci_aer_available() is false with
> "pci=noaer" or when MSI is disabled.
> 
> The DPC driver does not need either of these.  pci_aer_available()
> depends on MSI only because the AER driver does not work with INTx
> (commit 3e77a3f7895e ("PCI: Disable AER with pci=nomsi")).  The DPC
> driver does not depend on MSI or on the AER driver, and it works on
> ports without an AER capability.
> 
> PCIe r7.0 sec 6.2.11 recommends that the OS link control of DPC to
> control of AER.  PCI Firmware r3.3, sec 4.5.2.4, requires the same for
> _OSC.  Both are about ownership, not about using the AER driver.
> host->native_aer and the _OSC negotiation already cover ownership.
> 
> Drop the pci_aer_available() check.
> 
> The changes in behavior are:
> 
>   - ACPI systems booted with "pci=noaer" or with MSI disabled, and with
>     "pcie_ports=native" or "pcie_ports=dpc-native".  The OS now uses DPC
>     there, which is what those options ask for.  Without them nothing
>     changes, because the OS does not request AER control in _OSC, so
>     host->native_aer is not set.
> 
>   - Non-ACPI systems booted with "pci=noaer" or with MSI disabled.
>     host->native_aer is set there, so the OS now uses DPC.  An
>     uncorrectable error that used to be ignored with "pci=noaer" now
>     triggers DPC, which takes the link down and resets the devices below
>     the port.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 32fc623dd410..b77680fd3b75 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -263,7 +263,6 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 * permission to use AER.
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() &&
>  	    (pcie_ports_dpc_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
