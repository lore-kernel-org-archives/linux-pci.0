Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013076.outbound.protection.outlook.com [52.103.43.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71226AF4;
	Thu,  7 May 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161530; cv=fail; b=cb1bxEEQQmB7yTckLmGEYrek/ObiN+8OI+2NdlrzfdHD34mqIeALYs+NFDagwliWLARh3atDw8ZYq7xWjd2WO5t9lBRzerQOrPFGJ8lZrAurRE75T8MyBTqeCmONLMqt9VUi4MomzKWBlMP6Wb8TRC62uk2ta7Ifbe3U8rTNJ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161530; c=relaxed/simple;
	bh=K9/UaeJgnzN2MLSvOKQT2+iE+bczlAlrgao3tv/H5+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tchq3cRdBeu3EAzk2xO92O79vCbv4ZW2TMJKVpWYNh54n18wmaA5+NaGCDDREC31uDWfElEzCx3rJj/1Wkr9wcwnaj5N+JYDWc0FoApp4UnW7VcbkqYIhl+TR+vdhH2IT/Xsn/tOMZq3k93rkn3gLm3vpfpAAj6Eh/uirw04Z6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JRSzNo4h; arc=fail smtp.client-ip=52.103.43.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JRSzNo4h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg3t6WmAJNbX6A2gk1mAdFobhr7VQsSDANBmir0HV5Cua04dGhMOV03lLJwofz/K4MltW0YB4MTS3mJvYLUXLHCM2Xypb+72euOhj4Qx0etvfRJHSPVD5lhyNhB1Yrr2wCVXxCnTpkMCkvWCj3DP9DM8acQjDSOI0MuRHo4t8TEV++jN2V1cLq/AWem9Q4WqA1655goU3S+4mx3CSbbpN+eDx6cEeoF82t/cZMbT04YkZ5paL37ublCAe+5olGCg4gajcnvjIQFbAY0EP6cXjIY+JwtGSn/tJ6DAD5ltCuc1pzK5s4/30QJAKF7+cXG15VD2Rb2sXbS0NBLp4icOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBlOKckAqw5arsLZ1R+2SRy5ZmkmSNydJ9aTAc8puFo=;
 b=SJoN0hA7fw4cveFdFDPhJ8D4fb4mHONMNmp/vryCci9OqFRevQ0brayu0b3elKvIRtFUPqFzPBl31W7DzfB0LN/haWJ1bQphbOS8Sbp70DWA7SrigxCS20lnfR260B+qas420j6tfypH/sj2Kw6JovxA6YOiVwHS//TzbSbHjCUX1WYIxLbnP+J3fU8irFT65GOYzhXVJH3RANXHAC0N/AK4LnWBsFst4znLALW3cn7l/Tga8KFDB2diu4FFiv9VGlbADjOeCsNoPQ39Akq5GGdkRhnHilYz8MWfxDDWBwhPAJbLzeKOR+JPNAgFLmAxURExeOvOzw7EcZUTa7umnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBlOKckAqw5arsLZ1R+2SRy5ZmkmSNydJ9aTAc8puFo=;
 b=JRSzNo4hrXIFPIIEreP8c60HaFAHw8eRIIKjXES1L0Dw5uh5CBi4R/rLKPoukCceIpT/kJtUudWKrz95wv8U58WrSCd8TWfphJelbMdkr1QHvsFNNMMyefjYe6NBgh8w+TIc+rmS9Jz7eKZL1dhOeuTidyJjGPV0gk/6JWqjD7dYeMdA0xEj/1u3Aw4SJzFlHgQsAgIme0IKraJ9gtma4LAIepjipVqwYxpUx2cOb1GzgLm8d8yfEyf3oK6MF3Ah06KlNOUQexK33z33JYAeB27JFHWvDDEx1dUNvbtjdrupTEABb52cPEorgpnyW4d3N/iW2OA4seKluZa26TKQew==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by SEYPR01MB5598.apcprd01.prod.exchangelabs.com
 (2603:1096:101:139::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:45:25 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:45:25 +0000
Message-ID:
 <SEZPR01MB439930F69EC1025A3F188357DC3C2@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Date: Thu, 7 May 2026 21:45:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] Documentation/kernel-parameters: Add multi-device
 config_acs example
To: Randy Dunlap <rdunlap@infradead.org>, bhelgaas@google.com,
 jgg@nvidia.com, akpm@linux-foundation.org, bp@alien8.de, alex@shazbot.org,
 kevin.tian@intel.com, manivannan.sadhasivam@oss.qualcomm.com,
 jic23@kernel.org, error27@gmail.com, kwilczynski@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439372F20062A8C25599FE43DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <649c67bb-be03-4843-ac2f-19f4eeabef54@infradead.org>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <649c67bb-be03-4843-ac2f-19f4eeabef54@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0368.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::19) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <bda20d85-bb7e-4e34-b5a9-d984d46d8e76@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|SEYPR01MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4511d-4f75-4885-5fc5-08deac3ee2fb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|55001999006|45011099003|51005399006|2604032031799003|8060799015|41001999006|19110799012|37011999003|23021999003|15080799012|7042599007|6090799003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFVmZ2h0NHhhT1ZuZW1UNXhRdGVvV3VVZ0xFU0VkZ1FEUmVtRmN4anlpRkY5?=
 =?utf-8?B?RytyMVhXdENMaFQ5S1l4ODV2L0wwbmZRMTlUZ2F2WGp2K1RqclpvNVNyYVVS?=
 =?utf-8?B?T2YzRVdTbUFpT0RIU2ZuSGx6V1EwL0F0Ukp2ekhUaCsydkUyMU1uK1pCUDlS?=
 =?utf-8?B?di9qU1RibVRJM2pHSFdTekxEbGlmZWhwWVU0ejdmWnlmQ0ZQcjJyaVVrRDNv?=
 =?utf-8?B?UG5oaDFNN2ZzKzJrVERLMTNrQmZubWRUdnNwL1VtNDY1MHRFYStwakdoWDVa?=
 =?utf-8?B?T2JONjBOUUswUWFMYm05K0tqelcvTkVKQnhoWXFJTkxOYXJqV21yeDVYZFFk?=
 =?utf-8?B?OFY3UjFMajZLdlVQb1BWQlhYenNSSngvS1RmK3dwaVlpTjZPOHQ2cEpDL0J0?=
 =?utf-8?B?Q2w1NklBQW5wRkVKeWFxSXZmWEQycmZNNWZDV3NBendaRjZxYUJWV1B4cjBW?=
 =?utf-8?B?WEgzcnEvdCs1SndOSmp3UHNwN3AxYnkvVS9VdGZRTWFiNTVkZ2xaT1YycTNF?=
 =?utf-8?B?Z05hSVhrZVo3SEh1eTQ2cmY3clpIZlYzbFF0dm5iSXRLNFlWUU52RzhvbVFJ?=
 =?utf-8?B?MGV1RnNjKzRpTFE0a09WM2ZTR0ZOay91UXJLRzBGeDRhY3dNLzdOSWdJc3ZT?=
 =?utf-8?B?M00ybHp3WWIwQmxRbnFMaEpEY1FSdGs5ZGhnb1Q5ZFJqOE82TzUzdERaZG9B?=
 =?utf-8?B?ZEp6NjFrbC9QYzJVM1hHY09lODVrS1RZMlRGL1l0bHBMSkR0QVFGcUVxcHZs?=
 =?utf-8?B?MWh2NkhENUVKejZ0U1QxQ2J2L3lUOUo2RkRCVVViSkhwWkJkcTJWOWk1NWpB?=
 =?utf-8?B?N2lPWUZZUFFKQTZIdEdnSEFwYW9qV3NzVDNMU3lxc0tiamhSVEVmazd2ZGti?=
 =?utf-8?B?MDhpbXQ0eEhFd3BiUUVHQ0NBNDNJcXdMTXB6VFJWVzY1WFBPM09xbDFNTFpK?=
 =?utf-8?B?c3FEQUtSb1RDeDJWeGVMd1VWaWpFelQ0NmEyZFFweW9vdzUzNTNReHRZUGhp?=
 =?utf-8?B?bW45WCtVK2l2T3I3a3Iya0xxQVNOMmpPa2twVmxqZGZMb05wMUR1N01QZXVI?=
 =?utf-8?B?ZjFxV0VPdnVCL1BmcjEzOW4wZVBiZHZxNjNVSXJCdDdXY2VrYjQzanBWa3kw?=
 =?utf-8?B?ZlF4YkVtRGZidlQ4b3VsdzdPR2pOeTY0bGpleHY5bHpLb0d2VklDUnpIQUtu?=
 =?utf-8?B?cjZOWmFRaSsrVW5VYjFScnNic25MOVNGaDFSdzlJTmNtVjB2ZXR2MDJndnVa?=
 =?utf-8?B?TVRJQXNTUXFmbENYd0theE85eURlV0grc09ZVVBXaGRYa05DRGp4TWZmdDlC?=
 =?utf-8?B?M3FuOXp3WmVmZ01ORmpUUWdSZ0k0UlE3YTBYYy9JQ1NRNlFjY292VlhaVkx0?=
 =?utf-8?B?dzJsc1RQajgvbHJmcFhIcFRYU1dVdFVNVWdqOTVvWFFjQmwzazhiVGM3UWs3?=
 =?utf-8?B?ZFlDdVVaVjQ3dnlwd0RJVHdaODZ1cG4rNGJCeTBaMUQ2TGdWM1A1Y0ErTldU?=
 =?utf-8?B?bytsSkY4Nkp3dmxCRkRpSFh1RTlybkhLa2dubnRjUjRSMklGU3RUVUZpREp1?=
 =?utf-8?B?aUhqdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lKS29NNXB2ZDRZaW9wNjZvUk1KNnJxTU5DSHhQcmVma1MzY3RVREYyUnhB?=
 =?utf-8?B?TWMrN01OQ0RVZU1ZVVRUYmVqWmxDcWZBZ1oweE9BZEQ1N1U0Q3J1Ry84L0hB?=
 =?utf-8?B?ZGZ4V3dZSHNEeThOWU13dVluMko0V3NoVlBNMFpjNysxZE1NVVNTTmJnQ0hp?=
 =?utf-8?B?OG9zd2ZWVVpzdDJxMWN0NHJadDNZNS9wNFNEOTEvT1hEZ3RRbmpDOStqenFT?=
 =?utf-8?B?UXVpRnpFQ21UK2ZwZkJaYzAzZTYwSjJteW80TG5vbkN3ak90NzhvcWFQVUxK?=
 =?utf-8?B?OVdBdTRadStPN2pCMGNnSnNyQ3A3WEgzZmt0QTRQSlZTdzhza21iZXY5N01v?=
 =?utf-8?B?b3ZVcHZQV2hiSXd1NWY1Q2JLckhzREZVays3ekpmckhiWnp1UmROTEQ0YkJr?=
 =?utf-8?B?MWJKQktxdlpndFYyOHpiUUxxd1VJR2t6Z09reVFLUDQxdy9KMnRSSGMxYWRu?=
 =?utf-8?B?NHBPaHNlcmZIdnkrZ2NoczRuZXFoSzQ0dktvQ1VJcjNxSFliMEF0Q0dWREsx?=
 =?utf-8?B?VGRoeVh0WlNDYTNMRVIwakhhMFc5aTFqUEZnQ1E3RnNwZEhNaExXRHVTRUhr?=
 =?utf-8?B?Qkd4U252QitVaVhpbCthUkppZlprQXNmL2VLOW9nUkFOYW1VZ1B4Y2xLK0Fs?=
 =?utf-8?B?WnBsWjhSVkRsd2poWWNEcUc1SW9JZDdmeW5uNnd3Y29McGFBVVA1TXlEQUdV?=
 =?utf-8?B?OGZrV1NUUDdkckpQcWFXSVVGSi8rOXdBTXZFVnlKUnhSZHpqK0l0ckxXbExO?=
 =?utf-8?B?ejlqU3BQYUUzMXZxR3NJME9BdkJTNFp3VGxmRjlLT1U1UHVTV0FKZkxnNG5P?=
 =?utf-8?B?Y2gwYTIyVWRlR3ZIdjFlR1RUWTI1akVVNEJSTU1Sc1Z4cllJYWl4OVRUK2VR?=
 =?utf-8?B?R3BOa1JzQXpJV0RDM0tsUkpFWVdBSUVZaG5sNHVMaEhNVS9EOUo3Z0NQRGZQ?=
 =?utf-8?B?NGtQUFlVcDF5Z29xQ2dwUG1jWGZBd0xXVG04ZURzdnJUUytudkpMZVAxTnJl?=
 =?utf-8?B?ZS9YR2Y1VHpUOEhaMzByRStqRDZKWFBoNS9RSURmNlhzbXNkVDVrMlpHcm1B?=
 =?utf-8?B?RWNZZndzUU0vQXF6UDFWSU5zYVlMc1JjcUFFdEU5ZCtlQ01ZYzQ2Z1UxSWMv?=
 =?utf-8?B?MXEzMElkZmdXMVVUakQxc2pjN3RZczUvYnZ2MEh3RElaSWk5ZXZxTlpTcHJk?=
 =?utf-8?B?Yit4ZHk1eXJucGFmc2MxQU8yTzFjYkh5TDlBTDZPSE4xbWhEaTdzUDNBZkxq?=
 =?utf-8?B?SWVKODNwbnFlVHFkSHREb3RFYnZRZmhRYThValF5ZEZnNFdROS8vQVgwbnhP?=
 =?utf-8?B?cGZtRWdoWXB2bFgzbHRzcUpxUVFVbzBVQTlHVTNZSHM0T0R0YmNlNFY5RFcw?=
 =?utf-8?B?by92MndCUDZ6Mm40T1NBT1dnVW5naTBPR3E5eVY1TDMrM2hEdDdEOXIwWlFz?=
 =?utf-8?B?Z3VBZ1pzWEx0SE03REJCdXplc2dyUXhVUGxPY2ZCTkVwS0ozS1VKMnZmUkxj?=
 =?utf-8?B?Si8xelNMR0FKNTF5MkQ2aThQb0hwdWNFUUhXNW52QUp0cWd0MU5kOXFOMXNW?=
 =?utf-8?B?TURqUUVPcTF4OUtCM3JTRk05MEgxc3plWWNBUmZ0ZEN0Ykl0dVRDbFREbjV0?=
 =?utf-8?B?cm1DRXRxUnEwQmN3MjQvYjZzL1c3TzljVlpkWnZWZTYvbWJYY1JSaGV6dXN6?=
 =?utf-8?B?ODl3V0kxRzQwbHBmTFBkMnM0c0VNSVlpd0RtMWJ0dkNTQkd1aHBKSFZIdzRS?=
 =?utf-8?B?ODVXbDBuTDlTOExQUm1zY1hZRFhJTHJKVVVjWmtENTdsYVZ0R3ZUbnlvVi9V?=
 =?utf-8?B?OW1MTUhpQlFxT2h4eGNjNDh5ZHNNUk9ibzZTY3dZczMydjlHMzZxb3hzSWdE?=
 =?utf-8?Q?Gs2BpHBLC6lPH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4511d-4f75-4885-5fc5-08deac3ee2fb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:45:24.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5598

On 5/7/26 6:06 AM, Randy Dunlap wrote:
> Hi,
> 
> On 5/6/26 7:10 AM, Wei Wang wrote:
>> The config_acs parameter allows configuring ACS settings for multiple PCI
>> devices by separating entries with semicolons. The current documentation
>> only illustrates applying one configuration pattern to all devices, but
>> does not show how to specify multiple devices with different ACS settings
>> in a single parameter. Add an example demonstrating multi-device usage
>> with distinct ACS configurations.
>>
>> Some bootloaders interpret ';' as a command separator, which can cause
>> the parameter to be split as multiple commands. Document that the entire
>> parameter may need to be quoted to avoid bootloader parsing issues. This
>> avoids confusing bootloader errors such as ‘can't find command <BDF>’
>> when passing multiple device entries.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 170aae226e2e..0c159ab59e14 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5277,15 +5277,20 @@ Kernel parameters
>>   				  '1' – force enabled
>>   				  'x' – unchanged
>>   				For example,
>> -				  pci=config_acs=10x@pci:0:0
>> +				- pci=config_acs=10x@pci:0:0
> 
> Are these added hyphens/dashes helpful?
> Are they needed for some reason?
> I don't see any problem here without the leading '-'.
> They (here and below) seem like they could add some confusion IMO.

My intention was to use the hyphens as bullet points to separate the
examples. Yes, maybe they could cause copy-paste confusion for users.
I will drop them. Thanks.


> 
>>   				would configure all devices that support
>>   				ACS to enable P2P Request Redirect, disable
>>   				Translation Blocking, and leave Source
>>   				Validation unchanged from whatever power-up
>>   				or firmware set it to.
>> -
>>   				Note: this may remove isolation between devices
>>   				and may put more devices in an IOMMU group.
>> +				- 'pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0'
>> +				configures two devices with different ACS settings.
>> +				Note: Some bootloaders interpret ';' as a command
>> +				separator. If so, quote the entire parameter to
>> +				ensure it is passed to the kernel unchanged.
>> +
>>   		force_floating	[S390] Force usage of floating interrupts.
>>   		nomio		[S390] Do not use MIO instructions.
>>   		norid		[S390] ignore the RID field and force use of
> 

