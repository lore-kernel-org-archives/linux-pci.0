Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2D5288C30;
	Fri,  6 Feb 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357640; cv=fail; b=sBkUT9r+QHcgHe7giwaoYybHS3eTBKb1vJkyZEzVwDbrGHypoXcyLs/4HWzsO6jhG4cblv+SSn5Rzt0aBlXYEOxEaFdRUuF3tNvA/5bKjaAmpyrT6bSHoCc1PIuZhIKZrLb5SalQ3P5gi2A+GRbR2YIfynGYKICnv70akLMbNUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357640; c=relaxed/simple;
	bh=NxF5fmoX56Z67LYwglIyxnkZB86BFFq0io2ePa/7MPQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dbMKa9WMS4Y0buNZ7/n9OAm+8E0/Jv6oLkJxSPxPwUkusSbnbXPIHcIGN66euxMs2v7bAvLzWxYl4NCm3PBKqlVY3YBxySd1o3AuJi/LCO6uhFqmEQVGWklUJDF90i5sZXJMnU6myTV88ok6MAvUGJ6b1vleIyIpnn8YIFiv/aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ALwIBV+H; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ALwIBV+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB9vSX7Fdduaxxbn9bg9pIVkUSTQ20htzE623lfEK86bYAzJmsaWY8wSRJ+c0BoMRC0HeaOvAqv1FE6MtzJTq40xrAhHtzSl/CwKL4VX/U7/yhi1HKRJLBD98gAaqZ5/WG9x+XepsFzosoFWDuvNeu85y9fBgejcRVTo10QATr0a6wAin0CklBA+rgoEWWm6NhZ0A4Hcjm8yF5zfQBwOB2r1hdZjOO6hH4giW3B5mDCHZambKF7r0sPmjZNDkcZ8+FR2ad/MSPwwjo7sjBI73IZD1YI2R6GrBdNQ+qiCZQb1VFhzQxZwRBsyVqXTcga8hIzyrHRtHJlW8FshiEN9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZqmM99A726J99tNSHWsXBrA/p1RX/GQ4re6N/RaykM=;
 b=Yc+7lyDJPL7CJ3xU6N8+u2DV3sWtjJrpR7dx1wPvp28v+E4pERdEws7Y0YyX33kr/xgp4FIXg/Z6xAy/kuomTzrCK3gi8vtljIFKGDEOgtq/0hMoSlQrUl/6ChaBe1SilRVhrcF58wo4NqHzY0s1KAH8cMJ8KgcyTHebmHh/ILPimm++nI1GMhCjTStXto11golTswNCaxdiDTClAoydBFR3A4LKivEqNaVaJvSULq1TtB+FxK48uhRQtUz8Lh8ykiAItVQiw5C+YwwRDJ/d2eOukF6zi9CTsOuCe2n6yDtyjT+k5e3IFCGH+tfSbLik7S57Da0VWbJEn5HOwL4h9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZqmM99A726J99tNSHWsXBrA/p1RX/GQ4re6N/RaykM=;
 b=ALwIBV+Hedm0vvn549CIC4HtZDoOt8gkd4mDCqGkZ1gk5mRmdPPcyr7FGilTM6JJE3ewSXDt7STSyJzWP5IYEe4AekKjNQ6FJQ/F0Y4ZZ2Brj+30PJ4xZHGbY2/sqAM3HRmqbWO2v9YUkxyIXMKwX3Xr2AgarQUTum/5G8CYfMC1oHa2ohe2NjjJKBEUkTVNhriVuL1D3988bqQpso5hlwtj4EaQwcXhekBVpEIgtWsrWs90HpDbbub05byXTPIClm5yPDTVqdmHhVZd6HCLNhnmvo+2Us+PwHjYPwIW6dVJa+co141NfiGVhuH1dPzNDEnjpQoPv0vpgC32nVFlnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:00:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 06:00:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
Date: Fri, 06 Feb 2026 15:00:14 +0900
Message-Id: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMwQ7CIBBEf6XZsxjYplA99T9MD6Usdg+CAUM0D
 f8u9uZlkjeZeTtkSkwZrt0OiQpnjqEBnjpYtyXcSbBrDChRyxaCoxiVd70evRn0AG34TOT5fUh
 uc+ON8yumz+Es6tf+3YsSUlysRWWMw97SFAo7Xs5rfMBca/0Clr8YrJUAAAA=
X-Change-ID: 20260202-io-81fd368f7565
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
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: bff2806a-75e1-4aad-397e-08de6545074e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHZJRVNZZXcyU0w2SGRTL2VsUUk0a0VYRzlyelZvMHd2U3B1WFFmSEVINlp5?=
 =?utf-8?B?K3I5cVdJOWtTQzRZZFpoVlVaSDlITjc2NGg1ZjRtSHc2REpCVTFuc3NLcGJL?=
 =?utf-8?B?SDRJeHhCN04zc3JGNG9zd1VmYmRjRFlQYU1CTko0MVFCTmdHV2V1alRTNzRv?=
 =?utf-8?B?ZUp2UWJUcXJ3NmtteXZBRGZIbkZwSVNEZFlYcitSb3JYUGExanZ6c2tuZ3lB?=
 =?utf-8?B?SDk2U3RwbnhNUTdPK05LcVZ5NjFrSVhOL2ZSQXhZY2l5Wkd5eGd5RGxsWm8r?=
 =?utf-8?B?Q0w3TndwT1cyajM3NGJkcEZKMjNiU2lUT09XeW8rcGxJMWJuMjVGNjg5ZXRT?=
 =?utf-8?B?Tko0ZjlRMDBnYUJrTHhyRGZneEhkcjZMUXI0UkpndnJHT0ZLRHdzaUtVUElv?=
 =?utf-8?B?akJJblVNUHZVUFFwdEovWWpuVitETUU2cWVsbHJZYkVJZEVzZXpydGZ6c21r?=
 =?utf-8?B?Y0lqQjlacnB3L3A3M01pKzB3VkxnYXpuQUVJQ0pyWWE3UnllVWYvLzZib0tV?=
 =?utf-8?B?b1g2eDBiL3doRWt6c1B6bmM0OTk0NW5zVkM2K3VVZXFkZU9XZ01ibkZLQlVE?=
 =?utf-8?B?TWlUNU1icThMSHJySkkwQ0FpU0VmUFU5dVFhUU1BQm9tYStwSGtCTzgwc3R6?=
 =?utf-8?B?K3R4SzFuT3RmeSsxRTExbjRjQXl5bndiWUVNZlZhUG1Md2J6cWlhTEdodjlv?=
 =?utf-8?B?TE9Xa2V3a1JQM0NGdVY5RmRiR0RkUGljeTNzdDJPQ0VKWjFHMU1UY1VZNGpj?=
 =?utf-8?B?OGU1eThzdWtlRVd6K1Radk9iN0t4eXFSdHZqY0hFWWNSelRzaUMvRVBPbGtY?=
 =?utf-8?B?TXJhTzUwVGpvNFpUUjdvMFBrVnorN1NvaEErK01yb2xVc3l0bG5iZytYUHFl?=
 =?utf-8?B?K0ptWlV3T3Y0Vkh0K2N5M0xXa3pTT3lUMk9OQWY0YWNtN0xscHgwNldVMlhG?=
 =?utf-8?B?bTJLaUNSdzZjaFBaeWNQU2hiS2Z3RVJ1ZmtsQk9rczlrRFRKOTlmMTNCNVcy?=
 =?utf-8?B?VlZMTU1nbGczck54SHM3MUtLOWlVMjV0NUNFelp6MzFkdmFFN1BYY29jUmVU?=
 =?utf-8?B?K09LVFdpLzQxb21VL2lIL1RGYWxQZmFvelRhTk1mZEZTQ1dJU09UWStzLyt5?=
 =?utf-8?B?YXN4THN3ZDdBNWhrUTJZejE4anhRKzhVTStFWkNTTFErZlVoYWM1VUQvaldH?=
 =?utf-8?B?UXRPb3pyYnd2NXkwbXhvczJPQzhCcWRDamFVRUNlMXZVS2g4b0Qyd2NHeWRz?=
 =?utf-8?B?TDUrYkxLci9YUXFEcmhiYzZKdktkOG1IY2lRYmROeW5ldG8wOHJEQUVNUm1l?=
 =?utf-8?B?SkYya1NmL2JnV0tsRytFeURadWljSGNyaGlzZTl0MmU4ZFRaRFRhTXMzNU1t?=
 =?utf-8?B?TUEwVzl4WTdpVkFGeEZSS3J3Ukp3aVNxTTFielhnZkcrSVJaaFRWVTJGaFJD?=
 =?utf-8?B?S0NDUHcvVmNkSzdJaXpyK09mNXd0QTRiYXNDaXFHeW1TRFplaG1PV3FZSW12?=
 =?utf-8?B?ZTB0aGtueTZUUzF4MXlMNWloSEw0Uy9Yam5rSWlWcnNGSE1GQ3dNUXNHaHQr?=
 =?utf-8?B?V1JFckI4Wm83VnpyakRrQzZRdFdwZE8yenFUQ1U3bHEzQ0FhdmdvZE1ReWgz?=
 =?utf-8?B?RlR2UFhHTFA0MEpjVGhsTENDYTRrNk1kK0Q1cG5Ha2dsRVd1dDF6WDFvdmVY?=
 =?utf-8?B?dGdKK0ozcGtTR0hxU1hWMnQzV1FYcXFKLzVrekVHYkdyQldyMWlhRnRLdzlu?=
 =?utf-8?B?SWxCbFhFNmdkWm82WW5zU0xGM1U1SU1CQjA4RmQvUWxFZ0paUUV4TzdrSUJl?=
 =?utf-8?B?bjdVUUd2V284V0FlMkkvZDd0SWVmZkpzQXRvdFZsczBmVTd2Si9NYXNaVlVT?=
 =?utf-8?B?WG5OVDVpYlpUR0FNejQrbzN5b2VuQVdNbUtrQXhNTk8vUzAxWVZCc3diSHJK?=
 =?utf-8?B?MDBGR1I0dWc0NTBkYitIM1gwTXpxNFN6RmxtVHAyQ0ZCYjZhbDZ3TzJOUGhN?=
 =?utf-8?B?dXlZZWNnUWZWMmVlTWpIeDk5NnZ2VGFVV0VKV2VZMnlDdUtPWWNtMFdUZkFj?=
 =?utf-8?B?bzVacnBRdHJtaGZOUFh5RTg2cFpaRlluLytZZXRVbmFPRkJ3aWtOcVhrYXUx?=
 =?utf-8?B?bzBsNk92YzFJUEx0MHM2cFc4U0JBa1loc00wNVNaZnhCQVBlbnRaYk81Q0Qw?=
 =?utf-8?Q?MKejkwITmFIDGuMP75WFIuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXNDdGpCVzNaMDkzbEszL01qeWxDdDlnSXY3bG1aWmREaTlLcC80N2tKSjBl?=
 =?utf-8?B?OTY1ZUEvYnRVTHZaOHlVM2JhK0xlSlFOQ3hIVXpYUG1PbldsamYyWTBSTFIv?=
 =?utf-8?B?TkhzY2I1MlJnNitEWkJwVjdFS0hJamVkcE9qem9udWlIOTI1dzRjelhDdyty?=
 =?utf-8?B?UTdNOEEyeXVMUWhFYys1MS9GNDQxZUEwbW1oRHdGOEk5MnQ1UCtGYWtZMVR3?=
 =?utf-8?B?cDZXUUN1REs5UkJEMDVIWmdOZkhSQ1diZEp5VEpraE53MTRFRTVTNWVhazVX?=
 =?utf-8?B?aHB4Ty9jdWJGVzVNdHY0YXZyZnFkQTl6VGk3Z3pCNzlqb01MRDNvejBINXZl?=
 =?utf-8?B?T2dYME5zdkJwcno5L3BqbjZ2NHQxUWpmMGw5Z1Y0UEVaVGZxMUV5YXJqMU5x?=
 =?utf-8?B?c2ppblE2NFFpWWlrRXU2REh2bFc0RDVGNTVOQUh5amxpanJQek93eHBWRHhj?=
 =?utf-8?B?VDAvMkZpaXh1SG0vWG1VTzZlMGxDZk5PYXY4YTE2d2tVejR2d1hpMEFjOTR6?=
 =?utf-8?B?cUtMTW1hYWJMTDBsY3hMa0ZCTHlLQ2VzcHl5cEtERmNUYnoycDF1alJTK2Ev?=
 =?utf-8?B?eE8yNlozbWhENlBEa3o5OU5MTVdLbHpEOGVlMnkvbzF4ZGFJYVM5elFpcVF6?=
 =?utf-8?B?SklwRWxnaThZL2ZkdDFaYWo4WEdCVW5ZcmUxZXpDSUM5VDcwcDQzNnBuWFBP?=
 =?utf-8?B?UjBWRlNna3I4dHN4ZXJlckhDNElWNHRKYWZKVmMyUDdNMGRlU3lKM1RBbnpk?=
 =?utf-8?B?TzUxd0Zsa2xweSs4VTNVRHdrcGxEV3BsNk00cEYvU0N6OUQzbldjd2hxOUVQ?=
 =?utf-8?B?Y0pralhobVhVUWk4dndnczI2eHg4UlBnU1lzZi9ZSmtLY2lmVjFkVExPZWZW?=
 =?utf-8?B?RXIxLzZmanMxY0lEbU41MStwandzMzBpTVZrbmhZQkx3M1o0MkludXpZaHBr?=
 =?utf-8?B?a0k4R0hYY3RkY21EenEveno3MVNQUklRSVkzOTk3SUFVV0I0ZVVHUDFrd1dK?=
 =?utf-8?B?ZEJNYW81WGs3YkJ4NURkVHJtWlpvSVhteUk4WmpoTmozVUlqRXlZcmM4NWNv?=
 =?utf-8?B?ZWFKMVJBNU1kaGd5Ylp1WDYvMDNvc0NmazFSMnhwS1h2VjNsUWlmTGtwZ25I?=
 =?utf-8?B?Z0d2NlpRUmU2eXlLVkErZy9ONm9uRXY5TFFIQ1lEY3IwQVJNRXhlejU2eHdy?=
 =?utf-8?B?bEgrRXhRVmduL3hFQ28rZ3lSeHVjbngxUU9HSWVudmFlMDRIbk1hUkVTeU56?=
 =?utf-8?B?WG9TeVR4YXd0YW5nVnFFcFlwb3JrSFg0V1pET1VpNTZVKzFJaXpzRzd1M29o?=
 =?utf-8?B?YTBUTUJxZ3g0cTZnckxwdEVuMzVNTDZIMGFNSHkwdHZ3cThiVDlxRU94MGN0?=
 =?utf-8?B?bnQ5Vm9HQ2NVa05SeUhjeXFqcUorT1dNZVRyV2lKSDREbW11ODFOUGVYVkJ5?=
 =?utf-8?B?YXpmM1djSmdBUVFuM2U1SHlSMFBCaEs3MjcvcitTNWYrRTd1SnNXM3d6UlNX?=
 =?utf-8?B?UDB3S3lnN0xIU29Ua0lUTFRPTlY4LzgwWnBVRjVNaXNCQXZGMHJITnNkZmNz?=
 =?utf-8?B?RlVadk9wODdsWUlEbTUvWkd1MUtXKzJpUGcvM3VKeE1hUjZONUZkZVEvV3J0?=
 =?utf-8?B?cnRGMkg2K3V6c1R0bmF3ZWJGTzhKKzJwQmRXaGdIaHg5NjVoUzJxK3hYY3BX?=
 =?utf-8?B?WW9VZm82aEVLeFM0a3R0dXcrSW9sQzMrRHU2RVA4QUcxNmE0M3EyNC9DaS94?=
 =?utf-8?B?TCtCeHFPVDYySmNXQm5TMHo1ZE4zRGF2azNUam8zWjFYVlNjUHBwdElvOWNk?=
 =?utf-8?B?NHdEaklhZDVZZWtJTUVmK3hIYTJoaXpLbHFqTVJBTjU1SnZHb2FJdy9KKzND?=
 =?utf-8?B?WFhKdFNRdDZiSE9wcjRhOFBHSFJLVkJ3eU1lZmFIYkpLOE9DdUtGOFJrdE9K?=
 =?utf-8?B?THFOVXkxSzBQaS9wYWJzeHk5Y2t1VEV4WGUyeGRMRHFlR0NLMzQ1eHdRNWND?=
 =?utf-8?B?K2NrZStycGdYUFNYSzVYelFDVGQ3MWJMdzJ2WisvZ2t2T1B6WGNqa2NMMjdq?=
 =?utf-8?B?QlAxR2hOUlkxTmtpby9OQitCaTZPaHVGV0pMVXJKOVpDM0FvRS9BRHpXOTNC?=
 =?utf-8?B?emNjZTlSOFh0d2hDNFBQS095UGRtOEVRYVFyUHFhTm5IMEVIdTMzb09rSjl4?=
 =?utf-8?B?VzNtT2ViRTNJSWs5Vm1FK0JIV29HVjB3em9hNzEyTytGc1hkRzQyS3NRQ0pC?=
 =?utf-8?B?a2FjZ1N5R3pyM1VNeElScE5DZ0hTSnhxSTVWanRCRVJHMzlQRWhJVTVkRkVx?=
 =?utf-8?B?bGhwMlRDR3NVV1BxRER2aHFoclhQaDNNQmhENnN2aUVtL0hpcVBmcEtaSjhX?=
 =?utf-8?Q?6EFbdXRuYqk5IoW8DftfbjNu3lzUIvRQk6rHivFraDFiR?=
X-MS-Exchange-AntiSpam-MessageData-1: 63uqwCPuvDSbXw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff2806a-75e1-4aad-397e-08de6545074e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:00:28.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fycqgefhXjHi5KG3FFutoDl453l/ZAeX3YSgvfQ7T0XkirHBCcOJ2yIF0wprfyYueAaKhYQFekSnsWAzDxi9Ew==
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

This patchset fixes these issues by turning `IoCapable` into a
functional trait including the raw implementation of the I/O
accessors for `T` using unsafe methods that work with an arbitrary
address, and making the default methods of `Io` call into these
implementations after checking the bounds.

This makes overriding these accessors on all I/O backends unneeded,
resulting in a net -90 LoCs while avoiding a violation of the DRY
principle and reducing (and simplifying) the use of macros generating
unsafe code.

Patch 1 adds the `io_read` and `io_write` unsafe methods to `IoCapable`,
provides the required implementations for `Mmio` and `pci::ConfigSpace`,
and make the default I/O accessors of `Io` call into them instead of
failing.

Patches 2 to 4 get rid of the `_relaxed` variants we had in `Mmio`,
since these are not usable in code generic against `Io` and makes use of
the macros we want to remove. They are replaced by a `RelaxedMmio`
wrapper type that implements the required `IoCapable`s and is thus
usable in generic code.

Patches 5 and 6 remove the overloaded implementations of the `Io`
methods for `pci::ConfigSpace` and `Mmio`, respectively, while also
deleting the macros that have become unused.

There is more work coming on top of this patchset (notably the
`register!` macro with proper I/O), but I wanted to send this work first
as it stands on its own IMHO and is more digestible from a review
perspective.

The base for this patchset is `driver-core-testing`.

Cc: Zhi Wang <zhiw@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Turn `RelaxedMmio` into an actual wrapper type and make it available
  through a `Mmio::relaxed()` method.
- Link to v1: https://patch.msgid.link/20260202-io-v1-0-9bb2177d23be@nvidia.com

---
Alexandre Courbot (6):
      rust: io: turn IoCapable into a functional trait
      rust: io: mem: use non-relaxed I/O ops in examples
      rust: io: provide Mmio relaxed ops through a wrapper type
      rust: io: remove legacy relaxed accessors of Mmio
      rust: pci: io: remove overloaded Io methods of ConfigSpace
      rust: io: remove overloaded Io methods of Mmio

 rust/kernel/io.rs     | 435 ++++++++++++++++++++++----------------------------
 rust/kernel/io/mem.rs |  10 +-
 rust/kernel/pci/io.rs |  99 ++++--------
 3 files changed, 227 insertions(+), 317 deletions(-)
---
base-commit: f55ae0bfa00e446ea751d09f468daeafc303e03f
change-id: 20260202-io-81fd368f7565

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

