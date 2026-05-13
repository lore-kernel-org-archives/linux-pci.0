Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013072.outbound.protection.outlook.com [52.103.43.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965C37DE83
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667007; cv=fail; b=pP3/BGgYJQbebkYGjUWp6ammKkLUVNTndVaqvr14acR19Jwwp/Jxcez2gOQXeW1brHLPxykrE22vZUDEBN9LUma1aCXAdTogOIrtcrcqOU/fVNON3blCEJ7yXzEpP5ONtSZtft/M7p2mYMTNExrfLJtFWQRs1I1Ag1utDfOrhSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667007; c=relaxed/simple;
	bh=Yfd0grg1L1M/8c344d5cp7tXYF0oCEzE3ivJkibnUlI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOC4y6+vq+ObTWP5LM7vWhKF9B5y78Vdd7uUOfd2xXZAo2VyHsHQsVQbtlrHmttlOB/ha9+gaTs4Dozr26ehSfnWcEOmo7ldA050+8MxJCuzkQqLppQNrdk6Cil7u9G9kjZpiGrMavhKOhM+oIguGW3saBad9D6epGkRPJLgZw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EOykYbPz; arc=fail smtp.client-ip=52.103.43.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EOykYbPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msdkuBjVcARHK+81PHxwr9z7y/c2Ns+YD0xTtK3Q4C8maDLouuoEsmKph+sS6UpGUH6QRmx9SRSaf/ZIjwVRrLH2RBDSVq2+wg/zJvuUJVv/fMMiWXOuIz33ERoYsSJKBffxNaqdDZ0ky08gVv2BSWADFkluPWIa/IN0fJFkXg8pWe9AeHXmHYhbVq0y5NuJeSDyAhH7yQ78hcX/5TWUISXrQ2d5QgJ2xQmyieUubx6lapt/zkstpUYVJG9stWfbFeMfNgS9Pcl71VeOL9Sn4fkrWFmMufdtuaYjUtgSVPhTRjrBOzoFbo2UU8BJXmu5hFH93L4ojl4TSQs43doUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb83e4OonzjNxlKeSmm5eukfBtKsDPALHRY5RdAEYtA=;
 b=SLmnSg5AMTefsIBGGiRhHjxY31UW3ZWHMZLYgBdBDrzLn4y+VE0UPmoZisEWt7zUf+1LofxHkrLrk9YguCfzMNqaubOV/TqePp2/9x9wD4p2Z3/jEGH14RO775PggchzCH85j0osfF5c5yWexX+9joS5MSLPHdJ36PUXR+bscn4B+9uYml6UYXRTMg+qTiFCWDg0SZ837oaHlxxAGfFlyhm5Sa4nyUSNqTSiDfJywnrk7iFZFvOF4GbaE/txuqDbqDxI4qZSqxIx4K+GdVlXirnaJsjQQQolcoosyEoN6PBun7XuIr3DM7JzG+6dTpb/kBWosjOKdAFu+SIx7m4KBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb83e4OonzjNxlKeSmm5eukfBtKsDPALHRY5RdAEYtA=;
 b=EOykYbPzuAgJZmppMqc9TFakXe4TPsrDmibcfiS/9wdYeDSF+PwxOWB8YjQb96Al2QA1bgi2WDCd9mOL4HLIAu5ESBuOQKSMPqqS7ReX6e0H+1Qvyd6STbt8Ag/5B5OjnziBki0OHjwzmTWsnrwkzxxPKSUdOBvptmAcK4rGFa+Beu5aAgBDY41izqb0FblnMhPT3ylhQ/OT26ydv4pUmsS2ERHmtpsFdPdNBFqpEtr73ULz6x2Y6/6/e76yYAycM3ARQ02FjCw2fqNYDP48OBOlkkOH0rPMHD3KpRPdqvBTXzMgpviQUs2DFIJ3W9luD0PPge3cLzK2yM+Ode8rGg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SI4PR01MB8008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:29b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:09:54 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:09:54 +0000
Message-ID:
 <SI2PR01MB4393B797DFA5AD23FEBC6D6FDC062@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 13 May 2026 18:09:46 +0800
User-Agent: Mozilla Thunderbird
From: Wei Wang <wei.w.wang@hotmail.com>
Subject: Re: [PATCH v7 4/6] PCI: Refactor disable_acs_redir and config_acs
 param handling
To: sashiko@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <SI2PR01MB43933B1790A24957EB7DB79ADC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260506210725.49C3CC2BCB0@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260506210725.49C3CC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0180.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::11) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <4e98986d-4dcd-4b69-ae32-40401f4b564f@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SI4PR01MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 5964aad3-19f0-43e7-acb9-08deb0d7c66c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|55001999006|5072599009|7042599007|45011099003|12121999013|37011999003|41001999006|23021999003|15080799012|8060799015|19110799012|52005399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1NubnBka3VlQUhUVngzbUcyRHlDNk9iYVJNYitQeVB3RHIvM1o4akxhMWF0?=
 =?utf-8?B?VjhXVzVobmc2V1habGZacUh0cnRhRlNqaHNYNSs1eWpFaHR5d2hiRzJmU2RG?=
 =?utf-8?B?ZjlQa3VJME1UaHlFMEF6cHVMbTMza3YwckYzczNPc0pjck5kM1V6UE5ZdklT?=
 =?utf-8?B?eEgvME9aelRrT251WExwMEt1MWxzNTRobkpTU2hwRjliNERVZTIrR0Y1Uzk0?=
 =?utf-8?B?anZLaXV1TWpxL3E4b2pyc1B2YU1tb1RYN1lsUTRCZDZNcU1OQ3NDa2hLdlIw?=
 =?utf-8?B?eWxTZEJMMGNIbHQ4N3JGblluSmdUMURSTGl0djQwalJ0cjh4M1lYOUpsaHhB?=
 =?utf-8?B?MUhpZmNRQ0hjSTBJdEJranJCTVFac2Y2aU5HT0hrM1RVdXNDa1ZYcnlQdm5X?=
 =?utf-8?B?bmNSSmJ2UjRyTVFaaEpOU1JuS0s5cHNnVHV4bGp5OTlqM05BM3hKaW5JYUVU?=
 =?utf-8?B?VUxzaEJMV09lakV6WVBZOTMrM2lUMWVicERzME5HdkZQQUxxV1FLdzZMZ3ZE?=
 =?utf-8?B?ZlRscHVsSTl3RUdNM25CSlJLVGU3cng2bHArNUpnR3h3LytkWlFRcm5ITFIx?=
 =?utf-8?B?aHFoVE1rRnMraEFxQi9TSE1CYzMreXVRVGszMVJoQ00vMGJRL3FyWm5WemV6?=
 =?utf-8?B?L21BcEZaOHU2OGZseGp1TFJPeklBMDBJNHphSzd1NHdqWG50K1VXUUVZWm1K?=
 =?utf-8?B?SWtxYlNDMVFsZ1JhSFJqMXJPRnVLeHVEY2p1Qk4yYjkrc0pMVVRUUHhMRzNI?=
 =?utf-8?B?bWQzQzJ6Q0ZTaXRtQlRzZGNxa2lHN25XdkRjRTJ1TmlWeVpKRWRoWVRpNk54?=
 =?utf-8?B?ZFFQRjdYUDJ4dGY4MmxGdDNnNWhieEhDdVpvbytmSkp4SnlGR1daWElLQ3g2?=
 =?utf-8?B?eUxjSThGMjg4SU41ZmY2TjIrUS8yNHprMEIzS3ZybFJnWVNieFlqeTVEeFcv?=
 =?utf-8?B?RmdqYk1QTk1WZzVaMElSRVFMSldVSEhZT2VGSjZHSFdSTWNWazFWMUtZa2F0?=
 =?utf-8?B?SVVmMW1zUkpBc0M4eDNWNFo0UzRBaklIaWYycTM2VStjd2NuUlpUenQrcFpC?=
 =?utf-8?B?c3JMTktIcFBZMlBJK2U5aHlkaVF5Y3pmMHJqVEYwdVlUK2FNWFpDUkduL1l3?=
 =?utf-8?B?Sk1GSGMxT2dVY1Nwc1daSjEzMXdKMDltN1BZVlIwVjI5WmplMjBOM2NUcG8y?=
 =?utf-8?B?R29mbWNjcUtuYmFHZkRXYWJIdmZZSkJLVUxhdHl4eUhqZ0wyNnQ0bStTR3Jy?=
 =?utf-8?B?b2NnRVlTUmEzWU9pYnJsWG5ET0NmRGEyS1N2cUg0d00wZ3RVamFxNGVmZ3dE?=
 =?utf-8?B?elgvM2VZM3lpRnpKL1p3am51dDJ3Uy8zTE82cGlRMUNYU091aTFvajBObVo2?=
 =?utf-8?B?MlVicnJKWDNPRTVKTHFTb0p4S1JWSkFLSzhNTkVUV3NRVGN5R09uL2Y0b0dw?=
 =?utf-8?B?N0pkVjVIQUY3clN6RW9USkl4eGJhaDgxSlZQZktvTVB4MW5BVmMwTnpWZisv?=
 =?utf-8?Q?76P4YFQtoO9iu9DBDyX9ZD5NXVP?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVk5a0hTdUl6YmxidGNWYlNFSGNMTzRUV014UHZCU0VRckQ1ZCs1eHJsaVNn?=
 =?utf-8?B?RExMTkFZeDNlWWY4V0tvaEdPUmQ2bDQvSjRpaXN2eWI3dEJkRkwwcjlobXpS?=
 =?utf-8?B?QVVBMVpOZVdVRVU1RXRDUFdMeUJWc1pTU2xEbUdQTHpmelB6SGpETlVXV3Zv?=
 =?utf-8?B?MTJiYzVZeTdSN3pJb1hLV3h5cmxSaytTSnRzWk1pblE1aGNPeXpmaTk4ZGpu?=
 =?utf-8?B?Vko4cSt6UUtyaWR4b1Y4dWloRGdqNktjazNGaTZjbWNDZzd5TWlHb2Nsa0RV?=
 =?utf-8?B?VEc0TzBSaWRIZ0YyeGREcThxaVU0OVloYU5OU0lnSHZCY0laajNjQTFNSjkw?=
 =?utf-8?B?UkxpOGVvRmNyam9SdzhQSGxaYWxQbHhVR2FXOEQySjlNT2g4K0ljVWlWdGRt?=
 =?utf-8?B?RXpqeEFrRHhJY3VaQmEzTjNETlRaSGUvMXVENW9JOEp3SFdRTm1IVDF4ZEJC?=
 =?utf-8?B?bGtNdXYwU1VqMXJuT2c1QU12MjRaUHp2L1pyTTJTbURhd1Z5aHNhUDQzWGhn?=
 =?utf-8?B?cHZkMlgzcHhjQnVmMHFjQnpxYW5CTW8wNTdoWDlwZDQ4TFZYM0NxZVU1a2gv?=
 =?utf-8?B?OGtJVmFxZ2xvK3FIV2ZmbUpZVDVaL3M2ek1kVndDS1h2b2tXNTBtc0NrTCtX?=
 =?utf-8?B?clh3aVRZd0w1VEp0L2gvZmpGa1RTSU5NcG1tRGhLcGZ5TTFKQkFGOCtlNGtB?=
 =?utf-8?B?d1VZZk5JZ3FKOEFXT3V2K0ZkZ1JQS3ZWRk1HWnhQK0Nac1gyMlFmTlIwV0o2?=
 =?utf-8?B?VkttMXpHMWVPR1E4dzUwRG9wc2ZudndPM2g0cmI1eVhZUSsyNCt2d2lCOWRx?=
 =?utf-8?B?aEZrbkpiZ0NMZ2VWU09aWW9OSms2VUt4b2ZFWGdoV2tleXRpQUlHcFQwZXdq?=
 =?utf-8?B?c05rWTZER3RjT09qdjRrN1NjOFBwZXFHazVlTnc2ZWJlOE5Td1ErYnFuZkhU?=
 =?utf-8?B?MXpNUmFRd283Q0NUc3ljanE3eUdHY1MzNE0ycGRKOGF1cGFnZ2tGMWZ1MWZ2?=
 =?utf-8?B?aTh6OFdyN25uTktvT3Z0dnBLdlZoRTE0c1VaU1lDVUZXbU1PMEl4MjIyVGNq?=
 =?utf-8?B?NFJIb1F6WVBiblljNlN5K0tmdDd1MEhhWXFaOW9FWjNwMURDQmFEZ3pQMGFS?=
 =?utf-8?B?TW00cHhzZmlaZTNiaENKWlJNMVVFWFE4aldnemUwbXhtL0prZFhXVEc2cWYw?=
 =?utf-8?B?SU1lcUI4WDVVbndLczZoUEdqc0EraldHZDVPQ0s4ME8wdmdHS0RjY3MzU2o1?=
 =?utf-8?B?N1lPRlZOQTdkS3BEdStzeWRncis2M3hXdWozZk4vajZtSGtmNDJTWmxmd2Np?=
 =?utf-8?B?SzlBcTBSS1NrbDYvOXpYUHI5TExqRlducDFFNGlISzRXSTZPRisrekpjb1hr?=
 =?utf-8?B?TTRSeHpHcHhQSFYwMnQvRjlocXRTNXRLY2cvRG1iZldQcWtVMjdObEpQS1A2?=
 =?utf-8?B?ZGRrWStJVTNUdHNCNkdrTXIxL3lKL3pUUUZoMXo3L0JHb3hOQXdOV244VzB0?=
 =?utf-8?B?cVk4QmdSRTlTdUNhZ3JnQzRWOVEwVEZ5U1pwQnlqMGRMNGtQaWp6VnYyZW1M?=
 =?utf-8?B?dkdiQzZJN2V6YTlrMmpvY0RNS1YxdjhUczl5SHFyNTNKYXJvYjlYOXA0ajZs?=
 =?utf-8?B?eHB0bmRJYWorUnAwRVVlRC9aOEFHdy9TRHl0V2ZRM2hJb3FSdkJBYXErK2d2?=
 =?utf-8?B?V1BpYWNzbnhxWGZudlFMdHY2TGRBYnJQbzVlRlNHTTlUVkpCQ0pyY1pQUjhr?=
 =?utf-8?B?SVZsZm1YdzVhQ1poTzBNM3NCenNpaStPaWhKUHIxandlS1JnOFB4TDZ1a2Fv?=
 =?utf-8?B?ZlgxWDdYNHJ5bUord1RiVElLSTU4U0lVZHFYd2NkbDk2RTBLUjFUL2tWa0JS?=
 =?utf-8?B?ZTNFT1BVS0NocG5QaDUyQWxCT3d0QU1JK09zQVFEYlF0VENiR3ZUcHpTbTlS?=
 =?utf-8?Q?XWeITKCPxlgxWaAKW0ZtTPVzvhKfHqNY?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5964aad3-19f0-43e7-acb9-08deb0d7c66c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:09:54.0086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR01MB8008

On 5/7/26 5:07 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Bounds checking in pci_param_config_acs() breaks backwards compatibility for padded parameters and contains an integer underflow that leads to Undefined Behavior.
> - [Medium] Silenced logging for disable_acs_redir reduces configuration observability.
> --
> 
> commit 2b4c7af1c4a60302203ef348c929aa8cf673e3ac
> Author: Wei Wang <wei.w.wang@hotmail.com>
> 
> PCI: Refactor disable_acs_redir and config_acs param handling
> 
> This commit refactors the ACS parameter handling by splitting the old
> __pci_config_acs function into dedicated functions for disable_acs_redir
> and config_acs parameters.
> 
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
> 
> [ ... ]
> 
>> +static void pci_param_disable_acs_redir(struct pci_dev *dev,
>> +					struct pci_acs *caps)
>> +{
>> +	u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
>> +
>> +	if (!disable_acs_redir_param ||
>> +	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
>> +	    !pci_dev_specific_disable_acs_redir(dev))
>> +		return;
>> +
>> +	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
>> +}
> 
> The previous implementation printed a pci_info message when ACS control was
> modified. Is it intentional that pci_param_disable_acs_redir no longer logs
> confirmation that the redirect was disabled?
> 
> This might make debugging device isolation issues more difficult without the
> dmesg confirmation.

Yes. I think it's better to have the pci_info message printed in
pci_enable_acs():

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b684ae4e92b5..dcc591d679d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1008,9 +1008,6 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
                 enabled_bits, disabled_bits);
  
         caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
-
-       pci_info(dev, "Configured ACS to %#06x (FW default: %#06x)\n",
-                caps->ctrl, caps->fw_ctrl);
  }
  
  /**
@@ -1080,6 +1077,9 @@ void pci_enable_acs(struct pci_dev *dev)
         pci_param_disable_acs_redir(dev, &caps);
         pci_param_config_acs(dev, &caps);
  
+       pci_info(dev, "Configured ACS to %#06x (FW default: %#06x)\n",
+                caps->ctrl, caps->fw_ctrl);
+
         pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);


> 
> [ ... ]
> 
>> +static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
>> +{
>> +	u16 shift = 0, max_shift = fls(dev->acs_capabilities) - 1;
> 
> If dev->acs_capabilities is 0, fls(0) evaluates to 0. Will 0 - 1 underflow
> the u16 max_shift variable to 65535, effectively bypassing the bounds check
> below?

pci_enable_acs() has already gated the execution via checking dev->acs_cap,
so if the acs_cap is 0, it should have returned earlier already.

It seems not possible that a device has an acs_cap but dev->acs_capabilities is
0, which means the device added acs cap but the cap is empty (no acs features).


> 
>> +	u16 enabled_bits = 0, disabled_bits = 0;
>> +	const char *p, *seg;
> 
> [ ... ]
> 
>> +	p = strchr(seg, '@');
>> +	/* Parse bitstring backwards from '@' */
>> +	while (p > seg) {
>> +		if (shift > max_shift) {
>> +			pci_err(dev, "ACS flag bit %d exceed range %d\n",
>> +				shift, max_shift);
>> +			return;
>> +		}
> 
> The previous implementation gracefully allowed parameter padding that exceeded
> the capability mask, only erroring if unsupported bits were actively enabled.
> 
> Does aborting here when shift exceeds max_shift break backwards compatibility
> for existing working kernel boot parameters (like config_acs=00000000@...)
> on devices with fewer capabilities?

Yes, use "break" here is better than "return". We should allow the valid
configs (< max_shift) applying to device. Zeroing those exceed the max_shift
isn't necessary, as the device does not support them.

> 
>> +
>> +		switch (*--p) {
>> +		case '1':
>> +			enabled_bits |= BIT(shift);
>> +			break;
> 
> If the bounds check is bypassed due to the max_shift underflow mentioned
> above, could shift increment without bounds for long user strings?
> 
> If shift exceeds the width of an unsigned long, BIT(shift) could trigger
> undefined behavior. Additionally, since enabled_bits is a u16, shift amounts
> of 16 or greater will silently truncate.

As mentioned above, max_shift wouldn't underflow, so it won't be an issue
here then.


  

