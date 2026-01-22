Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021112.outbound.protection.outlook.com [52.101.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90444CAC6;
	Thu, 22 Jan 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082776; cv=fail; b=TouGa/1oBXx98Kslu6SHF1X4fk5Utu2qps/oktklgNInd5Qm+OCmcv5ouPPI0gNAgy+0u1LOTlPodoXCvCF1NQb57qTmRrF+mX8pOl+PIm/ZaeC3dy8NPysrAh4Jo17x9TDJw3wW154qJUBigsqv+FeKtgi+IUabWCtmtUzau4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082776; c=relaxed/simple;
	bh=jYcXsCKKrZRUxjlbF1fT6Q5/WLYj3CX8rKmiJEZghGg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Kxl4MW5SLG8zPfo/F8ffKmvFNSP2nDOuKvpYcfpF7mMqaQbPTFGLISM11kWvHQcuzNuLEE7edW2K4y0yM52ae5de534s5NmF9KDySPzaP+nsC0lWlCsSXINBbzjgC7n33cNPLGglzAwp/XnSuFzyEpFnlKu51WBUxkn8KBf5wGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ijcu+Qgl; arc=fail smtp.client-ip=52.101.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ijcu+Qgl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivOvB4N6oMyItI+BXLKUqUyhWhUvrtFLZ94PIHhfCETJjsZxZ28XNIsA4P0AAmoHfoMyeagrEDteHM3bpa4vnU/mSQTxyoqBjf0smughIzO2eJj7oLMXQOsm9uzZms4TwZMduY9Od/r2SHWjnovpMJC4VqodNjxbiq1hPglx5uM63eBP3qNXrvzfp0+niZL5ULGO88S+XaQb98rX1bLnyRePJOJ87wN1mMM1l2vI8/xzCo2kMzj3f+mw/7z4OUT+INlO3IkUaRSVHJGsbzhRbAvcAUqsmy9PCMtx3sFt/ALaOe+CQSm5TUC0TRz+92r9Oua6K6EGbZTgqrbDRB9gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtDZEiZOmM4pZkfCCKWtzvmKBSifAlZ91/yI8ledmJk=;
 b=bhiGOocLYRzBOW0iZnW/76DUI2wAEcJuN8t7DKAShAMoVNv4L5CcQH8xp2wKGpqTJf7jMpY+/0PhYyDaFM78UU9tF+MYUhkhn9tj0vwd2wcWX6TAgm3+Dg6s08MIIl5e/bUwjgYMrFCe8wyDePrKl9zrEMhs6mDQSLw/OoF2V6bVRSSNpll5593sDj21V+OZAMW4fqg5xTPJrPHZSBMWrT+6/S2Mf3qCpTfxCrHyv3ZHLYcSC/L9Uv+0Adn6cR1I/QWOkFMob34MLdmw8t8qw2lGHaoY7YIL9W6yz/ULLqtfrZEF+CmdrmBc7sr7WDJoVZYfMTTagMD8HOEkYCnZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtDZEiZOmM4pZkfCCKWtzvmKBSifAlZ91/yI8ledmJk=;
 b=Ijcu+QglLNEVF35Cva9qHSxfTE6kAEHAludh6+s6h+dDRNuzFLOBUK4ysPV84jURfMFiUN9XcYBs/8QdPBpUyTeFMC9oJvEfiW5AitmV1ybzq5zJ34omEwVo+lb/L2agxVk0D+62PTGnRAD3CvIrXJNOP4dSNTarUVhLfRbEIKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2769.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 11:52:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:52:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 11:52:49 +0000
Message-Id: <DFV3I4Y0DZ00.22QP81NTWD9IS@garyguo.net>
Subject: Re: [PATCH v12 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-3-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-3-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 41894a2e-1751-482f-b6de-08de59acc4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STV0Tlo2L21nc21JeVd5SkEvQTk2TUxjTXpuOHoxRkhwdGcyOXEzUk1pZXMw?=
 =?utf-8?B?YTBPb1FtcFRLQkVSR1NwVDNqUG0zSEJsN0g2ZXNzazA1UEVhQlVUNnRINjVi?=
 =?utf-8?B?S0hJV3djWUV3VnBzTWFDQXdxb2Rkc0xDSG1ZbDNKREkvM05qT1VFM1R3c3hX?=
 =?utf-8?B?MGFZclNnamVYbGNJMVZXaWdVYnM5SnYzeE1XM3E5bEpEczFGcncyK3k4U25G?=
 =?utf-8?B?RzdXc0Rid3pzcmVTZjNBT0RRMndHKy93SGZkYjZ1WVVHOW5jcUV0VmdtTFYz?=
 =?utf-8?B?WnhJbnFYZzl3VWlGTndEUldYTndYZ1EreTVkeThmVzNUbkJidXIyaFoxcXBo?=
 =?utf-8?B?RWNvRG5ibWhrQkMwQ1N1UEtkRXRvWHVCS2s3RlRMRTc4WGJ4QWUreFR5R2Y0?=
 =?utf-8?B?WlJTSG9SVVp4b0piRm5IUlBOYVg2K09WWndTYVNFNzc2YXdFd2JJTlljYkhP?=
 =?utf-8?B?dFUvVnlxT2I5K2oyRFBuZS8rODNpV0NzUE94U0V5VFVwS0NqK0tEVEw5RWV6?=
 =?utf-8?B?ZUZxRE9UWm0yVUwxOWwxeThLMzhhUHdXUEl3SmhxNWEybGI2V0IxRFBqam85?=
 =?utf-8?B?TTh2ckZEdXZzaktDYi9SR09YNFY1ODJJenhVQ0dGOUU3cldSdnNOM1J0akZy?=
 =?utf-8?B?eldwMUFXRDNtdlVUZURnN1R3WnZXZXVCYU1jcHNkMVJOenZ2NUxRRTNKZU0v?=
 =?utf-8?B?ODJOQngxcVlxTDJSN0EwYW1XUVdzZm4zWk9vclJSR2ovWERTVlVUQjlVZ1R0?=
 =?utf-8?B?ZUtESkZLNE9za3psVGl2T1FnRUlUclkrQUdPanR0aXlENERzT1ErbXgyN2Vl?=
 =?utf-8?B?MjhyaHFKYzV0dkhNTlRNb0JxQUxsRHpJeG01NVBOOHN6R0ltWlFWc1BCRmRP?=
 =?utf-8?B?TC95VUUzcDl3MUdVVkZuTXcxSGRHak1iN3lqRDdrNE1ML3hjNlBENzBnWndt?=
 =?utf-8?B?R1lzQTZDbEs4S3pVVmR3b0xzS0tMZld1WmNWU0t6UEdwaTBrSVhnMk9PNElX?=
 =?utf-8?B?ek9XYmgvbnJnL25XK3BUWVlHanZ3dG9YMHhCOGVySXNOM2s2TDV4VFkycXZN?=
 =?utf-8?B?TXV4ditlVDhEVG1DdjlJNEh3YVpCc0J4dU1GWDJlalBobnU2VEQ4KzZxMktJ?=
 =?utf-8?B?Y3JLbE03SG51TVd4M21QYW11MnllM0RzS2JMZWtRL3JuQlhPVmsxVnZiS3g1?=
 =?utf-8?B?ZTBqdDcwZ3pLZjlWVlo2djFpSE9HVzdoRndDczdodktGYzNRdWtTbWUwdlY0?=
 =?utf-8?B?bGFvZ3dnL2ZocWJJaElldWczOERvbHlkbmwxdDZmT3A5VDc2NjduMEZ5Y2Fu?=
 =?utf-8?B?KzlmUEUyZnpSKzMwSG5FUzRNNUU5VVFHbGpSVE9qRHhCOTJ6dzd3eFhNS0N6?=
 =?utf-8?B?Z0Q0OTUxaUFNNlBoZUUvMVdEUFJVM0ErcFF2cnIzRjVwT09pVTRRTXlMalp1?=
 =?utf-8?B?d3FyUERQdnZkeDFsSmRYaGlMQWlQM1Vra1BodUx3VEFmTmJvVkpSblJiNndq?=
 =?utf-8?B?VElvMVJKLzMvWGNtdXVhSm9sSWovaDdXcEdNSHY4SU0yRXd6bGcvc3hWRnRI?=
 =?utf-8?B?S25XdHZHbCtjbDNpdzNEcitQNGhNVS9GVFRPSkVsemdkejRVZU1mNWkyV0M1?=
 =?utf-8?B?RFYwVFE5ZUFQZDJHWWk2NWFXQWRTOE5qUTZ5NC9WWTBWTGRBWjM2d3ZlUlM5?=
 =?utf-8?B?bUNhWUZMSTdvckxRNWsvbW1yb1FhVXhKVUQza1c0SlhuUmUxYU5SUUdFQm9Q?=
 =?utf-8?B?SzhhU09wbmRKa2tkYUpyNWhDTXJEVDYwb0NxaEhwTWdaR1lSOHpCd2lFRzkz?=
 =?utf-8?B?bGYvd0ZZbC9sMlVSSHRBVzJTdU1vTEN6bUYrcHczTndSb3dsRWZUTUFQajVR?=
 =?utf-8?B?WnEvU0pEWHBrU2VYVysvNHp1OVNrSGkrVkNRTFRIUVU1Tmt5cVBPQ0NhS1FQ?=
 =?utf-8?B?WnlTVUF1alRwa0ZlOGYwNnFZcXVFUlh3Zzl0SHFzc1phMnhSQmx1RDhPMWV6?=
 =?utf-8?B?ek5YNjc3b3dWWjRRRDdjckJvMXVvdy9SK3AvaW5Fc25Dd29FK3NvMzZQQk0x?=
 =?utf-8?B?d21oYSsvRmR6SGFESnh0K1ZFeWZZQi9oZFk2b0puUzlnQWJRZXhtSzgxRWJT?=
 =?utf-8?Q?pxxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2cyY2RTaXZWanpPZG1GNmZ1MHlLY202ajRjcjFqOHVnR2RQbUpCWDVMN0c5?=
 =?utf-8?B?RTl4dWgwV3U0SHJVNUEyUjN0bTBHdlVhMENzRDdKOW85aS9MSklEZlVsTis2?=
 =?utf-8?B?Y3BleWdIQ1I2WGlJQmhnaThqVUthYnJYdE14a0xCdUY2emxWZlNtdEhad2FI?=
 =?utf-8?B?N2FmVTNaU3FDcmtmWmlNUEluS1hCY2RSTy9wZ0xJSzRodHI0eDRiSS9tekox?=
 =?utf-8?B?a2p1OENOM09RSloxeUhBSDhpaHlPT0dhaUNEbDg4cXYzbm9uVVhhWFlHSmFZ?=
 =?utf-8?B?aTVZYXo2UHRqTXZVMXBvdTZHQXc1dy9QQ0FianM2SXVrcmlrVnkrUHNmMDIw?=
 =?utf-8?B?K1lyVzVaSVVRbGtnWXpPTDlhdDdZMjFhRWUyMDdJY0NKcnNsUjE5NEVxcEdz?=
 =?utf-8?B?TEJkRHM5UlBobFl5Wng2K3dYSThZZ1cvcUt5aVhCK0JVVXM5bWhZTGhFWG5T?=
 =?utf-8?B?dlFTc2ZtUElyZ1QycHV6Vmt1YTArTC9IMnh0czQzZXVISGw0S1lsY0tUWisx?=
 =?utf-8?B?SEtycUpZOWxwSTRPTEc0RmlCaW1PV29KTTZvSDdGYVVuUSt1MDBGamJSY2hP?=
 =?utf-8?B?UzcrMmFremg3ZHA5cHZXd2gvSVNvbG85dlk4U0trMDhPWHBKcGVITEF2RnYv?=
 =?utf-8?B?ZEFXbHpmTW5mQmJQZFloNE0vaXhwZ0Nad0ZIcHlta0RmT0dUUDNKa3VMcG1I?=
 =?utf-8?B?RnBTeUliajI2T3JpMkNXT2NXT2o4bjgzcVNaSlk4MU0yMWw5ODVjSnhuTnFp?=
 =?utf-8?B?Rjd2bmFlbDZiSXptRmFjeEIxaDQyVm5aRzlDVWV4a3ZKdnM1RmdlMnBNRm9X?=
 =?utf-8?B?OGpaOEJRK1ZlVWc1UGViUDh2NGFMWE5DN0tBRVdMalBsRjRjRE1ENTdma3Fx?=
 =?utf-8?B?ZHNsYU9MYzNwSis5dnFYSkI5c2ZSbTNOTXdBYlpSRTBTcFhmMitLZWJudy9P?=
 =?utf-8?B?cEJOK1h2RzBBTmRPKzdiSExCbU9IZFYzK1o4NXZaOHY2SXhEWFNDRVREODZ1?=
 =?utf-8?B?YXFjTXBsVEFGUkZoRmZJWjg4KzJ2bTdMSVlSZEJrQnN0b0NjQlZJZ3dQTHdE?=
 =?utf-8?B?OWR2czdKZjU1VW44Q3VHTTgyUmtQT1lUcnVtTGFOa09SdDdtZmMxVkJXTVky?=
 =?utf-8?B?aDJtNzVwQ2x1V0lySSt6Zm5ETmpId25IYmhFKzZha040QkE5WWYvNHY4MkVE?=
 =?utf-8?B?RUx0UFdoN1l3eTdHb3k3cFB4QUJ1bmFaelFqcTlLekNONDhBaGFNN3RWQkNJ?=
 =?utf-8?B?Yk9PQ2dVc0ovUUhRQVpuci8zVStWQk1IbDZHYVdLQWowcW9ZOFRMVXB6eHFY?=
 =?utf-8?B?WGpVaVQwdFdDd0NCWWF1bVgrdlBZMlBJSDl1dzdOVnE0RXNNakx6NXJHOUMr?=
 =?utf-8?B?aE1sSndDTTN5cVRLSUptTFczUVVBNmdMWGFXQXVGZGc0Sm9TaFVUZFZmZllk?=
 =?utf-8?B?dVVjTWRpemxodFZaclVWT0JkYzFSaUVSVkU4cFA5c0E0Q3JsT3NBcEdyRUlw?=
 =?utf-8?B?NHpaNWlpd2Zoa0lZaEx3NDVqVlFxbk5VQVN0ajlpLy9mb1pqRHJaQ2V1Tkl5?=
 =?utf-8?B?ajBDcXpTY1phQWZUTzFGWXZQblk0SkVvbFR5b214emVCL2xnQzU4cHNwdnQ5?=
 =?utf-8?B?YVRhYkpWaDc0U0xTZXhuSDBlaStnOStIZWF3cWpzVGV0V2xlSENjUkJsem1M?=
 =?utf-8?B?OUZRSVBOcDRVMkZhMHFCU1AvNWRoZmxGUzNEeWVnR2YyMXpmcXJ5NVA4TWFB?=
 =?utf-8?B?NENGT3BBU1ZiNnpyQ1FwVXpYTnUxVzJKak9iRkQrSnAxNUlhV3hlWjYwYnhN?=
 =?utf-8?B?VnNrWUZLQUVuNzJzaG5vK1dpcjZrVCtIR1VPMHpITGorVlNKcGhtaytENE1B?=
 =?utf-8?B?bFJBVzFnYWxQeGRYVkk4SkhrdHVjVzVqcnl3eXE5aTFOYk92VDcrZDQzc082?=
 =?utf-8?B?b04yQlZNZGxQWE93a0tGSThjdkZOWmJCQkphSW8xNi9iQzFOcHhBclBEMGcr?=
 =?utf-8?B?dEVzN09jMTZ2S0kvTVhYTTRWcjAyY3ArZ0xUZXVYNWdSMUY1YVFpL0xDU3Vt?=
 =?utf-8?B?VTJ4Q0ZZM3lIdzhyVDFjd05nbGZLNGU5N3FOZnd4UTVFdzUyUmJPdGVFYUxI?=
 =?utf-8?B?dHFSRXlGVmsrbjJ6eS9pWFpsTHU2a2ViWWh4N2JhbFlkQ0JFcGtEK2lzUnQ5?=
 =?utf-8?B?OHFoajMxTmhBWi83OUt3aFBGMkFNa0JoeG5lTmExb0ZYSlZ1S0RTSmtCZGZp?=
 =?utf-8?B?R3ZXUHpXUnZELzFmZ1BuOVNoWmRYREovN2ZSMXNzc290S2xHTFlocW1JcDhv?=
 =?utf-8?B?NDd6OUZBVXpsYWV3QnYrVGFaakY0TlQ4U0s5YWgyV08zTDd1MnVuUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 41894a2e-1751-482f-b6de-08de59acc4c2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:52:50.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNHypa3nCY0PFVtHUZ4u43oq9TJAH5tAlVhki961kEAj1oasiGy5BYl0f6wWFm31Guzsm6ADoZwpnfeiyBcSMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2769

On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevent=
ed
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
>=20
> Establish a clean separation between the I/O interface and concrete
> backends by separating generic I/O helpers from MMIO implementation.
>=20
> Introduce a new trait hierarchy to handle different access capabilities:
>=20
> - IoCapable<T>: A marker trait indicating that a backend supports I/O
>   operations of a certain type (u8, u16, u32, or u64).
>=20
> - Io trait: Defines fallible (try_read8, try_write8, etc.) and infallibil=
e
>   (read8, write8, etc.) I/O methods with runtime bounds checking and
>   compile-time bounds checking.
>=20
> - IoKnownSize trait: The marker trait for types support infallible I/O
>   methods.
>=20
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements the Io traits. Rename IoRaw to MmioRaw and update consumers to
> use the new types.
>=20
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/tyr/regs.rs            |   1 +
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  drivers/pwm/pwm_th1520.rs              |   5 +-
>  rust/kernel/devres.rs                  |  19 +-
>  rust/kernel/io.rs                      | 398 ++++++++++++++++++++-----
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |  16 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   1 +
>  11 files changed, 433 insertions(+), 131 deletions(-)

