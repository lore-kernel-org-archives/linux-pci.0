Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF93BFE31;
	Fri, 26 Jun 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510959; cv=fail; b=bQ9Eeig4l0OtcVU32YJRVtHPNB/hkIMiC4uDdK8VeU4T+5/MaYugmj+4ejQeTpzXMFA1bDTRQrzPZqoLisAMBqITy1Indk1Z1oLIMT/xv/WqjQySzFsTb2R8m41Sn9ISXmrd8G9Hb1VxWy2sMiyG2qJtiFvGRkpih/1q67+MuLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510959; c=relaxed/simple;
	bh=2SXWEdURF2VFnA4vlpwOnicC6oBry5PP8ZtDhYJVH6Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lPRpXBNlgFMFlOKidaRNOWp5Jtx2quGtsbvFmD/Opkjapg9vWSbFhlllAXBiHhJ6/ucu8BvrcfVVpmrI9v7QvMGGA0Yi9LfDStjns+0wj3xx7Twrh9V+go5IYNQ0uVT2a+GJTlzr40rX8u42XwYNcKWSA+Eh+hcMWaK0cuIzQjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aYlonsAg; arc=fail smtp.client-ip=52.101.196.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aYlonsAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMkbbwr3f3ERAwMsQ0azE9E5ItWxdOM3F2zl95OTrZTpyStLYq4MNTvfAksLBpoHEJL/JB4MrJDelC5o0UpqqT0rJ/Rw/1+Yy7T3238Lz5sDp+CXQqplu51pQvJ2evHxXPlEyzQAauFyu3uuq+wXw5wCDKxoa7qTzaQSrloHHJi3y9XsI4Lt3AgpNAyykIxtb8xqqxP+GN+SgGlGA8kzZ7vQTtyHQ+SUcnm8v1B/WgSdFwYZ9RaSQU+9plVXrLHtoYk64IJwSiZf79GCzWw4kIDXwsBkW80wnevvgFed/sBTe3AUJoLIy2cwrmj70m9e8UGLXEge1noOqQ+8S2DzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbyNqs4sPyUNZnM4lTcLmt05lUocSt9sS+NgsDYDlD8=;
 b=hpa/JR7kIV3UR5yS2mNnzdAlHcVauIflNn3KP6ZidXLeZzFPk9etgnWfyuDHdEocCraGofDC3ag1MTDahhkHZ7cXjRlXQpINMgMhBiTU98YW+RhKHzELzSybzSG2iONjMYFrXUF7GT0GTV7ZKYJMiA9qiiZNSMSOkHAtjJ/3yGpgQxyWB9EVVN0pxNzAsrs6zwWZPqFkXjeRR6b/d8sXwVkVoGUc5VlXjOhuAIYDZdCPYrYeQx/zhR0E8u46hKJZYTwqGMB/4boQaY9cAtj9tqDGBsZ2BuWQmxHW0Dc30DPg4rjtZFPLpPsN53C0xcRIMJpVvprAGidf1wjQO+2C0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbyNqs4sPyUNZnM4lTcLmt05lUocSt9sS+NgsDYDlD8=;
 b=aYlonsAgE2sCtxZQnH+dS62F/weo8MeW0oNR7Vn25ODlLqt1gT9dy7Y6a5tOtOxYf6NeSckMIxE+pctMU0xPfH2rIJLb3m9F31OXyayMckgIOTcaGqNlVa8AJ2KBpNsk/SkHFqC4+jQibRfiwmnKps4lGruT4yGMEQqHXj85Hm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7859.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 21:55:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 21:55:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 22:55:52 +0100
Message-Id: <DJJBEB155M4S.E8LMGC56TRNP@garyguo.net>
Cc: <linux-pci@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 3/3] pci: fix UAF when probe runs concurrent to dyn ID
 removal
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Zhenzhong Duan" <zhenzhong.duan@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net>
 <20260626-pci_id_fix-v1-3-a35c803f1b95@garyguo.net>
In-Reply-To: <20260626-pci_id_fix-v1-3-a35c803f1b95@garyguo.net>
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b428aa-70ea-4cd5-bfe3-08ded3cdb173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|4143699003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gkfli5YG0ctaYltPoO8ku1zZ4Bwb/ObnNkPCRix0xWoihJB3EdIVmsG3ksBhvryNGeIsgEDasQ7H9bZMc6xHl6BPcqGNrlsC/97GtLfEYTs4JCbNXMcAGoaVebad6VGVeTvkWQ9xWuR9Ym2RnXFGBY5vxfQBexlGq0QXDR9AKXMnOyHFUp+ug0H7KyPnz8IvHWacu5E4GNAz6Jpmbg1gRmKxbiM83SkFGm4aqVNEY3rYc87mG/Z3ELSdXlFLO6d0U/aXdS7QXBVSCoO7pP95zGSuh4h88qxAb+DwHCFSDqrpk7tP3tASKjW0M5PzU0XXbVSJr7YRgrLF5c7NlFfDPIRIp74GFkR/NN9DD04O/YMWX3+QLVC+Px0VGOqkYJ+WArjYL0TiVEnY09ta33Zx7nmEAwf5tuhsCgN+VYpgW+OdqRilmndUzNPVl7lr1x3cQ/LFm88gxgiNx+FVyTfRFJuonjuofssPZHOqLO0shMoVxMVqmLd1G48inAJHJIeQGUvVB3WoLX9z3LhOOVa6sL05fzdG+c3DEb/xaMgf+QPzhU6v2fblGNMnR3//xct3G9S2lEm+udo4XA1bzYiIoDRQiBPAeP/MWWqtdFDv+lE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(4143699003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhUUHBjZEFLRkplV01oNy80eVBsU2Y1VFFUWnFCNTV4dGJYU0N6N1k1aFl1?=
 =?utf-8?B?Z3A5ZG9La3NKcnR2bmQ0Y0lONVBFSHVrT3dpdjN0RGpCM2hFTzdBMm1HWTJC?=
 =?utf-8?B?Y2pPdldxU3VaR3lxYzM1eWp5NG5rMjI0QzZrWStDNkRrTUxEREpSamIrUVlP?=
 =?utf-8?B?ZVl2RmJSSmVZS0ZleXNkK255ejdsaDFFQXR0OTlnNHI2UHlvM2QrRFM3T1Y1?=
 =?utf-8?B?UU1CL2RaV0xRcyt4NExUV3JZOVBJclpLSDFSbUlva2JZb0pYZzhkSW4yaXpw?=
 =?utf-8?B?czVOREk3TDdnSUZWTzJWRWxuZkM5Z2VxUTRWeWVYZW9udTJNQXREeVJ1cDd5?=
 =?utf-8?B?WHl2bkg0V3NnNTZBTXlKQWlsbTdzSjdvOXVOZEtOVER2QWdTdjl4Q1A0MWRW?=
 =?utf-8?B?cU5JeHI3V2dNczhTbklxbE1HRzYzZTdsMzFuUmxhUG5leEgxVU8xQmgyUW1N?=
 =?utf-8?B?WjQrQjNsZnVXSnZhZnBseFVJaEU1aUlQTG9YQ1ZZK05rMy9qMkRHMTRKMm1D?=
 =?utf-8?B?L3Rqc083TlJUeWo4d0hPWGwrTFdTR21DQ1dEaFhhUXV5SnlTQldEMnpIbktH?=
 =?utf-8?B?VUkzdlArNElETHZpRElIQml4aS90WmJWY3F5UHozdC9nWlI0S05IVUdjYkFW?=
 =?utf-8?B?VGRzaDIybHFJTFc0QWp3V3lTbEJ2QzZRZDJaMXY3WWxZMUo2eVBPK0hNMUhQ?=
 =?utf-8?B?QWxvQWN5ZFlTUnV6bkUvbTR3b00zbmZvbCtZKzNWSzI0cWFrZ21hZ0Fkd3U2?=
 =?utf-8?B?NHU4NDlMVi9pZENUUTNUVnhoaEtIWjN5RTNLMk5STEtieE9hK0RXaUttVnMz?=
 =?utf-8?B?S1hhTXBHTk5wVDRjYTRCREZXZ05xYnRCc29VMXE0eno1WUh4WXBQMHhaSHg2?=
 =?utf-8?B?OUFNb09uNWhLbFIwQzhVUGNhaXJVdnI3c21tMHRoMU55ZFpmbW90cnc1emVn?=
 =?utf-8?B?dWI2YW5VK2ZpczRITTd5dTdoVi8yUWg3aW1WenFDdkRlajl0YVpvOTFzVith?=
 =?utf-8?B?V0tpMmNPTG94ZVZkZ01USjVFVTQvWmh3cDh2S09OQm42VVlVMzVvNkhMZ3Vt?=
 =?utf-8?B?M3BIaEFHblZFMS91ZzJYa0JmbjhsNnpYNGhjUGp1Ry9tWTN4ZzduYzAycFZU?=
 =?utf-8?B?M0hKSCtQWkNuS0RhaXEyQnVBZFduRmVxTnp2bFR4YlhpQk5JdnZWUlBNY20y?=
 =?utf-8?B?QU9hODNtZFB0QkZXUnlqL3p0Szg4cHJ0RC9waGtXMWVBM1IrK0dKUnZxaDQw?=
 =?utf-8?B?cy8vRklYSlNCRlhBVFkxUUEvSGFwdW00bmtzTWlucHI0WUtBZ2lwTmFYNVBD?=
 =?utf-8?B?b0pDUFRTK08zZm1MNDY5dzJNK1lFNFJoNnhXTHNTd1FkeEtZaWRpZklGd0U5?=
 =?utf-8?B?Q3VRS0xLOXlkQS9XS3FvTmhUSVY0NG5kSWZLdUxCL21DWHM2RmE2UUI4VGtn?=
 =?utf-8?B?SWlPajZlOU0wdkFPcll5V3RGd2Vxb0ZrZ1dIWCs0bjNpN0szV3lJaEoyY2Rh?=
 =?utf-8?B?SXNiWVp5T252aVEyeFpnOWJBd1h4UDR6YUZya3NZV1VZek5DMmhPVEZaMU9z?=
 =?utf-8?B?enpGZE5nSm1GUktYcVoyK3RWVWhQVWRyLzBZVmc1VmhCMjc4MTA0MzR2a0xH?=
 =?utf-8?B?UzJycUtmcHJuZjNiMjNsRUdsd21JcmdXaTJ3VXBKdU9vYlhiOHk0L2R1MGRX?=
 =?utf-8?B?TjhITHcxZ1pOWDI2ajFlSjVpS2RMZEN4RzNJSUxGelgxTHprUmxUOTRyMEZi?=
 =?utf-8?B?R244YXEydXUxbm9BZXZZcUFPenZ1NEYyaHZ6MHJCUDAxYUZRVThnYjRLS2ZJ?=
 =?utf-8?B?bkpLL3E3QkJhbGlmWFNGZEt5YWYvY2lBQ0FWaXhNY05rQTNScWJPNVNYUGRG?=
 =?utf-8?B?YWpKOG5zSVpiTUgwckQrbytYZ1JkRU5oOWdUTUtvRVQwcHZqckJEcHRDdkta?=
 =?utf-8?B?KzY4cjhKUHFXQWlvY2dETFF5V1FNdHBaakNTQmlHR2lTNWRSd0NwQjdSanoy?=
 =?utf-8?B?b3pzV2RmeEpzLzJmT20yZXBUVzhZOXo2emQ5UXBqalNGUFlyTGJuMjlyV0NJ?=
 =?utf-8?B?Q0x0S09CYTdEUkVycE9RNmFYZGpOVmx5NU4vTW1MYk9pUEd6UGN6OEFqQk96?=
 =?utf-8?B?RXdkQ1NKVm9DTkxEUUtWNWczeDBHUG94K09GQjNRNVRsc0RobWh0ZXFrc0li?=
 =?utf-8?B?c1huRWF1a2QxVW51WVVCbVpOSUxaTFhWSkRKSmNGSUJLQnRRWFdtSWkyTlVz?=
 =?utf-8?B?NGhkVTNKdWRCc1A1Szg5K2hjN05NN0hvTTBDRnM3cXVZRmVwWGk2UEhFZ09o?=
 =?utf-8?B?eDl4MnNpZUZPQmR6dkw1MUpOQytSRXduQ01MeFZFcW9JRlp6Z1JxZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b428aa-70ea-4cd5-bfe3-08ded3cdb173
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 21:55:53.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/oVRgU5xyDrj3+/LWchNW4rPpRKyRHptHN2VGFjtkRBs7TINJPIsoTOrW7sZB9bpalMY7wHkl/dJPtOaG+Hzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7859

On Fri Jun 26, 2026 at 8:49 PM BST, Gary Guo wrote:
> Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
> as remove_id_store can free the node. Thus, make a copy in
> pci_match_device.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel=
.org/
> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko reports driver UAF issue with this:
https://sashiko.dev/#/patchset/20260626-pci_id_fix-v1-0-a35c803f1b95%40gary=
guo.net?part=3D3

All of these cases are already existing UAF issues, albeit now it is much e=
asier
to trigger because this patch converts them to heap UAF for dynamic ID only=
 to
stack UAF for all IDs.

One obvious fix is to instead keep a copy of the ID in pci_dev. However, in
practice I think it doesn't make much sense for drivers to keep pci_device_=
id
pointers at all; everything except driver_data can just be retrieved from
pci_dev.

So I think it's better to fix drivers that stores these IDs. I used this
coccinelle script to find cases:

---
@store@
identifier fn;
identifier id;
expression E;
parameter list[n] ps;
@@
  fn(ps, const struct pci_device_id *id, ...)
  {
    ...
*   E =3D id
    ...
  }

@store_cast@
identifier fn;
identifier id;
expression E;
type T;
parameter list[n] ps;
@@
  fn(ps, const struct pci_device_id *id, ...)
  {
    ...
*   E =3D (T)id
    ...
  }

@struct_const@
identifier s, fld;
@@
  struct s {
    ...
*   const struct pci_device_id *fld;
    ...
  };

@struct_mut@
identifier s, fld;
@@
  struct s {
    ...
*   struct pci_device_id *fld;
    ...
  };
---

And it looks like there're only 4 drivers that need fixing:
- mlxsw
- ipack/tpci200
- nsp32
- ata

Best,
Gary
