Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DF3090D4;
	Mon, 16 Feb 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248452; cv=fail; b=AOazMrLyYOv7UQLUwexGI/aKFb0ZRXK+nMDDc60VdxaDoThnPpxNuG/q9TqbEHo3b9gdRkIWSZ7EM40LxdzjGbcPtKW67WXjlLyjbb1u7TOsYOYcDtfBbh+spQ6nTcDDqQQInI5r/syjxIt6HvmxKKRjpZryCm1InAcNEA7/loU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248452; c=relaxed/simple;
	bh=Gj3u6kVFKbvp9WVypDZvzNBiXmr+HykR5bxNZaGxAHo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bY9TUXhmFT6owal2oqkv6LSgp5bgqp9W+WevW3bKrG6noDQQhBwDBtktrJ9rW+yAcdkUIhHnnPFt62nN6wRg7iaT6vLQJrAoEpvxDG7VBKHvUXL8ibePH90YAzlgHES3XU9nj4u8ymj0dCzJY1RbwWumjLdbQ0ENmBwhH6P5LfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkI82YER; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkI82YER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0yimslms9fUvjvzqnzLDzKtmFAX/uBM9vBG+YUqqUPnoX3oDOr8KREHS1Dg0Jolv7dtlbEbN+dcUpoPOSLQlzUO3Cp5ugce/9rek+PQFRkwpUrKPbHaNfHxaRaGZgPqw402DPhKaP/gzo2ferLUxNCYJfRqH8XETgJkytqDxz0ZqUqDgm4QB7kfZGMm2krhNoV7ohFDVdbe/gKXJpTupkStZI+gnMgZevOxv6gRnxFGIroeCOsNRO633FtqUop6JaaA8ZlYR262wlCwziBYjC6jKpXNiBL5MPbDZH1o3asYbNQXIHh/qX7/WB3TCKpTSdkoiSFVGAjff0zfWGxTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBEY7MeRHzv13L/ENmtaREB6VLduVUAsjPmdnv9aO7A=;
 b=J4aOHLbmkGVE1vunShRsZlqcA5HaB8jdpkL14PcHzh7MKocqzwqBIDH+/k5OhDmgehnhbJSF4hrLGwbPr1qPpSi2l8ZAj1xtv5L4QYCIAxYEuJGpQ3jBkQa9gyNiLyC0N5nsUyr2hA2rB8/eZTe37dxqlks+xP+PdJk87UKwwqM4Opv94faWXF1mbB2qD24Q3zG8TlphdZJVwH12lBTDYiNRAruivByBdcB+PHlJ4HTTxd0YL7BbH1vZS08hQ90zuWwZJU/Q6H78yaomUnJ47JoqIDRJMCVMCqq8H5JNSjKouyuUYnKp4XET1OMzuqBx26KdV24B9IwLN0HoVQFbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBEY7MeRHzv13L/ENmtaREB6VLduVUAsjPmdnv9aO7A=;
 b=VkI82YERDVDt3l7dJPp5foQAHG1GNfdqEzK1Prutju0QQ7KmLOwHYEUc8TnB1qecUh9bDXZChseVNDqQUaylKb5mkFF70GBJBFw4bYDaY2dlKNYQZuXaCNg7Ixb4nMZqI8qaQpA37QMVmxejqL2Ewq7IUnC/7OXaUxM1u8uxjDOP2ilgS37O0qed7bSelcz0+3DU0mOzmNKLkA+R/cruUppHBem43aoKtkx9YpRLBB6uEsgbCH9G7CfkTT7V9mXzBw7XKE/HAb4rh3TfR5I85es347QTibJIljP/LgT0mah8hpThnSd0eCswZBfr1WFb9HAd6hX+y7IcyIFFOZketA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 13:27:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 13:27:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 22:27:23 +0900
Message-Id: <DGGF65JPF8S6.268LR7YDPTWMQ@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, <lyude@redhat.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
 <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
 <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>
 <DGGDHY4582D1.1GZGZ7P98OKWO@kernel.org>
In-Reply-To: <DGGDHY4582D1.1GZGZ7P98OKWO@kernel.org>
X-ClientProxiedBy: TYWPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9395b320-4465-4775-3a8f-08de6d5f2046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1gxTFpRMlExb1hhanVSWkZZZGlDZ2VTa1MyTVFpNi9aR1NGOXZhbmlpa0hV?=
 =?utf-8?B?VEIyazFoUGp3czhJWkwzS05RVjFNSUp1Q21yR3BrVWNydVRraXBPcVNjbStY?=
 =?utf-8?B?QTBEVWg5d0N3RVliY0RIcDlhcGJjZGpGcXNPTnRHV3FBbTRGWi9wUEltRVR3?=
 =?utf-8?B?MC9qUC9RbGt0UDYyMDhQRjMxZEQxYWdpOS9BT3pBMy9tVDQ1NlRTV2NiRXlY?=
 =?utf-8?B?bG1jNVp6bDJhcGd5VnR3VjFod28yVnFieWdCVVJaSjNPRm1nS1RBVEhhREU3?=
 =?utf-8?B?QTF2bmVVWkQ5ZlBJQjJWUkFSeUhUKzRsYms1NzlXbjNqUStOKzRVM0dEbHM1?=
 =?utf-8?B?anBtK2pFczIwRFNWdVJuMTZuYmUxaGtqcVUvbm1QSkNRSkR3am9PRHNiWTFL?=
 =?utf-8?B?amdOaUNmQ1hPRUFaZVpkL0crUmRIMi9pNzNud0d3dGk1TWVwSlFEbDJDa3Bu?=
 =?utf-8?B?K0g4Um1lVGlQUUN5Yzl4cTE2Z0RzSzQ2MTRweWxIUXlHZ1VoKzRZaXF0WXdE?=
 =?utf-8?B?VU5hR05BRTNFdVNZbEVnRUx5ZnYvOEgrOW1DS3lrMTNSdkxWdVpWSzhUakhO?=
 =?utf-8?B?UHdjTUNOSFVEMnNuTEQyanVlaGp3MWg3LzgvWVNzYnh1UFhhQisxb2VmMTdn?=
 =?utf-8?B?Tlp4SkFCOUJzenJJd1VrOU1tT0daUEJNY1ZoSkZmaDNUa2huVEl6bGJzbFJT?=
 =?utf-8?B?d0RTN28xRUZKaitpQk1LbzZ6Y3dRZlN1TGdKdmNzNUxMTXZySTllWkJmOTJ0?=
 =?utf-8?B?UnhDdGZrdk41S08vS2hJeEZYU1RMOTI5SXlPWHBMajFFRzMzR3hwL1JFTnJn?=
 =?utf-8?B?R2FsekNvbVVjMzB2RVBESHkxZjhGNHJoNFVRVjB4TXhmdFpzUW5QUnZRQlhS?=
 =?utf-8?B?QWpoR3loMldlT205REFEOUt5VnMwd2xDcTN0YWMwaFBHSXF6dVd4K3RTcGRl?=
 =?utf-8?B?T1cwQXNQL3hsZXU5WkZRKzZFSVZvcjRvNUU4ZjVCSmNreG53MDBya3pzaEk4?=
 =?utf-8?B?c2EwRVJUTWEwKzZtaVE2SjJJeUdnbEQ3c2xkT3VXUDB6VGFsTGdsMGt4UUhZ?=
 =?utf-8?B?YjZjWFJ2dkRtUWNDTS80QzZQUjV0WUsyYkhNb2cxYkZvOXFQK0hyMmNEY29z?=
 =?utf-8?B?Zi9TOUI2ZHFXQjV6Y05MWXVaSDBRczA2ZzAzMEk1TVZEc3QwdFVicTh4eFVJ?=
 =?utf-8?B?YUlQRmEyWnNsNmhuYzhsNlZudy8rNGd1NXhIdHVONUN2cjV6U0VIZkZtNk85?=
 =?utf-8?B?bDhrVWdWSWJEaENOcHVOL2hCRzZoZldacm90S1ZaTEdCTE9yaVU2WlFvWEZw?=
 =?utf-8?B?N2lRMWJuOHZ1REk3VUdYTW9wYXF5Z3BYVlZwM0F6eGpIWkN0Q2J2UHBKaFlh?=
 =?utf-8?B?ZXFQa2grcC9PUVRuSnNZbXlqOG9YRmlNZVdKN29KTmwvdTJqbHFNYUdzeVd2?=
 =?utf-8?B?RmRxSTVLZ250N2RHMVF6aG90d2VUUEExc3J6YTZCSnNxU0dCMjArY1NRSGZy?=
 =?utf-8?B?RGt2UHE0ZXdUSDJCQk4vcFJkL3RtY1M0RHpjck9YQSs5NkJHaFBzU2tqVE5P?=
 =?utf-8?B?L3IvZUN2ZEx5bWZSaTdsRTA2UlJ0S2JHOTkvNnhJR1ZqSjQ2YnpKdlphbmsx?=
 =?utf-8?B?cGQ5ZHpURzdxT0xmdDZ3WWNlekNnK3lCNU5GMHRXSEhYdmJObTM1bk1NMmdE?=
 =?utf-8?B?Rm5lZm9jcWUzbERQWmtPcEhEMDZ0SUtFTHhrLy91VUxsTXRQWTJ0Tm5Fb2xm?=
 =?utf-8?B?M2FOQm9rcVE0YnRGTVppOFgzc1lQbkhiS2h0T3BvajM1NCtteUU0T0JiaUxZ?=
 =?utf-8?B?ZUoyeWVIUkxheGNXL2FkeGthUFJWNjB1VFNlbG1JM242bzRjMHFJbHBpMHlC?=
 =?utf-8?B?cW5OaDNkdWV0TlU0VWcwTEd3dnF0VTFOaUN2alNoQ3JHc3NzTlI0NWZJRDNv?=
 =?utf-8?B?TEdaY0g3bHVLT3ErbkJxMDBUMGpKKy8vbjhtU1YvWnhKZHN4WTRwK2ZDSk5X?=
 =?utf-8?B?SWZvdUdOM21VbTJoZkNhWmNjakdqWW5ZNDJPczZ1MU5PRG5MbWh2ZXFqa052?=
 =?utf-8?B?a2FnUjZuNE40amZQajQ3b24wYXRwTEhVYkM5Njl1bThEZ1lBME5ReGpxR3lm?=
 =?utf-8?Q?YbHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZDeGZ6aGFNS1AwWTFvZ1BRSEt1TU42YkRVQW1LVVZyUitpQmhVSzJFQlF2?=
 =?utf-8?B?a2owQVhiUTlmckNHeCtiK0JBVzhyekV4aFFHTEd5ODRKbzNoTzJGNy9ldzJo?=
 =?utf-8?B?Njd0eU0wV0UwdFo2WGtVMzQ3amVZaDRub0w2VnRQakozRFBveVZYTHpGL3Nm?=
 =?utf-8?B?cUFhQ1RScDZRbEV4ZXUyQkUvLzNJVWFuUm1qUW9UdUlxN0FMYW5NU3RIcTBu?=
 =?utf-8?B?T2MvRzdzazhJaWg5bXNyUzZQWEdnYzNzKzNWY2YrdnJYUU5GenRPNDZ5bEli?=
 =?utf-8?B?amxmSjFjaEVsMXgrQkRObzd6dnVMQzZldjVRZGgrdzhlbDhFQkplWjRiMWpo?=
 =?utf-8?B?dnJneDh0U3daOUQyVndQY1E5UTV2UG90U3prdXhuZUJxYXFmbjBWVG44VFdk?=
 =?utf-8?B?NkdlOEg2VmMrdEtQRWh1YU5ISVhCdGFya3paNXlMWVFrUHF0MHh1dHhPNi9L?=
 =?utf-8?B?Uk9jNFlVMGtzQXZUSG5WSTdXUUFGSGhhQTkxOTZFdzduTUpXaURDVDBzVzli?=
 =?utf-8?B?RTlkcmZlUVBqNmpXV3ZsaHZsMXczYU5kZlBDQlJRcFg4TXlKVDFkaHFLak55?=
 =?utf-8?B?N2E2RkQ2azdmZCtQUkNkTzZKWHZ1L2VQVEplZ1hZWlhFNzdzSUg1ek9jNndR?=
 =?utf-8?B?bHIyLzZOQndNQk1QVWkxRVIzTk1EYUxjTzZJL1BaT3JBYTM2bk9mR0pkRFYr?=
 =?utf-8?B?eThIVHBTb3RpejNWbk9qcmZvZXVNVWlVS1ordENQem5CWFNUc0RudjNXamJO?=
 =?utf-8?B?dnlPdjJ4VmowK2JJbW8vOHdCdE1RQWY1S0RYYkJuOUhQK1pRd2hKSWVSRjFH?=
 =?utf-8?B?QjZmZWttMkpPeFlzNW9EQWVKSUNvRlhCdktkNDJ1V3FRWDhkejNJaDU4bVI4?=
 =?utf-8?B?cUlJUksrSDJkNVNLRU5EQzkra1h2TFJ0NURZRmRJbU1LN09WUHlCSkJNNmha?=
 =?utf-8?B?NWlCZlhIektCNTNlUVUrRkoxMjcwaUFSdGR1QkhCanI5d2JRVVZSRVA1WlFX?=
 =?utf-8?B?a0pJWGlQYmhBemwwaS9PTjAyZTFkbkE3YVYzRDliVDFMUko5VFAwVmlRWUtQ?=
 =?utf-8?B?QWxMSFI3Zm90VmgyektjSTEweWZkYjNuUm01YWpDQXFOR3RxMEpNeWpuc0JR?=
 =?utf-8?B?NTFrZlhUY21ra1NZWlZrMUE3blhhUWtuZHFTcG5Jci9DZVFQcGM1V2hOYjVv?=
 =?utf-8?B?eHEyMytFRXgvaGVvMTVmRWdaeUxuckNSdUMva0hxSkNVMlpzTmdMNXRTVmtW?=
 =?utf-8?B?RmlhdnV3RFBnNnhORzJickNxdENzVU94cXZINElYaThESC9JbkhKeTZWYzdv?=
 =?utf-8?B?NmN6T2JMY3dqVHRPRzVqOGh6TG14YlRzZUQ2NEplRWhZb2Q4ekw5Mm5ZbFk1?=
 =?utf-8?B?TC9nTGpnMkZDZ1V6dmwyYlVFK2xFZVp6ZFVhUklGUStDQ1k3U29RQ0g4eGZK?=
 =?utf-8?B?eTBFNDRmYkcwT3lFNkljZkFxNXlVL1Z0bUVGbnNQVlhJcStQQ0k3NWI0aWpJ?=
 =?utf-8?B?SDdJenZIL2tkaDI0bVhZcDRualZTSlErUWtLTDcvVFV2U1o5RE9pV0p5aFFZ?=
 =?utf-8?B?T1NFMVEwTUh5Ulg3V0dzaFE2VGlzYlNBNnRPeFozd3ROS1BJbzI0N0hyazN5?=
 =?utf-8?B?bktFeURJL3Q1bjBadXVwR085UFJCOHVsR0Rlekk1Z3FlRjRKSUxvSyt6TEI3?=
 =?utf-8?B?bWpOR3VYampBbXhHOXJhb3p5ZXRYNHp3M0kvQ3lxcFdrL3NGUXBsQklNL2k4?=
 =?utf-8?B?K0lEWmg2MGFJRk92YzlndFZUQUFPTk96K0NLVUE2SnRLM243cjV0RUdZUTNw?=
 =?utf-8?B?L3oybXFFYU1sOWw3RGtXN2c0RlVhVEFjYlhnR3JDdGlUanJCc3NKTm9tb0l5?=
 =?utf-8?B?S2ZQWVlxOXlIbWwrcVIydUVhbWxwdGNqRlBkVkgwUy95THRHUkdKSWlUWFI1?=
 =?utf-8?B?RWQ1ZU9aM08zczdGN1B1ZXFpaHF0d3llSTBoSzBuYm9HektLS09kc2xUZ1hl?=
 =?utf-8?B?NnNEV0Y0R3VUZjBmUFJwQXpWekN5RTFnaG9hN3BiYzg5RDVOQTJ6Y2g2eWgx?=
 =?utf-8?B?K2xwc0c1UUJtMCtTTWZHR2I5WUgrNnczNGhsd1BjUjFwZEtNaHlTSXBPOTVi?=
 =?utf-8?B?eXR4N21KdXhQWUlHbU5wUHVVd3dXWlNoeFlacDkzWEovbjFGcTZNdjAzRWZC?=
 =?utf-8?B?SU1xL2p4dm5xZ0RyaThsZGJNQkxacENFS2JMNTN1UUNic3BZTXhmTzg4Q2p5?=
 =?utf-8?B?dUFMNGcrOXZWRHRkbkllUnl4MnlENm5la1ViWUJkcUZZTW12OFRkWE5pRWtT?=
 =?utf-8?B?WEk4cGtWaWRvVERVZWpJSUVDSzRIOUdXZjlEcDRGNFQ3dGw3TFl0SG9WYW5l?=
 =?utf-8?Q?8N81hdNxngp1bl5JrStaN8KQTYsEaFRMLGlYpoJCjsLVv?=
X-MS-Exchange-AntiSpam-MessageData-1: +i3r4lZ548XTCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9395b320-4465-4775-3a8f-08de6d5f2046
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 13:27:26.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rDUcKv3+kydm8xVAYXIz0LjUbbYpZwrMiPJGkrfGdz6NxKD05LPTLCw8egzho4LOR+2Mf+PqwS3sZGKaa1huA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708

On Mon Feb 16, 2026 at 9:08 PM JST, Danilo Krummrich wrote:
> On Mon Feb 16, 2026 at 12:51 PM CET, Alexandre Courbot wrote:
>> On Thu Feb 12, 2026 at 11:52 PM JST, Danilo Krummrich wrote:
>>> On Thu Feb 12, 2026 at 3:11 PM CET, Gary Guo wrote:
>>>> They can, but the `Io` trait just passes the wrong address to the `IoC=
apable`
>>>> trait, and nothing horrible can happen without doing things unsafely i=
nside
>>>> `IoCapable` impl, which is controlled by the user who implements `Io`.=
 It looks
>>>> to me that unsafe code is still needed to do bogus things.
>>>
>>> I think what you mean is that the invariant of `addr` and `maxsize` bei=
ng valid
>>> is on the implementing type of `Io`, e.g. `MmioRaw` and `Mmio`. The sam=
e applies
>>> to IoKnownSize::MIN_SIZE.
>>>
>>> To me this seems like a valid way of arguing.
>>
>> But still, using only safe code an implementor of `Io` can lie about
>> this safety statement:
>>
>>     // SAFETY: `address` has been validated by `io_addr`.
>>     Ok(unsafe { self.io_read(address) })
>>
>> Granted, the same person will likely have written the `IoCapable`
>> implementations, but its safety requirements cannot be fulfilled unless
>> the caller also guarantees that the offsets it passes are valid, which
>> the type system alone cannot guarantee - thus the need to make `Io` and
>> `IoKnownSize` unsafe IMHO.
>
> Hm...the implementor of Io and IoCapable has to justify in the implementa=
tion of
> IoCapable, i.e. in io_read() and io_write() that the address is in fact c=
orrect.

It doesn't - here is the implementation of Io for Mmio:

    impl<const SIZE: usize> Io for Mmio<SIZE> {
        /// Returns the base address of this mapping.
        #[inline]
        fn addr(&self) -> usize {
            self.0.addr()
        }

        /// Returns the maximum size of this mapping.
        #[inline]
        fn maxsize(&self) -> usize {
            self.0.maxsize()
        }
    }

Now what prevents me from doing this:

    impl<const SIZE: usize> Io for YoloMmio<SIZE> {
        fn addr(&self) -> usize {
            self.0.addr()
        }

        fn maxsize(&self) -> usize {
            self.0.maxsize() + 0x10000
        }
    }

With that, I have allowed callers to invoke the unsafe methods of
`IoCapable` on an extra 0x10000 bytes of I/O I don't own, without any
unsafe code.

> So, considering that, it looks to me that we don't even need io_read() an=
d
> io_write() to be unsafe in the first place?
>
> I.e. we are only passing through values in generic implementation.

Possibly? Although `io_read` and `io_write` typically call unsafe C
methods though, so they would have to always maintain *their* safety
requirements if we go that way (instead of delegating that to `Io`
through the `IoCapable` implementation's safety statement).
