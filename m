Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA2376463;
	Mon,  2 Feb 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044560; cv=fail; b=eD5979H7DmObMM7b5qpNV/4UX5EodhWf54KBoFi7vqu0qwp+1mFEH+3YMWnWWBnAHDmcGaUevyIWDT0sfF1hv4mTUCrrRAcX6NFGeFvQGVkeJG8bAWfmaxzRw18t5X/zOFCI/9Mnzhwic5cXKEVpOj0P84fmthQW0Ddi1RHQw0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044560; c=relaxed/simple;
	bh=VqNPZN7tkrplUCAeBZHCTE3wy6kYcyndIl0pOyHMVlc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=h1pcb7zFfbSdO8lsYFYlwdA14DcaIK4SfFqDKQSXjhKTRo0eoV2rmmSDk4bgxjW/H4Xo7GfXnkDHeSulwCD4eZISi7FW9mkyTyiNnIRxO/4UdrFHcDKQCU4jEt57zuIlsinnd+3RnpW5EBGtBgtnx07G2aU6lZCAWr5F1JteeKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=q68ScTIb; arc=fail smtp.client-ip=52.101.195.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="q68ScTIb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAthkrxrStASsQfFs24uBVKLzyizuksbWW/pnuEGObEAxc6br4slEy4gsTF35KKkK6wsbOtSL6ADU+uCKe6WARF4ho4QMjHYq7Nbn7+GwHTcY1vco070inXRKvcYMz7gI2Y/dQCCrL3X1NUv9EeEfvVDBIFylXo58jbHvi4qh5Si3UrvcG0tlw3fbHiiYIfCJXQ1NFJPERNza187V5qV5g378nyLJywwDHwImePIhGmVRygURqFhQa+noiJavThRAzEEEcgx8ZcWkmUqAt7sV/XFuF8EfGx0DY/rY2jHo7mzNNt/kiFaH/+GpujuotjvCbkJXOhDkG4UaWWaOrzxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1OC2BcFcehxojGk0goPcYnKyCOoRkV57C5L6dCOZOY=;
 b=X0DY0Xw8U3k0xVfNycVG/w4k1dPelOOnM9F3f9JOd8Lwmtw1SOJIFuGPa4/oL1tx+QsK1f7+tacYxXrwH0MsnCcyi/Xx1b1QlhBDHFvRFHVRu+rSleKeVTtv0ZCCzQCaHF8rXPIp9k1ZetH0AG01HAHxUCFcGj8O5oMtUHmMSKXbrAYLh0qJRmBXxogJj+4mwtVEqtc/Egvw4XJ2i7omrNla0zSefqISZb7UzA79j0s4XcHqCzO/yHAZda2WcjJIyfUxDIBc/5+bbfbwCxyd/sf+CN9JAZM7RAjvQ1CfeenRTk7Bzd2rAGNEDE3cG77DJGJ2YxXct1Olg5Da8yLPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1OC2BcFcehxojGk0goPcYnKyCOoRkV57C5L6dCOZOY=;
 b=q68ScTIbKhAtEZRYDCCzyN9jvIU+SlFjc/bep0BL0Lrs2/ApmXZBfsO3eJ+l7wpZ9J2lCecAvfUhaRe7ZONl5ZuGugBSq6E74bIOEuyzq09vbESuWQLHBR8oGwQ0BnxNsrqhtiuqfWGWjH2xgMyKdAcxxqsBxs78DBYudIkk7Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:02:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:02:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 15:02:32 +0000
Message-Id: <DG4KFDZNRSYS.28570B2QPH28E@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <gary@garyguo.net>, <dirk.behme@gmail.com>, <lianux.mm@gmail.com>
Subject: Re: [PATCH v5 0/2] rust: pci: add capability lookup helpers
From: "Gary Guo" <gary@garyguo.net>
To: "Zijing Zhang" <zijing.zhang@ry.rs>, <dakr@kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
In-Reply-To: <20260201074248.1629393-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: LO2P265CA0502.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bffab6f-8357-4ef3-5b75-08de626c1823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEI0UG51QWdoYnRlTmphNVRuNVJDMFBkNFpGeE9kRTc3Q3haVll1MGxjdFlR?=
 =?utf-8?B?emdFWEg2UkN6Qk05YzRpVkNDUU5WVU1QbjBJUUJmWjV0YTJvQmRTaDI1Zm5z?=
 =?utf-8?B?TFZoQlVTUjlzMFNDVkI3bGRUOGhJRlN4d243Z1Z3VVBwNGJZYVpBaXVCaGc4?=
 =?utf-8?B?MjhoaW5kdFIzS0lvTmt2aU44L24yQUR6aVVLWXJBNWpLZzZCc1lmZDg2ZGJy?=
 =?utf-8?B?aW92Z0V3NkhjWEc1b2VzSy9GY05hTEl0R2gwbmNKclJ1VFJ3NmN4cVBGQndu?=
 =?utf-8?B?SEtkcVJ3Nm9nNUlGNUd3OXVLb3g4UVplVVEzNDhhYWtuYmJHT2ZMUHZlT0NT?=
 =?utf-8?B?NVp2Y3FLdTRoVnhNSUJ6dEZPR0YyWStWdVFDYXAyN255WGNtMVdSdUJSajdP?=
 =?utf-8?B?L2VhSmdoblZvMWd3OWc0dHNLcTRGdHJqQlpSd3ExS2lRbm5BM05CUVpKS0wr?=
 =?utf-8?B?ancxUk4vZWVCMzQzR3A0T0lmL1piSVB5ckJvbG82WE55cnhZS0IwVU0xakhB?=
 =?utf-8?B?N2pRNEErbHMwY09Nbmdxdm5kZ21iZGw1NVNqMEgyazFjcURvRitVSFlQQVIy?=
 =?utf-8?B?bFk4OWMyV3M5OFRWenJlTDhwTEE3TVRoU09ab3FYODdQeHgxZy92blo3L0N2?=
 =?utf-8?B?RHVveERuUHdQSzFMRkFtbGo0YlZvR041QnJyaUlmTGYvNElsY0lOelJXYWl2?=
 =?utf-8?B?djZ0ajRuclJPMzRtSEZ1dVRvVWJLTTkrWGdKSjNSYU9oc3FqdXFiM0JxMDVR?=
 =?utf-8?B?b0JqT1NJaTd1bE1WUlZ0NmRQQmpZTXhuN2xwSEhrdXArNGVsekJudFAyTGRv?=
 =?utf-8?B?SCtkU2Q5bTgvUTN1eHRrSm9jb2swOUZTYmNSUFE4bURwai9DdXVHam5yY3Zo?=
 =?utf-8?B?UTdLcUUxaWFHdVdqb3ozTllsV0JxMUZpYlR3WWZaU3I3SlR3WGhtK1IwbTZj?=
 =?utf-8?B?bWgwb0tyRHlpSDVRamkzYTJDVDlXaUZUVXoyOFl1TDhvT2lvYUZ5WWxOMTY2?=
 =?utf-8?B?cS9yNmxreXdlK3dXeFBHVlhXMDJEVlVvRTFrZ01TSjdKNmQyNmhKL0JLa2to?=
 =?utf-8?B?VGsrakhLWjJQR0tIN2M5bW5ORVgyZ0RCL1FtSEZkUEU5aHBCckZCMWk0TEZs?=
 =?utf-8?B?N2RHb3FzNjNQKytXRkNoalFsNWhNNDlkWEJKUWRyck5Jem1vRDdzTjdST1pq?=
 =?utf-8?B?Z2xDT3NodUZXN3VWSjl6M2FFWFRuaVJoR2VnMGFmZ1MwMkl2eW1WNVdDQmZG?=
 =?utf-8?B?U01HNUU4a3E2RVhKQjgxRnNMK2ovdE9kTVZGNHY2Y2h5WE9xb05neUkvaGV5?=
 =?utf-8?B?RHFqVzhRQTVGcUVIc1JicnNtK0lBLysyV3pmT0hDMXhaeVZzeWk2bzEwbXJx?=
 =?utf-8?B?MTRhS2ZkUFlkRWRWTXRhWkxFdzZhcGdma1MwZ2wvQlhPZmo0b2c5MWpRcnI1?=
 =?utf-8?B?clF3WUNiZGMzaERHMTNMbG9FaGZ1TE9pemVwcEVMM1FpVlozZUtocHY0cGZG?=
 =?utf-8?B?QTQ5cGF4Smc2ZmY5SEovTEdyVDVobHBMNGRMdkxpS1B6WVhSam5MMThNR1B4?=
 =?utf-8?B?Z2t1MldRQnVsUU45N0QxRi9SdytPVG5OMDZsUUhDL3FzRis3d0p2YTQxWEJj?=
 =?utf-8?B?enRvWlBVc1MwSGc3VFN1UmlPQ3UwaGNRTVA4Yy9lRmFBMTNoM3NnbWlFQ2dx?=
 =?utf-8?B?NEVzY1N5MGV4Nm5FdjZVTVVYRHRtYVl6ME9oSnpXUUVpZU5DSDNUdmh4djhQ?=
 =?utf-8?B?WWFzU2Q5Qm5tcS84TVdUV21CaGRMVVl3aHdVVW5UVlFkNGNtZEVwRCtjNmIx?=
 =?utf-8?B?eXpWQkFLc3YrSkxYeHRqZlJobUVtN1k4QmN2WkgzLzhSdGYrRnBDSkdZQ0Nu?=
 =?utf-8?B?V1UydFJuVW8vSUMrSExtVW5pRkhGOXphekZnRmhzVEZrTHkyckdqL1p1dFdK?=
 =?utf-8?B?Qy9RSDJJcG1Ra3NUOFh5U0s4KytmdHJxQnVJbW9YUCtZZ2wwRUJ1T1RWR2JM?=
 =?utf-8?B?b0FoYlFVb3lNNlB5dmFmSkc2ZTBLaEc4VnVDOTYwVVNZZGdXenBMVUtNcGdT?=
 =?utf-8?B?VGZyelpDT3JFYUJRV3VLYXUvcjF6ZWJmNTdPcWlpUUtnUmh4Z0FvNkI1NFlr?=
 =?utf-8?Q?1HWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODltak5ySEpuM2haczhXTC9GTmRCUkNHbUZiejhuR1JGK2pSQW5TV3NqRU9n?=
 =?utf-8?B?dm5JVmU2OFAzT2Izem5Tais2QzYyTVJkdDQxNzNKVVlBRHVhQThHUi9zeDJI?=
 =?utf-8?B?L0JsYXlIZnhFL3ZTblVUZmQ0Qi94VmhoOW12elFRc3liQUJCZ0M5UHlIY1Zk?=
 =?utf-8?B?QkJ1dXZnSU9uVDhzZlozZzV6T3UybCsvL0EySmxlTTk2bHJnNmNzUXE4RExt?=
 =?utf-8?B?anBBZ3RDcjhrVHpweWN3UXJOTVdBUkNpOUhsRVZMRXRLcHpESHZSdmVVRGxq?=
 =?utf-8?B?ZnUvdVhJdlpObFNKRnByOUwydVFteGdPNjJJckhSUHl1RnEyUEJvcEVaUWRF?=
 =?utf-8?B?aGFjQWJKU2xvYlF4b2RGOVg5b0VlOFk2cnFBRkRzaG1DYmlQeUJQbXdUU2d4?=
 =?utf-8?B?aHRFL2pZNW5kUnRuMHpYSVFQanFRRHJoa1M2ekp4Qjg0R3NRdHlHSFY3T3Yr?=
 =?utf-8?B?MUd4bmdjWGVLMFZaWUVXWGdjTW05K2lRRUNnYkY1czdzaTdwVGlDUTlrNlZD?=
 =?utf-8?B?VlZIaEZWWms1YmFxcXBTYWxXL2gzS3I2eWdKaThic2NpUmdtYUxTUlAwQUtH?=
 =?utf-8?B?LzNpcFVaSTdqckZDRXdFWktUdUc3L0p0V3ZldkQwWXRhTzFpa3VnVUR6N3du?=
 =?utf-8?B?aEVDYmUwQlA4KzNVNHlvK09oaGRhQ0p1cWFGV0RveTMwaHA5OG5yRkl6TzZv?=
 =?utf-8?B?VklST3JIOE04ZHBzWFA0em1GTlkyVWNqMTZrZHJpZE0zOGlPYm8xZDFiWXhI?=
 =?utf-8?B?aER5SVRqUlN5ZUIwMlpxUjF5ODhVMHQ3OGxMeU9xS0tiZXdSRVF3WEQrNklq?=
 =?utf-8?B?T1Y2TS80RE8wc2FYU3plZEpLTm5NbnJmeUVXak44c1lrQVZFUUZuQzlaQ2t0?=
 =?utf-8?B?dlpXQXNvQkhMeEFQN3lvZXhXcnJidXZKK2tGVzQ4WmFEN2VxaFV1dXlpRTZX?=
 =?utf-8?B?dHljYTVtajZ3bmQ3QnAyamRDM1IyUW9pbnhsRXZRaVBOdG1hMXplSEdVeHFT?=
 =?utf-8?B?d1pWbE5MMHVTdlpCemltdVRqMlBsdDRBUGRLNS85R3VuYjFoK01iRlVKWFNM?=
 =?utf-8?B?eU4xc0grczRkRDBSVW5veEpOcTFCV2JVdi9Pa3lDUEtuL1lqK0xzMS8wSlZa?=
 =?utf-8?B?dW1XMVQ5TlRzK2IyZk9GYnlCZjZrdjlyc3dtWFRoQlNFcDlBQXo4d3FpTjAx?=
 =?utf-8?B?WGtQYlZXWUV1UlZORFJPL2dYeSsyTXhqUnhGOTBUOGptUTdmdmd3Z0VWTEtW?=
 =?utf-8?B?Yk5IaDlYQlhkMkVKNTFXRUd0ZVpleEd5dnNyYW14NnNOWmFzVGNjdS8yRTU1?=
 =?utf-8?B?TEczQ3M2dlpyRGZiM0poN2IwMVViTmRHOUI2a093dzA0WGNMQkNCY3R5UmdJ?=
 =?utf-8?B?VzdLeEFkeFZOWXVvTStwRVV4ZnZvT1RzUTNabEtWOGQ1bVFCcnNLaVQ5aWRW?=
 =?utf-8?B?Z05GU0FVcC9QeFNEcXFDK1lwMlA4OUpad1pWeW1UU29hZ0VRZXRRYms1WEI2?=
 =?utf-8?B?MDNmWUpuZjVQWWNBYXFqOVZlcWE0SGdBNFczY2hjRE9OUlh2VExhYmFrSko3?=
 =?utf-8?B?TjN4K2tnTjJNNFpDMkJOKzV3cXJoemttWlp2MUpVbEFQdjR0RWp2R1JnUHZY?=
 =?utf-8?B?djhIYlRYY1dBTWpnQ3ZwRCtqVnNTb1dBaHBXdkViMXJvVjZvc1ljQVM5Nm9J?=
 =?utf-8?B?aHZDSEN1WnhyRER5djZkZGZvYlJPLzYzelB3THhSdHpwL0RXRWhhVHdxRnNW?=
 =?utf-8?B?ZXYycUhIMEg3bWx0M0JmWDZDWmpDVU00TWlSU0VnZnVsczRoQm1QZ05LZGJz?=
 =?utf-8?B?dTFKY243NHVnWU9qV08yREVEdHNCZ0grYmZQWU4yOEdaTWsyUzhtMUhxUTND?=
 =?utf-8?B?MTgxNzVmUjBpMFR0WVZlUnlxSnFLU0hhMW9XWS9hVzMxdlZTSnFqeTdZMEZZ?=
 =?utf-8?B?dkQwZ1NSS3BvZFozUUZYZG5JSVBSak5ZZ3pBNHpRelBRdU5jZDRwY3JnOGVi?=
 =?utf-8?B?QSsyVnA2MGxnN0o2SUUyOUlUTVNmRG9veFk0UDZoZFRLcGJLblFwaWg3ZmFP?=
 =?utf-8?B?T3F3Ym5zblBVM2R1b2ZwZUZFQ2haUTNHMnFGVUFpdEFNVzViOTlXTk9lbDJi?=
 =?utf-8?B?WW5xeU9uNXRVampCYks0ZVdldXJBZ0tyUllPTjFvNE43YVIxZm1FYXUzVWd6?=
 =?utf-8?B?ckp2NXNmRklEekd6TERTbHJ6S2xrK0s0Z2dRMG1PcGJOZDZnb3J5OFlBRW1V?=
 =?utf-8?B?R3BxWUoyY1dQelZrUTY5U1FuWXpRcDBib0NxNVFqYW0zQ1BJVTFOUW1jT3RW?=
 =?utf-8?B?OENqU0paYTJaTi9oSGlDUmo2Vk04bENBTXovMHNlYjVBZ21zdnYzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bffab6f-8357-4ef3-5b75-08de626c1823
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:02:33.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWKtI80H29d8cqoToi4Kc5A8c2lAvQk2f2b9tflq2XpqGYvvx7ou1s2lSmfRBRFppjsm3QrcvcCtf4VT6JfcMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
> It introduces `pci::Device::{find_capability, find_ext_capability}`, thin=
=20
> wrappers around the PCI core helpers (`pci_find_capability()` and=20
> `pci_find_ext_capability()`), returning the config-space offset when pres=
ent.
>
> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability IDs a=
re=20
> wrapped as newtypes with `from_raw()` plus a set of common constants.
>
> An in-tree user is added to Rust PCI driver sample to exercise the new AP=
I.
>
> Previous versions (v4)
> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zh=
ang@ry.rs/

Also I'd like to mention that Zhi Wang already have a version adding the sa=
me
feature on the list, sent before your v1:

https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.=
com/

I'd recommend to work together for the feature rather than creating competi=
ng
series.

Thanks,
Gary

>
> Testing
> ---
>
> Build
> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
> - `CONFIG_SAMPLES_RUST=3Dy`
> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=3Dy`
>
> Runtime
> - QEMU x86_64 (i440FX) with `-device pci-testdev`
> - QEMU x86_64 (q35) with an NVMe device
>
> Changelog
> ---
>
> v2
> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
>
> v3
> - Base on pci/next.
> - Add `CapabilityId`/`ExtendedCapabilityId`, switch `find_*capability()`
>   to use them.
> - Document the common ID constants.
> - Update the sample to use typed IDs and exercise the new helpers.
>
> v4
> - Minor doc/style nits.
> - Use early-return style in `find_*capability()`.
>
>
> v5 (current)
> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
> - Use `as _` in constant definitions.
>
> Zijing Zhang (2):
>   rust: pci: add capability lookup helpers
>   samples: rust: pci: exercise capability lookup
>
>  rust/kernel/pci.rs              | 150 ++++++++++++++++++++++++++++++++
>  samples/rust/rust_driver_pci.rs |  31 +++++++
>  2 files changed, 181 insertions(+)
>
>
> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba

