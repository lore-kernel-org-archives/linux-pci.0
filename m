Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A412329373;
	Wed, 21 Jan 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017258; cv=fail; b=p2OUZz+8qdCrNK+a9wjyXOqauVhsIikkI/GBXmHVAtY1K7KKaFmGpLd8svStP1ggDH7NBs6hLOO3QD+jr8itCTsV6Q7xTbn1KwiYs/uXH7kD23Yu361476hREtDRy9osBYXnYVHXyjkOFzhh7AnOFN/q5Jfb8SD2/vNGtM08hjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017258; c=relaxed/simple;
	bh=+k7Y4LLl1DLgIE9vIjXwIidOxlip4VOO53KxKgi8ZWc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IjMW3MAYWp9UR6DqhCEafMDdXpc6eRHC1s9aiJyB1uaX8owiks1ak4iBnRA716VwCoJtJohaFlu8IXDY3o70ZJxEOm+r0Vr9EdC3+LNGt+qDdM9U+PQsU5kjHW17kP/J1q0pkUhY6mXaNJ9kX6MLJXcxF3yQDyZViKl4PBUpE3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xISRPUd5; arc=fail smtp.client-ip=52.101.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xISRPUd5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQcXsh2FSVxyk04CJo8d2Jlk1UHcnaIhGkXwe21Xwob4nOUnLnDx9mvE7oNqyPA02tDr+cmQo+ptUzJo0meke1FnYBYVr7ueNSVAb3jpoY0LOYiZBPNSnGK+TyNHycp4zsQk8Cw3Xl288YS2n4HTuv8jTLPLCcU07XXOsTpbDQv7LKrjylyxxjoiGIs3/+XbqXhuOSM9cmwWRXQ0veSE8XL5rdI7I/Cj9cZhRS4v2wGDpCrub5S6iGp9mhBDMZCTYx4ObGGEVem3A6ca/f6iJs87EpkGDXopbycCQy+k/NxiN842MHy1SufZVi5UjA2MDNCqL1TtMIL6Qi8l592csg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvySG2AI6E7SMdq18B0cAXWds7p9vhLjd0Z8ES8eOwU=;
 b=eK8vYY1YEJrSUuwyj1ULI7ciRNEK0AYa+5QW9Hf7xFla+GHCc9sfp7j7Gf18dp0IEh/vz4UTzfor4e3SThJVis1Drf2IidIpWZF6l7aN7Z4aLuYRn+n3WAAe3mSQ8Zor2aVLkW9/1BlDGz+eIT1k4pol8/6iTtgOtR4itMxbt4CHIEovr52fVE7thMHJkPsU1PAg/pKT/atsRiOIurXky4SNaHkhdQotewihqjPkzxnJSU5shk15ktsmtLeWs3hyU92ZAXrhTsnkNv0rIqdnXSBydonUnBzbvdHmgf6hEChLc7AwcgKrdXcsgUIAyB6hRSbWQ5etpLCyVEqACJgTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvySG2AI6E7SMdq18B0cAXWds7p9vhLjd0Z8ES8eOwU=;
 b=xISRPUd5vuGCWr9kIjZmFKF9I2v7FlR1BeTIcZHFyWFHogGCSwAku5Xnlb4pWk4/iUjcCSPzLtnBbmwZaY0n0pBJGnNIa5hJMuk70cpyhdyUwz4AxVxzjipkl2hTAZaSZFQaBDOEu7yoPXO72/yR79HIYESRTbiGMo1pI/5iF24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8422.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:40:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:40:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 17:40:51 +0000
Message-Id: <DFUGA22OTLEJ.AV6MKVZUFLIL@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v11 4/5] rust: pci: add config space read/write support
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260121142355.4761-1-zhiw@nvidia.com>
 <20260121142355.4761-5-zhiw@nvidia.com>
 <DFUDN05YDH4W.1VXNXWWZST0C6@garyguo.net>
 <DFUFO3WUQL1K.3JH3SS0J1Y0CQ@kernel.org>
In-Reply-To: <DFUFO3WUQL1K.3JH3SS0J1Y0CQ@kernel.org>
X-ClientProxiedBy: LO4P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8407ee63-bfe1-4b34-a0c7-08de5914388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG83WnlIeXNQdnVUNnk5UEdBVUw3ZDJ3TDVPOUZsN3F4ZU9GbXlHVng2YzlX?=
 =?utf-8?B?U3lscU96d29ZelBPMnVLZWlPOU5TV1lNbGFSNjBLWCttWVc1MkVIYWtjZ2M4?=
 =?utf-8?B?QjZJQmJNeUJ6T0d6dFVyVFBVSU1ncDNOa0tIaEQ5R1NBTHpPekhUR3g5N2Zw?=
 =?utf-8?B?QXdwWlptWml5aC9ncnRSWFF2VXA1SXExVE1Da3MwREFLdFFnUmU3NENmbENV?=
 =?utf-8?B?aW5maFhKMG5XM093dzVFaHVrbGdIS09VWXVrVExoSzUrZ0g0c254MDBqY1Nr?=
 =?utf-8?B?ZmRPUzlGYjF2d2dublV0dzYxL3Z5Y081K3dyWmMyN1E0ZjdOTVpUWjFtUGFU?=
 =?utf-8?B?QXM0cXdwMFdtOUF6R0NETzlac2ovNS85MXFyT0J0YlJmb205alhpNjBtWTcz?=
 =?utf-8?B?bTRJeFNlNEI5cktkWFY0LzdXSUVZS3AzQ1hWWC9KRzlFSnpQSGlJL3BYdEJJ?=
 =?utf-8?B?cFBsYjhJbFJwalR4WjE0bUV2SmVRRzRMcTJXSlAvYTRHa2FvWUUvRXhGOFBR?=
 =?utf-8?B?cjlKSGRQaWJScE5BQXBQd25kY3VXbVhQcEVndVl5UHdYMU8zbzB0RTJPbmQ3?=
 =?utf-8?B?bHVHKy9rQllUL1JyVUUrYy85UHFoaFh2SHdFUHNQRGhOaTlwemI5QUMxUEh5?=
 =?utf-8?B?UXpqMTBYSE1Pd05XazlkK2pqMU80QlJmS2VYS2k5aEVKVkRJU2hSN1N3cWIz?=
 =?utf-8?B?a0VIUEVjT01BaGlVMExUV0d4a2Y3ZlVQT3NVdmJkdG0rVlY3b0FBQThibzlL?=
 =?utf-8?B?aUNZOEk0RGNaNWhIOGx4UjRqcWN3dFZibjFHK0ZOc01BYjgrZElkZUNmOGVi?=
 =?utf-8?B?SUtQdVRjaEI2MzEwV0VDUVJQSXFPZ0FJWUh4ZDlyZm5NbWUzZE1XU1RjS3VZ?=
 =?utf-8?B?azdXUGU1UTRtT0c2VmZSNUhQbVFMenJlbE4wSm9ESFF0Nm90ekNBSE1PbGZQ?=
 =?utf-8?B?MTBmd0hYOXNuVFdCTy9vSC9jeWlHbmtZZzJJS1I5Zy9nSjNxblA2SldqTW1D?=
 =?utf-8?B?MHdaVVhCMS9TZFhVcXpYSHRUeVRYM2tsc3BGT3JpV2pjVTI3ZXFPMHFNaG1v?=
 =?utf-8?B?WldRYlZCOXdqdk5NcVppcmU2Z3pxdGZyemZUY2lqcDh4WUVrdm5QQkpIVFBp?=
 =?utf-8?B?d3ozMHRRbUtxbGhRZ0RWUjdYcGsyRVorV1dBaGZhQWU1SzB3RVM0YlRkQWx6?=
 =?utf-8?B?bHAxNnB2WDJWaWVyRkE1azl6d2lOUU9jRkF5OGRtYWFZd1BnK2VHdjErWUli?=
 =?utf-8?B?NmJJa3N1SDgvZnNqaVNjQW95eGN1RVVWVjNMTVFQUDVya0FQMTZ2T0VpcFlP?=
 =?utf-8?B?aGl6U3lEc1UrRm9jb0s1cVRQb3Rvb1BLNFlJTW5KZE5jS0tsNFRTbXMwT3da?=
 =?utf-8?B?L1hOQlpPM1V3RlRCR2pOZVhZNUVyVlFOS25vOUUzckhLQ09abnQ5em1HbExX?=
 =?utf-8?B?RlpTcGpZWTRBRFFmYm80KzY1U0FabmJmWFNoTnBOWng2STJRQ0JYVDY1dEE2?=
 =?utf-8?B?dGxqY202QnFlblhRbVJHZU9WeTJSVnliRlB5MHJpRlduS3cxcmU4dmVwZjBJ?=
 =?utf-8?B?NmZrZzFoUXY4WDlpZUZWeWpSQ083WXd6WlUraVBqVHVLZXpBdDFJaGw5d3RI?=
 =?utf-8?B?bW90TTlEVXpoYSt4MHgwTWdIUmdUQmtWNEdFUTZFendpMGZVbGwzZVBtd1Z1?=
 =?utf-8?B?ejRjWjV4eDJKZlhJeVREZkJzODBDVW9CVUtxNXBtaU8yV2w5dkhraGJOZDlo?=
 =?utf-8?B?VkJrelEzajVvNzREeXcweHVXVzdnbWp0ejEzSlJpUjdrL2Z6b0prVnYxVFdG?=
 =?utf-8?B?VnNiOU1oSU1rbTNCRnJ5STBIbmlrdWtOL1ZqYjBHakl3ZEJDcFVRQU0zWlhm?=
 =?utf-8?B?aUsxeXAyd3FpcUhidFErUlhoUUFnSE9kTnppUWlsSVM3VE1tZmtWNEdsUnVC?=
 =?utf-8?B?ekk1NVJ6L3ZTbVArVE92Uk9wQ0ZxWFQ3VXovMWs4OW1LUkZLU1duU05wdklS?=
 =?utf-8?B?eVpnd2l4eVJ0aGt5elh2SUhTUXk4cHkva3pZaXFkSjd4anJHSVp3QXYxVFdC?=
 =?utf-8?B?dDRQWmM2aVRoT0pZbVBldzVrWlN4VFRueXRnTHN0WXE5SGtwMmxZMHB2UE1Y?=
 =?utf-8?Q?4JY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhmamFrYjU1N0dPcy9JbXRXMkF2WGJYYktBZjJOeXBoK3hMUExpbDM1MG9T?=
 =?utf-8?B?NVlzT3crRzhmYStqeTFRc1RTa1lrd1RDRUlscHIwUzZ1QWszMGRBZm1nc3Qx?=
 =?utf-8?B?L3N1Q3NUcXNFVzl5dWp2VVVUdk5zL3pxVUJpaVRLZWRDdXBKdzhpL2NRaytr?=
 =?utf-8?B?VWFYMnhOVit2VjV1cWdSYkpSSTYrREJrVFR5V0tOaUpwSTVCQ0JnejNIRDMw?=
 =?utf-8?B?aXBWTU8xd0JxQTVMa1loMXdabUFGLzVVa01aRHIzditzYytUemJ2NjlTZ21D?=
 =?utf-8?B?VGMwaUNWOXhIRDJuM1pPbGhWMXNMaXZiK21BZ2pGUjFlZlJtaFU0U0RVb3lC?=
 =?utf-8?B?YmwzVVIwRy9rQ3Jyclc2MXB4WStlUjFXS3B4L3hITmhTQVRGQTNjamVVQzg0?=
 =?utf-8?B?U3RVbWdKdWpQMDNTWFJlYldSUi9yV0tac3RqNGdubjVLUjhmVmUvMldlVUgv?=
 =?utf-8?B?ZkNSa0tURDF5QisydklMNUtFT3M4U3Y4R3BsbkQ2cnNuNkdlRXowWHdDbnZ6?=
 =?utf-8?B?eTdCZWNEeUVtb3RDMFpKaGJjeFR2eUYyVG9uZ1JZOGN2bXd2UksxbmpiMUYy?=
 =?utf-8?B?WW1ZOXA4VXQ2V0MwbTlNTXZmTTNYUkZZWnRheklrT0plODhnNzVwdUlSVjdO?=
 =?utf-8?B?RHduRlg1K1pLY3NEQ0NVSUkyT0VZU3MwRUpmeWRRWFJrMFR2N1Z5WWd2K2Fu?=
 =?utf-8?B?bnJHUDZTQlgwWURhQWRwV0Y2YXdCSEVia2RiNVBzZ050V2R5OXFLZFlXK0RZ?=
 =?utf-8?B?NnlmSnpra2grMzVhc3R4TlY5WEsybTNyT055ZU94WE5YRnQrUFBPV3lyU1N5?=
 =?utf-8?B?TTh3TWRPdm9BbXAxeGJSNlZRa0dBcFlSSldWZ2JkNEZnb3Z6aEY3UkxDN0tY?=
 =?utf-8?B?TWJnUElWRlhPRjBpUWE2NGtsd1lHSlhxMDUvc2h2ak0yUE9QbEpjYzFTL0FY?=
 =?utf-8?B?dStRb1A4QXhoZzFTTG0rUi9LU3dEZFRrQWtBVlBkZXZZdkVoMzlGZk1neFNt?=
 =?utf-8?B?VGdaUXAydWF0SWs3bSthTTA5a2tqRzlVVzluK0ZHTjNTMkU3QTJWWUZjaFlR?=
 =?utf-8?B?ck05TlZpeDZMQnIrNndnZVZ0ZEZ5dmdMTzZWYjNYcXVuendncXMwOTE4b1Bs?=
 =?utf-8?B?dWwrWFVuVmloMjBta2Z2VzJxVnF4WUZRcitRS2I3TVhtL0E1TW9SVDFIRS9l?=
 =?utf-8?B?Mm0ybklGYVowMUFxbXJ6MjlOcnlHeW5tQjJ1dDBxdyt1NWtJa0Q1Y3l6MTJR?=
 =?utf-8?B?SVpFbWJrMU5VMDZaS1I3dnJ4UDQ5RUx0bUFrODN6ZmNhYWc0Z2NLTy9lL3lP?=
 =?utf-8?B?RHg4cHhRVHlmYlV2WnR2aE9CRjY5OVRYYzBtNVE1d3VrcGlXRDNkTTJ4UGhx?=
 =?utf-8?B?dkFNRVRwNlVhd1ArRFJuRm42NjYyV1JpRG9sZ2xCdjEvNDVpY2VpckxEUEF5?=
 =?utf-8?B?M0RlMk9UejBIbEdyN2NCZHJFWEhoNUN2bHRKb3VjSFBFeW9RS3luWi9lSXll?=
 =?utf-8?B?dlVQcllmUlJFL2lRdHBMZFRGNmtheGFQSDdzQmFvRFl5K01FclRuZW1RUU1h?=
 =?utf-8?B?SEI4VzZqdXFmZ0thdnVQTWVKNndFYWMrT3Uvak9jS2ZHT0lRajkwcVNlQms5?=
 =?utf-8?B?OUVVOThpcHBaZ2VsT0kvMldZbENqVWxmRHI2Q0VOM045ZExpYys5T2J4cTRr?=
 =?utf-8?B?QjJjdGNXNnhSS25MTmgxam1qNXlheFF4RzdPdzNFblF5VGlPZ2F0dVFSOFlt?=
 =?utf-8?B?ajRtd2VLNGRjVmFXaU9JSmlqcFgrYkE5ZU81TmVFMmNLdzZ6VEovd2p5VlZ6?=
 =?utf-8?B?NGFpdWZkejZHUTJwQUY1ajJ4N3BXN3hBU2U1T1BtSjJwWHpqNjhvSENQaDlP?=
 =?utf-8?B?QTNEWU9HK2hlZW5RL1RDTzFOS1IwbFdBWmV0Yk90eTRCK2RYQm8vTWQ0RXZJ?=
 =?utf-8?B?dDR2UnBwNnVNSFUva1BIRkM3Y1NiSHRsaTgvSFZnMUZ2OXV2bzZmKzJOZ0RB?=
 =?utf-8?B?OFFURWxJU21UN3Faa2YwOUlMditzMFpPL28xditLNldydDJEZDVnMUR1eCsw?=
 =?utf-8?B?UDQ3WEJqQzl1SjRCS1p6S2pUUm16cC9za2dqTE9qQ0hvRVIwdmJsRm5xeGVs?=
 =?utf-8?B?d3FjWCtoNVNYWmJKVkVkL2hBQVZqRXE2ekdibUp1VVBpVHBnSERSemFQZkFW?=
 =?utf-8?B?bTdnOHViV0V4S2s2WG53ZXpBVUpsZy9LNTk0Y2lLR0FuZXVpQU9ycEk2K1hw?=
 =?utf-8?B?cDg0ZnkwNjZOZkxQV21SNHM2NGwrNmRyakFsckRWNVg5ZkFkTjNFT0xNQnpx?=
 =?utf-8?B?WUtpVlNtQ3g1MngwUVY5VGt4Z25TTEk4eHRKcFNrTHVaWDcrNnl3Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8407ee63-bfe1-4b34-a0c7-08de5914388f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:40:51.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9hDB7NAh9ML6cPO2MEoixybZcaz2E31clqedQ40MnDzHofVTrXkxF/CD9o5VEgeX+rEg3jfO1X/g95DKMDqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8422

On Wed Jan 21, 2026 at 5:12 PM GMT, Danilo Krummrich wrote:
> On Wed Jan 21, 2026 at 4:36 PM CET, Gary Guo wrote:
>>> +/// The PCI configuration space of a device.
>>> +///
>>> +/// Provides typed read and write accessors for configuration register=
s
>>> +/// using the standard `pci_read_config_*` and `pci_write_config_*` he=
lpers.
>>> +///
>>> +/// The generic const parameter `SIZE` can be used to indicate the
>>> +/// maximum size of the configuration space (e.g. `ConfigSpaceSize::No=
rmal`
>>> +/// or `ConfigSpaceSize::Extended`).
>>> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Ex=
tended as usize }> {
>>
>> This is quite long to write. Given that it'll either be normal or extend=
ed, can
>> we just have two marker types instead? So you have
>>
>>     ConfigSpace<Normal> and ConfigSpace<Extended>
>
> I think in practice users don't have the need to write it anyways. You'd =
access
> the config space with either
>
> 	let config =3D pdev.config_space()?;
>
> or
>
> 	let config =3D pdev.config_space_extended()?;
>

I suspect when they need to write it, they'll just write `ConfigSpace<256>`
which'll be accepted by the compiler.

Also I don't see why we wouldn't want this to use types to begin with, even=
 if
in practice users don't need to write out the type names.

Best,
Gary

> i.e. there is no need to store an instance of the struct anywhere.
>
> Should it turn out that we do need it for some reason in the future we ca=
n do
> this as follow-up, I think.

