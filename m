Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7238836A;
	Thu, 12 Mar 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306426; cv=fail; b=bZ56iSpptzoWc6yvqyl2ebH9u+o6gw2U2+l5MLcdmYTBXG57TAol9Z09Sd6cV7+WxhkAbg1kJ66rzl97tw9BVZGnOoMkWe3Do0q+10aNZg/8vUguTU79V3qVO620UAJ36D26bVn6Rsp3lSCX3/HlIOQ9IdrHiIFq1wRDEP5MTAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306426; c=relaxed/simple;
	bh=RMICRx6P1bcgnT2SDuNNETwdqoLtBpA0063L9syfF44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFABEHvXBCsctqjKMgtmJL5jbk6AqkAewE7XDRh4P0FtNDk0gB7qPj+lpNwFgoTQ+cXhojmLgsEHGxN+CdJVi1qh0I/EW845gWJqP6HLcXYFiIK79qwmOVubXlXd4cOZAx/X4w2dQhtGgH29KNqyD5aoz7kD2TujA8JNZfv48Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hD98bDgZ; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="hD98bDgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLYcLwmz6/1CtZmfr3L0zPPjZulJuQ6v2pV2YcjGqSD1C8/xAaJgXh1xs376kEDXyl1hb1bAwouTeTom4U5OfZFquFJeBxbCmeb0GxHHdCXoJZzX4QrhUo8k1+YocoFHBYHHucC0A1N8tLKer40MxOfSXt4RGsL6CPLIrsL0slKoJlAdp1cJ41xveWhk634Q5FmrifW8jKeEQi8t4sXikvl70sERUDIXBq63sII7a2ZyutUlvZ51EaldI5arTfEI1aCBYY79J+DCw2eVA2/nuALYjcmWTqtbfciesNEzsIKiGjiyrrHNEbMK3l5PTR9xInTi+SPd2TvhuvpYvGlZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3Z4WGlQPRE1sVOmlLJG2Ws+46+0OLlboZn8ROajzMw=;
 b=j15wd15JNREYWpvywb/JRTC1JSSk4gYtgL3fxF7rb2fyLzm9/M0JUWxvEZemYxWvYotvrtTp+84dV0KgCJV9rif4AQVpdH5+hB0c355jtbX06SwR5yvfdgBB0enTiH0xEo3EXLEskrJeh9EiUbnwd5dnPTitiihsvKwMwKEL8FuJNfwmJH24s6VJBfl2zPGoPdLfrDrWSczZV/06AzhG3b4mHo/dJ6ykVPTj1otVDhLTWljuOSVLb0/BC8PdggFwkSncmDAAYOz4eOMhFUCXRzYL6AIoL1itLWe6PC9Zm2xJk8A9vmGt9+C5reLK63l48k+5gVMWtIIyRUKni/h37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Z4WGlQPRE1sVOmlLJG2Ws+46+0OLlboZn8ROajzMw=;
 b=hD98bDgZvaD4xYtUIOsqahkNtTvfVrX2WpU6ODgKIGpIyPIvIMBeoybERQkRXnqVvdroXh42JWDfkMM7PTq/F2UPAwokzy42RwS7eZU15V9vDq8MNkdzzaDDkmn3wDhg6eUXaktlFW6xHNOv42SRp3vmOOnb/5bytynTFycUgjp0uW5EWlqQInTTP8PoP9yXnIgnCDGE0m3n4wsJrMPP/tKvb3rkpA/SjlaR0QuLul90uD5wDW3rI4KvQIpx1RJGTYu84Wjw4eNapaz6iEZlUmNSnqBGw8hwCqmV22Cd+M+rcsrNtQI0kg0JfqsSI0SMUJvGfMyGwiCRWXgilNz/0g==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:06:55 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:06:55 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Thu, 12 Mar 2026 17:06:33 +0800
Message-ID:
 <SEZPR01MB4399C75BE115DA5214014880DC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e10510c-0e64-4912-bf04-08de8016b496
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37011999003|5072599009|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXhFeDlTTWZWM3NyY3llUjdNcnB6aldSQTBPck41MnNwMVg4WkNJTEdOYzRF?=
 =?utf-8?B?dld2Y0UvY3dwWGh5dFhLeGZMc2NJNHBMMGhCa1kyVGhpSUgrQmV5RXA3Q3F5?=
 =?utf-8?B?SkZ1THQ4VnAvaWpFcldkSkVJMUNOVHc0eURzWGxnUkQrT3FTYXBXeDRONmxB?=
 =?utf-8?B?a1QvY052b3ZzeUJqb2VxMnZoZThZeWJQMTNoTit5UWdQTW1DZVpXTG1QaDdB?=
 =?utf-8?B?elozNDVaazBVMi9uYlR4RGt4bjhPYVI2NXkxZkNBd0l3WDBveGZHenBJVlNW?=
 =?utf-8?B?UTFYOGVTNWZMWlB0UEM4R1pyUndXcDI4MTNnOWVsZVlzdmpVTy85RzA4MlF3?=
 =?utf-8?B?S05tRVpXaU1USDBNOXgvMG1kMmcwT1R1TmQzSTNCMjJnTWt4aDNHMytjTVlw?=
 =?utf-8?B?b2l3dlVUZHJ3L3FLYUV6MkRGdkdQQjkxL3RjN0JIZE53WkVUakxFNW9NUEdq?=
 =?utf-8?B?NjlnamtaeWF3WXZHUk1uZG1LaG8vTmZCdE9PQW1KclJBb21nQ3RydENObmlD?=
 =?utf-8?B?VElkOEtvWXBvT3FCNVA3bE9jUmNHVnpQcjR2a0pFUVA4aTgwZHRHL1pDUVdN?=
 =?utf-8?B?RWQ4QW52K3pCenM3aGxLejhZQ2xQZmFmZzFNQWhLbWdScEh1YlQybWdRemRo?=
 =?utf-8?B?cEN1UWpKNGtraVVWUWpiN25XVHlOeS9FeDdUM1pNd1hmWjJDVFNoTDBnZkRP?=
 =?utf-8?B?ZUwxQlNSbnpaR0F0QTBrV1ZjaXpQaVBjUW83OFJob1F0eDNKYTExWDdlNkow?=
 =?utf-8?B?YjBtRHBCUEhBVnViYTBoNUpqa1M1WkxvQ1NjaUlMUXZvWE9RdVFvUnQyeEFp?=
 =?utf-8?B?T0MxNDJscXlYVVZTSFNlTjNIMmNJbUc3S2VvL1NWYmtiVUhxUTVGUTZEdGd6?=
 =?utf-8?B?TlhXLzJQYlVHVHhMUjlKNGZPY2ZwdXkzak1zaXhqZGRsRmZuZU1zU0lHZkhC?=
 =?utf-8?B?MHBadllEYmdxR2FkTmQ2b2FWS3RwRnE2bkpKVDdvU0xNcmFORWRmODBwenRO?=
 =?utf-8?B?N1pWeDlYbWdHRWNaTmt2WklyRTZwc3hYTThWdkNETVRvZDlkVWFsRVpkcXVP?=
 =?utf-8?B?eVpoN0ZKZmR0c0I4NmlweGFtZEJFcjdpQmRtL0tzR3lzc2N3Nmd3ZXUwZzNM?=
 =?utf-8?B?WkR3bTVyakMrRFR5L1FrVW5hejZkYXBhUHowVjVETHQrUldQeEVTVnI5US90?=
 =?utf-8?B?REVNSGV6QzlRcUlTcitrNmVkUlZDNnJTaDNvQlpRWFA3QmltdE5lelh1bU9r?=
 =?utf-8?B?L3ZTQlp0ekRuVU1halpNbE55dFBYVmNUcUxRYk5VdjA3RldXRkhZcjFrd0xJ?=
 =?utf-8?B?UnNBWjNZSkpERjJScjZLSyt0b1RmZUlCYWZxV3pSV3NqMjNLMEwxbUdRc01x?=
 =?utf-8?B?dHRMSGpKQzdGZzR6V212cFA5M3BPVmdOOUtvdks5K05PeW9JWDZ5eFVVMWJV?=
 =?utf-8?Q?Gysgm4E5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVlFM3lwSlVFR3JJblZ3czIvcm0wckFTR0NCRThMSVFVVlhNY2tSZ3RLei9j?=
 =?utf-8?B?Yzd4clhVM0pBdWEzVHYyK2ppanFiMFk0MFNlNHgyQStndSs4QXBxVWYvZVlO?=
 =?utf-8?B?VVFpV1J5UThDRzRMbm1JcThaVkxreHB0cVBkRThpY0I5YlZPOFlxNkVBY293?=
 =?utf-8?B?T091UmovOERDTVZxbjZxUzZmbWZjOHdJZ1UxMEhXYjdXdXlhZ0lzc3NjRDFm?=
 =?utf-8?B?aGN6QmVSTWxvU2xoQ3ljSU0xTnlJRElTVlIyaG9zbllzV0Q0enF0aE5xbHdE?=
 =?utf-8?B?N3pYMzExYnoxMUhPbW5ET0xjdlBrYlhoWUlFQUhaV0tzeUx6dUZiWjkrSUts?=
 =?utf-8?B?NWs1L29iTzBVcVVPYW13dkgycUtScUdQOHlSc2NaMHBIZHh6bG5qQ1RYdjRk?=
 =?utf-8?B?aTJabXlBM1JLTXFwWC9pVkMvTDZpQUVBRlB0RGQveEJuajdVb3FNb2Z4a1B0?=
 =?utf-8?B?dDNLOXduYVNnRzhwSHFNRng0NUQvaXU0ZnFZYTdLUWRETVFqbjBuUVk0NUR0?=
 =?utf-8?B?NG9RUlFyT1pTemhQVW85QUJBWEpRamJFa1BXem9jMWNPTnhsbXdWaGFTSWtW?=
 =?utf-8?B?RGdvcHNuaEFyaG9Ua0tDKzhPVU9tSTlKNlJJR0dFTVVBdC8vUXhHeHZxWWI2?=
 =?utf-8?B?K1dXTHRWYThGNVV6eG5GajJteFg3ekU5cDl4dGZaQldWL1ZzWmdkbHJ0Q1VR?=
 =?utf-8?B?c0NtZzFtRWhqNDMvZWVORENyeU5xeTVEdk0rVVNVTTJTeFNOaEp3U09uc2FI?=
 =?utf-8?B?ZExiUGlidi9LMlFyODlXYmxnNFFpNGNnQWRsT3FNZjRHZENXT1haWkx6enQz?=
 =?utf-8?B?WkpUS1kvZUMyRmFhWkZHcEh5S0RqTUtMRUtjZ1UzaGluZUhJTE82dHBnUGRs?=
 =?utf-8?B?bWZkbVQzSFZWOXdQNHhicmh3cUI5M0N0cTV3TWorMExnRldSSmlvalh3ZzdT?=
 =?utf-8?B?NmlGeFlheFRWVmFvUUFYN1NHZEtSVVJkRzBCbXZzcHRvTHpXRkVnMkhxZEZE?=
 =?utf-8?B?ZE9GR0hLTGJySkMrZFBlSTA5MHhhSXNMY3VhK08vbmNZU3FlNHJNQ0kvQ09h?=
 =?utf-8?B?eGpuUHpsZyt1MFYwdXIrbkR2R05DdXdHQ1VveTdqQ3hWMDlRNVRuVU5Td1lV?=
 =?utf-8?B?bFRNOEgwU1pHblhQYUpmQmJrby9ycXlzUzVIM2tVU2xSNEJwa2NSbDhCand3?=
 =?utf-8?B?dkMzb2tvV0dGcW42L01OVTRLWjlYbENHVFNBTTgrVC9nUFVOTThsNDdJalVE?=
 =?utf-8?B?N3ZzYXhNM2tTTUh1ZGZ5Kys4UCtqVmVLNzF6blQyUGkrS1RaVC90K0VxZC9U?=
 =?utf-8?B?ZTZRNWpxd25EeDZOR2ZsSmUzUThBRzZZcVFLc1NhZXVRK1Z5ZWVyZ3YzdTRT?=
 =?utf-8?B?Nk8zVUlRQXB5VVFFNmFVSXRBVmMzZHo0WjBkV1ZJdXNid3NlOEpJY25ZcWVG?=
 =?utf-8?B?KzUxWXJzb0dyTnpxSFR4NXk5Vit2blFZNkgxMXVwMXhMYU9oWXB5a3I5azJ6?=
 =?utf-8?B?TUlpUkpyVWtqZnc2RmNzQjVxU2s3YUQrRHJTZEo0emJPeXpEWERLd0ZtYm11?=
 =?utf-8?B?MCtqNStjQ2MzUlMvdkVOK1g4cUU0akhEMU5mQUx5KzgrUGUrWEJpSGFiYzhZ?=
 =?utf-8?B?YktZVUZGdDNpYkVva2tINC9LSjZESitGdnJmWVhSOWNOYUlmbUh1VVhWdUs1?=
 =?utf-8?B?VFd6L0RHWGpHa3dYRks3ZmNDdzIyUjNDeTRkQm8yZHowVVc3amF2cWN1Y2tD?=
 =?utf-8?B?MjgyazdHV1ZSRE5EVXFWOEFqa2hjcDZ6TmlHUW1xQ3pBT3ZpcXVEUFRyMHRp?=
 =?utf-8?B?RjNOSDJyQmpySDFSK1ZMY1dmRW02N0FJN2FtQkRPQmR6TCtVc2pJdjk2TU9M?=
 =?utf-8?Q?kdaWh2bbOF0Kp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e10510c-0e64-4912-bf04-08de8016b496
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:06:54.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

The config_acs parameter allows configuring ACS settings for multiple PCI
devices by separating entries with semicolons. The current documentation
only illustrates applying one configuration pattern to all devices, but
does not show how to specify multiple devices with different ACS settings
in a single parameter. Add an example demonstrating multi-device usage
with distinct ACS configurations.

Some bootloaders interpret ';' as a command separator, which can cause
the parameter to be split as multiple commands. Document that the entire
parameter may need to be quoted to avoid bootloader parsing issues. This
avoids confusing bootloader errors such as ‘can't find command <BDF>’
when passing multiple device entries.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 29e0053eb9a5..fe24e5cf4cd0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5320,15 +5320,20 @@ Kernel parameters
 				  '1' – force enabled
 				  'x' – unchanged
 				For example,
-				  pci=config_acs=10x@pci:0:0
+				- pci=config_acs=10x@pci:0:0
 				would configure all devices that support
 				ACS to enable P2P Request Redirect, disable
 				Translation Blocking, and leave Source
 				Validation unchanged from whatever power-up
 				or firmware set it to.
-
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+				- 'pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0'
+				configures two devices with different ACS settings.
+				Note: Some bootloaders interpret ';' as a command
+				separator. If so, quote the entire parameter to
+				ensure it is passed to the kernel unchanged.
+
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
-- 
2.51.0

