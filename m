Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021116.outbound.protection.outlook.com [52.101.95.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29373C0C;
	Mon,  2 Feb 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041594; cv=fail; b=YaJoXwTtnHLtjziepug4oPuNpxt39osZjU+AODCam6kgKqu7srabKxGN0931+8RkyWZe6nuwGQ/Q4bmNbKbZBlQwatYxvuQQ5VY0Hu0zZ3/7pmpShIRee7KhAB+9pvvb5c68yXcGPckZdhz8klIV1CYq0zTYlEplVoCBsnVP630=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041594; c=relaxed/simple;
	bh=PTLdB4z+3zQP2vmmYsqtE+vkPiC5iEuSDVMB6LzqSew=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=i1qrgLkOGzzsJGhbGCH5M1pxuTHIFTnwoumgqttxjZN8iEaOXad60tBpcthnGni92Ymv9gYQIF1Fm3psB00qNnEvpygjle1IjGJQYWOWiYtT+vkx3H7gHskvp4h5SxWmChUtSA0Xq3R0FIDvLw66xtVWpFbJIdMdNKM8n5075ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YEhMe6zZ; arc=fail smtp.client-ip=52.101.95.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YEhMe6zZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJE3brddKHC271VbYwmQFsZ/Fd/UGRCokIj6I1f44OrkAmNJsNNa1xwZ6WbPZbwpTzwqjiTCBds2EUHTSXanoGYwLIIlp02Cwd3cLknYZF3oQJHvqe/mE8fLKanviRbm+EsFeX2A5lIqM7HpuoJwd9EmbM6emxE797zDFAHnWhTmHehzTNOJ9j1llEUzIaK4Xjb0y5fMbDLnGF5BtsddnBQkNHFEvrZ5dTw9a13kupDgP9CxnEiku3nyVRrF2FyYkaFc+ycSKM6APiW8gRQg5lZlEjtX4RV+Po/ETO+5H44Y0tfZRv+a1xzBg9yK5gVUQqeKtMKjQpx0O2hDh2iXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaaKjn/1yEN0PUwy/v2gts1JwYagkwCHFhwmQ0JzX+A=;
 b=ncbXQicvWDugXTe05QbUzO7KzIqcAWvyw5hHbsUawr5C8qkT6xGcHXG/1XY8U1Dv3R0FjsHLq5Mlrjs+OiIhdpysY0PjUVIUdcMH6NhWsgottVChmLIXJQsx9FzRYDTGQyp2bN4k4pMXBNwdG+QrKpalpZ6pOCPwI1TlVgcktSqSSS29RMELWSUdrwbKHKvPtsiVroMCW9jtiZxfa9BX8Z5YwIPQ24ucv++O+8QmpfevlUQSnwiCyxkXSMFUWx4KZWdKU8lD9StGm/iZ6XIjwMImQ7u5I23jl0k2U1eVMsOpsYDPFMiMK1BBIDy4MuRwOn3Yk6S9sQG21wOhzMR1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaaKjn/1yEN0PUwy/v2gts1JwYagkwCHFhwmQ0JzX+A=;
 b=YEhMe6zZEk/0Tp5GlRKRtCIxSIs7R6Uq34WcWEVTQjX/rbkvq0SlM/Yiwq0/GMkyqOUhVge9/NQrv+1IcTgfXXsSRvf2mlvNSDXU08I8kqamMgtJW9OIPRhTEupBIxvbFumwos4UVgEg2xc9SpXbSqHVy9BbDawTYC+IgsvZguE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7891.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:13:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:13:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 14:13:08 +0000
Message-Id: <DG4JDJZB7BI0.39DIJGBNAI3RA@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <gary@garyguo.net>, <dirk.behme@gmail.com>, <lianux.mm@gmail.com>
Subject: Re: [PATCH v5 0/2] rust: pci: add capability lookup helpers
From: "Gary Guo" <gary@garyguo.net>
To: "Zijing Zhang" <zijing.zhang@ry.rs>, <dakr@kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
In-Reply-To: <20260201074248.1629393-1-zijing.zhang@ry.rs>
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: e752c0b7-aae1-4efe-0f4b-08de626530f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eC9oc2xZL09XaGRkVWl0anZuL0NsZ1d3VElRY1Z5eFJYb1Y5eis4SnAzc0Z1?=
 =?utf-8?B?UXl6VkozKzBFQndaS3QyMGRlZDQ4T2VhN0NSd3d6cTVzYk9aQ0tiWnFYaHlp?=
 =?utf-8?B?U1F5R2RDVmE3ekxqaGg1eFFmTU5ZQVJOSlJ0KzJ2TnA2UHpjQVdNMFl2bDQ4?=
 =?utf-8?B?OUFyeTVRQkpqZEl5T2o2Y1IrYXZEdmQ1YVZXcmJMNEt4di96YmhhRm5yb0VE?=
 =?utf-8?B?bExLWHh1MktobHdVUEJuK1ZrMXBRYkhHRnAweWx4MUtVNzR3RUYvT2FWbHBj?=
 =?utf-8?B?SFAwUWZ0dzFaR1lKMnM3aHE1aU9jaGJ6cjlIZDJ2VkpPS1BsZGxFRE1Pc2lX?=
 =?utf-8?B?MDdFWU5kcmcxRVprbkxORlJSYmdBNmkxd3N2K2EvSXJyeEliOVJ1c1lzbHpC?=
 =?utf-8?B?dE9MSldDU0lneko5SXdwQzVMQjQvZUVHSDh4TTlITWlaSjZzcTZ1S2Roa0I0?=
 =?utf-8?B?R0dMQW1kUjFCcXo3MCs0Q1NDdXJLY0NUaGp5Z08zRWxJQzVwWTFvc29WbW9Q?=
 =?utf-8?B?MzZwR2FMMGxyQW5VNWdmZzVYWE9EamRqT3dTU0ViTk1tZU9sbUlIcGJXdkdj?=
 =?utf-8?B?QVVKZHJJby9WUCtwUUFWNllLMExmdkJIQVVLNmpsOXpEcU02S2RqV3Vjb0hW?=
 =?utf-8?B?c0F5R0pvcGUyN3dyT2JqdW1wVC9RcldkZ1lJSFlWWDA0OXJmNS8wQzRSSGg3?=
 =?utf-8?B?SmhHaGh1YVAvZ2svSnhycmtLVjgyYlhJUVcraXFzbnlTNE1RaUl2V2ZNR2Q5?=
 =?utf-8?B?MXNKcUU4STlkeElCNWVpczdOMEJrdGh6V3g3ZVRueHJxQ1hwRHhxbENPUjRX?=
 =?utf-8?B?WGlnNTN6ekp4VlcyRzFTbVVwOGJEWm9yZWxGblhjUk53ck9mYkdKVnkrWFlP?=
 =?utf-8?B?MGpLUVF5ZHBPQUdaV1NmK1dGTEEwYm1VUmQ1L0t5QWxLZThKc2JPeFhjN3Fk?=
 =?utf-8?B?SDBoay9seGhNcUMyRk1haGlrUy96eitVd1J1N3E4TjFadGN4OTdOYWtNekMz?=
 =?utf-8?B?ZmtnaHR0c2FPMjlYSklFZ2hFWFNVUXU5TWY2Mk54b3NmTjJtUTh6a2crNjcv?=
 =?utf-8?B?SzVWd2NOTzdtYkQ4NFJ0Q2hyUWM3bmdMVVpVTEZ2NzBReDZCQy9IQ001YU1Q?=
 =?utf-8?B?UGh1aGtTWEUyV1FrNFZqZUFiNU5LMzdLRmhDMktBbjBEellObEdvQUZaNmo0?=
 =?utf-8?B?dTFzWG9DT1NyUUVOSXhuRmxObjNmZzVIRW4zNVpiSksvQ1NWd2pXMmZVeXN5?=
 =?utf-8?B?UFlKQW03TmRFMHlwWk1mRnNNNTEzZTRHZnpKTDlXaXJoOGhHZmJqVVN6N0RR?=
 =?utf-8?B?TUZiOVFHSWJNRlNCOVZJSDZFVWJLaVNwbDNKRGpJWWJvTUV0dHd6VGtUY2ww?=
 =?utf-8?B?OTFYaG9PT21MaTZiNTYvc3lsSlBETHRyQ1EvaGcvQXdpUGtxSEhjQVVXS1cy?=
 =?utf-8?B?VDVWSzd5Z1lMbFFDcjRTdlVUOEFlKzBWSXkxS2JUQUtGajl1OCszdTVVdXg0?=
 =?utf-8?B?Ry8rYXZHaWFiWmFFRitOZDdXSGhtc1ZEVzhZVHJucWhJRU5ZSTUzV1dTKzJz?=
 =?utf-8?B?c0pHRXhva1drcmR1RldITTQwL2dTYWw3aVEwMEFLUzIweDg1RllSRXdlTXYr?=
 =?utf-8?B?dWFVL0xnSVVyVm0xYlRXM1dlaTNtcldPeGdxM2xsaUJiZnZFRG1TRG42ZkRG?=
 =?utf-8?B?ekVXUFlTVDRXVlZxVERTSjhkMDgwQXlHcmR6bVpYUUFsNEtMQk1EQlJMa0I4?=
 =?utf-8?B?aDR1L1VjK1Rrbyt4QlpvejlIMUxnd01QekpEVjhRSDBHYUZ1eGJ1ZDNVbUlF?=
 =?utf-8?B?eWdpUDRma3BMdWdSTFpTck9EWFo2d0s2cDZsWXVMQnFXVWYzUWRYVjlBSmpP?=
 =?utf-8?B?OHMwVEx6ZTVRYWZJYWhHcDRqT2JReTJtLzRwbnBvTk9lc3hObFVjZkNjZFlt?=
 =?utf-8?B?UUY0MDJVSzh2SUQrSFdoMVZCT21sc3dyWVdnWkNNRkJxeTQ5dVV2M05ocW1E?=
 =?utf-8?B?aDZTZFdOREhEbTZLWHFYbDBXWnBKc1R5VnY1MHZuQ3ZUMk1yWlpsUWRkYXBu?=
 =?utf-8?B?MTR5L2pQOVpLdldrVVN6NVBabmdHcTZYSlY4WHpnK2o1bm9HU2oxZk5sTy9n?=
 =?utf-8?Q?OIxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXBzeklaMStsWlZWS1M1cHFoUW9MNzFDTmZTNExtNTkyT1gxbGF1TGE0Wk5t?=
 =?utf-8?B?ZU5yeGxnaXIvR1ZZbkRaNU5vVkl2bGNRRi9ML3RUeVM1dlFmbDJhTUxsdm9h?=
 =?utf-8?B?bGhnb2NyOHBFZThtSVdwV01TNzJiMkZMUXl5MWhja0NsdFZRM1Fvd2kzeVZE?=
 =?utf-8?B?MkFWYjUwTzczQStQcEtBekNKdWpzYkY0K3VoVFdyU2FaQWxnaXB0bHA3MEJi?=
 =?utf-8?B?ZjN6dVhsaTZneGlhb2VBcGRFTU5JOTlMYXdlZEg4TTJuK3pHRTRxNG0vWkx0?=
 =?utf-8?B?MVVqcE1sellnSXJZb2dENW1LR1RWY0gyVW1MM0tKanZvVjRtNUJSTU9ReERG?=
 =?utf-8?B?K1ArNEk2YnFrbm8xdGhNWEJrYnZNdjRBSmwxWVloZmFGakhDZjVYdStFcUlp?=
 =?utf-8?B?NUlLanprbVRrNkZ6Q05DTkx5QThJRWt4MkN3Q0FyK3ZYVnBrNzVkOUt2cGFL?=
 =?utf-8?B?WGNFbGE1aXk0YngrNi8wN2gwWHhrTXY5S3k5cWgyM0o2NnBDbjI3TGRFbUpy?=
 =?utf-8?B?YXZocEF6Y3dNZFQ0UVp1ay9oWk80VmxaUmQ2c052cEYzZ0pOVE1KM3M5cDZ0?=
 =?utf-8?B?RDQ2Z2orblp6a1N3cW5HN1UwVkVUd1JZOGZoQVZaRTJSUEdqSXJFL2dOUzBs?=
 =?utf-8?B?dmxLclhsY2Z2Y0g4S29WYmlTcnlacXBDM1l6SHZNNnA3Q2lTUXo2aS8xNnNy?=
 =?utf-8?B?ays4TVJBSEt1bzV3UkpmT3hoeDFzUFBreUEwNDMvOUd5WFdNN1MwNGpyT3FP?=
 =?utf-8?B?RW1UUjQ0bmtYUGV0RklZM2toViswcm9jTWZUZU9ueWM1RWNiL3grUk1QdVBN?=
 =?utf-8?B?NnhlUzRTS2FFWE42V0JsSzdDZy9jZFZRZUJoazVtL1BNdjcxNFcxUmdiUTJC?=
 =?utf-8?B?QkZiYXFLeWZ1YjVUbHNIRmM2Q3VSdkQ1T2dVQTQzVUpZM0FaWVdiVVZJT05m?=
 =?utf-8?B?d1pWbktORmptZGI1THpXQUxwZzN0QjlIWGwwNzBkSVhkRHI1d1daVUlhY3NM?=
 =?utf-8?B?dXI1aTdyZkJjaUthQ0VaYU5rcjBCMGZqc3NUdmdmMnVsb2RhWTJpVjRnWVZz?=
 =?utf-8?B?eEh2VEdKcjVqMnk5SFJKTUQrRitobklZSlIxY2d2c2p6UmtSNmYxM3NUQklI?=
 =?utf-8?B?N1ZuMGJoVG5qZEhZejFkVE15NVVLaC8wT25nSVpJWUUxQmtGLzlGV1BHYkhN?=
 =?utf-8?B?eUJUaWVNeEJEZm82VHNRMTRwTndjTzB6YWx0cyt2ZzBMenJTMlIxcHpCOEJS?=
 =?utf-8?B?ZngwVnp1cUd0VGV4TFlBeUtPZi80anZzNVExRDY5Yi9CWTg5U0Q1NXIrR00x?=
 =?utf-8?B?Qk9EYUNkS05PQUI0cVBBWDdvL3ZvLzNpcVkyNjBTWDQrVDV4b2MvK203Ti91?=
 =?utf-8?B?ckxGQUgvcWxtNTZhZ3pzODlqZXJUaW0zT0wvTE5GdHJnWWwwdEtjOWZCK01L?=
 =?utf-8?B?NDVidFlVWmhmQVBXNklEVGFNN3dSbXV6cGh2a3N0VGhGT3ZtS0RIdGgvTklz?=
 =?utf-8?B?SGkwZzRPa0xGQUJlWUtqUysxdXEzNWlTTFdMU1kzYkI0SHdZR2tNd1hUZWxD?=
 =?utf-8?B?eGRiOGxtTzlQdEJCL3h5YzZLc2VIYytzWmExa3BTS2tiU1VkL3VQb1AyMi9x?=
 =?utf-8?B?d1FXSDZqanc3WHgraHFZTDE4ZUJnSFBmc1JNZzVFbnNsK2dZc0txYnRuSmhi?=
 =?utf-8?B?MWFGNmNMa2FBd2Q3bVlOMTRNcVM0emoybGJ3WTdxVDBPOVJmSmpyUGlUcGpq?=
 =?utf-8?B?TFJ3QVVWZGxRWmpsZFBYVnFuU3RrUmtiNk96SFliZGh4TXBoMzFENC9SNE4x?=
 =?utf-8?B?SWhEM0RvZHR0K2tudXh4WWRFZHRkMmpPaW5RMEROdys3bFF5VVJreVY2eTBZ?=
 =?utf-8?B?RUxrU2d6blhNWSt1NnpJWk5Da3R4SG5OS0Z6T2pNekcydGZ1SHQvTnBGZ1FF?=
 =?utf-8?B?ZmFyeENtYTRMdDZYVHBQM015VjJnajEzRCtZc2FMQnJtWDhxOXlDVlFOTStk?=
 =?utf-8?B?YXVsZngrVXVPQ3BFbkQxbjduOG90QlZxK0FDM21GTWFxRXUrU0NnbkhEcWJB?=
 =?utf-8?B?dWFyemQ3bkhQVmtUTW1ZMlpwYmFWS0wxSDJ0TkRpYk1vNm9VeDRaQlBrRVc2?=
 =?utf-8?B?b0JHam90bGxiVHdNYnhLV2wxczJlWDZNR094NWR4c3g0TFptR1JBc2pCWXU1?=
 =?utf-8?B?U0ZvRDNBd2FONEI5L2x5aWd4SkltVTFleWRrc3ZEd21UeFlGbEdWU3NZdmFh?=
 =?utf-8?B?WmZqVE1YbXlVd05zZUM4WjJmYUI2TUNzK1crSHJaVjg3d0M2SUFKZ0ZxVWJt?=
 =?utf-8?B?dDVub3dzQVNXaklJUVA3VDM3RHJmUEVnSlhiZlVVTElOcmNIRy9kUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e752c0b7-aae1-4efe-0f4b-08de626530f0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:13:08.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDJ0dFU1408vBFZiJ0ZP0u0NXr/q3ZgGGAOCAWjFDW38XBcAvqICe8Nuv+xlLEf+0x3xOYxZ5bgG11uKIzOtTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7891

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

Hi Zijing,

Please give people enough time to review your patch and provide feedbacks b=
efore
sending out a new version.

Sending out 5 versions during a weekend is excessive.

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

