Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021133.outbound.protection.outlook.com [52.101.95.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB22882CE;
	Fri, 23 Jan 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190270; cv=fail; b=gYBVCJ9Z0InF2e0TbSJLCqfUlPcvbsFdBwYpRnw/5f8devMLfjfn1MYMYBmw0Pu7AfNmWz116X/RgZkHwN/2rfozei+wM+xnW7slFYseVbwHL9ljhlnfV9fLIWBgMdK6FgIomDqxM039NjFXXILi2l4uZM9uFjW1Y9yGt0L7Mhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190270; c=relaxed/simple;
	bh=O0y/Te5mUBd4Dgl0sJOyg3eadbNpmLUrOlDdES3Ns8M=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IoP51vZ1pKojoLRNT2hkQmIsg4Sk27liaC/bb1SOhWHF5adtdeyHsLWDs/nDItgd+qQx4Jmy5KbSYCZc+i/03sop4EgAIHGDfkeOqd2pcsaMjM13mjT6fHDBZa7ZEMk4fhX11i9sqJUh6NIfI8Dqrj3o8mZPdsvBOAezSmDcAnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BvAbtTMt; arc=fail smtp.client-ip=52.101.95.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BvAbtTMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F45swFzlEZDZ488cfkJ1gXN7rAmVFpUNs3q+gAe9lfqpaLeGENjId0qeIbU3QbdQW1AFEmXMqqwfTd/EiAzbgOwjUiFYKHDvb9NhtSJvlrkuNZClktdd1fbujpm+eOmcpN5fapN7Iaio/UG6Wwn2YPeS2tm3aQOT80Zs9L0mUAOtdmSzvvnQVnfOVdAd6II61tQ3/NG3m3TPQJ5ujBFZR5gJvLswKWwuhzphcwuBwSXVuvhzX/W3ib2LMP21/a3JYUPXMaZnOE1ilcE3iNLwG7RHkBNWD4TFYA56gClhBbO6NFIO3WeUw6d3fo+ZTN8Gu9hrgZFpkIbtZ1YqGOdbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjY/lzq3LBsZhFSVYyzLaeUir3pOD2fvx6vb16vAYj4=;
 b=NMw/6AhkVtAMwmts/BinpiQFjjEjnc4f5naO+Av8MS73L/5cd8H9aej7N6kvNdZwFngkOlFIvexv4C+1BLnLSG8qF5z1bBRN/KcreDDbtqskVIq4/r7poWuPPDt0TuwmxVvpdKmTIhdkS5fUMj0Cd2KJm0leyZEIiDHGxzPVQlHxv5lYAxbp0SGaRbOrR8UYQFczKD631yiNeMY6MrocCAZ6RbmFZUDXJfG+VGhtpcjsMbNd+oTGV66CKVwgDbVfmWUkpjiVBGtw5FuEf6fCOFUBg9TasQebH8y5PPTmzCbROrl9Pra+OpaQP3WCpPc1oQf6dC0UkmdZ0vQ82UplTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjY/lzq3LBsZhFSVYyzLaeUir3pOD2fvx6vb16vAYj4=;
 b=BvAbtTMtolsuSUVmrFfe89A38tXL/xPW4seKZYj671NwjUrsRYnUq6yiNjlbjfjlbee3Y0FtdpeL5njfZJtOlymfJNMY3uUsfOG/6u6WjrQZ1EUPfnupv7LiPygfGorsul21jf0FgXtgGQyInfacEIGNgdEn4AAXckw/NAUuV5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7886.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:411::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 17:44:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:44:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Jan 2026 17:44:22 +0000
Message-Id: <DFW5LUIQVZK0.2W01YO54KTKR7@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] rust: samples: remove redundant `.as_ref()` for
 `dev_*` print
From: "Gary Guo" <gary@garyguo.net>
To: "Dirk Behme" <dirk.behme@de.bosch.com>, "Gary Guo" <gary@garyguo.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260120181152.3640314-1-gary@kernel.org>
 <20260120181152.3640314-2-gary@kernel.org>
 <82535e68-dde7-46b9-836f-cc6f2f8e7a78@de.bosch.com>
In-Reply-To: <82535e68-dde7-46b9-836f-cc6f2f8e7a78@de.bosch.com>
X-ClientProxiedBy: LO2P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d3843f-f97c-4438-79bf-08de5aa70ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lTN0JRTVJqWE0xT2lJbllaeisvdDNXVWxlWUh1bElHSlArL3ZnZ0dQWW94?=
 =?utf-8?B?YmYrTWFnZWVYdDhNQml2TnhFUVovUEVOeWtxZjYvb1NBTnFaNXFSSUtwOWhy?=
 =?utf-8?B?eUFjcDlOQ0dxTExuUGVlelVhL1ZudlVadzlJMmJ2WC90WmlIdGR5TmpBR09G?=
 =?utf-8?B?dWZkVS9tcW8yRHlLcjRMTllscDBCdit1Yy80NGc5dGFnUitLTTY2dDZqdEto?=
 =?utf-8?B?aU1neWN0U05hWlZjbnJ4SC9yQXJTaUk2NjQ4WUFWV3FmMmNBKzg5c3NyVUhI?=
 =?utf-8?B?S0htamlWdnhtSGFvVVhKcEd5eHh5cHFmZWNEdUlsYWhjNTdweUFtRjNSSGxx?=
 =?utf-8?B?dFZoeEM4SmY1eGpwVHlMTThnUUUrZi8vUFlEV0Y2Wm5uNG5YZTUwNlkrQ1Rz?=
 =?utf-8?B?NWhiWHg1WTd2U3VMSndFMkkvamxvU1dXM000RDF3Y0dWcWVsWW50NVhZTHRL?=
 =?utf-8?B?TVJkRFpsMDN1RnlxdkJtN2lBQUZtZHBDWnIxQ2w5QXI3TEZ6b2NWMTZ2ZmFJ?=
 =?utf-8?B?dVVYRHVmVEh1azViakZVWlFrd2tHb3h5SmtjblVUYklpVU5uTFBDQnJUeUxZ?=
 =?utf-8?B?d1RWN2oxQ2RpR2VKWWJ5eUxzV0JwVDdzZ1V1eDlpK0Z4VTFKL1lXZ2JZbzNJ?=
 =?utf-8?B?Yng1OEpxV1ZnRnVMUTArY3RWNmEwRWMxb1ZoQXRVL2Z0ckZrY2g1Ny9FODM5?=
 =?utf-8?B?N3VPWUFRS21MTStiWm93UEl4VGdwcklBT25EMW01MUxUajhzWGwyR2pES2Vj?=
 =?utf-8?B?dmpBK3ZhclBjVVRCMFhvVWExUWplQy9XeW9TQ2NEbzRvOEpDaEppUzhjSmV5?=
 =?utf-8?B?WWpEdzZ5WTJYL1NxaDI3T2tFbkdDMzNwQmVybnNMM2R6TCtKZWVNYzJacTAw?=
 =?utf-8?B?YUl4V1FJeUFkZlF6SFgya2JSM1BUVmVxaS9YTUVpVXZaNjFLcStLd2hta1I3?=
 =?utf-8?B?Y2JrWlUyVk1BMm9CeFRYYnRUcDlaSVRrb0YwZUJETHlRV3E1Y2pveGJqYzVm?=
 =?utf-8?B?RTJyZkRkWnowdmJwU1RNeWdDNXF6TDVocXNrN0RPYXM4NnVqcC9Vb1FmL3VZ?=
 =?utf-8?B?NlB6NGZuTDgwb2FxTEJFWnBZU20xWEdGRGxYaXZQSlN2UWxDMXFzeWc4azNR?=
 =?utf-8?B?OEpSMXRNTU5rUy9CcFM4cUJURlJkaU1oSmZ2Q09Lb3BpRTRFS2JIWHJxTGFG?=
 =?utf-8?B?Ujc4elZHN0lFTnkralZta1ZnZEZzREpwU1I3U2lIODRlZDVvd0MrdVUvd3Q0?=
 =?utf-8?B?cWR5OENuOEgreHVUeFROc3I0Kzlsc0JvMVM0UjczMEx5MVZvaUNHZ2RxOHBz?=
 =?utf-8?B?d3U3aWxnd1BjaEdTT0NLR2JFdkwwN2J3cVZOa0poTUZ0RzBqa3EralVLNUlQ?=
 =?utf-8?B?WklUOE5RaVFqZUVXZThrTUxLTW9qZzlLaDJYVERvWDMzZTEvYW52T1NGUGxR?=
 =?utf-8?B?WVpOdi9BWnRJdmF0Q2J3QXh4cE5LOVhGbUl3cVpuUUxXRWZYNnZUYzlVUE93?=
 =?utf-8?B?RGtHZmF1K2FLNTFnNDNKRElyNWpkZjRzUGJWdFBTSExsZHB0SDdDcmFJdmhr?=
 =?utf-8?B?UXpQS0laRXlzczFwSWNXTFYwa2JkOUJwMUZSUVdNNWxhNUxvSHRBdWQ3Y0pF?=
 =?utf-8?B?Z2pXS1V5REpGeU9iVUZXWnRTYUlzOS80cHhsZ1ZkekZ4aGJLbWRwMm5QQmNP?=
 =?utf-8?B?UmZJZUV5M09Rb0lTY2RGaXhMczRjLzR5NjBiL2pBaE9aZlpUd1pjRlhHdFg4?=
 =?utf-8?B?ZmdsMzJaSC9rVi9DalpYU1lnNUc5Rm9GZll4YWhDcVZXMjB0VEZQbFI1aDlq?=
 =?utf-8?B?cWFWdVpFVENMRmR3OGtEL1gzbUprTmxueVdGeG1KaEJmZWN2amNLdDRjWFpR?=
 =?utf-8?B?U3ZGdHVvWC9iREVuNG5kOU5NOUxqOCtzaGN6MitraW1UbjhpRTZqcnpoc0p4?=
 =?utf-8?B?Y0hQdnA4WFBLdFNyTE1GN2F3YVZ0eUZoUWVHVmxqSnFpYmkrRnZxQmRRaUUr?=
 =?utf-8?B?V2QxVjdsUWlaMThUUGJpUGpJaWdOQmZXWHZqdXBmWUxQajdpTU1Ba1R4SEx3?=
 =?utf-8?B?cHdrR05YWng1QUUyUG1ENnBLOUlwTmRWSU1rQnZ5M1FuOXZCeDZvaGpJVXhJ?=
 =?utf-8?B?KzhzQkFWaDhUeUlHb3lEaVdwczl6aUtNYUc2RVRrTS9yRlBmaUNZWi85Wis4?=
 =?utf-8?B?WFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0kwMWdQck5BZFY5WG92Y1pmQytHVDJDcDVLbXQxUi80MTRXMDVqblAvRXds?=
 =?utf-8?B?YXZZZUxtNTA4SXVFcVFXKzFTMzFJWGNTb0c4enlOVTR4b2F1YW4wSFVONEVI?=
 =?utf-8?B?cXZQRnd3c2dUZHFOSjZudUNOcUJHZ1Q1cnN0K29iZm5BbW5xdSs0eFZwU2hR?=
 =?utf-8?B?WmRHZlpqWTlsL01IUW1VNDU0MlJadDVaVkJTenVKTHNmQ2xXV2NnNjRodEJ2?=
 =?utf-8?B?NVgvamlWaFMxeG5WNmoxUzlmRWh6V0RlU0kyM29XR1pWVzdUa0xSeXdPV2Nu?=
 =?utf-8?B?R09veVpEWmQ0cVg1UURvb2p2aG5tZysydFNteERCUDJ0QVdhWTUvbHlQdzNX?=
 =?utf-8?B?eVIwSElEVTIrTEdyUjgzQ1RHeEo5RHlubG50SnJNTWNwQThLRU45YlFPNlI3?=
 =?utf-8?B?cmdkUndoVS95WDVIV1VxZVBjYXFHTVJDY2Q5UnI2ZGo2NENJczZ6WW9uTk1L?=
 =?utf-8?B?SlRBSytLYlM4d3lzUDFCdnUyOEJpYXA4S3RPV0FVcExRcFJ4U0s3ZlBPc1k2?=
 =?utf-8?B?TE52M2tPUC9JMEtPQkNWVldVL09HSUJRcCtTeFI1UVVwY0ROTU5IajBzNHBE?=
 =?utf-8?B?TnBmQ2tNeHA0c2J2a0h0SVp5dHhJK21WWHlqSzVXaE9lRDF1QVFOS1hxMjNS?=
 =?utf-8?B?WC9SWmRGUHQ5R2lQUVk5eCtpSVBzZERPUTZxWHpVVkdscWlZdFkxS3B2Mmpo?=
 =?utf-8?B?dDdsazZYamtNc3hQTHhiM0J4ZFh6V0VVQXhvZEJaU2Fja3kxb2c5TjdhMkhC?=
 =?utf-8?B?RzJUWU9EdENyRVVRYzlBUm9FZGdTRnYyOEpJTzZxZ0FmQ0MrMDZ0ZVBnN0dz?=
 =?utf-8?B?T1VEdi96dENCZnhYMW9lQ2ZoN1o0a1pxNmUwZkduck4rRUdxajFOaERTZjd5?=
 =?utf-8?B?MDBtY2VNUXlTL2dRdEFRQnpjV0ZzcXNZSWlaenVEWVBMdzVheGRxS01rclMy?=
 =?utf-8?B?SEFhb1pYZlk3NXFOOFZaMnVuMzdkMlNlSG1RSW85WnVwYWk3d1RyM2oxdFpQ?=
 =?utf-8?B?ZlRxRS8zVklFSXZjdFI0L01wSlM5SzZEZXE0cUhWRGdnK2laQkl5U3g2TFZE?=
 =?utf-8?B?RzAxUFBKdW4vUGZZb2JkaUFKays3VTA0K1ppZXhrVzF3Nnk4SU8vekdtTkFO?=
 =?utf-8?B?QmxlcGhWS3lKQkIybmRGam9WbDNDTkVLbHVBc1dhd2Z0WUFEY0cwT2ZjcGl5?=
 =?utf-8?B?OVhueUJIS3hxVWJBZ3hGMzFtd0l4c1NMQ0NjNTVjWUdvcGRUNUEyQnl2MTgv?=
 =?utf-8?B?QklUOWl3ZUI3NjJ0ZTY5eXpTRGxxcmN3dzR5VXJBK0FKTmw5SEx3Y2NaTFN5?=
 =?utf-8?B?bzZKY01RQlBveXkvRncySEM0cE5OeDJCOXlYcTFhREQ4TmlkRHJSOG1oSEMz?=
 =?utf-8?B?VDNEMG1IMUdUOVp0MUJKQTRxVzJKVFZYamhWZUF6UXNwQjRoN2hnRWo5dHZr?=
 =?utf-8?B?TDZXMURHbjFtckxHT1FmT3JkSS8yL3psQ29XQTh5L1BYb1RnZk54eXNkQnow?=
 =?utf-8?B?MmVuTUVYVVJUbWFEdlZBaE1PYldKVTdpbW1zSVAzazBNRndBK2Vpc1FGM3Zu?=
 =?utf-8?B?eU9KUWpwQXRIREZML0JjNXQyTjZPc0g4eTZNa2pzb1hEOFNxa2FuaHp4QTA4?=
 =?utf-8?B?ZGVOUnV0MThrcHpHZ25wOHdCK21XNXBPQjZudEVPd2NrWHU3Q0ZUbHJ1NXNs?=
 =?utf-8?B?ZkxPT2gyclNhUFlXY2krS0FWSlVyYnVMcDdxc2h6bEJLUk9FenY2YjhmcXNq?=
 =?utf-8?B?RmJwUDlYbCtYRkpHZm9KK3YxOEZjOS9Cb0dvMU5qMDd4ZHNlUk5hbU1ybzhC?=
 =?utf-8?B?U3BOYXZZcHBFYlpCb0RZbzBBeGpOekVMaWkxT2lwZ0FqNlljZUVSTVRmc0lz?=
 =?utf-8?B?ZitaV0lhM2ZSODZ5Nm5yQkQxeDNTaWVTZUxDdS9NUEhUOUVCY3Z2dmFhcnRN?=
 =?utf-8?B?SldKR2RjbmtuOTlVdDYwZHQxT28zcytnM25MRVMrQ1lTTUJ2UVFvbW1RNUcy?=
 =?utf-8?B?QjlPL3V3SmdBWkRVdjliMWRYaUV4eUVaUlJFd3NNci9BcFlUbjlMYTJaOE02?=
 =?utf-8?B?SUxtazllbEVrRGdrU21lcmtzZVlQR0RZVHlKc1I0Ykp4UlNyVjJWTDdYNEJW?=
 =?utf-8?B?aUFEemx5UmtFSTZaZFVrVG13WlFiREZuUWMrQm5BR25XTW1hLzdCemlneVpN?=
 =?utf-8?B?Skw0SmZ2ZFladGMvZ0swdjFYa2tDbVJQZC9ZU0RrNFpRWkgxMDRHSm9hSjg3?=
 =?utf-8?B?WXljRGE2UUQydlNvcTZEcXc2cVQxdmlDQ3NEd1hocHhsK2hOVjlhd3VINmZx?=
 =?utf-8?B?U2RmU1pkTy9JS3lwMGdESTRheDZRemFHSGpodDdma0F1eU9pZE9IQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d3843f-f97c-4438-79bf-08de5aa70ba5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:44:23.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4UO39i1blrHT3XQQGbvuGNQh6go8dFoVAHdcuCoBnsiIf8i7t9zBVK+Zg/za+NQ8PqZ1QuSxydc6gwXCqH5QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7886

On Wed Jan 21, 2026 at 6:52 AM GMT, Dirk Behme wrote:
> Hi Gary
>
> On 20/01/2026 19:11, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>=20
>> This is now handled by the macro itself.
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>   samples/rust/rust_dma.rs              |  2 +-
>>   samples/rust/rust_driver_auxiliary.rs |  2 +-
>>   samples/rust/rust_driver_faux.rs      |  2 +-
>>   samples/rust/rust_driver_i2c.rs       |  4 ++--
>>   samples/rust/rust_driver_pci.rs       |  6 +++---
>>   samples/rust/rust_driver_platform.rs  |  2 +-
>>   samples/rust/rust_i2c_client.rs       | 10 ++--------
>>   7 files changed, 11 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>> index f53bce2a73e3..a9ac7937ebaf 100644
>> --- a/samples/rust/rust_dma.rs
>> +++ b/samples/rust/rust_dma.rs
>> @@ -57,7 +57,7 @@ impl pci::Driver for DmaSampleDriver {
>>  =20
>>       fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl P=
inInit<Self, Error> {
>>           pin_init::pin_init_scope(move || {
>> -            dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
>> +            dev_info!(pdev, "Probe DMA test driver.\n");
>>  =20
>>               let mask =3D DmaMask::new::<64>();
>>  =20
>> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_d=
river_auxiliary.rs
>> index f148124fe81f..c20961f16835 100644
>> --- a/samples/rust/rust_driver_auxiliary.rs
>> +++ b/samples/rust/rust_driver_auxiliary.rs
>> @@ -39,7 +39,7 @@ impl auxiliary::Driver for AuxiliaryDriver {
>>  =20
>>       fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> =
impl PinInit<Self, Error> {
>>           dev_info!(
>> -            adev.as_ref(),
>> +            adev,
>>               "Probing auxiliary driver for auxiliary device with id=3D{=
}\n",
>>               adev.id()
>>           );
>> diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver=
_faux.rs
>> index 5330b77ea986..99876c8e3743 100644
>> --- a/samples/rust/rust_driver_faux.rs
>> +++ b/samples/rust/rust_driver_faux.rs
>> @@ -26,7 +26,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> =
{
>>  =20
>>           let reg =3D faux::Registration::new(c"rust-faux-sample-device"=
, None)?;
>>  =20
>> -        dev_info!(reg.as_ref(), "Hello from faux device!\n");
>> +        dev_info!(reg, "Hello from faux device!\n");
>>  =20
>>           Ok(Self { _reg: reg })
>>       }
>> diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_=
i2c.rs
>> index 6be79f9e9fb5..e71b77196163 100644
>> --- a/samples/rust/rust_driver_i2c.rs
>> +++ b/samples/rust/rust_driver_i2c.rs
>> @@ -56,11 +56,11 @@ fn probe(
>>       }
>>  =20
>>       fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
>> -        dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
>> +        dev_info!(idev, "Shutdown Rust I2C driver sample.\n");
>>       }
>>  =20
>>       fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
>> -        dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
>> +        dev_info!(idev, "Unbind Rust I2C driver sample.\n");
>>       }
>>   }
>>  =20
>> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_=
pci.rs
>> index ef04c6401e6a..d50828b642e5 100644
>> --- a/samples/rust/rust_driver_pci.rs
>> +++ b/samples/rust/rust_driver_pci.rs
>> @@ -75,7 +75,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo=
) -> impl PinInit<Self, Er
>>           pin_init::pin_init_scope(move || {
>>               let vendor =3D pdev.vendor_id();
>>               dev_dbg!(
>> -                pdev.as_ref(),
>> +                pdev,
>>                   "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n"=
,
>>                   vendor,
>>                   pdev.device_id()
>> @@ -91,7 +91,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo=
) -> impl PinInit<Self, Er
>>                       let bar =3D bar.access(pdev.as_ref())?;
>>  =20
>>                       dev_info!(
>> -                        pdev.as_ref(),
>> +                        pdev,
>>                           "pci-testdev data-match count: {}\n",
>>                           Self::testdev(info, bar)?
>>                       );
>> @@ -112,7 +112,7 @@ fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>=
) {
>>   #[pinned_drop]
>>   impl PinnedDrop for SampleDriver {
>>       fn drop(self: Pin<&mut Self>) {
>> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust PCI driver sample.\n"=
);
>> +        dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
>>       }
>>   }
>>  =20
>> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_dr=
iver_platform.rs
>> index 9537dc38c563..f2229d176fb9 100644
>> --- a/samples/rust/rust_driver_platform.rs
>> +++ b/samples/rust/rust_driver_platform.rs
>> @@ -180,7 +180,7 @@ fn properties_parse(dev: &device::Device) -> Result =
{
>>  =20
>>   impl Drop for SampleDriver {
>>       fn drop(&mut self) {
>> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sampl=
e.\n");
>> +        dev_dbg!(self.pdev, "Remove Rust Platform driver sample.\n");
>>       }
>>   }
>>  =20
>> diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_cli=
ent.rs
>> index 8d2c12e535b0..72da5499f150 100644
>> --- a/samples/rust/rust_i2c_client.rs
>> +++ b/samples/rust/rust_i2c_client.rs
>> @@ -113,10 +113,7 @@ fn probe(
>>           pdev: &platform::Device<device::Core>,
>>           _info: Option<&Self::IdInfo>,
>>       ) -> impl PinInit<Self, Error> {
>> -        dev_info!(
>> -            pdev.as_ref(),
>> -            "Probe Rust I2C Client registration sample.\n"
>> -        );
>> +        dev_info!(pdev, "Probe Rust I2C Client registration sample.\n")=
;
>>  =20
>>           kernel::try_pin_init!( Self {
>>               parent_dev: pdev.into(),
>> @@ -130,10 +127,7 @@ fn probe(
>>       }
>>  =20
>>       fn unbind(pdev: &platform::Device<device::Core>, _this: Pin<&Self>=
) {
>> -        dev_info!(
>> -            pdev.as_ref(),
>> -            "Unbind Rust I2C Client registration sample.\n"
>> -        );
>> +        dev_info!(pdev, "Unbind Rust I2C Client registration sample.\n"=
);
>>       }
>>   }
>
>
> At least in samples/rust we have several places where we added helper=20
> variables for `dev`. For example in rust_driver_platform.rs [1] we have
>
> let dev =3D pdev.as_ref();
> dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
>
> Do we want to keep this?
>
> I think there are places where this `dev` helper variable is used for=20
> printing, only. And there are places, like in the `probe()` of=20
> rust_driver_platform.rs, where the `dev` helper is additionally used=20
> elsewhere:
>
> ... Self::properties_parse(dev)?;
>
> Hmm, I'm somehow under the impression what to use when in the end=20
> becomes slightly confusing in sum?

Hi Dirk,

If you already need to be obtain `&Device`, then I would say either is fine=
.
The `AsRef` impl of devices are zero-cost operations anyway.

The motivation behind the patch is that in a lot of cases we only need `&De=
vice`
specifically to print, which is something that I want to avoid.

Best,
Gary

