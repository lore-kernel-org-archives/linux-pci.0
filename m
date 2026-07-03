Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD35AC20;
	Fri,  3 Jul 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089983; cv=fail; b=tCEDSe71Ex5RZK2I4o+LKYPDO4Wqp8cgQIYqV8q2gqbJq6oazitb9jc7MvmFRFzNPcp3p/mEbKwQ1Ula+CXvLdbI6oHvw2/SOq2gHmYGe46tjluKU7/PyJZ3nzGdtPa/EYLNKFw+puDLgsHFzgSymIQk54NM6cytDS/7D22j220=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089983; c=relaxed/simple;
	bh=NQ871K7GQZUGfDvpNQ2mTOm+LgHeyMS4B5tyAn+7T/w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=eV2NvqrbwRAtdImrVbRpg1ildWyd7O7C2YGIj9vf5mpOaOb0MRpWYCa7O15tjb3tieUgHbull/XQNENJouGDzLJRaxAgcfUhxHSIWD/mKqDvWDsXY635PIKAefkK/YqRG0sZsiCKRVwgwI8rQ58U1nFG/lYJ5ZnF5772IW1sqD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1U2QHX+; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1U2QHX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy5JTGygj7E8A2quyIubM6UF+g5lLoCUdpolGkScCC2Lary2YfXeQo5uTW8WkG7J89hZVc57ViqJLLHQ7LOFSSAR9KAyyk0rOsN6uFoLsgLZecmGsHhuK5vliICxZjdYEv+yazYGb6c6rNfDg3DU4rLDOjA/UmCYj4WSUqP2l0+tod+L76PPy7CXpJhNoIkh6+R5bxxnz4lZhfOzaLlDfAN3m6Cf80x/zB12+qLUnknC4Mnxxq2xdO8PSpCFa+q4PzDYYCR8PPyxMqKByEzSPAcp0naIpGA2jwWyIxer32B9PF9rjYQSkWM/yNP/IP5ujGd+m6zIjKbNU4B7pGq0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ871K7GQZUGfDvpNQ2mTOm+LgHeyMS4B5tyAn+7T/w=;
 b=EjegcyQUJpgW9Pgwxx4BdzaKLY80IevXai1RXBaiIB0nztdfsy4R6ezR1PIuWEDe3ADNnUY869D7ST8HONtZFbX3j+f0YFbtnfG2SAWWXWGqghnEFkiRZXWbbKbXz0aq486raeMHI1XMK9toDv/nLBd4smAmF2daQuL4P04/zy6mZK8Ef3GRTrauhjTk1HMxr82jXJG8ry9OKDgYJPwy3aN9edDH05iBIlugkdQYQktqxVZ3pTuexuYu7SJtpXtuzpMPkYx2x7xnZKqcYbP/ikUdABY7aHhK2vgQASvQfSkWHTj+ydi0ohVXven3Cn8GuFNSdFu4ZwA96dsdy8+pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ871K7GQZUGfDvpNQ2mTOm+LgHeyMS4B5tyAn+7T/w=;
 b=p1U2QHX+9swFeOpLyMk38SuAq+XzPQaobWG2mdm5Q1b81OUp/f9UxkXO0dmcHF2+VwM9ibcrHPw0p4lQMSph0jWlAcPFsKNJ1TNTw9DfJbi86iRd3VZ7dEi6kLtb0sEp0yzh9i/qM5ib5VIuAvobGjgoRE1Ohlmc7zUCQoOIxPQKvg1BEgYd71TIEzORqUAXaD6+f29ipoXj5BzQJBhQJmbDp9b95mJc7zHN6ByGsuKbItjZjgOwYvWY2k7WgQvduFInqKfI8yuNmIBgCbAtmHEvVYPzP8WCGhHC7jqnGpi/gOT377KEskuUE6qRqAIxxlcYgKFMTM7TjXPGvsGEug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:46:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 14:46:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 23:46:14 +0900
Message-Id: <DJP0N5VGKR7L.2EFP81KLCP9UK@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c56a4c-c02c-4f67-45a0-08ded911d70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	s8ciip8bIlSo9yILHBcyjxV7mCO1g6cXEcee8OKyPDCTRBlAiYxYzgKEDTKOKtRhEaHcwfg+i0C8YFe/nd9wFexeQcSMZ3emudc+uv02dr9JdlRfzHi7tUWM9G7h/xje15kXvVZaqpX4wQbxM0rfSvtpox4vo+mK7nVZTQTpAlQTMpTofz/WhfFv88i5JyK2PRa7X9KsoJ2Kv3m28u4I8dM9Bi7UzpOH9BM5n/M0o9EJk8iJ3tiHad+OIXtIRQGzFyjJ169DTyyODeKw1CWA8N5sPsRknW792spMJSLo+flXyHvSVvBRFDN2vdFlYMwaoGG/PFDbn/ZTKtyXrKoB+iardFvt/UGEe4p5C6+cbq+7cpsgmWit9Sq8pNwkmkg8Bwj8qmiWnJFLbHxS+DPgQAINHCsjm8XHF1x9qIxUlFAw/iJ7rzj3oLEi68026mjXDpC+u8vvbbgWvA0G3DrSBjSXF6nuYm1V5T0aQTl9MzzoaQWN5tOWGP6JIG/492Kq+TmGQtBWv2f9xTEDBSae6uHAyCAtJshuRrM1t4DvXLWf4AxF1+5+19uymM0IKKk+AkPHI2JWNiCoSuGlXW4RzxrCTUqiQiZnx+DrHe6iWxw1vwyjEOFIrKQOD28nwPmAe0NMFUmffyp/BOv2K89v+/ulS3bDBna/ldFJwMk+tEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2plV2hITDRLV3FGUVdzdG04NUpHTks5TlcxK1dDcnROdllPM0VQM0EyUE5I?=
 =?utf-8?B?a1NmczNUaHR4ZHBvVVBRckJTekJkOUF3ZjUySFFLRW5rdnRkZFhEbmNvQnVu?=
 =?utf-8?B?VmJ2R3VPekhncEJZRlduSnNWWGYwREp2ekNlemNEQW93dldMcnQ3MXd2akl1?=
 =?utf-8?B?ZVVKME1SaVo5eW5YdnVPSWFPc3VybmtJajlPYU85VlJFcjkyZ0hlVHdxSHpH?=
 =?utf-8?B?U3ppZm1JaitFYWdhV09vdGh5OElIZ04rUGpLRU9RVmcvWFFSc3VLSDVXR1Ra?=
 =?utf-8?B?NS9nV3FOdWxEWFhTSEJXb3dUL3B0RU1iU1RveWJHTng1cS9HU2hZZ2lCdmNn?=
 =?utf-8?B?UXBPM0dVc0lrWnQra3Vvd09yTnlvSUxZK3k5K2MzazZVdlg2b3hwQ3VSUzY2?=
 =?utf-8?B?RnJodHdVMExjcWVFV1VwZ2piV0o2eEhLRm9URkdGK3BCSkkzREl5bGM4ZHpV?=
 =?utf-8?B?NnV1UGFBTzBzQlhpTkRIYnlEdXpsblNRb1ZTeU5vSmRORnZuTDVWRVB4cW9R?=
 =?utf-8?B?ampvdDVrUFljQU1GUGZIdU5UdzJNOHdmWHc2Qmw4YnB3Um80dUtlSmRUYmJ3?=
 =?utf-8?B?dzl6YlYvbHI2ZHQvVXpGRlpXcjlOMGh4R0ZxeGlWaEthMmd6TjdMR09qbFZ0?=
 =?utf-8?B?WXVVcDJsNmtEYStxV3hqK0FZM1FwNkxsdU5tMk9vNURMSEM4S1k2bmhCbm5E?=
 =?utf-8?B?UTdVdlBRcU1QUHloazhyZCt6eisvLy94UGFpL05halBPQm05VHpxbnJzYmt6?=
 =?utf-8?B?UDhJanUvdGx5VDJIK3lMaURkR1ZZcWYrSDZ6aUxDdEFTM0hUa3NyZ3E3d3Mz?=
 =?utf-8?B?WE9zM2l3cEFNaVRrRkJKS0t5d1VBc1YzTlhLcEF4anVVRlVGMzJJM09xd1BC?=
 =?utf-8?B?NEczYmowMGtnUzdiKzZDQ1owYmhrUWdTKzF3Nmp5QXRjdEQwZUVsTlBhZnBw?=
 =?utf-8?B?ODlJaDlPUk96NC9nL1hzNVduNGlUOTJvemRjdkhDNFUyU3J4VktqWGkzbnpB?=
 =?utf-8?B?aU5DNE52TEdEOGZPc3V3VE1QWmpiMUphWTdaTFBETnFRYzBneU1WVXF6eFU2?=
 =?utf-8?B?d2JoU0psN0NyQVhLQldaUXFOcFZkLzdWc1AvbjZ6SFNyb04yV1NSOTNWNnFE?=
 =?utf-8?B?ZTFHc0x2dS84cWdPa3dOajNkTWgvNU8xc0pNdmo0bWxLeEY2aHhzUnh1bUQx?=
 =?utf-8?B?bW1xQ0tTYklsUVlaV2dwZlVkenhZR0ROMjBRZFp5YnVsL3R5NkVWUGUvRUZw?=
 =?utf-8?B?cFJTV1doMk1xbUx1MFY5VHkrYWpEaTZ1L3JkWHR1bFNCYytkQzY0UWZPekE0?=
 =?utf-8?B?RHpPL1NHaUZ5N3NiYS9vKzBJcGFMQ2NqeXJER2hDVmRLa3N5RE12V1FENk1i?=
 =?utf-8?B?WTEzYWljZS91bEpSM2JxRGYrRHVrMnZqUGdjcVVNai8xTGgxemZUMzFmbVlj?=
 =?utf-8?B?UkdnUlV4RS9QVHFJMStRTXlnSUg4NnFjRUxIcDY2SEsxMkxXZlduVkIxOVBB?=
 =?utf-8?B?cjVvZWRhd3NCeGFqT0toZnpqdlp6bDVxeUJyaWJoUDhvTVpER3VjNFArR0RH?=
 =?utf-8?B?Z1h5VzRSWlgwTE9PR1lmSlRGWklyOEwzYnVvNWxQY0pPV29tcm5mSGxiUkxv?=
 =?utf-8?B?MjFVNndCY1NXMit4ZXlRbDB0VkFTTjh0ZWtjcFk0eG9nWExCNGtQMzNhdndv?=
 =?utf-8?B?ZjFsVW8wSEtXSndjalRnZHcxS0JJR1dpSXFSZzhqYmdFeFdKWnlXZGNCeEhj?=
 =?utf-8?B?UmN4SmtKSlJXamw5eEMyWmVzLytwNUlMMGFTSWhQbWtxNzVBK2tFTVFKT0dE?=
 =?utf-8?B?OU9WMFNFZDZDemhVODBxQlB1QUcxOEdldEJxazkzblRyaGxwSkc5aGlkbUQx?=
 =?utf-8?B?cTlMNHcxeFRZT3ZpRDBKcWs1dGlUb0xKOWlKQmd2cU9xcldyODdRZ3BncUxH?=
 =?utf-8?B?dFlhUjZ6YTlhQ20yT3NLOWhiWGFmRDRPMWJNNTBIc3NSb3c3RkxKVFVqR1N4?=
 =?utf-8?B?VHBxQmhOdkl5TThvZjNDL3ZiSkdGMFU2NWFhYkc5eWh5QWUzQ2lCNTcyOFE4?=
 =?utf-8?B?RDhRWTJTNUd3Wkd0NTdiN3ZmWGo5V2V3UitBVnhJQzgxU21waThnMmxCSkdE?=
 =?utf-8?B?NFFVZVhHd2dzbExOZG9FVDV5REFUNm5zUW5UOUFrRHhqNzFDcE91K2NXNGFp?=
 =?utf-8?B?S2lXeHppY1UxWnJzQ3lNcWtUQmMyZ2pScWNwYXFtRVQ5enZwRlU4SEJ3dnc4?=
 =?utf-8?B?UWU2aXp1eDFyVEZGdEQrZXlmbzlzck9Hb2JHRGNHWVptMjhUUW1oRklkdWsz?=
 =?utf-8?B?cldNb3owcFlNTENHVjM3SFpRbkVRV1p0ZnV6LzVxWGtWempMNGJpcURaZ3gr?=
 =?utf-8?Q?sToocUaYgIy1Gqwwz9XsAfzLIzCGT8YYLPpfbZhCpuX1D?=
X-MS-Exchange-AntiSpam-MessageData-1: rwPUNf7Bqqh6Aw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c56a4c-c02c-4f67-45a0-08ded911d70c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:46:18.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nzIefseE+TV+aq/txvT+Edyx02Dy+8GxxJAPL5iz9+Lom96dks9VBbDQAlBm8E7POhc/An5haDLMEcPKQ6aSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Use `io_project!` for PTE array and message queues to restore the proper
> encapsulation.
>
> The remaining `dma_read!` and `dma_write!` is now only acting on
> primitives; thus replace by `io_read!` and `io_write!`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

This is beautiful. :_)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(the memory barrier concern raised by Sashiko looks real - and IIUC was
already discussed before - but not introduced by this series so let's
address that separately)
