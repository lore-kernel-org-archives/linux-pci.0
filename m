Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905212;
	b=EWiloie9muGw1jw3KM1l+325vXMc8NLEA0Xa/z6tUPSrBanJifiiC30SADHnWVE63nWL
	 wEQ9FMVySxu7KNYLb2hEFKuS6bTFA5vuVhSvx+tT+JNNhzE4cyErbMG/qgA+3hCCKukKW
	 30+9cTpbv2tEy+texXb2RLWup+JTgcqnZqfQThn4ES/UvDmjyyVli1tbZp0jSaf03rD99
	 6EXspWcSiJGq2iLsXE4zaM8WDRp4UxQzPA6kHYYvWc8SmMDNKLIZJtCKohm9qn/ddNWZa
	 s7Ar6nhgwBXyTfrKrfkd+uxtrvNSIBV7YFEt3n+a/IVz2VkI+jEitgtEy85P4F1uZDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905212;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AYZg3Aar9TJRUOm8lm7zrvRWGMOCLOtUa64R/qqxud0=;
	b=O0p/yadIfyPXk9Yd5iIJziDwvCiMWnpbh4HDqCAm7PzDbrOTYmgmu5sUSwRkyxyUzQbI
	 BVoHE6shdnXXY43V81NAzTt3OjMvrXyAPnMjwkG2cOUBtI6RLiZ8CQ5YrPHlHxHLmiV1z
	 9RISVgSH7RuDF1moXrELlpDeewIDSP+k8Y6fk4HREa24iAjAW+09bMYkfBQ8Bs2x7oAHD
	 qvHH4fWL6UXvDoMyETi+qQmAPduoijkgjqfWtTi2cgHPWuELh1CLg5wkaiAboxpN1RIOw
	 HvywvnwbdH1ZvajdM79uC/yNp4BVUnjVQuRXbnd8FoSqpzgV8L07L2oK5aW7In98hdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iNyMaeXJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E5606D80F;
	Thu,  5 Nov 2026 19:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB2E5606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iNyMaeXJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1dezdX2euD6s1ss82dKIXO5jFXNGY9GhayYn88WmEc4sSbqlWoytaFggfrahd83NCKCXT0bnODiQRCd3QNLO4wCI376h55Ucu/HrtYt4QQRJvS4JZiR0lsKJpvyAnGYqsfP3610IjJM133f4dDsLi295eLXHbBwt5JyRCzEAnmL2FUOy/M62KKUzHtU/8at+9wb0ObwTWzCvvsG3XhLLCx3BDXpbBj07804b6gbX6b3PY6TI/BujuMX9n0OJgxKe6kOkivf3UYzocoUuYKiMPTlvOcYfIriArqq6sDOU7qfelHRMy9M2SjQ7GE4Izl8DSZcXdxf+nW3iAJ8/BxziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYZg3Aar9TJRUOm8lm7zrvRWGMOCLOtUa64R/qqxud0=;
 b=Drlk0ISYf0aasmq4Gyl8t1WY8UtecJnIvhyAO1P9QShM7KPNNaCB3K0epU5mUyhE1SjWZ3khaBC+o/KWGdsKsfkWwcZrbP7DeUES2YJw3+2TrFDwu5VlMAJeUEgiBMdC8YREYgMAcGHeC9IwfejZk3A56Ny+NeIug+z/kLaXRgNfDrN5wX+t0XK3agwZ0klk23AOGwJkySiwRTpf45kvq+fkbBuvjMuBnGCX/zEi9f2PQTgg1IGvPVIXwD0LUKDHHEyYKTdJrPZexIwR6VJ7VqhiSrRzY6bMgKm2Jy/fk6nqcG8GqUT5AuPROGrq4UUO8ZOOfF1qiOYhb3x7CYZFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYZg3Aar9TJRUOm8lm7zrvRWGMOCLOtUa64R/qqxud0=;
 b=iNyMaeXJW/FNYAp9aMGvPDNvOlLsDUP7HV4pH5pCnQoo5ypFaeQPS3mNlB4VeLIjMNxUe7QGwnTTf2+PJ9McYPKAx+ERpH+curxRqYh89WeE29kBYCGJh5JuzfZLG+YFT92zTvoM754LMj3kN3oL7sJwcWTx2J1K3YRDeaKRmowBYyD3sa8v4IFKy/yN0D2Qaz7KlmvFqmURTMqTl3MauzwDT4Vi4Hew6XRRk89fmtPAICoyABucDIsrw23Ef4FKAP3elQPDwXYTsCohGin7rdbWAKFHbnTw6tVUgI9SEpl84DA7lZO0Ty/qi6R/8Lbpt+abo5v2BViW7HL1bEByRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:54 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:54 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 13/19] cxl: Validate and synchronize HDM ranges around reset
Date: Thu,  5 Nov 2026 18:59:11 +0000
Message-ID: <20261105185917.2667656-14-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: f2677a36-b631-44b7-96ec-08df3b6efa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|5023799004|261026140227099003|56012099006|261022113327099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102130727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QOEwyk+yrk2gXP/+tInVoc9wnE+5SI3XPe696ycg8U72M0Mq/qft1mhl6vVqWGygQdiECRWuCsS4+4wYpmxYE6eXJMe7V7Xb9lFkt93LWz3xlyX44twb7qLZDjM+EAUc9NnTUsD1HKmL93dWA/2nUdRYPMMpOgvQ6Hg3kqM6sd0Wzkx9jbZja2jHHRgvKBh7JwVLAZeKK7Wc0k16BnRknNGLbFuiLlf7qnyKUQs0yp9/id4jyRIDj6HDp1l3GFSZc5Xd4DcSiRMUuSk52E6foXOzKUVPmovJBBpj5b/8hLjkec8XG4oibOzDkzGSpEQPzRyuS58PHYyaDuTkRTQRux5C6GNk5LDh6Kk5tJHUTFlWvOKE+ghVSAkmp4ckjagKzu5wjeoViOGKLRZF1ojzanCzbjjn/7DWxv2SjwsSBUKwDT8A7vprpLBp2gu5KkEoaXvrpK7DIuURLJYrOgL2XMBmqXDlL5nPoBVP8ClS64Q85n8kNPy8PZGXScYFgckDlTkQv/gZNlnnpWIYN7RJMfMARtmKosGQ9+KFaswQnnXc3ttu/bqDGAdrUYkvOeCFiBj1BTais+OnB5aV+DQwIX4N5AObR4iDymBrfc62A7TRKr26CFGp/w0cPVdpIAw2FGE8wiy7swMNVNJuAnWu0JC5oLddzBidvGNxsavwJTzsT7GaMmr8B5+296Tx1iURn7QzoEtSO+T8QTKaBlVHtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(5023799004)(261026140227099003)(56012099006)(261022113327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102130727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqVvKvoD1SYMoDfpqqTQ0tc8nJQNuvX6hiDbN2FzovMV9CUztYY0lZogQhGp?=
 =?us-ascii?Q?Hlb1sLMxITYnXYJKkQoKUMuxyToqN21hjTDtJ7pH3cJ/EQa98Ryz5OxGHaXr?=
 =?us-ascii?Q?qJ9iyU1yYzdgdW/Jrg575SiUsKYglWHHVNErEazYidPKyX9I0KZqgjpsBK76?=
 =?us-ascii?Q?GCkThrJIxFnRVL4YrVKqhjRDBTvnokG0hQYbQ78VcjFtaBFeL0x9yaRLSSIF?=
 =?us-ascii?Q?BYIuNqaR+jEi0ef4RPSLeuFYLuZwvj1OXwIJ4h6UCxYMF/6YA6xNRd2EHJ9r?=
 =?us-ascii?Q?azb15YfTXYlCxgmNjSWby1Jt7OgsbP+la1BLuaM2Y3Eg8dcAWBYWwFmktw/s?=
 =?us-ascii?Q?FOkjDLODNwzwrbD9rHLKdJpt/CW1zwJRlX6gOMTvfbbBaoA54P0hSutuSzya?=
 =?us-ascii?Q?S3b1A65Ldw6Rhryj6rhtcF7qicJ6ydW7suD1mpuNYI8HdTIGvTT8q7EXgcCk?=
 =?us-ascii?Q?umevV4KAT9FFoj0YB9HEXffU9jsHAqKGirfzDQyXzmxDPjh4G229Kjhc5VC2?=
 =?us-ascii?Q?8cy17u18xDQ+r4xUHd5T11s/0vKhqmkTnMaVUfwvexa72YdOUlScyvpJDz+U?=
 =?us-ascii?Q?fX7fd8KlTKPN1L3ujPHymMdqTzTgOVGE4RzdzaqmfTWQxQrMuOXv9xqaVkXk?=
 =?us-ascii?Q?0KEJxt1mdPnffj9FLsFW/bqfc95N2XV8+VKZbICyti2jE02FT2u3PFYKQZLf?=
 =?us-ascii?Q?2s47epT6rKlx9d2vEuOxk0T/bnONfwsjEeItKVZ0AH1a4aWnOWTuJqMQi7BL?=
 =?us-ascii?Q?B7bPxppBMVKyhTerIVU6Q6T1Ye+aNuW+LVMQbjJpDi5T99PYJ1Hj+IQ94aHQ?=
 =?us-ascii?Q?hTiKSbRf5ByO3F23E1ZP/AVVcocU3vM7j49pxJHzLCOszOQdUKQyskp8AyC0?=
 =?us-ascii?Q?8sSKeTjbOLgR1mnfQUp5jxC3jICiOdXItXCnnQM95LjcvPVAr/ei78hB5C+O?=
 =?us-ascii?Q?lqmBH0xKvVcHjA5yswCCus7OOoMvvv/qhCAZq4jJdjFyN4qrF4PZD666Z8wI?=
 =?us-ascii?Q?vdD2QvZl1it2bo8A8mZiED0eP0dpcYPIw067887iNP2G+2x6DjEhPBFSQH+c?=
 =?us-ascii?Q?zrTxb4SOxvUxHGyFq4MP8vaefFnkX8fep3rtqhbJp4tWezkoJmb17a2RGIny?=
 =?us-ascii?Q?YavJfPibzd44w/dOwOS1ycxCZ5YpMePZUfkDF9zMvoVfrUHW+bW63TUPmj36?=
 =?us-ascii?Q?ShtZSWqjkJzqamxOTzr6wb8w5TOiNqirtHuGRsAO4Y8MgIu+Krjo3SiLio12?=
 =?us-ascii?Q?JJMtditrECcu0hgW2VM4701rSXSv4YDks9QV+d6U37xFnuOpodMVNXUmFKWg?=
 =?us-ascii?Q?yfNOY7y0Z//p9V36CHB8tkTRmDPmOqbNu5g9GD+yW74HsXUHMlUuJYF2rvhu?=
 =?us-ascii?Q?0YEBtgcTDQs23TZGqGWki66aLHy3cGc7hmZoXSY3ienEc/UOWK1Y5aHjAhIW?=
 =?us-ascii?Q?ex2MelRU7Rymt1Qr6LWVbqKXKuPN/HmUCLzu3h2jhw5WZ/IpnbKI2hilNP5N?=
 =?us-ascii?Q?ZVyNMnOty9D2Usva3RiipoO2e/DHOCk/rBg5IhUg4Oa0tDjaySKmMeisOGHY?=
 =?us-ascii?Q?xt3zbTQoE3ZKSiwN1dZ/iYcvU8/7/eMVfKHxC064yO/GqteBEpVHULRttW8I?=
 =?us-ascii?Q?z3MsA3D9gJphP4jAROKIQi5RXXsR8VO119OLQu6b/KVvQHXnuB+Bq9TVnWgR?=
 =?us-ascii?Q?FJ/nQ0LvMInzu/w340UA5J6LXm5KX+qu7uTXBtAbhyGdLrHhNw85jpk2z/H5?=
 =?us-ascii?Q?7WuG9IRJqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2677a36-b631-44b7-96ec-08df3b6efa29
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:54.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuTokUNbQAQ0SvvctPSNfBsAUnmcb+tb2muFMgcNtc7v7LexTqxQ9GodCA5DSNE7sfbyx1NSIAr9wRWokzW7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

Refuse reset unless enabled system-physical HDM ranges can be reserved
exclusively and CPU-cache invalidation is available. Invalidate before
reset and again before ending IOMMU exclusion, holding range reservations
until the second invalidation completes. A later patch places state
restoration before the second invalidation.

Userspace is expected to offline CXL.mem users before reset. The
reservation enforces this for claimed ranges: the reset fails while a
conflicting resource is claimed, and no one can claim the range during
the reset. It cannot see accesses by code that uses the range without
claiming it, which the offline expectation also covers.

Reject normalized-addressing decoders because their cached ranges are not
system physical addresses. Record Normalized Addressing in the cache when
region discovery sets it, since the cache is filled earlier. A reset that
takes its snapshot between endpoint probe and that update can still
miss it.

Ignore zero-size decoders because they map no address range. Refuse reset
when the device decodes memory through its DVSEC ranges instead of HDM
decoders, since the cache holds no range to reserve for that memory.

Hold the global cxl_rwsem.region write lock across snapshot, reset and
restoration to keep the decoder state and reserved ranges stable. This also
blocks region and decoder sysfs, region probe, poison operations, sanitize
and region-aware event tracing across CXL devices. The Memory Clear wait
lasts up to the timeout the device advertises, at most 100 seconds; cache
flushes and other reset work extend the hold.

Allow the existing CXL_REGION_INVALIDATION_TEST option to bypass missing
CPU cache invalidation for test environments without a provider.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Changes in v17:
- State that userspace is expected to offline CXL.mem users before
  reset, and what the HPA reservation does and does not cover (Richard)
  https://lore.kernel.org/linux-cxl/auQRSOGWEDzB_qjF@MWDK4CY14F/
- Record Normalized Addressing in the cached decoder when region
  discovery sets it, and note the short window before that update
  (Sashiko)
  https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=13
- Annotate cxl_region_quiesce_lock()/unlock() and __cxl_reset_execute()
  for context analysis (Sashiko)
  https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=15
- Describe the region lock hold as bounded by the advertised reset
  timeout, at most 100 seconds, plus cache flushes (Richard)
  https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
---
 drivers/cxl/Kconfig          |   3 +-
 drivers/cxl/core/hdm_state.c | 266 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region.c    |  14 ++
 drivers/pci/cxl.c            |  87 ++++++++++--
 include/cxl/hdm.h            |  47 ++++++-
 5 files changed, 406 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8b08bfdc4982..e927e69a3f7b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -226,7 +226,8 @@ config CXL_REGION_INVALIDATION_TEST
 	  invalidation mechanism. For example usage of wbinvd is restricted to
 	  bare metal x86. However, for testing purposes toggling this option
 	  can disable that data integrity safety and proceed with enabling
-	  regions when there might be conflicting contents in the CPU cache.
+	  regions or performing CXL reset when there might be conflicting
+	  contents in the CPU cache.
 
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index 9def4a7439c9..51df56377f7a 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,8 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
@@ -13,7 +19,8 @@
 
 /*
  * CXL state that must stay available while no CXL driver is bound: the CXL
- * locks and the per-device HDM cache filled during PCI enumeration.
+ * locks, the per-device HDM cache filled during PCI enumeration, and the
+ * region quiesce used around a reset.
  */
 struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
@@ -87,6 +94,27 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
 
+/**
+ * cxl_hdm_cache_set_normalized() - record Normalized Addressing in the cache
+ * @pdev: endpoint that owns the cache
+ * @id: endpoint decoder id
+ *
+ * Normalized Addressing is determined during region discovery, after the
+ * cache was filled, so the cached decoder lacks it. Record only that flag: the
+ * decoder's software lock must not become a hardware Lock On Commit when the
+ * cache is restored.
+ */
+void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (!pdev->hdm || id < 0 || id >= pdev->hdm->decoder_count)
+		return;
+
+	pdev->hdm->settings[id].config.flags |=
+		CXL_DECODER_F_NORMALIZED_ADDRESSING;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_normalized, "cxl_core");
+
 /**
  * cxl_hdm_cache_release() - unpublish and free cached HDM state
  * @slot: cache pointer owned by the device
@@ -105,3 +133,239 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
 	}
 	kfree(info);
 }
+
+/**
+ * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
+ * @slot: cache pointer owned by the device
+ *
+ * Return: true if the published state shows CXL.mem enabled while HDM
+ * decoders are globally disabled, so that the device decodes memory through
+ * its DVSEC ranges, which the cache does not describe.
+ */
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
+	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
+}
+
+/**
+ * cxl_hdm_cache_snapshot() - copy the published HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
+ * is published, or another ERR_PTR() on failure.
+ */
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
+{
+	struct cxl_hdm_info *info, *copy;
+	size_t size;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return ERR_PTR(-ENXIO);
+	if (info->decoder_count <= 0)
+		return ERR_PTR(-EINVAL);
+
+	size = struct_size(info, settings, info->decoder_count);
+	if (size == SIZE_MAX)
+		return ERR_PTR(-EOVERFLOW);
+
+	copy = kmemdup(info, size, GFP_KERNEL);
+	if (!copy)
+		return ERR_PTR(-ENOMEM);
+
+	return copy;
+}
+
+void cxl_region_quiesce_lock(void)
+	__acquires(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	down_write(&cxl_rwsem.region);
+	__acquire(cxl_region_quiesce);
+}
+
+void cxl_region_quiesce_unlock(void)
+	__releases(cxl_region_quiesce)
+	__context_unsafe(token maps to cxl_rwsem.region)
+{
+	__release(cxl_region_quiesce);
+	up_write(&cxl_rwsem.region);
+}
+
+/*
+ * Bound the range twice: request_mem_region() takes resource_size_t while
+ * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
+ * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
+ * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
+ * resource_size_t is 64-bit, which the !len test catches.
+ */
+static int cxl_hdm_range_validate(const struct range *hpa_range)
+{
+	u64 len = range_len(hpa_range);
+
+	if (!len)
+		return -EINVAL;
+	if (hpa_range->end > RESOURCE_SIZE_MAX || len > RESOURCE_SIZE_MAX ||
+	    len > SIZE_MAX)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q,
+			     const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range, *next, *new_range;
+	int rc;
+
+	rc = cxl_hdm_range_validate(hpa_range);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(range, &q->ranges, list)
+		if (range_contains(&range->hpa_range, hpa_range))
+			return 0;
+
+	new_range = kzalloc_obj(*new_range);
+	if (!new_range)
+		return -ENOMEM;
+
+	new_range->hpa_range = *hpa_range;
+	new_range->len = range_len(hpa_range);
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		if (range_contains(hpa_range, &range->hpa_range)) {
+			list_del(&range->list);
+			kfree(range);
+		}
+	}
+	list_add_tail(&new_range->list, &q->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q,
+				  const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	for (int i = 0; i < snapshot->decoder_count; i++) {
+		const struct cxl_decoder_config *config =
+			&snapshot->settings[i].config;
+
+		/* A committed zero-size decoder maps no HPA. */
+		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
+		    !range_len(&config->hpa_range))
+			continue;
+
+		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
+			return -EOPNOTSUPP;
+
+		rc = cxl_hdm_range_add(q, &config->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+
+		range->res = request_mem_region(hpa_range->start, range->len,
+						"cxl_reset");
+		if (!range->res)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range;
+	int rc = 0;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
+		pr_info_once("CXL reset: bypassing CPU cache invalidation for testing\n");
+		return 0;
+	}
+
+	list_for_each_entry(range, &q->ranges, list) {
+		const struct range *hpa_range = &range->hpa_range;
+		int rc2;
+
+		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
+		rc = rc ?: rc2;
+	}
+
+	return rc;
+}
+
+/**
+ * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
+ * @q: quiesce state to initialize
+ * @snapshot: HDM state from cxl_hdm_cache_snapshot()
+ *
+ * Reserve every enabled system-physical range in @snapshot exclusively, then
+ * write back and invalidate CPU caches for them. Call
+ * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	INIT_LIST_HEAD(&q->ranges);
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
+		return -ENXIO;
+
+	rc = cxl_hdm_ranges_collect(q, snapshot);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(q);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+/* Evict lines fetched during reset before DMA exclusion ends. */
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+{
+	return cxl_hdm_ranges_invalidate(q);
+}
+
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
+{
+	struct cxl_hdm_range *range, *next;
+
+	list_for_each_entry_safe(range, next, &q->ranges, list) {
+		list_del(&range->list);
+		if (range->res)
+			release_mem_region(range->hpa_range.start,
+					   resource_size(range->res));
+		kfree(range);
+	}
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8cfc06df3134..b06dd9b901f0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -12,6 +12,7 @@
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
 #include <linux/string_choices.h>
+#include <cxl/hdm.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -3840,6 +3841,19 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
+	/*
+	 * Translation setup may have marked the decoder as Normalized
+	 * Addressing, after the PCI cache was filled. Record it for reset.
+	 */
+	if (cxled->cxld.config.flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
+		struct pci_dev *pdev __free(pci_dev_put) =
+			cxl_port_get_uport_pci_dev(cxled_to_port(cxled));
+
+		if (pdev)
+			cxl_hdm_cache_set_normalized(pdev,
+						     cxled->cxld.config.id);
+	}
+
 	/*
 	 * Ensure that, if multiple threads race to construct_region()
 	 * for the HPA range, one does the construction and the others
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 9ac5948f595b..af8ec8db20f1 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -23,6 +24,13 @@
 
 #include "pci.h"
 
+struct cxl_pci_cache {
+	struct cxl_hdm_quiesce quiesce;
+	u16 saved_ctrl2;
+	/* A cache-policy write was attempted and may need undoing. */
+	bool cache_disabled;
+};
+
 /* Find the CXL Device DVSEC and read its capability register. */
 static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
 {
@@ -335,6 +343,23 @@ static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
 	return rc;
 }
 
+/* Shared range reservation, host invalidation, and device cache writeback. */
+static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
+				   const struct cxl_hdm_info *snapshot,
+				   struct cxl_pci_cache *cache)
+	__must_hold(cxl_region_quiesce)
+{
+	int rc;
+
+	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
+	if (rc)
+		return rc;
+
+	/* Track an attempted change so partial failures still restore policy. */
+	cache->cache_disabled = true;
+	return cxl_reset_disable_cache(pdev, dvsec, cap);
+}
+
 static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
 {
 	unsigned long deadline;
@@ -389,7 +414,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
 				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
 }
 
-static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
+			      struct cxl_hdm_quiesce *q)
+	__must_hold(cxl_region_quiesce)
 {
 	int rc, rc2;
 
@@ -414,29 +441,61 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
 	rc = rc ?: rc2;
 
+	rc2 = cxl_hdm_quiesce_flush(q);
+	if (rc2)
+		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
+	rc = rc ?: rc2;
+
 	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
-static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
+	__must_hold(cxl_region_quiesce)
 {
-	u16 saved_ctrl2;
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
+	struct cxl_pci_cache cache = {};
 	int rc, rc2;
 
-	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+				  &cache.saved_ctrl2);
 	if (rc)
 		return pcibios_err_to_errno(rc);
-	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+	if (PCI_POSSIBLE_ERROR(cache.saved_ctrl2))
 		return -ENODEV;
 
-	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot)) {
+		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
+			PTR_ERR(snapshot));
+		return PTR_ERR(snapshot);
+	}
+
+	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, &cache);
+	if (rc && !cache.cache_disabled) {
+		pci_err(pdev, "failed to prepare CXL reset ranges: %d\n", rc);
+		cxl_hdm_quiesce_destroy(&cache.quiesce);
+		return rc;
+	}
 	if (!rc)
-		rc = __cxl_reset_execute(pdev, dvsec, cap);
+		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
 	/* Restore cache policy after any attempt to disable caching. */
-	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
+	cxl_hdm_quiesce_destroy(&cache.quiesce);
 	return rc ?: rc2;
 }
 
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	cxl_region_quiesce_lock();
+	rc = cxl_reset_quiesced(pdev, dvsec, cap);
+	cxl_region_quiesce_unlock();
+
+	return rc;
+}
+
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	u16 dvsec, cap, ctrl;
@@ -463,5 +522,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
+	/* The cache is owned by @pdev and does not require a bound CXL driver. */
+	if (!pdev->hdm)
+		return -ENOTTY;
+
+	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
+	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
+		return -ENOTTY;
+
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
+		return -ENOTTY;
+
 	return cxl_reset_execute(pdev, dvsec, cap);
 }
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 0604dcc439c9..49b36a45c682 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -3,10 +3,14 @@
 #ifndef __CXL_HDM_H__
 #define __CXL_HDM_H__
 
+#include <linux/list.h>
 #include <linux/types.h>
+
 #include <cxl/cxl.h>
 
+struct device;
 struct pci_dev;
+struct resource;
 struct cxl_endpoint_decoder;
 
 /**
@@ -45,7 +49,6 @@ struct cxl_hdm_info {
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
-struct device;
 
 int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
 				 resource_size_t size);
@@ -55,6 +58,48 @@ void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled);
 int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
+void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id);
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
+bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
+struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+
+/*
+ * Region quiesce blocks CXL region commit and teardown, and with them decoder
+ * reprogramming, while reset handling captures or restores HDM decoder state.
+ */
+token_context_lock(cxl_region_quiesce);
+
+/**
+ * struct cxl_hdm_range - HPA range held exclusively across a reset
+ * @list: entry in &cxl_hdm_quiesce.ranges
+ * @hpa_range: system physical address range decoded by the device
+ * @len: length of @hpa_range
+ * @res: reservation of @hpa_range, once requested
+ */
+struct cxl_hdm_range {
+	struct list_head list;
+	struct range hpa_range;
+	u64 len;
+	struct resource *res;
+};
+
+/**
+ * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
+ * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
+ */
+struct cxl_hdm_quiesce {
+	struct list_head ranges;
+};
+
+void cxl_region_quiesce_lock(void)
+	__acquires(cxl_region_quiesce);
+void cxl_region_quiesce_unlock(void)
+	__releases(cxl_region_quiesce);
+int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
+			    const struct cxl_hdm_info *snapshot)
+	__must_hold(cxl_region_quiesce);
+int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
+	__must_hold(cxl_region_quiesce);
+void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
 
 #endif /* __CXL_HDM_H__ */
-- 
2.43.0

