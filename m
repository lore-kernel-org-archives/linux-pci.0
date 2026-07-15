Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D53126DF;
	Wed, 15 Jul 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123456; cv=fail; b=kD/eZp2nPx/RaVyRdmzG1UqpR3cQNxYwFBKg+fvg11y7SXaR7KqU837ylciUWc19ru2zs+AWvNoPEz5O3H2InN1nRxCRLYppmLkFr9ws5sKt2y2fRN7E/19e+21hYgJHcLgxORml/bmEym7yAuNvrpyyHASWay3GVyv94JbbNJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123456; c=relaxed/simple;
	bh=OQTaTJo9OIv60euH0Yg4xevVqOK1Y/pv59l4NAXm40c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tsCAp8sBxwsN/8jbBIEfFKgn1vTbDMA41ftX06ogBmHeywvtKjiE+hgFz94jNiKh0uRGXS5PkoMedzy3mYUF/31l9P4wqbmek4P72DKpXN5wtNa0twlg7I5kZ00n3oxXHgr/jQpafFXSmXw3LPPRCuQ1XgdVuQRikpDcJg0yXL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSAPPvjr; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSAPPvjr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcpT6uctQXcUKttYTQGtkwn8fCbP34zd30sGjXxjYpEB/zRMHgwKKvG64dNOxJyluri8va58PZvGW0IbbR8u/Jf2xRWFDEwzorWLeDz9dT6NLUK789xydJzGUkcAN0gW4W5ik1MWXskZWT5zGRmqGZJJYNQecyTaG10SeD/dMSpeuxW6L1dFrARnVidT1c/MDtPXzbWkdnW8is2m8z5FLjWmpAIsqBWaqH0jvKt98m4VZnBf9ORrXZRgkeKusG9dmnBXK6GIm1FPEPj3kj7LoG0umCglNdYndwW6Cvo8Z13bRy3woxU2hKEPmPy6hAYVcggh6xbFNSCo9OyCGXBSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFl2uFdy8iRMDgQ7ieQtE5MVQILQRNeAmiEMXnVLW64=;
 b=INWvZIBZuvmIv87Dlx3gJV+oTDEi5mr1AeXmvOakBrZNfCeDHMGnJPzt0yuHNDrku9j4Q9Zsqqpk/DH72PThiCkdChPiw/x1QTzbj/GfTC2BNFq+QYPb7vzFi7Nf4m3XBebrFvntx5FJojQ7wKO7oNbncffUuel+kfkGZQ0t1OBl60USIt2REaXO7lo6QGJxoYCypOLWRU6QsNG0rB/c6syE+A6OkJr3C4TH/zT/a9RCAnqaK4NU2+Q8ZYzA1VpaxHL9SbGWlT2zdfN4Ft+uD1c2LLaVceggEUN0m/mmDYUR9mOr2b/69TDEqIxKVStotHyKWajTdeX88ElkCa5rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFl2uFdy8iRMDgQ7ieQtE5MVQILQRNeAmiEMXnVLW64=;
 b=xSAPPvjrxJdqsg3btFumXRgVBq8HsgiNEbQeeDXqxke/E0sQOAl5lBH2gAJyBItaQmB92hf/5ag9BnVSjjVNHlkmfv7kKvs/qVIdKman6ZSV7XkpNLYJHLY0TG2E/ge5EWYprQJVvJzKTYLaJ9RMx+DA+rUVe/IsErcKAXMu8CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Wed, 15 Jul 2026 13:49:52 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 13:49:52 +0000
Message-ID: <f2f1dcaa-5656-4fd8-ba92-8a0e94659f5d@amd.com>
Date: Wed, 15 Jul 2026 14:49:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] cxl: Split decoder programming into a reusable
 helper
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-2-smadhavan@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260709010304.680422-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 156cbc46-0373-4c3a-b4e7-08dee277f1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|921020|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ouTK8CILIQJVXTEbR5A9apJSQKuqw9CXCZNRuxfj9f+UxD1SGh8rn6wi62wYRvegOLpN+vmYNJTeWpxVsc+RAZWm7Zf0SwJVNGuNgBCamEFY64cNIyoyxyc7km1jJH6Js1Lcjt1JCekh7akYYR/YjWZTpSNfE1vTtIV+ynNL752wkxSFz8Im4ECd9bwTxLaTkFx/GmFMbWGBwj3lFwgsaWdY0deda+3fMucxGYADQKHe7tq7ZS67Xxovjm37VezK7dJsciC3Hqv9qe2SPYnqEZ+MsKYswqpx9rZuxB7GbpYBR1UIZcOho560wSQMLIuiqGFCPVoRi101oLowh4pDTCbpmCd5TWHfxpIBVLiuZl3c5AWWje4u8/4oAJeSSU4Flwa80CEPK9FR774utK+l4K/jlcOXJq0YD+6+PTwn9r/bZ1UreIzC15OFLGZEpscR5467gZ0/xpzQhyOyH+3/Tbsj6zeKGsMITCKnfIbgGeGTi5EBrQhCUvkwXSrT8f20vPuwf+Ox+4oRWC2bTue013PBsIX5XftjqfN8JpGSYRsVLAUzaWoMZtRTFnd9nOguVBcrxxIHMsLM1sjz1ZABI0Zf9eug6qCCZamMlwcydMj5n2sMN4mo85WCak3Qge7A7jg0lWDVyuBZrtICrXbQ0y47qFZDO9/5Fzbh2Y6gN6PxlP2pPwOmrkRsavmGO8mCAHWajQvV8uCxT4ETTW4uKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(921020)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE9nTkxXRjgrMlR3T05pWDU1MlVzb200a2VWNGw3dDFMeGZlUU5KeTFHQzV5?=
 =?utf-8?B?Y0xDbDVyREp1YTQwdEtCQmR6OUdkVVdXYmRtUWNtcGxUWGZkYzFxQjRUMnpm?=
 =?utf-8?B?MnJhWVFsRmFRZFk1dEIvK25SWStFM0MxUXpoSFBxV2J2LzczSXV5cjRJWTdu?=
 =?utf-8?B?NGVMY3ByNzhKVVVyZ3VvYnBocG1Jek1aK1FWQVRpcXlFdlJGclNUV1R5SWdC?=
 =?utf-8?B?TW5xekFKY3NGekdoZHpHS3FVVDZDcmZ5R1hlbFJoWm92L1V1eXpaWi9lKzls?=
 =?utf-8?B?dGdlRFE3dERJbDVBS3Z0a3hpY211QUY1MjZXQ1NvS2pvU0I5bnprRzFFdUhq?=
 =?utf-8?B?T1NoUnVvQ1c0UnZrVnVBUG4wUHJ3V29tVUo3bVlTTDlSTUlmN3FtamxEeGRy?=
 =?utf-8?B?L1BJc1ArOVBMWXpPOHlCTlZzNTJNOC9UVjBBcFIvSUVDR3NzTGliR2I5dzJP?=
 =?utf-8?B?WEczSTNsSlRFd3kydlZ0MWh4NXdoZ1hIT1I1VmdWVld6bzFnSlRoMXpTWmlk?=
 =?utf-8?B?Vnp2V0s4Ui9ub1J0SXNIRVZkMlJMdFVjTWtyNVhzS3VtYXR6SERWdlZjSEVv?=
 =?utf-8?B?TGhiT2ZuOE5yd2crVUxDZkhrY1lwVWhBR0lPRDRzbTlKYUhrTWlSY2M3eUl5?=
 =?utf-8?B?VFQ2RFZRNG9IMmNpejFDMVh6ZzFzcVM4QUdzVTdKUWFRQ0JCVXVyVUdXekh4?=
 =?utf-8?B?S05BM3RYYmYyWDY0VUlHMWVDRzJYVmZCWmg5M3hCdkJkNXM0VXJwbkNabUh5?=
 =?utf-8?B?U0RFSk9KMVlIazliL0Z6ZEVSVTdqNHViUlR5S3lNeGpVZ1ZmemJ2NzJjM2lH?=
 =?utf-8?B?LzFSTkxkL1AxZW1ScEgyRW1hdUlwUGRWcEwzWUhNY3VNSVYvcEpNU0VVUEZs?=
 =?utf-8?B?VGdBWG0vaGFtVFhtZTZJT1VIVkkzeCt0MXl3ZGlkNFJDOElLOFhTWDNKTGNn?=
 =?utf-8?B?MnM0cm02YStFU3FOc0NDTEpVVys0MW9uSG85R3F2enlPQ0loWDk1YlBUUDJ2?=
 =?utf-8?B?RUxqZUltU3BKajBETzBkY1BTMTF4Z0lzU0t4aFMvUjVjNncySEFYYTQzM2Mz?=
 =?utf-8?B?K09wenlieExpWkNqWm5ST0RHdEhVaTczaHNMQWlaVWd5NWo3a3dGaDVuUzFa?=
 =?utf-8?B?MENnaW5qT0VpUW1OMVhJMnZTMmJlSm12V3kxL25TNy8wL05IaGpRdTBZd3lm?=
 =?utf-8?B?cVkvN3ZZSFh6SWgwQUlOdkphQ1puekk3WnZBYW41QUdJajZ4Ui83S2wwd09j?=
 =?utf-8?B?ei9jZlRwZTE0cmZXNTZXNTNZRnlCQUpGQjN5UWd2cld6K040OFFpUlkzNGFo?=
 =?utf-8?B?emp0VklnSjJhQWtrYm15bWNSa24rZXgxeHNiSDJWc1VHTGRLZ1NlRnQvcGts?=
 =?utf-8?B?a3hRVGMrNnBWTGNOZjBUUEhvbEcreThqTVJPTGF2MGVwcFd3VytqSXRsQmtJ?=
 =?utf-8?B?UlUxNVVVbDBoSHlRNEluL2psMkJvWXJlSWxCN0xsR2lxTWk5U0Y3RUhCU00x?=
 =?utf-8?B?TkZNbWE4M2Nka09hb3JqcnlLbDBhT3lMb0FMTjQvc3ExSXBQQVFYUE5CZmxn?=
 =?utf-8?B?SWYwbUd2RFhaOHh6YXUzZis1THNUeTN4UWpOeWRBbVRhYnYrVldyVXBNZ00z?=
 =?utf-8?B?b2V4MS9FWjJ5aENHTmN2SWRLdWhOV1ZYSGRLeGFnN0RNNUUrTWFtZXpibEF6?=
 =?utf-8?B?Nmp4aG1ONFcvMC9nZUt6L09NNTdEWm9SVVo3cC9rR3hVSm1jc3gyRTJPNGVr?=
 =?utf-8?B?WnZQZVlpYS9XM3JKT0dGanZlUHFoNjhHQXFYS0hSdkVGU2srczlYOG9qbnMy?=
 =?utf-8?B?VXBrZkttVW03T0pyT09nOVNYKzFkeGgvZXlYVE1PMHJQWnJyL0dLK3VuKzZX?=
 =?utf-8?B?cmQweEo3WEhqNndVQmZIUlh3Z3lxUjVjVFFsLzNLVVgzUGZuZTBTMXRrUTVm?=
 =?utf-8?B?aFlSVVdrNFUzUGFadkdTWHJtbGQwUjlPNFJod2JOL3Q4M0FhV3pxYldBQ0FT?=
 =?utf-8?B?L2crSFBwa1g4eEtsMFg4WVlXQ3Qzb1VCWGZZZXUyTE50VDVvdUZORTZGK0pH?=
 =?utf-8?B?eSt4OTlBRmlKbklwSWN4ODJ2WThjZVlGcVpGYkdXQ1MrN0tuQWpYUzBuVTRD?=
 =?utf-8?B?b1pkMC9Hc0FRcnlyMnZaN3AyOW5VK0pCRk13NEdFSGl6SGhNditYcE5ySWow?=
 =?utf-8?B?YXhNREpPaDk4WUtMSEI1Ti9yOUE2OEJwUkFDR2duZjQwa1RmcmlNNGhiODNz?=
 =?utf-8?B?TXdaY0p4VFE2TkV2OHFlWGlhaDdkeG5GSUhsMDIvcU5ZdkFjUTNUeVhVbG9K?=
 =?utf-8?B?NDVHTmt1Wm43SXkrRWlSMFlrTzJjK1ByUTV6aFUxUVJMNkZ5a3lDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156cbc46-0373-4c3a-b4e7-08dee277f1af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:52.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gSroe1eljTBqIFHN/TzVIJK7aIqn4NcEaJP/28kOPfgF7ifvO9pciZKK43FZ9RZkVKRtrmsHlNoRHIvBAkMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831


On 7/9/26 02:02, Srirangan Madhavan wrote:
> Move common HDM decoder settings to include/cxl/cxl.h and route the
> register programming sequence through cxl_commit(). This lets reset code
> restore cached HDM state without depending on private cxl_core types while
> keeping hdm.c in charge of the existing commit policy checks.
>
> Build the low-level HDM helper under CONFIG_CXL_HDM so it is available even
> when cxl_core is modular.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/cxl/Kconfig          |   4 ++
>   drivers/cxl/core/Makefile    |   1 +
>   drivers/cxl/core/hdm.c       | 122 ++++-------------------------------
>   drivers/cxl/core/region.c    |   6 +-
>   drivers/cxl/core/reset.c     | 118 +++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h            |  43 ------------
>   include/cxl/cxl.h            |  55 +++++++++++++++-
>   tools/testing/cxl/test/cxl.c |  10 +--
>   8 files changed, 197 insertions(+), 162 deletions(-)
>   create mode 100644 drivers/cxl/core/reset.c


<snip>


>   /*
>    * Track whether this decoder is free for userspace provisioning, reserved for
>    * region autodiscovery, whether it is started connecting (awaiting other
> @@ -322,7 +281,6 @@ enum cxl_decoder_state {
>    * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>    * @cxld: base cxl_decoder_object
>    * @dpa_res: actively claimed DPA span of this decoder
> - * @skip: offset into @dpa_res where @cxld.hpa_range maps
>    * @state: autodiscovery state
>    * @part: partition index this decoder maps
>    * @pos: interleave position in @cxld.region
> @@ -330,7 +288,6 @@ enum cxl_decoder_state {
>   struct cxl_endpoint_decoder {
>   	struct cxl_decoder cxld;
>   	struct resource *dpa_res;
> -	resource_size_t skip;


I understand this change moving skip to the cxl_decoder struct, but I do 
not undertand why dpa_res is not moved as well since skip refers to an 
offset inside dpa_res. Doesn't it?


If I am right this assumes only one decoder and mapping all the DPA. Is 
this the intention?


