Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021140.outbound.protection.outlook.com [52.101.125.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416902D63F6
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996904; cv=fail; b=i2nqLyayuWiZ4Ml4TEg2TIWwRk/snOQunuL4h32Hp96DQHwQdfU1/niYl+GUIZvtZWCSnzHULBTV9P+8E6zp2mzgiZtD3sglrhTi3jkl/n+W9Y+DDJ3/Bi0x8FvECG+i4q4ABw/ecu9caXNGdMx14xuK/OrYgoMV41KGrLmquno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996904; c=relaxed/simple;
	bh=UY2M7U5ygslqIG6ErpjR7O3QvqegAza2iUNE4sYaaOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wnzr+dAgKK/uV6ZZGg6HwOiZKkp/c7TzcPYMGIjFOSfEzUhJeipD5ZT45l+CrrqFN2+aOPQZK8HbbqP9yPqLh37/aOXvmdnAIeqoS/SRUfp9qz3aI+R43y5XiwGrWAP+c1aoEElL9tcJM1wfY708LLCcN6kcFWrh9wggSyfge74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=u+B1MfFB; arc=fail smtp.client-ip=52.101.125.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="u+B1MfFB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEcRmJ6kHXv7CWcXqw4eq+Dh9wQOGp4KkccEDCTnvffthVzq/rN8V0GOBqVuAqmx+2kjF2OKHlPIkZsq9u5JozeMF2hUyv4/zOBNZLH53yoPi5ujBoh/7lwWJVgV9r5ED82GDMMyzjql+5AczzxlXca/uq7jYaUmOH7dYO9ixZOcXUzk3UZd3UnKN3rnqgrVPYnPqH0i3pqOS11SfcjZTO/rCahhHsgYH9/bL4KdPZXHLfORye3ZQtPBQaYZ6k7NTXqHekkcwzA7qCBt9JH9ZHUFHClq4gYZmhL6ED6qmR8yCs318TDNtCwhBA+F1NAqqg9Y7sYuCMI+iDAdXB7zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRIwDxhNU/CwFx6f1uFGp5d2TiYE3oDACULkt7U94dU=;
 b=FC/knC4ZqdBBN1azlpJaHlijarcRzq1cMfIroaLDlpBM8d/x9prsan7HZH2/eC+pHRsR9uyBtmBMl2y53KX19vzEDdMcjU2lBW5S7ATXMU+fI7RCeJsfnHQU3jxmVL948pGz0ipv5cG1AY5Ehqlfmmn/wjy7sO1lez0TS8BDPTtmTak1Ad9wY2/uhwFcxAU1Rjm/+n1ymS+UrdupysZs2thVSvrEFm1KIj/+lw63wFkZzRyNRZUV9tTjwQc6hywfbqR/aW0mwZvVB0128U31EMtQpR/YpIM8bb9yjsliRsxXnyj/ssOpMxAmpPQTNMCs5fSo3dvYHgru9nA2dlGSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRIwDxhNU/CwFx6f1uFGp5d2TiYE3oDACULkt7U94dU=;
 b=u+B1MfFBNMSWAyjqwgfo+yVFUUtaftpZL9Qq99jCQjprht1SAeHgD3EodYwSE088WsDb/R0WfuKk6FjbRIxDhe5rvEItiGo0nZ4nJV+ZKWq+AUBfvCltJB6HfT18RFXaydtOvPGTcA7HtPlYmWqukzUBiwiQhubRMgt4cAMqdLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5504.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:25c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 05:21:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:21:40 +0000
Date: Wed, 25 Feb 2026 14:21:38 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: cassel@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Check
 pci_epc_get_features() return value
Message-ID: <l634rs2neo22jkdlpldkvraqzapi5pj6kz6j7gcpqz4xkd7c7y@5ar7zor4f3q6>
References: <20260224133112.1356612-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133112.1356612-1-alok.a.tiwari@oracle.com>
X-ClientProxiedBy: TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: a506bfbf-6d92-4c4b-b08d-08de742dc16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IHoe8PPHIteP+d0BvSukEDZRX2dCY5T/5own3QUokt/xAuZ1E5LwhpkxmfIm?=
 =?us-ascii?Q?uY2CDHu86jf6jDPHBsxwMZGi469WtUFQrbiGxzHiNMPB6pdhIZfDbsbumpGQ?=
 =?us-ascii?Q?QeiqRuibQ0Gee5ghHZJ8VIXehZ9C4OJhN/bUiSOpeXwMRHzYhBb/oK8YtI5G?=
 =?us-ascii?Q?iFy2jdMs42EZYyraxF/DH+HF4OK3/t2vhoUBXuOoz9u3KKrz8kM2gf6h7naG?=
 =?us-ascii?Q?zhzXbpj4yBNEvOlDvdThnG8uSOD0fhD2t0KUxNBiNxCYagY3zYKfJdCKAV+I?=
 =?us-ascii?Q?2mo3Ne1XzAPTDgFJw38zhJ+z/eI7P2Gr9+Tqm6x7OwpzWI0MuYQqNfRZJv3i?=
 =?us-ascii?Q?0ilF+m0S1wF1Nj3Lc4HO3AtneYrNzdhSVCItARuZhpsFW4me39gMyI2rzkIG?=
 =?us-ascii?Q?W+Wff55UHAhw5UewLO00NdoZphC0ZrCU3oYILNXToFdpXVRrGYB0Ut7syI8u?=
 =?us-ascii?Q?gMdCcXf3yLwCGcVYLLwD89mqG15e4wC0EW1s+8wvk/NjoAJC7rwL5RXdgc0a?=
 =?us-ascii?Q?IDPGu5JdDLnvaf8tRUFjgV+NJZ3jW0RR44xy6eqIR83jae8Hm9JbDHJG8+5O?=
 =?us-ascii?Q?+EgQe6mNZfHNjhIHpBeLnpdlwmPU2nSCrG/IUXcU0kDgaa3JLibVUtfNwwgC?=
 =?us-ascii?Q?89UMDNMXc+bSHihDj8xR9C5hVnqRvlzzmU8hd/9y8jvmSzkSffAqx8oxddd6?=
 =?us-ascii?Q?04UYe51zZD60PDCeOml317MbaYM10PcNemdwYjWmjxhpT+TndasHHygCeyNF?=
 =?us-ascii?Q?BC3aWanskFVeUL0tZiflKJ2gR3ORHk0BxHmgyAERKk96GIv1EL3FdMrXlel9?=
 =?us-ascii?Q?6X9oVoihvP15u55vFb/BaHdHJm9VZKd7FeLESMlt2xFTrTxXT0Rr6M3SouD1?=
 =?us-ascii?Q?mvYWI5u3ZO4ni1R/dQpZRLrt/R2mwXh+MeEs81SWVr2ITPvxyC0bSTK/x7xY?=
 =?us-ascii?Q?JbZom+cEQ7edlfxyz53p70ngWLPSnBsK4etEf/MV47a592WEq0goDlkVv3Ep?=
 =?us-ascii?Q?tPhTqwta2HpTZJSqsPpzTVnzLLdO7w6TG8z0aTjUGDSNdVNL+dsmdvgT7mla?=
 =?us-ascii?Q?YPTtDS0fsxZJi1D6sz+f6ywTPcp8CzM8Jk27gTcBEXCObwgOm9i/1ODeFHge?=
 =?us-ascii?Q?EHqZc7l5cjZsCnEjpYlrYbNy3cdPo9iw6HEspq3FVluP45QwG430qRy8hPWz?=
 =?us-ascii?Q?d8DzNoJhVJcdwZGUSuCQcaUTuw7BdD2+VoE62VvO3NgS0QW7ShiZ4fSt0iJ7?=
 =?us-ascii?Q?esyxnLSG5CoZKB9X/RQVTmA3bWEgArK5ATbYj5T+zdWZU4i5S1dwcc1GSwXV?=
 =?us-ascii?Q?R2oV1nB2+oG8rAW3o2HBAWaMHpGhow0hICAzEOT8ZgWQHU5ybApqUFqjCM6u?=
 =?us-ascii?Q?Iz3tnDTN2rJAqPr78gc8VZBk9lV2hgENvi43t3TPtUTngDI5CPz2NUQsE4XV?=
 =?us-ascii?Q?mJna8owoiQGKYx8W8f4aFrVaYDkGUIUg3juvrldXqP8MdeY+jfOoJPS+KNFm?=
 =?us-ascii?Q?auE8nI9Z45a8QFKqbcSTF9wYeDMT+obowRGXTy4Img+Ss8xBV/H6cGNXvJuc?=
 =?us-ascii?Q?frAC/dIlgJqh7+hRG2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1f2uyZoV5/0E3XP9S6fPJnvQN6I4QELe3DdBS8YjY2kGeXtEbzozDTwWsR93?=
 =?us-ascii?Q?C4lA+hl53kFCZj1hK2J7mOSTGsgBUTslgLQTgPDEiiSlGF4smQV0hdVXJ6s1?=
 =?us-ascii?Q?OJM2ZtRUHO8QyLIZlytBtQO5DM1AuLaQrSXvnMRefMfLPEaF3odwIRqei+/U?=
 =?us-ascii?Q?foQizIkSADnMaFWapYFRuy9QYgsegciZInOgHznTBX+4AvTm4VpiX4jlcZfQ?=
 =?us-ascii?Q?K58mHrLaa6VtQ9wJ/t/61Y9joGMLY1SknW5cOYUrymVRNbKaebT/RgtNDUOz?=
 =?us-ascii?Q?BcSKCXMdk1cblu+grAR6PZ9h4eaRN1cpA8LWB/M19wiUBWBBFdPox8RI+jzI?=
 =?us-ascii?Q?/yiIsbWt5l7aUKkTMxHeQyRrjfsbLC3pz2HlL1uijOikfcvPUJ9u59fu/BvJ?=
 =?us-ascii?Q?L1wTLHb4Ua2xxRtlDhS+7AigRild3ySqp4DmPYhVQ0abe3IDoiFFtZZb2ab1?=
 =?us-ascii?Q?ptbquESVh0hI/FkI2CbM+nRfOeZYNFv9XRQZkClSu82POd43w2THIfSj/gLQ?=
 =?us-ascii?Q?jNqdFfy3SMVrnadQglkTn5n7IzH5xeQyasLwy2eyywCPTQskfM3jNsVgRVTI?=
 =?us-ascii?Q?5Lr/oOw7nl77VFquhCd/0POqtn9gqNy9Q57eYESQ0v0zs3nVk8dNwyPOCuLT?=
 =?us-ascii?Q?LS5d3siBLsMvICOJCQd/2i/K1RAwqfw1d3dE/D4tzAgBMexqprdB4qWGm0j2?=
 =?us-ascii?Q?VqMiYF+r8P727CKa97A0G9Dpzb8MNUKK/K2xsrk7nxlIkxd9r6MVz9qW/XMF?=
 =?us-ascii?Q?NeNuvP8Q0n/FSDCkaerlA8s0+28I7R5bReYhMWG0OWhse5jC0Djn5ZIcyxnC?=
 =?us-ascii?Q?QIBLjkWmmiQc8JP290Pqtwh+W6YLsv6FIAGButNhCn4ekB/Yv/LnoEEPfkjl?=
 =?us-ascii?Q?QyvSYL8Y1iSOFcAlw55U2BvS7bRuPQi6iqkMhE9WHjHvo58yMKAkICNvGVxn?=
 =?us-ascii?Q?WkfpqYRQDxUkxUhNfyDtcc4f9VOSVCFy9CPurt8lx3t85DZAIIYQe241VxsX?=
 =?us-ascii?Q?WYpB99cxQdUoXvTlvoG8h0/96PE3+hJk5DlPGB/Vvv5jaATCsKG/yxMlkJvh?=
 =?us-ascii?Q?3gAlvC6N1HtnozuxmptayIfJnoShWQpLP1yVKSjBmdkMW61/dWBp8xcok560?=
 =?us-ascii?Q?oczw722WRzL39zDBH4OIVdCkAd7+6YdQmFA/BXPTJucqO1WijQlhaAsCQ9uF?=
 =?us-ascii?Q?NQ9HyNRgQ07N5fMkypf/h78R+Cpn4ENj18tkLRRXhzxAyL6hTmygG+jxSbRZ?=
 =?us-ascii?Q?MWCMQ5wlRVGlOngzpVbt5FHf6dC7Mu14A9ObIGSK8VPCQFaB92o9bcm+PH6Y?=
 =?us-ascii?Q?uRSziJ9qoQuWdEuUVygaoA2FKIsaz81NFvhLA1Tofo9BLiQh83/YdrVXWdQL?=
 =?us-ascii?Q?19cLUcdSO3FGtAJRNCMeaRwDdXLJY3SmvpOD1Hn0VnxPJy0ec5pOiyTuNNGd?=
 =?us-ascii?Q?hi/tJDlleRl4kbCtTKqzfXh6WDLOULRluVihA6grrJuE8DyR4KKhb1WfJfIb?=
 =?us-ascii?Q?YvZX3S47g1CQHLgP1AUDb9I13MkFvb4wBS0IUAcde4Sbgkmc4UJH4d5Kv4S+?=
 =?us-ascii?Q?ImQ1erVOvgdwdkYyMq04DWTJIDBu96FQRUz+upq6r7Mssz4+oLrxzq+i9Rqr?=
 =?us-ascii?Q?ngR1v3DYVyHJCLzurMx4FONK9ugm3hHFSJUD5v8uSTMltvB3E2YfDzdDY3az?=
 =?us-ascii?Q?HIdY7rVz1E8KnWuzxKx1KRDcgf9CsW/q+eqZzOMMLYY50CNel9eu/n2ESPtm?=
 =?us-ascii?Q?JCX9EulfA4EuCLqYUu7vllFjj2ZHCr9yl+bU0gWfVNYbPtpAsnLp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a506bfbf-6d92-4c4b-b08d-08de742dc16a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:21:40.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cr7JZZ1oxpMEk69+YHxxkhRHYZVbcxGQa2ZN431vW5Bw7bg9FULY/AuES5kHzPaxzgoArHcBnRZ/Jg1PCRaEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5504

On Tue, Feb 24, 2026 at 05:31:03AM -0800, Alok Tiwari wrote:
> pci_epc_get_features() may return NULL for invalid function numbers or
> if the EPC driver does not provide feature information. Other EPF drivers
> such as pci-epf-ntb.c and pci-epf-test.c already handle this case.
> 
> Add a defensive NULL check to avoid a potential NULL pointer dereference.
> 
> No functional change intended.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Hi Alok,

Thanks for picking this up. I have a similar view to Niklas [1], so if you
agree, I'll wait for a respin.
[1] https://lore.kernel.org/linux-pci/hew5wbd4fkaqlykv763wss3jirv52b5fyypzirvywysldbw5hh@qpds3syxgxgc/

Best regards,
Koichiro

> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20a400e83439..93943e4497a6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -438,6 +438,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
>  								epf->func_no,
>  								epf->vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>  	spad_count = ntb->spad_count;
>  
> @@ -489,6 +491,8 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	dev = &ntb->epf->dev;
>  
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
>  
>  	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
>  		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
> @@ -624,6 +628,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  	epf_bar = &ntb->epf->bar[barno];
>  
> @@ -852,6 +858,8 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	num_mws = ntb->num_mws;
>  	dev = &ntb->epf->dev;
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
>  
>  	/* These are required BARs which are mandatory for NTB functionality */
>  	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
> -- 
> 2.50.1
> 
