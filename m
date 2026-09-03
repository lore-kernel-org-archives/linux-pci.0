Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAF4A5C51;
	Thu,  3 Sep 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439406; cv=fail; b=XkfV6YMTeoPqh7MdXV9P7qT/zBKGO+OfYAi1aVnFoFxfPpxYfvAOU8If7Rg9nbXFXhsVmyiHCBo1kue/LF3anmJf5gLzn4J/t2+25ouV1JS9FVYzppaeW23ojk4pMT1n9s/now+CNhxHJoCJLjGRBGXPv62Gzw5W/OZqUd2Uun0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439406; c=relaxed/simple;
	bh=KWIvdjSP3ATKhfkT7IofDinaBBArmDp4a+0cTDJsuec=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=f/zTW73U5SlQ3XuDHJZUl06+naCuJCZtQyJJG3QXNQ3dDYk6ryKRx4LrHJHqp1vsusXi0iylHU6tku9ppZlEoQzsycQPC+bkCPAodsA7SgK6o42PZamCY/4R+NzYGukfFJHDK3P/hTtXwJ/QshBSTAUf48zjYHcKte6nxfpr7Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b5sjkG6h; arc=fail smtp.client-ip=40.93.198.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b5sjkG6h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2grnl86mkpuxEt6T+GGywtRmtVG8NuZaVY5c4qzaqrfaYzeGWqAq4PtHSCKcohXqGyYLTdH6n+5BnANf5tw/dPN+KplgG6Pzrmas8R13drYxt+J/D12Szi3Kb0jJ5lmAaJLWgqniZ0UP8i7whlGgx63tCKLDSMyDil/msqSMHC4lOGr3Zf/TiTyXCtDDQm0VHOPZYjFReKoyGFQxB6nErWxg4/5aj9lxfxHvvspCvwIWWdwEYH6HPJhpM4NbX0Pt2xnX8JwGTVTxMDGXsJB2CLSS/oyD+kQ3REdzDcY/wnzyMIXhMvKOUEdWi3lSJCpPIN3631NYMscUiI9OFpZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWIvdjSP3ATKhfkT7IofDinaBBArmDp4a+0cTDJsuec=;
 b=NaH63bVIWxfkzk+1X8TA6V6ec9n2aURSbYGAVzrx8UfC6eWJ6ZYnbaKyzeKJ6t8qRs77VmDksiq7RE8DgTrWcw/L9h6A4rKJMCg1iVQcLWryB/G/RrRGZJFV84IttfYIUD4cnGoV+C1fWfcj4N/dF0zLCpIRWYTjKKbZXCWIcgbNtJdoHukkGfMBEdRJvnjVlrPZodyn1xLVvNGMhrC3fJQ8nJ5nt+u2v8txh4uU85teKB2H5LemWN8RypnxYIPkQXLG5Z+woUvb3l/8FAfKZE0fFSEo/bj6TwFXZCYNYS5YOJ/f+xcZ2TckHRyrMj9qHtrhFd20C8RxByDYD41nRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWIvdjSP3ATKhfkT7IofDinaBBArmDp4a+0cTDJsuec=;
 b=b5sjkG6hnuHBUSE2HtgaRq1dNIbRvssiP10TNum2R43G40T53JanQ1E8IhWzycBcVLavZRERZEWkQLHsq60iXHK18do00UwZdm8lKKMJftL3xKjpjaNMmwizB2kQ4m3RtuCaWPLaNKhS1CWZfpg8nnDeNRTQaAhockvt/mu7mg3oGbJV9dQ8Uka3ZYm275+t0hSYcWjKXueIrf3SgPaWz0LchMBj1Tg+CjFjWRK9COVyTJ9JwdjU3kz27Q6n5Zq/sG1N8p8TUoe6o4v33sUnF4+gPpBxSOTk6+WMa0bI9vYFcKvLLkKVamtOR41QRIVgZZRWU+HPxWU2C5DqYxJwwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:43:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:43:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:43:14 +0900
Message-Id: <DL5OURLPDYFN.163LLY15NFRTS@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TY4P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e57b6a-8544-4185-7749-08df09b8ed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	M3ZAWAtvxpBz+3SvDJEe3WM1ZexBRpwkBYCWaOt2eihLRYXUHQUiizB9C5Jc8ZOGqzExjZgLGdXcafN7+vnP3iXk31TgrcIz1S6lWv3qfPc/ENZlVhOnZDHQtC2a2jQHjcEd7Wl3etz6KFvp43iITnl2kXk6s7Iq2S+28u7A0+1OmVA7uvUt+v6wZ/Ik7NIem94vj3vow8vDUok2D+IYSX5wz6B80H/H5fIjmuWEADX5+zOBL7+/B4QQoV8blXSkJBhPf9Bbxz2wYcqZSl2talQu+BF5nzj4xsqDSCmM5hnGCbEEpyWrNbL1mEb+JqCjmAZzQHtF72w2TaZhFNmmgp3ERjhYu4spqjblj8khKfn8WMcx56qSJJfASOjG9L1cMxSi2U3BrPhxwNxlZ3bx+MtmPJLXhq+bFkFBLLsEqcEqsacfgaWfxwhmS+wJOUBX/5RM9hHsNEZeLN4YWXQ8+xCXc+KhF2XdzDHrHr9a3vueyy7moOkVhpHqgaYTvfrO2NItOWYg2+LriT4hUEas1TKW35U4Ao7ZEl4erJktgda8uPf0Ddc2Ef/vX3nNWWIO+fvGRvm38FccNnal3U20fa9P/4JCw7/E00bWdZ6vOnkffxt8G1hRDDCU/Ch9HmVtBuoVUff+U2t6jd3B/muz2vqrFcjmp5ggErekJgirTmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXRvWnNkTzNndzhHcWJmc2p1TlFzTUdib1lza3llanlYdmlDT0dSZXRYZWVM?=
 =?utf-8?B?Tjk2Y3R3elpRV0dIS0pidkFiMkZPQWlaWU9GY0ptbk16aUdFdW1sd3ZERy9r?=
 =?utf-8?B?OUluS3lvTGxaZHJVaXhmZU85NVNJRnFPQWZYS1hqcnBnT05OczhUOVR5WlZ4?=
 =?utf-8?B?c0Y5RHo0c0o1dkI1cTBsbjFFRTJINFVVeE1nVHZPaFpwakhzbkhZclZ2RlUx?=
 =?utf-8?B?c0Z6djljU054K2t0OENiK2xVTHNrVG13dE1EMDQzYjZCSDhDZm5lM1B3NmQr?=
 =?utf-8?B?TlFSRzFrRU40SU5KYm91VWRaU0FVck81WmNkeFY2SlFNMXptaXhrSHBSUXFv?=
 =?utf-8?B?TDlwMk5VZ3lEc2g0anRvQXdOSkp3MGhzWFVRalFBajAybG0vOEd4c25haXFp?=
 =?utf-8?B?QVNqOEROd1N0R05GQWs3VkR0NkwyTEdGa0hDMmY3SzA1NFpuVmErQ29tSzBs?=
 =?utf-8?B?aHY3TXF6cXNkT1JBUEdhRzIyeDBCNnF2MVg1aDMvb29GYmtvUU5UOXY5VEp0?=
 =?utf-8?B?UGJtQUl2YVJBK284eFF1aUYrbVF2ZGJtRHYzQUF2aCszVHorQWxuaDFQUkVN?=
 =?utf-8?B?dC85N0g1OTdta2FIWXU0RUlOYmI4Uk5ubWF0UzdUNEN0ZFR5UWxWaUlBRkJU?=
 =?utf-8?B?eVhNNGxORm84R2Z1b2dCTWNVYVBYWVh1aGJLMUpxQXV5a0dGWUFUMk9oSyta?=
 =?utf-8?B?SHlweUROeWg4LysrbWF4VE9OWnVucU8yV3lBd0hodmRBbUdOM25WZkRQbnN6?=
 =?utf-8?B?dW0rSVNtYkc0c3RlaVVaeEtRcW5lMVFuK2tjVFhEa1RnSm5UQ00veFdhS0Rn?=
 =?utf-8?B?cXBOOVlVQ09uZ2cvRFRTOHU5SmExaklGTEdLazYxdjdXRnlMMk1vZXFyMUtQ?=
 =?utf-8?B?YVBPQVpmellaTFpkRGNVQmVCeW0zVm5sazg2UVUxRVAwK1NuWTdLSHhpS25X?=
 =?utf-8?B?VjBORTRvZjBUUTVEc21BRUh4aGh4ZnFoNXdBMGRBd2UrVXlGdmx4NDJ0SFJM?=
 =?utf-8?B?Vkt0WWZYSzBOS1JWOGFjME9ZSk96SEdWMlNORnh0ZXlyTE5EWmw2U0t2eWZE?=
 =?utf-8?B?MWE0ZVdEd2FUUGNBOTg4VjJocnplc3E3WE1ncytEVlM0S2hJZjljbnNpOSty?=
 =?utf-8?B?Qno4dVA0UFlyZHgrc0JiUmJ6R1dVM2J5VEhJdFhSN3JEcktBem40SEJaeWtB?=
 =?utf-8?B?dXBXOXByWGJlWnJlY1hCMlNzOHViSXhKNFpzUUdJQ1ZjSVl0QUlGaXZtRDQ2?=
 =?utf-8?B?bUlZQlhKdTZPczRpNERrMWJHdjZBT09LYk5ncmVtbjZXbUNVYjhFaUdId2ZI?=
 =?utf-8?B?UTFVQUthem90ejA5MXAzTFl5MW9hNTFVbjAvMnNoME5kMzk5SzRzVFhKNFRz?=
 =?utf-8?B?d1ExQ01pUDQyc0RTRWZwRkVHTXJLMG5oUS95VldxMDZ4ZDQwQmZ2MGVobDYw?=
 =?utf-8?B?M21SeFdWQ0tGa2R5SzF5Sk9la1JtaEFYc1NhWld1MWhHZFBKcUlmc2ZHWHVk?=
 =?utf-8?B?d0FWNi91Uk9sdU03SkhveFJXUHZPL3BlalZNSkJkUXppWjMweGw0cXY1NlBT?=
 =?utf-8?B?VkJIL05vdEVKOG5tQSt3dnJncEl6cy9Fc1oyRTRqbm9KQXRRSnJoNUFYc01U?=
 =?utf-8?B?aCtDMTdBVXlsUk1haTdCYzZ4d3d4ZlM2emZmWWlTQXB2dVhhbk1uekVDREVG?=
 =?utf-8?B?VzM0cHhzbFFBZ1dWSjNaTjZaL3AzemUzWmM3TUZnOURyT2JnWTQ5Uy9nWlZJ?=
 =?utf-8?B?R1JvaTdIK2tnV0pQT2xmbi9KWXI2b2JJYzJ1NGJGZGttVnpRUUcyd25GN1Vs?=
 =?utf-8?B?bk40WVpaT1JQUkVXNjREL25KVmp6S2NmKzhCUEE4bENIZklmbFdpWWxQL0Vr?=
 =?utf-8?B?dUxoWmJvWXpGRnZTd2R1ZjBFaW0wejEyazFuMFVSNWhwR1RZUFJTOStmYjRy?=
 =?utf-8?B?eFl6TUVnbWtJakE4ZWRWQU9kNE8zYno1T083YjhwcUlCQUZRcjhzdWtjM3Z6?=
 =?utf-8?B?VS95V1Z4SHBVRTNaSk83cWJCRUMvaVhsWXFOa1NybnVWbHJLWkdFOUJqWUJx?=
 =?utf-8?B?MjREWnBuMlpUQkhGQTBSdVoyL3VSbHBwamhBRERlaTBVQXl3VXZ0TVl4Szd4?=
 =?utf-8?B?SCtiNWNBK1RyLzc5UmFhWWl3ZUw3aG9nUDdMSThnUWJhaUtacXRsd2tleWdy?=
 =?utf-8?B?M1hWZFYxbmRVNGFMcVZLdWZHL29rK2QrbHRZMzhaelozL1k5YisvYU5tb0lR?=
 =?utf-8?B?WHdUaFpMZSt0amMvdVI3WnlpdVdiaXZRdmNISnAzVXQrWWpXWHJ1MjFZWjVi?=
 =?utf-8?B?cHkrV2loUEEzODdlWXNSMkFkblk3Y2sydmx4NHNSdTZ2aUtrQkY3SmZKREhj?=
 =?utf-8?Q?CZbw+wKowdeX2lj5OO0572DJwz2k5dX94XwrQik32Adfb?=
X-MS-Exchange-AntiSpam-MessageData-1: xD3PB0WmRF/zqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e57b6a-8544-4185-7749-08df09b8ed76
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:43:17.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVZNO2Zp665SSvoaEJe99+XQ6wQblMdiKe6JxT6dBiSz7J1PPNiLVH88YsZhLnRdfsfKvzYipYXzBtCIsFHELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

My v3 Rb is missing here, so renewing it:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
