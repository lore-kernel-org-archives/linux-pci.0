Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547A2FB09A;
	Fri,  6 Feb 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357654; cv=fail; b=cguudcfJNTpnMq8NgFXWlUwQ2224HO9M/+A3eyWE+hKCVQBoWyD+ZN9NsKV0aI2FSnMzxtDjtbi+oCzBHjKXBMDDTbhKdMppHjP0uAeV/nQ2RK0wibzS6NaBZsI62IWrCRrjk/TdeFJTz6tk+4Z2mS//2rw8A0N/V2yyAWewApA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357654; c=relaxed/simple;
	bh=R+5l7bpHYh9jHoKFRUVXjwwR8pQkL2OXYMfu146wPsU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hjOiAHMFqJ2Y6sq2nXGRmkEZ+H8FPS1Lct4bW9ierv/QNXvduzGgCYsO+06ptA/1mo6KaWuyTkxsE5G8u5zSJkwVSiDUjsPHG7qmjos1iz4RoshKbGTMs/rtfpadSwmaZ2xgt8uDxk5er1Acmx7zWq4uLWj6Y7dAXFlz8Igrpkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LL5kA4Al; arc=fail smtp.client-ip=52.101.56.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LL5kA4Al"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUvzB6CyR+HJ0JkmJpYk05zqO+Ix0BHwYXmo+AyLA1YqtjrfCvrl67FcxsD1YuFm29NDduxgG/k1b6Q2C46izvpJcxW89I2lIKaIV9frw6IVqZU8tiZtx3NZN9c2ZM/4bnEWB9Y818Wi5KAl9VcCSNYy4vwqfjkdNEDYH3Vxq5VeB+uiDUqqSVhqxcX8uTCCBBSXI5DCjXdLN3KgcBYPVPrxT4HyLRbx+ShFAhfPwStwdMKeNbgZchNCmwhPAaBM6gkv3jn9HcxCsobjvrRxG97XQQhSRlikx5xwkl2D6/6oWeYHAQo+kV5NaCneBrZ/4+f7fXUPAmXppK3haK0dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pfpkPcRSLa/ShPSWfQA7B6ZOYH1bsb+WzPjcKNYscA=;
 b=T/Ft4gtbInrE7VK4ldJOl7gtTlHFzl5c0+z5tAi/7JkbMNioIjb/htLot0njfw8iJktkcPLNh9qaS/A9tFMug//KMNVgEgfJ4VP7gJONYbNj6XUgiec/LutP2R2/ahD34wXCap0+cL+BWa9DvxcTga29+M61GyEDOgEnNioruPTv5306Y9OY+b19kyefNR1z9N3agEMdZbZ2Y+tEkR6YTJlnrnERyFiGaBHlesx17mmet4++bfzV6fHEgFsE0wGlTJq61FJHOrh3JCGzJ5ErtFipOjSu8u//5H0vYWO2+LlcNCFlDB5Y4aO4w5J+GWYn4c9s9HaSEPoSCUo4HVnWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pfpkPcRSLa/ShPSWfQA7B6ZOYH1bsb+WzPjcKNYscA=;
 b=LL5kA4AlxAmHAzhoquE6Oo9Pb+Fl4r5FLTQOL6bs08E8yEgRdT0wprFlWphXa0L5jZURb2cz/o7dSV5mZxwAFwrTPUHl4wMZJoQ7tJBwsNL+3l9M+F5eB3t86UQPXnDWp4tckDwxhRN40/Kws+kymGBembie0/OKiF4CTwaXsyhhWhqvilEudHxMoeAKlCkOl05IhA1M7iHwYO65U+mexwukPG1jUO7+/BHxjUhfri58YQ4eMSf6sNvu0bo2a071xV75cpJHDvB5tMBVUQ/ECW4Vasd2w6d4E24d+Pm52B82efCgoCy6aUmea+7NyCMG5lS6mZ0y7Im/r6SMCrqTKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:19 +0900
Subject: [PATCH v2 5/6] rust: pci: io: remove overloaded Io methods of
 ConfigSpace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260206-io-v2-5-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OSTPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c26a1e-6348-4ef5-d8b2-08de654513ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yzdnc29hS2xiV0tSSWdJb3A1ZWlnUXRZOHZ0bFVDK3Z4dnZwV2dLVXFZaE1l?=
 =?utf-8?B?UG5pS3M2ZUd2VlF2WGIzNnV3K0labDVlSWRmSFY2U3h3WjRGSHlVYVFVeGpV?=
 =?utf-8?B?Q1hHQkJoWFdDdnBuOUJ4SS9PZ2lXNE9CREVSN1dRdFVXejJLYk85c1Zpa2pn?=
 =?utf-8?B?bXNKdUtMaTl2V2ZUbUhWVGhkQVBiOVh4VWgrTkc4T3JKMmpaL1RNdWRvdkF0?=
 =?utf-8?B?UzFyVi80N3VacE1palJNR1ArV2VnSFhvU0puUS8xcGRmYVNQY3A0QmdyN0NT?=
 =?utf-8?B?MlFxTVdxUGZnTHBISWJsazdTZ1ZNU0ZXbjZPVTFlOE50RUpFaEVtbndMWm94?=
 =?utf-8?B?bzZ4UElZaUVQZGNsN2dIUWIyMHF3TVpKSVI4cEplTklDQjVMZ2xoWHAzOUJw?=
 =?utf-8?B?bWNmeXFOK2VIbTB6c2U5OXlMQlM0djB0a1VSY3RPYkk5WHkzcS9HdFAyTUZx?=
 =?utf-8?B?M1lDRVNJbWw1dG80QXVFNVJ1b3I3bjNwZ0tLTWtwOTV6dkR1OWdpS1lTckpk?=
 =?utf-8?B?aTFURzZsd2tpSzZmbE1DdUQzR1IzdmZ4ZGlXOHdndy9OR1pxaGwvNG9xZWZs?=
 =?utf-8?B?OW5zOStRUk5nQjE1Y3J4VXAyaSszZ2FscitwY3VZeVVyVkRkTGF6NXdPNDMr?=
 =?utf-8?B?NmpVT2ErSmZTd0ZLelVRS2s1cCtuNDc1SzJCa24yVStkS3czbllxSEoyZkJ4?=
 =?utf-8?B?Zms1RXA0Z3drV3o3STNmdTM4YTdYYmNadTFpSURaeTg5VGV4Q2VIeFhabFdR?=
 =?utf-8?B?S2h6Vmg3NVo0R3dXV1B1LzdlOHJ0ODlJYTc2T21PZFVmbHV5dDhMVHN1d2Zo?=
 =?utf-8?B?Vi9SZmFWaVpMZ25ZSUNNYmEvRnlSVzU3WGJKK0xtN1kxdXBJcXhoQUVKdDhG?=
 =?utf-8?B?aHNIZzVxY3VveXlOQ0JyTTlhMjcwR01kVUZpVXljdmhkbGIyanBVc0dsOEFP?=
 =?utf-8?B?cm9abG51cDRzWVhEY000U0w5VGZHVjhZcUhoSStieW9zQ1JYKzNva0oyQnAv?=
 =?utf-8?B?UU9WSWNFY3JIL2ZXNEhVTE1VSHVRZ0o4WFExZkpOUDVzVG5ZZGUwdnFMaEdV?=
 =?utf-8?B?UWhlbDJJZlovZjZVQURTaTVJYmRZeEFQN0VHd1JobjBmQWIyNUhFQ0NJNmNn?=
 =?utf-8?B?Y3J3VlIrMVBxcFZPVXV2ODQ0bFZTeGE1cVREbHVUaS9WVU5uT01pdDlHa2w4?=
 =?utf-8?B?bUltOWQ1UUFpVEVxMTRkM0xkbmVaeU1VMDdWdVBCV09ITjFhYzhWWTd3cnc5?=
 =?utf-8?B?Q003cnBHUlVqbzVIeGsrdkwxRThjL09kcDJCbzNZdmJFdmZ4Q0QzRXlqaFdW?=
 =?utf-8?B?Qjhmelc4SHFMLzltUi9jMmovNDFRZms5YTlCUEpBdi9SVWRMZGV0cUxiUDlz?=
 =?utf-8?B?b3M5ZWJaV29hVnA0eHdpZkhhRGtzS2tRUnM5V1VHVFJxVU0wZ0pVbTh1U2F3?=
 =?utf-8?B?RVg3VGpnV1hnR1JrUHJyRFJWOGJSM2VpQWV6ak5ydkJ3ZmEvS1l2N1lGNi9V?=
 =?utf-8?B?elYyWm5vMlJDL3NKUWNFY2xaRHhyc2xWaGErT1NmR0ZyQlB4djA0M3g4UlJv?=
 =?utf-8?B?VC84VlliM3RQREVHemxCYWR0cURWK2tBUElSNjlWYVdhRkY4dFYvaHhVaTlQ?=
 =?utf-8?B?eTFVYTVZUzZBeWRZRHhEeS85V1ZJaWVqdEt6azRYY0RuVlZlVzhpNEtqZi9N?=
 =?utf-8?B?bkI2b0paRHpmYW1oUWtPaVowVVZnYXBQS3RqOHFKNnA3ZHM4S0xORWRwTEdI?=
 =?utf-8?B?Uyt0NlFpYVdFaVJidE95NVFHNVZ4QjBJWHpmeEc5UXpTbDNJdFdvQ0ZKd29X?=
 =?utf-8?B?TFlBMGtrLzJNTzRydGhOeFA4blVoYXo3a1BnTS95Ung4ZkFVTER3d2U0UHpS?=
 =?utf-8?B?WDBjb0k0U2hVVjd0NDRhbk1NTXlGWi9UNDMvRDREaXNDRWhOZ3djL3NKYzk0?=
 =?utf-8?B?dUdjNWZ6QjlhR1J6WmUvYnh6TnJpamcwQnZsRWdxQ3VQa0pSNWVKenY0ZmE3?=
 =?utf-8?B?ZUVaNDdWWDl2cWFET0ExOHEzZTBGWU82WnMxbGJFSDVSVDBVVXRyVHA1bXRo?=
 =?utf-8?B?V0RXT0NwQ1hPMHRjOWw1WWE0V3MrNnNFR1d6ZUZGR3J4Tnh1c0VLUm16TExv?=
 =?utf-8?B?MUprQ1NTSyt6WFJjMlh3UEhBaUpQaDBLRytieTNOZE1YTDg4TnE5N1hTRFdk?=
 =?utf-8?B?ZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1prM2J5NEJGMTg2NVI0MldDTHdJREE4Q1NTRmtFZ0RnTmhVbXUrK3VxQjVF?=
 =?utf-8?B?aTVMZzFHZFp4QktQUjdzKzJNOXhNRTNQSm5tckNFdzhMYWVXL2tUNENNZk5B?=
 =?utf-8?B?cS9ROStyWFVNUnpmWm9nRDloajc1UXdIczlmaytBaGhkdXVCQVNLMk1GZ1gr?=
 =?utf-8?B?OUN4T1pCQ0lNMmpMZkdLN1ZCd2pWakFNVzhHNGhuZFFwYlNKa01UaE44UE5X?=
 =?utf-8?B?Rkp6cnU4dXJyT21odEVQRGMwOU52RUVTQjhWR203Z1lrQnlXZWx2L21Pb1lo?=
 =?utf-8?B?MUlGRHlvL3NTRzY4Q3lvRFN5VU12TE5KcVVNWDJLdy9TTFgxbXVwTjlOcG9P?=
 =?utf-8?B?QnY5K3pnQkdSOWdWREZGaEd2ZnZ1M3lOVU5kQnFYaFo1SWhiYjA0aUFIdm84?=
 =?utf-8?B?dEJHMktrVUhQOTMyRWRqcjRqd2tCSDRWR05qVzZFZFlhTEVTYm0wV3ZWUU1l?=
 =?utf-8?B?MGZRVzVxdHJoNmh0ZnQrejQzbjAvL1JXNFhQSkhMemFiVHAraENxWGtYN1gr?=
 =?utf-8?B?UGRIb2RuTDNRQWhxTm84QmJFa0FWWHVtY2lnYWE3TDNvQml5RXNNdERjUldI?=
 =?utf-8?B?Y053RXQ3QTFsUkFWcXVlSTJRRUVaMUtsNzQ0SHBZZFFtREkyblZOdi9HSjY4?=
 =?utf-8?B?VXkxbU91dWtXL2xBWkdWRGQvWTV4SlVaS0praDFOamtLZ3EvaHFlVXV5TzRv?=
 =?utf-8?B?SjNHUkM1a245U3c3SVFpbnNoWWFxekFxZkxYS0NPaEpTU3hldFdrNnhxREpC?=
 =?utf-8?B?RWdSRHl4VCtTKzBtOURSUEVYZDFBMDkrVDdlcmZqOHBkQkM0UVBpUUcvdUZC?=
 =?utf-8?B?dXJnNlNuL0V4aGxTcURpWlVnaCtGOExoM2xsZmVMN00rM2VmelRzUkpoaktq?=
 =?utf-8?B?MU1JRklxMUxxWTN1NXpGR2JwVWIxa25HZEdFcmwwTjlkN29VYnFmUm9HbnRh?=
 =?utf-8?B?TkVGTXRlbUlzVlBkZ3VDK1VTczdSQllUS1JPbDZHc0VEaGxZQUR2REIrUmxW?=
 =?utf-8?B?UVk5cHA5Y0Z4d0dLSk5RSDNZb2RnRGxaMFVLem1nOWVOZi9jK0oxaUwwWFpx?=
 =?utf-8?B?dG15a0g2d1pmd0RkMjczdE1wOStEdU5wV1R6d2ltWGk5SEZCVVBKQmFvaVdw?=
 =?utf-8?B?MXRJWVl5STMwNEdHeTU5VkhodGt5ZGlDTEdZWXdETWNtc1hEYTRac0x1RVAr?=
 =?utf-8?B?bmxTOEd5dWFLbGRXcUhMTDA2ZktxcS9uQTEweHViM0F2SzFTZ1QvMkNPc1la?=
 =?utf-8?B?bFhBdmJVamVQRXNUVXY3NlZHaVZOM2RVNmlQSGNKb2V1QTJGNjFDWERhZW50?=
 =?utf-8?B?UEQ0WDV0bHlKcWxJNDhMZFdXRWd1Qnl1ZC9QVjJpVjNodVE5dUxJZXlIaGg1?=
 =?utf-8?B?dnp3anUwTEJqTC96cUJXUVRvdHJJbUZySUUrb00xSzUyODR2Q2dDaVE2NVBz?=
 =?utf-8?B?VWZWeVVncFhiOG1wTGFaaml1QXZSeHlFTnRTdU05WjU5Sy9pQXBtVHRxb0c0?=
 =?utf-8?B?M2poRERVZWJNZkVFSGEzSURTemhLb2txR3lOaFR0VlU0ekcrWForUTlvVVAy?=
 =?utf-8?B?NFZuR2lxQm8zRjRzSHViZjIyRXVUQ0hWYmF1Q2tQUU80OGdSV1JEY3NlT3NY?=
 =?utf-8?B?M3owZlliSVNMZm5QWE40ZnJCUDJJOXJGVG40UGc1bWs4WFcrSFhmWTlVbzVB?=
 =?utf-8?B?Z2FsRDAwOEhFblBWcXZ2c2NEeW5GcklNT3JPSzEzNDRDVy90OG05UlBVQ00x?=
 =?utf-8?B?bzlKT21BUUI0MllJem9QNWtUanhXb3BpaC9pR1p4K3RHYU5qaCtPNXJuMkZj?=
 =?utf-8?B?K3lzd2xmZ2lDYzZiMThLTTFib3pHcVZzeHIvbjBiTDBKVitXR1UyMkVhMkto?=
 =?utf-8?B?bVZHUkRTdERUcXF0YlRvUmxGWWx2ZFplaHhLOWMwRWdJMTJDSWs3RFYrVTJU?=
 =?utf-8?B?MUdTTDh6aldVRHNzVisvdEd0MWRnR1JGaTJueXBSbmRIU1Y5UG9IbUg0bVFI?=
 =?utf-8?B?ZUwwd3FBSmxQeXpYWlVxeG83WmhmenhRVkx0NkZYZXdQRXZKS2JKUVlOSnM1?=
 =?utf-8?B?SnRZdEpWc1l6czJTNEJhUHNhNXpERU5JRG4wVVF0ZmxCRWwwaHJjWDg2cGhR?=
 =?utf-8?B?U25MYitNQkJuV1RHbFp4emYyV25Qak4vNHJXYTNyYWpwbFFDTnBXMUFRQ3pF?=
 =?utf-8?B?NENqYVlOWnFaNmVQaWZ1RGY2VjVtYWZGVHgvMUlocEYwb1NUbUZwMmFwdUZH?=
 =?utf-8?B?eWJpUWY1NnBHMFpaK3JWSGloakdzdnF1MHJUcyt2ekNSTnNudEdrRWowN3B5?=
 =?utf-8?B?UVVpUTFRdllLL2FneTdXems0Qjg1WXI0b0IxLzlKdjA1OGM1NG9sQ2NnVHEy?=
 =?utf-8?Q?KRsvjq505fgKBvJWkh812zZ3Zl63G+KnZVrC+rkHqaBgf?=
X-MS-Exchange-AntiSpam-MessageData-1: yPi55ywhFehOQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c26a1e-6348-4ef5-d8b2-08de654513ce
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:49.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ7SmDfV/TrApvadLNEEa5O+4HLAY1TUQnAs6W+OqHIrsa54Nt6nAEyBtreWWRNL8Pmy/d6BGqlMdo7lTW6eAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

Since `ConfigSpace` now has the relevant implementations of `IoCapable`,
the default methods of `Io` can be used in place of the overloaded ones.
Remove them as well as the macros generating them.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs     |  3 ---
 rust/kernel/pci/io.rs | 70 ---------------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 06856d6a9b46..9874edda2b28 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -226,8 +226,6 @@ macro_rules! define_read {
         }
     };
 }
-pub(crate) use define_read;
-
 macro_rules! define_write {
     (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
      $type_name:ty) => {
@@ -259,7 +257,6 @@ macro_rules! define_write {
         }
     };
 }
-pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 8c8aab2e3f22..ae78676c927f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,6 @@
     device,
     devres::Devres,
     io::{
-        define_read,
-        define_write,
         Io,
         IoCapable,
         IoKnownSize,
@@ -85,63 +83,6 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
     _marker: PhantomData<S>,
 }
 
-/// Internal helper macros used to invoke C PCI configuration space read functions.
-///
-/// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
-/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
-/// return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the PCI configuration space write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the value to read.
-/// * `$addr` – The PCI configuration space offset to read.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_config_read {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
-        let mut val: $ty = 0;
-        // SAFETY: By the type invariant `$self.pdev` is a valid address.
-        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
-        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
-        // within `i32` without truncation or sign change.
-        // Return value from C function is ignored in infallible accessors.
-        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
-        val
-    }};
-}
-
-/// Internal helper macros used to invoke C PCI configuration space write functions.
-///
-/// This macro is intended to be used by higher-level PCI configuration space access macros
-/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
-/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
-/// return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the PCI configuration space write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the written value.
-/// * `$addr` – The configuration space offset to write.
-/// * `$value` – The value to write.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_config_write {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
-        // SAFETY: By the type invariant `$self.pdev` is a valid address.
-        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
-        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
-        // within `i32` without truncation or sign change.
-        // Return value from C function is ignored in infallible accessors.
-        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
-    };
-}
-
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -190,17 +131,6 @@ fn addr(&self) -> usize {
     fn maxsize(&self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
-
-    // PCI configuration space does not support fallible operations.
-    // The default implementations from the Io trait are not used.
-
-    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
-    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
-    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
-
-    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
-    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
-    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
 }
 
 impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {

-- 
2.53.0

