Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067D326941;
	Mon,  2 Feb 2026 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020019; cv=fail; b=ZPLox6s08JsG7iqtFfLj15ttnnu4vPAerZ9nL0khJ0xBZ5lnO31E/tTFYKasrnxHtorIGvpEDz8TXb8E2QO2mj9xzAxaejSMvlmbrPgr74sid5GSt78B4gej2H+MK5flzgsGmgaktD7QZygBieKzgOMlQ4FlSvO4JVOBPUatNf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020019; c=relaxed/simple;
	bh=V2iqBH8TeSQLs3aW5CNBX9JjX8/JC3EFjpPntS3mrAs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=spQRLK9AawLKSkNpcwBf+wtpV+7Z7TCa8SPOx/Y9nvXSoVkGWaiWcpK5PwIMj5idomIgn7xiVvMfSGeazp94BP52WHFnjPKnpUTxZ77wd4XNdyH3vR2V27JlygA6p6s0v3Ki6MFTEeNdS9Vk3twA7cxwAAUNyO38cZE8szcoxMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EvPPojBy; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EvPPojBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHeZWippQyYgLx7o7425Tj9ePkA3LPG2Zi75UY7xTc5CrWZajU5tqr70bcrczCbLwnyHZkhrkdd5KE9PoH7bmfrBqwj4FwPwtzHGKyGtpGbKroIE3vihKdE/GJPPasL8Lu6OTiyTJZlbJsJ3m/P3uPi5oS8qbNhEcHLR1YjXRRmZFnqwhl4shcmBK1HSsWco9r9GENFvy9g8IywrFA6xR2EyNXXep2/SVmfi95etmzvY1ZLhJ/gR/zfphvFY3ybINoIIYs1UuVzqOEEeA48J/aNgaY2CYdhnffWrph/C12b10uDuapofa1n/s/GzztGamV1hSU6nCqi1yx1FUTxhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCuLjav3FCiH4jtqG9kkEDAVMMqw32ABXXw/p7YIcyU=;
 b=CAmvwhfO07YtfhvXw8TrgAbzAmeDTI9Y9dGdd6wl4NqP5S1JAXSlPFLJ966FGw3oMERaZ5DNHWSHI2fRTdUgOezjz/6ViYTJt7L6vV8Kd7j+dO3tsnQXIKU01pzZBDqWunR89tnAkQr89XdG1cm98SAEJjQN/f13/+sbdiiZPsYADslT3JEBf0eS0MDnr6Gn9BfTOUP7gc/ZJ6PFhyTbYcfZs5ApPuZeaOIqwlc33AIcm5IQ755yGpxsWT9CddQMy7QbNUQkClfVpViOe/pFFdhQ9itL4Wdf2ix/qO/hLWNvt5c52w4RyaO+7MFhE84VZ3VY1N/hxldi0y2XmHtIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCuLjav3FCiH4jtqG9kkEDAVMMqw32ABXXw/p7YIcyU=;
 b=EvPPojByqZJiAPOpmSElUktVUt7yofu2g5h0E8X3gRqUTs3+UneAJTYE0AD/fw6DX7XbADRpjBt6iC/vTqXCOVRtNYCsP5IGnHtml/Ngl/gX8iw0knrH60mLqVIh5FC8R/QkDWAUcjJQ7ehJBq5Ov2Pm682wvNsf7RK65DbqhN5eZIVJbQDSfXUnV5uMw7WaUE8GtEx5iNf1SJ9BMs+u/rfEFCXBRf58ZwTtmUO4SHp0ZWtylx1yOTQn3JSFKiKHOlaKLk25Q0u67uvz6aO4pFvraVCY265mXR0x5Etx2f9LK3NoyKMONoOXVZ+2O2FY4Q8VPcf0cuz1Rs1ptPe7AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:00 +0900
Subject: [PATCH 1/6] rust: io: turn IoCapable into a functional trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-io-v1-1-9bb2177d23be@nvidia.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f053bd-6808-4701-822d-08de6232ecc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkNHajQ1azFMdmhJenJtTE9pejY2T0x6UFZwbTI2aThzRlJPekxicjZxaHFt?=
 =?utf-8?B?dHFTRjRDaE1ubnA2Z0EwZmp2TU1VazcrVWc3N2pBWUIveTJybUJXdXhUb050?=
 =?utf-8?B?QXZVUWh5UnRLcXZ0Zm1ZWHg0UWRTVXRkeS9HbVpVaVNvQTJCclZ4ZVpta2k0?=
 =?utf-8?B?SDZwS2JDeHAzc01YMWNYM2ljTzFRSlV4WTZUQmVqT2RBM1ZMbzNWN2JMRnM2?=
 =?utf-8?B?cjhTZFd2amJrRmtRVEZXVFZDVk9vY3JKU21ZSEsrYzdqQVpJNWJmSUFJeTkr?=
 =?utf-8?B?eGcvNkR4Qm1uaDQ3eExpNGdxK0lSOEg4ZE9PQW9WNnA2SGNPMVEzbnd6M2pY?=
 =?utf-8?B?cjd1dWZGR3VhaTVmb3R2cG5aRUtDekhaUEM5dXNuR2lKbmZXOVUzNWZqUnBy?=
 =?utf-8?B?OWxDdGw2Uk43ODhsVWVRMHlycUMwTmNpWklsM2JURjZVeTNzSVFSRUdMbFEv?=
 =?utf-8?B?OHZQS3BDWTF4TFJ6Sm94OHdHUCtiZDA4KytoMk8yYWFQdHE5UXB0OFZIWWNE?=
 =?utf-8?B?d2VsYVkvOFdrZlJSWWgvS1R6R2owbHEzUEhJa1hDekszeFNLaTlIQVRLaG1n?=
 =?utf-8?B?MENVMGZjNS9xMHlXOGl5RXZLUzJoVkZUK3FCak1lWldJSFFVL0IrcFIrOTZq?=
 =?utf-8?B?amdWWHFkbVZUOEZ6RndzL1h6YXl0M0NDVDhBRE83S284eHAvcnhlQzU2ZlJo?=
 =?utf-8?B?U3NIY2JFRWFIWml6MHYvbzlvTVFqTUZxMHJyYTM2TFpOdU42bXpnYjFNdE52?=
 =?utf-8?B?bTEyYzdWczdnSTBIdHcyaDA2LzFMNlkza1hwZjYyUk5FYzZHeVN0cklLajN4?=
 =?utf-8?B?aXVWOXROUkJLcEdyWnNnNlpiY09LeW9pdno0TUNsREdJQXhOWFVlUDU1MkM3?=
 =?utf-8?B?WC8rVTNLamdLam5KRVVzQnFERkM1MWI5M0JtaTY1bDFmc09jSlpmWUVDZkhY?=
 =?utf-8?B?N09aK2tCZ2xlOU1nNHZTaEhia3ljTkl1WFN4U0p6V0VOdU14K21yMFUydkV1?=
 =?utf-8?B?bU02ZElNUUJhNnpyY0tEZC9oSThUUG5MMkRIMDM4U1dONHZqZnpwNzd5ZllI?=
 =?utf-8?B?WVVjQzFFZ0JtLzdmdFZDby9ZK2NwQjloOVRiSmlHN1FoUmY5aDhYNGpMQnJS?=
 =?utf-8?B?azIxVThPSFIvVnZnMnBWM05XNGVqN2FPQ1YwTXp3anZyQ2wvajJzUmVSL0lI?=
 =?utf-8?B?WE9kcHJycys1Q3V4SDhBeGdVcHMrWGtwcFZMbTV6Tk1KckUzd3kzK2p0a2hY?=
 =?utf-8?B?UEw3TGNBeXJDbnFlSDlhZmNoR0RnZUxkN3UyZ3VEWkVIU1NEb2IyYkFKTUh6?=
 =?utf-8?B?d3p4RzNTdHVlazQ4Wm1jOVllY3R1eDFXdElYNmZNQTJFTUFBbk5rZkZMUFhn?=
 =?utf-8?B?eXNGcHVvaXBPUXk3ODJNbWZ5N084TUhmaTZ3U2M0K0F1SDlLVDFyUllVbTRq?=
 =?utf-8?B?ZlFkNnRxMkhCTldhYlVBU05OTUJ3VVBxZThNeXFFNDljeWpUNXZHcGptc2E3?=
 =?utf-8?B?UTdSK0Z5cmxkR05lRUs0VXREUnB6TXhRRnkyUmxxUXd1RXZVYmI4YWlzTVl5?=
 =?utf-8?B?eE5tZm80OTEvOGNnVmdvd0ljOEFUR3EvU2RPRFlxQURmNGtwUW9wclQrYmFN?=
 =?utf-8?B?aUtLR21lQXlCaW9QanAzdmEvbzBjR3hkdC90NjZ4MzkvVzBuZW95MUFYSC92?=
 =?utf-8?B?Tmw4Q3BUUU40azROZ0d2eGJGTTF3QmVQZkNtOWZDRUxIdE9mT0hCVEZHQWd0?=
 =?utf-8?B?RERxWktvSTg0N3ZKZFhYRlRNNkk3NXdYaUZRb1BwZG9ZS0hYOHJNWlNzelRF?=
 =?utf-8?B?UE8vUnkzMVo1RkorZkdqWmg3TnpTeGVQbWZYZXducCtRMmpvclBkdnVEUU9s?=
 =?utf-8?B?djJEeUdTNmtnT3pmZXFxOVRPRWw4M3MweXhqVFFySlUrc2oyVE5CTmNpMUZS?=
 =?utf-8?B?ZzVMYnVDYUdNRnNibksvMnVnQjVmb1hISmVjaTFjUlRTaWgxOUxraHBVbkdZ?=
 =?utf-8?B?QzQ3bjZKczZiMHVuYkIwN1Jaa0tGQldXMWV0MnRHZmJIa1BBaHZvQ3NuZWt1?=
 =?utf-8?B?VjhmbkpQRS80dFRhTEREUElxR3NhbVdrT0hqNGJlVkVYdWZwdE9Ha1lvTFRW?=
 =?utf-8?B?MzhNSlhsTXNWdnNEUFJ5ME1uSHlNcmY0NUhCb2dZTDJOYXlXNEtyWDBtZ0hK?=
 =?utf-8?B?NFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWpOcGl3YU03SUNGUXQ2MjNrVXQ4QkowTlRnUGpDR09RTE1LK0VxRVBqR1BD?=
 =?utf-8?B?bXpFM0xxcUVtQkFiK1ZKVFpzOUtwNjIvK1o3RXNpMkdiVlBuc01wQ3R1d1pD?=
 =?utf-8?B?bm4wQ05NV2F4WWhnU090RE5pcHRLaWVZVHV4b2RXSWlmMGNrSFdNSzZMZ0xZ?=
 =?utf-8?B?dkk5bnk1RFF0QTVsb2Y4VlZ6Sm4rN0lrcExEUWUvN2lTUVBqRkMvaHRodlFR?=
 =?utf-8?B?T1ArUnkwZTJZaENIMzZkL20wRUJWK1g4MlJYRDMvTXdtRXEzSjFvRG1CMU5i?=
 =?utf-8?B?Vk9PZFpwUy92QUpJYU9qQXQ3cGdEbDUxa0YybU8yaE9hSXR1T295bHNxOHp6?=
 =?utf-8?B?M0thOXUrVjkwRGF6N3puZHJMNG91ZXVQdjJHL2ZDQVpZVVVPRFhEZWtyVFVS?=
 =?utf-8?B?ZWRGRk9nSnlMMWREcHN3MUdXTWpCT25pdjIxL29nMGNKa1FlWUxzSnRLMzlk?=
 =?utf-8?B?RkFGT1RzZXFBTDQ2dE1HUm5vVVRpNEo5ZndlTnkxMGJ3TVJWbERZNTB5R01o?=
 =?utf-8?B?NlV3QTBSbHZqZ0VQMVB2ZGRjTXQ5cEV5WGJzN3BGb3pTUm5MeDEwQktJQk9y?=
 =?utf-8?B?Y2p0MGRJblY1ekpic2FYNHE3Wmp0Ry9naFU5VktwV2paSjlPY2hyYTZENkkr?=
 =?utf-8?B?TjFIeHBmZXVCTU9tQVJzMzh3bHpaZEJIWGpydFAzdXhJMnFqeGFUOEpjYVg4?=
 =?utf-8?B?R0ZJcWJKb3R1RTR2KzFKaC9Xb2VkeWdRT1dkc0RrWjIyRVB3U2RZa3VDb0RX?=
 =?utf-8?B?c0NWSmc4RWMvMXM4eXFHekdlUkZUdlVwVUVVNFRhTlVqWmNyK0pxM2lpZExv?=
 =?utf-8?B?WHhVVWVNaVRKMUtORVVidElwcE1tQkNXTHRVa3RpN1BRQWloUlBRTVc4UEg5?=
 =?utf-8?B?cnFOSVFmaFQxVVRJTFVvRUc2cHJ0TE9acFNFQXUyRUN3S05kOWlOQmNtT2lT?=
 =?utf-8?B?WGJKWm04V2NUV2hqT3phcFYvMUVVaXlDL2psZTlzWW85V1pjUlBsaXV5L25s?=
 =?utf-8?B?VUJUQ1RxZEJzQmY5Yk1FaW5vUjNIcGd5M2FvcmpMbWlwa1FrK0ZLclBWZXRG?=
 =?utf-8?B?dk1HOHI2TmxVRFBzYWFsam5lbFVINFk3dDd4NmxhS1NnbjBpL2tZQlpwTlYz?=
 =?utf-8?B?YzFzbW1pZGRHdUdmbmpORFdQTnJZZVhvN2Q1UmpubkRIN2xSUHdNbklTQ0Iz?=
 =?utf-8?B?NmpkTlM3eHFmUWF6Vk14bDY2MXJFNDY2ci9CY0NIeW9TZ3E3bVZEaEcwU2pk?=
 =?utf-8?B?YkpUbFk3dWFRemJoZ3RjWmlwVkZ5MkpkYm1ybjI1dSthSngzSVZCU3hSUG91?=
 =?utf-8?B?aEhDVlFGWUMwMTJmbzc1Y09LL2JlY0dlajhyaXBWYWN2UE5ERklvY3pIOHFm?=
 =?utf-8?B?RTEzKzFmUWM4NXUvbm5OL2YrVHRYY0dRL2p3Y1BIdlJZVldXQ1J4cUI4UXlr?=
 =?utf-8?B?Nnp2S3FYNzRUanVjaDdmVElxeDFqb3owUEc3VDhsY3JxbVUxcWZDekhGbUFY?=
 =?utf-8?B?bzlqVjlSOFQ0cUs1MWw5ZWNva011cHRFQ01Dc3B5VkFoZE11ZjcyeVV6NGlx?=
 =?utf-8?B?U05rakFxTENKaGlqMTBNUGtLci9DcFFaN09qUGg2TWtKcjZWdDN6bElINHJV?=
 =?utf-8?B?RnpYMDRPbUFQUGV2Ym5UR0V4RzkvZGFSZGJpNDlQZ3h5UTduMnNoZFkzT1RO?=
 =?utf-8?B?MDRzNittV3AzM3NNc0UwY1AyMEQ5ZW5PRHA2Z0ZRS3AwVkdxMlFvNnhydG1z?=
 =?utf-8?B?Q3VESWY3WU1jTHRuVHVES3BQM2Rsa3laWmNqT29kNnQ0Q3V5Ykg3c0hhQ3pR?=
 =?utf-8?B?ejdyMlVodm9CYVVEdjhSVmNKL0hsWVJzVytSWmxSajJhQ1I1R2Z1UVhqRi9l?=
 =?utf-8?B?TWFEZW9ibG83d0JVWXEzY28wTytqUmVpODJkWHFQellNZTRjc1JZRTlTSmxz?=
 =?utf-8?B?SGdqRzlZSWRmWUtVem1hc0N6blRnNEk1Um04UGdLZ0crQWFVMGVhYU1GbXQz?=
 =?utf-8?B?M2xLSXFLaWNtNHYveFhTNEFldkNsQzJJRlhFNlN0Q25UTVpYSHdYY2lRNG9Q?=
 =?utf-8?B?cG1kR01ab0cwYk5qM01mdDNZUmc2VGxCcldINTV4Vmc0QnkzbkY4NURZbS9a?=
 =?utf-8?B?U3FkS0RFdFl0NVd2VUx2dHl5SnBha0dYSy8vRW1NTFRsdmdjWlNVYTVTaGZq?=
 =?utf-8?B?YTNZRzNLMGxNNkpEUk1HdFhvMVM4QkhEUzZnK1N3czFEejMwbzl5RVViajA3?=
 =?utf-8?B?SGZraU9XdS92ZVF6ZzBNK2tmZlF1bTgzNHlCRGpuUTBoWmFhUW5tMVZXUEl5?=
 =?utf-8?B?Q2dpODNmWVI1MVFRWldKLzFHWEVNWGMvNUhjRmdJbk5SdjhXZjBPR1FGSUoy?=
 =?utf-8?Q?xQVGymAwNwkpSiLKnwbXZojO8J8mnWcO/FQzomJNhLPmL?=
X-MS-Exchange-AntiSpam-MessageData-1: g1Vye9TTmep39w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f053bd-6808-4701-822d-08de6232ecc0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:19.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7xtIJW9expX2gOypihVx2Ztu1K8tHP24rKRLlHB5h5XMuOwXxpniB3fbBkzbyKoCRbmbEuCUbfuGAGfE102XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

`IoCapable<T>` is currently used as a marker trait to signal that the
methods of the `Io` trait corresponding to `T` have been overridden by
the implementor (the default implementations triggering a build-time
error).

This goes against the DRY principle and separates the signaling of the
capability from its implementation, making it possible to forget a step
while implementing a new `Io`.

Another undesirable side-effect is that it makes the implementation of
I/O backends boilerplate-y and convoluted: currently this is done using
two levels of imbricated macros that generate unsafe code.

Fix these issues by turning `IoCapable` into a functional trait that
includes the raw implementation of the I/O access for `T` using
unsafe methods that work with an arbitrary address.

This allows us to turn the default methods of `Io` into regular methods
that check the passed offset, turn it into an address, and call into the
corresponding `IoCapable` functions, removing the need to overload them
at all.

`IoCapable` must still be implemented for all supported primitive types,
which is still done more concisely using a macro, but this macro becomes
much simpler and does not require calling into another one.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs     | 169 ++++++++++++++++++++++++++++++++++++++------------
 rust/kernel/pci/io.rs |  37 ++++++++++-
 2 files changed, 163 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c1cca7b438c3..dc894a45bbcc 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -273,14 +273,29 @@ const fn offset_valid<U>(offset: usize, size: usize) -> bool {
     }
 }
 
-/// Marker trait indicating that an I/O backend supports operations of a certain type.
+/// Trait indicating that an I/O backend supports operations of a certain type and providing an
+/// implementation for these operations.
 ///
 /// Different I/O backends can implement this trait to expose only the operations they support.
 ///
 /// For example, a PCI configuration space may implement `IoCapable<u8>`, `IoCapable<u16>`,
 /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region on a 64-bit
 /// system might implement all four.
-pub trait IoCapable<T> {}
+pub trait IoCapable<T> {
+    /// Performs an I/O read of type `T` at `address` and returns the result.
+    ///
+    /// # Safety
+    ///
+    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    unsafe fn io_read(&self, address: usize) -> T;
+
+    /// Performs an I/O write of `value` at `address`.
+    ///
+    /// # Safety
+    ///
+    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    unsafe fn io_write(&self, value: T, address: usize);
+}
 
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
@@ -322,146 +337,198 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read8(&self, _offset: usize) -> Result<u8>
+    fn try_read8(&self, offset: usize) -> Result<u8>
     where
         Self: IoCapable<u8>,
     {
-        build_error!("Backend does not support fallible 8-bit read")
+        let address = self.io_addr::<u8>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        Ok(unsafe { self.io_read(address) })
     }
 
     /// Fallible 16-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read16(&self, _offset: usize) -> Result<u16>
+    fn try_read16(&self, offset: usize) -> Result<u16>
     where
         Self: IoCapable<u16>,
     {
-        build_error!("Backend does not support fallible 16-bit read")
+        let address = self.io_addr::<u16>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        Ok(unsafe { self.io_read(address) })
     }
 
     /// Fallible 32-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read32(&self, _offset: usize) -> Result<u32>
+    fn try_read32(&self, offset: usize) -> Result<u32>
     where
         Self: IoCapable<u32>,
     {
-        build_error!("Backend does not support fallible 32-bit read")
+        let address = self.io_addr::<u32>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        Ok(unsafe { self.io_read(address) })
     }
 
     /// Fallible 64-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read64(&self, _offset: usize) -> Result<u64>
+    fn try_read64(&self, offset: usize) -> Result<u64>
     where
         Self: IoCapable<u64>,
     {
-        build_error!("Backend does not support fallible 64-bit read")
+        let address = self.io_addr::<u64>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        Ok(unsafe { self.io_read(address) })
     }
 
     /// Fallible 8-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write8(&self, _value: u8, _offset: usize) -> Result
+    fn try_write8(&self, value: u8, offset: usize) -> Result
     where
         Self: IoCapable<u8>,
     {
-        build_error!("Backend does not support fallible 8-bit write")
+        let address = self.io_addr::<u8>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        unsafe { self.io_write(value, address) };
+        Ok(())
     }
 
     /// Fallible 16-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write16(&self, _value: u16, _offset: usize) -> Result
+    fn try_write16(&self, value: u16, offset: usize) -> Result
     where
         Self: IoCapable<u16>,
     {
-        build_error!("Backend does not support fallible 16-bit write")
+        let address = self.io_addr::<u16>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        unsafe { self.io_write(value, address) };
+        Ok(())
     }
 
     /// Fallible 32-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write32(&self, _value: u32, _offset: usize) -> Result
+    fn try_write32(&self, value: u32, offset: usize) -> Result
     where
         Self: IoCapable<u32>,
     {
-        build_error!("Backend does not support fallible 32-bit write")
+        let address = self.io_addr::<u32>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        unsafe { self.io_write(value, address) };
+        Ok(())
     }
 
     /// Fallible 64-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write64(&self, _value: u64, _offset: usize) -> Result
+    fn try_write64(&self, value: u64, offset: usize) -> Result
     where
         Self: IoCapable<u64>,
     {
-        build_error!("Backend does not support fallible 64-bit write")
+        let address = self.io_addr::<u64>(offset)?;
+
+        // SAFETY: `address` has been validated by `io_addr`.
+        unsafe { self.io_write(value, address) };
+        Ok(())
     }
 
     /// Infallible 8-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read8(&self, _offset: usize) -> u8
+    fn read8(&self, offset: usize) -> u8
     where
         Self: IoKnownSize + IoCapable<u8>,
     {
-        build_error!("Backend does not support infallible 8-bit read")
+        let address = self.io_addr_assert::<u8>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_read(address) }
     }
 
     /// Infallible 16-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read16(&self, _offset: usize) -> u16
+    fn read16(&self, offset: usize) -> u16
     where
         Self: IoKnownSize + IoCapable<u16>,
     {
-        build_error!("Backend does not support infallible 16-bit read")
+        let address = self.io_addr_assert::<u16>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_read(address) }
     }
 
     /// Infallible 32-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read32(&self, _offset: usize) -> u32
+    fn read32(&self, offset: usize) -> u32
     where
         Self: IoKnownSize + IoCapable<u32>,
     {
-        build_error!("Backend does not support infallible 32-bit read")
+        let address = self.io_addr_assert::<u32>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_read(address) }
     }
 
     /// Infallible 64-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read64(&self, _offset: usize) -> u64
+    fn read64(&self, offset: usize) -> u64
     where
         Self: IoKnownSize + IoCapable<u64>,
     {
-        build_error!("Backend does not support infallible 64-bit read")
+        let address = self.io_addr_assert::<u64>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_read(address) }
     }
 
     /// Infallible 8-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write8(&self, _value: u8, _offset: usize)
+    fn write8(&self, value: u8, offset: usize)
     where
         Self: IoKnownSize + IoCapable<u8>,
     {
-        build_error!("Backend does not support infallible 8-bit write")
+        let address = self.io_addr_assert::<u8>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_write(value, address) }
     }
 
     /// Infallible 16-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write16(&self, _value: u16, _offset: usize)
+    fn write16(&self, value: u16, offset: usize)
     where
         Self: IoKnownSize + IoCapable<u16>,
     {
-        build_error!("Backend does not support infallible 16-bit write")
+        let address = self.io_addr_assert::<u16>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_write(value, address) }
     }
 
     /// Infallible 32-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write32(&self, _value: u32, _offset: usize)
+    fn write32(&self, value: u32, offset: usize)
     where
         Self: IoKnownSize + IoCapable<u32>,
     {
-        build_error!("Backend does not support infallible 32-bit write")
+        let address = self.io_addr_assert::<u32>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_write(value, address) }
     }
 
     /// Infallible 64-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write64(&self, _value: u64, _offset: usize)
+    fn write64(&self, value: u64, offset: usize)
     where
         Self: IoKnownSize + IoCapable<u64>,
     {
-        build_error!("Backend does not support infallible 64-bit write")
+        let address = self.io_addr_assert::<u64>(offset);
+
+        // SAFETY: `address` has been validated by `io_addr_assert`.
+        unsafe { self.io_write(value, address) }
     }
 }
 
@@ -487,14 +554,36 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     }
 }
 
-// MMIO regions support 8, 16, and 32-bit accesses.
-impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
-impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {}
-impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
+/// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
+macro_rules! impl_mmio_io_capable {
+    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
+        $(#[$attr])*
+        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
+            unsafe fn io_read(&self, address: usize) -> $ty {
+                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
+                unsafe { bindings::$read_fn(address as *const c_void) }
+            }
 
+            unsafe fn io_write(&self, value: $ty, address: usize) {
+                // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
+                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+            }
+        }
+    };
+}
+
+// MMIO regions support 8, 16, and 32-bit accesses.
+impl_mmio_io_capable!(Mmio, u8, readb, writeb);
+impl_mmio_io_capable!(Mmio, u16, readw, writew);
+impl_mmio_io_capable!(Mmio, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-#[cfg(CONFIG_64BIT)]
-impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
+impl_mmio_io_capable!(
+    Mmio,
+    #[cfg(CONFIG_64BIT)]
+    u64,
+    readq,
+    writeq
+);
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
     /// Returns the base address of this mapping.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 6ca4cf75594c..8c8aab2e3f22 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -142,10 +142,41 @@ macro_rules! call_config_write {
     };
 }
 
+/// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
+macro_rules! impl_config_space_io_capable {
+    ($ty:ty, $read_fn:ident, $write_fn:ident) => {
+        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+            unsafe fn io_read(&self, address: usize) -> $ty {
+                let mut val: $ty = 0;
+
+                // Return value from C function is ignored in infallible accessors.
+                let _ret =
+                    // SAFETY: By the type invariant `self.pdev` is a valid address.
+                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                    // so the value always fits within `i32` without truncation or sign change.
+                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
+
+                val
+            }
+
+            unsafe fn io_write(&self, value: $ty, address: usize) {
+                // Return value from C function is ignored in infallible accessors.
+                let _ret =
+                    // SAFETY: By the type invariant `self.pdev` is a valid address.
+                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                    // so the value always fits within `i32` without truncation or sign change.
+                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+            }
+        }
+    };
+}
+
 // PCI configuration space supports 8, 16, and 32-bit accesses.
-impl<'a, S: ConfigSpaceKind> IoCapable<u8> for ConfigSpace<'a, S> {}
-impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
-impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}
+impl_config_space_io_capable!(u8, pci_read_config_byte, pci_write_config_byte);
+impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
+impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
 impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
     /// Returns the base address of the I/O region. It is always 0 for configuration space.

-- 
2.52.0

