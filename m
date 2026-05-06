Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D5481257;
	Wed,  6 May 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076654; cv=fail; b=YVtrmV458cNAFUEC3CM5GEFjOTz/q1AA+nldQS8rkRoZI50pVezcFa50xvbxPlxnl5tVy57FvQMJTW0AgjQYhzJe6o0GUBmuepTIPwoxQdPY6OM9pt2hdTclmqWVonQDWtXpvwzc7LR6f3ZEV8Tj7W/aeJm9JMXaIoFrwzBGm5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076654; c=relaxed/simple;
	bh=1+UPt5CWAeWxz6yGiVA2FYu5RCLTBLn+W6lPQVgzllo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eVusuW7DVcAMszKwPhgPK8skWTKdpVQU0RggLnxn6rDsNtva4Iw+cyZwt542scfzWuP6MVxCfqbOv94J5qIWkTYDOepsisntBPplu4tsOWxKlH1zkOReyvCDeLGjjf5WbkmyK1KMjDaRRfWmWQ5fnz063TLIZeFiCnFK5Axo0T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PFsq+tsG; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PFsq+tsG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmYPEhskJocAXxhJdM/lJtkvRAWIlpShsZSg9NnNHNeJD8c0SOleH0zVCIfRcAP05F6bgoc4Qln5sQDjmExVKPo+Z0AHXiFP5ffVtqTSTQ9pZjImDCjSP/HJnrEKrV1zyMSrYHUXoVYLi8K5ejMmyGArTpyWBqxxnaVCT4EPQX/ZImORZJrZjhHbrpixPz/6j+qFTNQ8znv8ULbSPhuMzjQXSsbflDBjikny0RalUntz8hX3C8aX96ity3ZyfjYWtj0bo4qq6odmaYUm6FazNRpjQQhMg8euDYyV01HBqf0tuNy/NVU+7peHFxG8ritwgZEbaS1KxFpE3kIpNOMKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Bg2TWvOG/WPQ6h06xmJlGPtI6z7HApU8atGHXce+g=;
 b=kUIRJfaEO+2sjBGIsGEIZVbRuycDPZdWrSzjPdrLj2BEB/RnZQRYBZoENnvM685+wFadWOyNjrOr3+YD1h9yZcVUxnbM4eUPmXVfjk1m0qgrztNUcfTzQReN49Xi8jXYpREKZwpsdcvCJT09PBAiDZVN2bR58pA3OOhFlLKO9xPX6e49LbTVqY+yQsBd36+T0X0pYd3IFlkbGdaEWOJq6tvqAi0XwjTVt+zfl5IlKlg+JYzS0lTqE5ECiJVyOQyT5LM8OC8xn2MJaWWqX08hMTVTJUl8CY1JyGtyUEuGmKFIY6gC4tix5XintrD1JzfNWdTGSa5RaxrOGveuh7gS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Bg2TWvOG/WPQ6h06xmJlGPtI6z7HApU8atGHXce+g=;
 b=PFsq+tsGuF8Oucu5TRYQb8IPhDZUYqi1vza8JeKtFbuL0XEXkCwpQJD8Lefl52WpW78K9xUTe43MTkhzVZkHTq443iosNC1McvKG4x7p9P/xN3AD/8swfqHJUMQPpDsCsMxYQHEn+vEAK6DXs3wM6ry25aBRnx+slWSZdW2XuSXnyyg9vjyUdUGv+f8oBCjTx2zGmXr3m3ulXVaJogTxEqQ+eQYOvV71PuO4yxYNOvXTY6+FYLK0tldak7BThnHkjBqLbWqQv/upQa7CKWM6Df6EgNmcrQc3IC5bvjcdITofFdK6ci2kgxVt3NJK4ISZqR+rM4eLXcWMQWVTPeHokg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:10:48 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:10:48 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v7 0/6] PCI: Add support for ACS Enhanced Capability
Date: Wed,  6 May 2026 22:10:28 +0800
Message-ID:
 <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1806ab44-4cf6-417d-909a-08deab794561
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5062599005|5072599009|6090799003|19110799012|7042599007|15080799012|51005399006|12121999013|461199028|45011099003|37011999003|10035399007|4302099013|3412199025|440099028|1602099012|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHV4d3gxdU1qanV5dGM5MG9WUVh0bG04Szd6M3dJWkFpZldHcnpzVzg2Znd4?=
 =?utf-8?B?QzA3S3NyM0dwRjNJaFlKTmZBNlJha2ppYzhIR0UvbU5XNG8wZ0JUaFFXUTNs?=
 =?utf-8?B?R2xvQzlDODFTSHFHRmpTNXE1TTRENjdUKzhLSU1wbVpyNS9YTVR3eWtjZmlq?=
 =?utf-8?B?bDhxdWFqRC9vZGVZSG1QU1NXZUVCczNRWE0yV25YQlFQTWNXT3ZGaWFhRERN?=
 =?utf-8?B?ZkZ2cUcvSkJiLzJNeHFKTURWNWdtUVhrK2I4UUpvZENXL3VQT0owQ1kxZXR2?=
 =?utf-8?B?QzltVExNTU1VdVN6RnlkZXpyMEtLeTN4Zis1MDRLSTJLMGg3THdKZkJQb0s0?=
 =?utf-8?B?NnZ4eVNueWQrb0RNMXZiWWlkRFBYNldsU3lrRjk5dUFLU0VlbFFqTWlMT1Qw?=
 =?utf-8?B?SUtZUU80d1czalp0ZVJ0alYyOE13ZmFQM1pQWm55aDBOanpMUmdrRXdmY0M5?=
 =?utf-8?B?R3FVU3cwc1V6ajhPUVB4aEF1ZmlaVU1QNjBRZlRqRTkycHZHTE9QRVZJanpW?=
 =?utf-8?B?aVVtSUxMdWhlUm5TaHdVNjBFa1BqSjhOWmFTYWhYYWZkMWd6Z1JDam40Zm5Q?=
 =?utf-8?B?bVhXbytpYXhzWjlQTFZTNWFOMTRKSHJqeHltcU5yYUxvb3V2MGhlOU1INjBD?=
 =?utf-8?B?SG45eDBBMGRWcHFWb0xxYzZ2OWF0RFg4V1VkeHN3WmNac3NkTzFOakhuaWtO?=
 =?utf-8?B?ODJOaHRrL2lPMGRUa3Nkb0RCY2hZemRscVRRWldBbktENVVvT3VnZEorTEla?=
 =?utf-8?B?TTRoYnNXdnBNbVQyU2t6MitWYXFIZ2d1K09LMC90b3JyanJkYTFRUGdtY2VP?=
 =?utf-8?B?SXhEYjc2RHM5cnZpOXdkeXZzdC8xQVExam5mUm14Rm1TY0tJVmVvdUtnQ3NG?=
 =?utf-8?B?Q0N4YWg3aUJ6WXVkaFBsd1dZRDFRZU03RXVVaDN1eVVzTWpheWJidjFQOWJv?=
 =?utf-8?B?T1pTNTNjN0d3a1VBZ2V5MTI4UXBTSyt1VUMzTy8yVmI3TnZ1OTc4NXM3Wmtl?=
 =?utf-8?B?NWpqZGZqUWhCeGpieE5yK2NUd2VkR01OZ0piRElmMjRTNldqUXY4dU51LzAv?=
 =?utf-8?B?QkVudnBNRHBqZ1B2Y2pGbm4wWDhvUGtGV1NiUlg1RXRKdkNWemRodTNORDds?=
 =?utf-8?B?NDkrdUNJWWt4Y2RDNlkrOFpFdktRaGFwbFc5WHBEWlBOVDhZTzdhbS9kMzBY?=
 =?utf-8?B?NkQ4THRweWZ1Z2pSK2Nia1FqQzRyYUZOZ0dvbGNDcWFKTVdlQnZRdXd3a2tx?=
 =?utf-8?B?b1ZPRVg1ZDVJV3hVZ0E3Ty9XV1lWaVJTQkFhK1lYb05BTHI2b3lBQmpkS0M2?=
 =?utf-8?B?dlNXRTBicUVSSUlyck5RdmY3YXFyVXhsSkwxTi9FR3dIUDJRVjBUdjE0MVZs?=
 =?utf-8?B?bmFZRUpqaHJJS0VIUnkzSEdvbUZjVDBwOGFwQkNDNGN6ZzM3VWF0eGc5S3Va?=
 =?utf-8?B?MVhWUnYrZEZXQVFHaHppM3FjVHhsWEJxallYZDJMdDAxZG0wUzdNMFQzaUJO?=
 =?utf-8?B?VFJacUwxMGM3OThJZlY1RUFXM2o1OHdiY0p5NWZmZXlkODEwSjFFeFFQaUNt?=
 =?utf-8?B?NnV1STFDQ2RuaDQrK2tza3RGMGFYQm5LZnlpQmM0anlIYWRXQjllWERGemJn?=
 =?utf-8?B?dlFUNElieVB4WWpzVis2R3kvaFFXRGE0UW8xSjZVUWl4SUNubHFYUW1NQ21N?=
 =?utf-8?Q?IRWjGuSpeWnMm8u+0HTP?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJHNUo4UTRqSzZqL0xVQ200ZDBWelp6NTNGL1NCbHIrcmM2djZ0WXZoR3ZS?=
 =?utf-8?B?TytKZ0JNSUowL0dCZGtRWU9JVFA1b1pXMVh1Q2paaFRDZHMycm5HeWp0NXlI?=
 =?utf-8?B?S3J1cG1TdERDZnAxQWo4Mm5yWERyQ2o5ZXpiL2ZrVWtId0Q1RGdtUWF4NHFE?=
 =?utf-8?B?U0MvWGJRNWIreTNKUXgxaHVpaDNCTEZ0MzJ1cUV4MHNmQUpya0F0NTRBcURR?=
 =?utf-8?B?bnlRZmN2MGxESkhqWnc5TDlYR1h4NjMxMzJxYzVWS082UkRMY09NWmkvQ3NS?=
 =?utf-8?B?bDIvODJEZ1oyS2ZTZ2Z5SkJBcmtmT2xpQ3E3ZEprRDJSN213R3gwMHN6NERi?=
 =?utf-8?B?WGl2dmFBMzZaRmlZampKQmN3eFpBcmppbndBZHVVc0JMNS8wZE1ydStNbVR2?=
 =?utf-8?B?R1VsekNzRzhMalFGYTQzUzZRKzZCeEpFeVgyYU40bElsWkQySkJrYVdEUDBM?=
 =?utf-8?B?ZDFaNlBVYVVTcXRFdXQ5dFN6TWg5YzJINEhPR1BMVDBmTmxCTkpzTXpoblFo?=
 =?utf-8?B?YTZPOXRYOXNTZkZiN0hXSmtpMEFici9qM09JUUJlSUNpakpMZUlXb2R6K3Fw?=
 =?utf-8?B?azVUSU9kcWZPc1Y0NG9qYzRpUVgrWlNSQlovU2xmbG8vYUx3Mk1oaGgzbUpJ?=
 =?utf-8?B?am5pbXp5U3k1RFV2YmtVdDcyRW5WRHpiR2hFQzNrZ0hIK2tNOWtmY1owM25V?=
 =?utf-8?B?VVBvKzFLVDUwdUw2ekxRR0VvY2VKVzVrMlJ3cVRkWWxkdnRsYi9WRkdybElk?=
 =?utf-8?B?YlJTWElJYXFGVnJtZ2NrRWhMbmtIb2I1VDN0bXA5anQ5dklyUkY2Vit2cTJw?=
 =?utf-8?B?aENGYUxPT3UvNkJTU0VuTThKdTYwOTdVYXhudDhLUkhReXR5ajZ3VURhK2xW?=
 =?utf-8?B?UlNuSDFXQjFaNWJ3MnZRa3ZkZ29zeG8vV25nQVhOczhmeWRHWXB5THd6STNl?=
 =?utf-8?B?V2diT1pKMXJ0a2xaVVU4Ui8wQ0I3SHVibzhNaHVGbTlPUHRDcnB6UHo5NzhX?=
 =?utf-8?B?S3U0SnBMWXQ0eS9zYW1ONlJPNzgyTFhMWkVrb3VHRGZuZ0tVekdyMWNNY1Y4?=
 =?utf-8?B?Q0czYU5aNDZvMDlkeTBlaEtMUWlyQlRaWm5kdy9yU01RRUZOOEVFRkttUzhB?=
 =?utf-8?B?TWhyUnE3YWpCbmNaN3dMc3BlYmdXNEJGdVh4ZHNZTG50K0VHLytscFpjaHdB?=
 =?utf-8?B?SkplTklXRzE1T0ZIczZtVkJUcWdtKzdPNk5iNGxUYUd6YmtxdU1aVlpFTlQw?=
 =?utf-8?B?cmhVWUZGbi9IYWhVMHNNZjVMWVNhNVdKTGdBblZBdXNLT0VTWVlTczlzOTA1?=
 =?utf-8?B?bmFObkdBcEtNQldUN0EvUVdaOXVUQkQ2YnRiYlBTTFlIL25ITVJ0NE1DYkZP?=
 =?utf-8?B?d3RHdEx6NXZRZFZwWGd4aUI2RTVTMVJIMzc0dUdueU9QYldIbXcvQzZBTTBH?=
 =?utf-8?B?TTdtZGlwMVFpZ2VHTllpa3RBWVY3eFFFWEkxQ3EzZmQ2VVRWOXNBbGYxNFor?=
 =?utf-8?B?VjdZQVREZTdBWWtMOXVyYmt5clR4bytwc3o4V3cvNEpZS01yVzBYSHp0U3ZX?=
 =?utf-8?B?Z05BNmZlc2E5a3JQdkoyQ2kvbHd6Y3RlT1RkcFJSaTh4OElxYko0dytOLzU5?=
 =?utf-8?B?U09mTlc0cVJMU3ZhOUhQYWxUSWhiMkswaGZjbzZvelFmczR2TUJpc1Q2Yy9K?=
 =?utf-8?B?eVVJZ1NRVWI0TExnTXVyVDdYTE4yek1Fd0NLTUpKSUYxTTFDajRnaU94eUhS?=
 =?utf-8?B?bXlOOEpMMTFXU3ViYnFzRE96WmszV1pubFhFWWlUdUNpVkdwNUMwZWtGVEpV?=
 =?utf-8?B?U2dsckRXTVc3a2xzZVZrQnRqWDM4YVdsVThNcFZ2aEZuVHE0RlJITmpVeDE2?=
 =?utf-8?Q?YBN3j8ljVIZPH?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1806ab44-4cf6-417d-909a-08deab794561
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:10:48.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

This patchset improves the core ACS implementation and adds support for
the Access Control Services (ACS) Enhanced Capability, introduced with
PCIe Gen 5.

Improvements to the core ACS implementation include:
- Validating ACS enable flags against device-specific capabilities rather
  than generic kernel masks. This ensures only supported features are
  enabled while safely ignoring attempts to disable unsupported bits.

- Consolidating delimiter parsing into pci_dev_str_match() and returning
  -ENODEV when no further entries can be parsed. This removes duplicated
  logic in callers.

- Refactoring ACS parameter handling by splitting the intertwined
  disable_acs_redir and config_acs param logic into dedicated functions.
  This improves maintainability and robustness while optimizing parsing
  with better validation and readability.

- Updating the config_acs kernel parameter documentation to include an
  example of multi-device configuration with distinct settings and
  advising users to quote the parameter to avoid bootloader parsing
  issues with the semicolon separator.

Support for the ACS Enhanced Capability is built on top of this improved
implementation. This capability provides additional access control
features that improve device isolation — particularly important in
virtualization scenarios where devices are passed through to different
virtual machines (VMs). Strong isolation is critical to ensure security
between devices assigned to different VMs and the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() simply skips the check.

v6->v7 changes:
 - Rebased onto next-20260506 (based on v7.1-rc2)
 - Picked up Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
 - No functional changes
 v6 Link: https://lore.kernel.org/all/SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com/

v5->v6 changes:
- Patch 3: In pci_dev_str_match(), explicitly set `ret = 0` when no
  matching string is found. This resolves a smatch warning that `ret`
  returned from sscanf() may be 2 or 4 even though no matching string
  is found later comparison.
  v5 Link: https://lore.kernel.org/all/SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v4->v5 changes:
- Added significant refactoring of the core ACS implementation (Patches
  1-4) to improve validation, safety, and readability;
- For USP and DSP Memory Target Access Control, added masks and enum
  values for the encodings and explicitly rejected the reserved encoding
  (0b11);
- In pci_acs_ecap_enabled(), removed the use of 'is_dsp' variable.
  v4 Link: https://lore.kernel.org/all/SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v3->v4 changes:
- In pci_acs_ecap_enabled(): Check the pcie type for
  PCI_EXP_TYPE_DOWNSTREAM explicitly.
  v3 Link: https://lore.kernel.org/all/SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v2->v3 changes:
- Drop the warning when a device has no support for the enhanced
  capability.
  v2 Link: https://lore.kernel.org/all/SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered);
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.
  v1 Link: https://lore.kernel.org/all/SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com/

Thanks to Jason Gunthorpe, Jonathan Cameron and Dan Carpenter for reviewing the patchset.

Patches on github: https://github.com/wei-w-wang/linux/tree/v7-acs-enhanced-cap-and-refactor

Wei Wang (6):
  PCI: Validate ACS enable flags against device-specific ACS
    capabilities
  Documentation/kernel-parameters: Add multi-device config_acs example
  PCI: Consolidate delimiter handling into pci_dev_str_match()
  PCI: Refactor disable_acs_redir and config_acs param handling
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         |  32 +-
 drivers/pci/pci.c                             | 274 ++++++++++++------
 include/uapi/linux/pci_regs.h                 |  13 +
 3 files changed, 224 insertions(+), 95 deletions(-)


base-commit: 735d2f48cadaa9a87e7c7601667878de70c771c5
-- 
2.51.0

