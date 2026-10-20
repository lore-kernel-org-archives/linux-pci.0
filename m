Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549297;
	b=0pv3OyfGfTzlPZ3oQwwCSVsH10qTGfKZ0cj2qUWk3TzSRmQRHRqURNJ3Lef0p8KgkArh
	 DxO8v0l/slnB08LRCfjZKP5fMy4vioI1O9xkuLtLMlEH7ru4QqHMggDxmiJBmvveOvoCA
	 U21xrlO1xv3ZJM+wrh9YiS5hpZIonWU/NaP6piL/fshJA10DmWimxZgabhHgGRSBvsO7H
	 xcp68poLnGTpFL1L297Y/tH5i9lvVwQYgEqnfGKMdic4/b2jqjrFhRN1WnYfR1y+MCxYi
	 skp1Bh//F5as8QNY+4h5c4xeh3re+yJEMeFlwzI4LTVKHqvFM/FEJMiZIMUwRacGdNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549297;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=s5WF1SSOzfW1udZU6mQwo1L4xq4QGFsOyNYeSHNbPoY=;
	b=WEJborOAP0N8TJvL6fVyvLWQeRL6hLKjc2ZDxXl5MobHsPyQ3JaurNQdUj94mCJ/2EeU
	 xl4aGaAfCIBchWH48EXU9j6BApsa4AC0iRqr3UCcdZohZcncSadsyy5xoGqy4OwvlZf++
	 ZDNyU7Mbv+M9ifQ5iUUlqS7cOnUV08pe63dhAQvBhJ6j/hn3KTRjK3dWIhqJ3D6y7OFEt
	 KXDNWUc/JIAQ5Cjcwq23oIiBdXAsjDuEKTXt8LKWYvMhKOy6Js56QjJSiDJ3zS31Tpk7m
	 vCCEwYOjxgrxOTvo4+DjzjDtge74I96U5ikv3q1t8bgH/Mb5/MDUM5GdnJsB61NYulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=e5dOrzaX;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C4606A31A;
	Wed, 21 Oct 2026 02:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=e5dOrzaX
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j8Y1m62Z9zKnsg;
	Wed, 21 Oct 2026 04:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792549292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5WF1SSOzfW1udZU6mQwo1L4xq4QGFsOyNYeSHNbPoY=;
	b=e5dOrzaX5E6uqQJ8NiAvhRQuHeVGwRJ1TiQIkwEaDUvj6d+BHaGoAUhMeTi1Zo4QmNSjNO
	I2WAK9YhLo6cpR+k+ec6VqBQuMDcPTGweTEMpHQWyWWLsTWWolgrstqvzA55LMYN+1OLln
	f3+FDMFgmpUIiDVD97XguGeAFvd/c8K1XT0BMK+86ZW14R6kSjF1AoUuxma3DauxtEkISA
	esllMxXldKD94duVJ2AgBlgmkru8I4s3vYjktUw1NnE3SW2sgPHwXyrdbNXdgbOZ8/fm+i
	E0cuqNzBoA9itvoXki5+zVZoGBnN4H9JzK4RUyoeAEV/SFO6zY/pBgyp/iZC9w==
Message-ID: <c26c961d-5901-4df7-b8db-2711e233a22d@mailbox.org>
Date: Tue, 20 Oct 2026 14:45:39 +0200
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
Subject: Re: [PATCH v5 04/17] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt for R-Car Gen4 SoCs
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <Shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-5-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020031049.969895-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: emani3wdchyx4rijtecteroa7ix9jyah
X-MBO-RS-ID: 7422b402835ceb3cdef

On 10/20/26 5:10 AM, Koichiro Den wrote:
> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
> 
> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> trees remain valid. Extend the example accordingly.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
