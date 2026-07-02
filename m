Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D264433E8C;
	Thu,  2 Jul 2026 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006826; cv=none; b=h/jAU3LRFW1m64LoZsOZAhThcLsOu/XaTnz8dEoFb/kwsoUBbWcdWz9WupqvDBPo0BOK6oIk+RruJHz66Z80inMvVK4+RJhpwosgssUhsHoqMN4CVmlH0ByPVU20zqUdtA0dtFQ0g7uoA5LTTLLZ7eBMqR5Co+Mvh8CVw1ijwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006826; c=relaxed/simple;
	bh=+l7GAsk0x/vJ2hI6EK695h4bTdNyGuaXcZ77Z88pDOs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=h/uCmrAuuAa1OJ56ZTneMFgIFZKS5mZp/EWXPVoI2d4CX7mBqCCkRM894Ig2oo5FdDu9WBSAG+hDqTmdf4WiMRyjBMJ/m3EZmX3aVmGjZV0xFd3dOAuF7u69RCrbxibPwYBnh/PLYN+WUkyPHipfVD1LggMUvJBtWGmww7K+4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4caPv5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4caPv5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56BF1F00A3D;
	Thu,  2 Jul 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006825;
	bh=yfUvHVI8SP80uIxkcQY9ZvZZE7Zv/L9JYU92dnt0O6I=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=l4caPv5c+0s5trvs6J0lgoEYtFiTAbTl0Xl5Ri7MILqVxlP/IORg74hGywAf3MIwi
	 yFDk77A3fP3H28cEr7L8uqUqEaHKxwm8GyW99WNRjtQVmQZFcjZKaLBIATrTNcvPXH
	 JkDRcDfp8nl32vMDJA1pGwClqS1Qlbs3kgXLRpsz5skrSo33iS2zegeT+/KR7LdI28
	 XXAZmOw8peV8+E28AJZsUGucaTKvudpz6x1X//9GleDVpQ1QwqO4Xuq6kdI5ikNdiz
	 JvjJ5sE17tCrimqEWF6IIBSgtSI3EaPDlvTHmhr5D1SfpY5Sndj/vQGZBilxFzhrbT
	 OspK1zx1WDong==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 17:40:20 +0200
Message-Id: <DJO761D977GM.34EF3PQ0XUI91@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Cc: "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
 <DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org>
 <DJO6UALV8NXX.CQL2772AEKFE@mailbox.org>
In-Reply-To: <DJO6UALV8NXX.CQL2772AEKFE@mailbox.org>

On Thu Jul 2, 2026 at 5:24 PM CEST, Maurice Hieronymus wrote:
> On Sun Jun 21, 2026 at 2:27 PM CEST, Danilo Krummrich wrote:
>>> +impl pci::Driver for EduDriver {
>>> +    type IdInfo =3D ();
>>> +    type Data<'bound> =3D Self;
>>
>> Please make this a new type and take advantage of Rust native lifetimes =
for
>> device resources, just like the existing sample driver and nova-core doe=
s.
>>
>> I understand that the existing IRQ infrastructure is a bit in the way an=
d you
>> have to work around it.
>>
>> I'm going to send a patch to make the irq::Registration compatible with =
the
>> device driver lifetime rework soon. Please rebase onto that once it's se=
nt, so
>> this sample can land as idiomatic as possible.
>
> If you haven't started on the irq::Registration rework yet, I'd be happy =
to take a
> try at it myself. I saw the DevresLt/ForLt work on your driver-lifetime b=
ranch;
> is stacking on the I/O generalization series the direction you have in mi=
nd for the
> handler data?

I do have the code already, I just have to get to sending it out. I will
probably send it tomorrow.

But I think there's some room for subsequent improvements on the device ena=
ble
and bus mastering stuff; going to reply there.

Thanks,
Danilo
