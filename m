Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020121.outbound.protection.outlook.com [52.101.196.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445973E3155;
	Tue, 31 Mar 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963164; cv=fail; b=TPwtHLKqwMr7I/3EVLIwOOmkCdjQHeEJQie+aaM/cvs2syQzTJwBsOaM9P4XI7NB+5BOKAOV/1VNwr8nzJ8Jfm1gta4wdOxurtjh4ZOpQZjmYRtjX1SnZ1gapWzEouamzo8VwE+uQUmMh3PMhKcXgVL9+JBgz3Zij1hUkk/uOZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963164; c=relaxed/simple;
	bh=1GpkqAVV6m/PWxnqfPC7FqMf8gXC4lwiiJnFAdmvi0w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=D8NBIj935b5HSNiiSi/ec3MT4sLzrJE8FK9PwN+b6kpx8rKPKZnxuItGArnB1UDz8f/nLKh6YnDio1SuCKVww2ukd1wYvRjFvAikME9rHnmHyv6SKluSC9eCLkqPTYsapUQIHh2EhlcKxUqPbeWpvyHEg7n4Mycpp8lNcY8kntI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=s4WW11ST; arc=fail smtp.client-ip=52.101.196.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="s4WW11ST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeUgKpLg4W+mDxmuSdfXwl30Akl15jbtJcjE0X5YVzJSpWOKZbjB8RVrnGUYCq7IVzKNaM4rorIT9YUnsyoywN8zA+Ho0l0+N907kETMJMZ+Ev3KnZZ7/S3fDh3lpNSYVcg/G+9p+TzJFcXoJ4+8SDQe6PX14joR45y0lBG0yVDYWYfAG+/G+Z40LxZU0Zs7V6ik2h+JnVez+c2ZjKkTB5JVM3PmpdbDZGhFrIPc0pKEVhRZCrFnmw9kdp831SeNb7mPKdWkwU/jBBARrhY20fbNkbdgF1YiizDe4AI7QZpYuIjc0d3HF82KTMdHeBIV6kNBgzubqodrTeECdWBOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEBwTru3iMRP7ReZRIh0Fbr6YXWGEJlgjjc0FHtM9G4=;
 b=ivykh13iZ5wE5cZlldg6BqYYidoRFp0Q3iGGXx2TJPUDpSA8TQ+5a15swU+Kn9G6NXf1tiFwVrmd8y2f5yL1O0D6iiIwJ5z0tzZRkLgK9gz46uY7YR0+9nj8cffwBR9ltN+t74olBlFmyHw91mdr6DCQVEdCuWzc9KiwX0eD6WFfoDOJ6OrVQXfaBcyj/kgZ2qGkoPXAX8lBS1KOWm4BH6+flTJfY6oor9AsFUJNa6/NO0Bpzjds6UFfj/Ltf0OY0edbBKXU1MEmMyMFi5OlQ37EiYaLHTLpAASjfeNu9CsFMkC2gT+C3qdYxY8/kWaf/bICOElqC18Y/cqTxL7TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEBwTru3iMRP7ReZRIh0Fbr6YXWGEJlgjjc0FHtM9G4=;
 b=s4WW11STEHmD/SiHu0tCAsqfMqoQ2bI+9cI9fWopFZKFDD7Hec0v6SPVMVpSj47IbRP0IVM73aPi6+lwxDH8z7/N2VovdRB8AsSOjCegwHtgzmYrUAwiccWDhJ2LcRNbbTSzKz3tILlaEUmirHPhqH1E8jubGmhJD+ARq+OTc78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5336.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 31 Mar
 2026 13:19:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 13:19:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 14:19:17 +0100
Message-Id: <DHGZXDPKEDAU.1DX1Z6U87O8XS@garyguo.net>
Cc: <bhelgaas@google.com>, <lukas@wunner.de>,
 <rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
 <benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
 "Alistair Francis" <alistair@alistair23.me>
Subject: Re: [RFC v3 16/27] lib: rspdm: Support SPDM get_certificate
From: "Gary Guo" <gary@garyguo.net>
To: "Alistair Francis" <alistair23@gmail.com>, "Jonathan Cameron"
 <jonathan.cameron@huawei.com>
X-Mailer: aerc 0.21.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-17-alistair.francis@wdc.com>
 <20260303145139.00007b80@huawei.com>
 <CAKmqyKNrP6Ap-0Jy-uaYKM=7W3Fiz8WtdG=JWV4ACv=2weS5EQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNrP6Ap-0Jy-uaYKM=7W3Fiz8WtdG=JWV4ACv=2weS5EQ@mail.gmail.com>
X-ClientProxiedBy: LNXP123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::31) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec677c1-6e35-4978-02a2-08de8f281d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xpK7k9Q4IyRi6ccwlF6kPwr8S9xLQrAB7xAfGSgkLB3gQrZsCwtNFdUXTNlVYSpuR1eWGgyit0gAR7WLs7VEdnEW6qOWgiSaX4Cg38Defgxa5jFrPcM6GtQKfAVV10AX6gxxAjzKUOEAb+EI3rOlZsE++f/18O+VbCsJ3Oi9FEdtLTGYQ4RJcNg5I0yYJE9Oyzk2F2ZFHXrTgIASmVnn+yxTE7n42v3BDDVq3zPc/3P2wZSFr7oTq836TbjJdTEfExzkK29Eeh0Or8cwVTUsftinFMQLzQTEka30+unI4pkZ8OEqmWtENWbokG8OHFdypPfw+j5ydi5tyC8b8kas+eMUpIoSm5NxTjtkhEpP+11ZeB3cm54kCLYM+wKGCOlhrA8XCj0xXa+NDOqqZlJABqM/peYxHXS7IJJcPiRuAGQjfnBJ3im93CeD3nJCItj55l7PuIvVnoJCXpHZQnL9DK3qsorKrDjbxoF4t+cTjKHKT/QWbpVRwL8m0mF5h4jOY5N+SIcf2RXCedujkhkZsCHFGpGG5/tsQOroSXdhIWbPU+x3p5Mob/NGGH0t02sdapeMCjmjW4B7MtTOhqJPyM2fnx7yraLSvFwieecw5Nc+zK3DUOIFji6mHmjN+exybhcjtl/Mngh2oSMJWXTcH1WRoythtsYgsculONlfOcEWavPG/E7n7vvXzd6O5qRamZtZlEpkc0erA9nlvispv+tkzfBaqg9H54Kfs/mRLDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0s0ZzhRbXdCaU5CRWVxS2FSelZxM2JxSmUwcEI5Ykp1OWtKQXdzc3V3anZ3?=
 =?utf-8?B?bDFJcDdXZjdET2FRQ3V6VGMySVRwQ3FtdVJQVTY1SFJuMkRpNzg0VDc0Tzcy?=
 =?utf-8?B?NENpSEFHSVpjMURxMnV1OGhqcmhiUm9qOTZaUzFLbmc2elVpN1FXSW5COFhx?=
 =?utf-8?B?cHF2LzQ2b2R5V1VhYkxKemU0b0s2ZVR6VFV0NVh0TlhpaCtWeGI1QTRQTE1B?=
 =?utf-8?B?aVlCckNuUG1hbVMxa3IySDNwZS9HVXF5aHBsdEplMEZQNEhSQUR6SVI3YTBk?=
 =?utf-8?B?SjNJOHlvSzVnRC9NOUJxUnJvZ2FFVURpV0Fkc2dheU5QWEVMYUszaERmbGll?=
 =?utf-8?B?aVZwazkxODRCTTkyVG50MnovQlBSMDYzeHlNc1NBOHpaOEJZQU5IUlV0dU5y?=
 =?utf-8?B?ZDdpMm43eXBRUWFIMm5rbUVIYVVkREVabkRNMHRURzQ2em96aGYwemtnVjBp?=
 =?utf-8?B?bXRUd0ViVXFDd0pMeFgrTEorelZOMHZCQ3VQbEtqWDQ2eHVXenNPb2hycmE2?=
 =?utf-8?B?RlJMcXBtbzRHcXpKaW5KNnFCdjdCdEgrU1FReUM0OGdOa3J5VGNZRGpjRUhl?=
 =?utf-8?B?b0JNWkVQYWs1QitFWVZZZnF4ejBXcjF1M3V0ZjU0RUU1TWpWSFFYdlViQUNZ?=
 =?utf-8?B?T2tEeDR2NFdIVllOcG5MSktYblJqV01Ec0ZkZWZpVDYrUTVQTXlWdDRiaVdu?=
 =?utf-8?B?OUxGN2Nab1lWeVhzUG8wd1UwclN3Yng5cDBmQkpMVTZSLzRnRCtiaE1rWFgr?=
 =?utf-8?B?aG9qNFFzREI4SjFNSng5SXY1QW1yM0Zyc1dPZXJmTVpYZlNLUW5yMTB6alY5?=
 =?utf-8?B?ajdneGFjUUlwT0UvZDkxSXczNXVOazVnVXY0ZldSVlljTlRYS3JFaW8ySE5t?=
 =?utf-8?B?WWk5RGppZDRhM3ZPYVNhaGZrQWY0ajV2U09qWkNCN0p2SWlHMFdsUjNsZEwz?=
 =?utf-8?B?TlozUkhmclFCZ2hSSHhucDFJa3pyWHdLcUUwbzI2WU1XQ056dUZtK2NyMmk5?=
 =?utf-8?B?cFFzM0UyVHB5c0owQW5jMEZHTDRaR1ViVjNYNWVrMzJERDJzNUw4OGVwWE5h?=
 =?utf-8?B?SE5vV1VYVUU4Z1R4ekw3YnFROERDOTVrTGh1ZWw0TEtKMnExMUJGbGJSM1pN?=
 =?utf-8?B?TTExeUJVcDUyMlZOQ25XK2grYXBvOVNwSlNmclZKYVcwbVFRczhrU0xRd2dk?=
 =?utf-8?B?cG9ydkFySTRzdmZhc252TkVLZEk0VFNGZjc2L3NhOHc4K3FORzBJcHhaSENy?=
 =?utf-8?B?Qmt4SGRPdVdURi9NaTcxbWs1TUlZcFU4empsTU83R2drSUE3b1l5SThDZ1JM?=
 =?utf-8?B?OVMwdVdqOGZBU2dKKzVUbENhODZFaXJtTEY0M2RDNVl2Y0lVU0xZSXhrc1hs?=
 =?utf-8?B?eHc2cTlRVXl0WVBXR3dWNk1EV3d4SEpBS2NDMXp3KzdXVnJsdVNyWjVJQ2RJ?=
 =?utf-8?B?RFlTSUcrODdFU2paQUJIemxkbVYwK2xzbGVUZW44bU1GcFdNdlcvLzFFbVk0?=
 =?utf-8?B?dTR6VEp5cC9pbWt1QTVXOEg0S0hkRm5scUwvS0RYY245YVFUempqVThPd0RI?=
 =?utf-8?B?ZHdzemxjMFc4TzRWMnNDNm02eEJYMHFCUDJUY2hzMXJnZ0NtVXEzejJkUGxJ?=
 =?utf-8?B?NXFMd2VZMk9MckZzRjA4QXlpNkRINU5POGU3eGdYUFpIQnBzdFBoV2NmOWJ5?=
 =?utf-8?B?VExPZThMY2lqOW1wNTU1SXhlMzhmcjNpYUVIT0M0Z0ZTZmR2ZkY5aTVhcEpJ?=
 =?utf-8?B?d1hpV3o2ZUQyMFJTb1M0eVZEU010SVZUU1lZOXVyd0FGa1FkYVVRdEFJTGx1?=
 =?utf-8?B?SS9FSUV5NnFrYk1SY2VGSUFLWS9wNnhKWW0xWTFXNGZBQXptL3F2SmhwVGlI?=
 =?utf-8?B?M3BRRm4rR2dSbk1FT0g3dUc1UDlUZjQvWko0YksvdFRxRzBib3NXejJHaTgv?=
 =?utf-8?B?ZytFRDBGSTB5a01nTWRJOUtrRHBJL3dLWWQ0cGoxRWhIQ1kwVUc2a2pXeWtm?=
 =?utf-8?B?a0FGSmV3OExLY0NSVHo2QnRibjh0cWxYMlVIcVBBSU5wQUE0S1pXemFmVWdO?=
 =?utf-8?B?ckxkT0Vsbm9FQzBGZnBYd0dESnY3VFR1TDZoQzV1WkozWWxsc1RvRGd0eXQ5?=
 =?utf-8?B?ckxvMkUvSFNPM0g5bjE4WlZncHgyQVJRaHZHNVZEVHlmQU9tT0JVU2dabFhn?=
 =?utf-8?B?R3ExdkUvTnorRlNHNXhBbGQ2WHl5Um9JQTdJc0ZxRDcyMm1ScElvcFdoTlVC?=
 =?utf-8?B?REs1anNKNGI4cTlCL1EvdG0zMEIxTk4zQzdsb3dZZEdQVUNreFZqQm9QbmFj?=
 =?utf-8?B?ejRpeEFoU2UvcFFBaW5taXY1eC82UVJ3dHRQeVZjRUZYREdxamR6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec677c1-6e35-4978-02a2-08de8f281d08
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:19:18.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgq6nQo3Yo5gcro4F0QyaOMFMRXYwnlxUd3FxmOexByladHrGII3IDxd1JlJQkUFALnJ7S0vrbrHsEsLKGUhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5336

On Tue Mar 31, 2026 at 3:37 AM BST, Alistair Francis wrote:
> On Wed, Mar 4, 2026 at 12:51=E2=80=AFAM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
>>
>> On Wed, 11 Feb 2026 13:29:23 +1000
>> alistair23@gmail.com wrote:
>>
>> > From: Alistair Francis <alistair@alistair23.me>
>> >
>> > Support the GET_CERTIFICATE SPDM command.
>> >
>> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>>
>> Minor things inline. The endian handling in general needs
>> some care + possibly some tests.
>>
>> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
>> > index 2606b825c494..1e5656144611 100644
>> > --- a/lib/rspdm/state.rs
>> > +++ b/lib/rspdm/state.rs
>> > @@ -26,8 +26,9 @@
>> >      SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11=
, SPDM_VER_12,
>> >  };
>>
>> >  impl SpdmState {
>> >      pub(crate) fn new(
>> >          dev: *mut bindings::device,
>> > @@ -620,4 +629,118 @@ pub(crate) fn get_digests(&mut self) -> Result<(=
), Error> {
>> >
>> >          Ok(())
>> >      }
>> > +
>> > +    fn get_cert_exchange(
>> > +        &mut self,
>> > +        request_buf: &mut [u8],
>> > +        response_vec: &mut KVec<u8>,
>> > +        rsp_sz: usize,
>> > +    ) -> Result<&mut GetCertificateRsp, Error> {
>> > +        // SAFETY: `request` is repr(C) and packed, so we can convert=
 it to a slice
>> > +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec=
.as_mut_ptr(), rsp_sz) };
>> > +
>> > +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
>> > +
>> > +        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
>> > +            pr_err!("Truncated certificate response\n");
>> > +            to_result(-(bindings::EIO as i32))?;
>> > +        }
>> > +
>> > +        // SAFETY: `rc` is the length of data read, which will be sma=
ller
>> > +        // then the capacity of the vector
>> > +        unsafe { response_vec.inc_len(rc as usize) };
>> > +
>> > +        let response: &mut GetCertificateRsp =3D Untrusted::new_mut(r=
esponse_vec).validate_mut()?;
>> > +
>> > +        if rc
>> > +            < (core::mem::size_of::<GetCertificateRsp>() + response.p=
ortion_length as usize) as i32
>>
>> As below, I'd keep the type matching the spec and have the little endian=
 to cpu conversion out here.
>>
>>
>> > +        {
>> > +            pr_err!("Truncated certificate response\n");
>> > +            to_result(-(bindings::EIO as i32))?;
>> > +        }
>> > +
>> > +        Ok(response)
>> > +    }
>> > +
>> > +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), =
Error> {
>> > +        let mut request =3D GetCertificateReq::default();
>> > +        request.version =3D self.version;
>> > +        request.param1 =3D slot;
>> > +
>> > +        let req_sz =3D core::mem::size_of::<GetCertificateReq>();
>> > +        let rsp_sz =3D ((core::mem::size_of::<GetCertificateRsp>() + =
0xffff) as u32)
>>
>> Similar to earlier comment, do we have U16_MAX or similar available?
>>
>> > +            .min(self.transport_sz) as usize;
>> > +
>> > +        request.offset =3D 0;
>>
>> That's the default, so worth setting here?
>
> I like being explicit :)
>
>>
>> > +        request.length =3D (rsp_sz - core::mem::size_of::<GetCertific=
ateRsp>()).to_le() as u16;
>>
>> Why store it in a u16 if it is le16?
>
> core::mem::size_of gives us a usize. So this ensures it's little
> endian then casts it to a u16.

This is broken code then.

In BE architectures, `.to_le()` flips the bytes around, and you do the trun=
cation
*after* the byteswap, which would give you 0.

You'd need ((...) as u16).to_le()

Best,
Gary

>
> We could cast it to a __le16. u16 is a standard Rust type (compared to
> __le16 which is a internal kernel type), so I prefer u16 as it matches
> other Rust implementations.
>
>>
>> > +
>> > +        // SAFETY: `request` is repr(C) and packed, so we can convert=
 it to a slice
>> > +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request =
as *mut _ as *mut u8, req_sz) };
>> > +
>> > +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(rsp_sz=
, GFP_KERNEL)?;
>> > +
>> > +        let response =3D self.get_cert_exchange(request_buf, &mut res=
ponse_vec, rsp_sz)?;
>> > +
>> > +        let total_cert_len =3D
>> > +            ((response.portion_length + response.remainder_length) & =
0xFFFF) as usize;
>> > +
>> > +        let mut certs_buf: KVec<u8> =3D KVec::new();
>> > +
>> > +        certs_buf.extend_from_slice(
>> > +            &response_vec[8..(8 + response.portion_length as usize)],
>> > +            GFP_KERNEL,
>> > +        )?;
>> > +
>> > +        let mut offset: usize =3D response.portion_length as usize;
>> > +        let mut remainder_length =3D response.remainder_length as usi=
ze;
>> > +
>> > +        while remainder_length > 0 {
>> > +            request.offset =3D offset.to_le() as u16;
>>
>> Similar to other places, why not just make the type __le16
>> and avoid need to cast.
>
> Same as above
>
>>
>> > +            request.length =3D (remainder_length
>> > +                .min(rsp_sz - core::mem::size_of::<GetCertificateRsp>=
()))
>> > +            .to_le() as u16;
>>
>> Likewise.
>
> and above
>
>>
>> > +
>> > +            let request_buf =3D
>> > +                unsafe { from_raw_parts_mut(&mut request as *mut _ as=
 *mut u8, req_sz) };
>> > +
>> > +            let response =3D self.get_cert_exchange(request_buf, &mut=
 response_vec, rsp_sz)?;
>> > +
>> > +            if response.portion_length =3D=3D 0
>> > +                || (response.param1 & 0xF) !=3D slot
>> > +                || offset as u16 + response.portion_length + response=
.remainder_length
>> > +                    !=3D total_cert_len as u16
>> > +            {
>> > +                pr_err!("Malformed certificate response\n");
>> > +                to_result(-(bindings::EPROTO as i32))?;
>> > +            }
>> > +
>> > +            certs_buf.extend_from_slice(
>> > +                &response_vec[8..(8 + response.portion_length as usiz=
e)],
>> > +                GFP_KERNEL,
>> > +            )?;
>> > +            offset +=3D response.portion_length as usize;
>> > +            remainder_length =3D response.remainder_length as usize;
>> > +        }
>> > +
>> > +        let header_length =3D core::mem::size_of::<SpdmCertChain>() +=
 self.hash_len;
>> > +
>> > +        let ptr =3D certs_buf.as_mut_ptr();
>> > +        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can c=
onvert it from a slice
>> > +        let ptr =3D ptr.cast::<SpdmCertChain>();
>> > +        // SAFETY: `ptr` came from a reference and the cast above is =
valid.
>> > +        let certs: &mut SpdmCertChain =3D unsafe { &mut *ptr };
>> > +
>> > +        if total_cert_len < header_length
>> > +            || total_cert_len !=3D usize::from_le(certs.length as usi=
ze)
>>
>> That's a confusing bit of casting as you are interpretting an __le16 as =
a usize
>> before doing the endian conversion?  Seems unlikely to get what you want
>> on a big endian machine.
>
> Yeah, I think this is wrong
>
>>
>> > +            || total_cert_len !=3D certs_buf.len()
>> > +        {
>> > +            pr_err!("Malformed certificate chain in slot {slot}\n");
>> > +            to_result(-(bindings::EPROTO as i32))?;
>> > +        }
>> > +
>> > +        self.certs[slot as usize].clear();
>> > +        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_K=
ERNEL)?;
>> > +
>> > +        Ok(())
>> > +    }
>> >  }
>> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
>> > index 2150a23997db..a8bc3378676f 100644
>> > --- a/lib/rspdm/validator.rs
>> > +++ b/lib/rspdm/validator.rs
>> > @@ -17,8 +17,9 @@
>> >  };
>>
>> >  #[repr(C, packed)]
>> > @@ -364,3 +365,62 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8=
>>) -> Result<Self, Self::Err>
>> >          Ok(rsp)
>> >      }
>> >  }
>>
>> > +#[repr(C, packed)]
>> > +pub(crate) struct GetCertificateRsp {
>> > +    pub(crate) version: u8,
>> > +    pub(crate) code: u8,
>> > +    pub(crate) param1: u8,
>> > +    pub(crate) param2: u8,
>> > +
>> > +    pub(crate) portion_length: u16,
>> > +    pub(crate) remainder_length: u16,
>> > +
>> > +    pub(crate) cert_chain: __IncompleteArrayField<u8>,
>> > +}
>> > +
>> > +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp =
{
>> > +    type Err =3D Error;
>> > +
>> > +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Se=
lf, Self::Err> {
>> > +        let raw =3D unvalidated.raw_mut();
>> > +        if raw.len() < mem::size_of::<GetCertificateRsp>() {
>> > +            return Err(EINVAL);
>> > +        }
>> > +
>> > +        let ptr =3D raw.as_mut_ptr();
>> > +        // CAST: `GetCertificateRsp` only contains integers and has `=
repr(C)`.
>> > +        let ptr =3D ptr.cast::<GetCertificateRsp>();
>> > +        // SAFETY: `ptr` came from a reference and the cast above is =
valid.
>> > +        let rsp: &mut GetCertificateRsp =3D unsafe { &mut *ptr };
>> > +
>> > +        rsp.portion_length =3D rsp.portion_length.to_le();
>> > +        rsp.remainder_length =3D rsp.remainder_length.to_le();
>>
>> Why to_le()?  I can understand from_le() but then I'm a bit dubious abou=
t the
>> types. My gut feeling is that the validate code should leave these in li=
ttle
>> endian and we should convert them only at time of use.
>
> Fixed
>
> Alistair
>
>>
>> > +
>> > +        Ok(rsp)
>> > +    }
>> > +}
>>

