Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED56C2FF;
	Tue, 17 Feb 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771292225; cv=fail; b=SQ8FtMeiTdXOVuVsgkQzvbe/Ik7VYrvLuhEi2FTg7wgGr+K0tPH/PbFyBlHRL5AgFpPKI+RsLqUpJZeObdXVOg+aCpf4+75DkjQ0BGBKBlIhoPrIY+F6I//3hHekZ03PKc9Bn92tPiMWs2i9rFvVEl0rJuLoL3uyY+UyWxL3VqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771292225; c=relaxed/simple;
	bh=77V0SS2uth2jz4Br2yeIxL32SbA+MAOfUTKMQv9FYsk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=r45oWvxH0r+8HoG+aw4pRBvjtu7u/v+/RHs5Y+4V9tEJQqmpnTy3Rb2dHMMpAubm62Mu/rMDbPfb9VO+Vry6gq5hauUnzsKO25LW/64GmunuqVvwVrbpSbfzwNa1e9btK3LEXqVDfk0vbDVRZHgJux76p4dimOCYWt7l6BP66Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dhfdkqgi; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dhfdkqgi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqOoICX2CPTFnp8sdPzw8PC/hwlRmbu8p8duWmEHoiwufCU3au9DBaCvmr7H8tqMaeBWNlya6NYb8M5yZCGBahIQYC4YnLgd9esscGrGjIKTdsCWtapXmMnKmmXV8tCT+uFhFPHXIOYypbiNT082NNZkZHhehhkc7yFI1BmiR/36/usBeIDU4jwW1omH/51jfF4UwAhKeZxMXfNVkgDpWrj8SwhhdvgG4m7MVT/oNpo7+8ePXLQd86OqNtqKdTeaeyYyZ8iEtSRS+RoQGL9xFzW6ZRuzrk0eucASVbp/bL4+qgZYHg95IwW/BplnELI+IuxPdFFHuHCNe4IUlTTVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV4jqQZEkmNHKUdbeSc1ISwCGMFOuUzDN7Q/UtN5XTM=;
 b=qWfAUrC6ITso611DCi00nkBjCq652DO6UyBqSksiSrZjjPXViUvVgXjw+Nk7oaIgwxZDdOK8cX7srD1ixqb8NrVnkzGa3c1THqws4erb+in7Dr0yVQ/oEKmCqbhtzW+dVCtzKcY4HKAAZpXe9dFY6uvDhXRwY6I9o2P+UaMroy/NlOxnrHkM1Cz0D2PmexA3/AiRvJJM+xGr9bbL0uNpDP5wkLCWQiwTd3SbsaXkoZ6ajeMQb6ujXj0qo1Ico8POhK/B/jI0Y7alwj2QgDy09aTMSiP6YX0pnGSVPO3Vgh0q58FOYWrgSpzlpx/49eCpCZhrT8LNpIvTTqrE7/ECNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV4jqQZEkmNHKUdbeSc1ISwCGMFOuUzDN7Q/UtN5XTM=;
 b=dhfdkqgiTFxBupKeWytZwejqYQKjCprQwbGjWx12DqvOs40sAdSFyE0Z+akLl2sW7Y1Pliq6bEoXtgIwIXy33BFdaMhBxPT0VfpVGcE/KUG0VlK1Lp1Z84TxzXwYqBFR4qCosgwcMTBNaUuEtfiswiyoqTBg0dTbU8KW9K7Vy6weH9QJWYx2hGx4DDyn6F87cQOOdM6AFRmrQtuoPg8JNSqku3aIee9jly4IhR5WUFgwIDlychOws6TODhjsGn4oqk4RiWy19J7rq7wj+uWOF+C5St+P/lyuWw3Z3RZR2E6MgC7JCSqTF3JzYA4YsnFED6eHzD1DEZ8V9HqUP5zn3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Tue, 17 Feb
 2026 01:37:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 01:37:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 10:36:56 +0900
Message-Id: <DGGUOQT5BJW2.14AK9GFZKC854@nvidia.com>
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
 <DGGF65JPF8S6.268LR7YDPTWMQ@nvidia.com>
 <DGGJSHVZB6U5.2V8OMF5N3KZNZ@kernel.org>
In-Reply-To: <DGGJSHVZB6U5.2V8OMF5N3KZNZ@kernel.org>
X-ClientProxiedBy: TYCP286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a51f508-78cb-41cc-586f-08de6dc50b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJzejFhYkRBUVl3bVd0VUU2cUh0Yy9YQXhuYWxlYVAwS3V6MmNTempFSS9w?=
 =?utf-8?B?SUVIS1pQN1NBSktlTzNacUVobW1KZEthazBHZzFNQ3RSUzRmd0t0bjlRUUFP?=
 =?utf-8?B?VGU2N21yU0paV3RVb3ZRQW41Y0UwWGh4ZmxVZWR0U1k3aHphWUhLUEtpdm52?=
 =?utf-8?B?eS9BWFpzVENQMU5oY1dPRGVkNGJZci9oU3ZNbFBWUE5aZWVUQXRyQ1VrRGU3?=
 =?utf-8?B?QXpmUlVYTEUzcEhVUDY0UG52OVM1eTJQOVR1Mmhia1RrR1psaU9uYW9xVmtZ?=
 =?utf-8?B?Q05Ka1MyMWFOOHBHajhDUzJ5TXl4cXlIZ0twZExwRlhQMHVYdWtTdndoN013?=
 =?utf-8?B?NmdwQzQ4N1ZCSVNRWUk5ZnFXY09vODFGWEFRY3lkZVp2bE5CVkdPbFJiSEJh?=
 =?utf-8?B?cTF4eTc3eWN2SjRIbnk3N2xQQS9MeTVVT2JiT0tQcXNpREYyWlNmdUhvb0lt?=
 =?utf-8?B?WFJLeDh0MWpPVUpyejFOdVJPVjNvWk5xcjA5b0h4QzJHNzkvQjRSTVVWSEsy?=
 =?utf-8?B?UElISmUzakpWYTlnMXFaZVg4Z1ZQUnA4eWEwOU04MWd1a25iVDltNzJXSjZK?=
 =?utf-8?B?cnJCN2VIUFRMY0J1ekxZNTFoTDRHODNqSHhEU0RuWDZMVW5Ga0dFQWQ2YVND?=
 =?utf-8?B?M1JQTis4eXk0QUh3T2JRaFFyS2NyVmtCOURTZ0JtOWt5RW5sZjB1WFdOMGE3?=
 =?utf-8?B?QWxhb0pZUXRmblJnSTk2eGtkZTQzTXgwTldsZ0FWY2swcTlORjZxaTBLczA3?=
 =?utf-8?B?QmI4NWN5VnZiS0dacXVkLzMrd3JiczZpbldDMmRKMW42dS93aTlobUg4NUs2?=
 =?utf-8?B?Wlk5S1liaXp3dTFKc2wwcDVlbUFyUU1ldXFWU2FQVFpxM2kyZFdTQ2pzb0dl?=
 =?utf-8?B?SXFDTFd3M2laZ1J2Qm9lbVhDRUtYblpwUzJrMlZUV043ZEhUaGFXUkF0dzVQ?=
 =?utf-8?B?clJXOVE0cnpSakZCRkZ5TVNWVTA1ZGNBeVV3TFJQNHAxZ0RGL2tJb28wTE1B?=
 =?utf-8?B?NC9hQ1NVSitCYmlJMlREMFgwQlFBR1lHd2xUdVdYaWlNVU5UblZXcFRyTDdv?=
 =?utf-8?B?dEx1OVUxTjJ6U2xYOHlIejFmRkNweURoaUZOZnF4QUdodDl6bDRuMEQ5QWxt?=
 =?utf-8?B?SXhPMytjOGlyOFN4RTZ4STM5TFJXMEduZzhHWllYT0dYSEp3NHcwK2ROclpU?=
 =?utf-8?B?blJmT0MvTUltQ1NCSmtNVytQZ2J0TkRyVHJycU9WWDNXandmZnMvT1VtNEpy?=
 =?utf-8?B?TUtHbHhOdE5QZUxiWWZMN3M1TUJCV0JBMmhVVS81R0hKL0lzbnN1TEtoQTly?=
 =?utf-8?B?ZHVsM3lyZjVkT0lmaW4vdVFhTkJzUVp6QXVyWTNxb2lmNUlxZFd5NllReVFC?=
 =?utf-8?B?OHZ6QjZHdTZwak45a2FDRitFa0ZrU3hBenNYZ2NRamVYRkxJamhER2xGQ0Rz?=
 =?utf-8?B?eTRuN2ZDVUF2VEk4YXVUemtERjBYR3VyelMvUG1SSCtXZy9LOVc1Vi9yczlV?=
 =?utf-8?B?em9xN0N0TWpEUTA0SDk5R1JOZkF0TE00c3pEZXdTMmpxUnN1Ri92R0xWNXVP?=
 =?utf-8?B?RXpWam1tL1FSQXBNNWtraXZiR213NGVvUkFKS3A5TThTcGluQVRpSjcxRkdi?=
 =?utf-8?B?TE9BbURhUTdwSHdPUU9HclJtOS9oOHlvWGNMTk9HZTFWcnl1TGQxNHcyWkdB?=
 =?utf-8?B?RVFpVWQvaElrT1VMN2g3WnhyVjQvSFN1UWdrUkp0eXY1R29QWjdFRm84dE9q?=
 =?utf-8?B?MVQrejZieHI0dWdQN0ZIb2ora21zNUt0cXJOSk53VU04b2FlMTgwYXZneEZC?=
 =?utf-8?B?K3FWQzkrK2E1V1NPNFJ4MmxJSjNJZEQyc2lLVTRCOUF6MFhWR2dXZUcrLzRz?=
 =?utf-8?B?NE03clJrc0xIMzFXc1JGajNqcSt3TlVLRldTeEV0VUJISC9qTFFIbytJekpU?=
 =?utf-8?B?c05IaU5SVDVkcVFuOGJ6ZWRSVFZOUmZBZzgxYVFzU3lBUGRkNVpHMElFVFlG?=
 =?utf-8?B?c1crdEtuY3Bvc1lRYkdLZlV4a1dCY2JBazFyWDJpbWVkWUh3dmRvQnFIS0t5?=
 =?utf-8?B?cmdmMDA5RmE4Q21ESTRYajJkTFhIR1NOUGQ0S2Vra2Rwd0p5YzF0d25aQ0Ra?=
 =?utf-8?Q?Bjw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXJYVlZFZnVkbTFyb29abmhFVFBHMTBOR0lXa2dJb21KbGVrYTEvZE52azJF?=
 =?utf-8?B?dTdlSXV6QmFKK0grRk4vSHAyUnVkMDZDUlNqaGlwT0wrYTZqb0NTM0c0ZCts?=
 =?utf-8?B?cHVKT05pSXk0V3VnQ01kcFZjTkJBUWRxZ3JvRTAvdlZ5Rmt3aFFvbDl0WEl1?=
 =?utf-8?B?WE1kTGsyRGVvSW1QVUEvM2h4RUpxR01Zcmc0K0cvZTdYdHAyK2JhblRxUlA1?=
 =?utf-8?B?czlSWmhyRjM3NkIvdTMzQ0lyTm1KdVh2Z0JnTmFpaU1peTUzbjJaZHRjbkov?=
 =?utf-8?B?WnV1aFhvOTV5N1dNMTFyZ2llZkJ4VVdSTVpTZkJEbk5mNGNjdDlYYkNmUm5P?=
 =?utf-8?B?M3AyNkVWVWtONTFFTzkrYkF1dU5Ecnc2aXBtUmpiN2UveHdsU2ZEN3JXdklr?=
 =?utf-8?B?THVuMTMycTVvTVhMQ1lXRmZDU003ZjBTWnQ2ZCs3aU1NMXRlY2I4UjZEUWNV?=
 =?utf-8?B?NXRENSthRXArSDFOL3BEUk94bFVKeWVYNnNabVNIUnE3bXpZT29GajRSc29I?=
 =?utf-8?B?emVEbUxkUW5KTXJJYk43ZWlLeUVMRWFjdzRwMTRrcDVibWdSTjlxZ09vM1J3?=
 =?utf-8?B?Y0dJamRKUEZZV3pGR2M4SURiNldhZkZoMTA1YzVMQzZqdmZnU1haOUpGbmhM?=
 =?utf-8?B?QUtlNzFtRVFmblNRS2RNQmdXZ3VuZW5aU3hraTgwbE41RHVsVVBlQmpHWGtu?=
 =?utf-8?B?YjM2MWRCNWZWL2JjT0JGNUpoRkhYM1ExcGJXbDYvTUIyck96TittNU4zVytq?=
 =?utf-8?B?OGp4Z3F0OFFvUmhlOGdKajd0aW9Jczk2UDdUQ0FXdGRBKzI3Si9Ea2ZKOWQ2?=
 =?utf-8?B?MnRqWGk1a000L2VjWEdYd3RJclR1bDY2eVJteDVtNFI1azU4RTBnVDRXWDlN?=
 =?utf-8?B?dU04VVZHRllOcnhNODJ5RnRJamp1cU5qTFhOL2QwU241WC9aR3VhY0RwWWZu?=
 =?utf-8?B?U1g1RGtJVGxxM3VqUmdZTjJ1aWlLbFhyS28wdDB6TGlLQWZCeTM0MUd2b3l0?=
 =?utf-8?B?KzQrQXZjWVp4aXgzZnBkQTA5ZWUwSWRFenUzc0diSFpQYUZid0tLNERSTWVr?=
 =?utf-8?B?S0VnRFErMFI5bWhUTUtYZ0djTWd0ODdqVDVmK0FOMmRxZ0xBZGVxQnM0Smpv?=
 =?utf-8?B?Q21jcFhyK2FMVDVtcVc1cjUxTWZtaTBuaGNST3l6RFU3S1d3ZWRjWWdxUisx?=
 =?utf-8?B?dFpSalVWR3lrTFo4WFdYWW9pRlNYcThhQVU2L0RMd1RDdlVOa2VYTDlxRGdF?=
 =?utf-8?B?b0VrNDNJT045dXh6MWFrZllOdEJWMk92YjlqK3U5WUZkaGc0Q2NFaUNuRUZt?=
 =?utf-8?B?OEowajg4eFNkVkM1M2J0SWd2ams1TTFGV2syYW8yVUExRnpLNEsvcG14eDcy?=
 =?utf-8?B?aEFMeEVqSHk5UkpiZkticXVWK0hYTWZqN012WGVyVFhBQXNTamllWjZHalVH?=
 =?utf-8?B?QmlnVjBOU09GTFdQd3lRemU5VDZtUzJtSXdOMWxhU05HY2x1TVhyRWs1MXN2?=
 =?utf-8?B?U0Q5b0ZRRWpENVgwb0U4dTI1eGhMZDUyRjN6R2dMeDZ0RUVWNENIb21sTzlz?=
 =?utf-8?B?S2FaTXRnOUd0eEJpNDc2QWMyc0E3SXIxSCtGOWh0WDlreXlLUnVHUkVkVHgx?=
 =?utf-8?B?aXZwODltdVluelgrODI2S3lrUlJkd3BVVjZCWVhNaDVZV09ka3ZUN1BNSlJK?=
 =?utf-8?B?UElleGJvSzF0eFdCZkxsTy9yditqd252cStzc1c4ZkxTZzE3WmZuM2lCR0hT?=
 =?utf-8?B?YVBnUCtjc0dvc25RKzV4UVduQyt0WVliUlVwSDFQNk5DSkVFc3p3QXFYM3NQ?=
 =?utf-8?B?T216VHdMVXhmcTdkWWhDc1h5MC9PUTRSNUZHSXB3ZktBNmtWOG12eXhCbG5F?=
 =?utf-8?B?dWY5czFNeEw3QmFHSzNFaWhHR1A3VWtyUE1WdmY1NGg2ZkxIclJvRzVEVDEw?=
 =?utf-8?B?SVFIdVF2UXRjeVBFU0RXR2RSUWlWdGZTN1pRUUFKU2QyL1lvR0JnR2VJZVFW?=
 =?utf-8?B?OUtmRzJqQ1ZjNzdRVFpmU3NnYzRkMElIMDVZaTBhS2oyS2M4REZaaTl2Q2Fz?=
 =?utf-8?B?Mitka005ZnNKYzdPSmtjaXpSaVpaN1pkalRLZFg4TURadFZyS3ZLbjE0Rmor?=
 =?utf-8?B?UDZkQXJyKzdtQ3lhVzVVeVpBUWVIKytUUVEwc2lGVlhURDZacW4rRzQwQVRv?=
 =?utf-8?B?Sk0rMExGRHhkTDY3VWYxZnA5VTRnZXduSTVXM1RaYnlMVi9kUTRlOTFnV3Zn?=
 =?utf-8?B?ZTlFVEptLzJON1ZMTEp5WmRtUzV5VTNSR0ZnK3JhSFFuckJxT2VJRUxDNXVl?=
 =?utf-8?B?ZE9JS0lVMUdBZjNuM1ArZ085Y1ZuTDVMNUdwdlc1OVFTNHFJa0thQ1JjK1Nj?=
 =?utf-8?Q?3/lE86WonwFeOANUz0YNrH66lHfOYjUdec2VV/wzHR3MC?=
X-MS-Exchange-AntiSpam-MessageData-1: ue9WqSF5wB+91Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a51f508-78cb-41cc-586f-08de6dc50b3f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 01:37:00.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfG/vDpXyMdY2Jb9LrXUj4BBqZ3x02nmVXh18tiOrrwjkikPfl/cVOv42g7Hx7xKCdez3GaYZt3E2BS9lFmBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224

On Tue Feb 17, 2026 at 2:04 AM JST, Danilo Krummrich wrote:
> On Mon Feb 16, 2026 at 2:27 PM CET, Alexandre Courbot wrote:
>> It doesn't - here is the implementation of Io for Mmio:
>>
>>     impl<const SIZE: usize> Io for Mmio<SIZE> {
>>         /// Returns the base address of this mapping.
>>         #[inline]
>>         fn addr(&self) -> usize {
>>             self.0.addr()
>>         }
>>
>>         /// Returns the maximum size of this mapping.
>>         #[inline]
>>         fn maxsize(&self) -> usize {
>>             self.0.maxsize()
>>         }
>>     }
>>
>> Now what prevents me from doing this:
>>
>>     impl<const SIZE: usize> Io for YoloMmio<SIZE> {
>>         fn addr(&self) -> usize {
>>             self.0.addr()
>>         }
>>
>>         fn maxsize(&self) -> usize {
>>             self.0.maxsize() + 0x10000
>>         }
>>     }
>>
>> With that, I have allowed callers to invoke the unsafe methods of
>> `IoCapable` on an extra 0x10000 bytes of I/O I don't own, without any
>> unsafe code.
>
> I don't think you did, as you only present half of your counter example; =
you
> left out the IoCapable part.
>
> I.e. with what you have above cannot uphold the safety justification in t=
he
> corresponding IoCapable implementation:
>
> This is the invariant on struct Mmio:
>
> 	/// # Invariant
> 	///
> 	/// `addr` is the start and `maxsize` the length of valid I/O mapped mem=
ory region of size
> 	/// `maxsize`.
>
> And in impl_mmio_io_capable!() you refer to this invariant:
>
> 	macro_rules! impl_mmio_io_capable {
> 	    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:id=
ent) =3D> {
> 	        $(#[$attr])*
> 	        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
> 	            unsafe fn io_read(&self, address: usize) -> $ty {
> 	                // SAFETY: By the trait invariant `address` is a valid a=
ddress for MMIO operations.
> 	                unsafe { bindings::$read_fn(address as *const c_void) }
> 	            }
> =09
> 	            unsafe fn io_write(&self, value: $ty, address: usize) {
> 	                // SAFETY: By the trait invariant `address` is a valid a=
ddress for MMIO operations.
> 	                unsafe { bindings::$write_fn(value, address as *mut c_vo=
id) }
> 	            }
> 	        }
> 	    };
> 	}
>
> But your YoloMmio implementation doesn't provide this invariant (because =
it
> can't).
>
> So, how do you justify the unsafe call to bindings::$write_fn and
> bindings::$read_fn now that you have to call impl_mmio_io_capable!() for
> YoloMmio?
>
> Again, you can't justify it, which proves that it doesn't matter what Yol=
oMmio
> returns, it matters how you can justify it in io_read() and io_write().

Ah, I think I finally get it now. `Io` and `IoKnownSize` can piggyback
on the `IoCapable` safety requirement, because all the unsafe code
requires an `IoCapable` implementation anyway. I guess that's sound
indeed.

I don't think the same can apply to `io_read` and `io_write` though -
`IoCapable` is public, and so anyone could call them with an arbitrary
argument, e.g.

   let mmio: &Mmio<0x100>;
   ...
   IoCapable::<u8>::io_read(mmio, usize::MAX);

Here we have no way of making the callers enforce the internal safety
requirement of these methods, thus we need to keep them unsafe.
