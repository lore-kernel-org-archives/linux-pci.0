Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29913E56A;
	Sun,  2 Aug 2026 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785636254; cv=none; b=Zj+e3X1M36f+mh7teKRgnaXgTteSRUnXcN53eafmb9n2pVKVq32Cce5OZOqYUXVLc4HXFXynK59Q+O0peRRZF9zTK8wyHxqOPjkWX1g4+SQC80WFXzRQi/2EBhXibUU9FDW0XjKMnYJilI2plqyvw+RCtCKJj3uUU6HUSfJGsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785636254; c=relaxed/simple;
	bh=WacV5soqjkCc4+7PY6HLIGZdfd/ld1WmhyJBoPCjb40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jk8p1cXhqqCkQYQzECiH6nHBy79mgqfJN4m+r1Ne58Pl2L6O+hkZzhTFaaRn37yTId3WeRku8tVcXBRZcQwJqdh/i7Iwgww1Ozc8vVssJMWtx63B7/wgeRfaZCqIMfuomZz5HRxsA922DcmI6tcgqosah+d0wrLH/f+tFySUqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=n9i4I1vo; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RgItc+k+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n9i4I1vo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RgItc+k+"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hCNQW6jbVzMlGX;
	Sun, 02 Aug 2026 04:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785636244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAROnVhnAkeu5y0AEEbAdxluS7JzVCg5yWSFlsMM8jk=;
	b=n9i4I1vozJzGZcSPuIoPpLuypkiaRkI86dE+jgR4bL6ZvLQHNoHA4HObp5ayonRe1/a6Bb
	vrBsYoR6rqAPIOH3V8Mo74XkOBAeQBe7kc6xqJ0Zb7kBZvue9dVuLv5pz9hTpgtdMH/dPK
	BGRlAunqEnIAEyOL37lTTd3jLEx3uNTqIOymmg4w4uZqZzLe6Mh2PC2Va21XFoYeVbbzF7
	DGGCaaSLVr6vbRCcfF6e5lebf/5CDA/n2TzuiD4v+q/NCt6g+AU2GCmfG5QDUhYvNKk0Sg
	QLMs1EAJ6sjHntWS5lfdpoyTE+aUe4rQX4TZac7x6jSeMrfi/AfKQ5d9qc//wA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RgItc+k+;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6108aa58-3595-4b43-82a4-6f94cb9cca31@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785636242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GAROnVhnAkeu5y0AEEbAdxluS7JzVCg5yWSFlsMM8jk=;
	b=RgItc+k+jb3+1Q+UviTwgUyiZsOWh004DL/I0Fq9hJSZa03L6EFvNBxgXLFAoLOrpMTNAJ
	znX3AHCgsCzbQHIKLZf93RGWF8degeOD94PzNCgSjkugPrpXCFYj4QCmmxpTxvPWAr9j1V
	za7XCw/cNKoNZXZ8mLBLzccprC/EIKV9hA1HC5XNMH92zofG7ifjV9D3/WMt3CQX8rcT+T
	EjcLS/gJW5KjJAUrnodiOg0bvi5UMHjlC+sn3aBdxzhpUNDFxi/MMHSHH947v7OP3yTRKd
	tidnaSlx7wOGosz7pNULJIEQMGQgYY4P6bgqEtlXml3s3Lellaf68Nh6M+6Ffg==
Date: Sun, 2 Aug 2026 04:03:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: PCI: Correct white-space style
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f80aa9cc35e8dfc77fe
X-MBO-RS-META: 6mrrnyrfzi36q3b4htmaiygg34gqfjip
X-Rspamd-Queue-Id: 4hCNQW6jbVzMlGX

On 8/1/26 9:55 PM, Krzysztof Kozlowski wrote:

> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> @@ -155,7 +155,7 @@ examples:
>       #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
>       #include <dt-bindings/power/r8a7790-sysc.h>
>   
> -    pci@ee090000  {
> +    pci@ee090000 {
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
