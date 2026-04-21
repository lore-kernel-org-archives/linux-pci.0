Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA23612ED;
	Tue, 21 Apr 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752182; cv=fail; b=fdRguaCF5t7f1tvUz1hLiuJ01OYHeqnDSHglrAfWpouNKC1P42rYtmPCmcQ9hxdne6hhMUpXtKHh1nS2Hnavn3tBoItRReg14z2w6zZ4Xd8G7tzHaZtdcfwju1hD0VOTd+kqfwWXp79EjbL5tNsrZ9suD6hlhO+jBdc9WlamU9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752182; c=relaxed/simple;
	bh=ezOoX0R7U2YBxxEDUIDkw+0y/3SEvnRBUawPQHF0w/E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BxCVWq7gneocm9U7yTVHbxLEkwRVJS1wTBfs/J8rZHfgCWfMCUvivbKRxyl8lLTUYnZNRHSHrf/jfxtzBY0ekDxOXXzkntCm7C751rzH3SF6ff2iAH0A2l3HF8LnKtdIMktmRwh3C8c+apLvFeJlY9BuFJQA2hJEf0hjM2wLhSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VuXJhzo7; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuXJhzo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmwGr19Aa0eXyct1lzWvdhFfUiYVDkldx0fIY5wDI6WQsTPAksiFYqRs1W91nZrKkrHyx0UEkvIB2dh/eElLOb9R0yzKR3zLwe2TbEIY32C9xTjICQnL/zxb4GV+pOnwSmSNPI/8xjaWVOGpAo3l9tpcG+YYRH+EpomA1YSEblAA9RlRYcPgQzxmK2lJAnlvsXaBZnsnHlNDAESdWDstTdT/oA8JbxGPfzOmuPldklmzH/NzYNTjUoYKxegK9Oo5kP3Lk9GBlvjQ/eytU5VhlBgjegnckmbiPMULsMbFuYq7UfynSeQC2RiUMVBTEU0pZHfLqRFcdXSF+B1NHP2zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4965W/kk6suBOQScQmnfXZ5+mvbT6zZc2OycZbDVd8M=;
 b=Er9Cp+TIXd/IdMFj441p42l4Ezqt4AkSqUdhjnKXnTAPnFJoPbvCfEkIiaQZnwlnkAN85vdYFZ7uP9AvuyqeVoBA0iZJeML8PUvrJc9Za+mBRPQG9fKVEGbysGNqU7+KCJaHuF8xFcBsNXxu0uYT9f2dStUEcxswRn5tWQANQ8ScWMDzRBbBj4jvGibx1tfHuOBv0LHExL2E6lZwQqo+qsiZ7bNuOUh1oVSMoqM5HHTWq524dd6bNKf+7uJptsGbx3MMF173MxJhIGjDG7nQbFV38x94iI/txS3FwpSK83pfuGOZuB0y1VjNG1JKu9z8+6D0nyxDGI+8ctFlzpQekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4965W/kk6suBOQScQmnfXZ5+mvbT6zZc2OycZbDVd8M=;
 b=VuXJhzo7K5MiWQACvoqTg0s0PjUbrx0O3j9ooMiwXV4SbDVTR4zssont0P+cfR4vjMaktdHhACfo0QAM9gpvvhM6w1cFf91Jd+CeEuPXLPhZwmN6qiem+xD6PyHbBBzaLqWJ9dKHNUsbCFmGPWEOlvv+gyJRsNlwh+Hs8m2R9NG1+JjBljs6ZCW9/hkwCsLO5BijrUOabpJjzLE0EGwv97bH/A2db+Wvi4AXnyr4ZrVyis5MGWcxJLyW0cKxtEyI061/UCGr7YYEnqq9wl0K9i5Xpvr8CWW/E/uDMy8MbRqc6gsZLBFqKN3NRHVDF6c0KGctkfhWNeA8I4sXylbh0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/5] gpu: nova-core: run unload sequence upon unbinding
Date: Tue, 21 Apr 2026 15:16:10 +0900
Message-Id: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ7CIBCF4as0sxYDU0HrynuYLqCMdhIFA0o0D
 XcXu3b5v+R9C2RKTBmO3QKJCmeOoQVuOphmG64k2LcGlKgVKiNCLFa8wi1aL3YSB9e7vRm0hPZ
 4JLrwe9XOY+uZ8zOmz4oX9Vv/O0UJKYzV/oC9IzX4Uyjs2W6neIex1voFxN/XPacAAAA=
X-Change-ID: 20251216-nova-unload-4029b3b76950
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:604:253::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 477a7aef-f8df-41b2-62c7-08de9f6d7ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b+amCaogoNkfHXdsy2XtyichBYHDgUvFNS+s1Ravp+ukpe693kXUT2XxPOrMhqYbNA2umE4gxl/QMtJxe82nLjpDSFHud1nIhw2rX39s7ajQPcg8Tzf+Ep/Ql9mhQQRxzEOkPMT8ZAoXuFG0mp8LnHC/NOwAqlIBJh4jZitje/Nh5x8lf5y9OI30uuZ5bAKbTjlO5gp5jcYli6NIT+qOni44ujYoSSGo7A4ncC9NepSASQ1thaBhuHIdjMQ9iqMcdNVEpnnAu5PHbmJxCtGiozAwJV1ducJpGVr3Z+FX/b7UYGiFqeFMS391MaYrp/2M9rrXa39U32eG5Z234I12HEcBVA8ftV8XqiJ0RfQy2Pxirrni3376g150BGH8ZOn7vRQXnVIwqXYBtShW1uCPhimznO38VDU+SSPUsdmeGYVQTzP9yONRy8uiKaXkFw10QwxLe1JeNrAwfxmUJcQYV/9/NaxXWY1FnYbvLZaMyWCmm456Lp5p/ez2K/nmhCNhKoqnJEqRr5bqpWnORWT7e/uAgwbDAPIzb0/xg12a7wF/TQm1nHDIlwuB8of3Zl+rTn9JTQmlhzJazBIicSsTUVJFty6pnJEYiriIlf2ebFImBWyObzS94Um9hYULmnVRyWJW4MPyw4e/0zr/VqPP30xcQeW9JIKcA6Nw/Xy+lfAl55PK61olleTT5wbRYnhoujBx0ZyA4Pgian8j+oIRXdT7UvCKw7vSUhMTtG+x8A5yd+8I/Pe2lBm+YeS8jiaAlYwt2T4J0PwQ3xqD+6C4Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXZ6cURQNU9OWFVNbUpUMEtPeVBHZWJZd2UrdXZxNjVhYUg2eW0xbmRTWDgx?=
 =?utf-8?B?SEtHb0t2b1BEQ3A0d3ZpVVhoNVBOU01uVGVqVWRBblphaXFkam9xK3N0WU1j?=
 =?utf-8?B?UDJQajhtT0VaQ2hVUmxxVHBnVmNZZThYUWJtUzZqSlo3bndDU3FrMlA5c3Jo?=
 =?utf-8?B?cHMyV2U3aHpmWHlHT1Q1ci9JN0Vad1V5YlBiNWdDUDFYQlRxUDAzUDZoRmFX?=
 =?utf-8?B?Z0Q1N1NSZ1VuSEZmbVRBaklxVXd1dXV3TDUzYXNreVZmQUZucnd5eC9jSXZP?=
 =?utf-8?B?d0xSN2h1Vk5aa0hqQ01obnZvbXRWeFVuaWtFT3dSeEMySTQyN2lvZUcvRCtT?=
 =?utf-8?B?S1hUTWFobFZjS2I3dTIrUHlRR2UzSnV1R0cwaHdsU3REQVJjL3RvTjYzcTE0?=
 =?utf-8?B?aDFNb2hIV2crTjZDY09RZURYRzVlcUdmZCtNY3VZNVNEN0VQdFdVWDJjQTZ4?=
 =?utf-8?B?N091Qm5qbjIzVGUyK21GRjI4b2o0d3RmbGxMWU9lYll5eUFFcklQd0hnVVRW?=
 =?utf-8?B?WTFTZ244dGovak02SS9YcEpFN2d3cVZNUzZXZXczbzc4MUpSRU84RzB1Rmty?=
 =?utf-8?B?SS9pMWhMRm0vMWc1T25FbzVWa3RjTHBXaFo3WU95elJCRnhKUEVKZ0czb21O?=
 =?utf-8?B?RTR1U0tab3pwWGc1MUg4eFFrdmJkYUNLR2JEam1JM1VmeXRmN0FqWmZIYzZO?=
 =?utf-8?B?MEpUYUxUMGplWEN1WXh2U0NGUkxvM0xPdkN0K0FnYTU2WnM5Vno1UFd2ZmJp?=
 =?utf-8?B?YnVJQlRVZ1pUZFNpUEJtekRCNUhRSnBwMU1WWXpaeTUvSFZCUnJBVjV0aVQz?=
 =?utf-8?B?bTJqOU43c0JLQmU2OVRCSTNNL0l6SXBHSVdYSElXL084WDJtemlyL1hCVTJC?=
 =?utf-8?B?MmtNdUtqZnFDRWMxZUsxWWZEOWE0ci9CNzVQU0hETk9Xd2xGdDU3aE5IeEZB?=
 =?utf-8?B?K2lZNlRaR2lNV2VkaHV2S3pnNFFvdTBIUFdQWm5RY2RIQzNKYlVMV09CMi9u?=
 =?utf-8?B?ejNva2dGZm8rY0JXcGoxVGpMd0VKOGpoZTZ2ZDlvR05tanhvZmIwcjVGZ2JX?=
 =?utf-8?B?T0VzTnUrVEFNUVdyb3QxMm1iK0xSZ0J6Mmtwdm9ZbDBPYUtDWENxdVkxZTgz?=
 =?utf-8?B?Mi9rdi81MEV1QnhOTXFSdXFSenlITXQyRkJFUkNEc1hQeGFjTEVXWUNJaWpp?=
 =?utf-8?B?bURWL1NJbUdzUklKN1E4Wm1QcExidnZUN2kzVVFqbWJTek9jcWlscmlvN1lN?=
 =?utf-8?B?MytaMFRpRnJLSUF5UGowRXNLaVpYYm1DUGNHQnVDNEsxTkg5WUo3eUF5a0VZ?=
 =?utf-8?B?d3Z6ZTVQTXdxWDUxUW5RSHJuTTQzV2RTanpTeCsyZFJueU1kNjd6UGk2VExK?=
 =?utf-8?B?Lzd0dGpEN2JPbkFwL0ZDNVdaY2tONmlWMU5kYmx6dnI1Nm5NZVlkSzZGSHZK?=
 =?utf-8?B?QktveU14RW54OTh0SmVUMjFoTWN3SXVFNXBWN2NNdmdaKy93UE9kcThjK2o4?=
 =?utf-8?B?dXVBUHVXL3JOWjFqUm52WVl2SHA5OGEwaEQxeFhrcmNldEQrajUyTm0zVVlU?=
 =?utf-8?B?VFUvd2pTUFVvRkswdmNjNUZkd3dxN2xRaTZxNGcrSlphZldxcXRmR3dzSVVl?=
 =?utf-8?B?UUs0Zkp3SVMrNXEyUTF5QStaMlVTaDJ2dGJObTdrem9zekhOaCtyNDV3dHJs?=
 =?utf-8?B?TG10YlZ6OVBWbm01UHdEcm1qZ3IxVlRIanJqQTdjRUNHcy9XNWlMYWVCUVk5?=
 =?utf-8?B?RTlpTHl5RnUxVXNhQUF0VUdkaVZVTjRJMVNWWFovVzREeHpMUlplSkY3UEN3?=
 =?utf-8?B?Rm9EZlZ5Qk82VzVtclh2V1g5SjlOR2ZpbXp2NUtza2plY3YrR1Jqa2htU2Fr?=
 =?utf-8?B?c3hiTGlDSWlBN29ZNXhFWEEyNDNLbktEenkrOWRYMUJrdW1BVnQrVEprU1ZN?=
 =?utf-8?B?Q1I4WFFISnROeHUvQ2JvcFlqTE1ldC9OVDBXVkcwY1ZZaTVtVGJWRjJtc2pQ?=
 =?utf-8?B?bzJHbTI1M2h2Y0c5dEs2ek1nOE5QZ2NvQ0xmbXZ4N082WGNIbXNBenhlZ1hG?=
 =?utf-8?B?SHBDbW4vVHN1bGNuOW9ybGQraks2eENNeHF0bXB3Y044SW4xRmlnblFBTzd4?=
 =?utf-8?B?Tm5rZDRSenRzWUE3aHJNU0RzeExUeTJwTS8rRmwrRVZHajJ6RXRIdzAyMHRZ?=
 =?utf-8?B?S3hVSDZiTkREN1NvZ2xSVGNVUGRveXQ1NWl1RUpEaVpPb3BEQ0xPSjZwRWVq?=
 =?utf-8?B?Zkl5b2NnZldRT2U2V29hVlFYNWVHR050cktTQXhLUXJ6S0ZiQ2Q0MVVJSnc3?=
 =?utf-8?B?WUhvM3RBT2hjRWlrLytwNFM4QTZ6T1NFQlV4TDRndWgwYTNZY2Z1M0hWb0Fk?=
 =?utf-8?Q?qV7nXKrJhFR2zpLTSV8Ga34LUZ9txaQWMC2w0ve0wzspZ?=
X-MS-Exchange-AntiSpam-MessageData-1: lB6QmZlOSxpKag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477a7aef-f8df-41b2-62c7-08de9f6d7ec4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:16.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA0MAwdKhH8uYrIIyB/KbHOaQCL7hrr76GYaB7oKWQyluFV97TBNCLR8ogxbJ6Rw+tSTHYK7K81MU+v8MzY8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Currently the GSP is left running and the WPR2 memory region untouched
when the driver is unbound. This is obviously not ideal for at least two
reasons:

- Probing requires setting up the WPR2 region, which cannot be done if
  there is already one in place. Hence the current requirement to reset
  the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
  the driver can be probed again after removal.
- The running GSP may still attempt to access shared memory regions
  which the kernel might recycle.

On top of that, there is a nasty bug in the Blackwell VBIOS that
sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
on the PCI reset to unload/reload Nova is really not practical here.

This series does the necessary to leave the GPU in a clean state after
unbind, for all currently supported GPUs. Blackwell support is trivial
and will be added alongside the Blackwell series [1] if this can be
merged first.

The first patch adds a `warn_on_err` utility macro to the kernel crate
as it is useful to warn on failures in the driver unbind path, but I can
remove it if it is not deemed useful.

This series applies cleanly on `master` as of today.

[1] https://lore.kernel.org/all/20260411024953.473149-1-jhubbard@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
- Tidy up the imports of commands from the `fw` module in the `gsp` module.
- Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com

---
Alexandre Courbot (5):
      rust: add warn_on_err macro
      gpu: nova-core: use warn_on_err macro
      gpu: nova-core: do not import firmware commands into GSP command module
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding

 drivers/gpu/nova-core/firmware/booter.rs          |  1 -
 drivers/gpu/nova-core/firmware/fwsec.rs           |  1 -
 drivers/gpu/nova-core/gpu.rs                      | 21 ++++--
 drivers/gpu/nova-core/gsp/boot.rs                 | 83 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 60 ++++++++++++----
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 ++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 23 +++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  8 +++
 drivers/gpu/nova-core/regs.rs                     |  5 ++
 rust/kernel/bug.rs                                | 10 +++
 10 files changed, 197 insertions(+), 19 deletions(-)
---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

