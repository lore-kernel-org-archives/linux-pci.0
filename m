Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020124.outbound.protection.outlook.com [52.101.196.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028647DF97;
	Wed, 12 Aug 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558581; cv=fail; b=hsTL1C49CMsrsitRrNRqZaUKjZYKuPHvbmiJtLAEaGQgIga63vrsFmR5FO6HO7XYUEEti2vYRDsW52nixgEhnTvkZwxvTyPQQphrDGynWSXa60vEoreiWk8osKaJN5L/GM3c4k5vGNn5YOW2MaQXvHqUnM1UphNBXmd1zP5kkGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558581; c=relaxed/simple;
	bh=RcRFtqa5ElhQM7Vpk47jrwODxQdGjcKGDO+atwAVzr8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FK3WEu2HscBfnOINRA3d5ZZ1lWCTny8unisk0nXopRGnGIjsob79dBPAbHJll1UESAFToCOXkygjL8MBgXmhQUU2FQe4ObTLYJbE2VXYeQHoRESZ2zpnvVcskvCCaRRmLo0/ubQiGTxx2zFeFiOBnWnHlmBXb0rjF4WQ2M6vPWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=t9sxDZFG; arc=fail smtp.client-ip=52.101.196.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="t9sxDZFG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYLqb/SJCaGj0Xn3FaBPvHtNZ+QN5IOSLslpjM8PDhO5FYf4kZXfaYjp9EGClGDjqtnjUNMAA8ziLo9xbJ2DTyy7uGxKMx4uoF4gUKuHNjnktW/frhEIYFqlplRPXkoOEMMlJW57jALpTQEckCne0Jcvq4VPg6Ali8DQzPWagSsy4KqLM9ClEFhyg0lt707BkhjXlbOIkec9C82rwaGYGf3DmwxrEUhRuTeyN1btbJoU2tJThzEvyFUrds0wrd+pwa3uuPm8uyxs9ubk2rAU4F7rlAmhAUfNGm3/rYigwCRPyND8hbVGWcTcnQLPRQv7QvdrXevrO91lTCJNpb5WUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQYYAioKw46AiS6v0IgIIRbJjBDAMt6TCXy6aYXc7lw=;
 b=EPsyhqMYZzuLn2RqHvJ4aAcpKlCljAyLaZ1UWkHQHpEbWFCvQlK8DmHNfPGU9VJwwiCALulzhlguJrvN0WL1IJ3aQdF8/pffRB6bkftfuob7rhYFqvY9q++XIb/JNibfY6odcTTf0bC0/oNxyg7K/JOLa+tLMD4mpBvcgng1yiCpQSA0p9j1H9df6PeTfgXPkP+5By6IJgUn2qFaNi2Q3F5sW65nMYXTJo/N9PS9OAqkiPyHVD77UOA9ewi4HxRVmREjoWzZo0eG5KcGwR1zK0DPZjSsC1O/jImUfjvT70IrTnBJ5nM5OC4jsyJ2/QGf2A/XmI1+1ZbLvCnM24r2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQYYAioKw46AiS6v0IgIIRbJjBDAMt6TCXy6aYXc7lw=;
 b=t9sxDZFGWj/30dO124Q38jpO0qBnOSiD3r5u8ePMLJZlFBlxK6PDM6ObuehQ+TtBO3IdzVXSWhjZDdU/4Sv1IQdhmdwTU96ll99JmuO2BR2nAffBRTK/fW6HoVr18AEWHlCApQZSyb/WfVsWl28AdMHdpkc3f2pJW267zqbspTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 18:16:12 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 18:16:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:16:11 +0100
Message-Id: <DKN65PE95UMV.1NW8ZW80Y60UC@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] rust: pci: expose the allocated interrupt type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-6-dakr@kernel.org>
 <DKN47TIEH9R7.2Z6FDMEZTUKL5@garyguo.net>
 <DKN5RMNZUBGM.1EFIG6TFAT3AW@kernel.org>
In-Reply-To: <DKN5RMNZUBGM.1EFIG6TFAT3AW@kernel.org>
X-ClientProxiedBy: LO3P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 019ef4bf-9bca-4bc6-a9f2-08def89dca80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|7416014|366016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LkBoOftuu3G1S2A3wsozVHz5DMS0/d8DMYaghsDKsUdPM5nsRjusmhvfCb1tGDCbU2ozhsvDWe5kq04iFTDA4+uaT7b68ZJRJdRevcl95spl/l/yqmrFsHOLw6QXanT1DGxFo4piWc1KmI5UxaaklE7G+LLHexbfbDFKttBRR5En98Fbk7xdJd//b9CY59HuwXRA7WydVPBAOlyEC5xExOVLhqqOmO+N6qmFuNv+DOKb/RjxfD0OavKNuqIXKwpS5R2pgBgG5UhjDiTm/5Qoj8wlxg/8loHzYh9XNsll6EcKutZWG4DljXTx1/C0z4LspKSeiTjN6qQKzGRhd8IN6FS9/aeG0mvYeBO5GeFYw3sqdzahYtH5uCWaUsePFbMFJu3hS5X31FfqB5PRRt2vPgK+SZp715HD9UFip59tRzeRMll8hfQ5ww8SpwwoQRpG6ZOYavnyk+7Jaein4vYbavMX543AzXGFEo6Ku5FEfbhn/Mx0PI3AOeKcAeCy3h+uu+SmM6n0TssjFfBVCVeRpdlKa4oQ0489tp6ZOuMknhzfFR/tP13r+JHGxvvILUT8+2lJOb2I5Vg5xCeWW2iAZLMRS0Vhwaxbppq7Tp5dm6h8AE7ViPGWX8bTXStAr7ZImf91XTcJ8fsXNWerAsERu3c9RlnBIH41TjPMvFvNxwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk51elRyNEhWZzFrb21nZU04U3RSR0svNlltTDRZdTVuRTBzYVhadkZDdTVj?=
 =?utf-8?B?WjI0UkpBS2xnajlOWWtpUzJtbXAwUzlybkJ1d0IwaThsMXMxcndjQ1JLLzJa?=
 =?utf-8?B?SWRRWHhxZjJQL2hqSHRUUXdjdWwrWW53eUtuZmg0T3IxK0lDcnl6dHcvek5T?=
 =?utf-8?B?cGpGSjIrM21NeVo5RWZUeGQrZzJHVkh1b3VrT3ZMQjlxYTVVcjBoTUxueEYy?=
 =?utf-8?B?b3JmNDhxWFc5QjdMWml6cmZScTNRK1gyL1lsK04rTFNSNStzeHhaQWxNSWxX?=
 =?utf-8?B?S2Q1YURpMnRneW44MzY0SHNCQ1pybXk1dndIYmVPZjVLektMdTlMUnNFNjdZ?=
 =?utf-8?B?RVoxcVU4T04wMklaSW9tRStkUnpIWDN5Snk4OW42M2l5Y0tBV2ZIQ2VhS0lw?=
 =?utf-8?B?b0kzR040b3pwN3BXMUNaTzdnbU9RN2RSSEhiK1RkUXpUSm9lMTM3KzhCTm1z?=
 =?utf-8?B?K1ZGd29HeGVaSFBhbUxuVWtDcS94Y0x6cFJUdEtZbVk3VmtWQXlJQW1GUzkz?=
 =?utf-8?B?VVRHcCthcXFBV1Q0aTNtSWwrRlZ5MUFDWGRUL1pTaTNzQkdKdEZQbmx4K1Zs?=
 =?utf-8?B?VittSHRWSGt4c2FJUEU2UlZFaDNLUjlvRGNOYVBESyswQ1ZDR0xDU2V2Qms3?=
 =?utf-8?B?TkJ0UmlIWWFEMVVZSE5FaEYxa2paN09NT1hmU3N2WHVpYlVzaklPWUg1dk1Q?=
 =?utf-8?B?MnJOQ0lZYUJ6ZjZvaXNtWkthaEtxaGxCdVVtaUpFVEtqZVc5K0h1bHZBeUZ3?=
 =?utf-8?B?Rnk4cVNXMGRIOFpnSGd3Tm5DbFFPM3o0QjNJNWlmSXhUQkdKNE9hRjQwc0Ni?=
 =?utf-8?B?SGZVNFN1dUQ3Um1qWXUza2Jsc2IycGRSOWdvcDgxM21PYzh4aW82TUgvTno0?=
 =?utf-8?B?TUNzRitiREJiUXpBQjliNTJxZThpeTRWdUo0aGdaVFdxY21LM2l5TzJpT0tL?=
 =?utf-8?B?R2NzcEtacStQTmJreFVMbWsyQVlwL0xOUVk0K3JlWUtFTHNzdjJJQlVqR3ZQ?=
 =?utf-8?B?WUJWcnUySllzTi84a2F2QTFsVGRVdTJiSkhwc3RNc29lZDVYb2h3V1VuQk9V?=
 =?utf-8?B?OTAvSVBiM0MvR0lNTHNkZ2VGWTVFWGYwR3BHZURHL3dvUVRhR25pU2NpSFlj?=
 =?utf-8?B?ZGtKZFFRbnZZVDQ2RjJvRGJ3eWlIQnFRU3lGV0kvdnNXQTFoYjRqN3N0aVFC?=
 =?utf-8?B?bm9DZHA1UlpZRHpkR3Yxck9NS3VlTllkMHJUci8zcFd3NDVxd0NqaUFNMUlw?=
 =?utf-8?B?WVBuV2pxaEtEdnREZU1hZ0x0bHdNVUVRdDhrbnZqcDhjSFhabk5VOXN1d3BJ?=
 =?utf-8?B?SC9LOGlNSUhTZE5peGljYkUyWXJvWTZZZE5SSTFXbzBYdWRVVUs2NklaK0VR?=
 =?utf-8?B?ZkVZUkxzS0phV0VPeUhiVS8xa2lmQXRjc3lXTWt3WEViUkQxQUFGZ2o4bjBn?=
 =?utf-8?B?Zk11blhVUUE4bThYbTBRTjhmdjJiZEFxc3Mxd1Vmbkdzb0Z2cnB3NmxvdHV1?=
 =?utf-8?B?czlKdVVobUhTWnQxN2dPOEI2eERxUzRRU25qdDdpd09BRmNSbVNyZmwybUVs?=
 =?utf-8?B?L29oNTlYQ2xOZHBKM0svRjNCTWxxQmp3anQzaWxEUzc3Y2d6NXBoeWJYKzhr?=
 =?utf-8?B?U0twSEVZelhSUlo5aFo5KzNDbmZZZHhUY0NadzhwdUN3c21UWEpEZ3RaT1Vq?=
 =?utf-8?B?OUNvUTlobXRuTkxDQnFKcGx0aHNZbzFyOTNIcHlYb3FYQVA1MWh5dXB0Uk9L?=
 =?utf-8?B?a1lKb25zay9NRWdIWDJOL3h0K2tLYWtVWndwZHB0cW8ydTVqQm4xN0VyODgv?=
 =?utf-8?B?WHhPNVpPQWZaWWVDWHgydVE0RWxXVEdtZXF6RkFWc2ZnMmR5dXpOQmZhUGls?=
 =?utf-8?B?d0RPVmhMWlJneG1TN294dnJ4UW5zRDhwc1pML2lGeFg2VXMyUHVSMVNaajc1?=
 =?utf-8?B?ci83TFdXSE44Mjl2Q0hjd0lYQmlucEo4Mmt4QjZDOWdxZm94bWtKdmh5UWQ0?=
 =?utf-8?B?NmNHbjZrRUk1Z3podUNhR28wbDJtZ0pSWlJlaDNYRUc4eXd2cXFJYTV6bXEv?=
 =?utf-8?B?RUpNbkdxcUE4RXk4YWxnN1MxY0QvWXNXRnNLU0p5YVJqdnBHc09ST3puV0xP?=
 =?utf-8?B?d3hmcTByYmFJWVRwZ1AwT2s2aWRxTEEyK0F3YU5zQ0xYWkFsMUZVR0xqeXZC?=
 =?utf-8?B?b1djVHRVRXQwWU5kaVI2aGNiS3d1RlpzWjhEL1RFUDBHVFV1K29vQVFmU0g3?=
 =?utf-8?B?ckRsVlQrbG5OcUREeXI1OG1YQlB5MjNmNDBCb2xFamlESmx1Z3dHazBpZVpN?=
 =?utf-8?B?dDZmd1FybHhGQ2ZRTHNwMlFTNG5OdmVDUHhId1l5VmJITHk2eW5lQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 019ef4bf-9bca-4bc6-a9f2-08def89dca80
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 18:16:12.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoGh/HtMT1nIZMGyPWu7ownUKCrckS60q7pog2YRzABkcNkq4JEJFy2JtN15WgDfrfaZZKyr8rgSg5oO3tMeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6208

On Wed Aug 12, 2026 at 6:57 PM BST, Danilo Krummrich wrote:
> On Wed Aug 12, 2026 at 6:44 PM CEST, Gary Guo wrote:
>> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>>> +    pub fn irq_type(&self) -> IrqType {
>>> +        self.reg.irq_type()
>>
>> Do you expect people to call this on the `IrqVetor` (or even
>> `IrqVectorRegistration`)? This is really a property of the device, and n=
ot on a
>> specific IRQ vector/allocation.
>
> You are not wrong, but the C API sets msix_enabled and msi_enabled in
> pci_alloc_irq_vectors() and clears them in pci_free_irq_vectors().

Right, then putting it on `IrqVectorRegistration` does make sense. Speaking=
 of
which, what prevents people from calling pci_alloc_irq_vectors twice with
different irq types or with both IrqType::Intx?

Best,
Gary
