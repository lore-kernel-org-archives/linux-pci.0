Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D7471243;
	Tue, 21 Jul 2026 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665839; cv=fail; b=dkJLo/iOsO4RwKVosCJoVtR2cAXcbgi0gEkZLkHasgEDHzPGKNrdWdBuzgxFMU2hBTx5CDdXwl0f0q9r8zFhE6qNxkIHp7IoJhk9f+NAq+TQJPG8i/GeMqN+8wi4NWZ24J4Kb3ql3VmIE+KEe2fimYMgF3+md0U8ITGGs9BRKyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665839; c=relaxed/simple;
	bh=4mxmvqR8ysEpZrQjOXmNGTnb4rUfDytNxTdfw+ITc64=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=iOSyXxP8Ckx8XdoI/ARXt++pSUjo9lbF0RuPNOWq9T2CHGpYH0eZnSEViqGKbUTSp1A1mF1p6bTC7JlSzH8CLkiViUZptVNdIvMZg0Z2xOx2HhbNHmZBoypB2tuwj0tB+ZpF2UVp6UdlPrr0qaUxrbvydPdvmWbP2lBBrRsHeIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cxYWkqtv; arc=fail smtp.client-ip=52.101.95.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cxYWkqtv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d06daF+45vWa+0qXgzSWLkymxQEjXUuiOqmtLXswjiz5h1qKEpogBahAOqqi2CW39gCK6mOdPISZU0j5pBeRmI7DPrU6aM/zMbz4Ep8Q6R0jb7swBF7rlHfhGqmZlegRiEQk2ZeABLd0M/NtZm2KZ4jOj+4gTbcp3DnIacJumMbf80kD/aXYlIeh901VCIyiJagH+3YjrZK+2Xb2jWbtzQIXtXfmFfVTJai7wBh7GpkpgWQU+xDR8hAdvbPQ3QsNl+PmPiF8mXsbPDGcI4DAKWl2LWGusJh0Z9DGM3war/t2u36NRYeNwUt4HS/fZzFb5GM3LEDzOzWIpf52TdFs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJEqwfnjWPYlj1kY0gUM9sHPulcWhpLNXr8YZGtzjtQ=;
 b=VtyFSNVQx/3iuiwqfbd3Zr4LVf2DgTCmxgF1kBXiQpe0jroLoSLcWUy94b486/PhKLjXeJJmwzExr9XURN6Eg3EI/u4huq+DDa/fN4Sn/sejlCobflVbjMXQvlkNpgHSOrbzBbCtb9OBTLOWLXhc5tJqCD5PTXVw2Bk/KKclLDvGuHDblj4UGFD8kBcc0pCf8yiPtd+T+CjDny+XqrivhcRJd9tcpUJBHvYxGzA318RQsFrOsugSSCD1GsEzkEZNM1NIFL+tSuYfyWRKlxjWjHUVTL4UQte/VF3KSbY5OGaBsJ/2UqDgSFj+krJ2G/7tVO9SFZc75thD3Gw1UbXVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJEqwfnjWPYlj1kY0gUM9sHPulcWhpLNXr8YZGtzjtQ=;
 b=cxYWkqtvAdTjioiczIg9vy1l5QTzxiHh6Ip7my4NFaBwQlm1n5Kts8DNfr6dABEp5wPuZHQ/pzZ2Qc1rjYg6jzvMgcv6PHg3ylbw3oRGASZ7ZREcaJqXC+RCjmmtVw0a335tzSudLyAVNbMD3n5pTMAeUIjS9Dt3MHUw0pRSwS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB4965.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 20:30:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 20:30:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 21:30:32 +0100
Message-Id: <DK4J8KYRY5YB.2GVK6E1RJC4SK@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <mhi@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260719153631.559341-1-dakr@kernel.org>
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: a775ca75-cb38-4b14-13b5-08dee766e9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|921020|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hVaqqAtMkN2covvOnT0LOVmNUnuWQPU2rmLAQbxhmw4AZ6mTUXYHuYrXhYTJqAFlkfVRKB3f0zJtCsnd34VEvJAfb4OJ4oJFRmrJvhPEQu+BS7CaO0uPxx02C0k9isSvH1OIa8W2atYKgN2xAzAehj3+1Cm9eiyAXbnBjfy+2ac0L0OOL9n4t+t17E3DNipMbcqFWiwX0aMOawh/zdekneob4y8REDtJOZxZhgFScAl0R4+GNaJq10STu13VpWnn5ATcnpDvepFQWV/j4zOoMRq38AMl8hsF68tHvsRvwPqSqQLHfAvletxTdSYbiG6oMrWuYh45UvrHv0/o2l6+4Vx/bb5YS+Ix3eL5PzdJL2wOy6FPqhgoquKYEgZJbOyEuSoNeZ/Z/VdhmjXo48PZT6cpsGteBoBd8f8d8G5/hd68bZum66uOePtGU+wEUywFsgDdOCoTdSV5ldzFYJP3vA4NKiJW7Og0xxYSZMjtJE7rmU1kp4KF9oQSw3X5NyG5hGslsq7+7Od8CUwq6zsAwpkuDkGoaLZXDdIcBq5TjqI24gR4CgRb4c0ReLLw6eMftuj08QDXyzzMvLy+TPtjuyg6Uih/sT6hysVx8qAfrwsx6rToTkBWv5VJZ2r++qe+D9WWP3+OOpyrK02/w0mYXOyaLKs3curNNwOF7ItgiWOAGO6O80m4dZNsBw3OeILfB/SPq6Vty0jWdaUrmxm+3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGVabXZZOCtNMFFoenZaeXIzUFZZOHVubGthTHFDYS9xbzg1RWpUTG1kNi84?=
 =?utf-8?B?R3VXT0s1VkdienRkS3MrOElFWkxJNFdNK2I0b1F0WVl5QlphalBGUXZiRHdY?=
 =?utf-8?B?Tm9pWmwrTFFhR2wyT2xYVkN0elcyRTB6eDdmaVNPaElqb1p0b2JncktpTWdW?=
 =?utf-8?B?b3pLTnhrOXp6YStDQ1JOaHVUSmR0NGZlSGtlOSswN3BpU3BZQ0dHKzFQYUtR?=
 =?utf-8?B?M1dLTFZpcjB0K0xTQ3pzbnBRSURJbHFHQzUxbzlYOG1OOU14ekFWRmdLMzFk?=
 =?utf-8?B?dHZnRUIyZ24zZVFwZ0oyMFJIQVROV1lyeGRlc1krQnlkc1VSTlBwekxjQXZX?=
 =?utf-8?B?QStjUzRiS3NES2YyMjdWQjJlUEU1RlRaWHc4d1dEcmhDcnRmYTlyMjBBeVlM?=
 =?utf-8?B?OFR5VCtUd1hGMzVTcTByTk9jclZBdG8rQ1JWVkljT1FBTzF0L3VxRFZOcmdH?=
 =?utf-8?B?TVc1dXJzK2NweXdSRXd5bGlSU2ZKQmQ0djZFb0ovSGZMR1BibmxqKzlrcms4?=
 =?utf-8?B?MDFjQmUrTUpZeGtTNUxHZm1QY0xncFQ0ekVrQmVRYkVLRlJndVVwcWlPVkw2?=
 =?utf-8?B?QTVYUko2SzBPUGxhWWt1UW50cVF2UjIrSnp6QXQvTGoxdE9QaVovTU55NWJy?=
 =?utf-8?B?ZG1nejBxUWc4YWpQRE5KdmVGcVFNbEhpbWNORVJCVG1aejJodXZFcG9pTzB1?=
 =?utf-8?B?VEttY0V5alRkOGlyNjBkb09RU0sxOHVQZFRnSzJKRGlvUWpBa2wvaHBZM1lJ?=
 =?utf-8?B?WDJGOGE5c3NKUXlQRjlTRkRva0dPTDNuUWJwR0o5OWpYbmVaQTJwS0ZFcFhP?=
 =?utf-8?B?UTM3ekhGRDVSOUlJVENqc0JxVHFCVXF6OUx5RjB2OFdzMkYwSU8raTZ0ZmFm?=
 =?utf-8?B?bmhMd3I2UHAyTit4cUhqc3M0bi9jaHhrTkJzVzJaVmRBYjdjNDlPWDdmUG1R?=
 =?utf-8?B?emJLcEx0K1d3amlrK2k4MFUxVmNRT0Rpc2Fmd2NqQXlrOXpCcjJCc0VkRGVR?=
 =?utf-8?B?TkV4TWZBemhKYTg0SHJBOHZYN09wOW5TcGdNWkpIWm9pS3BSbnJkRDBjdTd6?=
 =?utf-8?B?bDRjWkZzTnNXbFI1UmhlSHMxcE9Ha2QxUTlaczIxQUJVRWd6cWh3K2xGcjln?=
 =?utf-8?B?QnYzMHNmdGdaczM4NWh2WlRtZDFmdE5iYUFtektOWkhTR3FtbXMvOVMrWjFT?=
 =?utf-8?B?a0kzRm4ySVAxbVJLcGVZWUlnZUpqVlBuVHhqYTh2dEN1amQxcmYrTWhzS0Zu?=
 =?utf-8?B?YkVScWEwYVJHbzVSeUlhQWVXR0RGZ1k3bG4xRWVxUU9xU0lSNjVIVDllbVhL?=
 =?utf-8?B?Y2FNM0R4QTVVdnJ0SkZmTlMrQ2RUNTNnbSs4ZHV3clhPRjcrYWtWZGpWWUZQ?=
 =?utf-8?B?OHBxMitHTXBmanc1eWxNTHV4UWpKTlZZYXJGekNabHhxRTNOSnB2VmVGUXVL?=
 =?utf-8?B?QmlFWkRRWStaaGRnL2ZLcEU3YjkxNVlpSmdqaEhVN3FxRlZDOVl5aDdIdGht?=
 =?utf-8?B?WGE2ZmJ4dlpwOVRFNXpHTldIOTJ4d0prRkE2WnZtakRtTEhmSlRTZUNwTmFv?=
 =?utf-8?B?aDBiTHY1cXp4VXo4ZWZlb2k4Zi9rc0tDa1FOTElJVHZ6Z0FaeFpkczN0QlhQ?=
 =?utf-8?B?bFVZUktSc1AvTHBPeXo1Wm1YVm1UTG9WRW0zbnppNlVwWTBQN3Q5eEVVSzRQ?=
 =?utf-8?B?OHlVNWVuZkdFNVV1UE9FSXFaMVYya3dmdmtIRENsN2NIS012RElJNWUvY2xk?=
 =?utf-8?B?MXhaaVdXUUhuZVFicTZ4R0xUdG83cjBXZk5rQithNG5TUndjUzJuL200V0I5?=
 =?utf-8?B?UTZnTkM0VTg3NTgwM2diVU5OcDRqVGdkTWlVcU1qR0JCdmhLYmZVMW54blBT?=
 =?utf-8?B?dWlqNURIQlRYS2JORXRkUTBHWEZOV1B6bWptZDR4NmtFNllFdUlOeDh3a3Nj?=
 =?utf-8?B?Q21TajhmTkQrN2pCZVQwbHlIdEdRNXducTBUMDQ5OVR2bVFWY1NnT3FoaWdy?=
 =?utf-8?B?bTkveG8wMGxkcEhyWjVnVG5SZFBmTDd2OGRueHdpZllwQ2MvRW5McjNLa09H?=
 =?utf-8?B?dzdLeXVLV2lITUM3NENYWmNlaUR5TDlTaFFzVldDa2FoekZHdEJZVUZ6bk5J?=
 =?utf-8?B?eWV6cGhOR2M2KzZ5dTV3Z1B1MG5HSHZINUtROGI0Nk9ldzhIdmprdUtyTlc0?=
 =?utf-8?B?TlJLNExBb0JoMXZSZ0J0ZXlOdjA3WThYT1cxQlRTQldnUWZrNG13OGJ1cnVO?=
 =?utf-8?B?aHpia2lVT2NEdHdQbW5jbEdXR28zNlRtdURtMFRYL3JrYiswbERjWTBaUEx3?=
 =?utf-8?B?UDl3Z3g4YjZFUXgyRUQ4MmhWRzBrbkMxWVBIT0U0OWVlQTZJQXI4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a775ca75-cb38-4b14-13b5-08dee766e9cb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 20:30:32.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/TAtPc1303BPqypqWcaiFRf1X/t25AwhHrqZA7grkU9I5uG8l3jNQTaq6VIXiGV98G8x159umXbeQ4NgWA1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB4965

On Sun Jul 19, 2026 at 4:36 PM BST, Danilo Krummrich wrote:
> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
>=20
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
>=20
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> binding scope.
>=20
> Also remove the &Device<Bound> parameter from the handler callbacks,
> since handlers that need device access can embed it in their own type.
>=20
> IRQ handlers can now directly own device resources:
>=20
> 	struct IrqHandler<'irq> {
> 	    bar: pci::Bar<'irq, BAR_SIZE>,
> 	}
>=20
> 	impl irq::Handler for IrqHandler<'_> {
> 	    fn handle(&self) -> IrqReturn {
> 	        let stat =3D self.bar.read(regs::STAT);
> 	        ...
> 	    }
> 	}
>=20
> This eliminates the indirection previously required for IRQ handlers to
> access device resources and aligns with the broader goal of expressing
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
>=20
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes in v2:
>   - Move request_irq() / request_threaded_irq() to _: blocks.
>   - Add INVARIANT missing comments and missing #[inline] annotations.
> ---
>  rust/kernel/irq/request.rs | 432 ++++++++++++++++++-------------------
>  rust/kernel/pci/irq.rs     |  26 ++-
>  rust/kernel/platform.rs    |  48 +++--
>  3 files changed, 255 insertions(+), 251 deletions(-)

