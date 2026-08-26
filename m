Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380E3E3DA8;
	Wed, 26 Aug 2026 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745020; cv=fail; b=pk0dLpiZQbMHkZibVU8A6VMDLgPO3u3gR7V0Sj9Im3g6hWBPs7LNa011t5NRaN0RjRk8VMWnrGQbMWEn9hIlvoNYvDegjax1OmOlooG/i1r10NAbsO0TF0A4bL39tP6PU1RdCrNINE5F8M8X2cMLyayjmDsdQTi6QyTJCF9avJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745020; c=relaxed/simple;
	bh=MLPsFcIyUy4m0NWu/LaRWsb1Q+Mil2Ied4qaoK+EiYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUShGfAbyZI0Q9qj+16CamF9fKKKRAkzL4+A3ELNsOB6PqfoRHfQR2KhTA2YJVsZemjeBKhsP3KxFlomJ/3UbPO5oStJA3yoIGhN6l28nrQBticRFfYQ10tSoRH/1oOLK+LbWW7Ywj//meOldNqa2ahB1Z5zBcIEBYp4pV5RdRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s5i669sK; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5i669sK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAohs0oIGil4FVOvCVmBwlAhtQzNqm13l2KRiWPQ9zphPAPiQReQ0Y3xYRJ55bfzinsA4EBRGRPm302/KROZxuUmigA608Je18nTL/hyamiOGJHDloLTK2fZCIf1swue5qP80ik/MrTFrEeO3kbzu67M6q16tkZ4NXnLwiPD145trb77cShBrp+sPvcdqDn8/gYw4YI32rAUdY3gh7MB13iwYu78CzSso24zw2+Bskklr/aFwEZlfIJJffHGuVtbKlFMJ5T2I8ewa7twhLXWD3vOCtMJRQzRrqsLDGxiM7YHZoS+ELaNTw1kisfKuzDdZG5sgQ9mbPSbyzV/gaIjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lxrH4lY9NfwLBq4Eu0mAFP4TjZqZW+1qzOOuNZ7+es=;
 b=EqKKUBJ80ExBoJ/6dZYeOGPtIedSHMgl4XvpR46FvEwJ7sCskFI4yb/fXBvaxQjgIYwSUSXYzQh6IehmDDCmJ7WlFXlIsWzNR7OWhKP49QUkqF9/mRED5Cfk5eFzbewRdlOzCOhY3/t0bCvpcnpkdWFWgYBnkUQWjRRimvYfa8bQ8GU5LkXvEVGVOk0k7Y1FV9pNzXYoH/ZyRSHIJovZADbnMBAjl3dBe/HofwA36za/2XHsto4PPmT++rmF7KJJPXvYQv758cAqsTeiQDgF3W7G+NSlnqpv8UStuwvdZfpTIKSvemT3hrO8dOGl0ej/BEm9Kv7Lm+6L3ywq0jXQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lxrH4lY9NfwLBq4Eu0mAFP4TjZqZW+1qzOOuNZ7+es=;
 b=s5i669sK14VwIrEKhhH1WI0wHW3T0EFNf6WgN8A6QjikHjnrodSnOMOkwy0SjMKoIJZ/oQTlDWEzBtpaTqiLXoLYzNuEWk8QPtHh/wcfPJjP4f50JlXIN8zQHtplwW+gy1cLN3vvv4HDr9KD6ZgXGbVakSNdZncGZr9BV7rzavI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 11:50:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 11:50:08 +0000
Message-ID: <76e18d87-6550-4ddb-b2bd-0063598688de@amd.com>
Date: Wed, 26 Aug 2026 13:50:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: f8304bba-d2ef-43e7-0b8d-08df03682d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|10067099003|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eTwSjUnfN4pv8983QUx9tHHo+IRq2wYNwgIGvMHKXWdKg04qjL9eZYpkFbt59avEURy3uonUoMNuH04sI7NbyrZuPvQz7bjgLGsWnxIacloEMH7+mmPrejC/U6X3XNEhH/+/9BYkncbniYR/pE88NjpvWNcOye0cf3Lb5jqHXYsmHsy38sp3IdTAbr0PJNlBhNYH5w568eyU0vlO9Qa/uCfPqt8tHXBgOgCdQz+a4XoEMoLijaSnVunuzmdlvxjFDMop7JFfb9Nb4nVDpbGNr62sJxTBhswDvYewbTlndmSGAoiYUhLWRJE5j/Ew64wEIyOtLM0GbT8CDh6KicJntbzDdZsPrN4PVvKEdD34jI9faQ+mTrrg5FqL+gSjvTBIfU6JBBP17xZpKIXHHST6BYYhjULJtE3F3ZxEQ472alvQ/+1KshKP3myhQCYshWiqmXgxHty70iS/SVROWy9PpWFAhhzOHemwTA/T1TC3cYpdL2QX1LuAEJWGhu14YQXRZJB/3Ov98NlZuAwPpWFC/tLG1kmqMQboUXV6NLIE4SKwGX/qlAK7myQpP1Qpq+z1HR+RaNQ3Lff1ORXSCsc+VVxBcHKc8PF5IK/zXoSffp7ZYw0FgXjhngvwpqwbTXqsVeaq3wgmMbHJZKXOrLFJFM7fxYvwQaNU7I4G1KZucDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZtS1Y2WUtjNGNXbFdWbWhXOFZyNm5QQm9MY0pIcHdxcnBiV2ZaTkNrRTJV?=
 =?utf-8?B?K3NoT0l3dmZZZ0taM0dZaHYxdUxuUC9ESTF3NnZOaXNxek9aV2NuVnA2Unlz?=
 =?utf-8?B?ZWxwNGR1SmdyNTFuSU9uZEVtUlorT3ppNjZyRkYrOU02Z1I1M2wzclZlUEFs?=
 =?utf-8?B?NTlIS3I3bHBxbERNdWFYdHY3QVd0Vk5kdXVoSHdDeFNONlNJMU9CT2JyK09W?=
 =?utf-8?B?d0xPbzBqMGJMZSthdUdwWjlSa0srMDRqTTFOM0FFUWRKa2UraGZiNDRzQ2lI?=
 =?utf-8?B?YTRWcUNkaE9kV1lMYUNGRk1oOUFmMkJWTU43K2dpODdKVWpRcXJsbCtIS2xU?=
 =?utf-8?B?VkUvQnpLZ0RjZXAwSHlFTmY5aG55ZmRZcjZxQ3ZyRHlndUFBRGc4TjA1bTZW?=
 =?utf-8?B?T2R0ZHdkS1pJdE5DUngzc2xvWTNCdmRBajA4V3JzbnhmTUJBTnFBdXoxeVdC?=
 =?utf-8?B?WmZ4T0p3S2w0QmczRGE2VkV0YnpqNjExRTF0dWFBem1ncGY3RlBPNzg2ZUYx?=
 =?utf-8?B?NHh5cHZmeUVybFRFZ2txQmtJcWhVMHdHSjd4MVdQVTFrQW9qaXU1dFdxYVdG?=
 =?utf-8?B?MEQvRkVybGoyRmNTZm9VUFFHakNzdFl2OUtDazhCSnM1U1V4QkZXV05JTHRv?=
 =?utf-8?B?ckhLaXpaWXpZWGhHQmZ4czMrSmN4eTJiTExqMFlsemFwM2Q2Q2tNWkgvNG1H?=
 =?utf-8?B?SGh2MmJWVi9HK04xYlB2WTBFR0Q2bU1sbTkzS1A2b0tYajUxZy9jNWcvQlRq?=
 =?utf-8?B?L3EwQWdKbEhDZEs3bWtPUGFpeFlMS1h6N3ArWkVVQ2lGSS9OU3ovb1pQQmsr?=
 =?utf-8?B?c1BOMTBDbFplaUtkSS9zYUxCNEFvRzRzeTNuTitDK3F3b3FFWThubGtiSFcr?=
 =?utf-8?B?YjlYdWFVcEFzWElKRWdPWUx4UXF0NU1EbjdDeWJKa2wydEF0TkJjQnVySUxB?=
 =?utf-8?B?MFZsNEdTZlJRZkxnVTNvS2pHM29zeHJVWEhmRWtSWjhPbDYvd21KV0hnQzBr?=
 =?utf-8?B?WEFoc0dtT214bDFQYjBkOWdIVFlYWWcxU2tmaUwzTkszbW93TSswRDRKblBG?=
 =?utf-8?B?MTVxczh0QjVzNGxGaTUzQktUR1pEQUZmYkxCdHJZbktPd3lwbkFVbTdRb00x?=
 =?utf-8?B?MEJ0QmhqcFAvRWx5bzBOL0ZZRzBrbUUrNnduZ29LcTU0L1BKVWIwaTlMWWRV?=
 =?utf-8?B?d1l6RExLNHJzN0ZPU2F4R3VDeitWMDNRU3B6UFZoSFdCNGFtd0pXZWxjYUxZ?=
 =?utf-8?B?ZXNVY0tHZXN0QWFpRzdoVU0renRVUlRUc3B1WkVSRzgybU1ML3IxcUd5endQ?=
 =?utf-8?B?MDVpZXRTQXU0OVl0S3lCT2V4MU5URW1PWlhvVU85R3EvaERRdk5UZ2ZJY2Jx?=
 =?utf-8?B?ZjNDUEpmV1ZwaFZEVkVHR01zR052K3lJRWVwSUVWdlVVdGdqZm1pV2crM3cz?=
 =?utf-8?B?N0NCbjgwRWdCZmFkVVhBRGRQd1Q1cXlkOFgyNFkwVlZiUE9XTmxsRG9WTiti?=
 =?utf-8?B?NDA3ZlliUUVlL0cyYm9TWE1nU292YVZpeWxnWWNuY3lOak5iYmlkTWlMUytS?=
 =?utf-8?B?UlRhQTNBaUV6UlBFUUxZbTlQZ1pKekhhS0pWanlUZ29UemR2WkFia3V3Z08v?=
 =?utf-8?B?SXZNcVpING1HSDVZN0Z5VDlCSnJGYVVpMzFnTTJLVzFaNVNVR3lWZ1Q3eEVP?=
 =?utf-8?B?NlFTTjE2VExsYUdyajNtckw0VEQzTGhPRjFWQjR0eHZ6dUJYWnZJN3FYeVh0?=
 =?utf-8?B?dVZXekE1T0ZMakVLRCttNXhWUG1MMzhMTHF5Q0VUZDkrdU04VE83SjNHOHli?=
 =?utf-8?B?ODFQWUhhQllIZlllWThyNUJoK1M1Uyt2SVlzREZmTC9abzlTTEJFdFhCT3pP?=
 =?utf-8?B?UjFac2ZnaTNISWpYSkpIZnBaeEZMa0xtRkZlZzBPN1IvcTQ2VTd4Qkhkc0Qr?=
 =?utf-8?B?SHA5RDlKNjllOXFjQkpPVXNzZHJJOXhaMTI2eE1CR2J1VWZ5RzFCazJldGQz?=
 =?utf-8?B?M0FOeTJINUVSb0cwNjZMWlNWUGpHeTQzYUZ3cmtTTnZSKzQxdEtEQVhwUW8x?=
 =?utf-8?B?VCtpekdST0NkVVJXbGZVbEg3MlhrRUIwTWVKeExvVEJPb1NER1I4RWdiVnNj?=
 =?utf-8?B?dDNScFBZMm1kcG11bnl2UnV1REljR1BKcXlGdzFmTkF5bmthaU5xczBOMVJX?=
 =?utf-8?B?Q1RSWjA4bzB4engxek5qaXJWaHJmaWFzNU1HN1FjZzR4Y0h4QlI4UjhzbEE5?=
 =?utf-8?B?ekhLdFpIZEtMdnpab1ZGSkEyYkRUOVh2VUw2TVNlWXpNNVE2Y20rekZQbVFq?=
 =?utf-8?Q?HydqEI3K0ySS35oC5c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8304bba-d2ef-43e7-0b8d-08df03682d48
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:50:08.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ7mbgklgDihSXUYKDMIb+rDseMj33IS+7FdvVLt4OaNtR0DO+S9Mp7tdOnUiHWU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322

On 8/25/26 08:28, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
> 
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
> 
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> index d3f406cca694..63cff9e4d2c9 100644
> --- a/Documentation/driver-api/pci/p2pdma.rst
> +++ b/Documentation/driver-api/pci/p2pdma.rst
> @@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
>  is used to determine the mapping type. The phys_addr_t-based DMA API is used to
>  establish the dma_addr_t.
>  
> -Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
> +Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
>  to remove() it must deliver an invalidation shutdown to all DMABUF importing
> -drivers through move_notify() and synchronously DMA unmap all the MMIO.
> +drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
> +the MMIO. Importers unable to complete that unmap within bounded time have to
> +be rejected when they attach, which dma_buf_attach_revocable() checks for.
>  
>  No importing driver can continue to have a DMA map to the MMIO after the
>  exporting driver has destroyed its p2p_provider.
> 

