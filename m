Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021123.outbound.protection.outlook.com [52.101.100.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669832BF51;
	Wed, 21 Jan 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008233; cv=fail; b=TBS2Xwxb8qUCR2LQFC2TEHeLcubciklwkSgZg6uIjYt9+5yeGXgggcV8cyCblfgIZDsnXdWZR3XIkAharU1omrwrTBC8GFxBwUCUoO4OOOBe1nnfVjovxzJbb5sq2AeYvrPFykW9CfNM8K7Q3w2b1hIgRYVTo2mcxhFiAyNErhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008233; c=relaxed/simple;
	bh=W4fMOVIV9ecGNJZQ94KyQXPPNCzCLhVcs83QYiKn2vo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FFfThIXxR8ZMvpfM7VhD8OXv6d65cNRT4wChyqCZ8myKjmYoIbMmZEvgIN16gpazYZ4eEYpe+BkbHhtSQpqgZo73Ec/Z7hmEk4r/u8DH6r/FGE2mEKaeiOv+yVg7Bc7qp/O+bx77h7YTqY7v4tybdl6OYC3RpprpU+d172gkghY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IMYNgVYa; arc=fail smtp.client-ip=52.101.100.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IMYNgVYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igsr7er+VuISjNoASO4auDd3h308b/Wpsks+i4lJ0w0IYfNZCDnG+59Rbi1jHUAHEt0vHODHn99IaBhrHQSUs2PkHhAhdbPm3mXWY+DsCdn/Kbl082NGAWhXjzde89eHgrDU2ZiVPtzwDQlmUw0hM7dDc4f0QhqsaQU9Dd7WgRDsOihYZgvGGYKBsHVADq8wDJ3ywugoPSou51pSM4SSrrWeG1Du4URFUAoev0+k1glCCLgE8JY0QSfceDZ+kMFR/5NS2yj6Wqnc1DxV6xWg1QRWdG7ObL5AK0+DGzG6ZA/17heyfarmnA4/FbLeRMHFw0vgGzPr9Bl+QRiTmFyXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzp7RLpvp4URiDmBX0cWL4PaIsZEo8NUkscsCyRUJLE=;
 b=YoBFoLJzMGrjjvnhQpsSvS6HRPmy8BcjeTy6mTIIJnMhUHTNlJNzVvypiG3jmWa07gYwbtGP9a+Hy0E9IZa7EOvZqcXX3Z4L3aZtH9mW5hk6iXhQCu71xj6v9hxR8i1EmoZs7sXrceUtz5UY0A5PZD8PafsrHUUFsa7QfsjNu1rpawYCm/gPu/osQAj76IYzRQk+0EQX5oCoRs/oQkEfBAVgU3I8RLUs+A4BsDfFU8bo412QCRqL7QQQmT3C6N7mwqUO6WRixhbA2SoEEfs85xD2x/iVUIH5KebM2U3jTbv2MZFFk4um64DyDN4C1/AYs8aCK8IzUHLo2hpU1xQVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzp7RLpvp4URiDmBX0cWL4PaIsZEo8NUkscsCyRUJLE=;
 b=IMYNgVYaiwlMi94vAd66CmexchApWWoc5T7tH1nrOLDiC8SJWygNml0B9GqBCwrBklfaoYIeWWHJz72UfZXhGuSRGg8jqejGySlR/BmGyhZHWopyieovrhG3APuts5jG0XkifSgoDfn4RJvKR+a2oILf0RNHNma9WtxLGhgjPtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6993.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 15:10:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:10:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 15:10:25 +0000
Message-Id: <DFUD2VQGF43V.3AGDOE8K4ANNX@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v11 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260121142355.4761-1-zhiw@nvidia.com>
 <20260121142355.4761-3-zhiw@nvidia.com>
In-Reply-To: <20260121142355.4761-3-zhiw@nvidia.com>
X-ClientProxiedBy: LO2P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: e2388a06-5dbb-4cd4-88f5-08de58ff352d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alhjKzJjRFRnZENsYU0xcmR4NTYvb01ySkZhdnhiRGh5bVI2eFYxYmMwTXl0?=
 =?utf-8?B?b0lyNHVtRG1HVUkwWEtoNFJ2S2hLNlQxZlFPeHRRZUdiUi9TT2gycDNUSmlO?=
 =?utf-8?B?K09JTGh5d3NKcWJEV0VabEZ5dUJtbHJtU3FQS2FhVDRQZUJwWHZIbFhhN3Rn?=
 =?utf-8?B?MUZKdjg2a0JpZVJSbmNIdHBLYzlqR01USGFsaDd0Y0t3ZUFZbU4xQ05UWEU0?=
 =?utf-8?B?U3BZYnhPQzJkSEQxZ0Y2ZHpwK3I4NWJRWXVxV1o2dlJNWjJxVThuOVJyVVBU?=
 =?utf-8?B?cTdRVkF3Q2ZmUmVXaThsNjhSdzFQZXc3a09VOUlzVEVST1RQY1NCVTB3bTFW?=
 =?utf-8?B?R1NBSEwzdUhBMkg0N1EvSTI1SFJVOFFIeDVqZnNydFE3TDZvY3pPM0RsamVh?=
 =?utf-8?B?UklmbTIzTFBkQVVjM3VVc2RFV1FBL0tSbnBIakZNc3JyVlZTU2h3aWVrV2pV?=
 =?utf-8?B?bFFiOHk5UmxjenBJYVlPaWgxaTRML1ZCOVlCUjdzUG8rZnNIc0Z2VlNsNkdu?=
 =?utf-8?B?d0J1ZUlLRzFyRzhxblFTTG1UdVNicU1mcTR5S1A4Y2RMZHQ3NldCSFVaSE9w?=
 =?utf-8?B?VlJteFpQaE4xaUNzTy9MdWNQaTljTm5sc3VPdTUzWSsvdzlVV0E4SkdmYUdH?=
 =?utf-8?B?WHZib0JuYzAwNTlydFJIZG1FVzhUN0V1OEhHdWFPTGtSczZCTWpHRmdMQ0di?=
 =?utf-8?B?dHRaTXVhOGNtUjhoVUl3YldmK2NQNlJQZC9VMEdnWkJVZWhUZlFJdytSQzlx?=
 =?utf-8?B?Q3pVUVl5ZUFOYzN4dGhYWDZsWFJ0anFMdzlKUEpnRkNtRy9TVlJ3RUt5SW9r?=
 =?utf-8?B?WWF1ajdydFlpOUhSUXAzNVVYdmRzeTd5UTRNeFJNR0hGSXIzbkUxdHViQjRD?=
 =?utf-8?B?VlE2VktBdVRrOWx5TGNaK3NWQ1J5NTlXclp4Wk1ZbWpRZklWVUJuL1l6VHgv?=
 =?utf-8?B?TVRYYVYvOHRTaDNXbmNZVDJXc0NUblZhYjA4bEFhTEdUL1J0QXhjSjJBajFD?=
 =?utf-8?B?NGh2TTlhWDk5TEpSMEJEVGxSSmhpQUtjTUUwQjNYYytIUm8zcGJoSFZOMVE3?=
 =?utf-8?B?RGxuWnJsNDEzMm9LMmNuTWh6b2VLcXJPN1J1aFVHQmd1dVlJc3hmUHAwMEQz?=
 =?utf-8?B?L3drb1p1TFJZcUtDVXRVQWppT2ZHbGh6UHZYdERRc2k4K0R2QmUyUHFNdnMr?=
 =?utf-8?B?cFZhb1VFcUs4NWk5ckJJT1E2MGRlL3hCUGZBRC9SVDl6T3NsUWtrcHgvWlZt?=
 =?utf-8?B?ZEQyQkd3aGtUMXhUUGR4ZEhUTmhLUnBDWWVaZktWS2hUYjdETENuU2dscHVL?=
 =?utf-8?B?NXZJSXU3STlHREMybWdYVUpYancwa0d2QXRibkN1SG5xcHVOdHZudHFweWd3?=
 =?utf-8?B?MkRxNWQrNHJKNDJFY0Q3dFNOa24vdm9pK3Uza2NraHBsTTU5SE42UmllL0w4?=
 =?utf-8?B?d2hOc2JmVEhjTldYV1drNmZnYnFCMi94UlRtbnlLVDJMQnh3M0tPcE1XSzF3?=
 =?utf-8?B?MTdQUTVuUk1xcTdHZ0ZRVExRSm9qRVhXRDlGR3Q1UVZWSkdzTldyMWxzUE54?=
 =?utf-8?B?VTh6Vjd3czIzVm8xVklkTDBRYkVibHFlbE5HVVdZZzlaWE1kN3NPcTVEc3l3?=
 =?utf-8?B?cTVtWlBmdTFza2hxZi92OGUxWmxjSjd5ay9SRnl6UHI3L2paMGdDWlVmazA2?=
 =?utf-8?B?TUJpS0F5MkRVK2EvT2YyMXJXSjNhckVzamRHN3QrQnNjZit2aHhoK1RVaVNC?=
 =?utf-8?B?eEdlZFE4VTd3Mk5oT3RKQWZFaVBRNldlR1VKVTJWSi8zVkRmZDVUWnR6TjV6?=
 =?utf-8?B?UWlGNktIdUUydmhmMVpPaGl4UWVuSjQ4d0toRXI4SFI1V0JPTWFTNHR6bjF3?=
 =?utf-8?B?T0d6NWszLzVlZC9zUVdyL1V4dTZDUWdacXR3azhheG1wZlBvbER6Y1lnZ3FU?=
 =?utf-8?B?MmFMTzBCQnJqQnJ2NDJkU0RwU0N5Mjd5QllQUmNCai9mMzRHeUFoUGw4ZVNN?=
 =?utf-8?B?SzR0Znp0RnJXdndsMjFqVFV6N29CV3FHS3RnMnF3UGdHQUowNVF0dHUraEta?=
 =?utf-8?B?TFIyVU5qRmtEcmcrQ3pjZ3lQdTROaGdSQUdUditoY1VKa2tleUxnWGlZaHl2?=
 =?utf-8?Q?IZbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3lhSzVwc1M2SktJZGRKcWpMK3YrMFJacUx6MGxlTjZSSzhyVXF4ZmV0OTdF?=
 =?utf-8?B?R0ZIck9vZ3prcWJaRk5CVHhleVh0c0hRV09sRWNzTVNKZm1yamlZci8wbmti?=
 =?utf-8?B?R3FMYmJ3RnpRV3psMWpBM1lGRUQ5ZnBTeDdYOGZtZG9RNklsTFROTlI1bDZE?=
 =?utf-8?B?WFhVRjNQZVJ3dW14aGdCWlJYd295QmRrdDJZbWIwRkRabmNjYnZRRjlWcUxX?=
 =?utf-8?B?WWFYSExIOXFlUURLTS9CeHNCWi9iL2xPejlEaUFDMVdSL2JMa1o0eGhLNFJt?=
 =?utf-8?B?WVdIOW0rc2JLa0hGNDRaSVZGa0taeFJrZnJFMHI3ZVNKWEJxNzlSMEsxRXQ4?=
 =?utf-8?B?UjNSYldwRmYwL2lOcjduNDZGZUxyazJja1R2RlNXMVJNcEwycW9EOWRVSTVN?=
 =?utf-8?B?bTJZUnp1bDhVT1FCb0xKUHRoQUd5ODZJZ3F2QXAwWHMrdzdmRDZzQ2NIL3ln?=
 =?utf-8?B?K2R4R1dRalpacW41dFV0WGxlOUYzdGtlSHd6cG1CVlpMUGZ3MHQ4OE84UjlN?=
 =?utf-8?B?WEJ6bG5zYzRvN2IySFVKL1Roc1Y2N1JwNmtiak5sODU0Wk1JYVB0N1RwaUEy?=
 =?utf-8?B?dXVMVzZWUVhVNCtUejc0N3VHem9XaVBNQ2J5ZVdLdTlnK0dtVjhVNVBRVisw?=
 =?utf-8?B?ZHJSY1FCZE9aQkZCdkpEcmJnVDFMNmpRaHZXeGFXZ2IzN3Z6M3BhMkQ4ak1j?=
 =?utf-8?B?SXFtTmt0U3phY3NzSVN5WHZzZzBkSnJteUhYa2VHVjI2SVRKOG5JQ29jMW1Z?=
 =?utf-8?B?UmR4alNHenFuU2Evdk9IelJERzhLVm5vUXZrMFQzYmFra1BBaHY2QmV0VXcz?=
 =?utf-8?B?T1VZVUdkYVFGSkFJOFBYbVgrWFJ4YTNKZzZxZFhUd1hQQVE3eW5hVUZwN0lr?=
 =?utf-8?B?NmwreTM3QVdUb3JkR05YM1dNWmF3a2JDZ2hyRk5waEYwRytrRjU3Z0V1dWIr?=
 =?utf-8?B?Q1dQamt5NUY4WW5JTkt4dkZvYWVIb0VqWXFRRXFrNlRXZGpnUDlERm4zN1pv?=
 =?utf-8?B?LzhiYXBha2FpaUlKRElwYjA5aUtlNVJNQVlTY3pJMjVhbzl1aUZndzV4WjRM?=
 =?utf-8?B?dlFqcm1xMzM3UUVmY2ZwNFBQODBHK1V2QS9RamN0QzJjVFdZNjJWQk1QL0FF?=
 =?utf-8?B?cHg3cWlzSnBWVXd0aUVaSHpDRWlvZEJMemV5M0ZVdHM3NG5DV245MXFyc05a?=
 =?utf-8?B?RHB6SzZFejMwaG52cXRJZXIzTDZ5R01TWDRaWWY5UHE3cE1VeVEwWU16V0pT?=
 =?utf-8?B?STZCcm9CQWE3bmFaMTNuYlVZNUhZYzRpRnM3ZHpGRXBQQk13dGdwcW9LSFRw?=
 =?utf-8?B?RkdkRmUrVDZyeDU2MnFNRSt4WnRvOXFOTSt2SXU5MEF3SUJnVW9lbzJWRlNm?=
 =?utf-8?B?akdzV2RuM3N1U2V1clYvcEJsZVFQWmxYNVBOZXJocHlPYkpYdlNVRHZ4Y2tz?=
 =?utf-8?B?b2tXTkpTTU5aWlpmNzRFVTNVaFpCODJSYVhLNk13TzhaZHpoK29VQVlqZmZP?=
 =?utf-8?B?SXo5NGFZdXNqQ0xPUkV1NE53RWdtZ0lUT3pVbzF5djI4ajI3bTJFaDVOV3kx?=
 =?utf-8?B?dkJZWTJqQ3V4dWtjL3hGejBkYnhhUUo3L0VxVHFRS3Z4eXoxYkUwbE9FQkk0?=
 =?utf-8?B?Q1BTZTk3RFZZdkZnOVcwUW5aOE5GaElnUzhDU0RNcllRWTlScFZDZThwRGJP?=
 =?utf-8?B?WVFSWUNSTW9zdjJYVURJY2xIa3RtVXNpalRTZWZORmQzV0hkVEd0WTdQS01s?=
 =?utf-8?B?ZWNZeG4rYk1lZ2V6QWFRd0lNWldJblVNWWhVSjhzd1hsOWpBZWtaUURJcVVK?=
 =?utf-8?B?T0pPT2s1OGllR0dsekdxSFpqQmY5alNYbGxjTFlHY0JjZGN3ek9VdWVSK1JV?=
 =?utf-8?B?SjVUY0p5Tkw0ZUMwNy9ZTHhlK1FtSnEzOCtaU1N4SmFQanlLTGwwS25uTlJC?=
 =?utf-8?B?dFZVRnFBU1V4cURBS1VvZlRSdXdvaHB6UlBwREpkanpWWmNIc2F5UDE4YWlL?=
 =?utf-8?B?STNhV1U5VUdzTXZYMzdQT1RyUmxwQlVSVmJEdUdOUWs3Q01pT0wyWFBVdEVR?=
 =?utf-8?B?ektXeURtWExkSTQ5N2QrNDFwYURPbW4rbXFYRWRqR1BRMFJIalQ0Tlc1RENs?=
 =?utf-8?B?RVRjSjRuSm9lRXRnbnM2QnJtbjZVQkNmc1o2SEJURFBiK2xCOS9wRkJFRWZ2?=
 =?utf-8?B?Mit0R1hDelRvQ2ZOMlVRNTR6cGxaM00yellmbmRQRmQ2UlRDWm1VR2EvdXBj?=
 =?utf-8?B?dTA5MmxMQkNzMlBlNnZ0QXRjUWhDdmU2cFJrNHRCTVVHdFB6Qm5iYmJ2Skcx?=
 =?utf-8?B?bzMyb2lOTml0YnJBV1hsOVRMd044RFlWVkx2VExiN3N4T240WXFkQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2388a06-5dbb-4cd4-88f5-08de58ff352d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:10:26.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhO2zLV+ECCAQXrnYSBcbdJuAx/c7Eta7bZUbo7aOKDxvYUHXK+PJnrobNBL9BN7rADS000rFYeJ+QOTnnq9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6993

On Wed Jan 21, 2026 at 2:23 PM GMT, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevent=
ed
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
>
> Establish a clean separation between the I/O interface and concrete backe=
nds
> by separating generic I/O helpers from MMIO implementation.
>
> Introduce a new trait hierarchy to handle different access capabilities:
>
> - IoCapable<T>: A marker trait indicating that a backend supports I/O
>   operations of a certain type (u8, u16, u32, or u64).
>
> - Io trait: Defines fallible I/O methods (try_read8, try_write8, etc.) wi=
th
>   runtime bounds checking.
>
> - IoKnownSize trait: Extends Io to define infallible I/O methods (read8,
>   write8, etc.) with compile-time bounds checking for regions where the
>   size is known at compile time.
>
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements the Io and IoKnownSize traits. Rename IoRaw to MmioRaw and
> update consumers to use the new types.
>

Hi Zhi, thanks for doing the work. It looks much nicer now :)

Still, some comments below.

Best,
Gary

> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/drm/tyr/regs.rs            |   1 +
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  drivers/pwm/pwm_th1520.rs              |   5 +-
>  rust/kernel/devres.rs                  |  19 +-
>  rust/kernel/io.rs                      | 415 +++++++++++++++++++++----
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |  16 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   4 +
>  11 files changed, 453 insertions(+), 131 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index a97eb44a9a87..152afdcbaf78 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -32,16 +32,16 @@
>  /// By itself, the existence of an instance of this structure does not p=
rovide any guarantees that
>  /// the represented MMIO region does exist or is properly mapped.
>  ///
> -/// Instead, the bus specific MMIO implementation must convert this raw =
representation into an `Io`
> -/// instance providing the actual memory accessors. Only by the conversi=
on into an `Io` structure
> -/// any guarantees are given.
> -pub struct IoRaw<const SIZE: usize =3D 0> {
> +/// Instead, the bus specific MMIO implementation must convert this raw =
representation into an
> +/// `Mmio` instance providing the actual memory accessors. Only by the c=
onversion into an `Mmio`
> +/// structure any guarantees are given.
> +pub struct MmioRaw<const SIZE: usize =3D 0> {
>      addr: usize,
>      maxsize: usize,
>  }
> =20
> -impl<const SIZE: usize> IoRaw<SIZE> {
> -    /// Returns a new `IoRaw` instance on success, an error otherwise.
> +impl<const SIZE: usize> MmioRaw<SIZE> {
> +    /// Returns a new `MmioRaw` instance on success, an error otherwise.
>      pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
>          if maxsize < SIZE {
>              return Err(EINVAL);
> @@ -81,14 +81,16 @@ pub fn maxsize(&self) -> usize {
>  ///     ffi::c_void,
>  ///     io::{
>  ///         Io,
> -///         IoRaw,
> +///         IoKnownSize,
> +///         Mmio,
> +///         MmioRaw,
>  ///         PhysAddr,
>  ///     },
>  /// };
>  /// use core::ops::Deref;
>  ///
>  /// // See also `pci::Bar` for a real example.
> -/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> +/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
>  ///
>  /// impl<const SIZE: usize> IoMem<SIZE> {
>  ///     /// # Safety
> @@ -103,7 +105,7 @@ pub fn maxsize(&self) -> usize {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> +///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
>  ///     }
>  /// }
>  ///
> @@ -115,11 +117,11 @@ pub fn maxsize(&self) -> usize {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D Io<SIZE>;
> +///    type Target =3D Mmio<SIZE>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been proper=
ly mapped in `Self::new`.
> -///         unsafe { Io::from_raw(&self.0) }
> +///         unsafe { Mmio::from_raw(&self.0) }
>  ///    }
>  /// }
>  ///
> @@ -133,29 +135,31 @@ pub fn maxsize(&self) -> usize {
>  /// # }
>  /// ```
>  #[repr(transparent)]
> -pub struct Io<const SIZE: usize =3D 0>(IoRaw<SIZE>);
> +pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> =20
>  macro_rules! define_read {
> -    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $typ=
e_name:ty) =3D> {
> +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> =
$type_name:ty) =3D> {
>          /// Read IO data from a given offset known at compile time.
>          ///
>          /// Bound checks are performed on compile time, hence if the off=
set is not known at compile
>          /// time, the build will fail.
>          $(#[$attr])*
>          #[inline]
> -        pub fn $name(&self, offset: usize) -> $type_name {
> +        $vis fn $name(&self, offset: usize) -> $type_name {
>              let addr =3D self.io_addr_assert::<$type_name>(offset);
> =20
>              // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
>              unsafe { bindings::$c_fn(addr as *const c_void) }
>          }
> +    };
> =20
> +    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -=
> $type_name:ty) =3D> {
>          /// Read IO data from a given offset.
>          ///
>          /// Bound checks are performed on runtime, it fails if the offse=
t (plus the type size) is
>          /// out of bounds.
>          $(#[$attr])*
> -        pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
> +        $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
>              let addr =3D self.io_addr::<$type_name>(offset)?;
> =20
>              // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
> @@ -163,74 +167,95 @@ pub fn $try_name(&self, offset: usize) -> Result<$t=
ype_name> {
>          }
>      };
>  }
> +pub(crate) use define_read;
> =20
>  macro_rules! define_write {
> -    ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident <- $typ=
e_name:ty) =3D> {
> +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- =
$type_name:ty) =3D> {
>          /// Write IO data from a given offset known at compile time.
>          ///
>          /// Bound checks are performed on compile time, hence if the off=
set is not known at compile
>          /// time, the build will fail.
>          $(#[$attr])*
>          #[inline]
> -        pub fn $name(&self, value: $type_name, offset: usize) {
> +        $vis fn $name(&self, value: $type_name, offset: usize) {
>              let addr =3D self.io_addr_assert::<$type_name>(offset);
> =20
>              // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
>              unsafe { bindings::$c_fn(value, addr as *mut c_void) }
>          }
> +    };
> =20
> +    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <=
- $type_name:ty) =3D> {
>          /// Write IO data from a given offset.
>          ///
>          /// Bound checks are performed on runtime, it fails if the offse=
t (plus the type size) is
>          /// out of bounds.
>          $(#[$attr])*
> -        pub fn $try_name(&self, value: $type_name, offset: usize) -> Res=
ult {
> +        $vis fn $try_name(&self, value: $type_name, offset: usize) -> Re=
sult {
>              let addr =3D self.io_addr::<$type_name>(offset)?;
> =20
>              // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
> -            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
> +            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
>              Ok(())
>          }
>      };
>  }
> -
> -impl<const SIZE: usize> Io<SIZE> {
> -    /// Converts an `IoRaw` into an `Io` instance, providing the accesso=
rs to the MMIO mapping.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure that `addr` is the start of a valid I/O mapp=
ed memory region of size
> -    /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> -        unsafe { &*core::ptr::from_ref(raw).cast() }
> +pub(crate) use define_write;
> +
> +/// Checks whether an access of type `U` at the given `offset`
> +/// is valid within this region.
> +#[inline]
> +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +    let type_size =3D core::mem::size_of::<U>();
> +    if let Some(end) =3D offset.checked_add(type_size) {
> +        end <=3D size && offset % type_size =3D=3D 0
> +    } else {
> +        false
>      }
> +}
> +
> +/// Marker trait indicating that an I/O backend supports operations of a=
 certain type.
> +///
> +/// Different I/O backends can implement this trait to expose only the o=
perations they support.
> +///
> +/// For example, a PCI configuration space may implement `IoCapable<u8>`=
, `IoCapable<u16>`,
> +/// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO region=
 on a 64-bit
> +/// system might implement all four.
> +pub trait IoCapable<T> {}
> +
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
> +/// can perform I/O operations on regions of memory.
> +///
> +/// This is an abstract representation to be implemented by arbitrary I/=
O
> +/// backends (e.g. MMIO, PCI config space, etc.).
> +///
> +/// The [`Io`] trait provides:
> +/// - Base address and size information
> +/// - Helper methods for offset validation and address calculation
> +/// - Fallible (runtime checked) accessors for different data widths
> +///
> +/// Which I/O methods are available depends on which [`IoCapable<T>`] tr=
aits
> +/// are implemented for the type.
> +///
> +/// # Examples
> +///
> +/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit system=
s) are typically
> +/// supported. For PCI configuration space, u8, u16, and u32 are support=
ed but u64 is not.
> +pub trait Io {
> +    /// Minimum usable size of this region.
> +    const MIN_SIZE: usize;
> =20
>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
> =20
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> -
> -    #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -        let type_size =3D core::mem::size_of::<U>();
> -        if let Some(end) =3D offset.checked_add(type_size) {
> -            end <=3D size && offset % type_size =3D=3D 0
> -        } else {
> -            false
> -        }
> -    }
> +    fn maxsize(&self) -> usize;
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing runtime bound checks.
>      #[inline]
>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(offset, self.maxsize()) {
>              return Err(EINVAL);
>          }
> =20
> @@ -239,50 +264,302 @@ fn io_addr<U>(&self, offset: usize) -> Result<usiz=
e> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
>      #[inline]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> =20
>          self.addr() + offset
>      }
> =20
> -    define_read!(read8, try_read8, readb -> u8);
> -    define_read!(read16, try_read16, readw -> u16);
> -    define_read!(read32, try_read32, readl -> u32);
> +    /// Fallible 8-bit read with runtime bounds check.
> +    #[inline(always)]
> +    fn try_read8(&self, _offset: usize) -> Result<u8>
> +    where
> +        Self: IoCapable<u8>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 8-bit =
read") };
> +        unreachable!()

I think this is actually where `build_error!()` make sense. Similar to how =
we
use it for vtable methods that are not defined (and hence will be `None`).

This would eliminate `unreachable!()`.

> +    }
> +
> +    /// Fallible 16-bit read with runtime bounds check.
> +    #[inline(always)]
> +    fn try_read16(&self, _offset: usize) -> Result<u16>
> +    where
> +        Self: IoCapable<u16>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 16-bit=
 read") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 32-bit read with runtime bounds check.
> +    #[inline(always)]
> +    fn try_read32(&self, _offset: usize) -> Result<u32>
> +    where
> +        Self: IoCapable<u32>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 32-bit=
 read") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 64-bit read with runtime bounds check.
> +    #[cfg(CONFIG_64BIT)]
> +    #[inline(always)]
> +    fn try_read64(&self, _offset: usize) -> Result<u64>
> +    where
> +        Self: IoCapable<u64>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 64-bit=
 read") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 8-bit write with runtime bounds check.
> +    #[inline(always)]
> +    fn try_write8(&self, _value: u8, _offset: usize) -> Result
> +    where
> +        Self: IoCapable<u8>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 8-bit =
write") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 16-bit write with runtime bounds check.
> +    #[inline(always)]
> +    fn try_write16(&self, _value: u16, _offset: usize) -> Result
> +    where
> +        Self: IoCapable<u16>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 16-bit=
 write") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 32-bit write with runtime bounds check.
> +    #[inline(always)]
> +    fn try_write32(&self, _value: u32, _offset: usize) -> Result
> +    where
> +        Self: IoCapable<u32>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 32-bit=
 write") };
> +        unreachable!()
> +    }
> +
> +    /// Fallible 64-bit write with runtime bounds check.
> +    #[cfg(CONFIG_64BIT)]

As Alice mentioned previously, the CONFIG_64BIT shouldn't need to exist on =
the trait.

The cfg on the impl is sufficient (there might be `Io` that provides 64-bit
access on 32-bit systems anyway).

> +    #[inline(always)]
> +    fn try_write64(&self, _value: u64, _offset: usize) -> Result
> +    where
> +        Self: IoCapable<u64>,
> +    {
> +        const { assert!(false, "Backend does not support fallible 64-bit=
 write") };
> +        unreachable!()
> +    }
> +}
> +
> +/// Types with a known size at compile time can provide infallible I/O a=
ccessors.
> +///
> +/// This trait extends [`Io`] to provide compile-time bounds-checked I/O=
 operations
> +/// for regions where the size is known at compile time (e.g., `Mmio<SIZ=
E>`).
> +pub trait IoKnownSize: Io {
> +    /// Infallible 8-bit read with compile-time bounds check.
> +    #[inline(always)]
> +    fn read8(&self, _offset: usize) -> u8
> +    where
> +        Self: IoCapable<u8>,

I think these *can* be also on `Io` with `Self: IoKnownSize` bound, althoug=
h in
practice I don't think it would matter.

> +    {
> +        const { assert!(false, "Backend does not support infallible 8-bi=
t read") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 16-bit read with compile-time bounds check.
> +    #[inline(always)]
> +    fn read16(&self, _offset: usize) -> u16
> +    where
> +        Self: IoCapable<u16>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 16-b=
it read") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 32-bit read with compile-time bounds check.
> +    #[inline(always)]
> +    fn read32(&self, _offset: usize) -> u32
> +    where
> +        Self: IoCapable<u32>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 32-b=
it read") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 64-bit read with compile-time bounds check.
> +    #[cfg(CONFIG_64BIT)]
> +    #[inline(always)]
> +    fn read64(&self, _offset: usize) -> u64
> +    where
> +        Self: IoCapable<u64>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 64-b=
it read") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 8-bit write with compile-time bounds check.
> +    #[inline(always)]
> +    fn write8(&self, _value: u8, _offset: usize)
> +    where
> +        Self: IoCapable<u8>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 8-bi=
t write") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 16-bit write with compile-time bounds check.
> +    #[inline(always)]
> +    fn write16(&self, _value: u16, _offset: usize)
> +    where
> +        Self: IoCapable<u16>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 16-b=
it write") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 32-bit write with compile-time bounds check.
> +    #[inline(always)]
> +    fn write32(&self, _value: u32, _offset: usize)
> +    where
> +        Self: IoCapable<u32>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 32-b=
it write") };
> +        unreachable!()
> +    }
> +
> +    /// Infallible 64-bit write with compile-time bounds check.
> +    #[cfg(CONFIG_64BIT)]
> +    #[inline(always)]
> +    fn write64(&self, _value: u64, _offset: usize)
> +    where
> +        Self: IoCapable<u64>,
> +    {
> +        const { assert!(false, "Backend does not support infallible 64-b=
it write") };
> +        unreachable!()
> +    }
> +}
> +
> +// MMIO regions support 8, 16, and 32-bit accesses.
> +impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
> +impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {}
> +impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
> +
> +// MMIO regions on 64-bit systems also support 64-bit accesses.
> +#[cfg(CONFIG_64BIT)]
> +impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
> +
> +impl<const SIZE: usize> Io for Mmio<SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +
> +    define_read!(fallible, try_read8, readb -> u8);
> +    define_read!(fallible, try_read16, readw -> u16);
> +    define_read!(fallible, try_read32, readl -> u32);
>      define_read!(
> +        fallible,
>          #[cfg(CONFIG_64BIT)]
> -        read64,
>          try_read64,
>          readq -> u64
>      );
> =20
> -    define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
> -    define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u1=
6);
> -    define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u3=
2);
> +    define_write!(fallible, try_write8, writeb <- u8);
> +    define_write!(fallible, try_write16, writew <- u16);
> +    define_write!(fallible, try_write32, writel <- u32);
> +    define_write!(
> +        fallible,
> +        #[cfg(CONFIG_64BIT)]
> +        try_write64,
> +        writeq <- u64
> +    );
> +}
> +
> +impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
> +    define_read!(infallible, read8, readb -> u8);
> +    define_read!(infallible, read16, readw -> u16);
> +    define_read!(infallible, read32, readl -> u32);
>      define_read!(
> +        infallible,
>          #[cfg(CONFIG_64BIT)]
> -        read64_relaxed,
> -        try_read64_relaxed,
> -        readq_relaxed -> u64
> +        read64,
> +        readq -> u64
>      );
> =20
> -    define_write!(write8, try_write8, writeb <- u8);
> -    define_write!(write16, try_write16, writew <- u16);
> -    define_write!(write32, try_write32, writel <- u32);
> +    define_write!(infallible, write8, writeb <- u8);
> +    define_write!(infallible, write16, writew <- u16);
> +    define_write!(infallible, write32, writel <- u32);
>      define_write!(
> +        infallible,
>          #[cfg(CONFIG_64BIT)]
>          write64,
> -        try_write64,
>          writeq <- u64
>      );
> +}
> +
> +impl<const SIZE: usize> Mmio<SIZE> {
> +    /// Converts an `MmioRaw` into an `Mmio` instance, providing the acc=
essors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `addr` is the start of a valid I/O mapp=
ed memory region of size
> +    /// `maxsize`.
> +    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
> +        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
> +        unsafe { &*core::ptr::from_ref(raw).cast() }
> +    }
> +
> +    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
> +    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
> +    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
> +    define_read!(
> +        infallible,
> +        #[cfg(CONFIG_64BIT)]
> +        pub read64_relaxed,
> +        readq_relaxed -> u64
> +    );
> +
> +    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
> +    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16)=
;
> +    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32)=
;
> +    define_read!(
> +        fallible,
> +        #[cfg(CONFIG_64BIT)]
> +        pub try_read64_relaxed,
> +        readq_relaxed -> u64
> +    );
> +
> +    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
> +    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16=
);
> +    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32=
);
> +    define_write!(
> +        infallible,
> +        #[cfg(CONFIG_64BIT)]
> +        pub write64_relaxed,
> +        writeq_relaxed <- u64
> +    );
> =20
> -    define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- =
u8);
> -    define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <=
- u16);
> -    define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <=
- u32);
> +    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8=
);
> +    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u=
16);
> +    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u=
32);
>      define_write!(
> +        fallible,
>          #[cfg(CONFIG_64BIT)]
> -        write64_relaxed,
> -        try_write64_relaxed,
> +        pub try_write64_relaxed,
>          writeq_relaxed <- u64
>      );
>  }
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index e4878c131c6d..620022cff401 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -16,8 +16,8 @@
>              Region,
>              Resource, //
>          },
> -        Io,
> -        IoRaw, //
> +        Mmio,
> +        MmioRaw, //
>      },
>      prelude::*,
>  };
> @@ -212,7 +212,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl Pin=
Init<Devres<Self>, Error> +
>  }
> =20
>  impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
> -    type Target =3D Io<SIZE>;
> +    type Target =3D Mmio<SIZE>;
> =20
>      fn deref(&self) -> &Self::Target {
>          &self.iomem
> @@ -226,10 +226,10 @@ fn deref(&self) -> &Self::Target {
>  ///
>  /// # Invariants
>  ///
> -/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid poin=
ter to the
> +/// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid po=
inter to the
>  /// start of the I/O memory mapped region.
>  pub struct IoMem<const SIZE: usize =3D 0> {
> -    io: IoRaw<SIZE>,
> +    io: MmioRaw<SIZE>,
>  }
> =20
>  impl<const SIZE: usize> IoMem<SIZE> {
> @@ -264,7 +264,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D IoRaw::new(addr as usize, size)?;
> +        let io =3D MmioRaw::new(addr as usize, size)?;
>          let io =3D IoMem { io };
> =20
>          Ok(io)
> @@ -287,10 +287,10 @@ fn drop(&mut self) {
>  }
> =20
>  impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -    type Target =3D Io<SIZE>;
> +    type Target =3D Mmio<SIZE>;
> =20
>      fn deref(&self) -> &Self::Target {
>          // SAFETY: Safe as by the invariant of `IoMem`.
> -        unsafe { Io::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(&self.io) }
>      }
>  }
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index b1a2570364f4..75d1b3e8596c 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -45,12 +45,16 @@
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::io::{Io, poll::read_poll_timeout};
> +/// use kernel::io::{
> +///     Io,
> +///     Mmio,
> +///     poll::read_poll_timeout, //
> +/// };
>  /// use kernel::time::Delta;
>  ///
>  /// const HW_READY: u16 =3D 0x01;
>  ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
>  ///     read_poll_timeout(
>  ///         // The `op` closure reads the value of a specific status reg=
ister.
>  ///         || io.try_read16(0x1000),
> @@ -128,12 +132,16 @@ pub fn read_poll_timeout<Op, Cond, T>(
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
> +/// use kernel::io::{
> +///     Io,
> +///     Mmio,
> +///     poll::read_poll_timeout_atomic, //
> +/// };
>  /// use kernel::time::Delta;
>  ///
>  /// const HW_READY: u16 =3D 0x01;
>  ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
>  ///     read_poll_timeout_atomic(
>  ///         // The `op` closure reads the value of a specific status reg=
ister.
>  ///         || io.try_read16(0x1000),
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 70e3854e7d8d..e3377397666e 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,8 +8,8 @@
>      device,
>      devres::Devres,
>      io::{
> -        Io,
> -        IoRaw, //
> +        Mmio,
> +        MmioRaw, //
>      },
>      prelude::*,
>      sync::aref::ARef, //
> @@ -27,7 +27,7 @@
>  /// memory mapped PCI BAR and its size.
>  pub struct Bar<const SIZE: usize =3D 0> {
>      pdev: ARef<Device>,
> -    io: IoRaw<SIZE>,
> +    io: MmioRaw<SIZE>,
>      num: i32,
>  }
> =20
> @@ -63,7 +63,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr)=
 -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D match IoRaw::new(ioptr, len as usize) {
> +        let io =3D match MmioRaw::new(ioptr, len as usize) {
>              Ok(io) =3D> io,
>              Err(err) =3D> {
>                  // SAFETY:
> @@ -117,11 +117,11 @@ fn drop(&mut self) {
>  }
> =20
>  impl<const SIZE: usize> Deref for Bar<SIZE> {
> -    type Target =3D Io<SIZE>;
> +    type Target =3D Mmio<SIZE>;
> =20
>      fn deref(&self) -> &Self::Target {
>          // SAFETY: By the type invariant of `Self`, the MMIO range in `s=
elf.io` is properly mapped.
> -        unsafe { Io::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(&self.io) }
>      }
>  }
> =20
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index ef04c6401e6a..bfb053059667 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -7,6 +7,10 @@
>  use kernel::{
>      device::Core,
>      devres::Devres,
> +    io::{
> +        Io,
> +        IoKnownSize, //
> +    },
>      pci,
>      prelude::*,
>      sync::aref::ARef, //

