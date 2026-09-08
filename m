Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A6572695;
	Tue,  8 Sep 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884716; cv=none; b=SRMjd7oBLU1/6pKt8UZe7YdbfwpQmPEE6XcEQrv5qz/eM+LcX88M7dc2/ux8+hJRQBObzSblOMd6rCpHSRnspT1umoy693kuYwKK7kgizMuPLkbOHq/QHQpDNFYYYBKlM3YKLZ2bAmtx20kgoD1wQeFkAf63XmIxkn+lCzHUt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884716; c=relaxed/simple;
	bh=ap36uQ4Bp2PH1Hk30QcfuKOebLmKtqJQFue3g+V6wBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5JNyYNz6cMmlWEebi1mUFAI6pOnTJ2cxeSygSv+JrJN8vl7W6tFUm0HYMfLtl+jbg1bqaP/aQ2yvebQ0hS9Xi7bBPRZ2oYmhq1iV5LAYLZjlW5/B3xML+/FJUvMjO9+2ERZAZtuMXeyYE9nXdTiqFRGWGQSA7nmji/oSfb6NGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CN4aZrQW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CN4aZrQW"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hfTn23VKXzKmsk;
	Tue, 08 Sep 2026 18:25:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788884710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3pZc0vhobhb4iV2Lz3CbJ8dngsPKvp4OKQiVk9RJ0k=;
	b=CN4aZrQW/b33dj7JfMnjTjLaqthRsK1RcdKl6J0KVRzS84vYAbkqNfn1GWihYgm6EDqEdN
	wCftBIr+A/olOjAWFXMRvc95wF8V+Y57LLMVxjAK2A5kTg5rt4fXvFQbQyj3Ac2si5HNc1
	bUBRyCag+GEJMjzXBiUPfbQyp35Rit2lmauipVz4LAtmpE4EJ9XnO0OJd5qzKGGIdEnCu6
	a0UCj/MmLrtKW3t3CjtcujUjlsr5EuZFIjEyTaWtnsuAqp4l5hr32Hqi4r6IEg1IEipB8F
	kzo7/KfcuZEqnllifsTvz9n0NUVMiDsITAYgjsc/h8CjVkWkUbsMkD6u1x4FNA==
Message-ID: <820f02c1-f7d3-4a98-aa1e-6456587dc6f5@mailbox.org>
Date: Tue, 8 Sep 2026 18:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] arm64: dts: renesas: r8a779g0: Add GICv3 ITS and
 update PCIe nodes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260809200429.843212-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXpq170gW12KEzmf5cUkUfRQ-6Vj_hMyeGeUny_WUCohA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdXpq170gW12KEzmf5cUkUfRQ-6Vj_hMyeGeUny_WUCohA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1577b8dba529201d395
X-MBO-RS-META: a5156gzqfptqb7b8r9rkcsyoxcxm586z

On 9/8/26 10:46 AM, Geert Uytterhoeven wrote:

Hello Geert,

> On Sun, 9 Aug 2026 at 22:04, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
>> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
>> and add msi-map into PCIe controller node.
> 
> I missed before that "msi-map" is not actually added?

I sent a fix:

[PATCH] arm64: dts: renesas: r8a779g0: Add MSI cells to GICv3 ITS

[...]

>> +                       };
>>                  };
>>
>>                  gpu: gpu@fd000000 {
> 
> I have already queued this in renesas-devel as commit 7fe73a3a3f2c3718
> ("arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes"),
> but I can still amend it.
Thank you !
