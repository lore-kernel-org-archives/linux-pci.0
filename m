Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDD459AE5;
	Tue, 28 Jul 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251396; cv=fail; b=PuOP+HHWfQvHTujcypra5wkxmnBquAZKC9OTfVZ91vTdaNrU2ugruMNZ7TFoJmeavBij6osrrHWAc7KD9j5GnQ2daMl4GuNCNGqItVkwRLKX5iHbzNlNpmkueaiJlgiuxOa+EAQN8dEPhVZe+iDYnQy4eGx0wi49OEywSagkAo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251396; c=relaxed/simple;
	bh=zy4mc91CY7L19fC9q7l9jnrzNM9wieN9qRqRgPYyC+A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ds29Apm9UBeK5OPGVZsj+BWIuv/BWg4Rg3dnihfUeovobvCJFiPOk+AFUhouCtfyMBP58+jTaf0OJQ9i6R5iyDleQO4VtXTYsfyQceH9bkFLjKqXV/O8MxfJ4qoCItJXEAwvlVJGw3mu6HDAMaX7egtnGJGTgfhU00AqT3avHuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CbRk+CfK; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CbRk+CfK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGaP86XtwI0ObU5EQaspgo6uniTYTTFNX2DF6RoIXekZ7m0NJmoeDoV3Mo/7HDG2v7/OCTDecB+Mac5zwAXuZAHpbxIYcGplM7806FpsBdkpqlE3vuJHt2BYtkkmuW/8kxCwBA7+4JFmWXpujNpnvHsFr9pmB7Jfl1leALEjtTq0yMpL3/mloC0brYqDKZLWTBo8PdD2ES2hu5qVFZ/rq8UHb7YKDlgdE8oJZFWS+VbRzTBJ/Y4mVPQo08OSn0elEgYe8eHx22l3NE0Vn2He/DcYb+nwiC+ngxLFmTa8J8zG9r7e0w91NBZatKxtSgU5ZiQWR+UWQoWtzJNq6FxnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQLs4y+PPMItTj3+3wYWiJ/o03oy2+UPiIL5+Mgtw2A=;
 b=Zp0SruyfLW2Hp3KurvkY7KGfQey0zyxQntKPU6X8f0kGf1/uuyEaOKWGeqi+on5cMLpQt85s5jGIvcgOctY+KYMP1y7gm/hDghiAIOxlYu1qTZNWh43EWAq5L0RsM7gfK8C6O182NZ+Cc2mQgxc2utUZJbI9pU1h2nJVAanuQZ0EIKOlPEsYG413Dddz/XJhdsqwZmQREzj5bJwkgvdQ0gt5c8itc4Fg8w4MCopIUqKLqjFGqhQVuMXY9QkBRXrm7JS/4VT4Ng9vi+kzlPdLsuunSmgkK21PHheMtnH6Fx8g+wu6BZsmkX/jOdCPoNPlvZIVJe6iT9r0xIwp4ICTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQLs4y+PPMItTj3+3wYWiJ/o03oy2+UPiIL5+Mgtw2A=;
 b=CbRk+CfKieG+50uRSE3CssIFCse1juZbmsF4B0aJtHLoM8IQLW47jNyncdSherzcuPAlAvRXhcjAAkS9a437oltaiPjGxnoGrCq1hoXUjVWuw3DO9eLl1t4ephmjS9kVqiwudEcIl7blIB2jMVrvvZCGw0xKm/QTsiQF1cOgUVZJKQQ3ujSc5+jL7iFKEYaQBP/VgQRIHDKKgq8Yf2LnkW0Uo04e9bZ4iq5E51NzToX0aLcr85eebW5dRy/RANKqIGcI+8NX46XxE5Nm0StLzByJ7oGsJFRCl923Et9HCslY1OadZbQdPFzx9aUvz+tTalviHusjQjI3XNaMtFlH4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:09:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:09:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 00:09:43 +0900
Message-Id: <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
In-Reply-To: <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 69421325-5cc4-46b5-cd4d-08deecba4318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|23010399003|4143699003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iCtc+w9WNltX5jgESujR5la/okxmXOSy6mbvrs+YCAJma0lPljzCCO3CV50rM5Yxoae3XZIFTnspno+b2yOr4zbuZWegtAUdvjUn+TwJeB9H7R+IcS/XEAAF1XXfhbRunIU0xeHjbotrxcv0ybhsidqzfpyJtiWVdcCBQmXfVJd5/gkf6hVecjudihaR47aVUrCkzy7ANYZQ8iEfvpIF8PLnNHeyO6ebQDxO6JJB25D12cObg3TVlGITXT4evAWy/60ynEc4CAEC3HnQbKOAA0rjh/XpYYktl27/Vo7rwutRmVFX4w5/9RNxN7r6TW2/p/AbEiK4+xq4gAggPW8vHstA1N1H2iXHWo+ehJT1Cg7b/lDo0zCzmFt42eo/fSKqmPD5l4FIOxpOfYaNTR3+FQngQVTl5ET0sm5o0B6/iiZ5sNS+02oq1UoCN0TPhA8Cq73HTSMMWONOGzdW7LqbWqxH/rQzImzI6Iwm3brqO7XCSjOVQ2yLRQZmahwDkEZ89fAMhs+S9Sl/ZAjV8sGIb0iOJZn+1RE2dXKN25s5RJxQYAvsFJ8ng7k1jDcwu8qia3drEFYi97VWRfI0f69vTmDrBpPj+4Zogqto/abjg7R8Yg/tAWeFWUXNnvR1wADBgm8r3TpJLhryCkdqddCvy8c74GQOg093D1dKCIKe6b0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(23010399003)(4143699003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnpkRVdKUVNSR2ZmSDVVSDFBMWVZbWtGMk50bVovOFI5NExDU1FSdWNhbXFt?=
 =?utf-8?B?aTdmYWpvY1g0R2d4bUFlVEU5NmU1L04wL1AwK3h3SUdGSFhQVDROVDJUSDd0?=
 =?utf-8?B?dVc1Wnh3WDRpS2hqUnJ6VlpNSHRjSXBsVEtyeVd1aGtleHhpc1lqZlhnV3BZ?=
 =?utf-8?B?UlFOVTVCQnl1NURzaHRKV1RibFlTSjRGbnpTTWlKVThhWERtQ1pyR2V4SWt2?=
 =?utf-8?B?ekRSWkNtcW5Xc1FXalBseVR3TllzdS9CU3JhOUJ5NVRpLzcxRXZYZjJGVGpS?=
 =?utf-8?B?TlZTNjR3WkR5TDdsaWZ4cDB2NFNpYmpjQ0Y5OVhDdXVpUEFwYXRkRHZVQ3R2?=
 =?utf-8?B?YXFaempFQ29yM050YzhKN2JiOHl3Tnd5UUlSYjJQa2pBN2wvTExLNVZJSnR6?=
 =?utf-8?B?UklGbXd4MThhMDhVRTltNlF2SlI4U0NOcTRTUmQ4QU8wWlcyUlhUVmFaaUhM?=
 =?utf-8?B?UEdvbVBNVExBZlRtOTI0TWMzekl5L3B1NkJUdnZHUHlVWElQaFF2Z1JRUVN3?=
 =?utf-8?B?MjNka0VvbUQvbzZraDdFNFlla0pJZTI0a0tYc2NsSTA0N0dpVXRuYnhkbzc1?=
 =?utf-8?B?bmkyUG5RT25mVG9YRVB3Q1puSERCU3F3ZHlpZkt3a3pvanV4aDZrU3FFZjMz?=
 =?utf-8?B?aFViNnJQWEdDcGQ1SUpWbVhidkdHa2RkUGMvZElJdkJKTXl0Q3VUdmxoMDdW?=
 =?utf-8?B?bjdlWWJMaW1CZEg5c1UzOWw4UWJEN2pVQzBLZzZTZmNjbFh2ekJjdCtBdit1?=
 =?utf-8?B?V2RGSlBneC9YS2tlL29jWlpKdEhRQmVqQmFDR1RHakhjMmZpOHdxbldSMURM?=
 =?utf-8?B?dE1TQUx5clR4QUs5STBUWFJ4WnNUdU9mcnRvTWYvZkIybng4b20yc1ROL25o?=
 =?utf-8?B?MldWZFZwWWd0UU9nR1NiZ2lCbXJRQXJUa3A3Tjk4aXFNQzBhQ0JoYWZ6L3lG?=
 =?utf-8?B?RmFVaUgwZUdiR0VJWjJLVXZ0eG51ZmtwaHh2VmpxMW9hSFVHRFA0Z2VFOUZv?=
 =?utf-8?B?dVpmaFREaGlPdUxTREMvU3ExdS82V1hQNkdjTXZka1NMcmd2MHZSRGpmMGhy?=
 =?utf-8?B?ZDZqQ0xjVklrS2U1dkp2TVM5anMzbVhqa2xXcXdidUszTjhBU2FxbFhzZko0?=
 =?utf-8?B?VUZIdUtTVjdOS1NlcXZNNE55MDMxTUozc1NMc0tMK1NXSjdVQ2hqME91TWJK?=
 =?utf-8?B?ZE1Rd0YvdWlZMWVzWWxjQWpxOHZGZ3VYdFB5TzA1Y1RVMWtWZDZ0QkgxRVRN?=
 =?utf-8?B?VFZVd0VwMzFUSVg3dVpLTWRLNGhWa0JxSmNoYWJvREc3bkt2Z1JxK0g0MVd2?=
 =?utf-8?B?VHVGc3Y5ekFoYklETEc2UG92OG9rN2lyVkJSaENwSUVUWHFQdjdPazFNUmtT?=
 =?utf-8?B?azN5MGovT1I5N0M1TE5pc1NlVjcvd3NDRUtDMWlUazRNWnpWMFYvdDJiMTIy?=
 =?utf-8?B?QXkvcVJkODVmN05GeUlxdXRuUnc1R3BJTXpTbEorRXhySlNCRitjekt5RkRo?=
 =?utf-8?B?Z3VFd3F5TzlVd1RjeHl6K3ZNTzAvMm1nK3h3YXpwVFR2ZGp4cS9BbjJLeENv?=
 =?utf-8?B?MEwyNmk4b0MrVGpvNmNUMTBtL1VDM3U5cDdjbHR6QzE3MTRpMC95anMrb01F?=
 =?utf-8?B?VWxyMXUrNzExdTYwNXdhbmlhakZXd090ZW93QTlGZ3Z3aHhYQnk5TUNlODQ4?=
 =?utf-8?B?by9sYkVKNGYrbUlnK09OUXp4VXBWRnJMWGp5OEZ2ZFZlbEYxZ1kvT1B0OVpE?=
 =?utf-8?B?MkY1VWZjWHgzc0FiY1VjbnRLVmVhMkdCbzdQUWxqTjhrWHpGK2RLd2VXMWlh?=
 =?utf-8?B?aUF4ajl0MUpEVngvby9Bckl0SzFXYWVXeVdGNzYrTTBISW5neGJEdXVmWWNv?=
 =?utf-8?B?a1l1WWtMTlRGd3VaaXlySHJpTnBoeTJsR1hmelZVUVNhcU9ZbWpxeU9XcUdv?=
 =?utf-8?B?Q1VvNURTRmdUZ2RrZTFac3doaWtHU1dHNDU2eTBzOU5aSyt5eWVxajNFZitp?=
 =?utf-8?B?VkVKMzBUNlBsT0hOL092NWVCQ2dnV3VGbXZNSSs2WWMrMEJXUmE4c1VTcW9K?=
 =?utf-8?B?RmE5SW9qbnRaSXY4KzQycDhwTFdRaGdVSzdmQXJiMHZtOWRrMGFZckZ2cTRi?=
 =?utf-8?B?NlgrKzZPdkJMVkVNRTk3cEtvV0QvemxsWEJYZXNRTzNQdis1dnFsTDRYMmhy?=
 =?utf-8?B?eFAxbGJocFRPY2F0NnprM0d4blU1bkFMNGpObkNxQTE5WXV1MWZUdE4yOHNp?=
 =?utf-8?B?dnZJUzVoY3RWNzAxQ2M0V3k1MVZBaW9iL3NxU21MWW1YZnRBWTZiQzZzQnRC?=
 =?utf-8?B?TjZ2eEQ4SVYzN3JJQzBUT3dBaUpmOElvRUE5TFBNZm56bjNGZWk3TmVMcjZW?=
 =?utf-8?Q?iv/9c5Hae8G1M0oP/fNtqqCGlruZLXFiIWoBlpO/381AE?=
X-MS-Exchange-AntiSpam-MessageData-1: VPwMhcOKsrWzNA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69421325-5cc4-46b5-cd4d-08deecba4318
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:09:46.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4TaqJtixLEu0l7NW6S7kCOY6GYNhveorCywqoLRL+E7A0WlkCX5mXVf4M4MSsE918GOK7BCHu+VescxW+dI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

On Tue Jul 28, 2026 at 7:24 PM JST, Gary Guo wrote:
> On Tue Jul 28, 2026 at 7:45 AM BST, Alexandre Courbot wrote:
>> On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
>>> Add fixed size region types for these and add projection methods that
>>> project from `Bar0` into these. Update these registers to be registers =
on
>>> `PFalconRegisters` and `PFalcon2Registers` and not relative registers o=
n
>>> `NovaRegisters`.
>>>
>>> The use sites are updated mechanically; calls to the projection methods=
 are
>>> not extracted in this commit.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  drivers/gpu/nova-core/falcon.rs                    | 158 +++++++++----=
--------
>>>  drivers/gpu/nova-core/falcon/fsp.rs                |  53 +++----
>>>  drivers/gpu/nova-core/falcon/gsp.rs                |  43 +++---
>>>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  39 ++---
>>>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |   8 +-
>>>  drivers/gpu/nova-core/falcon/sec2.rs               |  32 +++--
>>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  11 +-
>>>  drivers/gpu/nova-core/regs.rs                      |  81 ++++++-----
>>>  8 files changed, 193 insertions(+), 232 deletions(-)
>>>
>> We are calling these methods quite a bit throughout the code. I
>> understand they are supposed to be optimized away, but that's still a
>> lot of repetition.
>>
>> Since we now have HRTB and `Falcon` is already referencing the `Bar0`,
>> how about storing the projected `Mmio` inside the `Falcon` instance?
>>
>>     pub(crate) struct Falcon<'a, E: FalconEngine> {
>>         ...
>>         pfalcon: Mmio<'a, PFalconRegisters>,
>>         pfalcon2: Mmio<'a, PFalcon2Registers>,
>>     }
>>
>>     pub(crate) fn new(...) -> Result<Self> {
>>         Ok(Self {
>>             ...
>>             pfalcon: E::pfalcon(bar),
>>             pfalcon2: E::pfalcon2(bar),
>>         })
>>     }
>>
>> That way all the
>>
>>     E::pfalcon(self.bar)...
>>
>> Can become simply
>>
>>     self.pfalcon
>
> Right, this is the direction that I do think we should head to. As descri=
bed in
> commit message, this commit is intended as a mechanical conversion and re=
factors
> are left to the future.

Great, keeping this commit purely mechanical sounds good to me if you
prefer it that way (although one can argue that the refactor itself is
also mostly mechanical as the end result shouldn't be more complex).

>
>>
>> And I suspect that once this is generalized, `Falcon` won't even need to
>> store a reference to the `Bar0` (and potentially poke the I/O of other
>> engines) anymore.
>>
>> Actually I would like to push that even further and replace the
>> `pfalcon()` and `pfalcon2()` trait methods by associated constants used
>> to construct the projected view in `Falcon::new`, since the projections
>> are all constructed the same way, but doing so requires
>> `generic_const_exprs`. :/
>>
>> We could make it work by moving the `OFFSET` generic argument of
>> `subregion` into a regular argument and enforcing its invariants using
>> `build_assert!`, but that would require `subregion` to be
>> `#[inline(always)]`. I don't know if there is another trick we can use,
>> if not otherwise I guess the trait methods are ok, especially if they
>> are only called once in the constructor.
>
> This was definitely one option that I have considered, however as `NEW_SI=
ZE`
> still needs to be generic so we're not entirely turbofish-free. But if ma=
king
> `offset` become an effective const parameter helps nova impl, it might ma=
ke
> sense to use `build_assert!` for this.

Maybe we can have another variant of `subregion` that operates that way,
but your call. I don't see any obvious flaw with the current
implementation, it's just that the `FalconEngine` methods should not be
useful outside of the constructor eventually, so it seems a bit
superfluous to have them visible to the whole crate.
