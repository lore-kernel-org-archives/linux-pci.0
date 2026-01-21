Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020133.outbound.protection.outlook.com [52.101.195.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA64481648;
	Wed, 21 Jan 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003221; cv=fail; b=P0qJ2/CS5TZ4bqQXcSAyffGP3iV5cEtS6xT97nFO4++2mkxQjWL2ewO+/e7uyppHJ2XACj+TOp5axUMif8Gl7Pho5Im29Is1QnSrqTkz6QKCsxmY4J8TVz8V/742TnSPB49/eqLdwhINFj+5MlEObcWluMu59W5Tb9mEcO3PjHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003221; c=relaxed/simple;
	bh=4wOmpJsCeKJQThCEpJ3Hl5LnrweWwBRYrYcp8cKxjNk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=oW6H1kmfRBT1T6DulpSwckf42L/ovg6IzpXmHhPrUzA1yeN7puP5tksvOP8RR6J5r0N3LYTVi6YoFFsvlSDkt4NF8qF2rv8rjJVpLMNx4GRsuCPy90oPpcTcen2BwILo+JGRnFCVoSp4fcTPM0j90tlQqaqQS7ongMPYlpCsJYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MJqF6+np; arc=fail smtp.client-ip=52.101.195.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MJqF6+np"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sucaU0pJJ7oYc0k1JXE6+/cepd3z+3M6MqjTMrTds882YDxjXZ2Yl2X7FJWcDGoy4ZWeT3CsRf4iGS/y9TBWxC4nv2lVnRuC/JmzeSAzseHaCvyFbEdFGXkJA5+MA6wQZac67I6hqzZlwO4roqLifRxBCA4qJIFVetDlQ4ib74jnagt63T3SPmYxsQVEpgGPy59hm3L7sVvWmmCSw4tKaYP8y6fYmeZ8fCg3HtoxqX+A+IJRrGt2TADiASiBhWIrzWb4Mkl3/o0s/zaOFASzLMpsuLN7XSzOIjHMhmO7NXJ5b6emjxdCkpFJhUKOsBXb9+4rNM4u6odgKS8/k3OWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD01h4me+majNAscHbY2xLRfwn1jhKHcQmcXkxkH1Ts=;
 b=soCW3+G/Zcwfd3rQdh3QmFUtKHc/LqAZYk5hn+p6YOooE55UoOB5Wd+05ArpWaXjvHsnUgfYhfzKQbx0/iMu4/AkFb3eYW4HTAam2cHCFkQN5rFRImMSZnRP/vniZtNs9npRRyld555Nu/C6hW7o3CINILJXbFKbRMi/+VxG8rE2eBJm7egQy0FvgYoQW3UdheHXoDoZD6IA/95WZolEfzG77hg8XzDO3+vbuMXrvlSXJ+hvKj+n9xZ+HKYl0QhVq2lCensydZ4D3RYid2LtZnR0a5K/jTCUIylrJ0BqOAFS1cfx7TOgC76FsYFEsE0tLEcVu87zd4MOaP9o8qLkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD01h4me+majNAscHbY2xLRfwn1jhKHcQmcXkxkH1Ts=;
 b=MJqF6+npkAXXgfV4aQJEadY0v9Dg9J5Qi0rWu0g+mXDz83yCuoAyfCpRPTOfG0+nfDKs5OI128zIudtiU0Wj5uepn33yNKpxdItV0mAmIZjB6ax7xbwMRcLQCvLtrXW3WCTOd990JYQhpms9xwRkVO9golnb7pk0aOOXNUwulSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7407.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:21b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 13:46:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:46:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 13:46:53 +0000
Message-Id: <DFUBAXCDIF1H.2R3004ZHIZPOE@garyguo.net>
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/4] rust: device: support `dev_printk` on all devices
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260120181152.3640314-1-gary@kernel.org>
 <DFTN9F5OGCBS.2CRNLWNC60971@kernel.org>
In-Reply-To: <DFTN9F5OGCBS.2CRNLWNC60971@kernel.org>
X-ClientProxiedBy: LO4P123CA0252.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa5647a-e661-4be1-209f-08de58f38995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhiOXVmWEZ5cTFITDRCMng0SkNQbERlTkZFbmtOV2poRUZmTU03ckdCSURu?=
 =?utf-8?B?VXQwc0ZRSXovUkZIREJvWkZlYnNVMXloQ29lTHlsdUVOLytyTWF2WmdpRmg0?=
 =?utf-8?B?ZjVaZUozakZsUEdKc00rd2RVZlduZTlzU3RUVHU5Y01zYnJpSWphY0JrWjZB?=
 =?utf-8?B?ZDg1eHVtNE9SZE50SUl2WmtHdkFRUS9OcE13RHJjcFVKK1NTU2g1RHpoQXZm?=
 =?utf-8?B?UzJOdjZlcFRRa3o2bTNWZ0dXRDdiUFhaTmNIZm1WdXluK29TcXhDOTVXRkND?=
 =?utf-8?B?bjVDUTFrUzUyVWNtRDhHRituWUFUTVFlZ3NTR1l3cTduMytaSS9hOWlYR1gz?=
 =?utf-8?B?VEd3ODRJYk03Z1Y5M2dKLzdPOTVncGU4Z2k4RXF2OUpMb0tNS05RMTRaRita?=
 =?utf-8?B?YzJXazdHRlIyTy9iNnpTaFd2b0lOYmZCQnU1QUFMeXM3bXFPeUJWVlVHTUdW?=
 =?utf-8?B?emt4Nk9GSXd6YlQvK3duZStHM1BBelNmdEhqMEJZZS9YdUtJQ1NpMTNqTWpS?=
 =?utf-8?B?TXR1VkZLeG1MM1dwZXFnd0tmUkpxWVhKOXZGNzVYbW94WG81OTdUU1NCUXdo?=
 =?utf-8?B?UW9JWllydnBHbE81ZzJtMFVhQzJDQzk5cnM0U1lWZFZ0TnhhempUSE9DTXJF?=
 =?utf-8?B?cDloYUwyQnVjd3hoZFR0b2oxeDVsOFh6SnMyUXdSUndkL3NodFRTYUx3WTZH?=
 =?utf-8?B?bVB4OElaMGU1QWZUVkZkVzcxQ1QzelFSc3I3aXc1SS9zUHdrc1dNamZvd1k1?=
 =?utf-8?B?VjNsekRtMXh6R3EvdFY1L2t0MmVTTy9CaUNnWFBWR1BHRUx1S0dsM0FoU2Fl?=
 =?utf-8?B?TVdhSk1TZnZYVDl2cTRiNk1XREVvZ2pKSG9yblVubGx2bGx6ZCtQWlNUcElO?=
 =?utf-8?B?T28weWI2MlJsZzZYQ0dIcm91U0RNWXhuRjVsVUMxcjc1TzJ4WkRlTUNvamJr?=
 =?utf-8?B?QTBXb1RqR2ZSUUg1WS9jSjRxZXZrbU9WTURMOVM4b0xZMDRzU0w0QzV0eVY4?=
 =?utf-8?B?OGpGbVh0UVZEOTRhMiszNjVwbml3aWxOUi9EVzdUNUE4UThZbHluOUEvdElu?=
 =?utf-8?B?KzYzRmMycmluNWFFZFBsd3ArSUJhamVKZ3R6Y0wrdjlsUXZXN0Q1THpyaFJD?=
 =?utf-8?B?VFAzSmVuL0VKdisxN2xnSld2NjNrY1FjakhVU0VKWGs3NTVObjU1OEhucEI2?=
 =?utf-8?B?MFpSN2FhZFo0S3dGWGxuVWxMZWp4d3FpZ0JnY3FXbHd6Qi8yUHdGS2xnUkFC?=
 =?utf-8?B?NU42bkRackIvVDBYNC9sanNtVEFRTE9PQlZvazFVMTZ4bURxeXFVN2s0Kzgy?=
 =?utf-8?B?R3B0QTQ0dE9oVnRRWjlZVWpEZ3RKZUVoeDhUb3laV29OSm5ObDZSeWdzNkc3?=
 =?utf-8?B?Mnljc28rNmFQcEdlSFlLcDBMY2JSMjhCdU1oNmpzUnJZRnBUWFRxUDRqcVJa?=
 =?utf-8?B?T3NaNjNnR3M5TFo3eGc3dWd1eHd2MkpvLzRCcWN5cW5tTmNBWVJxUEhwaHBw?=
 =?utf-8?B?SnBFODBHQ3lCQWhhYnZZZklodFJhMmo3SWJuYnRLL2E2MnRoOVFmZ2Y4aVlm?=
 =?utf-8?B?ZjdkOWtwT014Nko2ZFdhZVMwRW83MnJZZ0orak9aRjZuWmpKUmEzaFo3cnBZ?=
 =?utf-8?B?dUtEOTBvTDBPQkVtOGpvcjJlRWFsT243Q3pkMllZLzkram1Yc1FrQjBjUEJz?=
 =?utf-8?B?NjZndWt1OHJwQkM4bE5kdjBPbXNKd2YyYkdwSm9ia2U4SGxuNWU3SmsweVBT?=
 =?utf-8?B?V241VjJDRW5rTW5PK0VTd042OXNiNTZEY3huS3UySVVJQy9mU0dSQWlzN3Ji?=
 =?utf-8?B?SzlwWEhuWTFjK3V2NWVqUTd3Um56VDBiUm5HSVlmWFZoYXJHTVFxM0ZLK2J0?=
 =?utf-8?B?RzdnemIrNjNhQ0FxRm1wNE1UenVIaDZ4WlZmb1h2aThtdWZHMDNoUm5OeXFJ?=
 =?utf-8?B?a3pwRjZQM3R2bGpEODEvZDlSUDJTOW1XYWRWcnQ1TEk3ZjZIaTgyMHFWU0gv?=
 =?utf-8?B?bzNUaWs0NitmbEovaklCUFVzcmg1ZW8yWkJDb1hmVXNacGFlalhzNmdZWkY2?=
 =?utf-8?B?TXU0V0VaQ1VNY1hpcWVqWk9DUFNmdjJHZXpHeDFpcE4xVlFuWTV0enNTU0Rq?=
 =?utf-8?Q?9/aI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmN6TUR6N05zdmtqSkFqTHF0WWc5eW82VGVycW1UdlppaUFFR1BjZStJeWVQ?=
 =?utf-8?B?bFRFaGZ0eVltY08yUmtka252d2dTcEN5TkhnRTFObVE5Y2hKYnZydGNBSXpv?=
 =?utf-8?B?V0xVeVA1VDFzOUJMZURScmd2aUI0ZGQ4b1NwRnF0MjFVSXpSRTlMRjRzS3kv?=
 =?utf-8?B?WjNGZEZRVEg3eUNBYWh5Z2U0c3F4aVJrU0FSMjJKK1dnemhGSnJ0UkVqdFF5?=
 =?utf-8?B?cFFHMEJjdStyUlJITDB3YWg5ZVoyOVFMZGM4cVE0MjhzL1pvSjQ2S3hpV3Zi?=
 =?utf-8?B?dGRzQlpjQ0FlTWp3UWFRQVROYkdORDFlVU5QZzRPUmRMc21CUFZ3V3hmaVRa?=
 =?utf-8?B?cWFhUWUreXJzM1NSRGdTMWVMdjBMWjdMT0o5alp3ZjVyUVA3cnhGTGJuam0x?=
 =?utf-8?B?c3ZSbFVhay80MHAxSFVpakFNMWRaU25uSlczOTViUDZVcjVscGlDZ1ozdGdn?=
 =?utf-8?B?SjdHaDg4c21FVzdvQmx5clVoSjBtUkRzbDMybnF1QlRDbE9MYTY2OCtXQ0dp?=
 =?utf-8?B?VVYvVGpOTTJUNFpjRFZWNXZzbDc0TDRyMmlzRytsbFh2Z3pSVlpwalRDSitZ?=
 =?utf-8?B?T0FEWlV4WVhSaXZTc2RTcGxXdmhCVHowNS9KOS9VTzhJV3lOaXB1UHdOdXlE?=
 =?utf-8?B?Y2tRZm1SUVJzVHpLRCsvWDc4Z2loNkNFRXljdENLd05PSjJQRmlrL0hoRk1E?=
 =?utf-8?B?bnN4OVNWWGx5RDhBb0pRcjg5cTZqRU52T1pLSmpMUFl1MndYVXFnT0F4R2xO?=
 =?utf-8?B?RzBYdmFEVk02aG9jc0dISFEyVGkzdk5keVY4dzVhTllGQUJQL2ZFb0hkZ1R2?=
 =?utf-8?B?WGpjcjEyNHRldElhSkxnOGlKejd4N2M5MjNYZmthdkUxYVBNcnQ1NFhoYzhz?=
 =?utf-8?B?dWZxc3Bmd2RGSERqREJRMUpWeU5rUC9wbS9SQTZFTjBtcVhMUTRSMmFhNWda?=
 =?utf-8?B?YUVMaXpaV21QY2NFZjBKT2VaN2ZoQ2dEY3EwUzA3R0dWaytXaTl2L2V0TFgy?=
 =?utf-8?B?OWFzdjBaNUZ6K2VLaCsxMG9sSFl2ajVkdmVyWkszb1E4K1g2bElFeDB4V05I?=
 =?utf-8?B?WFhnRTExWWo1Njc0RkFyN1RlNlE0aHB5L0VmUWlJZTQ2RTlIdkM1SVZrbWxM?=
 =?utf-8?B?UmV2dUc4UStxME5CeUhabEhSSHVlby9UQldSRm00clF4bTRweFRqblMvU1Nx?=
 =?utf-8?B?YldvSWhjems0M1BRcFpxcHRrV05zbFhBMlBQdThING1XcWVaSk52b2JSbUlZ?=
 =?utf-8?B?UmhPL1lpWFhTRmc4L2hvWmZXQmx1WkVCT3kxM05XTlVZU2J6MmdEZTMvSm9x?=
 =?utf-8?B?cDgvVG40YklGMUhYeXVMZDZXditZZVlCVXlYSlVveVc5SlJRNGQwUWZSRXpw?=
 =?utf-8?B?VDlTUHhydDB3TmxkSHBtdjl3bDl0WWdSQWRWT0FBWWdTUkJhc2I0Lzc2VEJL?=
 =?utf-8?B?dmNXcDFCQmZWeVdadlhlUndjVDVmdFBWL0M4UmtHRkRTZ29UQThFMHAvdnNk?=
 =?utf-8?B?K2VMREVXNmxrSk9IL1hNZERVY1JBUDdHYTdLUDZYZFFRNElMdmJvMERINlgz?=
 =?utf-8?B?TGQzWXB4aTJDak5Kb1dscXRsS2hvb3VMU1U1VHN0b3pvMjAvYUpCUnpGSEhG?=
 =?utf-8?B?SUUyVFcrNzJldGxnZ29nU0laOUVYSXBKZXNVeHNSR1hnM21tUkJONlJyZy9R?=
 =?utf-8?B?cjJtYmtEQW9uUEllM1YyMS80Zkg2bTJpUVBzYjNrSUtVbzJFRmZ4SXZSbXpj?=
 =?utf-8?B?eU9FZ1FFcTk2UFFucUhHTnZmRU5uYjV0QnB3TkV4Wjd6bWpmVjZ6UGZla2hv?=
 =?utf-8?B?anVJaTFONDFGa2RmMzd0dWxtczZEVXpGVXNDTk8zUFl4cFowZVkwaGlrOXpp?=
 =?utf-8?B?clNWUXA2eklPcEtYb3B3dFdneTc0S1RhZ0NOZ1NTbHZ6aHNuMlRVekZPcWM3?=
 =?utf-8?B?aXk1c1l2SzNsczJvbVRTQlFrNHlRSTZxSFA1dmFZVEFSclNLL1owRkpsQVpn?=
 =?utf-8?B?dXU0S3Z4STFWMlB2NXlPekJtTUErMGlaQkFrVWFFMlhRK1JMSGNINWpTcXM4?=
 =?utf-8?B?cjVWMmY3aUZGMHZVbGkxTmdnZno5Y3FqV2luSzIwK29tT2lSYzRHT0RPaVQ2?=
 =?utf-8?B?a2ltdytWY1J6QStYbEVSRHYyeEdZNVNPVTlhL0YrOUJKaENML1k0eTRwUXdj?=
 =?utf-8?B?ZDlrYk1nNEVNT0VGR3ViWDhxTUhBU2JLQkNqK2JKS29vd3VJc3hWdDZSRSt2?=
 =?utf-8?B?TXFGR3NNSXB1TVBKK29YU0JDb0JBZG9rN2orZkNTYWFDQndYT0ZQUXNaUWtQ?=
 =?utf-8?B?N0ozcWhhc3ZWWklmNU05ZS9Ga2NUakRuaWl5aE9GN2ltWHNsaVpvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa5647a-e661-4be1-209f-08de58f38995
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:46:54.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMwPa/YEqNUSzp+5qHF8aGL7J6l9Dfk6FEC7ZIsoPjL5ancHWdm0QjqSzJ0fyaNNdkQNiuq39YTzXOb8mwNZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7407

On Tue Jan 20, 2026 at 6:56 PM GMT, Danilo Krummrich wrote:
> On Tue Jan 20, 2026 at 7:11 PM CET, Gary Guo wrote:
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index c7b5db9dcca1..94e0548e7687 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -601,6 +601,13 @@ impl DeviceContext for Core {}
>>  impl DeviceContext for CoreInternal {}
>>  impl DeviceContext for Normal {}
>> =20
>> +impl<Ctx: DeviceContext> AsRef<Device<Ctx>> for Device<Ctx> {
>> +    #[inline]
>> +    fn as_ref(&self) -> &Device<Ctx> {
>> +        self
>> +    }
>> +}
>> +
>>  /// Convert device references to bus device references.
>>  ///
>>  /// Bus devices can implement this trait to allow abstractions to provi=
de the bus device in
>> @@ -720,7 +727,7 @@ macro_rules! impl_device_context_into_aref {
>>  macro_rules! dev_printk {
>>      ($method:ident, $dev:expr, $($f:tt)*) =3D> {
>>          {
>> -            ($dev).$method($crate::prelude::fmt!($($f)*));
>> +            $crate::device::Device::$method($dev.as_ref(), $crate::prel=
ude::fmt!($($f)*))
>
> At a first glance I wasn't sure if we really want to rely on AsRef when h=
ide it
> in the macro. But on the other hand, if someone would implement AsRef on =
a class
> or bus device to return some other (unrelated) &Device it would be wrong
> anyways. So I think using AsRef is fine.
>
> I think a lot of people will be very happy about this patch. :)

^ this is basically me getting annoyed by everything being `pdev.as_ref()` =
when
reviewing code and want to fix the pain :)

>
> I will pick up patches 1 and 2 this cycle, patch 3 and 4 can go through t=
he
> corresponding subsystem tree next cycle.
>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index bea76ca9c3da..3946ca919332 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -351,7 +351,7 @@ impl Device {
>>      ///     // Get an instance of `Vendor`.
>>      ///     let vendor =3D pdev.vendor_id();
>>      ///     dev_info!(
>> -    ///         pdev.as_ref(),
>> +    ///         pdev,
>>      ///         "Device: Vendor=3D{}, Device=3D0x{:x}\n",
>>      ///         vendor,
>>      ///         pdev.device_id()
>> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
>> index c09125946d9e..e2d9e8804347 100644
>> --- a/rust/kernel/pci/id.rs
>> +++ b/rust/kernel/pci/id.rs
>> @@ -22,7 +22,7 @@
>>  /// fn probe_device(pdev: &pci::Device<Core>) -> Result {
>>  ///     let pci_class =3D pdev.pci_class();
>>  ///     dev_info!(
>> -///         pdev.as_ref(),
>> +///         pdev,
>>  ///         "Detected PCI class: {}\n",
>>  ///         pci_class
>>  ///     );
>
> Can you please send a separate patch for those?

I converted them as they're the users that benefit from this behaviour in t=
he
kernel crate (i.e. "convert the users"). Do you want them separate so you c=
an
take it via a different tree?

Best,
Gary
