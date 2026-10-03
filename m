Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A728C5B1;
	Sat,  3 Oct 2026 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059045; cv=none; b=U8bOpM1Ph4J+NhxrA2TsmJZZ4QgobY2n3Okm4fxaeC3W6JIX9focnIH63Nj9yAJC3tJctMK9eHuwryiPniHNrtrZ0Fvfz78lKPW+FqNNGQS9gO+mhHUxVhcfBd+oQUNaPI4iVW+ztkH2bo0jS7kNRfO5p4t31ftSV1K+8JcM/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059045; c=relaxed/simple;
	bh=Ih/mGTakxH6WAjtXkgbjnHoYIWPMyTHZeTKJJPBZ2fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjmatolOL70DslCL/2x63jjllEfn/H7eGkUtJlEFqANCXE7P9OvgTc0I3vDKJJk5SLxE3tcs7znu0u47DCloHYaHkw5FebsKkizgUUA44zCpSwObYKzAdSTP9vidvupzuy4ysFBOPcZWjcHXfmBdIwkKMpI/Yvhnc9I/nnZO+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JGIjBLsV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tR3mMDkK; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JGIjBLsV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tR3mMDkK"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hxxv519tgzMlX9;
	Sat, 03 Oct 2026 22:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791059041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpAhM8hSb1rl5i3nql8DGGyqEwvKnFcUgadhQQx0KBY=;
	b=JGIjBLsV9fXvazedlIqBMwtTURR5LBkRzsUojTY88KVxlBYH6fe9RMOESRpcj4+zTiAxJB
	tOKFglGGP3Kvm7mQ2za5ZBIKmVcAUo0H4MKukC9Ok155htX8I/e2N13WqYqW1b63S/QIz5
	lakx4rScZWASm30Hb3kHuPTjlz4Sl5o9vJbU+IkBz51Bf6YK4Xo4gNDoufMOzAXev9QHFs
	rSkHgmKX4L53pWsBxjSjSIwNIef/YvkYBy8uiRMgPTIWPIpK/sZTv2JSklOVWo6zim/AqV
	QMix32W8yQfFuWWzLhXi/pg6ElQDw8hDMgON640kjWzGPqi2/b8M/PjkaMlPHA==
Message-ID: <4014c330-0009-44bd-8b57-572f91517253@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791059040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpAhM8hSb1rl5i3nql8DGGyqEwvKnFcUgadhQQx0KBY=;
	b=tR3mMDkKMkT/MGVgJKAcl1ZCdtGLSCosu6ir8+fgk+ku/j9FrGLHx88M1JmQ89ReMWcKEV
	9DLKwGNWmciwFDaetl+Ow/fIhCXc9Jb9D15Vlb0wz0x1cfOkILZUp6pQ2MEIWuPKB1zEil
	8LVM1YDM4Y52Tn8eCBRXhTChk+R0fpNrKrDq04UoD48CjGhrZWjwi+lQSLe56WVtgOreVq
	NwJ3xbTxOeFQsp92wWW/c/IuChZ/8Cp9kuGDQD4iRxApcg6fjKN50l3hCgk5vafn2IJ9+z
	+awoYqjWWCGcZdXG2whjTANmg1/027l2IeqDhbSb0DWeve7Mfv75VHND4gt/1g==
Date: Sat, 3 Oct 2026 22:23:54 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] PCI: rcar-gen4: Move deinitialization helpers
 before SoC initialization
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-6-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-6-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m74whjzh4jntmmda7gfsgadu39aapyj9
X-MBO-RS-ID: d7ba01d7b2d07298f2a

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Move common_deinit() next to common_init(), ahead of the Gen5 .init()
> that will call it when PHY initialization fails. Place the Gen5 .deinit()
> before the Gen5 initialization code as well.
> 
> Keep these moves separate from the following initialization refactoring
> to make that patch easier to review. The function bodies are unchanged.
> 
> No functional changes.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
