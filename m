Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3E49F13A;
	Thu, 10 Sep 2026 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051216; cv=none; b=LrEYYZY2PpbbAa3uOrESsfsggx8LMffy7BpOKB+ya8AzNIIkzkpeyvV85aY6SAkss/U2PfS54RbjvB8D+JEYxXLUjsPB7P/mYRKrHDo+y815BSPo7cvYz+d5O0KjI0hamAlHqKRolSOgUlKjcdF1LrOBEgV7G0hMfI73D0onNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051216; c=relaxed/simple;
	bh=0aGXhr0wekYKe1daywekJhJJvQqGSqeH3iZtYj1ZthY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsDTEP0sLjpxkB1gRLxuxClAZbB2B1V3cGM04GlVnVY9o+mc4Z9QRnDwzDMJeD+3VEHt/s+KabAbBDGKxCM71koeE9cmA2NXeDinrK369Ifp92zNtIbON/Z7DwkFj0mw38MfKibs76LXMGXonYduX4ak59iqC+JTJz23kXGw6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r/GG4DaI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r/GG4DaI"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hggLw54gHzKvsx;
	Thu, 10 Sep 2026 16:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789051208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmE7gMRT3k8OSgZ+Z+9TzwYWeF1O1bwOiRIgbLOfJFY=;
	b=r/GG4DaIVQoItrRs9+/edb4433qcvDHID1mWF4dYFvv7GbcYWWp40/85Opd4r8sJHLAP43
	wHeSOC385FmkHg162YFcBVg/HOdP6UiLKHStSYwBvu5ps5ikltes9TjuHkRb12pVD0pkXj
	ByXXQp9TMOU9IrkcMHZGp/4HZlfH80PrUgZlNU+fY46zAUuApVXHvxmGtq5hyXH61gd7+b
	Jb+V+gY49YCjTxJUiKiExAVapa6V9MYG6Qm66JFL98oWOd2jVQzsXZCayQxsVQ/xauvDfk
	9WjsFDZkQsSBGoUEi/DuMGy3M3eGyB2J6drFEq2SeXkpaEWe9cqKvIqSA9rc2A==
Message-ID: <c74e6c95-2cd2-4123-a232-a372f7b48819@mailbox.org>
Date: Thu, 10 Sep 2026 16:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] arm64: dts: renesas: r8a779f0: Add GICv3 ITS and
 update PCIe nodes
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm
 <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
 <ulxyqbaodkunrodrqfev5a6idrc2x7yjkee4tpmwv45bthpfg3@c5yozpfqaou5>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ulxyqbaodkunrodrqfev5a6idrc2x7yjkee4tpmwv45bthpfg3@c5yozpfqaou5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gtkr539excr6cu1pu9xqwmwtwpr8qaep
X-MBO-RS-ID: 3948277c6ed69d606f3

Hello Den-san,

On 9/10/26 10:18 AM, Koichiro Den wrote:
> On Wed, Sep 09, 2026 at 07:58:46PM +0200, Marek Vasut wrote:
>> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
>> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
>> and add msi-map into PCIe controller node.
>>
>> The GIC ITS does have master interface to issue transactions to RAM.
>> The interface does support cacheable transactions, however, it does
>> not support shareable attribute, because the AXI port signals are tied
>> to inactive in this implementation. Therefore, add "dma-noncoherent"
>> DT property into the GIC ITS subnode.
>>
>> The GIC redistributor does not have cacheable/shareable, therefore
>> add "dma-noncoherent" DT property into the GIC node.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Koichiro Den <den@valinux.co.jp>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> NOTE: I am sending this as an RFC. Den-san, would you please test
>>        whether this works correctly together with your Endpoint setup?
>>        Especially whether the Host-side MSI change does not break it?
>>        Thank you for your help!
> 
> Yes, I confirmed that it works fine with renesas-next-2026-09-09-v7.3-rc1
> kernel.
> 
> Tested-by: Koichiro Den <den@valinux.co.jp>

Thank you!

-- 
Best regards,
Marek Vasut
