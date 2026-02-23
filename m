Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0B1E8826;
	Mon, 23 Feb 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852321; cv=fail; b=sfyT0xDGygy5oi+D1hEOWZEmb2512aQpDM9mSKTl36AmboAV+DRZT60dHfORb0xJvgDRjso/mxFKxLTPsOLu08LrShmQS2Aa5K3WQ2VFryPPTb59lhYKgKSmYSlMA3Jg2PakaQSjxPY5IEJJqLJ6LTadsiJIV+/+rJMCpZKlt7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852321; c=relaxed/simple;
	bh=hVeMEVzx+vsf4Gx04gi5xinhiYqmWKfHMOLjfk888t4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmV4Eb/Dl1XnqsB12YdE2tXHKgYFkq5CCPMK0s0nPxXIUCr2qUpDkIwFrPQZDCD1rbVtUgiPSnMeNjVT65eFSZ1DvtdV6shKVrzW1aLUPO/GWmrXTFBewQlg25sSAoN0dS1WICC6Su92hTdY5KR2rETXzEzRBlID9aDO0BWg0Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FaB1BAv4; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FaB1BAv4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOAOkPmVTH7XEAj0bCtONyzzJoiXBYy5/NGp6Z6t/XFur3SzgvoBAuZdIhWVSOoN90mW3gCTofaEaINLlm0ilDaf1azu1e8/DV7zk/UbFgHSanysTaTOoC5uYcqRT1yv6u0a8UNlW4YfiYb3171R1YRhI0owisvk4h8kF6k4bHE3Q0906abhsfh3i7b8ApTsA2v5po4KnifS8RFYw+/ucxiwIDu0PmslSKEB2HhqGhMAN2cXzkcjvdLMwJoVlSzvM9+h4qls8+LzFUU/ent7JeXyA/unw8tNq1Rxscy9WY/bRhM1T/p/q6/FfG096mzf5VA5+ke1WagFQT/LQJeVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVeMEVzx+vsf4Gx04gi5xinhiYqmWKfHMOLjfk888t4=;
 b=hOStx+kpt8uboWuGhryZziEuAImX4dY6eLPQpTjsNrm371gjX/lf9kdlOOP3cArLTokUWOz2/r/Tg9ELHvwigHvxNCGUc7BBle3R4rwaRyhL5IQSno2A55lLkF7Petm/m9+AIhAhTRZm/0Mh5NLbGLVdxKw3lQzm9k6b1S5xAe6jlBbSY0hJHuJoxzUb21WWmp/MqasdXht+xtD7PEaw65w3T8DFstL0SCP9laIQvjuXjResXcyoaew3oS54x6v0McbTU4kBVXgv97j5ei702P/MEwV8mSr+Eo6JPeMCcF4EN0JL7rMkBdCxOU2B8Jn7h9d+5zCrpQurr/fAOhR4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVeMEVzx+vsf4Gx04gi5xinhiYqmWKfHMOLjfk888t4=;
 b=FaB1BAv44pAB3qRMKhHDjQbgB90TA/ZYnt8nnQJo4E2RS3Hc6euLm0IcKw6VbsPFHRNvVZXNsvnSWQWCIZhLljAtzQizYwNR15WWixtX7xGh24HTveHbuFMWFzb3keDPS0b0X1jBEGcgTT3UbOUUPkYHagV6wx/ja6WDg8n12tgx+anD2el3pMl5bNOjFjawe4ZWPRxrLqmpn4PkEsdhPItjV0wg8FQm8kyh+SkHHqEyFmVXDPkucrD661oyYS3aJdKV45qIHxuaRb09J2P73e2D3zY0wDP0GR4eO/JFf/WtwQ4IW9JCXyjI52rs+BDw4VoOgVP2bJIZjXL3VDdT0g==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 13:11:55 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 13:11:54 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "raphael.norwitz@nutanix.com"
	<raphael.norwitz@nutanix.com>, Dan Williams <dan.j.williams@intel.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Srirangan Madhavan <smadhavan@nvidia.com>, Sai
 Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
	<vaslot@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Topic: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
Thread-Index: AQHcoqKiG24KlYCSm0Ksb0cJxXYNarWMGHmAgAQuNQA=
Date: Mon, 23 Feb 2026 13:11:54 +0000
Message-ID: <82a5a344-26d7-40ef-9047-60657c6923b0@nvidia.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
 <835de7c9-a64f-4aaa-95e0-b91c2ae5885e@intel.com>
In-Reply-To: <835de7c9-a64f-4aaa-95e0-b91c2ae5885e@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|MN0PR12MB6269:EE_
x-ms-office365-filtering-correlation-id: fa4e846d-30bd-4a1e-3e69-08de72dd1da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGlZVDNkUVBncHJjK043a0dWZHByZmpYTkpDVjBVdFZJMnR0NFVLYmNaaTdu?=
 =?utf-8?B?NkdxRllzUmxoVDVEWVRYYWdIdG5YTFhzK2pyZW1Fczc4YTZVTnRMc2tTR090?=
 =?utf-8?B?aHdKR1VFSzV2ay9ObldCNFlHbHpIWVlROXBpV1JEQ0JhTDVNNlVKZndYZmRa?=
 =?utf-8?B?VXRZUHdtTEVQRnB3M3lycGFueVd0Z24ySjQzdkRPcFNMeHF3a1JxQ1h3MVNR?=
 =?utf-8?B?N3dlLzVqcWlWMkNYVllQbVAxak1ZUE8yK0ZHMFN0R3J3d3ZOQi9KRW1qZHNB?=
 =?utf-8?B?aHlqb3RVaDhYN3UwZkVYSFJyaWxuUjJjWGY0ZWFNajk3WWZmRkZqM053NUIr?=
 =?utf-8?B?ODhJME5WL0RpZzVFckhuS3J2MjFhZTZMK2NFYWRqWjFHSzRrVDlOaGZUWVdW?=
 =?utf-8?B?ODhYRy9MRGV2TFM2UGdoMDF1QmFuTFY3MVREQzBzaGxuelpHTmpwK3N1QUZL?=
 =?utf-8?B?QUQ5QjNydnZEeEhZanhSbUtFTWFYam54eHQ1MmpNdXlKQlV5aGJxelRnTDF0?=
 =?utf-8?B?cmpUeWRIMXU2SVlrRWJ0VVBWZjhVWEhFY2JZTDZVUHRGT1Z4Mk5pRWJVYkJK?=
 =?utf-8?B?SW02SlZCcTlxaE9VNHpLN1JWRkFFMzI3MEJPczJaeFpLSVpYZ1dVMGtEajVR?=
 =?utf-8?B?a0d1NVg5MmZtMk5qUUlhRXhpM1Vxd0JMbGRIc2MxOEtDU09GbXVabTEzaU1s?=
 =?utf-8?B?eGpSOXZTMmZaMUxoTVhrR0taV0liZGdTd281ZDJyeTNOK1ZOSEkrS2tWQnIw?=
 =?utf-8?B?R3N2eW4wLzZJTWxpcURUc2drZlZKN1kxdU4wekc3WkZDYjdJcjA4UFJ2bnlB?=
 =?utf-8?B?cGZYUkk4bXJraHFBT0x0VDNwSEZOb0dRUWZUSjdZSUpZb0s3NEFKS3lWbG9w?=
 =?utf-8?B?aEdHNWU4MEdRSkdyYUVHY1hUb0pISlBrcXNEVU56RVlLS1ltMGxiUmtaSCs1?=
 =?utf-8?B?eGxoOW9NZ3VjWk1JRm5LTTAwTzVGM2tzRE9VelhqTndPQ3pLb2k3TThiN3Y3?=
 =?utf-8?B?RE9rNkFSWS9DUUdFeG9hTEt3QUhiQ2tIZzhTS1FDV2RTZStjK2RMVzIwMHNY?=
 =?utf-8?B?SkZrVGt6alBOVHBBK1VTMUg1bUtBZU53b0o2aGZHcFF6MThLVjJwa1N1bm1z?=
 =?utf-8?B?ajRUWVl1NGtlMU1qR3RlZkRoTElLT1dLaUZ2K1Z4Y1FZc3V5Vm0xaC9GdkJK?=
 =?utf-8?B?M1VsNUpTL3R6VEhXNFozeEJPMko2K3d4bGJHcFFTL2ZzWlpWWloxemUxWTQz?=
 =?utf-8?B?bmVITWo1ZzR2ZWtpOGs4RHhDVSsxYTFrYWptYVB0Rkt2dlh2WnFKMHlnUjdx?=
 =?utf-8?B?OS91aHFuSC9XNU1zRit2aW5IenRaUS8rVTdRYUxRQ2RvVmtZYXI4QzlvbDIv?=
 =?utf-8?B?WTVGL0s0Qk5RVkFIRDA3aGxBaVIxdTBFVDR3Z09JeUFGM2U3Y0E4NDBrZG9p?=
 =?utf-8?B?VEdvR0xsbXVQZU1uRGVaSmxpdkRnaDRwSldpemQ5T0Vxb1I1YnR3TXA1R1Rx?=
 =?utf-8?B?U0YzNXVPMkZqZTVyKzdlWGhodnBVQ1hLS3RwMkZLY0RuS1RkT0lIYm1rV2w1?=
 =?utf-8?B?QXQyRjlPemI2dlloOHlKWFU1VDU5ckV6YlNiZWRoSWVVV1BkY0hGb0o4U1M4?=
 =?utf-8?B?WTFyMCtDZlVMdFB3SUJ4dEh0YU15V29JbUMva2ZNdVIrSU5TUENSZHVKd3Zq?=
 =?utf-8?B?RjNxQTRkQlpQL05JN3pHb2FTcktNalorL1UvZ04xanNrbFZCdU9id3I1dGhY?=
 =?utf-8?B?V3B0ZHloWFBQNHR2bXNVNlRGb0x4OE9WK0QwRmtqdW10em1CZ0I5OFFYUHND?=
 =?utf-8?B?Q3MrZVdTUDVGMGJTOWQ1SGtLUHBDRUNyRFJ3aG9qMVFld1lrbnF3Sk9RYWEz?=
 =?utf-8?B?bGFDejRRRnZ2blVkcTFiMEgrd2dqTFA1QWxCazVVVXUySVk3eitqcFlxenN0?=
 =?utf-8?B?TnByYXV2cThRZEpqZjltM3ZJc29GOTdGeEM1RlNqaG5zK3UxOHhEdllqYmxs?=
 =?utf-8?B?aFV0eHZhczdhdUZWKzlxYVhOazRKMzZMV2NkNk5WV05UckxYaXRya3g2QUR5?=
 =?utf-8?B?R1JGWC9kZmV6RGV5V2xFd1gyaTJqM0EwbjE1VVFDUFVMS1YxZ0ZsZUlkNE1T?=
 =?utf-8?B?ck9lMkR4K2ludjduZzZEWmhEZ2VZNUUvZVErbldiNmtjK0VpMlVvaUhWS3Vj?=
 =?utf-8?Q?hwd/2nZRe3t9DnOvyn+3Ji8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2JmVmFvTjQ2TGFoUEV4SlFVYWJ3VGNPaGNrSndJMWlMQVdBMjl3Y1QwRDh1?=
 =?utf-8?B?a0hVR3JHajEyMEJJMFEwU295UVFpOW8wbVpHaU9SMWdqdGk3M3UrK1U5dUFo?=
 =?utf-8?B?QWhHaHdEVlUzZzJqOEkva0lISFF5V3FYZDFKMjNES21PSFVLb3dTSmtDSTk4?=
 =?utf-8?B?U2xFNy9NWWNGZXZpZEpXMzIzQ3dzU2hlNjErRHVieGlpU0gxN1FaMitiNUtu?=
 =?utf-8?B?ekxna0JwcjVoZGJpcS91a3BmV3BDM29VQXpWWDJUZGY2NE5nWmg4U2RSNDVx?=
 =?utf-8?B?U2lVeENpRVVzRStSbjg2Q3d1clNXTGZYTFFyOUE1SXJWcWkzSEgyQnV6ZnVl?=
 =?utf-8?B?aTU5RG9UWDZ0L093OWF4b2lxTXFMa3JxR1o5bU4zNlpQUkJrUTBkVG9OTUV3?=
 =?utf-8?B?VVo5dGt1YUNQeWxkR3BuNVVIQUt5N3N6QUxxZzRhNUwvMHA5MnJhQ2I5akZE?=
 =?utf-8?B?VXE1dEhjVlFtMndKMVhmTjVnQWszOXdFRXVhWVJodEdPVXM1dUFKRFdieFF2?=
 =?utf-8?B?V0lRWC9ZYnI5ZkpVVkJEQ1JaT2NmSFQ1dGl2YldScXJPcmg3dTFmTElKa09K?=
 =?utf-8?B?QkpZdTlFM3VJMGRsVXNYUVZRU3JaUVBDaWJ3ZHE2dnh6aEF5SEV4ZUhZSnk5?=
 =?utf-8?B?Nld1NmM2Vzh3b05qRkpRK3NDczdSZWk2eE0zUlMxMUV3bEhWZ2Nib2FTWS9I?=
 =?utf-8?B?NGVMVWJQNGpEK0taeEJieExnY0NZcmx2VXVsVWFJWGhnM28wVlZkTFExQkRB?=
 =?utf-8?B?dTU1TmFRVzFaajl6YkhsaXdpMDZheUpKMnY4UHliYlpISXIxdmJmR3FNT2hF?=
 =?utf-8?B?enAwclRBUWQySXlUbkY2Unc3QStYUVRhZW9lSWFmNzJDRGFXa2EyS1Mya0kz?=
 =?utf-8?B?Z05ZeVB6SVdqNm10a0dDMmRCVWdaZ3hZUnBPdUhnZS9lWHJBblJXVlFUS1E0?=
 =?utf-8?B?RWhUMjc3bEcwbFRNamFIemQySFg5MG14S0NWdXVLRSszYjRGN0YxcUNtTllV?=
 =?utf-8?B?T2pTMk9uSTJQaXlrVE9MQ2lIUU0wazcvVXFKeVZNVElMMTRKWi80aVc1dW1R?=
 =?utf-8?B?NlJtbnJqYnI4eksvalZrb2FJeXVsc2NibDVtVEpYaGQ5NFZpUGZLMjZGNE1y?=
 =?utf-8?B?WDQ4NTY5OUJ5MzhiaWZ1VUlreFdyclIvK2xzMGpPbXlzNkhQVjZSSVhwUWVK?=
 =?utf-8?B?UjJnVmd0ZDhDb2tseWcwZHloKzE1TFJFUWtnYkloQkVGTElmWHVxUkFNa3Nt?=
 =?utf-8?B?T01sdUF1dzA3SUZRVzEwRHdlOElmRlRsRUhXa2JwNHFMZUNicm1kNTJmYkQ4?=
 =?utf-8?B?YjllZ3AzY1BIWnBrSERiWFhUcklOeUZuRTlxNDBEY2x5TUpYWjJUclFFNmpO?=
 =?utf-8?B?amF6SGtaWURKMXFlOFRKZnlTQ3ZrZjJuTUhpNnEzeUw3eUFLSVJRMG4zR1E4?=
 =?utf-8?B?TTlURlhPNXhENTQ3WVJ2b1RSQlFkbmhZRDhHdEt2S21TTE1OeHFWWDgvQkMr?=
 =?utf-8?B?ZW9FYU1udXMzUktNdmdlbm5jQXJYQ0ptcE5QVHhUOFlJRnYvY0wxc3RUdGMx?=
 =?utf-8?B?WU1VTGcvcVMyRHBkR25yMFZhQ043TlNabDZ5OVd1cmlJY1AvMWlTZlIyZFVZ?=
 =?utf-8?B?RWxyMjFlZXRIUUZmNnJuYzNPQ3lFdXlQcHlzQTFXNUo2UzJyRWZwTHVSMys4?=
 =?utf-8?B?VTZNYXJvbkpiYVltQ21GYy9iT3N3eXJiS3JGbGRiUmZJeFpzbmJzdnNCT0h5?=
 =?utf-8?B?aG1NQ1p6SUs1ZUZDN241dDBKaTRscnJhUUNBSkhIcWZPM2RvQ2xrdGFIMS9a?=
 =?utf-8?B?QThVWTBWWXlCYnhiUkQwS1g5aWE1aVBVL1NxcFlha0ozOEdOR0sxaHV6U210?=
 =?utf-8?B?WVAvakhyRzkxQTZGWWZITDN6cHZNbWs4RHM1YkpiWUJRQURTSk1oQm51UW9K?=
 =?utf-8?B?cjllcmI3RXdkdjZGTHdJamx2U2xCWlovQjhtTFk4NlpEVTZZYUllQUJyd0VG?=
 =?utf-8?B?amVndHBYcXN1dzA2RFNudmt4VmJjM21QUkhwWHFHTEw3ZWpSMlljeEFZdXV1?=
 =?utf-8?B?bE5XN0NMMTd0MTFEa083Y3F5T2tKUEg1RUUxTHdYbEVtQ0hCRzllUmJmYm96?=
 =?utf-8?B?cGtmQXQzZGJmdURwZG1iRExEZUtjTG5MeG51dWZXcjFwTTJvSHN4SmlBSldW?=
 =?utf-8?B?ZmNqNUxrd01FOUxDalRMaTFuMHBHekk5TFlrUngzbzhRbXFNdlh1Qk5UWldZ?=
 =?utf-8?B?QmdsNTdqZ0o1TEFpQmgwSWRpM0pUakx6NFlyTDBzRlYxRmRzVGxiRm5hTXgv?=
 =?utf-8?B?eWtmK0ROS2o2cFBSZkg0VEx6YmMxblMwL2hFeXlzNUk1aGQ0Yk1IZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F5AF3C198D8D547AA9DBF1C5644D5DB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e846d-30bd-4a1e-3e69-08de72dd1da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 13:11:54.3385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkWvE2jnPVydh+b97Ncuy6adTF/nBEgsD6KTIrO5OuZ9WfmfWfC0KcqN8XlhI20pFga5v7eLX6PkoHqVCMBECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

T24gMjEvMDIvMjYgMDI6NTEsIERhdmUgSmlhbmcgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+DQo+DQo+IE9uIDIvMjAv
MjYgMTI6NTIgUE0sIFZpZHlhIFNhZ2FyIHdyb3RlOg0KPj4gVGhlIENYTCBzcGVjaWZpY2F0aW9u
IChlLmcuLCBDWEwgcjMuMSB2MS4wLCBzZWMgOC4xLjUuMikgZGVmaW5lcw0KPj4gdGhlICJVbm1h
c2sgU0JSIiBiaXQgaW4gdGhlIFBvcnQgQ29udHJvbCBFeHRlbnNpb25zIFJlZ2lzdGVyLg0KPj4g
V2hlbiB0aGlzIGJpdCBpcyAwIChkZWZhdWx0KSwgYXNzZXJ0aW5nIHRoZSBTZWNvbmRhcnkgQnVz
IFJlc2V0IChTQlIpIGJpdA0KPj4gaW4gdGhlIEJyaWRnZSBDb250cm9sIHJlZ2lzdGVyIGhhcyBu
byBlZmZlY3Qgb24gdGhlIGRvd25zdHJlYW0gYnVzLg0KPj4NCj4+IEN1cnJlbnRseSwgdGhlIExp
bnV4IFBDSSBjb3JlIGNoZWNrcyB0aGlzIGNvbmRpdGlvbiBpbg0KPj4gcGNpX3Jlc2V0X2J1c19m
dW5jdGlvbigpLiBJZiBTQlIgaXMgbWFza2VkLCBpdCByZXR1cm5zIC1FTk9UVFkgZHVyaW5nIHRo
ZQ0KPj4gZXhlY3V0aW9uIG9mIHRoZSByZXNldC4gSG93ZXZlciwgZHVyaW5nIHRoZSBwcm9iZSBw
aGFzZSAod2hlbiBwcm9iZT10cnVlKSwNCj4+IHRoZSBmdW5jdGlvbiBjdXJyZW50bHkgcmV0dXJu
cyAwLiBUaGlzIDAgcmV0dXJuIHZhbHVlIGluY29ycmVjdGx5IHNpZ25hbHMNCj4+IHRvIHRoZSBQ
Q0kgc3Vic3lzdGVtIHRoYXQgU0JSIGlzIGEgdmlhYmxlIHJlc2V0IG1ldGhvZCBmb3IgdGhlIGRl
dmljZS4NCj4NCj4gVGhlICJVbm1hc2sgU0JSIiBiaXQgaXMgYSB0b2dnbGUgYml0LiBJdCBkb2Vz
IG5vdCBnaXZlIGluZGljYXRvciB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgY2FwYWJsZSBvZiBTQlIg
b3Igbm90Lg0KDQpOb3Qgc3VyZSBob3cgaXMgdGhpcyBwb2ludCByZWxldmFudCBoZXJlLiBDYW4g
eW91IGhlbHAgbWUgdW5kZXJzdGFuZD8NCg0KQlRXLCB3aGF0IGRvIHlvdSBtZWFuIGJ5ICJ3aGV0
aGVyIHRoZSBkZXZpY2UgaXMgY2FwYWJsZSBvZiBTQlIgb3Igbm90Ii4gTXkgdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0IGVhY2ggZG93bnN0cmVhbSBwb3J0DQoNCm11c3Qgc3VwcG9ydCBTQlIuIFRoZSBw
YXRjaCBJIG1hZGUgd291bGQgZW5zdXJlIHRoYXQgJ2J1cycgZW50cnkgaXMgbm90IHNob3duIHVu
ZGVyICdyZXNldF9tZXRob2RzJyBpZiB0aGUgZG93bnN0cmVhbQ0KDQpwb3J0IGlzIGEgQ1hMIGNh
cGFibGUgcG9ydCBhbmQgJ1VubWFzayBTQlInIGlzICcwJy4NCg0KPiBUaGUgb3JpZ2luYWwgdGhv
dWdodCB3YXMgdGhhdCBpZiB0aGUgdXNlciBpcyBpc3N1aW5nIENYTCBTQlIsIHlvdSBrbm93IHdo
YXQgeW91IGFyZSBkb2luZyBhbmQgdGhlIGtlcm5lbCB3aWxsIHNldCB0aGF0IGJpdCBhbmQgaXNz
dWUgdGhlIFNCUi4NCj4NCj4gREoNCj4NCj4+IEFzIGEgcmVzdWx0LCAnYnVzJyBpcyBsaXN0ZWQg
aW4gdGhlIGRldmljZSdzDQo+PiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8uLi4vcmVzZXRfbWV0aG9k
cyBhdHRyaWJ1dGUsIGV2ZW4gdGhvdWdoIHRoZSBoYXJkd2FyZQ0KPj4gaXMgaW5jYXBhYmxlIG9m
IHBlcmZvcm1pbmcgaXQuIElmIGEgdXNlciBhdHRlbXB0cyB0byB3cml0ZSBidXMgdG8gcmVzZXQN
Cj4+IG1ldGhvZCBvciB0cmlnZ2VycyBhIHJlc2V0IHRoYXQgZmFsbHMgYmFjayB0byBTQlIsIHRo
ZSBvcGVyYXRpb24gZmFpbHMNCj4+IHdpdGg6ICJiYXNoOiBlY2hvOiB3cml0ZSBlcnJvcjogSW5h
cHByb3ByaWF0ZSBpb2N0bCBmb3IgZGV2aWNlIiBlcnJvci4NCj4+DQo+PiBUaGlzIHBhdGNoIG1v
ZGlmaWVzIHBjaV9yZXNldF9idXNfZnVuY3Rpb24oKSB0byByZXR1cm4gLUVOT1RUWSBpbW1lZGlh
dGVseQ0KPj4gaWYgY3hsX3Nicl9tYXNrZWQoKSBpcyB0cnVlLCByZWdhcmRsZXNzIG9mIHRoZSBw
cm9iZSBhcmd1bWVudC4gVGhpcw0KPj4gZW5zdXJlcyB0aGF0ICdidXMnIGlzIG5vdCBhZHZlcnRp
c2VkIGluIHJlc2V0X21ldGhvZHMgd2hlbiB0aGUgaGFyZHdhcmUNCj4+IHByZXZlbnRzIGl0LCBp
bXByb3ZpbmcgY2xhcml0eSBmb3IgdXNlcnMgYW5kIGFsaWduaW5nIHRoZSBzeXNmcyBjYXBhYmls
aXR5DQo+PiByZXBvcnQgd2l0aCBhY3R1YWwgaGFyZHdhcmUgYmVoYXZpb3IuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAg
ZHJpdmVycy9wY2kvcGNpLmMgfCA2ICstLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
cGNpLmMgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPj4gaW5kZXggZjMyNDQ2MzBiZmQwLi41N2UyNDMw
MGQxYzcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KPj4gKysrIGIvZHJpdmVy
cy9wY2kvcGNpLmMNCj4+IEBAIC00OTE1LDEyICs0OTE1LDggQEAgc3RhdGljIGludCBwY2lfcmVz
ZXRfYnVzX2Z1bmN0aW9uKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGJvb2wgcHJvYmUpDQo+PiAgICAg
ICAgKiBJZiAiZGV2IiBpcyBiZWxvdyBhIENYTCBwb3J0IHRoYXQgaGFzIFNCUiBjb250cm9sIG1h
c2tlZCwgU0JSDQo+PiAgICAgICAgKiB3b24ndCBkbyBhbnl0aGluZywgc28gcmV0dXJuIGVycm9y
Lg0KPj4gICAgICAgICovDQo+PiAtICAgICBpZiAoYnJpZGdlICYmIGN4bF9zYnJfbWFza2VkKGJy
aWRnZSkpIHsNCj4+IC0gICAgICAgICAgICAgaWYgKHByb2JlKQ0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPj4gLQ0KPj4gKyAgICAgaWYgKGJyaWRnZSAmJiBjeGxfc2JyX21h
c2tlZChicmlkZ2UpKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gLUVOT1RUWTsNCj4+IC0gICAg
IH0NCj4+DQo+PiAgICAgICByYyA9IHBjaV9kZXZfcmVzZXRfaW9tbXVfcHJlcGFyZShkZXYpOw0K
Pj4gICAgICAgaWYgKHJjKSB7DQoNCg0K
