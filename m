Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782F36C0D8;
	Mon,  2 Feb 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042084; cv=none; b=VgPtj8tT7PHlKoWuZKhmzxscl9KLFDq1bnCYUbjuhoOMScsuITJq1X8u/ksO7wd1I8QHNtx9Eem2q2rkL32BCMN2eflTLlcAVxau7L7REh1PB5voU9vVdWWXx40x8q3Z7LeqhEJ5vXrGZ9+veA3oprEqryKrY2lpvXCLz2gIm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042084; c=relaxed/simple;
	bh=RUo4BpQIK3FZz7IgsAOuYIhK1wzbxhMQNYC48oTnlVE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=J+Zyz554XqyyVMUfspfKZ5s8OmD/1GMPhLzns3HNifm9HV/InV4DvkKEUCULX9oIfEFubHXs/Sk7wbnOJPygNwmj1V/BjyVvp+l8d64ru09epE9qZ4SydnsGD9Q0mcBeYHPwhTWxoOgdGRB9l88N2UPHfesGSQGoFFVjJXSZLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6vcIH2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6vcIH2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC04C19422;
	Mon,  2 Feb 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770042084;
	bh=RUo4BpQIK3FZz7IgsAOuYIhK1wzbxhMQNYC48oTnlVE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=G6vcIH2W5bXsSz7rEhKMzlR+yE0q1uCqGufTxCO7Vm+RYqY/PAnCa4gV1u3R8YGaZ
	 iCGok6J3z+24raE0MMFEhPRED7pp/8VMiG3Evl0ZJzL795MhjCopDu/Tu0Nl54s84h
	 s0B+D58/wFC+sa0nTNnr0LcWbOglop0m1OJCe+rBfE/pUGvCK3mnm+J3tUck2yF+i1
	 PIQ5Ni70PTsvpN4dbDAfd/WoIFsfX1GS/PAFYKJhczBpkuztPbR4bfuo32pDYLm7R8
	 xAIkqKeZIf2z+65aAe8sLVTzvCDy8iTsCbj8Pa/c0HmnQJHqlPN0V1AsoIXv7qnWJh
	 cQzPpbcg1cAPg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 15:21:18 +0100
Message-Id: <DG4JJTAZ90DS.S76K5YX47PBE@kernel.org>
Subject: Re: [PATCH 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-3-9bb2177d23be@nvidia.com>
 <DG4J98HVOUEX.I7XOB7LPB49L@garyguo.net>
 <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>
In-Reply-To: <DG4JHKY0Y19S.24TZ7TAX5ISD@kernel.org>

On Mon Feb 2, 2026 at 3:18 PM CET, Danilo Krummrich wrote:
> On Mon Feb 2, 2026 at 3:07 PM CET, Gary Guo wrote:
>> I think ultimately choice of order to use for each I/O access is local t=
o the
>> specific access, not a global property.
>>
>> I know you can just do `RelaxedMmio::from(io).access()` for each single =
access
>> too, but it feels quite verbose.
>
> mmio.relaxed().access() would work as well.
>
>> I guess one alternative design is explicit order on the access, e.g.
>>
>>     io.read32(Relaxed)
>>
>> Or
>>
>>     io.read32(Full)
>>
>> however this is verbose in some other ways... I'd like to hear how Boqun=
 thinks
>> on this one.
>
> This apprach would be misleading for a lot of other I/O backends. For ins=
tance,
> the I2C bus has no relaxed ordering.

Forgot to mention, relaxed ordering accesses are far less common, hence thi=
s
would become unnecessarily verbose.
