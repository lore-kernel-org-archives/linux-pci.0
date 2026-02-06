Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2812F83B7;
	Fri,  6 Feb 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357641; cv=fail; b=Z/YNgmPLiY8cOlL52/4HdDiGKXFUFxDEcUPffbOl6Y/AQOCWfeh5xv63HJRhWEAu5wn12wFGweXhB94En+iMHNR7C+b9zTgQGu5+AI8yLo5laxJMU6XRu/QgkDFp72jCEhKnVK7NBYepOPTOg+j1fHkyNLI74eX7xvO1EQlMzJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357641; c=relaxed/simple;
	bh=BVNIVCrLfdQKS258Cg9tVVB/3neY9tOQlAyGfdHbJ7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rMs5ZecEaAal7aRPU1Dm+9HPwFYgXRgSbch34GbsEXjRed0pm7o1ww096+6HJW2U6Todi9IMmlnoXzMG5WGu4AYOJ+bWeVoR+XDGxYcY6gmZX5tR26R4qudjzokCJtNqymjAZS4BPByOJsdzMWhtanOqXNRa7UBrew2wVQevq4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vwkn3FRM; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vwkn3FRM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1NFucp+TrcY9nZDVv6vqMK4TTdWYXQtUvKxe8aQ4mqVgY3TyBKGDxqS9LF+RLUv3L2EX08Zf3J9w9W+hIEvDwAb+VuSHGd8FjDQLWBXQ3iuebu0zpVmt9suxn9Q2MLZ6K3/EDgp+cM+PiB+wOCPzYX1EzHPmgyce/amxiF8nMo/VR83AjdXkBdUO2aipi1/6jX/d79H11SuQIwzwM2yg+RNz9G5gkQ3MwDWlPSKPCE/ih9ugtChndd4JdLguR81kfBqiFxd1vdepwdGf4qttgLxBAhXQHKZny3TSzYBn/OSBvjICRwkZA5gBvQjENdLYf+dr/BZ/+P8j9xZEazDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI4ueIdK7OkUMt6EMTicCyjHyHzX/hnd8kbYyYZ2W38=;
 b=spy4qPA/4O5G72VTyej3AnAMUaljqj/qU0wv0O7qs8DumgafOQW/prkTF6gMeeECV+Jg9TuIOg1Py/UoUKnG5qfnMLQB82cBMc2EaFbCBqt02U8f4jZNU0ZbVkq2579KjuwhDpCuNFm3t8nO/99DZFYX8B55N2iMQfoCxHxg62wtrD+fm90DhvECTu/pDMLLBd3LiIj0aOGvZIHjwuJKVOPDKgHetT2PzSouKuUigzkdqPEQ1Q82Of2Yd6gDIvuf9t9/GoCrtW4DyLnbRjTRJNy/KxwUmFm/ylOtmoovIyMhxbeNdXgNMkdwMERyxlbocZ8JaNXt+D/k3Y7BHxNf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI4ueIdK7OkUMt6EMTicCyjHyHzX/hnd8kbYyYZ2W38=;
 b=Vwkn3FRM9XKq9cWJbodd+IhR+evHfpJagvy9TGzkhJhFPGY87Dmz0RHKFvHfSsRhxlkFcH8tACsUrOEmVuh6foNUcHDjoIzy4U/BCEuQvZe1ExHEYuBUrBstK/cCjLGXFDa0cIOzDUCBV4qARwscIuuKwBFtM/lridb5hsNZTg6YA0CtbJyFaLMpoW2IvTQSEfG0uDj00T6YoM9MOjE8lp0OMwA6iyx2/EwxMHQdS08BcwefkdKLPP/BLi0AJzzX1njqIJTMe2p/XiJBzG5sFYOu4yKiBoLN/CQKOfDxR16YLZxY3v9hKjdop/oYpkAIn48tetbAfnnUcWh0TSYHlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 06 Feb 2026 15:00:15 +0900
Subject: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-io-v2-1-71dea20a06e6@nvidia.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0324.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: f8335b5f-016d-4f08-d802-08de65450990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm9tUmVoNEgxbGZxaHc5R2NzSE9ReUtMdVltQ05ZTGZMNEkxNVJEaTJ2Wkkx?=
 =?utf-8?B?c0t2NVhyQm5GUFJMMnY0OEg3WWhXZ0xKeFFTc0ROcCtqY3pIUEdiSW03NWRX?=
 =?utf-8?B?NDl6azFmZVdBZlFzT0JQMHBITkhycGpMT3kwaGRsN0dhbXFxZEVoOVpuQ0Zm?=
 =?utf-8?B?aWRnRHFQTGdCWkZIYzhvLzBHMTUrR09GN1psWGliZVBhdjdKUkxDb3A1UUV2?=
 =?utf-8?B?Mk5OTmpxVytIQVM2d21CS1RTTXRHZGx2OTgvcGRTRzZKY2RXVjFEM215RHI2?=
 =?utf-8?B?WFh4Z0xLOVJ5cTRnQURkdTd0ZGZGci8xZGlubnRmZW5yczBZSW9OOStZVUZv?=
 =?utf-8?B?eE5EQXRNeDFPOUtKTkR5REVHZTkyUllrcEdIN0NMV2pUYXZrMFJjZVB2dDZM?=
 =?utf-8?B?YUVVSjRJNlBmbDd4ekNWb2ZmN0wyK2VWZmVIR0dQVmRJMUdzUnVENUZIWTZ4?=
 =?utf-8?B?bVR3YTNhdTdxdmZoNTZXMjlOR1VFb3p4dk8wUTFqVFNlZU9yRVJaSUNyZzVs?=
 =?utf-8?B?VXRUQ1lIUG5tUVFyalJNRnJhaThaWlJBcnd6VU4vekNzTUt6a0E4NlI0Q29U?=
 =?utf-8?B?TG00OTFMclgrdDBwVFhWY0M4OTNNc05OOVJhY1lySkMxZnJEcks3Y0IvRlhQ?=
 =?utf-8?B?SVEyRnozV1VNRzJZOHh5K1hvN0ZSbmdhdWJlRE1JZ3VTeDhHa1FXWC8yUkh0?=
 =?utf-8?B?SWNBVkhjNDNzczZDUUhMSWlha2FtVmdienRKUVh3TWRGaXVFUktEaENBRXNl?=
 =?utf-8?B?S0lYVGZCNDFXMzhWYTQ4MWZoWnA1cndlWnRRSnFwTTJab2hkR3Q4Y2xXNHRk?=
 =?utf-8?B?NVdxYjgyS0ZUV1U3VXpIa1NvUFFaTlhJTURKQzNOeWtGcS9LVTZCQ2RsWjhp?=
 =?utf-8?B?c3JLZWJxalVBMUx0aHRBQkw5S0dvNGZjbkxFZ1pGNTczQ2xDSkhMcFF4RnUx?=
 =?utf-8?B?V0dQZ0V5d2Q0eFRSc1J6Y2NtaWR6T3U2SUtkaFphdEc5S3FKVy9vUHhLVFBy?=
 =?utf-8?B?VGU5Z3NRQyszYUs5My9aVU1JUW1sTXJPcFRldWhlaEc0WW9KQ09hSjVucWIw?=
 =?utf-8?B?K0dDeWlTYU5ySlI0TDRDejI0STdpMjFlbm1kSVY1cGprb2xtb2J5NlFlVnBj?=
 =?utf-8?B?MW8rL0lSaG1kOFl6NGxEWkNsZDBlSnM0ZGIvekN3c0NrTkJBU2IvbWFJckVs?=
 =?utf-8?B?ZFplTnc3cUZRREY5MU9JTkR6alBwRWhwcEFSNUluaFBaS28rdzhYTTBPcEVj?=
 =?utf-8?B?K2cwSjRMRW9adGhzS3hvT1lRUVpaZmliMVVyOXZ3Q002dnIyT2hhTEYwd2VQ?=
 =?utf-8?B?K25DRDhWbEV0MU9oeFF5VDFBK1FFeUZKdGJIYUYyR3V2dFRiRnhYbDIxcysz?=
 =?utf-8?B?SXo0RmZWUVBJV3ZxN1d1S1FaZkNrVGx6QUI5eEFpalJPY3lOZnExMXdxZWVp?=
 =?utf-8?B?eW0wQ0FRdDcvWnp5cG5sbGRhMDZGNlBpWUhmeUJ6aG1KaGpUVzZIamNSZWlu?=
 =?utf-8?B?ZGJXMDVuTzlxNUFTRUhPZVJ2dm1iVGw5QlU3alNPdEdUL1lCaVdjMFJjVEZn?=
 =?utf-8?B?aFhxaUFYeWZqWEtHS0dLVEFMeE1aYzhzQnBQOTNoNVU1SDJpRmVvUXFEbVBX?=
 =?utf-8?B?U3dPZFVWM0sybVk1alIzbHlVRGtQRkhmcmFHeU9aYTlnVGVtb3V6Ykk3ekxF?=
 =?utf-8?B?T2hXUHRSUXNTZnpncXc3T09ZVGhEckp5bTc0bWQ1V2lSVU5zWmdMZUs3UDBz?=
 =?utf-8?B?Y1lVczFyc2haUDV0eVR5QmZJSjFtUjhSTFp4dnBwYnFyc2FlMEc4azZBTkFB?=
 =?utf-8?B?M0s2SWVFU0hZWVhxakN4UUN1YTZPcWc0MU9kajhKaDVPQkJtY084bXB3U283?=
 =?utf-8?B?NlBGTmViRi9yTnl2WUpHTUFrMW5icXhiOFM0c1d1anBKTktPcHl6N2hZaHdl?=
 =?utf-8?B?WmpqTGh2TStLc2FPMDVyd1IwV0c1eFlsWjdzajh4dWdzSUhjNDJUSjRsZUVQ?=
 =?utf-8?B?dURnVVFVbUpENVRWUm1mUzBXWkVwa3BIQTViZlp5eWtGSlkwT1B5T2lVbW4v?=
 =?utf-8?B?K2QyMjBQU2ROOVZoTjBQdnFjbUVyZk1sd1Vnc1JHWFhxN2F1MExQZjJtaUdB?=
 =?utf-8?B?WHErNm5IRlBlZ3I2UFBMZXVkU1Zuc09pYk5VQ0ExeHoyelFoVXBKb1NpQTlq?=
 =?utf-8?B?QXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEpHNjZDQzhNVGhZVFN3cUtiMUxHd0N2RXc3c1A1MVBFODJrTE9LU3pGd2JB?=
 =?utf-8?B?TDBJdGhvMVZKdGJ5S3puNHg4R2NkNzhUekk3M1VZbTJHQlhSWkhoN2xHTjJV?=
 =?utf-8?B?QkozbElHdVBRK3pPNG9zRGcxQXNBczN6MVFURTNSVnBMMFRzdnI1R1hEekFY?=
 =?utf-8?B?UFF3dzhhNk5JUmY0ckFoS0dYVXBCajVIMHRqSmk2UVZkeS8wQzB5N0RqaWxZ?=
 =?utf-8?B?RSs5U3FrbURXQk54RHp6Q0ZZNHB1L3FYZXVZSGdJRUNMWEp6elRqSUgyZVUw?=
 =?utf-8?B?VU9GNG9oNU5YdkRrK280NExyYkFmY1RYOEFKV0tNSSt6Q1plWkZrTmljUXUr?=
 =?utf-8?B?dk5MOGFOMDVGQU5FS2szMHgwTmcrcmlhK09lQWhtVnVZcDMzbmtPV1A1Vzhy?=
 =?utf-8?B?bXQwbkNZSFY4OEZqWUlBVFB0MldaeC80SlgrWWg2QVB1SFJIQWN3WS8rRDEz?=
 =?utf-8?B?SjIzK2Y5TitUT1g0WnRFc1ZvenNCR2JKNTBpS0VwcHE4cnI0bldxN0FDMjBh?=
 =?utf-8?B?aWJFQmlKeWRRaFc0NVBkR1Eza1lqQ1YzRTZOaFdwVHYzY2dCR25sVHF6R3BR?=
 =?utf-8?B?R1JBWnRPa1o2NDgrVU8wb1hMS1lWUFhmb1EzV2N3YWRSYkNUL3Z0b2Uyelhx?=
 =?utf-8?B?VzRadmpoMnB5cytFcndacjcvTU52TUs2L0V3UjFQalA2UkZvRFlxczVMN1dS?=
 =?utf-8?B?dUVDUFFiVzl5OW5iaWZkNnVwbmUxQVdQbEF3WVN1ak0xNnRhanVZYXhhWUNS?=
 =?utf-8?B?MjF1TG4wamNRMWVnUmZaSkQ3Ky9tMGJkSjBaMTdvWmJDOWphSTlrN3VFWW4r?=
 =?utf-8?B?WERwMSs1em9YbDFXZUFLUzhGbDhFVEdJYnhDcGJZQlo3ZlZselBEaGR2SDFJ?=
 =?utf-8?B?cWkrT1JiRGZzUERNWUFpdGFvdGdrYjV0S0JRVnZ1Zll0TkZISzZUY1VvemEv?=
 =?utf-8?B?OTdWZ3duWkcvUTM1Q29oRDdYbGFIUDNsUU5QVUdHUXBKNFMySGswQWlhSjlP?=
 =?utf-8?B?ajNMUEJCYU9RZ3dXcG9oWUpQVS9ITnZCekZKK05XS2FHbklMRFBlbmgwSWpG?=
 =?utf-8?B?UENDQzViQWwxSVI4bDVhQis1R1d3VFJ2MFczbFliOFlMaGorNFF4dDluOEZ4?=
 =?utf-8?B?dW5RMGpKcU9oTDJGNnZpSGJOWCsvZGM3aWdGUWFLUzhaTEtCRFM4eHF6RXJw?=
 =?utf-8?B?MXpwWjNjNTM1K0dNd2FnN1VOanRwY1JBVllLVmF0RDZwQlViYzR5WWhPSHBP?=
 =?utf-8?B?aU9TRk9WRzdmcHU4MTk0bjJvNW5qZW5FMU1ZUkVTYkJQcUwwaTM4bnNqUHcv?=
 =?utf-8?B?enVVNGFoQm1qNVg4bXhWRXhRNHlKaWVrRWRZdzMyMGxYQzJjK2pBTS96S2Fs?=
 =?utf-8?B?VGdLUTBxcDBQU1ZDd1M2Z1Y1L0U4T0o2ZFZsT2pvWEZ6ZjUramt1dEdGbkdh?=
 =?utf-8?B?WWRRVUxMMElqbTBJS0NnaVc2em5lQjVtOGtNbnpLTjVtMWpHMGMrd0h2aGZu?=
 =?utf-8?B?c0I4N3NIVEdaeGUzNnN6UnF1TUtiVmhLNzRBeXZmbzV4YVY4OUJINXhGQVRr?=
 =?utf-8?B?UU9XTTR6MGticVFYTDJCeUpmUFpWOWxlbC9WeXJoRHBaY2xDdWlCUktSck41?=
 =?utf-8?B?UnMzK1loS0Z3T0tHd3BDbHY1Q0FDNkFCRlkxdFJGQndIYWNHTUNRQnRyZmgr?=
 =?utf-8?B?c29pWjZCTytKSnFpdEJmTjB5WFFzak9OcUkyUVpyNjhFazcrSHlJYSsvdmdx?=
 =?utf-8?B?V2NLVmQwWi9ZbWY5aDV2U1hpQ241ajJsMzlnUUR0aWpGdzJxMHFDQWZLL3V5?=
 =?utf-8?B?K0c3R1M4UHVZMTRFMXdUcEEvNzRCQ1lBOE00YlVnZ1lyTXNhTGtOWlRjODFp?=
 =?utf-8?B?cjBpRDdjYzNPOEhCck1Cd0VaM1JWZTBKeU9iQXJQOWJRa2laK1lMTlB6dUNB?=
 =?utf-8?B?S2Z2TnV0QXhoYjUyRVFCdjZqR2MydDllYmVuRkNvYXpXSDNUbm91Wm1oWklz?=
 =?utf-8?B?dnk2M25oY0hqSEpDUEY4TXRGWGZlWWZ4eWpGZ2xTWkxyb3Vsc3V0VUVidXRo?=
 =?utf-8?B?MU03M0xVVTVrQk54MCtsSlZjazE5SmNVUlo3eks1SUI3MXd4RWlJNWNRU3FX?=
 =?utf-8?B?U1ozQ2tHb0Z5ZkdqTklxVThpeDNZdTZYZjZ1VyswcmxwN3FabGE2RDQwWTBy?=
 =?utf-8?B?YnQwSkhiMUJxUEY2VGZ5R0JpbzZ0ZXVUTjFwTk9GL1NQa3hOV0wvNVlMdE05?=
 =?utf-8?B?Unc1MjlxakErd05DU00xdHN1ZitIbVc1SmtTM2xTZTEyLzN6TWNtMTNvNjdB?=
 =?utf-8?B?ZldDa3M4bHFuUlRIV0dxVnVsREtXdTlsdzlOWGxkOHVtSmNaajZpTzM2dnJR?=
 =?utf-8?Q?WO7G6p4y6LAAl5fue5rC+QZjXfcwuK/TlJBQXT3JrG1Wn?=
X-MS-Exchange-AntiSpam-MessageData-1: S6y7faC3r8Lx0Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8335b5f-016d-4f08-d802-08de65450990
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:32.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09fkM5X9Bd9aG9nqv32eewL4uluA/aK/h+bGBQ4GJBGUkcggAGU9cHS7vK/w8DLgUemZV3/b73UgzhQ3/xddGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Acked-by: Alice Ryhl <aliceryhl@google.com>
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
2.53.0

