Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8B418341
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438596; cv=fail; b=KYKn21ka+pjD3duf4cw1HZSKky8GaBwmfKLc6UpQ2KLkSer4TApTLwhfbl7M3gNNUk6Q2LtulzdIRUgqepnDOCfUt5Eulh+y1R530wMjYxBAZ2u+TRAW2jC8HrpBgtqT3w0AY0bfDF3mazmgrcvuQSDsBCQKfXBN63yG9JA7C14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438596; c=relaxed/simple;
	bh=s2BRTwRDw+5yP15ymehfZdPBusQpN7XLeW1Y5UAPeaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nw1et10HxSepWNkaa3ND1AnU4dctV8zesy1Tyq79U2vEM2eaupyWmy7m55YkCjuOwBqJBaGHYLCfOFSbXlbTOVBUw51b8VwqOu/8El6R0y1xxDpdHkTUSIb+E1TRa4gq4eYJGYdXkjjfYLZ9QBFk+hXpqCo7b8Y7xUhF5t7GsFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPjqCq78; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPjqCq78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786438596; x=1817974596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s2BRTwRDw+5yP15ymehfZdPBusQpN7XLeW1Y5UAPeaw=;
  b=mPjqCq78M+H6UNnIw8pGepvJ22/mI1al4IlaWvrm+82c2DqRa/GKQ2lK
   pcgYiVgU8rTN7FW/DyqtPpba9OzKl3URyCpGxgJ/gmEw/+iYAUc2Ppkwl
   7VVgMYqclKMSOetvq0v1az5YkVKJhCLKlBoAelDn6tgZDcOiWvcsy/vDg
   xf9utB+X5/WcvcvJzpfgSHyqdbQrNMh51c7CCBaKnnXGx/ioYw10wCxox
   DpHfh5JCD5kht8XXcyuNOBXC8R0sNqoDcf5W88N3QPjygTMbbRsKMtEh8
   pFYHrsNEPjU/Ri0E5LGhKWo4CTVrjEd/zURZRpXLtsqpB56b6fdIrTZo6
   w==;
X-CSE-ConnectionGUID: oS8ZWt3YR3GEwOkaQpYyVQ==
X-CSE-MsgGUID: pQE9xUJITmaX7AuQh+gvgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98111636"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98111636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:56:35 -0700
X-CSE-ConnectionGUID: LeTjNZQ3Sk6ak7flnU/Mew==
X-CSE-MsgGUID: q0y1feyfRVac5c68kdmP5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="293222356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:56:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 01:56:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 01:56:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 01:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfLAQjPmvRDRrGYAPJS47e3YPHr9/+PK43LypSMH+CP9gM7cXCyCK+6/0MLNmu2v54tX32hlx1MQlI30eLBxRntqE4HH2CHl3cuTJzifdXivt9h0Qb93NXhDsflPcI8j78jAm9xUg3KXfUFsfjRzGUMvLn0oqn6IEmZe+qjvrP3doYmxmepo8xk1dSq1pp75qGfj28jvqfuopQs/E6+ynsvSit5cPXaCd+45k+KQp5QVm65sutsxQaw6S55F5nwogkunzROgc/pndIRyudm6rtSoM01tZ/zdsXdmDQuDxGVd85VVUGbofUvRX9ncL+W8FVZ91Q2wQo/Np7LkCdmtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2BRTwRDw+5yP15ymehfZdPBusQpN7XLeW1Y5UAPeaw=;
 b=CRI47zaV6WnH3MFKYBjK4QyD/d/VFbyq1C1jZYUR2Ts/HwQ99gHf+D7ZqXsuFd2+HSmECiXhvbKR5gsbnrO4Z/90U6Br0ma5i4BfFqOnas6YF5NRPuUzrr9x3Tr14Ps42YA0t/3Ck6QxiOJaQrCwjqM7UtA3U3hKaf394vesNyRn6bMq9DBM5YzdMj9ixlTbgFFCkEfHwtrb2YS1GHLE4Yobh1Ed4wYoiiwQ2kexwPdd5YtFxZEhJuk/3D72rtQsbxHqai7aVeUBKkHn4CSBkQM2as95+rfg6GHEtooyd8oqte9B8ULrwfuISXOEB9IihRTDReJZCD/zkqdORm3aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 08:56:31 +0000
Received: from PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083]) by PH0PR11MB7494.namprd11.prod.outlook.com
 ([fe80::e642:c73c:6d80:5083%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 08:56:31 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
	"mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "treding@nvidia.com"
	<treding@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Topic: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
Thread-Index: AQHdAUruh/HWEZwEC0iMA6tK8iUSn7ZImB0AgAAE6oCAMTTxAIAABOIAgAAe6wCAARjQAIAAHZOAgAhH+4CAAAUPAIAAEYwAgAAGZYCAAAi/gIAAsEyAgAFxSwCAANOCgIAAFZ0AgAAXJoCAAAJLAIABQL+AgAZSnQCAABxpgIAKbjYA
Date: Tue, 11 Aug 2026 08:56:31 +0000
Message-ID: <c191d2f7e3672bc50864696bb53467cfa775c45a.camel@intel.com>
References: <20260804173927.GA1845060@bhelgaas>
In-Reply-To: <20260804173927.GA1845060@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7494:EE_|SA1PR11MB6781:EE_
x-ms-office365-filtering-correlation-id: de32d43a-4e32-4c40-788b-08def7867041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003|5023799004|6133799003|38070700021|3023799007;
x-microsoft-antispam-message-info: NziLcWPWMuxsEwqfv3puNoenbKsli7TKrdrnnqbOro927z/T8JLDQ7tfbE9y2aOcMik221n+hN2yo44RczykqkVNDiAQ0dXYcXawiqKOrZ4TgTZUhyGyHU20JTFlSpdWuzR7ETd0bz9SzomuWkufrcqye1w/HpTsFYfYekxR+7RKoA7p4s5L+3Jq3+C+mRJjYdZ3sDcaylTHt0PiKcR0WJtGSM6sdlruPowXa5680kxWSPChF4LwD+sdeNQcdnVvTZgA3qEEvhneowxW13fMg2u5pqN8pUxJ3yRLeH8tj8JR7/VeUHKQqlrqcuvRI8MsJ70f0c1J+o8Rdwr3F/34pNggeNj5ZHEOIgXY++xhKoXSLIuMO7cNQM2ZlodX+bP0H9Qq3kNXLYdIGNIRT/Pf/yprtYlZC1YXoKWP8XsFixrqsTFg6AsRGvXRvdSZE0IfbWgTxhh7tEDW0DTUTX1LEWIhyXRXmYViYYzpmQp4kVGJBsXjrfUCauojq8i5hl0IdidkURzyEsxqNq1gksef8r0QoMG1dh41w6cNo5HpAw467yXMTurxSV6UsjIYlqvDy0RByvuABNBI8pIYJtSghmSX7BtfPnggLN1Errv781LcgJUV2f+ZSpTQVAuOhSZvRi1KhwQiH2oIq1K4AOkdKEYTGSiRMIEBCKe3dD5AzOo5glyzIHimNxnQ+g3W0bp2HPF7FrHcAwhZWo9Wq+carocyue+6ZI2fADT4rr38ufU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7494.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(5023799004)(6133799003)(38070700021)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xhVjdqMjFJMGJUdEZUQ0NEYUN6RXQvMlZJakMxQWJXSDNvQm8zamxpUTlT?=
 =?utf-8?B?SllPSHU0THJQYVpFREhibG1KRDBxOUQyVUZxS3JWQjZPU2tPMEV4TmdnSjBn?=
 =?utf-8?B?M1duS05YQWE0N1JTSVM0bk9zY3gzTGdJTFJRU29uaHJ5aFVyNWo1Z0lXVjEv?=
 =?utf-8?B?c0tVYnVoTUtuWkcwbFhPVTlJeFM0N095TFhJN1NyV2VTTytEdkNWY1pZelpx?=
 =?utf-8?B?MERsZ0FFaGduOFdsYisvcUZubFd1clEyQW1MN3BSQ1dvbHFISCsvOW1TU1Bm?=
 =?utf-8?B?ZVFyNnBFZ2xldk51cVd0ZnBjSjhCdnRjVlNrNTBKT3NpcG1Ea1dDNHBFeDRn?=
 =?utf-8?B?UWR6UkdSYTVLMDA0SkRqS00rN0VWMTRjTFdub2RXZ09GdVo5QkdDZTFHam5R?=
 =?utf-8?B?TCtDaUlWTmMzeFdBV0VvcitDRkJLWWRWQW50MVpnMDhnNkxiYUFsUjRwS08z?=
 =?utf-8?B?aDRKbVFWa1NFM1oxT0NIenFlL1k1V2JFU1hnb0U3M0xEanUxdHpVZm5WV0hB?=
 =?utf-8?B?WUFHMWlyOEZMTnpnSld3MDM2akNDYkhEdnV5N2hqRkhlTUFoTWo2aFRwUXdE?=
 =?utf-8?B?ZC9ENkNMcHJtL2FuUjRnQ1Z5RGZpazRFVGtSTGdlL21rSnNUVXp1cUIyWWRN?=
 =?utf-8?B?MG5kV01TbjZqdTY3OW9JSVoyUmtxOGZUT095ZXlwMEszOEJHVUpELzNwSkhG?=
 =?utf-8?B?QmNCVHNQZVp4aGhYRHJZcDExekx2NnBsdVhRcDNwdGhBNldkNm90blBzNHVt?=
 =?utf-8?B?bW1STGk5eXcrQ2Y5UTRPOXVFODlqNEQwcSsvemlZM1Bwei9iV2lkQUlMZUJh?=
 =?utf-8?B?VGMrekV4TmNIeUFuRDZEdFRYcEZOUWw4QnZzV0w2bXp2THAxVUtoOGx5cjlF?=
 =?utf-8?B?UEwxOGVONVBVTVJtQkNwSm0rc1owWTFleUZBRDNXeCtIVDlQTVB1dHhibmNM?=
 =?utf-8?B?bUMrdE5SV1pZMUNtSGF3ME1ubHlyMFJMWkQyZXdCeFhuZGlEMXNYdzcyM0NO?=
 =?utf-8?B?OE5rOHJwZ0RMSmFYMUFlTWw0THVIZVRVTVFVTU1oWU1UNkxjbVkyQk1VTlVq?=
 =?utf-8?B?TnpEcnFvL2E3TVRWK1FWWTIzS0JOV1lnKzRkYlZERktDejN4eHVvOWwyR0Zu?=
 =?utf-8?B?MFlZaDlKS09jV0NGSXdqR3F3RjZmTFJLV2JHbTBCR001cmlnQVl0ajZSUkho?=
 =?utf-8?B?dnYweXpIS0JiK1g2b2x0MThOdTVYWW5Fbk9wMHYwUDI1NkNPVWNHaktESDVQ?=
 =?utf-8?B?ZCtKNDk0TGltanlRam54QU5jNkkzaGFlSDV4eDZnR1pnNWZSUDVwNk9HRlV0?=
 =?utf-8?B?MTc4OGorak0yQ0JPR2NUR3VUQkd4ZUZFWSt3ZzNRNE1UdElPRDBXT1htdjBI?=
 =?utf-8?B?dzlVdGdSYVFPYTRjZytTWTYxVW5yWmVFZHQrbnhHYU9TTGtrSTBnUERNbi9J?=
 =?utf-8?B?RUdlZS93bkFPR1hnMk1hZlpqMWhSZ09BRGNLazNNei9FZmxDeTkwYkVCcTJT?=
 =?utf-8?B?QUZ6Tk84ckZGQ1c5YXlkSEc1bXpuMUR5cDlOajJLQzR4TUc5VzlmNXlacS9R?=
 =?utf-8?B?TUgxYko3cU1EVnNxMGdYZE5SNTZsR2JLbXc5dk0zd29vQVlZd080NW5xUEEr?=
 =?utf-8?B?M1lZQS85bmdJbVZsOHBFWFBxMXE3MkVUVG82TlNqd1JudkN6YlhzTjdpUzFV?=
 =?utf-8?B?T1o5WjdReFV4dGFHNU9RUWpmVSsvTWl5ZTZNTXlGb0hlTEUvaTYxUzIzeUk5?=
 =?utf-8?B?SjJ3cEI0U2FLbnlPOEJ2M1hTYjMzekczQlp6dkZBS0VlRytnWU5hYWxvSjNW?=
 =?utf-8?B?ZDB0NHBvdFNSUHdxNlNuaUtkakc1d2dGV0NFYVBNVWdEVDhkeTVYNXc3bEM5?=
 =?utf-8?B?a2lmbUpUeTVTUEh4akFuRE1TR1U3Q3poYTNxeHgwSnZXTGZzQURzK1lzUjdZ?=
 =?utf-8?B?bzNmMWtqcDI1Q3grSnN2VTAwWE5kNnNzNmdRWFZQY3hSS1BqY2ttTjlUU0RQ?=
 =?utf-8?B?a3o0MU11QkhwTGxRQnAvZXVxdFRJd3l2V0thRHpzYzYySkcwZjkzUzBnQnZm?=
 =?utf-8?B?dGIxWnJyL0NwL2huZzdqNmRkbDhLSVV5VU92Vkpld2ExQUUvbVg0UkdQVFYy?=
 =?utf-8?B?REJBTjN4R0Evc2tGN3pMSWxZSHdYYU8vNjgrUUwwWHNZdmF6TkNHTWE4ZzF1?=
 =?utf-8?B?R1lhSkYxMVdjSlpSTjlWQlp0TTc5cm55U2xoeDBUbkRGVWEvQlhkMVZqQ09N?=
 =?utf-8?B?M09qcEpJZUYzc0MxR0VVUzZ3QmFFNUprTWRVSFlIS0M5U3A3ekpDc25VTm5J?=
 =?utf-8?B?ZG54OGlqT0xBeU5tRXRBbmtKaTVhczlBbGpBMlBWcXgyNzE4QndyUGtMWHYz?=
 =?utf-8?Q?x+Fm3brna6KlNKsU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCCC0DFD6C0A6C42B33FC3853B4F300D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: epKXJZgGtGZaLKYLWcuG5KES4TTjpJPIYuUrixoNDI0+/GgGMxcR1h9lx12ofjZuxBUSxG+9oA61UWmtwFF64OLlfpgPq+HDseNiYx4HbGUApcPd9BkrNkeMn5fbr4IdZ6voUE6UphxVyFZAWDLiHd3Qp0VoXPfF9LgNCvsRELt7JhsdMglfZ9SlJbZRzEMOW/4YHxNrEORWIrMq+n0TdkZNRzkTp6tEkJxhmagUaBMfFJszbh05GVui2qI8tkVTScnVz6pUY+TetywVdz96KZbULNeJxQY91R0x9tIyjHyE2rn2nzVgisQPJRr0MbqX00U1GXU6OHUIbNXxbf5Elw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7494.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de32d43a-4e32-4c40-788b-08def7867041
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 08:56:31.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W47N0wi0zQFQpD6GWQ11NS5NUL1yr9QwoTqmujVW8qQI31XumC3PvfVfIfAapeav37UExIIAvZlkiBmk5/K9rhZ4ml+P7CIe7vlGs/x2UnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDEyOjM5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAwNCwgMjAyNiBhdCAwMzo1Nzo1MVBNICswMDAwLCBHcnVtYmFjaCwgRW1t
YW51ZWwgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI2LTA3LTMxIGF0IDEwOjI0IC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMzAsIDIwMjYgYXQgMDg6MTY6MzNQ
TSArMDAwMCwgR3J1bWJhY2gsIEVtbWFudWVsDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gT24gVGh1
LCAyMDI2LTA3LTMwIGF0IDE1OjA4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4g
PiAuLi4NCj4gPiA+IA0KPiA+ID4gPiA+IEkgd29uZGVyIGlmIHRoZSBQQ0kgY29yZSBzaG91bGQg
ZGlzYWJsZSBSTyBhbmQgTm9Tbm9vcCBvbg0KPiA+ID4gPiA+IFJvb3QNCj4gPiA+ID4gPiBQb3J0
cyBhY3Jvc3MgdGhlIGJvYXJkPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhpbmsgdGhpcyB3
b3VsZCBtYWlubHkgYWZmZWN0IE1NSU8gYWNjZXNzZXMgcGVyZm9ybWVkIGJ5DQo+ID4gPiA+ID4g
ZHJpdmVycywgYW5kIEkgc3VzcGVjdCBkcml2ZXJzIGV4cGVjdCB0aG9zZSB3cml0ZXMgdG8gYmUN
Cj4gPiA+ID4gPiBwZXJmb3JtZWQgaW4gb3JkZXIsIGUuZy4sIGlmIHRoZSBkcml2ZXIgd3JpdGVz
IERNQQ0KPiA+ID4gPiA+IGRlc2NyaXB0b3JzDQo+ID4gPiA+ID4gdG8gdGhlIGRldmljZSBmb2xs
b3dlZCBieSBhIHdyaXRlIHRvIGEgZG9vcmJlbGwsIHRob3NlIHNob3VsZA0KPiA+ID4gPiA+IHN0
YXkgaW4gb3JkZXIuwqAgSWYgdGhlIFJQIGhhcyBSTyBlbmFibGVkLCB0aG9zZSB3cml0ZXMgbWF5
IGJlDQo+ID4gPiA+ID4gcmVvcmRlcmVkLg0KPiA+ID4gPiANCj4gPiA+ID4gQXMgYSBkZXZpY2Ug
d3JpdGVyIEknZCBzYXkgd2UnZCBiZSByZXF1aXJlZCB0byBhZGQgYSBtZW1vcnkNCj4gPiA+ID4g
YmFycmllciBpbiB0aGF0IGNhc2UsIGJ1dCB3ZSB1c2Ugd3JpdGVsIHVzdWFsbHkuwqAgRG9lcyB0
aGF0DQo+ID4gPiA+IGluY2x1ZGUgYSB3cml0ZSB2cyB3cml0ZSBvcmRlcmluZz8gSG0uLi4NCj4g
PiA+IA0KPiA+ID4gTm90IGJlaW5nIGFuIG9yZGVyaW5nIGV4cGVydCwgSSdtIG5vdCBzdXJlIEkg
Y2FuIG1ha2UgYQ0KPiA+ID4gY29udmluY2luZw0KPiA+ID4gYXJndW1lbnQgZm9yIHdoZXRoZXIg
Uk8gc2hvdWxkIGJlIGVuYWJsZWQgb3IgZGlzYWJsZWQgZm9yIFJvb3QNCj4gPiA+IFBvcnRzLg0K
PiA+ID4gDQo+ID4gPiBNYXliZSBpdCdzIGVhc2llciB0byBhcmd1ZSB0aGF0IHdoYXRldmVyIHRo
ZSBSTyBzZXR0aW5nIGlzLCBpdA0KPiA+ID4gc2hvdWxkIGJlIHRoZSBzYW1lIGFjcm9zcyBhbGwg
cGxhdGZvcm1zIGJlY2F1c2UgZHJpdmVycyBzaG91bGRuJ3QNCj4gPiA+IGhhdmUgdG8gYWRhcHQg
dG8gcGxhdGZvcm0gZGlmZmVyZW5jZXMuDQo+ID4gDQo+ID4gVGhhdCdzIHBsYXlpbmcgc2FmZSwg
d2hpY2ggaXMgbmV2ZXIgYSBiYWQgb3B0aW9uIGlmIHRoZSBwZXJmb3JtYW5jZQ0KPiA+IGhpdCBp
cyBub3Qgc2lnbmlmaWNhbnQsIGJ1dCBJIGNhbid0IHRlbGwgSSBjYW4gY2xhaW0gdGhhdCBoYXZl
IGFueQ0KPiA+IGV4cGVydGlzZSBoZXJlLg0KPiANCj4gSSdtIG5vdCBhIFBDSWUgcHJvdG9jb2wg
ZXhwZXJ0LCBidXQgaXQncyBoYXJkIGZvciBtZSB0byBzZWUgaG93IE5vDQo+IFNub29wIHdvdWxk
IGJlIHVzZWZ1bCBmb3Igb3V0Ym91bmQgdHJhbnNhY3Rpb25zIGluaXRpYXRlZCBieSB0aGUgUm9v
dA0KPiBQb3J0Lg0KPiANCj4gRm9yIGluYm91bmQgRE1BIHRyYW5zYWN0aW9ucyB3aXRob3V0IE5v
IFNub29wLCB0aGUgUkMgY2FuIGVuZm9yY2UNCj4gY2FjaGUgY29oZXJlbmN5IGJ5IHNub29waW5n
IENQVSBjYWNoZXMgYmVmb3JlIGFjY2Vzc2luZyBtYWluIG1lbW9yeS4NCj4gSWYgYSBkcml2ZXIg
a25vd3MgdGhhdCB0aGUgbWFpbiBtZW1vcnkgdGFyZ2V0IGlzIHVuY2FjaGVkIG9yIGRvZXNuJ3QN
Cj4gbmVlZCBjb2hlcmVuY3ksIGl0IGNhbiBzZXQgTm8gU25vb3Agb24gaXRzIGRldmljZSB0byBi
eXBhc3MgdGhlIENQVQ0KPiBjYWNoZSBzbm9vcC4NCj4gDQo+IEJ1dCBmb3Igb3V0Ym91bmQgcmVh
ZHMgb3Igd3JpdGVzIGZyb20gdGhlIFJQLCB0aGUgY29tcGxldGVyIGlzIHRoZQ0KPiBQQ0llIGRl
dmljZSB0aGF0IGNsYWltcyB0aGUgdHJhbnNhY3Rpb24gYWRkcmVzcywgYW5kIEkgZG9uJ3QgdGhp
bmsNCj4gYW55DQo+IG90aGVyIGRldmljZSBvciBzd2l0Y2ggaXMgYWJsZSB0byBzbm9vcCBjYWNo
ZXMgYW5kIGFmZmVjdCB0aGUNCj4gcmVzcG9uc2UuDQo+IA0KPiBJIHN1c3BlY3QgdGhlcmUgKmlz
KiBwb3RlbnRpYWwgYmVuZWZpdCBmb3IgUmVsYXhlZCBPcmRlcmluZyBvbg0KPiBvdXRib3VuZCB0
cmFuc2FjdGlvbnMsIGJ1dCBJIHRoaW5rIGRyaXZlcnMgd291bGQgbmVlZCB0byBiZSBhd2FyZSBv
Zg0KPiB0aGlzLsKgIE1heWJlIHRoZSBMaW51eCBkcml2ZXIgbW9kZWwgYWxyZWFkeSBjb21wcmVo
ZW5kcyB0aGlzLCBhbmQgd2UNCj4gc2hvdWxkIGVuYWJsZSBSTyBvbiBSUHMuwqAgRWl0aGVyIHdh
eSwgSSB0aGluayB3ZSBzaG91bGQgY29uZmlndXJlIFJPDQo+IGV4cGxpY2l0bHkgc28gZHJpdmVy
cyBrbm93IHdoYXQgdG8gZXhwZWN0IGFuZCB0aGUgYmVoYXZpb3IgZG9lc24ndA0KPiBkZXBlbmQg
b24gd2hhdGV2ZXIgZmlybXdhcmUgZGlkLg0KDQpJIGRvbid0IGtub3cgd2hhdCB5b3VyIGRlY2lz
aW9uIHdpbGwgYmUgaW4gdGhlIGVuZCBhbmQgSSB1bmRlcnN0YW5kDQp0aGF0IHRoZSBkZWNpc2lv
biBhYm91dCB0aGUgcXVpcmsgaXMgcmVsYXRlZC4NCkZvciBub3csIEknbGwgdGVsbCB0aGUgcGVv
cGxlIHdobyB3YW50IHRvIHVzZSBCRTIwMCBvbiBKZXRzb24gdG8gdXNlIGl0DQpidXQgaXQnZCBi
ZSBuaWNlIHRvIGFsbG93IHRoZW0gdG8gdXNlIGEgdmFuaWxsYSBrZXJuZWwuDQoNCj4gDQo+ID4g
PiBSb290IFBvcnQgc2V0dGluZ3MgcG90ZW50aWFsbHkgYWZmZWN0IHNldmVyYWwgZW5kcG9pbnRz
LCBhbmQgSQ0KPiA+ID4gdGhpbmsgaXQgd291bGQgYmUgaW1wcmFjdGljYWwgZm9yIGRyaXZlcnMg
dG8gcmVxdWVzdCBSTyBzZXR0aW5ncw0KPiA+ID4gdGhhdCBtaWdodCBjb25mbGljdCB3aXRoIGVh
Y2ggb3RoZXIuDQo+ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIGFueSB2aXNpYmlsaXR5IGludG8g
d2hldGhlciBhbmQgaG93IG90aGVyIE9TZXMNCj4gPiA+IGFjdGl2ZWx5IGNvbmZpZ3VyZSBSb290
IFBvcnQgUk8gYW5kIE5vU25vb3AgYWNyb3NzIHRoZSBib2FyZCwNCj4gPiA+IGluZGVwZW5kZW50
IG9mIGluZGl2aWR1YWwgZHJpdmVycz8NCj4gPiANCj4gPiBJIGFza2VkIGludGVybmFsbHkgYW5k
IHdlIGRvbid0IHJlYWxseSBrbm93IHdoYXQgV2luZG93cyBkb2VzIHdoZW4NCj4gPiB0aGUgUENJ
IHJvb3QgcG9ydCBoYXMgdGhvc2UgYml0cyBzZXRzLiBXZSBtb3N0bHkgdGVzdCB3aXRoIEludGVs
IC8NCj4gPiBBTUQgc3lzdGVtcyBhbmQgdGhvc2Ugc3lzdGVtcyBoYXZlIHRob3NlIGJpdHMgY2xl
YXIuDQo+ID4gDQo+ID4gQlRXIC0gY2FuIHlvdSBwbGVhc2UgcG9pbnQgdG8gdGhlIHJlbGV2YW50
IHBhcmFncmFwaCBpbiB0aGUgUENJDQo+ID4gc3BlYw0KPiA+IHRoYXQgc3RhdGVzIFJlbGF4ZWRP
cmRlciBhbmQgTm9Tbm9vcCBzaG91bGQgYmUgc2V0IGJ5IGRlZmF1bHQgb24NCj4gPiB0aGUNCj4g
PiBSUD8NCj4gDQo+IFRoaXMgaXMgaW4gUENJZSByNy4wLCBzZWMgNy41LjMuNDoNCj4gDQo+IMKg
IEVuYWJsZSBSZWxheGVkIE9yZGVyaW5nIC0gSWYgdGhpcyBiaXQgaXMgU2V0LCB0aGUgRnVuY3Rp
b24gaXMNCj4gwqAgcGVybWl0dGVkIHRvIHNldCB0aGUgUmVsYXhlZCBPcmRlcmluZyBiaXQgaW4g
dGhlIEF0dHJpYnV0ZXMgZmllbGQNCj4gb2YNCj4gwqAgdHJhbnNhY3Rpb25zIGl0IGluaXRpYXRl
cyB0aGF0IGRvIG5vdCByZXF1aXJlIHN0cm9uZyB3cml0ZSBvcmRlcmluZw0KPiDCoCAoc2VlIMKn
IFNlY3Rpb24gMi4yLjYuNCBhbmQgwqcgU2VjdGlvbiAyLjQpLg0KPiANCj4gwqAgQSBGdW5jdGlv
biBpcyBwZXJtaXR0ZWQgdG8gaGFyZHdpcmUgdGhpcyBiaXQgdG8gMGIgaWYgaXQgbmV2ZXIgc2V0
cw0KPiDCoCB0aGUgUmVsYXhlZCBPcmRlcmluZyBhdHRyaWJ1dGUgaW4gdHJhbnNhY3Rpb25zIGl0
IGluaXRpYXRlcyBhcyBhDQo+IMKgIFJlcXVlc3Rlci4NCj4gDQo+IMKgIFdoZW4gbm90IGhhcmR3
aXJlZCB0byAwYiwgdGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhpcyBiaXQgaXMgMWIuDQo+IA0KPiAN
Cj4gwqAgRW5hYmxlIE5vIFNub29wIC0gSWYgdGhpcyBiaXQgaXMgU2V0LCB0aGUgRnVuY3Rpb24g
aXMgcGVybWl0dGVkIHRvDQo+IMKgIFNldCB0aGUgTm8gU25vb3AgYml0IGluIHRoZSBSZXF1ZXN0
ZXIgQXR0cmlidXRlcyBvZiB0cmFuc2FjdGlvbnMgaXQNCj4gwqAgaW5pdGlhdGVzIHRoYXQgZG8g
bm90IHJlcXVpcmUgaGFyZHdhcmUgZW5mb3JjZWQgY2FjaGUgY29oZXJlbmN5DQo+IChzZWUNCj4g
wqAgwqcgU2VjdGlvbiAyLjIuNi41KS4gTm90ZSB0aGF0IHNldHRpbmcgdGhpcyBiaXQgdG8gMWIg
c2hvdWxkIG5vdA0KPiDCoCBjYXVzZSBhIEZ1bmN0aW9uIHRvIFNldCB0aGUgTm8gU25vb3AgYXR0
cmlidXRlIG9uIGFsbCB0cmFuc2FjdGlvbnMNCj4gwqAgdGhhdCBpdCBpbml0aWF0ZXMuIEV2ZW4g
d2hlbiB0aGlzIGJpdCBpcyBTZXQsIGEgRnVuY3Rpb24gaXMgb25seQ0KPiDCoCBwZXJtaXR0ZWQg
dG8gU2V0IHRoZSBObyBTbm9vcCBhdHRyaWJ1dGUgb24gYSB0cmFuc2FjdGlvbiB3aGVuIGl0DQo+
IGNhbg0KPiDCoCBndWFyYW50ZWUgdGhhdCB0aGUgYWRkcmVzcyBvZiB0aGUgdHJhbnNhY3Rpb24g
aXMgbm90IHN0b3JlZCBpbiBhbnkNCj4gwqAgY2FjaGUgaW4gdGhlIHN5c3RlbS4NCj4gDQo+IMKg
IFRoaXMgYml0IGlzIHBlcm1pdHRlZCB0byBiZSBoYXJkd2lyZWQgdG8gMGIgaWYgYSBGdW5jdGlv
biB3b3VsZA0KPiDCoCBuZXZlciBTZXQgdGhlIE5vIFNub29wIGF0dHJpYnV0ZSBpbiB0cmFuc2Fj
dGlvbnMgaXQgaW5pdGlhdGVzLg0KPiANCj4gwqAgRGVmYXVsdCB2YWx1ZSBvZiB0aGlzIGJpdCBp
cyAxYi4NCg0KVGhhbmsgeW91Lg0K
