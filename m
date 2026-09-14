Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66848A2C7;
	Mon, 14 Sep 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405070; cv=fail; b=bocPX0z2wv0bqV/y3RFXzvMRjK1WlhDvykpWAOr2WxSET2IkRQ4uqYuEZbomi/38rgd8KlT6x4YI+lrZpAcHLvcMk/pY2RXrt5zCexniv2H+Entagyjt6OD4yVKM8CvWe2Lu12xHfnVZLvVSpQmaCfMLcIm/Qb73jG+wI4wHM9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405070; c=relaxed/simple;
	bh=JrqSHO0xUKexVXbQ4S09M4hgBYT4EatfndZu9/crdTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=njwhQz0WW3OKtZlwGBWzSr06kKxjXZuc5k8v3A43JsahaBgKesKuebuAEZ1WIHWgs+ALthHiuXv3JT7yHTfrKuNGVORVjxXkRhhQvPNdnyZraUKlzxGvhFG0pcOJa1KMqgEZGamV6fuKXuPmIDNK1Zj8p/x7P94MPyUplElB86k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9NKWwv5; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9NKWwv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr2Jg+oXPt67rxYfbuFgxvAPXt7nCBVchLmxUSg60RXvf7uxH75NKBmcwebkw1hxJpGt44qzOW2eSMXEAMsj5yWtxBQI+qA+pcmLS55nQplxySrax2tpKWLR23uXDxe9pmHYFrxJBLm2vFuyMRehOVlhPrU5kF2CIDW/U2W0Sw8Tz1FOM+UQgAxIIAcjfcd5P4xnRrbUuihcpP18c1qdHcCjjiznGjB59aVpTwjEc6RErySZlW/u6QptHm7ZB5B5HMcEco7v9OHiJQ0PPDs5KNbhexr09g2pg2yo/24zdqRTLm/7KGPz0bfT2oTAjk5I62c3+aDcvCd/r96lLTQMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIHa/wngUCF4SRdH6ItVECTpIqfHjMUknvAvNhsUmRg=;
 b=qsAYtpu5QxjZAp1a1OwmP7jfLBGA6tnuXXpH/67wlfyW3bwnA58T/9SNNr+uTrxFfC1OHXwEr8zx+f0Tyk2LlFDK/kD5fKF1HO3eOovUCd1i+XLa7KwQGIgffhrcJcrprOmagBI6yj1MxqQRtBbP7CT6iS/Iw0ASg+C+zBzCEUC9siCfekaKCNVT7rF6VKvHFgH/qkdF1rzeLHhAHx7n0FlVAq4L75Nd6e3ZGigQZWebRfMOPvc5BqkF15V7bl0fWpgrb5UnxD2KikpjXGBONG/oGuFaz3F+CCMAVnq57tQqmilYlIYbRUXjd1N9yA7wtqaSWCqZEv4X4bEc0gCvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIHa/wngUCF4SRdH6ItVECTpIqfHjMUknvAvNhsUmRg=;
 b=b9NKWwv5yJqv2zQoRDrVX1QQd4E/sJBUPhe/Oz/LlmIETNLrpUSC3PShn074tggMshO2FW8M2BfI+0sEFcxFosHowNa6lD3VN9KgN72eDbfRR3JT42XTTYDboCs63DkP9I0elsooin683tzNwZjF++gMhrE+fvB2yPs0zR20uyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:57:43 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:57:43 +0000
Message-ID: <ed334568-d741-4374-b953-29a97a82963c@amd.com>
Date: Mon, 14 Sep 2026 11:57:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
 ports
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, david.laight.linux@gmail.com,
 John Smith <imjohnsmith4000@gmail.com>,
 Lennert Buytenhek <kernel@wantstofly.org>,
 Roland Waltersson <roland.waltersson@netinsight.net>,
 Mikael Etienne <mikael1022bzh@gmail.com>, Arthur Husband
 <artmoty@gmail.com>, Alvin Lim <alvinwylim@gmail.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <20260908190600.226485-2-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260908190600.226485-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 16de88f4-a87b-46e6-dc45-08df12814b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	go3YHhRLz0OmkdbJJpzeJtPe3dVD6qErRBm3/8pT4C/wsKwZUABlVqmoEQdhGV2ePBtaNqxc78YKLKkfEw7DGNdS/2e7x98Hwurd9BE4PlkGEaqBBwdz90zDT2uXvYCGfICS66t4YaMwV0dDWps5DBSo/jueiOJkk7iiyAO9IVmKe7JjfrozAddI4VUfdC1V20tVsqrx774TS3pOKoz2suQjV4On0UpBrLEZDz9uzYvdK3cwMwsOKkxUo87bM3mfLmdP3JcbNe2Fr6Ha6DgUnWX2GgTlpJer0XoJcOeaXq4NypO9NE7cFkVaK6maLp+8VC1rmClpvWwKLxot0U4Bb1x2AIxd4xdtuttKppuLUyU0lBwtSPkl9V3di+6fz7LRmekgOST8BCaVlzayWPS3rb8eh+anFKwWEZFYHFCfqNCXVDo6+eYR2dCyuFgRKc+epsYNCI8tjc70PwDbCuKoVDZW8djElgiNofjVHMSpfxhhLmhUJYQDVeZ+rAw/qBJdQNdFtsu0soOdJWwNRrYmDCeY/uwQyP9WsynEtOzjaEaeN93+Fy9Pl4aluMecE0cxAuy9SPyYSLDzYnZAfym97sNidUNC7zFKz/aJXxUaOAVO7WsTjLx2Fst7wncScAizY5vG/H0oQBvP+dbdbQ0HgbEY8qSuQOXy9GhNVYgbJIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZqM1JZaE1ldjRQVXc3QWFXUUpLb3hVa0ROMWpHYTQyd1pEWXRsTk5Edy9t?=
 =?utf-8?B?KzgzU01CclhJQnQ1U1pBSnBKSlV1elh2M1U5bFZJVnZaSnNTZzRTdE9Wd0Nm?=
 =?utf-8?B?ZXdWYkIyYVNjcXdnTFJybllvWWFTN2JqVjIvRGhPSVVSR3JOT3dESTU3UXFi?=
 =?utf-8?B?eWVyMno3QXg1SXk5OEEyZkFQR0VOc05yU09GSnVRd0RhQ3VuYm5rbFdhRWNE?=
 =?utf-8?B?YXRXWjlUOHpuQzZGM3JrMUhiVjRoZkV3cXBYQmVSbFB3Z1ZUbnNROWNnQVRB?=
 =?utf-8?B?TmVSV1RnenlCN3hSSzFGUUM3THJLQUkvbytwaDlTdTBlRFEzSVhIa0t2VUJr?=
 =?utf-8?B?Zjh6K0VGKys4OVlwMzR5QkN3VWxUNkR0SEhCTlVTbjg5WFl1SFZmekVJMFNK?=
 =?utf-8?B?TFJiSnk3MmJBS1pVM1V5NS9meElURlc3cEpGY0NDVU1TNW9FYW1jQWFqMHMy?=
 =?utf-8?B?VGQ5NWZsdWlKajFKOERSNC9jaHphM2x0M0l3d1lFMjJ6V0RmcGppdTZ3cFYy?=
 =?utf-8?B?OFA2VkF2THBQUXlNVWdTOUJHaFI0TUd5T3ZGYjRlMkpiaWNFV2tVSW1YWXYr?=
 =?utf-8?B?bVQ2SkRKMG1ySkVYTUJWOVVoUlhZL1lRSjBSVzRLTXRsY2F0a3lPR1ZXZFBn?=
 =?utf-8?B?T085bDVhRGZkYk5DZ0RjY1BDZmM5WHZ1a2JRSUNFQTM4cElGR040RVk2b0dH?=
 =?utf-8?B?bUpYOWtLNjMyWi9LMC9XOVRWREV2TFpCQVc1dDVyS3NwdzUrNmYvemtiY1Ar?=
 =?utf-8?B?aHBNSytwcUdiWWNMaEJjYXl2Z1hPU0tBWXpFUTFORG9peEdaYkFuL0V6YUlq?=
 =?utf-8?B?K2FMaGhBM1lMZEFhaVRiVmxlcHM1RU1NNGczb00xL09ESXg1OFZ6QjVPV1g1?=
 =?utf-8?B?bFpiRUhPRFpVYjdWbHorVUJqaXRSUGZSR3NJOWRMcm5OZ2JwS2play80WE00?=
 =?utf-8?B?YXVST2xORm5uQ1pWTFZ4T2drb1hEemZKTk5zYU9VNFFkTXNXQW5tQkhEWHdN?=
 =?utf-8?B?bWVDM1c5VjhDL0tlNm4wU2FVRUxaMWNDbmErbkRqZnlNdGdhRHVPQ1NtNnln?=
 =?utf-8?B?c05IWXF4V2kwRlBsQ0VmWUMrNkszd2djYmZBdCtNVnpDNGM0bUc3NnpQQzRT?=
 =?utf-8?B?dXFKcGtWVkllU3lwMVdkNTlqbHZxNXdkR05vMmR3UEIxUXdmdTR2UWU3OHI2?=
 =?utf-8?B?MXo3ZnFSZW5objZ0UVhVRGc5dUVtU2taUGhiN2c4SDkrQ3NrTVRIVzJsUG9u?=
 =?utf-8?B?aklMSjM5cGVUNGlYejhEZ3hBdytNa0pjUExCZlhmbEFHc216bzZwR0NCSnJT?=
 =?utf-8?B?ODJxUHhwVlNnaC9reWpyM3JQV0RLSERtb0dWc0NmN1lPbStKZVlmckhCeDQy?=
 =?utf-8?B?WElnOFJKZVRJYmhrYzN4Y1BhSmhvbUdmYmZSemlrZHJ4UmFkY0RQakFib1Mw?=
 =?utf-8?B?ZUEzRzhWRU56OEVZS3Jhb2RkMXRIUXFrRkJOdnhHYXJ4UUhJaVprU1NZYi8z?=
 =?utf-8?B?RTE3eTh0OWs3TGJIWENGdUpLNVVwN1dYTVBlWnZnaXhneVFuS3dsbk14cnps?=
 =?utf-8?B?WEZ0NzFKTlE0ckVUelhqQlRiakhjdnFqV0FmZFVPei9NWjl1eFh2YnpVZkJ3?=
 =?utf-8?B?azFsWENRRzFmWEVYditsSzFZZlE4czFkRUx1SnhjT2NodHVFUlhEcXEwNnZz?=
 =?utf-8?B?QVNMNVRQWEhuWFo1N3FYOFliSXRHU3NidnJnckpGVEw0K1hocktMbnZpRTV2?=
 =?utf-8?B?clBLeE9aL000Yy9Ha2I5am9zb3hmZHo1djZneGd0TTNFa2doUlp2bm0rdjJ2?=
 =?utf-8?B?V1lRMGV2b0VHdTlmdU1DQlYwNDd1K3dyci9hZXFkYkRFemczNk9EWGp0YnJD?=
 =?utf-8?B?R1ZvOVdjK1NQTkh4cDB5WmRid25uc2pERHdYcnk2TnVDRUFjUWVZb2h1U3Yr?=
 =?utf-8?B?YkJJYmFCQzBsSXpFS3NnSmd6Z21CWG02eUVzMldOQjlHVkhRUGtJdkcwM2Yr?=
 =?utf-8?B?SGhnRXpZQ0VkZEFGQm1ib0s3MytqUkxkNnUxUDNxZStOK2xiZTdObW5IamFN?=
 =?utf-8?B?YkQrRDdURk9rcGhHM2ZURlRYYU5YUVQ3WEh3UkZFbGdFNEgwRERTVEQ3dkVK?=
 =?utf-8?B?OGk2eUphOHBMd0ZFZjdsVHQ2VmtZT1pHeGcxd1ZCOWl6c1gxVisrOGcvdE9J?=
 =?utf-8?B?bnNieTIyRzhmanBsTE5qVjd4ZEEzbEZzRWs0YWNqN0w4M0Vjb3BSbXp5dE9z?=
 =?utf-8?B?aVpqZ2pzSkZ6L1ZrT21vSUtWcFFYVjAxMFVZelVPa0xyMVRwOGdmSk55QmtU?=
 =?utf-8?B?Z2xvM1RSVnk4MTlMRlhQOVNCZVcvUTl1ZHk4RU9CSXFpcU9mUzNIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16de88f4-a87b-46e6-dc45-08df12814b3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:57:43.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0iQtYxZpVnEzG2g6WicGpIOEgMQ3LRZ2eKqlX8hgI7e/lkeX0CLJKF8+H/q9MA3oe4O0cEtLSLHxD8kXRDRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980



On 9/8/26 14:05, Mario Limonciello wrote:
> There have been multiple reports of data corruption that can occur
> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
> BIOSes enabling enhanced atomic operations on PCIe ports.
> 
> When enhanced atomic operations are enabled on PCIe ports for some
> models, data corruption occurs when the 32-bit IOVA space is exhausted.
> The problem is reported on storage devices, but can affect any device
> that uses 64 bit DMA.
> 
> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
> 
> Cc: david.laight.linux@gmail.com
> Cc: John Smith <imjohnsmith4000@gmail.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
> Reported-by: Arthur Husband <artmoty@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
> Reported-by: Alvin Lim <alvinwylim@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

There was a contingent of eager responders on the original issue added 
to CC.

Those of you on CC - any progress with testing this?  Does it help you?

Internal AMD team did come up with a reproducer workload that we have 
confirmed it helps.

> v2:
>   * Apply to suspend/resume as well.
> ---
>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..79e4338e4b876 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>   	}
>   }
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
> +
> +/*
> + * Enhanced atomic operations can cause corruption with 64-bit IOVA
> + * on these devices.
> + */
> +#define RX_ENH_ATOMIC_EN		BIT(8)
> +
> +static const u32 nbio_7_7_pcie_smn_addrs[] = {
> +	0x111401d0,
> +	0x111411d0,
> +	0x111421d0,
> +	0x111431d0,
> +	0x111441d0,
> +	0x112401d0,
> +	0x112411d0,
> +	0x112421d0,
> +	0x112431d0,
> +	0x112441d0,
> +	0x112451d0,
> +	0x113401d0,
> +	0x114401d0,
> +};
> +
> +static const u32 nbio_7_11_pcie_smn_addrs[] = {
> +	0x112401d0,
> +	0x112411d0,
> +	0x112421d0,
> +	0x112431d0,
> +	0x112441d0,
> +	0x112451d0,
> +	0x113401d0,
> +	0x113411d0,
> +	0x113421d0,
> +	0x113431d0,
> +	0x113441d0,
> +	0x113451d0,
> +};
> +
> +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
> +					   const u32 *smn_addrs,
> +					   size_t nr_smn_addrs)
> +{
> +	bool changed = false;
> +	size_t i;
> +	u32 data;
> +	int ret;
> +
> +	for (i = 0; i < nr_smn_addrs; i++) {
> +		ret = amd_smn_read(0, smn_addrs[i], &data);
> +		if (ret)
> +			continue;
> +		if (!(data & RX_ENH_ATOMIC_EN))
> +			continue;
> +		data = data & ~RX_ENH_ATOMIC_EN;
> +		ret = amd_smn_write(0, smn_addrs[i], data);
> +		if (ret)
> +			continue;
> +		if (changed)
> +			continue;
> +		ret = amd_smn_read(0, smn_addrs[i], &data);
> +		if (ret)
> +			continue;
> +		if (data & RX_ENH_ATOMIC_EN)
> +			continue;
> +		changed = true;
> +	}
> +
> +	if (changed)
> +		pci_info(host_bridge, "enhanced atomics disabled\n");
> +}
> +
> +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
> +{
> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
> +				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
> +}
> +
> +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
> +{
> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
> +				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
> +}
> +
> +/* Phoenix, Hawk Point (NBIO 7.7) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
> +
> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
> +
>   #endif
>   
>   /*

