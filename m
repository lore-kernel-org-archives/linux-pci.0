Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E122D0606;
	Thu, 23 Apr 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911539; cv=fail; b=PjS+MAZm/dAyoaIvSCymD1BCqOtz0ceZnpOh9pZGk2egNvjWNRXYDEGrnGedbvFpl6zo8J6yp8lk9OV0a7/Offa52RnpgkaWWf5IVBKF26vUP2RmAwgp1sMdkqGNCj6VbBdR3W448O63uDt3yBg84lpVKgvI6+cYWo3HWnj9/mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911539; c=relaxed/simple;
	bh=xw4itXIyFEdru7eNXSNAwQF+WJcj7SZ8GAjX4e6SCsE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=uU4R2UWTVF/SUUbsHBWxUks2/fN8qe6+NOTi70XfInHKnu9dLQS9i5Q9kuwEVFJPrvwa1DL37kH/bxsrXZXCeOKGL0RhznI6vsTpJmRFReL9zyAcrOZtz5Vt9cMQ97FX57l1WZm0hEY+sXXsDzJZeQZxPjT6XfDlH4uZYm2yoIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8zfvEt6; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8zfvEt6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FebXwFCdVx3dZKlVtEED0lSzLSzyAwKTkTnF0wHslng+IdTh4us3qhkLGuYPNvnB7WjQqjB2pb8XtEO7tMfxJjoozoC7YQ5U5fNdeykgDt0wK1vEeoAM1qt7nzRl4XRF/UPIyk0EdDV36/XmeCbBRQdH/Ex3Rgq9OMOqkI7MCYyLlHm916Wu9ZQr/oPiF6iB3Pl5qMXENYrIX+VveslJiC28r8C269nFe5W4YbmjEWE/2NoM8xRgvLdJqGZFLDeJgANoOat4v6Xbt4wyp6Xnb/VHEheN5aoAiJGyS7B8j8EVAJdbp07pP8yp8Z5iKZpTClo27c1zMDvPtVkib7ba5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSG6BgYyMI5Qoj4e7kg83fw7rkvk35lyoBn8XjymU0k=;
 b=f9xwF1sASI32pAdpE239A98gqJ0DJ1X9laYvM4UFLT7YHCTqp/9d2rvuPHZY+z8QYkZ7lIHF25P97jOitOl3YaaG7j7MNBft+nCO8kzhmFs9MqwdiEWmh6nWe4OTy2RM+zNnzgoKK5f4LOuTHELn6lDKexsakt/4vzNmvCVQGa21eZcsDNXNjfJv7DzCfOhGjkgT86ScIxbqP+16DKS+w9eU/qXjHQ+gBqC/T7iWa1llgVJJ2sb6IwXlUPEiH5EIsYYLbU4LDNZ/c1odz2RxOQzdNevd1+QyEUmX2yM3D3QYXYw1QSbtWRK6qL8btCVjx1AZWw8tFm88cRBgeULOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSG6BgYyMI5Qoj4e7kg83fw7rkvk35lyoBn8XjymU0k=;
 b=V8zfvEt6WUgludypxhaNOXgIC0lG/e6MnSiXOfAjp2IwtbYNjjrVhB6ukn0DVT2FsY7iXnTAnP5kAePDD5RFAYNZb3nhQ7/mfopbwY4YZl4MCG/knoiXhHPwl+rfizu2XIzPBcwHORtonNVxyAeemijs44BgXN4Jkp16+BUU6T0yWBkO+faySZmBRR8sYVMojEIrEbNfUuPl1NVifQKPusFA4/Ljq50lxNMJmMb+90YRfBx0p7onU906oAtZDadiymCMjAtYER1OJMzGeYhwu+qhnTIiWn7Bsh/Na/ro8/eNj66C7+Svx6ahRxAgnYUN/SFrylu75FymU1MfOazIfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Thu, 23 Apr
 2026 02:32:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 02:32:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 11:32:09 +0900
Message-Id: <DI06KFG7C6P7.1NR2L62JY2RSF@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Boqun Feng" <boqun@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
 <DHYQGLYYXEN6.11Q3FQGZMWCJ6@nvidia.com>
 <DHYWJ32M02N4.2954OSJXFGD1G@nvidia.com>
 <DHZMHF1YVBI4.F11YKDDKBNTQ@nvidia.com>
In-Reply-To: <DHZMHF1YVBI4.F11YKDDKBNTQ@nvidia.com>
X-ClientProxiedBy: DM6PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:5:60::44) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: e26a563d-1f10-446b-bb5e-08dea0e08654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1vnkujns5nCh3QxbeJIQB6J47yb91A1Owlp6Ng28Fy3UEm+Nj5ljkv5ree5MPLdvHtiYrjvC6y5fW19j3es2ejWExxZo+SYX4v4jC83aHiMKEAbAQGZw2xlaXEvLtftYyjaPo3kcPc/kBrNla5mfKcNyzc3c6hDVVYcO8SC2O/hMGcpEK7cMbmC7vh7yo+FKkYIOQENOa4EMuaU6zI/NjR9LLrihJpIFNcNXebr+9b0Kvz/IG2s5FihVwA9BIV5mz3r24mszflJBODbbzG87uoZWER7i38P4bkrnseJkPeityNkk4ewBh1gVnuBc2nzPPu1fVFkH5WDhKrzhVwNibG6bsUG9aqACBHIt1KjTWosoo03H2st434GXIkiu1J1dy2dWQNTT2IjLt9ItjsIUk8e4Xu/5Y04QHxU4nE2w1FCPq2jvCd43mxJrExBa4dBb5JiwZkzmdnqy78l3Mc45e/08fxxYqmJdhUoGGhspNftf4eFE18zGgNJsMzYABS2MT7mtyWB8xafbrf/dtJCOX1Lcu0EM0/AxHc/RzUdYYOuGrSIqwP0Bje9ea69B+lWiG+GCL0buHfwmaehlWotCRdJaU1ejr1K02FknHDNNKrXRxs7cC/wBkRqm1vFQ6X2iRHt13FSMeDgPsESgmZd4ghb/muPZ/MVIovImn6RG/c4uKprzQFQ/Aeh7CLQT52OLNao8BIfL2T4s9uQJ2f1VHOIb6CCOGzlA3nTl8+O41wo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1V3cExDRTRQRmdLOU5NWkNBZVIrdm5wRStjeUZuMXYwZG9Qaklxb1dnQWxq?=
 =?utf-8?B?TVlFWFUvTlQ4U01EL2lkK0FxbW9URjBSR1JmUFp3N3VrejJUcjd5ejlMZGsv?=
 =?utf-8?B?K05UcmR0bFFJZDBhMytSNGVZYUFReXE3RnhwTlpYR0JrM1loZ2VWQWdXS0VY?=
 =?utf-8?B?ZFdqeDdzRWd6UlpybnJkb1FvVkYrc1EzSzQ2T2doY2xMZDJPamZWakNKb09T?=
 =?utf-8?B?MTdtM2JsY0xOLzlUUlRZNmFjb1JuSm1RSmZOL3pnVGVBeEtSeEhRcUE4KzZo?=
 =?utf-8?B?Wkd6bjhrVWMzSlNoaVU4QzF3RFZsNGgyaS9MYUs2enptZFEvMWhDZm1FdzM4?=
 =?utf-8?B?Vml1dDFzeTJTZTR0bEJxUldjb0FMcC93SlNqcWRGNjdsVkVOejRkTVQzUU9y?=
 =?utf-8?B?aWtFY0s2dmUwUmZ0ZlJmTlhHaHFIcWxvMm4wRzFldTFYU3ZLRTZzSVVNUGFn?=
 =?utf-8?B?eXB0Z3BDQ1g2c0I3b2tIc05URjllcHo5cS9ZZTlxQUZUdWlCTmE5Qk5VR0or?=
 =?utf-8?B?VHJuWXg1UHhQRE9zejJuN2M4WjNrNlI4OWplR2dmVEFrbktRQ2JjUXp1dU5T?=
 =?utf-8?B?a2lYQWoxa09pS2t1V3BEYjNyOXpxaXU3eXgyVEVSUHpzQXdjV3FWQkYyOEhH?=
 =?utf-8?B?bVlBNVgrUDhuRTZhS00rZUF0YUlBR1kvUFUzOUxTOWJWTDBkdFFtN3lSOEp0?=
 =?utf-8?B?SG5oenNCUzZkL3RUNzVHajRvbHJCRmsyT2pnMHlVbVdyL1p5bDYzU090c3J1?=
 =?utf-8?B?NU5RajZiZkJXMzhZSmlDWXJXUFUxVTl4Yml0QUw2bU5zSzc3a1lJcGNwZ2dY?=
 =?utf-8?B?dGJ0aFJuZjd6bFFCMVByWndBRUJNK1JNK2luVC9DbEc3TUowVTRHVUVPa3No?=
 =?utf-8?B?NzJEVGZPcUVPdFpUYTJHcDZWL2pyYWFlN2FLd0M4dUVEbzZHaVFtKzVMVHZH?=
 =?utf-8?B?TWNsQTBRR2NrT0Y3aThSNFEvVGdZaXZIUmJKYkIyeENCV0tNV2hRdmFoZDlO?=
 =?utf-8?B?S0Z3Qm1HM2MxZER3WE8yTENOZVBPUmdsMTFNMGVCQmdEcWRRd2tKY3FLZG1Z?=
 =?utf-8?B?cENvR0phREl5M2poczA2Z01WMmFzbWhPbHIyamk0bHlGbURUVEx1MkcraGJt?=
 =?utf-8?B?dzRJeVh4T3NZRmZRSHo4MW9HRUpVUlJOamY4OVJ2VytQRHlZUFZrQW0vbEl0?=
 =?utf-8?B?REI5YmpqdkRmMG1VSnZaNEZWanFkWE1mMTVnQVZJOEhCTGZSbDhwMEd6Q3oy?=
 =?utf-8?B?dGJYeG1GaGxBN1duS2d6YWx1aG5nbXM3cHZYNG92MlVxbDFwN1RsUUw5Q2k4?=
 =?utf-8?B?OUxTWGNnWWxVM3N6NWtaWlhoLy9xdlltRks5QVFWWWkyam5HQkZ1eEdqcUdX?=
 =?utf-8?B?UHFLeDNlWXlVQmJmRXpwTERYeTQ2ZGlvcStwa3lBakJSNU5xa2Z0ZlAxdDlM?=
 =?utf-8?B?YnRObGZDZ3k1YnJPVG9FTTZVcWxQNnFQaE1yOG5DaDcwZGpOWSsvL0tpdzd4?=
 =?utf-8?B?RHZOa0J6b2ZLWEVqRExvVGl5QjNlNzBPdFk5azJkT2pQcU8vL2tqMTdRSURo?=
 =?utf-8?B?bnJJWDhwKzZxUGhXM1ZlelRFdWxINmkxUHZlOE1wUUxiVXJVQ2J0MVpuZmpG?=
 =?utf-8?B?MlBiMVNlSFJZYTE1SmdxUEJuWDFHTGt6UElJY3dkMzA1NS9qWlUyUXNVVTE2?=
 =?utf-8?B?YTVWeW9IU1pMdWNqVndPTUxwQ0cwaHVUWUhrbk1yYXBTbkxNMUJ6MWpDZlBv?=
 =?utf-8?B?RjlmbC9zbXJmK0dsa3Rjb29TZHVRa3NlY3prdTF3VFFlWVpSTHVqMExjVEp2?=
 =?utf-8?B?MnFKOFBvTkY4MG53ME9iaGlWZkJxdW1UamQ2eTNHd2FCcitlL1dvZzVqWEFN?=
 =?utf-8?B?aGkyeHhQWVBFVHVHTHBuRGs1ek0xTTNIdGdQd3RTVksvaXQyb3I3MnowajdG?=
 =?utf-8?B?cXJtcWVqdHkxU2tLSEc3QzBVajI4aTlOMUQ4VHFlT29NRFcyb0c1aVR0Wk80?=
 =?utf-8?B?b0dSNE92Z1NHQUVMU25lM3ZXVENOWDkyN2VPK0U2Q1hPZU1McnJrMlBJa29x?=
 =?utf-8?B?eDV5R3k0ZXdkRGU1Wkh3djRSTHlsSEcySUFqSmtvMExGa3lFWnFMeVczMk9H?=
 =?utf-8?B?SFpJbDE1SWRmZi9KS2JZemZYRmZQNDJ5MWo4Tis4M1ZjYVluK0JNbHM5WTg5?=
 =?utf-8?B?THpkbmJsZDA4UURJZEdSdUs0YStxdGM1NTNmcTNGRnJ5QUh4ZkhPZVNucERI?=
 =?utf-8?B?QU5GUHJIV3ZyNGN0MnhicTdvWVc4UjByWDVDdEtOZzJWRHJNaUVtQm9HaXFj?=
 =?utf-8?B?cW5lVkJXdmtyenFweE5LYlUvOWtlSHdVUHRMckMvcGU5cVBrQStxZndRbDNG?=
 =?utf-8?Q?+EoMHLhvfaUfhJWj/GsTIj04Y1Ahblp6WUY1o9UJjRJfM?=
X-MS-Exchange-AntiSpam-MessageData-1: 1PSClHCN2aYXhQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26a563d-1f10-446b-bb5e-08dea0e08654
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 02:32:12.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Loq+dBwL46O89A1jliE3yiPOQtm0iRRsJkIqYwo8KxgvZEe0CfyXgnyHAgwFy8l/L1l2qZO2Mh8haAhdhyl8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

On Wed Apr 22, 2026 at 7:47 PM JST, Alexandre Courbot wrote:
> On Tue Apr 21, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
> <snip>
>>>> +        dev_dbg!(dev, "GSP shut down\n");
>>>> +
>>>> +        Ok(())
>>>> +    }
>>>>  }
>>>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-=
core/gsp/commands.rs
>>>> index c80df421702c..fb94460c451e 100644
>>>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>>>> @@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::Re=
sult<&str, GpuNameError> {
>>>>  pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspS=
taticInfoReply> {
>>>>      cmdq.send_command(bar, GetGspStaticInfo)
>>>>  }
>>>> +
>>>> +pub(crate) struct UnloadingGuestDriver {
>>>> +    suspend: bool,
>>>> +}
>>>
>>> This feels like it only makes sense to call from within the gsp module,
>>> so I wonder if it can be pub(super) (prolly a few others in this file
>>> could be too, ofc not relevant for this series).
>>
>> I'll review that, we do want to limit visibility as much as possible.
>
> Mmm looking more closely I am not sure this is something we want/can do.
> As the driver expands, it looks likely that some of these types will be
> used outside of the `gsp` module - in particular some of the responses
> can be used outside, I think this actually happens with the MM series.
>
> So I think I will keep the visibility as-is for now.

I think some will be used outside yeah. For UnloadingGuestDriver do you
reckon it makes sense for it to be called outside of the gsp module? It
looks like it should only happen on unload and needs to be a part of a
bunch of other tear down code to work.
