Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F442087F;
	Tue,  7 Jul 2026 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455861; cv=none; b=bp+ag6D0kCMed7oSiJyygW+jHv36+sVMPuz9M6PZJQ1yNcfpvNnL9x7QPO6qEtffb3sEzDUVRflWYxoasVTFa4dnRJPvtxwWQeR27gIa7C0qUggm2Zr94pX3RxHa5In57zQtj0qME62BEWxXgQNTbGSCgF+a4ph1JqBnl0oBZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455861; c=relaxed/simple;
	bh=fwReva9uoUxB1MQyBfEquSl0KIEHdpI1AQyr6XKGsNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa32OWy9EGSIVcOwfJHEX0kU7L2lUA/8Vxe4kFEdl74/h26T8nGWCqQdImAzK4iDCmnD/y1XWveGMA1W/rdCE7XrEHHp5SJ9qQ0kmIkyK/jQ8e+KFQWpbsXqoexiuoi8a06ZmnZd+nr+9la1AxkzkglLKdnuR0EIFzGdOKNOCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hlX9qH3P; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hlX9qH3P"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gvt3r6X4zzMlHZ;
	Tue, 07 Jul 2026 22:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783455848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pE6yNMp+uXpgGUcwJt1cNGBLI12Hj8FXQ5m2BI8bX4s=;
	b=hlX9qH3P7QNIy3fjcF4n/8eSucWZ176Mk6rgjs1M739zaMKvTQvGGk549o/lK7yzZY8UKe
	jrzFdT6d+qGQ8TmH5E8onyjvFhIdY+IgHM7HLT6Llob5IE5V+y8Fk7WgrW3QqWf4ODCQIa
	eYSgnfyQrdAPnV8IUCnsSUcelKJAkz9guNykDXeTGHK/kY5secL5vamRRk/cwduEriTwSM
	f8CZF+4XnDZ0VgOApdQJ4+L+WpHH7MVIYfFxN6LKJEcgVUhp1FGVkc5sucYDAu0sbcym+B
	BmjQEfAMRLzikJr7elz3UFrWy8d2X9uQAUaLcjfAlrZXHRJsHRxMO6xWLW81Dw==
Message-ID: <e67d526b-7e4c-424d-b971-35e06c163376@mailbox.org>
Date: Tue, 7 Jul 2026 22:24:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/5] PCI: dwc: Determine whether iMSI is used before
 calling .init
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
 <20260701203918.63189-2-marek.vasut+renesas@mailbox.org>
 <4qyn4fljtb3cbzcmfpkdomkm7vqnwn2rfbtqng4iwmtvfd4bpj@t6kkw53erl7f>
 <8a921ce9-e339-445a-af05-d20f9f2df01e@mailbox.org>
 <p4it4hcg24narbtjtoqdk6zg7wpfs5hc2mm77acyoi6hwfkh5u@5bqlwhylosmo>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <p4it4hcg24narbtjtoqdk6zg7wpfs5hc2mm77acyoi6hwfkh5u@5bqlwhylosmo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 073d86a19c85a0d025b
X-MBO-RS-META: 5dycfot7945dqgf3kieqojhkr9yf6hae

On 7/7/26 5:36 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 06, 2026 at 07:48:24PM +0200, Marek Vasut wrote:
>> On 7/6/26 6:43 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 01, 2026 at 10:37:44PM +0200, Marek Vasut wrote:
>>>> The R-Car Gen4 PCIe controller integration configures MSI registers
>>>> in the controller driver .init callback, because those registers
>>>> have to be configured while PERST signal is asserted, and the PERST
>>>> signal is asserted across the controller driver .init callback.
>>>>
>>>> The registers have to be configured differently in case the iMSI is
>>>> or is not used. Assign pp->use_imsi_rx before the controller driver
>>>> .init callback is called, so the controller driver .init callback
>>>> implementation can use the pp->use_imsi_rx value.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> LGTM!
>> Thank you. Can I get AB/RB before sending V4 ?
> 
> Why? Since this series goes through PCI tree and all PCI patches are controller
> patches, I'm going to merge the series. So no need of the A-b/R-b tags.
All right, V4 patchset is coming shortly.
