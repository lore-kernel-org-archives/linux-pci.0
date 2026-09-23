Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB83AD513;
	Wed, 23 Sep 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189182; cv=none; b=MDsuSQmzFl6PkbvjPJ1nlDIXTZwHjzRHEpaphtEMgEDRLE5dcAuGrWFwQaPP/4fu1HT83If/pDma6jSLN7NZLu3KW6iALIFsCKVoxj/k2VrlaXx/2f/k50fIgUh7aX3LcHFFwXlGPRuEEX1NHYQjI9MvBYlswi++shMGBgOVB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189182; c=relaxed/simple;
	bh=rH8yAyqi1c+oMnQBQmUIueQRmppbfeO7vw2UuyvMbLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReXmNqtIzO2jz4sn+8ax+2nsEIbyOGjA43P6ZQQPf/0m1XU+7ER9OprHAfdlPt5YJMXRWZ4XKD3n6ruP0WO4sOCjQMm26SZUOXcX1/WxQARvCWuJ7KTAGMl6m3EGQU+gv9GjpPO7x5xjzZ0ij1IAevD1GJXxJ+AZ7ytvVT8AdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=V62zPp6n; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V62zPp6n"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hqmBj1G6VzKqJw;
	Wed, 23 Sep 2026 20:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790189165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5knNz61kSkSju4U5VzB8QE+YbN5s70b+UWzok69nnE=;
	b=V62zPp6nn+wtR6RFFFQqpGTFBA64Ie370TOl0quQ/rUGHFjrJwJpp+JVeOPaEGGpZfqNPr
	WfBB9Q3vx6yEaMi8sVKAOj7kvFhE+rXahmvhByGhwImANRHnPPugHKQg+TWMKp/9tGF5Ld
	EHEnM01VtoB5yTH1wb1W5iUEa7/e/BDajWAiWtlL6Gupz24kMxI9fKbXe/5jjC0uKeiFXp
	NieNTYBIr7Hb80uFCl3mKZIT0seNptWqrl3spDc8BgHB/BMeB3b1AsTNJin+lmXMq2fem/
	WpoD93Jpxpy74NADj2kOOrvhCp3eNYTPJwkYlgz7LWI6Spqg93l4ZoYkbq4qhg==
Message-ID: <3a964a4c-56bd-4103-9de8-ca7da48c9b01@mailbox.org>
Date: Wed, 23 Sep 2026 20:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
To: Fuad Tabba <fuad.tabba@linux.dev>, Manivannan Sadhasivam
 <mani@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
References: <20260923180749.3906547-1-fuad.tabba@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260923180749.3906547-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9226aae27c1171cb7c0
X-MBO-RS-META: ua3w8odx1exwhj18jy6qmfrxxs17ejgs

On 9/23/26 8:07 PM, Fuad Tabba wrote:
> rcar_gen4_pcie_host_msi_addr() calls of_msi_xlate() with *msi_np NULL,
> so it receives the MSI controller node with a reference held, and every
> return past the NULL check leaks that reference, the success path
> included. Declare msi_node with __free(device_node) so it's put on
> every return.
> 
> Fixes: 8d6af27c0a73 ("PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260905213855.8D6671F00A3D@smtp.kernel.org/
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Retronix R-Car V4H Sparrow Hawk
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
I liked V1 a bit better, but either way works.
