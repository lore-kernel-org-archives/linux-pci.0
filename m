Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E51DDA18;
	Fri, 25 Sep 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312982; cv=none; b=agfaB/157351jZq5dSDiFR6Lraqup1d69hCaUR3nOm4IzadlTU1KjizyljCxoJOImQPjVdzM961La9/jSrRr1nQ65XGMB2PFCmsuqKVjUhbz1ouTbfcKHqyy7zY0gD3RGGt1fS2aiBEpAIh/nCW1WYoHbpOWpuhjVwsPTG9I93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312982; c=relaxed/simple;
	bh=wEwPOc2WQyyy/2t/P4dqWVW+sEpoy7tMrAbctEy9e5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndKD8Y2mf/QU3G70MX9eA4BgtO6a6HJFDqIv5VTLxQF/5p+tFXj3st37mWUZ/12if+0yIm6kDqvTe2GgXtqHmWL3PCQv7AUzjxvMb4o9SWW3SuoTmHvOga3oeA7nL4ewrDzLMrJ0TWQmLQJH77GdaOX+aMwGyABhDzkLqkbqzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SjaCNnKr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=m1o7XIhn; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SjaCNnKr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m1o7XIhn"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hrdzc0wBVz8v2B;
	Fri, 25 Sep 2026 07:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790312972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKsKlVZl8uuQQnOAtnTUFnRYg7AX745LF+QJJaTDUXo=;
	b=SjaCNnKrXGGiqKcSR4se9BQjZG9Wt4pQZGUD7X3xeYPGwGaAxheKCJIynR7eAdzvCJ1FkR
	DJuCDR5LKpCujIvwHeffkoPPkeTN2AQHYjTKp4TjsKgbGpmD/d27qc/xoBcY2rHur2+sCO
	e3935Z1zMM31biNB7rZg9VQBzidOZs97gfYPaiE9CQ7NAVKmKkrN0OWqSLE3mqTkyPSsvf
	ZmiKPvOLEZ7fQlcaSBBXPaKtNr0LyLYstM27kVHNjwsV28UewMAPQAcltWfaqRieDoGNca
	QoG5FntjVON/OaHTJHstanz8oF10tEHGEl6Nl9MGW3g7fxlGVrJuvCuZIypLUg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=m1o7XIhn;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ff358193-8c64-4200-aa9e-fe6619dc8948@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790312970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKsKlVZl8uuQQnOAtnTUFnRYg7AX745LF+QJJaTDUXo=;
	b=m1o7XIhnZb+Vp/uiU6FDd52l3TU+9RaTmhY4ZvsQ4p36Bxb4xvkE02HjZtjcqn+Ru79gRc
	pZZmiuWEbFoIXN3O9sAwqrf0zWN3j6jbjJlgWAlF5FF/oUQhT+UoOT3jG/ubHYyXFqiSNq
	ZPGjREbZ/iBMnflTXKckl8anmD8ViKUUUVPcMwNp5aOpXZ1vu4sXVdYnODmRuSYZrMyyvS
	ehdgeqiWFyIzgdbKSw10uCNsLTRM0Y9FKMcH5jUU7LZZdTeCVFnEoFjIhjgUzZcGe8f/oy
	fb47M0brXDmZD3a4m3KxOG47rmEabuI1HtNNcr4156YM560LYNEbAAa/rKPcXQ==
Date: Fri, 25 Sep 2026 06:31:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar: Release temporary device tree node
 reference
To: Yuho Choi <oss.patchbox@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924010418.726980-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260924010418.726980-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: af84b3c26f185d3a6bb
X-MBO-RS-META: xwooipfiedu7iqqtgymzp9ashnna8ept
X-Rspamd-Queue-Id: 4hrdzc0wBVz8v2B

On 9/24/26 3:04 AM, Yuho Choi wrote:
> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Drop the reference right after the match check.
> 
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
