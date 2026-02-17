Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB636C5A3;
	Tue, 17 Feb 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339009; cv=fail; b=YG4EyiozsaRCjZNBy8B5ZtLl6EEBZ0wmrn+27Dxt527ZRjCC488oxt4A5zg4gwTTzkDx9/SiItZsmjvnYADv0kNmii1BCAC/xoBSg3+bbl3KNs8N87N/N9XtxPNnDENHo1TcZEtgoUbP3iD0t3okyN3io7s46CKBdEBaYqm5r0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339009; c=relaxed/simple;
	bh=9oFOQg6CbGilhdoJ6XXsD71lT4HClXP2uFjX9R1jryc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRJc5Xo9/HXS0k0siVnd334pVy0zxUjfYWlwDTvPblsAFpNOLBXfA0GCMwj0W9OH1QQhZ4daSRVWbV2ilWd3fHgDy7qlR1/LVL3N2jLetwt+vhgsuaPOlUnjvwEgVC6GB+X1qXhDhHACTL90H0j5TVTrplDm00oXemFYZIVSZgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dcfREWvS; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dcfREWvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq725OW++P7tFjJViIxZ37YZcXE/5mYuxSALoWjkSCy32bEaC+y/aszNcZdkCgUxgvnJcysGL0Gx/3pHGc3W1Sp9GjGkKyO9rV9EaZ8Z2tT7TxfzS8ZU5tXnarZvrrftgJurGUfSWwHYfIWMpieI0+vO68Yo9W2/jUjmbcRAIYYkXU0992+ywkJ6FFB3LEJLa1Q7hlhY5+VwNPoBFaD6TVIctpHbuLl8IeuffVcBY6QVPxoJLfbztdBS47cUf3k64jFJJb/HSzdu974oMrR9BfyGbCxvQMrtcwwSZYMAShyzcSITH9gElY2X5WFlvt5f7DWzXeBpiqGxI5l5M9nWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAjoilTAMQEmDQ6vQKbHj5pIMf9SlvznTo/pO8cMtz0=;
 b=BvnLtxYWh90+I25ZKPEOcqZCWzcHxOVbZy6Ynle1b0UCJF0NAaPS27M/aIKlgZG2WTUnp+WRGrqHMp/Uh1rIAkKOXFc/tM07pJTZSL6VRtVpnvI60NrHer/YnCl7VUDIgYHGa5emJeferZ1Ljeiq9GVRCtVNav3Hd0OZYPJpsRrNq8wyxpPwgEA4VFuEv1tHfMapj6/tVQ+3xYWnA6/j6Nu9WdQ0rlpcukvPTFWF8sxwvzccinWypBS5R/xoBqttqwbiNZVCiajixYMCnC0pGdQNVr/7qhfdZyci6QBKOYbTRhm351XC/Kegh0pJiCSgpFTrm9iV2ozSEyk02ZC/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAjoilTAMQEmDQ6vQKbHj5pIMf9SlvznTo/pO8cMtz0=;
 b=dcfREWvSvoWFCI4pHpJMFCGcCIKWHaLhHwiY8MYJqXV87SLYDa5Pvu+5jXNYB2H7cyeaNV93O0pRV15OBKSCa2ZR0KnFZsamPR3Eji2YnrOXWa84dfmcoVpBsZPAbp7193SFQVBs6XJlo95kjGNEVOaNo3xXmobq4/tHh1Zv9Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 14:36:44 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::d87b:2c6a:4793:b4f5]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::d87b:2c6a:4793:b4f5%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:36:44 +0000
Message-ID: <a7d03703-04fa-4c26-987a-a34d2e96a4a7@amd.com>
Date: Tue, 17 Feb 2026 08:36:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Bjorn Helgaas <helgaas@kernel.org>,
 Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>, kengyu@lexical.tw,
 Brian Norris <briannorris@chromium.org>
References: <20260213192607.GA3167656@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260213192607.GA3167656@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: bb17284e-adf2-4474-0315-08de6e31f8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTFNS25qSnAwTlhsUk9iSEZuZDRLUEJnRjVnYXBsVFVYOUV1d2hUY0tBZmxw?=
 =?utf-8?B?QTl0TWNzMm9YOXRrc1hlVnRYOHFQZ3lrRFp5U1FSbjZyZVdOeE1wUkkya2VK?=
 =?utf-8?B?VWxOczIvZVlpdjV2QVZqZ2xGWVE5VzE1cTB0YWJkaVhUWldBd2xDVGNRK3Az?=
 =?utf-8?B?VUhuSkIrWDlXK3FxVGFRZTAwVWpuSnZzUkJaZi9TQXdIM2VrWmYwSkpvNDY5?=
 =?utf-8?B?ZFpSeHI0VlZVb0duTXEveDF4eE9NM0NId3c1MzZld2dBZ3MxNzFZMDdoS1Fj?=
 =?utf-8?B?RTJDZUV2N0NkMVRDUXBlRlZMTXliYXo3UE5SSjI0S0xnQjVIMnB4UDNGNVB6?=
 =?utf-8?B?YzBJaHVXTm9OOEdhck4reTBEa1hWbjBhNWxtSDRnQjJqRUJsMy83L2xaV3NR?=
 =?utf-8?B?YzVMeVpocXVRZi85dWh4cnhkbU1ockdhS1JTOWRnL1B4UHhYa2ZYNThsWnZp?=
 =?utf-8?B?T1FFOG1JaHdkM0V5a1lRS2w2ZURpMnRyanNIdDlyN0RzZHNXSjZaaDY1VHp0?=
 =?utf-8?B?S1hkUjVzMEcrcXhRUmFkVjRoOFJaSGpCMjRpTFVFRmw2VENUNUFRTFc4TUw2?=
 =?utf-8?B?aEVPdXJvQk9TeCtlSzdjWU9XRFB3U1hFTGh6UEY4d3h4MVpwblh2c2NTWmQy?=
 =?utf-8?B?aWR1cW0wM0JOcnJ0QmRXVDF5OUJKbHZVZnpNRW9HM2xlMkVCeDdNdG1EcVR0?=
 =?utf-8?B?ZU1ZWUNsNVRQVTErMjhrRHpiRTlrMDZlblc5YVh6ZkZPdC9obnpEYi9sOG1J?=
 =?utf-8?B?eE1xYjQvYnNCbkpaVFVCY0pHeCtGVGo4MVlPTkdZQkQwbERTQTN3WHFkVENi?=
 =?utf-8?B?bXdHTkIrdzNWVjZpMDU5QlpqV2FRVjBMOGNacnQxc2xNUUwvRTVQNTdXY1ND?=
 =?utf-8?B?VjF5U01TWjlCc1FpMlIvR29MdTlMdzg3eEcvU1RXNFZJa1VSZ1JyRWh5VnlY?=
 =?utf-8?B?Sk9zN2xlMDNvdjZQUEsrSVl5K21rM09CdkpDckNDdEV6czhIdkwxMjdHc2Jq?=
 =?utf-8?B?OEhCWlFBLzhzQWcxMEx6MHV3NXQ2ZUpjNWtnTGdMeTFRdW9OU1llc1lLVFJm?=
 =?utf-8?B?cElXMEtkdVB6WDh2bFV3WjQ1bm83RUkxaDdOUkNWalJZUjVJTHg4cGRFcmdC?=
 =?utf-8?B?ZG1kekgvUXVaZUpjaCt4U3pFM2JqWHdrMkhsVEZXM1pqckRySnd6U3hKNVBQ?=
 =?utf-8?B?ODRZdzJxK0NKYUJBbWl0TVhEejcxQm8rYWNMM3BjNlUxeEZQYVVxT3hiaGNH?=
 =?utf-8?B?ZHcrOWFQODRZNWRwVjY4bEY0eFQxZmx4dzRESXFzbVBoKzZvbXBEZGMvZmFh?=
 =?utf-8?B?NDIxZjY1YlpnaTZnSVFwbFM4WHlHODVmRys5N1JVbmZnVm83ZDc2NHgrWGVB?=
 =?utf-8?B?RzdzZ3FhQmg3aUJlWm40d2RiNnlObXJNa3p1YVB1L2hKZi9WY215K216VWow?=
 =?utf-8?B?VGFqeVlGQzNmc0ZKS3ZneklyWVZJTG1LNnJjSTV6ZWFOYnFWVlNyRC9jK0xI?=
 =?utf-8?B?Z2F6Nm5zQ2lHeHlEUm9hY0tpdEVBK1ZuQlFPZjVWZDlzVTZwczJuVWM1ODFy?=
 =?utf-8?B?a3B0bGY0L09tSHFzb2tYYmE4YUZ2QXJQeEtpb0hFM0J2M0RLSklyWm1HMHph?=
 =?utf-8?B?L1BqSG56T1pKVEpKMmlFb2U1MTV4L3pFUmE0ckxEeElsTkVObzlyL2N0NEht?=
 =?utf-8?B?c2JSaFRIakwzZXhLZnZYWUd1MjRWbDBtNTE5TUVEY2xmdk9GWXVMc0poNXNO?=
 =?utf-8?B?Y2d4OFRLb2cwSVFneXh2Wlc2NlhORm9OMzJUeVd0Yld3ejNtcGdsbGlJS2JG?=
 =?utf-8?B?aGRGQndON3BiY1U3Z2lSWkE2cnNXMWxxMEhtUSsyRmpGOGFka1AzOHhLbnU5?=
 =?utf-8?B?b0J0T0ZjQmZqeld6UE44RE9QblNsNkc2Y3JQOU1zWDhrU3FYM3pBUFRxY2tt?=
 =?utf-8?B?MDhJZnFMYWl5TlNzM0lRSmRjZ3VzMHRONnUrRWJMNXE5OC8yQzdhdHdwazI5?=
 =?utf-8?B?OVBjemVSUEVjOEVtanl3TEdxUzVRUzljOHoveFZWTjc0Q0pBcEYvUmd0a3ht?=
 =?utf-8?B?RUtjckxUWUFlQ3RLMFYxZkRvNTBXc0VHQzlqS1RPVTBDbkxpcW9IYnRBMEFT?=
 =?utf-8?Q?/ygA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHpqL3Y1aHE2WkZWSkR3VjNOcndCRy9WS0M3N0lOblRJVUVRejNzTm0xQ0tE?=
 =?utf-8?B?UWpnNEl2cHJsQ285SGxReGNBOFJGbmJpdWpDZnJWSGRPR3BldDhuQUZtWEZB?=
 =?utf-8?B?Q2NQRlpDS1VvTUsrY2tSaWJiYWxZK2laWUV6QW5KcTE4a1BZV3d2VXZ4TVFk?=
 =?utf-8?B?c001NngraXNIdU52ZDRPR0c0cWU1R3Y5eUFlVmtkZy9NK0QvK0JPRVYyRFRN?=
 =?utf-8?B?VHBKY3c4N3BjMHpya0l2RERyckQ0RC94eXcrbTdJZkU2bDJvbjBFS0svb0hP?=
 =?utf-8?B?eWdTK2xacnNyMTFNVVl3a2NKQnkrN21YR3dENkoxVkZlT01kOTBmSkZjSm1l?=
 =?utf-8?B?aDNhcUs3R09qMnQ5TU9rR1ZoZHczMFRiM1dNSWhIdkVNUTArTTF6V0ZlTkZI?=
 =?utf-8?B?NFI0WXNuNnhCV2VUM2p5NFpmMmJFOXdQUlVMRWVIWGJFbWljeUduVlhpOEhz?=
 =?utf-8?B?V0VsNjdlNjFPNk5IMC9XSGVqS1NQZ0g0dTh1SE1PWWV2bEx6eUowMkJUMFFQ?=
 =?utf-8?B?eXEzam1CTlBIeGpCbkNHcGQ3WkdrMzdBdGVYUHlnRUI0c2o3YjVaRzBBRk5X?=
 =?utf-8?B?djJXVEVSSmZlWU5sc09JMjE5YzUvTEQ2T3NnTlcrbWVrQy9CMlBzNUZIdm1X?=
 =?utf-8?B?YlR5bms4WjNjanRnTWc1UzhlT2R0MWhQKzVYY1RXdWdnRUhhbEZGVXpaWXht?=
 =?utf-8?B?YmM2UU9heTQza2VlTmRnZU9kSzQwU1FseS9OOTZNeUM5MFB0TkhKTjRtQkpD?=
 =?utf-8?B?YWVKTUQyUGtldWpnMVpET2dJbEo3RjdxMklCZXBoU1d2MWVUczVtbHFlZ1Zh?=
 =?utf-8?B?ZEVFOWtFSm5yMzNPa29MeW9iMzYyTytuZm5TQ2hWeEhpV080akI5Z3dMUnZC?=
 =?utf-8?B?MmY1eWdrR2U4ci8yTEhzTGkvSHl0dWo0TEFkaGhncVNoQnFWQXMyMThMUGZa?=
 =?utf-8?B?UytySjJna0pJanEzQnNNOFFkUTk0aVJWUVJ2NkdiV2RpYldQYVdjMERyeFBO?=
 =?utf-8?B?c3ZrdGZSSW0xdTArV29Ba3BuM2s0SE1BYmlPeEozMFBXb2lWODFENGdTRGtM?=
 =?utf-8?B?ZXg3a3NaV2hId0lMcmpQcGR5UnRTVjBWTzRydTRzZXNhNzUwd2l0SUh1dlA2?=
 =?utf-8?B?Z25MNEFrTFk0K0VaSGk2T1hWdzNOb0hNS1hlQTc5eWpHbmk5WmxlaWI0N0s2?=
 =?utf-8?B?VnVPbXZTOUZ0dEI2U2ZORGlpREZidzdEUE5WSDQ4ZTdiYml1QlNPUiswWWIr?=
 =?utf-8?B?N0V0WmRLTWxIazBYcFdtcEdwSXpUQ1R4OVlHTnd4RHlsWXRCd0tVNjR3UU84?=
 =?utf-8?B?QjF6c1JTSkltSldyY2wzVmdTc00rYklPbmZKV2s0VE5HODdmbG15VHRRTC9m?=
 =?utf-8?B?aitNQUNvVXlOWXRTYWFTeXlRdVdmeGoreG81cHJ4VUlFSU0xS2FxMnhLZ3lr?=
 =?utf-8?B?cmhvZDVGQ2Vaa0xmaFBFNno2cGtBUDVjSkU2Njhzbkwxb2dMNGsxenB1QzRW?=
 =?utf-8?B?cDBmcUdoWWNRT0VDTmp6UUpjR0tISmo1anR2WGUwejV5V2s1Z0ZTU3lqRG5C?=
 =?utf-8?B?RVVNZzJBTW5NWEl3azJIRXphNkVaa1RMNTZMV3R1Z1ZZQ0h1N3QxY29OQ0V2?=
 =?utf-8?B?Smg5TkZ0cFZyMG1QMnFnNGpoSmxCNVVEN29tcTZDQWxPK0orWVlkRyswa1Ex?=
 =?utf-8?B?aVJuT3ZDUVc3TFFDVEtiVmcrdytWU3dJMG0ySm9UdXY5SXBqZXptSUJ2REg0?=
 =?utf-8?B?aURyUFdQdy9QUjdScDFxL0xvZWJnQndieWtQd28weE9LKy9wTHYzdWQ3ZFNE?=
 =?utf-8?B?VkJXTDhxdmxGMEV5eCtOZWV6OHZ3ZHZGUzFSU2lRZ1NVUzh2ZlNOUlo5a2ps?=
 =?utf-8?B?M1BjNDJLS1JycnJkZDdBbS8vQXByUHNOdDlBV2JiN3h0TEZ6ejFBMnB2dkhX?=
 =?utf-8?B?M0hvYlBwRFpUWmRlSXpXQWpSakpzbGFlb2g0YUJqK2RDVVdGRG5VckFrQzc4?=
 =?utf-8?B?MnF6elE2andjbTJFM1lqNzRSZWZJRnFoTDJqREU5bFFQblRzM3pFalVqYnp0?=
 =?utf-8?B?ZnFoRTMyaE12Qk44MXdValRLZEVNU1dCWFR6bnVFaC80S0doY2U2S1BCL0RC?=
 =?utf-8?B?MUNscmVETGhVS05STGtlNmhLUm5kSmxQNkNUSjRFc3ovUDhJdkx5ODZiTEFV?=
 =?utf-8?B?N3V5OFJLK0FyRzRWN3RvY2krZ293RWx5c0RCdS9hRlJzOGxUS1VpSFlDcklI?=
 =?utf-8?B?ZnFveWxoZTJ1UW9QZ29LZUNsNndmakhtRHA0OXlyU2tRMEtjRFJ6a21XZU1W?=
 =?utf-8?Q?tLIQfcPyaCaEaeQhFW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb17284e-adf2-4474-0315-08de6e31f8e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:36:44.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ykoZV1WaLxpg6HPfm/jpOUnJe+9kH+mBuhirpQpRZ+xHRK1Umq0RXtdtGOS7GcHyuRg9/UOJE45+oW8wkUnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

On 2/13/26 1:26 PM, Bjorn Helgaas wrote:
> [+cc Brian, author of 51c0996dadae ("PCI/PM: Prevent runtime suspend
> until devices are fully initialized") (though it's not clear to me
> whether this makes any difference)]
> 
> On Fri, Feb 13, 2026 at 06:54:13PM +1300, Matthew Ruffell wrote:
>> Hi Mario,
>>
>> I have been doing some experiments with c5.metal on AWS with an
>> Ubuntu resolute userspace and a 7.0 merge window kernel.
>>
>> Amazon AMI:
>> ami-04080dce0ccaa893d
>>
>> Linux HEAD 582a1ef360a05bff4350bbf6e383f61d26b804f0 (Linus's tree).
>>
>> $ sudo lspci
>> https://paste.ubuntu.com/p/mtgbn2HJtW/
>>
>> $ sudo lspci -vvv -t
>> https://paste.ubuntu.com/p/s6NhBz5FZy/
>>
>> I noticed that nvme_pci_enable() calls pci_set_master() with the pci
>> device, and I wondered, is this called with the NVMe device, so I
>> went and had a look.
>>
>> I added your patch:
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 595ec12d85df..bd116dccd897 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1300,6 +1300,7 @@ int pci_power_up(struct pci_dev *dev)
>>       bool need_restore;
>>       pci_power_t state;
>>       u16 pmcsr;
>> +    u16 old_cmd;
>>
>>       platform_pci_set_power_state(dev, PCI_D0);
>>
>> @@ -1347,6 +1348,10 @@ int pci_power_up(struct pci_dev *dev)
>>           udelay(PCI_PM_D2_DELAY);
>>
>>   end:
>> +        pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>> +        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
>> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
>> +
>>       dev->current_state = PCI_D0;
>>       if (need_restore)
>>           return 1;
>>
>> as well as some additional logging in nvme_pci_enable:
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 80df992d1ae8..2d1898016d40 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2992,6 +2992,7 @@ static bool nvme_pci_update_nr_queues(struct
>> nvme_dev *dev)
>>
>>   static int nvme_pci_enable(struct nvme_dev *dev)
>>   {
>> +    dev_info(dev->ctrl.device, "mruffell: nvme_pci_enable() start/n");
>>       int result = -ENOMEM;
>>       struct pci_dev *pdev = to_pci_dev(dev->dev);
>>       unsigned int flags = PCI_IRQ_ALL_TYPES;
>> @@ -2999,6 +3000,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>       if (pci_enable_device_mem(pdev))
>>           return result;
>>
>> +    pci_info(pdev, "mruffell: nvme_pci_enable() set master\n");
>>       pci_set_master(pdev);
>>
>>       if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>> @@ -3064,11 +3066,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>       result = nvme_pci_configure_admin_queue(dev);
>>       if (result)
>>           goto free_irq;
>> +    pci_info(pdev, "mruffell: nvme_pci_enable() end\n");
>>       return result;
>>
>>    free_irq:
>>       pci_free_irq_vectors(pdev);
>>    disable:
>> +    pci_info(pdev, "mruffell: nvme_pci_enable() disable\n");
>>       pci_disable_device(pdev);
>>       return result;
>>   }
>>
>> So, booting the system on a clean reboot, we see nvme_pci_enable
>> does infact get called with the nvme device, and all PCI devices in
>> D0 with the bus master bit enabled.
>>
>> https://paste.ubuntu.com/p/zp3khwfMg2/
>>
>> Then I did a kexec.
>>
>> https://paste.ubuntu.com/p/SWB5jz6x4g/
>>
>> nvme_pci_enable() still gets called, but it doesn't seem to change
>> anything.  The system still fails to issue I/O to the NVMe and all
>> pci devices say the bus mastering bit is disabled in D0.
>>
>> I then reverted
>>
>> commit 51c0996dadaea20d73eb0495aeda9cb0422243e8
>> Author: Brian Norris <briannorris@chromium.org>
>> Date:   Thu Jan 22 09:48:15 2026 -0800
>> Subject: PCI/PM: Prevent runtime suspend until devices are fully initialized
>>
>> commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
>> Author: Mario Limonciello <mario.limonciello@amd.com>
>> Date:   Wed Jun 11 18:31:16 2025 -0500
>> Subject: PCI/PM: Set up runtime PM even for devices without PCI PM
>>
>> commit 4d4c10f763d7808fbade28d83d237411603bca05
>> Author: Mario Limonciello <mario.limonciello@amd.com>
>> Date:   Wed Apr 23 23:31:32 2025 -0500
>> Subject: PCI: Explicitly put devices into D0 when initializing
>>
>> and repeated the tests.
>>
>> This time, on a clean reboot I get:
>>
>> https://paste.ubuntu.com/p/qm6ZBWNqG5/
>>
>> I get no messages about bus mastering at all. I did a kexec reboot
>> and the system comes up correctly, again with no messages about bus
>> mastering. So we must return early before the printout.
>>
>> I then added some more logging, to see if we can see what state
>> these devices are in:
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bd116dccd897..deed439af6e4 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1302,10 +1302,16 @@ int pci_power_up(struct pci_dev *dev)
>>       u16 pmcsr;
>>       u16 old_cmd;
>>
>> +    state = platform_pci_get_power_state(dev);
>> +    pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>> +        pci_info(dev, "Initial: Bus mastering bit is %sabled in %d\n",
>> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis", state);
> 
> If you include "%s", paired with "__func__", in the printf string,
> we'll get the locations directly.
> 
>>       platform_pci_set_power_state(dev, PCI_D0);
>>
>>       if (!dev->pm_cap) {
>>           state = platform_pci_get_power_state(dev);
>> +        pci_info(dev, "mruffell: pci power state is %d\n", state);
>>           if (state == PCI_UNKNOWN)
>>               dev->current_state = PCI_D0;
>>           else
>> @@ -1349,7 +1355,7 @@ int pci_power_up(struct pci_dev *dev)
>>
>>   end:
>>           pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>> -        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
>> +        pci_info(dev, "mruffell: final: Bus mastering bit is %sabled in D0\n",
>>                   (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
>>
>>       dev->current_state = PCI_D0;
>>
>> The result for a clean reboot is:
>>
>> https://paste.ubuntu.com/p/qh84c8T9ND/
>>
>> We seem to skip pci_power_up() entirely for most devices, including
>> the NVMe drive. Those that enter pci_power_up() are in state 5, or
>> PCI_UNKNOWN.
>>
>> I did a kexec, and we get:
>>
>> https://paste.ubuntu.com/p/D2GhjKxDG3/
>>
>> Pretty much identical results, and the system comes up correctly.
>> Each time the bus mastering printout at the very end of
>> pci_power_up() is never called.
>>
>> The only conclusions I can seem to draw from this is when "PCI:
>> Explicitly put devices into D0 when initializing" is present, all
>> devices get their bus mastering bit, and are placed into D0, and on
>> kexec, all devices lose their bus mastering bit and never get it
>> back again.
>>
>> If we revert "PCI: Explicitly put devices into D0 when
>> initializing", devices that work bypass pci_power_up(), get their
>> bus mastering bits set correctly, and kexec works.
> 
> Thanks for all your instrumentation and debugging!
> 
> I don't think it's safe for the PCI core to indiscriminately enable
> bus mastering during boot.  That allows devices to DMA to/from system
> memory even if there's no driver to operate the device.  Bus mastering
> should only be enabled by a driver.
> 

It seems to me the problem is a mismatch with the device and what the 
kernel did in the context of kexec.

I wonder if instead we should do the inverse - explicitly turn off bus 
mastering before we put it into D0 at startup.  Because as it stands 
today there appears to be some devices that the BIOS will have bus 
mastering enabled, kexec might have turned on bus mastering and we are 
just "getting lucky" there hasn't been a problem from that.

This would then also align the kernel behavior to the design pattern of 
bus mastering should always be off until a driver asks for it.

> Per D2GhjKxDG3, nvme_pci_enable() is being called after the kexec, as
> it should be.  We need to figure out why it isn't enabling bus
> mastering.
> 
> It looks like something is wrong before we even get to
> nvme_pci_enable() because it took 80+ seconds to get there after
> kexec (D2GhjKxDG3), vs 2 seconds for the clean reboot (qh84c8T9ND).
> 
> Can you please put the entire dmesg log in a pastebin, possibly also
> with a note about the circumstances and a pointer to another pastebin
> with the "git diff" from upstream to the kernel?  It's hard for me to
> pull all the pieces together from the excerpts and keep track of which
> logs correspond to reboots vs kexecs, etc.
> 
> Bjorn

