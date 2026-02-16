Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282131063B;
	Mon, 16 Feb 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249183; cv=fail; b=FwMWzM/bbYIE3SWpRdPvD2eVTgSlXXB8NhK/bsmnIzaOgxfEBNC3jEzdqchG8RitB9Tg6IkXFlPcJMJOFw6vMEcZngC+x3rn1R1hSnJ/5WyqixxFuGeBR3s34vO69Bt6TRfyOzKDdWxLZNucKp5ox8a+0ZhJDrl7Y2xLMwnv48c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249183; c=relaxed/simple;
	bh=HiiXdOa0Z0S+PH4dOw6VYn+2kUUJ8s7Dcj8quhfu53s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jFCqGv92Wd+bayPrteFHMU8gA1hHUEBX/2agsZjDBdBy9l/Oc/7vBTiLvZUIrn3oPymm7tAEBXyYgyRlsvtUtO0+P4MaEAIUB69gXgok0o/M5fQrygihIuCEeu7BH1EzFUBN5r0wpUWi2OKAqlAt8NLu5TDbPoebvjvtVoyRm6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KAsALPyk; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KAsALPyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa+/ae+XbFr9fkUT4OZ91b1lNOzIWsU7MevEvBXmuTVM1ddKDwWUr1PDRhzxNqdNwzJCheZiI7cUaq5epukozs1hfq3R8vNCmMY/UToI3DqKBIbzSHw3dGaG1EOwbzVzHoM4JCZkF+ziVvBLZ7SqSF9DzrsoPA7Q4abkJdJDUwEgxOJLNXoijPDBcoUzAn0kcjEfVwDCeGDw1zUBJruhLVyOtNFC3HmLWMg5aiyliWXySDcm5IDOb62VvqBo9pIPjoVz0mXOq2e8hY0+FhsehRgIE/eWIz2yWi+IjlTBkkrcS4ekr+ZiXMJ8u8H5VCGCSKnVBKbK4zk5CyoR44GQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiiXdOa0Z0S+PH4dOw6VYn+2kUUJ8s7Dcj8quhfu53s=;
 b=JgAbNE/mtyKFx5+PDi9c0L6e+vHAkjgjHLpjh5NjLnx1m5LyaSQFdtaZayBNyt7WOLCv601rUullUrfaAMTXafv1Bnyd9+wZO5G+0doUGPGaA44/lFFUXOvROntUpcixS9hAlPp9cy2iVUQlFhtEbTG6JNq6j6pgz6LV8fMr0aVMJ6VI5rGYMwbPI8h0qODtf4ZCW4jDbkAPe09QIvjp0r0INy66rlkqzOxJPDe92qagZTCEwRHAVU+HvfEH55bEQYDZw27Pribw/9y+d16g1K2yCsuQ5XWEhQtjiGIKDluqDWVRaIury0i9L+oGE945u5+yF0WBJ2sVLiv0rGBmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiiXdOa0Z0S+PH4dOw6VYn+2kUUJ8s7Dcj8quhfu53s=;
 b=KAsALPykuE9FWcvY3tHcUia4ARVuaopklpvUjkLGaw3/hUsX+IKNdmF9kds52m1zHQsVKeBkMNnkneA4YmpqK/q+gVlmODCklNTSOi//7Y2S3XsA4HC1LIA/2cvp4gGvyiQQJMPtjK/rNT0/3tEQgV3YipHnZuV9sk8FMkTDE/HIwU2knXd4kkKaRbFXEWPQQaIu9IPm28pgQY9YnVzHAOVHtNTEnqXl/8foUY6tA+05NaQXHsgfUfNYodH2Zp/RZULMlBI85NgCZ/knQIdXoZXH8Hq/938nsS7GNtgIO31K9Z1q8uYGVhyMwn8PWm2cJlLNZmQzQ8Srhpf6vBz+Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:39:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:39:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 22:39:26 +0900
Message-Id: <DGGFFDUCVJX4.57KHV1JH0LWK@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and
 io_define_write!()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260216131534.65008-1-dakr@kernel.org>
In-Reply-To: <20260216131534.65008-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db82c3a-5d48-43bf-75a8-08de6d60cf5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjFxU2MvTHBnSUhRWjZWaU5UM1JjZmRXRm5Ha2hIbnk2NFlFRmhnNzZwVzl0?=
 =?utf-8?B?cktDS0w4MW00N2ZybU0yQVUwV2NSZzF1L1JiRytTdXkwWDhNQWtNZjJnSlZt?=
 =?utf-8?B?OWZRZjhNZ0d4NzR0UWYvU05vL3NnYUJNTWgvZ1JlRlNheHVqUVVxZ0Rwbm1n?=
 =?utf-8?B?VGxuMW8yakw3ajlBY0NjV05UY0p2RWFXcUtkczV5L2M2Ym5kdlpSQWpMWmwy?=
 =?utf-8?B?N1FKK2V5T0xwVVh3U1FQaGhYOFg0Wnh1Q21rUkczV0hJYkEyVEtwd1o5bjZZ?=
 =?utf-8?B?OHBhSkIxSnBpZ2xSV2xiakJzaDhER05mUW1IRGFsT3licFBxRDNGRVRLTmtO?=
 =?utf-8?B?U0hjUnk0R3MyNWcrenBxbWdiTDZtYk5aRVhCcTFiY3d5WXh0ZzVUWlhZQy9V?=
 =?utf-8?B?LzRtbWhvZkFtQmpjYU9LOEZYc0hlVkpYTHZCWWhXbG5uYmliU2s1Y1g1aWZQ?=
 =?utf-8?B?VEQvYTZOY2VCSkJIY3NMdkcybkljUFpZUlFZdWoyNU5SS1pROFJrZXk0K3Ix?=
 =?utf-8?B?aDNTRmFZTk5CenlsUjg1Y20wNmZCWGkyQm9Rd0RtcEwxaWxBV0o0K3ZJZ1Jr?=
 =?utf-8?B?bE1EbXphRE5ZWm9BdFlOa2VDdTZ5Z3RoaURYNklteEwycE1kbzhqY1NBaENo?=
 =?utf-8?B?azNFeHBQYkd0WDQwaUlmRnFyZ3ZRRkNTZlI2bXZiUE9RRWhpaGlja002Q29G?=
 =?utf-8?B?eHFjbFhzWXNxY1ZIUExpbG5vcmxUc2pCTTVtWGo2djM0WWZWMUVKMlFXTUUw?=
 =?utf-8?B?UEtUcThhTDl6UmdkNVc2NElrYlU2WXpVZ2dyOU00MWJKdW9hSnlvVXdBczgr?=
 =?utf-8?B?ZytoWkhQRE8xVDRZNzdnSzNoQ2JocXFVRHpYcWtGbklqQUJHMDdpMEh0ZUR4?=
 =?utf-8?B?ckU1TU5ZVnVWUHdCd0phS2xRcHVLcUVzTXFrcWFoWGdEeFBzNC9WR21USjRY?=
 =?utf-8?B?UVpNSk5zQmtteXlMaGFIUzJNNlowR1FaaGhzTFlReHJ0ZU5Ka20raEt0T1ZR?=
 =?utf-8?B?WnpvbHQrSkNZOWJ1YnBqU1k3Q3ZmdlV4VmdBdU03QzE2L3lFa2NubzVnTDJF?=
 =?utf-8?B?bE5iayt2enRMK3hMUUMxaU9tZU1ES3ZXaExOV0E4WDZ1MmpnT0VnaFlpNVRo?=
 =?utf-8?B?U2ZPbWl6Mkp2N010V3p4ZytxeDNObkptbXhWM1ljUzU3cVFtQTg1ZFVaWXJ0?=
 =?utf-8?B?SjJ3T3E0YTV4OSt6QmVDYnRaaU5GcUtudFVydzgwUkZaVmxmWGlVY1ZYVHhV?=
 =?utf-8?B?ZU03c0Z0emNUMUk5dmgxdjNxdzNDaDl6dllVMXFXeVhraUVML1lOeUQ0Sk5K?=
 =?utf-8?B?MVBYY1Jpcll1cU40V0lES21CS25VMXNwbTlNcWJGZE1JWGpQTzBFQlN1Q2Rv?=
 =?utf-8?B?YWZUYXhyRzUrNWptaklKNGowaVA5WXV6MWV1NHQrZUo4ZTU2b2VLMThVRGtr?=
 =?utf-8?B?M2NMcFpGK0xEWU43MEZvMUJhQU5yUWN6SFdIQWxHWHVpaExIR3VXOEp3cTIw?=
 =?utf-8?B?MDBFUjlvUVlPQUtXQ1NMZVNTZU5BVi9DbS9tcURIRE85L2hHTStPcmVwbVhQ?=
 =?utf-8?B?RGsvMDFiRmZUc1laMlFCNmtmNzRFNXlvaFpVRnZKd0RqbThnT0pSNHFIdFlm?=
 =?utf-8?B?WFI0ODVxMVZENCthNzNneEl4ZFk4YUFIS28rSmJVQ3ZZcld5dEdxMGpETFJX?=
 =?utf-8?B?N1Nwa3FteHdGR3grUG1nZVZYN1lTZXRPUm9nS2ZhQXltQ0FVdDhuNEI4ZEo3?=
 =?utf-8?B?RGxNemxad2Z3UGdRV1BUNkJ2S2FNZmFmREVHOGZKNDB2Tlo1ekZ1MjJLd0RO?=
 =?utf-8?B?cGVxb1BtTEF4YS9PVVFlUlRncTJZa0VxbDhxQStiQjBQZFBMWGlzcVRPZTQ4?=
 =?utf-8?B?ZlFobE4rYUMxSUdiU1ZaYUxFVlZjeVdzSnJPQW5NQkNwYjNoYTZHZFEzbmpJ?=
 =?utf-8?B?NHRoVk90S1pOM2ltTHZ3bDFXYWRrenFhNXZYU21OSUE2ald3RGg1NVdaam9u?=
 =?utf-8?B?RloyZkdIMlJSVGNjcDQ3VEpLVE5HTnFpMUxPZU1xcVJZQzFtTnk4ckloU24w?=
 =?utf-8?B?eitiSWtEbSt5TXJKN255TlBNV1lLamdQR3I2SG1qWk9MbUNYc3QzM2ZCNFhC?=
 =?utf-8?Q?Lfj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VWQnFFS0RTa1NCUElBZE5uS2F4QlZmRk1aODB1UVpjUDhzMXB1SURWU3NQ?=
 =?utf-8?B?MGNza2hWclhKNDdQcUQyb204NnJ2Zm5CZTc1STlsRmw1bnlSdlpnaDRMWXlW?=
 =?utf-8?B?R1dKamh1R2xlWkRNVTV0UWpoN1VlQmY4bXhLMkNmUUJkV2F2THJGUWcyVzJq?=
 =?utf-8?B?R2RkTEhwc1FRSFhKNTRPUWtUalF4VDJRYU03UUtZRHROck9TWHBvNzFlYktI?=
 =?utf-8?B?MFBoZm43TldjRWdoY2N2elBuK2xvYmRLTXlZZ3NHTXlnMzQ1d0lNdmh2MU81?=
 =?utf-8?B?a0lBVGVUb29SaGQ1TktzV01sVGVGcEZOVElrUDZ0eVVtSmZ5bDZSbWM1eERB?=
 =?utf-8?B?UCtTMkttc1lYUkJ5ZDIrWjNZZXBiUE0xYmdnK05rT1hOaHdiQ0l3U2JDZitX?=
 =?utf-8?B?VHlIU1I5S3VuUXlhUEFPLzc5bEhkQnBMb203Wjc0NUNQSEpEOWpISGdaTTdn?=
 =?utf-8?B?TGl6UU1IUkM2cTNYWGNValdoU1pJMHhLOTFwOCtUd3B2QVZROVBmeUVnRDRB?=
 =?utf-8?B?Vy9RWTN0V2J1RnZNU09kZDVCT2pYcnR2eURhU25CanBzcHZaRFhDZHNSZHEv?=
 =?utf-8?B?eWdnMkdHdkJiNFhULzJtL3RXTTFtb05FYlVwcDF4YmNZZlVBdWQ5NnpSTG8z?=
 =?utf-8?B?TkF4US9BRGUrOFJEdVZXbDkzRTN4aVJWZGdUbTRiT2EwaG1SL2xtLzhxdFJr?=
 =?utf-8?B?ejRVU3MyQmdnUmxMaENXTlhGVFY4c2YvWHhQRzZaWGI4aEE4NE94M3IvaUND?=
 =?utf-8?B?S1gzZkJXSUFEU2pob0ttdWd4QlV2VTVVZm44Ylp3QXgvQ1hYaEd0QkdUQ0cv?=
 =?utf-8?B?Y1RYZG52TzBFS3BrdDd6SU9qdUU4Vm5FK0c4c21SenVCSE4zbDEySmVvaHJt?=
 =?utf-8?B?Mlp0S2xIVEFZcmpzWVdlZ0xzOTRnTk9sdnRmcW13QUgwbmJQSk9BUVY5eG1G?=
 =?utf-8?B?cm1SMHVvWlJtakJyWVluTFRLRVJuS2l3NUJPMlRrK0pFdy9vSzkyajFDRExs?=
 =?utf-8?B?MFMrNHVoWWtCYU9nNDdCZFdmYXIwbDdPelBrWlJib2hiSVRqVzd2TGRYZVZo?=
 =?utf-8?B?UGtFbmtoaHcyaHpzZktlaDdpajMxNGhsaklGUnJiMG1LTUZvNVdvdDhXSHJK?=
 =?utf-8?B?WFZZQ3R6alRuTGxqUm5GTVRKVFRRMUdqM0I2R1RPckxlYU12ZmNQNXhKM0do?=
 =?utf-8?B?dHFuZjdzcy8zVmk3SGtUR3JKUmZSc2VoZjZxVEtGTGhiVWtlNW1NME9IRXBm?=
 =?utf-8?B?ZWdXNnRmWmxweFlRTzFUQkFsZnNMcFE5cGVGM2tEWGJNUGorUGRNUVB6RUtQ?=
 =?utf-8?B?QzI3ZDFMR1ZJRDF6M2N6ZUY2Z2lKU0gwK2xvY2dJSkxrUVRRVVNibWxPKzNZ?=
 =?utf-8?B?dUVabVNweWMwVUh2bUtPcXJNT0luaDNTdERRMW5TQmh2ZDFIeG5uL0lmYmJv?=
 =?utf-8?B?OCtNbG5BL0ExdUdnR2F0OC9YcWtXakRzcnFVUjVUNkpVVkxpQ2N6cHBrbzl5?=
 =?utf-8?B?TDZDa1Y5Z2FhOFZtOXcwVVgzd2pVdVhLZ21SWTA1MFJhSXlQNEp3WE1qWFBV?=
 =?utf-8?B?eVExWm5CVTY4QjU5OEVzYXRTZXpxQ1VyWkI1U216Y2tmZVBEejd4Vm1ZaWd5?=
 =?utf-8?B?d3VjMVdoN2h4TWg4MTJrMnZoNnNJeG9LUkUyKzRMdDZKcFhHeGwzVWZ0KzJB?=
 =?utf-8?B?bzFuNk1PbzFtUUlEb3B5YVBXRG1hQ3RucStrdncydWYxWW1POXh3MWQ5aEJr?=
 =?utf-8?B?aSsvdUUrTkpDNGdZdDNFbitwODloS25RaUJoZ0ZUUHlRTlVRNjZLTlV0NE1m?=
 =?utf-8?B?RTcvMHRRUjI1dm50cXZIV1AyRmlwdkVtbXBucnl5T1lud1UrTlZ5Q2NyS0x4?=
 =?utf-8?B?Ky9uKzl3aEdZajYyM0dSYjM1eWdEVnpnNkpHZ0kxdDBYMGdIN2taMFFCRUd1?=
 =?utf-8?B?VFUxWkg3Q2QrOUtOTEFZblVRZExQY1Qrd3R6T2JHQWZSbHpnUFFVa1MxazEx?=
 =?utf-8?B?UXMvT2dMakx4djhCVlpKZ1k5VlVRdjlsYnlXTWM0emJHMHNFNEswQ0F0K1Ir?=
 =?utf-8?B?UTJmdWczTjNKSVFrVnMyVTF5TkVvNWIrSE8zNG1naWNYUDMvWGJ0N29tTmZl?=
 =?utf-8?B?UGVDWGtjb0VKa21RRzh2eHNNQXU2akUrOVlxeVROS0h0RlFRa0JRVm50TzdH?=
 =?utf-8?B?eDUyYXJmNkllVkZFRVNhbkFMaGs2SkVac2ZMODBmak00eVY0MkcxcEYxcnlw?=
 =?utf-8?B?UXRjeFAzVWpZWVZMU3VOY1I4YUVkQWpjZWtGQk1DcWVEcUxYR3RvSU0xK29a?=
 =?utf-8?B?SERjdWlWTmRhYUxCejd0Vm1CTGlLN3pBNDQrM1lNQUN5R2t3elk2cGp0cHRm?=
 =?utf-8?Q?/uZTaIbzO+6Z8gAIOwdHgeaHvh2sD9DE8ytX/+xhy3XfM?=
X-MS-Exchange-AntiSpam-MessageData-1: 882WFUet9rhoXQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db82c3a-5d48-43bf-75a8-08de6d60cf5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:39:29.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DlcQDQLzamuI7Mo8ORlrmDsnGyTnFt5mNuB13W4uOI2x/SX1HIv2DxVTDj/eUoQ9psN0zqNh2jmySa6sLrIKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

On Mon Feb 16, 2026 at 10:14 PM JST, Danilo Krummrich wrote:
> Currently, the define_read!() and define_write!() I/O macros are crate
> public. The only user outside of the I/O module is PCI (for the
> configurations space I/O backend). Consequently, when CONFIG_PCI=3Dn this
> causes a compile time warning [1].
>
> In order to fix this, rename the macros to io_define_read!() and
> io_define_write!() and use #[macro_export] to export them.
>
> This is better than making the crate public visibility conditional, as
> eventually subsystems will have their own crate.
>
> Also, I/O backends are valid to be implemented by drivers as well. For
> instance, there are devices (such as GPUs) that run firmware which
> allows to program other devices only accessible through the primary
> device through indirect I/O.
>
> Since the macros are now public, also add the corresponding
> documentation.

The fix is relevant for stable kernels, but if we merge [1] these macros
will disappear anyway, so is the extra documentation worth the trouble?

[1] https://lore.kernel.org/all/20260206-io-v2-0-71dea20a06e6@nvidia.com/
