Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793735273;
	b=reMRtDWvQ2jS0iSuppTRboQlgo//B0j+PE2KF7GP/EJORwJd836+EOrtTEk8q8+hgrwA
	 G5FvOSdvoU3Bs190J5y7DD0sOZMofO/ULzrIcgzF2B4usPCFJo1aUcr62Q2Y9vw/1FA8s
	 TNmMU03O+RzPt6d7HRwiaI/jeogQmUxXG12dHjxFQ0lLzfQN9HUh1BdZ5Wvj0RKCZYc+4
	 2AJR2yabxvTU1RMXoteOP/hJckuBWlHS7aFAcTMKKPbbZ6tBrwplaO79UIzyzpUdZWVdw
	 cLAUDjYPkRNzqqwotNAk+iS6s1mjhc8im4XlrmfDVxCByKAZMaDWzeKR1JPAZEGhoug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735273;
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
	bh=hVEFEWSi2oMht2RAJ28CZ0oXCm1B65IFoTrsA8yR13s=;
	b=uUsNITvD0c/t0KL2tpVO9QKknrFyD3KIXdOL9CEt1uJcKpmCgz48uNXarJj+N7LlrzIo
	 D0S+piAn+RlNlnSJYqxm5MRRrPUKZd0HcLz+KltcTJ7P0QQXOD6LmBXxawyAUpsdFnaRu
	 bohrWzj1F8a+ZD0nsc3aVoljYj3ux38RxODMZba+0wYfo3n8Njz9xdySXwNZYFMDH8N5Q
	 GtEh8xS8xcnGW82DJoXaygExPvGJrEEsxa5UjGirgMnW3Y5KxwKKOKYeWiooZFcFkJs83
	 4Ne1CfqJae6NxhoQ07rdzekZJiAfAr8zU0az8qD+0t+7kIj+59bc7t99nLAA5js+5Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="xeIg/2+X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.63
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90785606D805;
	Tue,  3 Nov 2026 19:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90785606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xeIg/2+X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqIFOqOHHfcThayGIWTwXpU6JJGKFLWYnzEIJA3aHxiWF2F8ba9oKtvqVWuhAuVyGWkkaceSjIMLqssCkmxIh+UhBrT1MchaLLybGs17V0VfBbGkTPCLq945wVPzZlFom7bQQYXk/7Z0s0hAxG2RZ1sLi+sst2owWktsgd6xvw6UOJmboV+bC3SIWMzDu7QsNx0PpRk1lc+0U7HUL6I+lAuSdCmB/DxGgQHa/X/cWClr473rin3GcCb/po+gjfMppD3iV1BnIx94bwEoI2NKgJobGHOrXHHASx1Z6zYCCEAx1GKhA6qioaw3jlg5jZKSbxFpe9tSTADa8r/i7QdMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVEFEWSi2oMht2RAJ28CZ0oXCm1B65IFoTrsA8yR13s=;
 b=Aetzn/pzYg1vZ+yE2VbDS5AmbwOfKt+aK8DL18IuxAY9qWMNwSdoWCstdLgro08Pp7UFaR/LDjg6RWQe0TmHZVlPziWNksG2s8YBL6Uh604Pi5gMRl22dSLaRofSgCaGrbpt2RlQOr7MDh4J5ajGFWcvbsZLtEG8g5mr1qo7KJ8eADOmsEn5swNNXs6RV42vvgtPZR33fer4Bzgly7UzEKPZVHFSYJOGD6cCegl4+x4n+GHPMPzg5QWLQXpOTQv3/Ndkem/4HMXJcC/yuwdpuAq4XHh7sfuYEtqR+xDk6T6Pl/M3JfW4kAttdt1CNlA3HqOpf0z7hL1XZPyzEUaxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVEFEWSi2oMht2RAJ28CZ0oXCm1B65IFoTrsA8yR13s=;
 b=xeIg/2+X7ONvdNinNBxuZkpfM053cuuo7I4Fkj1NcDsURn0roOIPU0iAmtRAboR0bl1xAJBxBEcAHVdaQXK17GlIono6/0/+FlCcCLtptJDTDP4padEtf+oGzKM60bmmwWHHBa92iMiZmLh8L81wLJ+khrcPIyfVxcFydAzZyq4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 19:47:44 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 19:47:44 +0000
Date: Tue, 3 Nov 2026 14:47:34 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] PCI/DPC: Avoid access to non-existent AER
 capability
Message-ID: <20261103194734.GA314988@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: CH0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:610:e4::24) To DM4PR12MB6374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: df8fbcc7-43fe-4ffd-4072-08df39e353c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|3023799007|56012099006|4143699003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|11063799006|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	UNksAFS3as4vEUa6gXQi7wDQyV5aZNFArU+vAyhyic9O3U0gpqZRiwM8feOAqwg7gXnD7jjU7AyQLdvlFJOxYfcRxizLyvLt13bDY6Lu4KXl0CMHMELTCEeGnaiI2mrd90RrJDwNu8pooPPIPzfpmLLAx4cOte7zUEA4CZPwqlhVnVqpLj0jFacEBiAhC76Wk9K3oBw8cTzR6IqN8FSZHL7Ji8QjxaPPAC9r/Rj1E6BUk4YsjE+Yfm+7ubPp4X/qKkki0Amb8EqaBvBp+kvfHBNvRK+UMWnSK0PxC6HI8GtRjbgGGOomj2m8o1XJLErH3B0VJroGj/lGWGCnHFkfabtrrtGsFUavDL/HsQRL9hPeMwa8JVMHjmV0u+wUrnC1cSKNS64Y7xlfeXrZ65cyKHBiy3u4rxkR/CSxAv0J/93hLbHFQRfXtq+z8iiguVlHtH39sRwCjeqHzmy39/W52QrTPPcop0HIY2f/JCgdpbqfTKnMxfCTm7fS4plrfN3y6M0VCqzml2f8ju2EXo8zR6OeM1JQHV5x91XA927+f37AKFTKd+3kq234kwHzGJS13hLL0hdfTn8nW98b3LorSp6vMD9uguemBgKIEWWnX7wm6l8wS+9BcgtnaTvkHOUX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvDB43eRq+1riGpi4vDG0iqXSfZZ8WYuq3Zrt+Vu/LXUSTvhOA2fe9IGyXoJ?=
 =?us-ascii?Q?r7Ez4IBZec420YmGdgi38wOJIyRQfE4Y9jv/olCCnL7/JCWXy4OSYqbENRbX?=
 =?us-ascii?Q?sIxeajVUJIDcWS3SXGZR7Y8LgHfgfGzPl6xA8AOf84niWqHA79Dah8/4lUJP?=
 =?us-ascii?Q?znwakAskDDORMtMX+WJUUb644B9twdS0bRv12xmnzFtZp8K2jM6PcpOZrb26?=
 =?us-ascii?Q?jC7E9WBKkQDt/r1g4XGpCjxw2S7X95TVIgajgXi4edPgxZgYEr6/zEfzxux+?=
 =?us-ascii?Q?6Bq/6bRqNiGNt7DZfJuMjybBPPbTpEkV/TcIKbQtN5U0O7ecd9sP0wTs0FaY?=
 =?us-ascii?Q?Q1kMHMSGK4EQwWUM+5vd7V8YAejguTWwdeQz+1vHwye40+4O7A6XRIYLYEMU?=
 =?us-ascii?Q?hEOIs3cn9z1+AkmlpH+4EzN7VUsukj04PMYkwZxymu+EIRMeZAxkPYccCRfz?=
 =?us-ascii?Q?TXFGq9knzXqEviE/yfrY2MZOZ+p2fdZbebS/CV2npxDs21gJt3n6/yZ3aO87?=
 =?us-ascii?Q?M90nWpJoAZwd7OoxH/lIx2RNT7lRzyEV6aoYNvCmYJBzzwd52oWRw6o11dXH?=
 =?us-ascii?Q?gou/TcnOH5R7KaVYfgMWq5Ut8gxHBHLVJyiVbxNH+JboA5S0Qyv5v6dMCv0F?=
 =?us-ascii?Q?sb5EYHSFLDGO2DiUyBuj/pgqnpAzmmjRw205PqpFLU+8pzbCYm9+ARQ7zxJJ?=
 =?us-ascii?Q?nnIWxa04aBJ6xa963Oq6/qWurIxYNRLIpIDGHSi/Ffq+kgNBnbfpAr2FnJjg?=
 =?us-ascii?Q?W0XKC/8k8sC+v5KUS0x+QAr746VtLpQRaojRtbLnw44JsxwcH2nl76oNBYA0?=
 =?us-ascii?Q?cjY3+14TVsZ7I3sds+XOMcw604we5/3GtLbD/c/3eJEROxfgWuxFsuoV+4pX?=
 =?us-ascii?Q?evclbbZ5V8riUOzU+5zeX4PwbsxfBciqc+e2jsz1JijY/FOjcA/tEQsUoE+h?=
 =?us-ascii?Q?QMGTQuzhjxKu2mIKxLw7VdlVc9U+KUhctVPKfkOY/2Kzd+Dfu2tkwHSX1D2o?=
 =?us-ascii?Q?u7DqstzaZRexdWtT9vXk2BXKBbn7N97b9K+srfI2J4iKj8eiYIOos8aBZUFA?=
 =?us-ascii?Q?h/MNAExU/4t8yf28JoHf5wVuFt3GIBBpiz1XUsj43xfp4A5uhzZY52BDuHvO?=
 =?us-ascii?Q?XfjcwfBK2TJFQmkkZwsvYAXPh3p/6MyzwYkjXbB8Vk0fwSAc+YjVil9pOUrq?=
 =?us-ascii?Q?srfg8hGOxVAgclYtGnc8v91SnlbMGavA59by54cTH9dDNrjV/31KpAHbF+V3?=
 =?us-ascii?Q?pJHXaav5alwrbd/vsCBTdi59ctS0k98l8ivW52KWfNQhoON9HZzirjCs+qd1?=
 =?us-ascii?Q?YzwrzttAry00+zTyeZpeghZM7IWNqehNAAARhVuyZ4wGujxyAlEblbZkzZdh?=
 =?us-ascii?Q?x2n2ZIyhTijBlFvSxFrhT+7rocJTokmxzJXWfYLIy4piIT+Nl2XmffTAkjjr?=
 =?us-ascii?Q?HsJ2C9jYBqm7RRAEfkGEiW6i/lwmi7FC53I9hZaFVUNO1+4xO8t+Lp9kTcvI?=
 =?us-ascii?Q?woBAXrQrfs2Nf3peu47+yxwLr28PznHp7EAXiMWAwvBihSonCIABtYnaQAa3?=
 =?us-ascii?Q?tw1NJdaCED/seVr5IV+EScZHhJDEgv30apSP3PyGasHlitNhwIZWfs/HXmPv?=
 =?us-ascii?Q?OCTLJAk1XOq440gLwSIUILqhoGQyZN8+9chWg+zsHrd/91INAwo66NYgJzDk?=
 =?us-ascii?Q?BuYJMytAbZYjTNLV1QCg8NQiNlo7FtpCDlNapxpz6SdP8B5l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8fbcc7-43fe-4ffd-4072-08df39e353c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 19:47:43.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we5ufWLbexONXjvxdVF1vx35Ynep4wsBfAHpMNyiQEF18pa0LilN5lZAXUhmNCisWxO/sN8LHT/m9+7FZ2LzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

On Tue, Oct 20, 2026 at 11:19:18AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
> 
> In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
> parsing for AER ownership") fixed it by inserting a call to
> pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
> of an AER capability.
> 
> However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=dpc-native" to allow DPC without AER control") made it
> possible to override the check:  The DPC driver may access a non-existent
> AER capability if "pcie_ports=dpc-native" is passed on the command line.
> 
> Fix it by making the DPC driver cope with AER-unsupporting Downstream
> Ports.
> 
> There are two places where the AER capability is accessed:
> 
> - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
>   Non-Fatal Error triggered DPC.  Access the Device Status Register
>   instead, in accordance with PCIe r7.1 sec 6.2.5.
> 
> - dpc_is_surprise_removal() uses it to detect whether a Surprise Down
>   Error triggered DPC.  Return false on AER-unsupporting devices.  The
>   function works around an AMD-specific quirk and it seems reasonable to
>   assume that all affected products are AER-supporting.  In any case the
>   detection is not possible without AER capability.
> 
> Insert a temporary check for an AER capability after the call to
> aer_get_device_error_info() because the function currently returns false
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
> 
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.5+
> ---
>  drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861..793a799053f1 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  					  struct aer_err_info *info)
>  {
> -	int pos = dev->aer_cap;
> -	u32 status, mask, sev;
> +	u16 devsta;
>  
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> -	status &= ~mask;
> -	if (!status)
> -		return 0;
> -
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> -	status &= sev;
> -	if (status)
> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +	if (devsta & PCI_EXP_DEVSTA_FED)
>  		info->severity = AER_FATAL;
> -	else
> +	else if (devsta & PCI_EXP_DEVSTA_NFED)
>  		info->severity = AER_NONFATAL;
> +	else
> +		return 0;
>  
>  	info->level = KERN_ERR;

Did you settle your question from here?

https://lore.kernel.org/all/74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com/

Thanks,
Yazen
