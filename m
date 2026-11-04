Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777029;
	b=blRchioDa0FxImUIUJ0xysMN89/+jKh3phxdON28RIzrXiJOJKViAcnw0c9hhPef3MxV
	 4vssbH+IhZuz+Y9pRJDJR+2knYFmfQSPJ9SB8YpZv26Mr1pY2/GsMkfMElvQsZ0yS2b+g
	 vBFXSa/tP+dCjv3w5M4nGg/2hHVViRlG+Dem89mC7/11LyxEFbPCw0PwYVX5D1vfKzvC4
	 jw5Suf9Bg0NyPwv1kT/VIjBo+f1ibuUH0rno1Tj1hyacaf5tIFPxhASy3vpkQ0HIJXCz+
	 RnxfuZSm4vR3MTQNjdlSonPz8rqGR4zpLBxjnKiduUhNqDCYEbeTuaAQSb8SfDypMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777029;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NBOQ40gBeaDYVe8Awm5p4ozUA0tAVvF4nJgh2RDLTZA=;
	b=GrxOrvmy+ZOZu8qmU4a48j0nkkVr5CJceDQvJXHrffu4po/hifyNtmyMvsrYLfurl6ln
	 tu/1vzYtL/V49yb939DkQfYn4+ezv3XhfGiPyh/ceJk3APAN3+FmhLrNQL8jffNBAcxB5
	 mAuKYiWslmcV0hj60ZmTDa/hCrklxP235TjkDN6DRxv2IwRX3a5PFAz6p4Wsmi3QcKD/g
	 /PoHAM8aVQhORSrRhO9TLV6djee0SXD3QV3oaigdy1fcm4wt3Q5KF2PYUJJFx/+Mhlehe
	 hbtRmIhC449A7nIGX6CR4BPveXclhr1ofujD9DCx1ixW4OnbCdKqESC+dW08qnjei5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAzoyO7l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEA606A31B;
	Wed,  4 Nov 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAzoyO7l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B71F000C1;
	Wed,  4 Nov 2026 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793777028;
	bh=NBOQ40gBeaDYVe8Awm5p4ozUA0tAVvF4nJgh2RDLTZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fAzoyO7l7JrQauRVoEzkU2YbVbg3GZqLoQ1vbvKVgH8kKLf+jgVdZxVK2J5pSVAQL
	 igHw5zbRXGhLbFPt+6lEcO8n/DMrkktk0R1AX7yS00jD4BRA/50zagFe3mZ/c1n3zS
	 XDzqw/t2zI2Is/qsU5wgGD+XARqXmJio2t4k4O/1/1DlI2m29fAlsYM94VHedruACU
	 QT8dAv05U6y1yXEoOuDyxkHzcTTF/Z6pdNibFjrneUGC58mrUzESj2HUCPPF5jhi93
	 TDrFG+NTMNMwg7Q8eQunznuVUUt2kQEY4UDVM7lVI4kwhKurhlq8vTVoKgRIh2K2Vt
	 z5rnAZ5/U8I1A==
Message-ID: <c0313537-532f-4c9c-86fb-067838829427@kernel.org>
Date: Wed, 4 Nov 2026 08:23:42 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add linux,pci-domain-reuse property
To: Cui Chao <cuichao1753@phytium.com.cn>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
 <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
 <8112d8ca-2234-490c-a4a2-c3b01adfbc88@kernel.org>
 <b49779cf-5132-4539-86c2-e4f806b1675d@phytium.com.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <b49779cf-5132-4539-86c2-e4f806b1675d@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2026 03:57, Cui Chao wrote:
> 
> On 11/2/2026 6:00 PM, Krzysztof Kozlowski wrote:
>> On 02/11/2026 10:51, Cui Chao wrote:
>>> Add a new optional boolean property 'linux,pci-domain-reuse' for PCI
>>> host bridges.
>>>
>>> By default, the 'linux,pci-domain' property must be unique across all
>>> host bridges. This property allows a host bridge to explicitly opt-out
>>> of this uniqueness check, permitting multiple host bridges to reuse the
>>> same software domain number.
>> Why isn't this deducible from the compatibles?
> Hi Krzysztof,
> 
> Thanks.
> 
> The compatible cannot express this. "pci-host-ecam-generic" only

You have vendor specific compatibles, no?

> describes how configuration space is accessed; it does not describe
> whether two host bridge instances may share one Linux PCI domain.
> 
> The same compatible is used on systems where every host bridge must
> have a unique domain and on this system where two RCs intentionally
> share a domain with disjoint bus ranges and resource windows.
> Comparing the compatible strings of the nodes therefore cannot
> distinguish our case.

OK, so let's look at your DTS - where is it posted for upstream?

> 
> Adding a vendor-specific compatible only to trigger this Linux policy
> would not describe a different hardware programming model either.
> What actually makes reuse valid is the platform-level relationship:
> the bus ranges and resource windows are disjoint.
> 
> If you prefer to avoid a new property, I can rework this to derive or
> validate reuse from the non-overlapping bus-range and resource layout
> instead. Would that be the preferred direction?
> 

This one is clear paste of LLM output to a message.


Best regards,
Krzysztof
