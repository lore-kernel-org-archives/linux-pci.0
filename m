Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012048.outbound.protection.outlook.com [52.103.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FB3876C0;
	Mon, 25 May 2026 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716605; cv=fail; b=AnrK0/k9EvMnRcxFX0wSB08n6RMzdsenUIFwBXvkFrLSrlhohQZmFFpT/scnsF+DJopGi+rh8XQTxxeq34J176zQt00GTEoc8iLefHjAe3qTuMBYUcNnwXns+A3JP9SvLuZH9Z70cotwVY/UpVe81YHUqCCty/wHpqkTabjyVbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716605; c=relaxed/simple;
	bh=CSwCWo3fOrgXvmQd0fGOATqv6JuK1FoccOoadbdj02A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BhmfW5ZaqXZTUpTeDFTjmbO1yJu6Wk/YJoosCcb8tfgPgYZfEJ7iwvYAYY7LKvGPn4Mp1w46nM5ihBv6k7xvDbxdB6wHnag3fDdivmC16ogteSqLxMGT8qUj7lNUn2OQsZCR5tq5VwdgqQSeGcjgpfcKdag4Ead9Xbx8+FsyqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=B2jiNUPv; arc=fail smtp.client-ip=52.103.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="B2jiNUPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUgu8zdBiLUN9+CS2U7jap1oa2zw6CUc9IIVd2o3moSh3z47K8rjszTPXmZ8/iJfn6ugt8QQlC/uMbkgfwaoCQuuL9L8QtuvdDgkVfchypPCbt9dxKM34gB0Wd1RnTMtw76x8NjZpvB1QmPPevAKasJmrNMJfQdE4B2kD8MCBP1QAdZu6heZXX185YL02asY7A/e4CvGkYcj4G+tJj4Vwz/ljTjH/dJJaaQbwvYD/8N2TCvIS1ctpdzbbn/BnDUoqDMIDmUR8mdIHroiHeL4LGxgiPUvAvmrbTTVbn40JfSM6xmc44mbrjPTD3nkLQ/NgeYMh/lBuJhuVEHw1QMbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYYgNzpqRvQUVVqKD1NnfVKzxQxKDtbvBcbJpwXI//M=;
 b=QUyQoRnvIRdPeRbr+RaT2ny60P+r81EVnBIA801ZzG7eTPcucYgg4ls4RJsnTcHKVjaEXr+lOZtLtiqvpp5MSg1DgK1AR3zRBkowoS3FW4neMRXMF/yIDpKnXe+d1+ATiG5r5PnVXDQQr7r9XCOi6kdsMYTJiW/QIO02wje8xUulSPJ0mWyvACE+p/FEgmpWqzpy23SDKwQl00f83FL1ozxQYBMq2QcVrgJnBlZ0d4yp3dX153vZpgkd88nuLZ5QwBiKMB2KiOo0ipE3dHE3lacLYkEnNpLksqdXBA7pw7UdHTS7mSX/wOaSfsAlAHm6XhgEKd9aWd0t/LVej4FUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYYgNzpqRvQUVVqKD1NnfVKzxQxKDtbvBcbJpwXI//M=;
 b=B2jiNUPvVCbTW2DXBywZz2wH12UZFSVZR5tG81DeybR7eKGyTPdVSasgp0TLsxECaaQ9euZ/TOZLm4QsEiYsF76oNjMAidp4SFCTbJyJL+Zzs72ZDgK0J9Vir8wmCbA2cWhQR+RYP5Nb9a3p//v3u8T6cPOap+zF0hHRdNWkYlQfrfGnydJPzhANiZ4+wcShZQAa4K5bFDgqCBM2yTDMGJvCw/atFDtyUlX6zHRgS7296m/7StjKPU3vWDiiagjq5twyhdNOad23iaPuf1APCpFl3WV2EENOM++4M1qbqSupWKKhk9G23XxHRNZ/rnwvSwlNPnHtuL5kR10bKR1bnw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:19 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:19 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 5/6] PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
Date: Sat, 23 May 2026 22:01:42 +0800
Message-ID:
 <SI2PR01MB4393FFFD729022A7AE45D19DDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <d5fe41f9c944fa3a75bed789fee979e0f06bf25b.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8828ca01-296e-4def-de74-08deba639494
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|16051099003|37011999003|51005399006|12121999013|41001999006|5072599009|15080799012|8060799015|19110799012|6090799003|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Szd2TTNyT3Q2a3NFSjU2SmM0MTFXaUUwcEM3T0dtUDE3d3hMS3hrWlJtTWNR?=
 =?utf-8?B?VjVIem1PWHBnMWJhUUZNZWdsT3Y5aFRUMXVMSHNoQXhJNjNDYy9QUGV0WUly?=
 =?utf-8?B?eGdoa0VTOE52Ri9NdjZwVXFaTVZRckhxZ25wOGtJazdZamQ1SHFpdEUzSENL?=
 =?utf-8?B?Y0JBUGcxZ1hGRnJ4bHZSWElEUkdTcGFDNGtlbHBwVkNCTnVWL3lQN1BhZ1NI?=
 =?utf-8?B?cnBiWEduckJsY1JFVlYwRlBUVXJMdnZWeFNBeTJCSzZaaWJyRmJhem9UcWN1?=
 =?utf-8?B?R0wyREZmbmZFWHlaaC9Rb1o4Vlcrc1lLUkU3Zk5BQ0MzWjdqTGV0eGxTeDRo?=
 =?utf-8?B?RDUvRWNZdCs5ZEE3UHljanlxTWMvRDFBaEIvYWh5NkRvVmVwYmRzNXVJSXdi?=
 =?utf-8?B?UFZpa2tHZlFXemVKTXljU3NNMGFIMnl2WFJ6dVJRQU5qbFUzN1M0NzVsOTY3?=
 =?utf-8?B?NWJlc1VJcklsTUlzeHdTMEhySi9xZC9VZld0cmdoZUhWeFRtcFUxeTU4YTk5?=
 =?utf-8?B?aVlRNnY0dlh2WitBQmsyeEUvMnAwb0dSWkljamRsVDQycXFEeTVJeTV5T2Ny?=
 =?utf-8?B?YzFsam5HRGxSOXZSQWJqZ3hvS1ZheGxPeS9XKy96S1UxNTV3K1RsZk9HSlJj?=
 =?utf-8?B?V3h2ZTBOOFo3UWlmcFN3WEpKQjdHamhacWlNUGI4N3owU1pIamtaQUtLdERB?=
 =?utf-8?B?dDB4RnIrWml6RXY2WjZLTjdZSG1RanpMR1phTDZiSlhuRmVLTTFmZ04yWHQr?=
 =?utf-8?B?dXdjcTVIN2RqdWZMamRmb0VYUStHNmo2MTIxbk5NZmd3R2RHaGVOY3ltSlQr?=
 =?utf-8?B?cWNDa3ZIMUlydGhNbjRJenJJQjRkbTIyR09CMThPcXVGajgra25GUzRtR1VX?=
 =?utf-8?B?RUpwbEFPN0xiZEpKK0lISEdHVnVyS0NRa1hXQ1Z5aStPSkNuQzZ1QWVieGlV?=
 =?utf-8?B?eTNaTXdLM3I5STJWU1JHdEtWMVV5VkMyNzEyN2JuSCt1RXErakxMVmVMcXFr?=
 =?utf-8?B?d0cyZi9sK3FVVURXR3lkT2kremhPVThqYmZ3MXBOdUVEaitVOEp6ck1VYjBQ?=
 =?utf-8?B?b1k0VTVtRDJFcG5EVFo2QVdsYi9FTVlLMEhBZkNIQXdPL29acDdOc1IyZWJk?=
 =?utf-8?B?ODdUQ3I2NG5Wbk4rbXVUNGFtWXhzdFZObGRNazQ5YnFaN3RldWNPcFJURVdv?=
 =?utf-8?B?U3RocFFmbVQ2aFQ5aVI5c05RUWZUc0lVeEpsdXE4WnpjYnlBN0pWaEk1WGxa?=
 =?utf-8?B?U1N5MGZpTHJoSktLY3E3TENaeUg0R1MrQUIvK2ZzZk91Z0tsNVRmVzlUVlcz?=
 =?utf-8?B?YnNvUnJ2bFF1SGRCa3V4N0ZhYUkwRE9YVlF1QkV4Sjk5YjVSVnJsMk9XbEJj?=
 =?utf-8?B?UkNPRW9sR3Y5VEdQMEc4U29leXdpRXZQTHZONkYxNHpGcWl0UElkU0Vvelpt?=
 =?utf-8?B?d1NDM29CcUpFVXhQN3ovTTlhVjBFaENuZitoQWhHOGlYZlFPQVVlM0pKOHZH?=
 =?utf-8?B?akdtU0lRbjR6alVMQ2VqODlQVXcxS2VuOVpmd29UQ0FOLzNCMkUrWW1kQU05?=
 =?utf-8?Q?VK8M3qysom+C+rC6jKp0/YUdDiA5+gKbJw/jUAd4TDT4xb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M09URFNXOXpwcFVhbElxaHJxTTRIa3d3RzY0TkhuZXFIZmk1UStvZEZldThS?=
 =?utf-8?B?dlRhZ245ZHQxZ0VGZmdMY0t0SEt3dUpMV3dBQmx3bmo4L29UcEdTOGtUM1VD?=
 =?utf-8?B?eUxTRWlOS3RJeGFob2xlQWZpcmRZS0F6cUladjhmNGROUmxQUGJoN3VqenlB?=
 =?utf-8?B?UVMvZW1OK3FOWWlIdU1aREZ1eVRTdXhieEo2eW1SUzJKRTRiUjkvRyt3V0FW?=
 =?utf-8?B?ZGFMY3FiNW9MNnEyU1BadkNaSG50aldDY01KV2tISnMralpoWTVoamhaVmJw?=
 =?utf-8?B?QTlRblpyclhDcytBRUNFM2JmL0N0TENsekxuRkdxejAzcFR4R1V3T0FUUUlK?=
 =?utf-8?B?ODFQM3BqTnFDRk9UUDlVVEVKV2xlc3h2alUvbk5ubXFia2Fudm1qMkJKNHZU?=
 =?utf-8?B?MVJhZnV6Q1RLSmlBVC8ycmxLRTBoVzUzUnNFcXY0VXRuc1pCOVY5c0ErT3dS?=
 =?utf-8?B?cDh0U2JkNGFDT3VwK0RCWFFKQU1NeFFUdTNuUjUzd01oc3FhTjR6ZFJtQ05Z?=
 =?utf-8?B?RE02OFFoL0lSSk5uOTVTTmlSQy9YUU1MSy84TnhqNmE0eWw4OTl3M1JDZ0ZO?=
 =?utf-8?B?T29BcHVXRkQxZ0x1MiswcmNtOTJxWjcveUd4ck4wTzI4Q3F3ZEhSUUlnQXdz?=
 =?utf-8?B?ZHZqbTFiV1R1dWpTRGxHYVBabExDWU5nTDRESU5pNEY0T0VVQ1dqR2NXeGRP?=
 =?utf-8?B?Nk1vdE8xU0tpT0NkQktQT1ZMbC9Nbms1SlJiMG9IVGlGK2NsQmljT29IQk0v?=
 =?utf-8?B?RFdoL1UwMWpIS3I3UnlpYnpQZmpmUmtNNlRlVXBDT1plOExCektQNVgyQk9C?=
 =?utf-8?B?T2VQVmpIRGZvdmR1c1VyMTU2R0ZWVy80TldEQ1g0d2Znck1SNnZvUXlGUnRv?=
 =?utf-8?B?MzlmWFp6MVBEMkJFZFFZTXRHQXlpdEYrbjhqNGhxOTQ4TExRbDZYM2NwV2w3?=
 =?utf-8?B?MUR3SE1NdjdWaGlQcnFBOFFzdzkzZ2RNUTFRVitvQ0hSTXlHcjdTNGpySnV4?=
 =?utf-8?B?Z3VTS1ZIRk85WG5Id1kyNmxLcUpENVdETDRsRGVXOGVzb1E3czFmSkMwbDQz?=
 =?utf-8?B?ZUliK3ZUMnFxYlkvUnduMzBHSGtHK0pseXRmdnphQWlCeFpZcnQ3RzJCWG94?=
 =?utf-8?B?NGdVM3JVWlJuaUpaMUQyS3dnMDJBeGFzeVo0b1RMWGEzZm9Xd1lxNk1zT21V?=
 =?utf-8?B?bzNRR2pzcmJqSTBXbFNJektNbTlnb1NPNFRkSGhFbm9yeEJnOXRBVjJpSC9Z?=
 =?utf-8?B?dXZCTzRPTXQ4Z0gvczdyaGRpNW1ZMXo3a3FOcmV2a1VXcjlad1pwYkwrbkZU?=
 =?utf-8?B?bUYrYUhIL3h3MjFJSHBrTUhIT3EzdXFJa05TK05ERDZtbHIvOThUVDRIMVlD?=
 =?utf-8?B?UTUyZWFQZ0pySVJRN1VvVk5sMFY0WmVRcXQzLzBhTEdiKzZJVXVOaWxpY2xv?=
 =?utf-8?B?L2o2KzJveWlLYUFRVWk5Q0VXQTlJRWlReHgxK0txbmQ1cjNBa2hVbmdGVk9u?=
 =?utf-8?B?VHdoaThBQjFDNm9DQVVYTTc0YmIzZ1JiSWZzRnVsUmFBU2YrZ29zMUwzbFFt?=
 =?utf-8?B?Q3BRR0MxdUJjT0FFdXhGUFVKK0QxdGJRNGRwR1VEVFBlcS9BSUtBY1M1OWE4?=
 =?utf-8?B?TzZRclV5WTA4K3ppZzJJZVMrL2prOHptcTdqekQwRUd5bFBUTzFTZEJJU2Zj?=
 =?utf-8?B?NW1ybExMU0E1dEp5U2lPTGc0TFphajJtZ3N5ZUVpbDFNVUExVjRaMnZVRTR4?=
 =?utf-8?B?MmhUbkZJb3NIdGo4NVhTMkwwNEhUTlA2YjYrZDBnNVVmQ290NzJLT01meTBz?=
 =?utf-8?B?azZjdmZLeE1jaVBvQm5SZnFlV0V0WVoveVVjVjViK1ZPZjFYUXBDQWlKSHZC?=
 =?utf-8?Q?U9WnxuSSwsvaa?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8828ca01-296e-4def-de74-08deba639494
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:19.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

The ACS Enhanced Capability introduces several new access controls to
improve device isolation. These new controls are particularly important
for device passthrough in virtualization scenarios.

For example, a DMA transaction from a device may target a guest physical
address that lies within the memory aperture of the switch's upstream
port, but not within any memory aperture or BAR space of a downstream
port. In such cases, the switch would generate an Unsupported Request (UR)
response to the device, which is undesirable. Enabling Unclaimed Request
Redirect Control ensures that these DMA requests are forwarded upstream
instead of being rejected.

The ACS DSP and USP Memory Target Access Control and ACS I/O Request
Blocking features similarly enhance device isolation. Device grouping in
Linux assumes that devices are properly isolated. Therefore, enable these
controls by default if PCI_ACS_ECAP is supported by the hardware. As with
other basic ACS access controls, these new controls can be configured via
the "config_acs=" boot parameter.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++-----
 drivers/pci/pci.c                             | 30 +++++++++++++++++--
 include/uapi/linux/pci_regs.h                 | 13 ++++++++
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91d2f3fbf8e7..af3d8a1eca7b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5260,13 +5260,22 @@ Kernel parameters
 				flags.
 
 				ACS Flags is defined as follows:
-				  bit-0 : ACS Source Validation
-				  bit-1 : ACS Translation Blocking
-				  bit-2 : ACS P2P Request Redirect
-				  bit-3 : ACS P2P Completion Redirect
-				  bit-4 : ACS Upstream Forwarding
-				  bit-5 : ACS P2P Egress Control
-				  bit-6 : ACS Direct Translated P2P
+				  bit-0     : ACS Source Validation
+				  bit-1     : ACS Translation Blocking
+				  bit-2     : ACS P2P Request Redirect
+				  bit-3     : ACS P2P Completion Redirect
+				  bit-4     : ACS Upstream Forwarding
+				  bit-5     : ACS P2P Egress Control
+				  bit-6     : ACS Direct Translated P2P
+				  bit-7     : ACS I/O Request Blocking
+				  bit-9:8   : ACS DSP Memory Target Access Ctrl
+				      00    : Direct Request access enabled
+				      01    : Request blocking enabled
+				      10    : Request redirect enabled
+				      11    : Reserved
+				  bit-11:10 : ACS USP Memory Target Access Ctrl
+				              Same encoding as bit-9:8
+				  bit-12    : ACS Unclaimed Request Redirect Ctrl
 				Each bit can be marked as:
 				  '0' – force disabled
 				  '1' – force enabled
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2e5b0119397..348caa1e132a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -957,9 +957,12 @@ static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
 static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
 	u16 shift = 0, valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
-	u16 invalid_bits, enabled_bits = 0, disabled_bits = 0;
+	u16 new_ctrl, invalid_bits, enabled_bits = 0, disabled_bits = 0;
 	const char *p, *seg;
 
+	if (dev->acs_capabilities & PCI_ACS_ECAP)
+		valid_ctrl |= GENMASK_U16(12, 7);
+
 	if (!config_acs_param || !valid_ctrl)
 		return;
 
@@ -999,10 +1002,23 @@ static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
 		return;
 	}
 
+	/*
+	 * DMAC/UMAC are 2-bit fields where encoding 0b11 is reserved. The
+	 * final value can land on 0b11 not only when the user enables both
+	 * bits, but also when they enable one bit, e.g. "1x", while fw_ctrl
+	 * already has the other set (e.g. "01").
+	 */
+	new_ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	if (FIELD_GET(PCI_ACS_DMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD ||
+	    FIELD_GET(PCI_ACS_UMAC_MASK, new_ctrl) == PCI_ACS_MAC_RSVD) {
+		pci_err(dev, "ACS DMAC/UMAC would be set to reserved value\n");
+		return;
+	}
+
 	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
 		enabled_bits, disabled_bits);
 
-	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+	caps->ctrl = new_ctrl;
 }
 
 /**
@@ -1024,6 +1040,16 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	/* Upstream Forwarding */
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
+	/*
+	 * Enable Unclaimed Request Redirect Control, I/O Request Blocking,
+	 * and Downstream and Upstream Port Memory Target Access Redirect.
+	 */
+	if (dev->acs_capabilities & PCI_ACS_ECAP) {
+		caps->ctrl |= PCI_ACS_URRC | PCI_ACS_IB;
+		FIELD_MODIFY(PCI_ACS_DMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+		FIELD_MODIFY(PCI_ACS_UMAC_MASK, &caps->ctrl, PCI_ACS_MAC_RR);
+	}
+
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..4cdb5954d183 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1016,6 +1016,7 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
+#define  PCI_ACS_ECAP		0x0080  /* ACS Enhanced Capability (CAP reg) */
 #define  PCI_ACS_SV		0x0001	/* Source Validation */
 #define  PCI_ACS_TB		0x0002	/* Translation Blocking */
 #define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
@@ -1023,10 +1024,22 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_IB		0x0080	/* I/O Request Blocking (CTRL reg) */
+#define  PCI_ACS_DMAC_MASK	0x0300  /* DSP Memory Target Access Control */
+#define  PCI_ACS_UMAC_MASK	0x0C00  /* USP Memory Target Access Control */
+#define  PCI_ACS_URRC		0x1000	/* Unclaimed Request Redirect Ctrl */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
 
+/* Encodings for DSP and USP Memory Target Access Control */
+enum {
+	PCI_ACS_MAC_DA   = 0x0,		/* Direct request access */
+	PCI_ACS_MAC_RB   = 0x1,		/* Request blocking */
+	PCI_ACS_MAC_RR   = 0x2,		/* Request redirect */
+	PCI_ACS_MAC_RSVD = 0x3,		/* Reserved */
+};
+
 /* SATA capability */
 #define PCI_SATA_REGS		4	/* SATA REGs specifier */
 #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
-- 
2.51.0

