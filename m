Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A360171CD
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424881; cv=none; b=TNixp3UUsFcAsyLsFP3k4sIWjiBOmlu68hB1m2YobLnrV1Pwm0ckUOxRnXFjFTvFWQ1JkHnyKpDeD1C+Ey47ctTnjo6hTY78dHpXUCdng1wQfrx3VsrRiM1lINDFouNATHVn8aDdCztifv/QtCQwC2cQkr0s2ShZNS0PQWKdHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424881; c=relaxed/simple;
	bh=PEdznQE2XE+f8rCFkGqo8/kbObIBmLfeCQG3nfXgAp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFilabAYEsuic0pAhHkoOjUYV3BIARHokvKtoofhmE/dTY7G1iG/3X1NUZvLOXA93SQFYFW10j58HkOGUvmxofpt8rW0noT62tV3jjlFXneh62pQMS3yazrMwq/T7OZGfBK97XzHWOgrhMYRY2Tf3lfW9mb8b7x+VR0NSbl5KEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fJx5L2i9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fJx5L2i9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g4zgc0qY8z9tkd;
	Wed, 29 Apr 2026 03:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777424876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrIiJ/1VeJoZS90MOSzgHaHoy8qfnV97x3jTtA0OI8k=;
	b=fJx5L2i9a0nWxJKM8iZbaNMwU49jlmW6dt/eNF0rLwmZl7tkVABOQwLehGIOWnATrgYxcj
	fb+KVNgj5s11uCqjIvECSbKjuHIr9xAkvG2ATUd8QpsGBCRmH/J4lmlHuYczt26wbE9e1X
	7JXujbDkYJcKl1roYlMZqNgk57KxBQaBzmIdCIsPI4teSZ/93pMeteAztcdnNRmZT12Dsq
	FJJdtI8ceEIxwETTJUf2hCCkLSuu/Vgwj1qR4MRpF4B3axLYBMlcydXzAmJ1oIlCwjyP1f
	MpL1yvKHm/WxDMnl/3ZP9ed9qerib6q1MP6p93Yi5gTH09d2uydYAYRrf/l9iA==
Message-ID: <c8d9911c-0880-4c2b-8896-a9939302d368@mailbox.org>
Date: Tue, 28 Apr 2026 20:55:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar: Fix up MAINTAINERS entry
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20260428173657.GA237110@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260428173657.GA237110@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b9718719dc9a263d2e5
X-MBO-RS-META: mred81ixfk73bpj19xxf6eqygwis7o4o

On 4/28/26 7:36 PM, Bjorn Helgaas wrote:
> On Tue, Apr 28, 2026 at 07:19:54AM +0200, Marek Vasut wrote:
>> Use up to date address. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> I'd be happy to apply this, but am wondering if you want to update
> other similar addresses at the same time?

Not all of them, only the gyroadc needs an update, and I'll send that 
one via iio, thank you for pointing that out. The rest are still fine.

If you could pick this one up, that would be nice. Thank you !
