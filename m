Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CD3B19A9;
	Tue,  5 May 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996812; cv=fail; b=tuzqSxWUXz0WJMLX0uywJUyF7ZN0sz935LMtSrBxobnL9gE2zE6DnL2pQ6eSeFCbp5a0FOTMGqn1aJTPURcp2bff5NKplQ+KdtHU7XRZ3NwYnQkSJ534Dj+31e+vY1yh5sfflJ3XIwBlCwWfBg/mlSI0WrJCrfcry8m3gWSn4sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996812; c=relaxed/simple;
	bh=BYj2+FgrkKaRErRyvkGIO58yqMhOoFkA1Hb99+O85Mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5CRVjy9alatfoTn5eWJLfKoPQl5l2srb946af0fj8XDpPxCnFc8fyKXOhu0uBiflECHRfUjR2al8eyhEON8VTgJRldf/sM613VszyztXqzeUwgggFkrBSFwAMV+yetLCD37o9QrOhP4KIGkPxmSlXK141PJ9/skIcfibBDyBqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MPK2YPSF; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MPK2YPSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjG95ryF0xQt46Ind41C2/GV+oJhXP0WJOxyO5o88z6LktYKU1BjnFFOXDTVh0qXjB56O6CEF31TDum9ycT2ir4idN2N3PyivS3ExvQ5zN5Xoekl2dtc3xl91YicWlORBfffHKqxZ26a6OKCcwfFp/G9jR+nk1nvopBL0DBWR95Daqpu+S9ir1c6Mc7ct3lU6610ma7Dt9KHoN3dEFE2jTU4T2/eHnS8GX8YfZkwmLitkJ5tICeUeAIyWudlbhqIH8NnPNBEPnO/lIbccSobH59OT174mnbD9tf3TKJ0rgbBJlsfsaJR+iVjtyz132+AE6ZcOU8wVUaOuPsUGV/fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DwvDfGlfsWQMGOzo+sbv5bCxpkKguGYYN38Oy/J7Dc=;
 b=w+PPmangmz5vWt93z9qBNTHd8GS0owbEHFgbnlw8P5SEUA2zyMSLHVNPKp07Vumdg834vX//YQbvoAgL4oFx03EvvaqWZ3hPfnk33w7kxhwiXMlnEn7AczPmyWknnwWuu8lz2w+iA520ZrN6W7btch2zy7bTee5M7vc4nweVKGAFlUoRxfF7uDmNvn53ywhofxe1lESttWBPq0DxGvbc9cEBPDc35GcZQSaJucV+2LcuUixeTJsmSa7yh8pd0mnI6bOdnuOF/Qx8woAFYRHYvGAIInEI5okgOcCLU4gMy8CvG0I3dw+X/VLFJ9V6lJuMQSkuykuzceBJNi2+DkOJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DwvDfGlfsWQMGOzo+sbv5bCxpkKguGYYN38Oy/J7Dc=;
 b=MPK2YPSFVRDw4Xs5SGZxiqBhjtukncx9HJdzfjphFaXkc0SCoe/uzFoe5WbV1DowYQc/zivFBwZjFtV+N+/nmiVS26z1aJEfTKyraBSMSG2CyiovaPLuXm7OBbooMvJCWJ9jlhiQWRorPI0xOm25AiFaMxp8J0ZawR5pl4gBjAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:00:05 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:00:05 +0000
Message-ID: <26e1e270-c6ae-4389-9956-3b4554db7735@amd.com>
Date: Tue, 5 May 2026 11:00:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mark Thunderbolt-attached devices as removable
Content-Language: en-US
To: Geramy Loveless <gloveless@jqluv.com>, bhelgaas@google.com
Cc: ilpo.jarvinen@linux.intel.com, christian.koenig@amd.com, cristi@ieee.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428223147.3092087-1-gloveless@jqluv.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260428223147.3092087-1-gloveless@jqluv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be99698-0bdc-4a26-50b0-08deaabf5fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/p9Bx/ecw0d1ar6MFqSg0pWrDMGjAaX2WZyC7rZXuQHQVdEUNcySx7Fb0phMXnxksiYmAOz0wQWRN6aP6675bv8WNaN+aV2anNZaw06OQfl1tnzKARGZPvkpIObOBmR1jWTTcvHjtzoubVfaEBEgVy/19NB+5uFAhHve667HStxXTCQhNg95akR3UiWgCIMmAstcql2RbI6RUABmedqro/lJ5Bk8l71jRSvhn5UYvwbcItZylEGggC+bFeB0hHBhtmiqrD1bzoTyO3paCLVAfoai6/+1MbUxyCtEXbRjOPzeauNW0fuXdCa8yvGz798SSgUEAegWGIJg67VbYKB0zdFl+MQcjZ6zNudXdSlLtxGCRfy7LcgeNUsNBEU25kVFQLzrm7k472pVF/30wZB0dmc+MTMtnHEaZ9U6Bu7wI3H+Fvrl+itR+XkxmbA21CE5RwYdjR7EZ7c6Kp38BzDkddI04Gp2UFm5lcihRkUoYUGEykTR+lofjvIP3U4icTRttnX8wA/eJaEmThF9c03Z4n0ExUb3M1iJTVBU1lobwLu6ew+T5uHBzz4qtxT7zMCosB+HqkOtHzbPT69uOIdvHHmNY3xNWUqtDlPHllKlM8u3Le253LOHD+gEjJjvAqUuPD8zUSjAAxEAnUZ7kCfMThspckAzk2X6XxJYmyZwAdsYjOvkoZyuTr4OSNnf/LKn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVJqSzVITmwvZnd3SnlnSnluSXNPNHZOb241STRRNXN3U0xZUjZJcTd4TWZO?=
 =?utf-8?B?dkhuUTMvZUhmM2lVd0g5NVpXaDJmTlB5YkRwT0xDU254Y2lwZ1c3VEdmRHJm?=
 =?utf-8?B?dkxQaStlcVlaZFJrcXBTb2YzWEViV2FzNGs5SzQrY0pUb3h1ZXdmeHM1Q25S?=
 =?utf-8?B?UmJ2L3p0WklSNndXWEd4NTJtTXptRFV4SWkrR0ErVzdZbU9uUEtldDM5NTVl?=
 =?utf-8?B?eUxLTjdpNk5Hc0U5S2Z0VTlhemFFL2VjRFUxU2dES1ZBVU9ubVZMUFpyVFF2?=
 =?utf-8?B?NEJlazN1V01nNEttVTlENWwxcUZCeURJRVN5OVlnNFJaLzQ4dGRieDRIRkdH?=
 =?utf-8?B?czJ5VjdzcXBlbnpEdWt0bzlLY3pRTWdNSGF5UTJ2WjdZU2Zpay9wSW0rSXlk?=
 =?utf-8?B?Q085dm1JVWNaam1hSkNJbWdyUkNqVTlndldSRUgzN3hCTlBKZXYzLzJlNWJ2?=
 =?utf-8?B?YnQrS0ZuK1NkY2FSdmlqWmtKR1FOM3BhbWhZeXY1M2NZeDdJendyRTgyN0RM?=
 =?utf-8?B?OGRPZDJTMHliUTRhaTd0RTIxdXpnWnZ6Ny9iTDBtc1hmZjdJSWZjaTRKM3Nv?=
 =?utf-8?B?eXl2QjFJNjhDNEpLalI0VG9HL2JFbnoxeUV1aU00M1VPM0VzeGxzNTE4Nk9L?=
 =?utf-8?B?dVhFbFpkM2RNL0I3WWk1Y01xcGdoQ1lwNkNGSFJvWFNUdHZQL3dvVEgxdXZl?=
 =?utf-8?B?dS9YNDBJblE0aVQwSnZ4Y3Q4cndIOW9rVDZTdUN1TnUyS3VWY0owRXFQMTNw?=
 =?utf-8?B?TWEyUm5nVVR2Z0VsbGt2NUVpTmRQVU5Nc3JBdDBtVi9KeExvRVRkR1h1d3pB?=
 =?utf-8?B?S3VWZnRNMndsRGYxcXlzTVdBa1JUblRsSlU0bHA5YnRjLzgxeWs1ZVZRRHYv?=
 =?utf-8?B?b2dBcm1JT255Z1BQbVpXUXZKYkxJK0lUK3FpelFTS2J4MG5yQmlqTFVlTlVQ?=
 =?utf-8?B?NGhydXpIV2JoZkcrTS9yNmF1R01TMVVZbEgxdTZPTDJndTFuaVRyTHJ4VTZa?=
 =?utf-8?B?VjErdmRkd1dSb29FVW5ZS3MyRURjNEdtYmxkcGpwRHlMbmdsYWpIM0dhWjd5?=
 =?utf-8?B?MVdJQnlsSFBNWFdtM0NxVURRc3h2a20zSEVTVjdtZEwwYmxES25uTUx1ZTQ4?=
 =?utf-8?B?ZTIvMGt4cTl3MGkrcE5ISjlrM3JnMmY4UitVNHNwMHlIbHJqbllSbWJraDMw?=
 =?utf-8?B?RFpOcjlWbzIyMExYTkw0NUhaTTVNZjhzNGNDVW1Nek83SU9yNmpyKzV4TEpF?=
 =?utf-8?B?bmJBVDNMQ1lXZVpNdXVEQm9VWDNlWit4Z1FDVlk2UEQ2VjFTejVVbG0xZkM1?=
 =?utf-8?B?dnhLYVRVemZwME95Q3hUTHhnR2U4RDJDMzQzWTcrRy9JN0Z5Y0lQOWZqdk1J?=
 =?utf-8?B?clZZT1lqblJHUXhrRCtDYmJMU1lLK0V3dE5ub01VWEtHbnpVWVFROFBQSWlX?=
 =?utf-8?B?a0dlU3ZFblE0MEM5djZKbFNNZXdsQ3dDR2lTNDhCUUtTRzFOOEpQRkJIdThI?=
 =?utf-8?B?bmlxY2dVNDJld29tWU9HYVppQjJ3TWZCOW9XU1VoRjBSZWdNWVcrSTl6cHpK?=
 =?utf-8?B?Y0VncDJ4V3VsSkYxY0ZvbTNQY1A2WWlpU3NwU2dnMXZnZzM2VS8rZUYwZTdo?=
 =?utf-8?B?cVRuelcxN2gvZ3lDZXp1aGFHWE1nNVhqbGNDejZSUEkrWjI4WU54Wkw4NzU0?=
 =?utf-8?B?ZnlRZU9lZ1FFZWJNT1lkMnFwSjJHK0dWbC9OYjdmVk5IektHeHZpM1ViZUMr?=
 =?utf-8?B?aW0xSmtiNUVjNmQ3V2JNcXBGZ3BVUkYySVlZSHVlRmsrNnF1RHZDZmRnUEM3?=
 =?utf-8?B?SjJPYnZHai90Z01VbGdtdU4xVERaVVI2RUhTeVZ3WC94NUU5aTkvaGNWM3RL?=
 =?utf-8?B?TStXL0pNSmJQTjZVZG1aRHFKVWdBYUNrSExmOGNXNDBCVXZ4dTVHSTM2TTNj?=
 =?utf-8?B?L2FwRlI3L0U0dktmZDJBc3ViOWdMbEsvR0pqRzFNVnNqblp1ZmYza3BISjVF?=
 =?utf-8?B?V1EzZGdPb1oySE9kMUxYM0dsSzBSZCtpa2t2OTlUVnF5UnFYRDFsS1FYZHZj?=
 =?utf-8?B?RWlmSE5uWVNJS0NacWtrM1FMMTRteXZuRmRRc2RTUHBjZ21LMTFScy9rWVBZ?=
 =?utf-8?B?ckRuRWgwanlERGc3R1gxR1BSa0RJTG1NdDIveDV1QktMZzdsTmRUZk5ka0ZV?=
 =?utf-8?B?OGFOT2czcjdWQ1dsM2FJYmlhbTJOK2tuUGNuUnR5ekY4VWdSWjlNRFF1WFFq?=
 =?utf-8?B?YnlxK2ExUCsxcFFuK093c2FXVTNJYnNiQ1NHS0h0WTV5eDBpTENxRUdRb0p5?=
 =?utf-8?B?M2E3UWRmdWZITXlmRDFoV1JRNDlxcERtMVJCd2MvUzdnbm5xcG80dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be99698-0bdc-4a26-50b0-08deaabf5fd2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:00:05.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVyKR2GvTlNTqzn0e2ca2MmsoqKu4U6tWfcuIUFMP5rPmO1atMQ6Sg+g11KeoTbj7e6+EvA/sKO9jtzMHyEfSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315



On 4/28/26 17:31, Geramy Loveless wrote:
> pci_set_removable() only marks devices as removable if their upstream
> bridge has the ACPI ExternalFacingPort property set.  Some firmware
> (e.g. MSI MS-S1 MAX with AMD Strix Halo) does not set this property on
> Thunderbolt root ports, so devices behind them are never marked
> removable.  This causes all drivers that use dev_is_removable() to miss
> eGPU-specific code paths.

Just to be clear on the topology here - this machine actually has both 
USB4 and USB4v2 routers.

There are 2 USB4 routers that are part of the APU.
Therea are 2 USB4v2 routers that are from a discrete chip.

Looking at the port I/O connectivity on their website [1], I suppose the 
"front" connectivity ones are the USB4 routers and the "rear" ones are 
USB4v2?  This issue you're hitting where devices are missing 
ExternalFacingPort - is it an issue with the rear ones, front ones, or both?

Link: https://www.minisforum.com/products/ms-s1-max [1]
> 
> Fall back to pci_is_thunderbolt_attached() when the parent is not
> already marked removable.  set_pcie_thunderbolt() runs before
> pci_set_removable() during device add, so the is_thunderbolt flag is
> already available.
> 
> This fixes the problem at the PCI core level so all drivers benefit
> from correct removable detection, not just individual drivers that add
> their own Thunderbolt checks.
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>   drivers/pci/probe.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd7..2387edc5b89 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1761,17 +1761,23 @@ static void pci_set_removable(struct pci_dev *dev)
>   	if (!parent)
>   		return;
>   	/*
> -	 * We (only) consider everything tunneled below an external_facing
> -	 * device to be removable by the user. We're mainly concerned with
> -	 * consumer platforms with user accessible thunderbolt ports that are
> -	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> -	 * the firmware as external_facing. Devices in traditional hotplug
> -	 * slots can technically be removed, but the expectation is that unless
> -	 * the port is marked with external_facing, such devices are less
> +	 * We consider everything tunneled below an external_facing device to
> +	 * be removable by the user. We're mainly concerned with consumer
> +	 * platforms with user accessible thunderbolt ports that are vulnerable
> +	 * to DMA attacks, and we expect those ports to be marked by the
> +	 * firmware as external_facing. Devices in traditional hotplug slots
> +	 * can technically be removed, but the expectation is that unless the
> +	 * port is marked with external_facing, such devices are less
>   	 * accessible to user / may not be removed by end user, and thus not
>   	 * exposed as "removable" to userspace.
> +	 *
> +	 * Some firmware does not set the ExternalFacingPort property on
> +	 * Thunderbolt root ports.  In that case, fall back to checking
> +	 * whether the device sits below a Thunderbolt controller, which
> +	 * is itself inherently user-removable.
>   	 */
> -	if (dev_is_removable(&parent->dev)) {
> +	if (dev_is_removable(&parent->dev) ||
> +	    pci_is_thunderbolt_attached(dev)) {
>   		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
>   		return;
>   	}

