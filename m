Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA63F4139;
	Wed, 26 Aug 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744523; cv=fail; b=t7KbxwvIIJBFK7QvWnAWh23cZoES/68wmFV3P/b/Kc9TfwW4nKYmvHxETRvWARCaV5RrsTLWUvZaf4RRPI86bbfrIHbZR7KWxK78YhNW3apzmdkLxymRXA2YDxGOVmsTLRCD0QRh/3D6y0wbPUvs6JRohcyJ/s1Ydy/vtqY6YTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744523; c=relaxed/simple;
	bh=jWvBJMd3D5cMDG6+rCmapnn7SozJVbE3jl9PN+/fifY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OuKB5FAvoqU9avoiYBriueFKyBUPMwFDYA33kcqpKqEeQ/1PT5jgr75JVCWxMGk95+mXyjdQuJI2jEHDZQmnSWagICCTsEaWf5MIY3HClLMHvYX8yLX6kfLqWDZgiiq8+9rZZM1FHKj32IRSWmNxZK7UquS0IRAEsdKaUAbI12M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1eNBL/R+; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1eNBL/R+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu+UYnNHKch1ZY6uwOnUBO24gLFZzt4RS3bNQWRaC9Y7Izcb+o+Yv4/e90bV36GoRhJJnVJwt8oXhAQ/pDfcNRBUR9wEqhY7OlVvAdWs1mBhcxn+ElWVDQ6BJrmQKNEdB8s/vmkY6faQg9Y1JqJFTTdLnOqvXf6qOa+vm/99dZ7zyW/BSgxjS6wMbt+Yzr3lVbpIwU+5fltmNm0CGClglnjN5SR8ixAnTNn4IEaGU82zXEsOoqNmfuLbdXn1bGJL6yx5GVvPO/ZupRhwWcyhsQAvPw08qBDJCP3TKSfKvcoZchspm06KvhkTyanJRkHVShzbf8jES3ig/0Po6kYUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfRDr59s9ydvFL0JtQK/PQCJ9TqofxBePgBMVpgCNro=;
 b=YLFegK4c4GgqAei1qJ+sIFrBeyLTwowfyGBWWF8Hdv3U2H3T4pGcLQplGJHSMe9h6iDhxHukggHAsTwtxjIqr45rzQ29OSY9yQGJCFoDW6BNy3/FSLGGrW1j5t4cSiH5lU2QRQ20fBvgvZ0oMNup0PyfHTZu41y3LvI20B/vktLq6vbUL3pMVuXkGzgXfo2wnD99c3GLP0D3/8mTXR70HAPf98M6mOkPVTPq1g9VhO/w3mDzdMZ25i7abn8ywzsSqqJZxWSNu6MAQ/4m5ZQYmd3C1Wdjeq/fldz412JU46qXTmBSfZ6C8Nf8OJcIrwhPEGO/JsOzByYrBQJli/Rdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfRDr59s9ydvFL0JtQK/PQCJ9TqofxBePgBMVpgCNro=;
 b=1eNBL/R+fExo8xllnfg/9oFC75IlJ8rcolIhhqULhzt4G70IiPCv3i7YdFtFXMypAk4pbq3S5+zq3/N6S4ynC0yqxHNPpwd9Ux0dGSooaeKMRQvdRIrLMH+x8rEOVvqJ6J9dqgMRSn2d9rjP3jEI3VZWE4vkochWucM8AN01Gt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS1PR12MB999189.namprd12.prod.outlook.com (2603:10b6:8:495::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 11:41:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 11:41:56 +0000
Message-ID: <2776f9b0-c299-45ff-bf82-89b95e73fd60@amd.com>
Date: Wed, 26 Aug 2026 13:41:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS1PR12MB999189:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b01132-6c57-4f75-9a14-08df036707e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tuLv9dEXdXw2fV+zbFStOyciaGAmPRvO9fNJmnClHGg09FG9r0VzfuQBi3HDLAMMoeGfIwZbwhHjM33IR4W9qt12T/xN7U8QKDWZSv6KErHtNzhT4xXkMzzOdz9HCGeSnKk7wJZBy3fSn5grLObqzQ+qk2KKgOfKW2hXwR7G9hniwkILcjd/tQIGTcZW14NvgBatJgup+Fio4R+nRAshNl9cv1+iwNCnSPl9UE+MCzScPRoWw6WvXBQoDaWAIsz48v2JHTf41eJHIWc4I1sT/86hySYt5v5vfnaJogXb0JFv+iOwUX0bkDdKgJ6Ba0gkJ4VnJeBZcJLlhrLL0cqOyGEWIIZ5j33dKo+BeTjAUeEMtBIqSuxLa3KFOviw2OdVYzzDgrLELiB7BXjJdH8m/FDhpItqfo4tsPTBXLv0ox3EUGne6LLIpzT6+x9eeVOKHg65ImQ9TpxC4uNPPNQJY73+K2Ejrxj/w0vmjBhqvw9ycvQbLXIImnBCyl+jeDT4EooJ04h5L9eZe9mnMACBlVn1avQoX66V/LBF9dv1p9AlY/QjfQPU+OMelzPyFW6WjrUqe4S1sT1zfUE37maQHBdA2PNKPobpzkJPtzsFBnI/cERQ1TbErRS229xb6VI6+wpsoELTLjBG/AdfnQPeF5eUGH69g/zQR4K5smMFvv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SngzdFZkMnFLVmNwTWlSbVZXak5KdXdjaURBR2h4TGNUQnNSRHEweFZSdkFX?=
 =?utf-8?B?eWppTGFyY1RzRkhLMmJ6RW1ucUdsRmRiZmRtK1kzekMyMnUvbFdzaUdtQ1U0?=
 =?utf-8?B?TThqSm1PdmdnbVhkaE1YMjZycXNoaFlzVGs2bUdRdExBZGJuNk5Pb1p5T3A4?=
 =?utf-8?B?eG1ZeWVoeXNjU3F4aHZiR1ZDRDRNNzllUzRQaGpWbmFjUVRaeDdHbzEvZE9U?=
 =?utf-8?B?ZFRXWXdGTjUyaC96c25WOWlPblJlVEVSNVdnUFdJeTZENTQyYnZnRi9CY3hq?=
 =?utf-8?B?NkE3Zkg4d0N6RVRDTHYzQURjak1WR2VNM2RoTGRTQkhDaWdhSWs4SGhsZUNC?=
 =?utf-8?B?bXFodytaeGVUc3h0THdzMWJ1bUhXUHZvc2RGRWxVb1V5SGZXSCt3dzg3VFFV?=
 =?utf-8?B?N1RocndpU3BuRVA4L1J3YjJlSFpnQmNVSkxTYUNzcjAzSXhHajVVVXAwT2U1?=
 =?utf-8?B?L1VxTTRSd1o5NnVoak5kYmcwOWtZMXQ2V3l3djJTZGZEQm94RngwWHRqaXNZ?=
 =?utf-8?B?Sm11UU12ZUhsdVNXNHZjNzR0N3l5Z1VRZ05BUUZTdzQ4WHdnT1o4UVlOVmZp?=
 =?utf-8?B?Z0FHWE1qWkNONEx4ZU9tU0ZhUlhUVWNoN3pWM0UrVWc2MWErQm5BZDhtY01E?=
 =?utf-8?B?SDJxcVpyR0pBU0JhVVN2SUxka3R0ZVcrVERLcTRtZGxsRGJwa1RUSEcyZTFF?=
 =?utf-8?B?WjU0SGpQUjgrVzgzSTdMcnRhOTd2Z0s2UXd5cHhBQjBBTmV1YXVqOEoranNH?=
 =?utf-8?B?K3BhbHZaeUFIMzFtT3owelc5ck5PbUVGYUh6aG5XamtCK3F2UmtBanNmSjRP?=
 =?utf-8?B?WExxRGV4ODJBTWZ2VE5BWCtvaXRRM1JaWTlIeTJrQmFIbkswOTBZRXI3WjR1?=
 =?utf-8?B?eVFzMkdtN1BZLzZjRElDQmlZWkxhTXBaa3h4aTlzSmFCY1Nlbk5NMU9GTXVO?=
 =?utf-8?B?ZUtRVHpydGt3Z1dXM3hraWd0dWE2RGZLNjJlL3NPWkRYMjJxS1dPR2lzQmJI?=
 =?utf-8?B?NHR1bWdZTFltZDZSU3ZKTjNKVEFndFh6cVpKeUxsYk9tWVdlK1ZaMHVaVEZ5?=
 =?utf-8?B?RVJLa3VhazQvY1pTKzgwS3VzLzF4cmFTWnNqeTBIWmNoOHhaejZTYkwrT25v?=
 =?utf-8?B?dnJFVWxGUmxMaTlua3dNbm9uWVRoTW1sa2lLZHp4WGRuVnA5QkV3K1g3aXhx?=
 =?utf-8?B?SjEvY2NJbE9sbFFzU0lUNHY3L0NMYzFMSVJ1eXdQL1c5a0lhbFZLdUpsa1VS?=
 =?utf-8?B?NWVrNHBmcGk1bEd2MDQ1WVphbFVnRC81dmFrZXJETUtuOWFJWVY0OVVTaXBz?=
 =?utf-8?B?bjdpenR0cDRYYnNPYVh5RGh4aXRSMFBKSDR2YVh0TVFKWTlsb25JRXd3cXlo?=
 =?utf-8?B?NngyTjRYRmVBdnV1OEVuRTVhT3ZrOUdoYW9Fcmhsa1Y5RkUvblVRN1o3eG5i?=
 =?utf-8?B?K002ZTM3ZmsxL3c1OUxDd0pVQnIycVltQk4vUkVMV0JYankxSUFadEVxbkk4?=
 =?utf-8?B?V0ljaThJTnFkMSswcXVNUXdLSjVwWUdoeGxqa0RleEluaDJKdis1KzUwemJ4?=
 =?utf-8?B?Y1J5azBEVVlrdkR6SnRhYm40RHJLVG4vWElyNStSZ3UxRCtzcG94dWZVVEU0?=
 =?utf-8?B?bFQybDl6MXdPVmllY3VvSnNSLzFFalZObmVoZHczTlViZC9hNnpQU3dVZzJT?=
 =?utf-8?B?bXJWWEVVQk1KOUpueEl1M2dKVUxJcXZOdWJYTEpWMERKN2VIVTNRNWZ5bFVD?=
 =?utf-8?B?c0syV3lLMHFwN2xhQjkrZC8xOVJUaThJVlVuZDJxMU9KckZjTGV6aFhpUzk3?=
 =?utf-8?B?QlgrL3BteTUvWGU3c2I4b0xXMDJqOTNJbS9xeTNCQnByRUQvU1lWYVd5d2VG?=
 =?utf-8?B?bzljS2dqNDRNcnZpdFFMNDJTa1hjOGZpbldEYkZpOFRiSkRkZWdvZUVtZXI2?=
 =?utf-8?B?ZnphRHN0UW1HSEw2amJYMk84R1hQUlhlUDk4MDFIU0Z3UHFYNm8vM2ZnNldl?=
 =?utf-8?B?RXU2aXZhTXdPRkJsSWIyajVwRUtSOWp4K0ppbmhxSlpjMU04aUhsc1dLaWth?=
 =?utf-8?B?TjRxdVAvRk95R0cwclhVenRZY2RCd3B2ekg1aGpGTnNKOWtNNExhVnFZdFhl?=
 =?utf-8?B?bHIxQmthMkZkK09KVENjK2VzV096cVpCS3V2Um1FRk1FYlQ4WXVpY2F2UVF4?=
 =?utf-8?B?emFLb1ZIWDBMTmtLVzE2SUp3TFZScVRDdTRPS3FPZUxaYndqbElpMlVCMTg3?=
 =?utf-8?B?QXJGNnZHeW9yd1Rjb0JvMjVUazBzREluRnRycjl2cTA1ZzF6am8wTktHd3M4?=
 =?utf-8?Q?ZmA4u9G/3agDr0jHU5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b01132-6c57-4f75-9a14-08df036707e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:41:56.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtKanBA4ha8SfgAqQNKjzpwgniOKyGPBxrcRRNQ1iZdVj1pR7QHQpB0HH6BzTl7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999189

On 8/25/26 08:28, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Pinned, revoked and movable mappings are selected by which optional
> callbacks each side implements and by whether dma_buf_pin() succeeds,
> not by any flag or enum. Nothing in Documentation/ says so, and the
> rules are spread over the kdoc of dma_buf_ops.pin,
> dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
> so a driver author has to know the symbol names before finding them.
> 
> Name, per flow, the callbacks both sides have to implement to end up in
> it, describe dma_buf_pin() as the runtime negotiation, and record that
> the pin is what tells a revoke from a move.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/driver-api/dma-buf.rst |  6 +++
>  drivers/dma-buf/dma-buf.c            | 85 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index 2f36c21d9948..39c201f38aa6 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -113,6 +113,12 @@ Basic Operation and Device DMA Access
>  .. kernel-doc:: drivers/dma-buf/dma-buf.c
>     :doc: dma buf device access
>  
> +Mapping Lifetime Negotiation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/dma-buf/dma-buf.c
> +   :doc: mapping lifetime negotiation
> +
>  CPU Access to DMA Buffer Objects
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..30afec7365bc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -684,7 +684,90 @@ static struct file *dma_buf_getfile(size_t size, int flags)
>   *    reference acquired with dma_buf_get() by calling dma_buf_put().
>   *
>   * For the detailed semantics exporters are expected to implement see
> - * &dma_buf_ops.
> + * &dma_buf_ops. Whether the exporter may still move or destroy the backing
> + * storage after step 3 depends on what exporter and importer implement, see
> + * the mapping lifetime negotiation section below.
> + */
> +
> +/**
> + * DOC: mapping lifetime negotiation
> + *
> + * No flag or enum says whether the exporter may move or take away the backing
> + * storage while an importer holds a mapping. Each side implements a set of
> + * optional callbacks, and dma_buf_pin() settles the result at runtime. Three
> + * flows come out of it:
> + *
> + * - Pinned: the storage never moves and is never taken away.

That's not quite correct. The backing store can still disappear if the exporter is physically hot removed.

In that case the exporter will still try to invalidate the mapping even if it is pinned. A NULL invalidate_mapping callback is of course still never called and so still optional.

> + * - Revoked: the storage never moves, but the exporter may take it away.
> + * - Movable: the exporter may relocate the storage at any time.
> + *

> + * Every exporter implements &dma_buf_ops.map_dma_buf,
> + * &dma_buf_ops.unmap_dma_buf and &dma_buf_ops.release. dma_buf_export()
> + * rejects an exporter missing any of them.

I think that this is superfluous, the check in dma_buf_export() should make sure that all exporters follow that.

> + *
> + * An importer reaches its flow like this:
> + *
> + * 1. Attach with dma_buf_dynamic_attach(). Leaving
> + *    &dma_buf_attach_ops.invalidate_mappings NULL rules out everything but the
> + *    pinned flow, because the importer can then never be told anything.

I would rather write "Leaving out the optional dma_buf_attach_ops.invalidate_mappings callback pins the buffer while the attachment is present".

> + * 2. Call dma_buf_pin() under the reservation lock.
> + * 3. On failure run the movable flow, or give up.
> + * 4. On success the storage stays put. Whether the exporter may still take it
> + *    away, which makes this the revoked flow instead of the pinned one, is the
> + *    exporter's choice and is not reported back.

That sentence sounds not really readable.

> + *
> + * dma_buf_attach() is the shorthand for an importer which only ever wants the
> + * pinned flow. It passes no &dma_buf_attach_ops, and DMA-buf then pins around
> + * every dma_buf_map_attachment() and waits for the DMA_RESV_USAGE_KERNEL
> + * fences on the importer's behalf. Peer to peer needs
> + * dma_buf_dynamic_attach(), because &dma_buf_attach_ops.allow_peer2peer lives
> + * in the attach ops.

That's also superfluous.

> + *
> + * Pinned flow:
> + *
> + * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold the
> + *   storage still on request. An exporter whose storage never moves implements
> + *   neither, and dma_buf_pin() then succeeds on its own. An exporter which
> + *   refuses to be pinned implements &dma_buf_ops.pin and fails it.
> + * - Importer: nothing more. The mapping stays valid until it unmaps.
> + *
> + * Revoked flow:
> + *
> + * - Exporter: answer dma_buf_pin() as above. Call
> + *   dma_buf_invalidate_mappings() when the storage goes away and fail
> + *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which complete a
> + *   revocation are described in dma_buf_invalidate_mappings().
> + * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within
> + *   bounded time and drop the pin.
> + *
> + * Movable flow:
> + *
> + * - Exporter: call dma_buf_invalidate_mappings() before each move, then wait
> + *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin play
> + *   no part here.
> + * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops the
> + *   cached mapping and has to lead to dma_buf_unmap_attachment() within
> + *   bounded time. It need not stop the hardware, because access runs until the
> + *   importer's &dma_buf.resv fences retire. Map again before the next DMA.

That is also not really correct. Those flows are not separated like this.

> + *
> + * The pin tells a revoke from a move.
> + * &dma_buf_attach_ops.invalidate_mappings carries no reason, and both flows
> + * ask for the same unmap. An importer holding a pin can only be seeing a
> + * revoke, because the exporter promised not to move. An importer without a pin
> + * treats every call as a move and maps again.
> + *
> + * A revoke need not be forever. An exporter revoking around a temporary loss
> + * of access takes mappings again afterwards. Giving up for good is the
> + * importer's own choice, so an exporter must not wait for one to come back.
> + *

> + * &dma_buf_ops.attach is the only place where an exporter can turn an importer
> + * away. An exporter which revokes rejects the importers for which
> + * dma_buf_attach_revocable() returns false. An exporter of memory without
> + * struct page rejects the importers which left
> + * &dma_buf_attach_ops.allow_peer2peer clear.

That is also not correct. A mapping can be rejected later on as well.

Regards,
Christian.

> + *
> + * Userspace sees none of this. The two drivers negotiate the flow between
> + * themselves, and the DMA-buf file descriptor shows no trace of the result.
>   */
>  
>  /**
> 

