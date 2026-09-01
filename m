Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9C2D7398;
	Tue,  1 Sep 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269566; cv=fail; b=IRYYG2C1Qe2eNmu+w17iSoJxfaozSc0t9Uh3NEVMP5yEzLvCw6Uueb8Ncz/5Yc3pKsDBApv6yMNSrRa4HlNmYPqwVpedaLQi8uEKPpi0a8X+AYhlGxLjiuy422buNtBl3LWtx6Tiv2DCAZJW4I0HOdT9Dqe2Z0sAm4o1EfYq+F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269566; c=relaxed/simple;
	bh=/gYGUr/A3rGaU1pasNl0zqqo9GVt0IZ+59SwhRwMfuU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BZgrrPerz3y8DG38DA8UFPOyTdUV9b0UO4h/Elm2lfok01tATE1kprsRNlJep4OANZNgW5x3z1STpkbU7NAu87DU8LHL+pEIdCzsJ/tb+ZQHyYiR5dQKdiWgvRNzp8KLqsVp75r23Jj2lyyf9IEB5UUKrFz0xktOa9bGsAv1j1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UYfzZB5v; arc=fail smtp.client-ip=52.101.48.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UYfzZB5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcevcwGHgWFpOvx+WRMMaXawvyKNa0jmqTBzOKBvvtiPPtRQzHA56NW0pUh5xNQkDUhx9l7aFTnLVZLoexPQ/fs2Jqx3wDVrFA3jSNc6w8NoDr0bcUHRUNONkWF0DsxvlZ9z/Ur5GdtIls1vkWCdpLGbvMjCmdHzy8tm28fArn4M4IGfrNRFrqZ4W/ixUKL4PDO6yTqbOgH84n+PCEUkcx3AbIzOIfNTDDMVgN5en+ZdtwI/ll/wK8Xd6NYeCySmoYwAjgXBaYQXLtzOU5h/sRl/HsqgyKIf9yvQDv9D+O3n1zi40BVzm0qvriDcnTVMo5fQXuXHsLSCyZAIr1LMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRoo0diEn20UTRVxePTdAAGqTdKFehrCx/C4SSvR52k=;
 b=bMkkVVD5LkD7Zti7LLWV2rcRDy0uszStX+aLUYm88JaZe17/Wi+bejYSb2WgUlR3RiI2d1ni0an+Yqa7kzOh4o/OVPtryKIaibKnk2YRPXv3SU/r9JVDxnCB65IRzCspdoPonRJpYRE8wfgVzW/W3PYNn6bFiNrNOw1Nve/4ck8IeKFVHywZxCHX4Ht9PehfKgW+c866mrYrtRFG0x9HO7EAe3WhYrE4YryCxAT9bkxErZJdGQOw2c+iKUeRnMPR8SNFs1UO/92yTslc0QkmCaGVIoLj/zbEDJKII9GYCcpdnAkea+q7ry0d/Vm6j9Qy3LZ6uzCL0PPxP1993TfL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRoo0diEn20UTRVxePTdAAGqTdKFehrCx/C4SSvR52k=;
 b=UYfzZB5vnV8/UDgmz8MXLa9IhepPgpBnkAUcxfsrhxy43Ok6WjmlLJrilQNBo7hcLHyrY6W7O8g5aTRpkleKROp9K/0UUFq00luZRfeh+89O/NhQOWlDGshapXzLUm3b9zLrVqLQKmBrXyS+fgrFPmBT2snox4ZFXWpDuBM1udfwySv9viVRsBF3WYlKLyeFgK8KtbIR+zVjCYD0s+7fp7XZGp2iMvJq7ieIqOMc865HmrA7M/rSqssnskABFAU41UR7f9EVOh96TTLcYo9IIxbZgcDeqzXT1PPwtPfYZ5vpWFYnOOhm4jhZNMGHO3XkckH76tcx+71d7STJYa1FDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SAWPR12MB999115.namprd12.prod.outlook.com (2603:10b6:806:4e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 13:32:39 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:32:39 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 22:32:36 +0900
Message-Id: <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
Cc: "Sophon Zhang via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>,
 <aiqubits@hotmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org>
In-Reply-To: <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org>
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SAWPR12MB999115:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0951ef-4853-48a1-d73a-08df082d7de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LVwQ9IyYyMuLTSNnbEn9LJGKJrN36SEqv/stX3banR+mq+o4eM+jD1D26Jg78WBEntOuZmsRPoaeQ+50QcHbb68QSWfIu7tZ1IzcYt/kCiXSZyVAun/C8aNFlbbqW+iNZ7/h3RuoU5Gw3sN4pCGfQsliT0oUPJRDdpLDsJ0k91XYFJdUHIAK5KExiN3wWJ5w90o9eWcBfaIdEPuH/odOkD13zlnDitRJD7aTMTxmEtrqTR87O/KD9jwNTale/EZRvhwzqrUlJ144TT1VH/LSssRPCxAijvxpn6zf/6Sf2zzRx668Dvg5ZtVqJmpP5hmcGqkRGieDTaY70LKiBVj5diHNK3kCvBJyZS7w9g4UuUkrhL8bGmL+CpAtKwW1KuzXcGkgsi7iUaEzOWzc+WWuU5Oy2qSp9EiuxmFhKFdmNVb8FnRQy3oCiNFgNUTx8GNbNAeVYCpelH35OnAF8xXeZONE7CpKuaOfhaFLw7DJ2pZCPZ67SKYaJHfyiAVxg2BZw0JQDSMDhbqZc/9O5jrj1f7bDnJgpD7g11swAbic6MLU7H77OzezUb2IRjLhNlpnOHCRi6Wko98i2V2zahlE18ra+d/hOAMJrZr+jDIRvU8ZSnGlFwt/6TsPNjhjh1SffJGaIN3AqnSToTzhdlJzEn0or1HfouGqn+W2oF2aBp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRnbC9nRHZqUEtPWGZNVHlqMlVDTjRtb0VjMFNCNVN3bmxZa25BbUFSTDNR?=
 =?utf-8?B?S2lnRXdvNi8zNXZYNHVGTG9qOGVEM2tYMjV1KzZYOE1EeUIzSFNwWFZEK3N2?=
 =?utf-8?B?blErQllmVGNBTkRMandNZDZZU0xrZ3BQY2EwUVJFc3BSUENCT1JqbGNhTzZZ?=
 =?utf-8?B?aTk4L1dzZmI0UmVtS05IdllvNzMxU0t1bUNpUGg2NGtOcVFCa3NMdkRSUHkx?=
 =?utf-8?B?bHNKa1JXRkdFMVJuY3pVTGV3SHl1ck0rWmxaTk1rTDRrNFg4Qzc1MTVlRUlZ?=
 =?utf-8?B?dVNKdHRsTHJuc3YzY251anlObzVncjlweWlTM3RzcEFKWFMxalBYYVpiZnFT?=
 =?utf-8?B?SjZ2RnlQUlNGQ3FGYUlzcFljWnJNeFpBbEszdyt1d1BIOE5WN3pCazdsZG1N?=
 =?utf-8?B?OUxpV3o1VUMxZDlLTHo4OVRzTTAycjI1SnhNdjE4RExVaVFrNlJCem1pNlRq?=
 =?utf-8?B?eHFmQzc2enJYdW5hcnMvWFpPUWx2Yk1DZS9HQnRQbTRna2J2ZVlEbUF5Ti9N?=
 =?utf-8?B?MHl2b0c1Z2RhUmdtWG9STFoyQmJ6VEgyYTlSemFhVVZvY21USmtHcktaQWFy?=
 =?utf-8?B?UmNJeVlFdjNWbTYwOVlTWG5HMWNPOXA3SWthZCtlNktxb3FTWkhBMjNxbzgy?=
 =?utf-8?B?Y21McFdyRjVZaEZ4NHdGejREbXVFVDF4WmdTK2pyRW1GT3dRVXBoNHNjSVBM?=
 =?utf-8?B?bzBySlNUNEpkR0wySnBJN29TczBRQlkweTczd2FFQTl3cHFqWmN1dFJLa1g4?=
 =?utf-8?B?aDBtZzlQaWs4OVlkVHVhTlUxSGZGMTFLK2RIcjBZWHFqZ2VqYjhYd0ZXWnBn?=
 =?utf-8?B?U2tCcnl4WUNGMys1OHFYaUpQbC9jM2Qyb2JYYVhhTTNaelNpV1pRTkZyajhr?=
 =?utf-8?B?TVNoeDdpWE1NYkZickFQTXpabkVwT05RVDc0aWF1b3MycGtQVDU2dnB4M0xL?=
 =?utf-8?B?ei9IaWd0VnhYS05ndHJ5WTZuK3lFak1vMS91YmNtV0RRTXlzWFM2S2hpOHdy?=
 =?utf-8?B?NkRRbmdOMVgrc2xBUGJ2VW1Fa3ZuZFpYTGZvWXpqaGNNOVZWY1l0TjF6RVVo?=
 =?utf-8?B?NmZ2RndzTU8xRTdOK3hWNDV1K3hzOU93bDZwb2ZrT0ZtcU0raUpRM0h3M1ps?=
 =?utf-8?B?YVJ6enpYbHF2OVgxcEJyWGlBdjJOc092QUxmTzRYZHJRcU5iSVdTZVRCbTN2?=
 =?utf-8?B?SXZ6dlNlUW1POTdIcnBNZVFNUy9oRE9TMk9NdHVycGJBbnIvRFdFZm9vYWhs?=
 =?utf-8?B?SU8xS3dGTWFXMTVLN0hiSEVISjVkZVJVZUVDSmZuQlNFc2JEcWVHeC84d3lt?=
 =?utf-8?B?eDlZRXZlR3VlNjl4TC8wZDdIM29MRmFSV01aa2ZzNndiSHFqRnRUWjJZekpY?=
 =?utf-8?B?UW15NVpVazJoUndtVkhIY3dzZ0RFdk9kbVZ0bnFtY1hqZSthVkJmYTBuQjg2?=
 =?utf-8?B?d2x1dURRVWxJQ24zZGxZQkJiV01PWHdERDNBeEh1NC9BRkpRU3FpeHRlL1E4?=
 =?utf-8?B?WnIzdWwvL3REeFE3TUptM09wRm8xT3BpamdpcjlhaGRRN3k1QTlKcU5peDg2?=
 =?utf-8?B?SG5wU3pmTlBGc1l6TDRZMlAxcG03SGlWMi9rajkrRGQ4REJVK2tOUTBVNVFS?=
 =?utf-8?B?VTRNbThjQlhhY1lpVnprK1AzYk1RZldMNHMxcjFuUWZvendBckZMeEhlZWpR?=
 =?utf-8?B?elV2Wng4amMza3gyNWxMbEp4WWJXTU9ZVVFXaGM5T2FMSzJRdWVub2pMMTRt?=
 =?utf-8?B?Y0FwV2szbXQxdERBN2JDZHVoTHhLZG1jRjVGdm10Tk12K0lEVkF2KzJCeUh0?=
 =?utf-8?B?b1ExVkFMeHZLWGdDSDhva3lrYXBaSVZ1VGhmNjNhYTdUb3pTZUlJTGlGLzVS?=
 =?utf-8?B?Y25KWFB2TmR3cy9DWDNoL0IxQXA5dGtpbkdybzdmK0pYcisrS1JNTWRKMW82?=
 =?utf-8?B?TVpYOFg3N0lxWEIwUUpQL04yTXhhWXJYalJoZ3RjUDdTajR2YVlzbmkwd3NK?=
 =?utf-8?B?d2tMU3VLVkxhSjhwUTIxZ2dBWnJsOHhkTlFFMVg4WUh1MkhIbmk5NDFUWWZY?=
 =?utf-8?B?d2lUL3FjNmV4bFN0S1hWaXE1NlVMN0hWcXpoYms1V1l5Z2pXVDFDRDU2TUEx?=
 =?utf-8?B?V0VHaWlaZk5yOHg5ZlZRQlB5eW9NWnFlbkl1WEw3RmNHWW1BUjRJSmZmWWY3?=
 =?utf-8?B?c05vZUJvWTQ0SGVpMVhqWkU1Qk5xdkJsQUZVU242UEJER0ZaRlZ0eEswdGRZ?=
 =?utf-8?B?OTdsNHNQdndwWHRrcy9FRXg3Ly9nYTZqb1dzV0NWNkhmV0x4WkppVldyUVUz?=
 =?utf-8?B?c0lkSUJLWHNKckhEdCtkbm5ieEdGYVlQK2xoNVIrTnNtL3R2VHBCQkJVcnZo?=
 =?utf-8?Q?iNWv4MzfElFyoVPOUNFWEoT4FjjVvPz7QL0snCKg9gnhz?=
X-MS-Exchange-AntiSpam-MessageData-1: L4JL6TlDh+PdRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0951ef-4853-48a1-d73a-08df082d7de2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:32:38.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toTxE1mZHUgNK2YLKZ9EwqwMr88ohgF5uS+MB3O9sLPltq52XKR+gDQtaHcv5N1bywrs613xTzZMpq+PtAE4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999115

On Tue Sep 1, 2026 at 8:08 PM JST, Danilo Krummrich wrote:
> On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
>> That makes me wonder, shouldn't we make `index` take a `u32` directly?
>> If that's what the C API expects, it does make sense to align to it
>> instead of forcing users to make a potential unneeded conversion if they
>> already have a u32.
>
> I intentionally did not do this, as the common type for an index is usize=
. Thus,
> I do not expect anyone to already have a u32, but to already have a usize=
, e.g.
> from some iterator.
>
> The fact that the C API did pick unsigned int as index type is an impleme=
ntation
> detail the abstraction should bother with.

Thanks for the clarification (and Miguel for elaborating - I wasn't
completely aware of it!). In that case this patch looks correct to me.

Note that there is another `as` right after, in the same method:

  if irq < 0 {
      return Err(Error::from_errno(irq));
  }

  // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from this=
 registration.
  Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u32)=
, self) })


We could get rid of it by replacing the `if irq < 0` test with:

  let irq =3D u32::try_from(irq).map_err(|_| Error::from_errno(irq))?;

Sophon, if you feel like doing it I think this could improve the patch
further.
