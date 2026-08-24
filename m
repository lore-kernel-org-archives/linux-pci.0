Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565945A2A0;
	Mon, 24 Aug 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588711; cv=fail; b=KaTKVAU/i8xlfoHfxr3xEmwBN4kkeu/x6brcCyU/2LnHv6r4T8bIUgHhpbNFxCfWZv9M3NfR2P1DgL4VQTmjseFZE37fwFI7zqgD1exPjxJwcLwgIgN6cxZc+Mbs2rWc5RzTFZlJoiU0y/CF716kOcfCw1isy9bYx+7wAl2J1NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588711; c=relaxed/simple;
	bh=TebHr+V40ERWo1vbaVhgkTkRsWjmqCRveud7mgu0BNw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jb8xo88EfoYP1PynWN2VnBQL4tyqgABg8OFg/JzJjLNbkcu5vbmUUPADPPeFnL4eSLo6pwHRtHhMbAyC8W8EsMvtdamg0hG3tAbEgoT9daG0ATsYPrxXKKOolAjHspqZateNHdsHE7lqWFu69HwGxKlfwMTRJxmIpOGNO4aVYos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KQkWxeby; arc=fail smtp.client-ip=52.101.196.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KQkWxeby"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmPi53/uYYLtORbwVMLBDKldHvr1l+AoD+jTgLq/uwFrpAe0IfXgQE6a1i0hC67kyyQN2RXgi5pIPTBMfPYM8z57iecUqz0a6WZazqlYlug8dnGM1178GjU/Z90YYsUofo/5J1Y/jm1QRbBjMceQR7xla/0DEIo8P8g9bBXi+o7j2ajI+64GL9VSwZzDAbR7vi4k2kFgLcHOw1rz+HR9DMCVgcxrxNr9S4oycS4KxUvvQv25qZfk3u8YwTBwzoWOdGO4aoOtsb5xgyNSq7rFV7XB88Bq15Rh05UmMLV7mAJnfkjfw6tp62BBL2avEVI/a8e19h/AJgelrS2i5G3afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TebHr+V40ERWo1vbaVhgkTkRsWjmqCRveud7mgu0BNw=;
 b=XNbgJNMkzxj8o6eb2dj4AzAIVsEY7vvuTseQnDKjnlrb2eCbKl44LbCfNdFxQ/O85LVA39dS2xNNWK3Ctc/ZWEwQPBiUTogWR/awxuZ8cRfvMEtU4eZpezGuMWIhS0vi20lrG1D+bkGBAT5qiSnZfi1RWJKAlA5Gtg3v4+/HzbTFihugGZfvLnp7JogwslDoQqq5yEPiK3/o0bkO+0vWIQD5lumuKqB/8rD7aREmr7SOykg1NkAGT6RDth1h6TkRyQ595Qefgy6LdA2TlOM88NNFiwMQP5dzSdJ9kHfFB4xLdINEy0t0r+QX5zmDyRwIpEzvs1xTADg9j55oJVVnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TebHr+V40ERWo1vbaVhgkTkRsWjmqCRveud7mgu0BNw=;
 b=KQkWxebymEP3xB21dLqkD0auLGswYE7M2NGjjyAoh/w4W1KjgckV3R57rY4KYUnPSwZiYJ3waYPXYJSCtythb3/khKmoQb12omf2/yh5j+opONzsSOzu3psWDpSRVfPALntLgmLWCVm3eoKEfeHrEhluBqEVX+YwiivrieXM1Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2148.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:60::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:25:05 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 16:25:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 17:25:04 +0100
Message-Id: <DKXBB60UMR11.2K7YBARWX33Y8@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
 <DKX45Q1J5M9O.27TM3TUTQH761@garyguo.net>
 <DKX4P05VHT0E.2O8M39SOVBVP2@nvidia.com>
 <DKX5NPH3DNJR.2MADBU37NMZB4@garyguo.net>
 <DKX9YTDJLJMI.1RKDZ3S28MVQ0@nvidia.com>
 <DKXAHMEKAJPI.316SW0ICNRS0A@garyguo.net>
In-Reply-To: <DKXAHMEKAJPI.316SW0ICNRS0A@garyguo.net>
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2148:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b2d697-5666-482d-9e91-08df01fc41ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|5023799004|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hT7CB8VoeUr03Gu5uWdfnSuqqN0fW0AtKXStssuuWdbqN0JSqLAYzUHZd8Gf3GqsfQzdis+t7EOPvI0MeTNY4WRF/s5hQeW7uVJQquhnYhxl+CqquCm+8X2DoHq8Fi9R7hbfPBYlqpMT9mlH+FEqyuSxZuOdmWeoGGSMa0rtFERPonkYicYDnfn8dzM0YM8gA9BBzbkf44k/IQtmvasPx4JrZQg0fqyA5NxX9m/skuy+oIl0NaR1ucmgdflX1EDnrGbQOXsWBuznKDYCwRMiQkNjShBBZNU8INIIdR8JPFqf7MZc2fQOHroD3GXtwtOMGiYPV2kcIjiwnkgGv4eX4FnaiBALb0Tse2tHDmm/kI8xDgVbXwpbuTvLLc1FGG6eg6GXz2UU+GB4pVyvL1Brt5CvB/wnC5OXzITE75I7O5puPzxtE9miFSQdCzP9KJ3KfvLmQZ7ErjJu9L013Sbhj2DNVML/x9ismAeEA7DKmRAUawNpYE4nNUcjtrCsRjduwLoWZE2iO75C0fWI9Es/65jYsTePs+ewhEWxky2hztT0Ied7zUzkS60OlyHzNpQkkliFhCq0I1+KG4bYlEW+etFx9xNiow2/0NRmjMQj0IOGBT2WttL/1J0xnTx3ot86FY30nWy1h+Mn96VaWPZmd+haZ/n/zyNwJAcbI77ZFHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdhQVRiSHpmeTZ3c2tMeE5rK3g1OHhpZTM3eDBuQmhkcDlIVzdoZlNQSXBr?=
 =?utf-8?B?aGs3SEhZamh5VzI4azdLZmt6Q1UzcEpnRllhcEZrY0ltNzJ5WnRJaHBBWDQ4?=
 =?utf-8?B?YmZ5TnJZaDFkRFJyWU5iQkFlamk3bzUrekZuTWNPR0E1cE1hajJYbW81QTZD?=
 =?utf-8?B?ajJ5U05BeGNCZHY3R1ZLdnY3Nm0zN1JjZ1MyMlp3WUZkWFkxNlFEU0pIOG01?=
 =?utf-8?B?WExyRVdhaW9CN1Y2Uk1iYnBMQUdrbExnNUx1Zi9PTFlvNVhua1BUczRyN3hn?=
 =?utf-8?B?c1hTMklNNzdYREhyRkgvTGN0MXZna2RJUVlLcnN2czRCYUgwUnFhVDlSWitt?=
 =?utf-8?B?V0RIVG5XQ3JkVU5mQlk1NWx2a1NraGY3OEdzRkZORGdXMUdTYVRBZDZwT3gv?=
 =?utf-8?B?THZBM0RqNytiVTJMMnd6QXNzRkg0ZjhuWXNpWWN1VC9Ga2tPYWR4dFVKY2M2?=
 =?utf-8?B?a0FaWkhSRmczZTlLbkNTRUh6UmxybUlHNzBwYVlMR3F6NVZPdzlOR2VDOGp4?=
 =?utf-8?B?TWJUdnVXa3JaUEQ1OHl3djdjRzAxOTJUdGpMc0Z3S01VSFBsVmFiek4zc3RR?=
 =?utf-8?B?VVFNRy96ZEl5SFdNTFB4aTQwdG1FZWxKb2ErWm5LZjNDNXBuREthcVpVcktk?=
 =?utf-8?B?Tjhhb0wxQW9EUkVub3oyNzhxdU1Xd3FwUXhrWURpQ3o0MTZvaDVTR0dLWEpa?=
 =?utf-8?B?RTRlblZEUTl5WDJ6U3pURTFWb28xbjc3QjB3amkvSjliMk53dVRHWTVSRkZP?=
 =?utf-8?B?WGtLUS8veGZSSUpEck5KNzRSZ0tiYUpSb1RmWXJZNkh5citJVmJpWnhwVTN3?=
 =?utf-8?B?eklCcndDd3Z3aEw1a1J4UWVQczNWZ2VKTnc3MmgzSWZHeUlONHYwSjBQWml2?=
 =?utf-8?B?WnlPKzNxb0lXZGMyVXQ1YlBoS0hnMWlKSmUxMElCUk9za1NGMVZmS3F5MTND?=
 =?utf-8?B?U1B4S2dlUVRTcy94VmZIeXJWMUNCZHRhaVZUVlMrR2ptczJEcGVKOWN1ZmFx?=
 =?utf-8?B?em10cDZ2WTZGMVhQV0NjYzVCZGtYVTRkcm1PUTQyYXBrK3lKVmRJekNiNDRG?=
 =?utf-8?B?bm5BT2hDbUlMN2xtMVEzbVViemRxSnQyS3JhamQwaXdUODlmMDJraTBJWC9h?=
 =?utf-8?B?Mnp3NjE3Rm9jSFlCZDN4YUJZU2E3MjA5WmFQR25QQWkyWm52czdOSzYwYm5i?=
 =?utf-8?B?U1JFUEN1QXlTMWlLSlk1aUl5cmJ5bURZZERENTkvN3BYRDkvdllSeEpRU3kw?=
 =?utf-8?B?Zm0wTStxaktXTVZxQjRkaGVuaDEvY2Rhd3dXQ1FNWVpLdUxLSlVCQ25zQUNP?=
 =?utf-8?B?VzF3L0pmTEF5M29vb1p2eVZuN2hoL2g5NVJnWVhyVkpFdEFoOWtCb0VnVVlT?=
 =?utf-8?B?azhMUUdaOTR5MDFJWlJsS0NmOUI3U21iS0szdS8yNEhlL0VRR0JZNEs2WE5J?=
 =?utf-8?B?R1EvNDZYN2x4aytXN0lMWjhKblMrU3IzMzFNWkd1ZDZoMy9OcnBmMWVVMDdM?=
 =?utf-8?B?ZjhhWUpubG9rY3pyUzhrbXcwNzVIWmNQT0phdm5NOGd6SXRaSWQzanNHNnpO?=
 =?utf-8?B?Q2t0dDNsSjRrTjZVMnhmV2ZiVXVMUUptNlcvVXpZNG1TZjJUQXBZOTB0UGRs?=
 =?utf-8?B?RW5DOVNUMVFyZlNnakdjSE1MZDRubGFrZ2RRSTVRemM5UThOeVdRSXVteGd2?=
 =?utf-8?B?ODRneEo0dnYrMjNkWmRiWHNmMjNrSzV0MXJra2NTWHV5WEMwelo4K0lTZUFV?=
 =?utf-8?B?N250SWFxVkF3OVI0eXJQL3dYekQ5MTlXYVRNYkJDenFlajNhQjZXUHpEbmJL?=
 =?utf-8?B?RkREWjBlQXR6dzk4VWtJMWJyTW5TUnBIbmpmSDNkZGN5ZkRuNzB5L1VlbnFE?=
 =?utf-8?B?SGpwWGlmNkJqRXU2UFAyWFhxWEJTRHVCN1JjUTB5S0NJMkNBSXJGYWptbU5H?=
 =?utf-8?B?Tmc4N0c2VU9UQnRwZ2xQcGtnT0x0bGtnQTV2Wi9aM3luc1pjQisza2JMUVhR?=
 =?utf-8?B?eWQ2MTRXOWtMa0thUDR0dmt4NkRtQk9McFFNVU1RaXFvenpvZmFQK2QrZlhX?=
 =?utf-8?B?MzJrOHNndzBWZ01DK2ljODJycUZLbWI4NExYSjRmRFZnckRlRDk1Tm94bC9a?=
 =?utf-8?B?UHc0K1ZDa3FEaWp4UDFWTlo2MjZCY2NPN0NjeUZkVEJldEdsY1NKTlNGeXlM?=
 =?utf-8?B?V3BQeTZHU1NDM0lEb09NMkZyT3ZrVGxXaUxQZGlTL2dqQUN2VlR3MWhtUGZU?=
 =?utf-8?B?c0h1NGRJOUdBYmZSZFJxWDdHUE5PUjNCZm01Q0VnQ2lab2F4cnhOSHc5K1Mw?=
 =?utf-8?B?bjVrTUlkaW1CNGhvNzIzUHRjbUF4Y3JNM1IxUjhyUXIvdDJBbjZydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b2d697-5666-482d-9e91-08df01fc41ae
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:25:05.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UZYJei75lMh52z1KBhbNGeazFKy3zMUaw8ZKeixNFqkfs+wtm0c/lFdMq2X4SO3Fon7FafXwXgPbXt7k/yhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2148

On Mon Aug 24, 2026 at 4:46 PM BST, Gary Guo wrote:
> On Mon Aug 24, 2026 at 4:21 PM BST, Alexandre Courbot wrote:
>> On Mon Aug 24, 2026 at 8:59 PM JST, Gary Guo wrote:
>>>
>>> Aesthetic and ergnomics is a big part of code, and is what make people =
like
>>> Rust. In a world where less code is produced by human, I think it's esp=
ecially
>>> important that code remains easily human readable.
>>>
>>> You can probably already tell that I have very strong opinion about thi=
s.
>>
>> So do I, and the fact we both have opinions on the matter is irrelevant.
>> "It looks horrible" is not an argument.
>
> Ergnomics is a perfectly valid argument and often a key factor in design
> decisions. Otherwise we'd make all functions carry extra argument indicat=
ing the
> context they're in and would require sleeping functions to carry such tok=
en
> types. We rejected that approach because it'll infect all functions and m=
ake
> Rust code look horrible.
>
> Everything is a trade-off. Whether to perform extra validation vs better
> ergnomics is a genuine thing that needs deliberation. A outright dismissa=
l of
> the argument is itself a non-constructive argument.
>
>>
>> Safety and correctness are the very reason for using Rust, not that it
>> looks better or is more ergonomic. It often does, it sometimes doesn't
>> (see the hoops we have to jump through to cast a pointer for instance),
>> and when it does, that is usually to improve correctness, not to
>> compromise it. The reason we go through these lengths is to remove
>> issues and footguns at build-time, and this is exactly what these
>> helpers do because `as` is one of the footguns.
>
> There's nothing unsafe or incorrect in using `as`. Your suggested code is=
 no
> more correct than Zhi's current version. You just added some extra check =
to some
> constant that will never change, and we know will not produce error. My a=
rgument
> is that that makes the syntax horrible and it's not a trade-off worth mak=
ing.
>
> When we create new abstractions, we try to make thing has minimal overhea=
d.
> Otherwise we'd be using a GC language and that'd solve memory safety issu=
es.
> Your abstraction is not zero-cost -- it sacrifices compilation-time, bina=
ry size
> (for debug info) and it adds a significant cognitive overhead for writing=
 code.

The code here is const eval, so debug info doesn't apply. And for the speci=
fic
cases of functions containing only a single cast, as all instructions are g=
oing
to be optimized out debug info should (hopefully) not be left too. However,
metadata sizes would still be larger because rustc record all inlined funct=
ions
within its MIR.

Anyway, this is really more an auxiliary point, my main focus is on the
cognitive complexity.

Best,
Gary

