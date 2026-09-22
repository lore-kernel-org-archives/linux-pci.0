Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2BC45C70B;
	Tue, 22 Sep 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113763; cv=none; b=aR+HKBUikFii3oV8qa47+yk1yw/VmfWvzeRAR1bdnWHasaflaCTUFCYEqtniAwYOdsWN7qllCdHc/DHgTEN0NaUVU57CuCoSGyWZknpZyIjbGLJ3lisCjzvlraFw1+YCV2SA6ye588a9XV5XFg4rYE1HbIKLMDcLAojFL8lc0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113763; c=relaxed/simple;
	bh=NsIYZWV3GZGiOM4UwrRYPgCcYf13C75MvTiWBEMR3AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HM9UVxFWUEV5eNq6ss4cw8K2Tc4EJ2zH3J2FA7fzza7d6IMvqXpuC2RkvG4CY6e3A+gzpQsWZh+e7GRebRFgGCTsXnpQoSlfNbo3C6Yv8fQ0OtP40/G1nQmq9lOBaymtw6j2l8qxQEbmNfOC19hrJC4tC9O45L04l/U5ckq/q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aRTeG9CB; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aRTeG9CB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hqDJT08sCzKmt5;
	Tue, 22 Sep 2026 23:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXYjPHazqBFP5oaNfc4ncajatoT1TniGOC1Liiyaw04=;
	b=aRTeG9CByuPTJxLZzL1fbbYraCIE1LcqBuL7Wlp+4vOLaybAZZMQJR9WXZIaEiJWoBHLju
	t+s/gXXtMaXp42IL7l/PFu6qTVuRQgvpRIrFTFATUMQ1aekQkS3r1Zew25Iq8Q+a2xzD+E
	7GtZ2DK2YWh6e74h3uTsiuJiqmP3DLMYx/yhULcnrCMr8SxTocNnmJ4M/mX1ZXUgcMju5q
	sJ7jE1KbQ7qWt9LYtvSlGaxcO7T0cn+aWP4tLIYKJfeQct7aIziWk1AiypdfRSW4YetDql
	n17o40LfRw/o/2lAR84gyApkon30h4BDIbH/Ino4qMEIJ7haUxOe5OebUOwEWQ==
Message-ID: <caae0a0b-75e6-4905-8406-266f9e54b5f1@mailbox.org>
Date: Tue, 22 Sep 2026 23:49:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
To: Fuad Tabba <fuad.tabba@linux.dev>, Manivannan Sadhasivam
 <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20260922210839.3765444-1-fuad.tabba@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260922210839.3765444-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e2d277f414c5232cea0
X-MBO-RS-META: ywj9ws3sgoax3on8nhqsbsuyr6wwpk9s

On 9/22/26 11:08 PM, Fuad Tabba wrote:
> Declare msi_node with __free(device_node) and drop the out_put_node
> label and its goto: the scoped cleanup puts the MSI controller node on
> every return, as the label did.
> 
> No functional change intended.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd75a4@mailbox.org/
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>   drivers/pci/controller/pcie-iproc.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
This is nice.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you.
