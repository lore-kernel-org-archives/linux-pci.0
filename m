Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792850972;
	b=MVs6EeXFGHvOP8YhZHMRPzC7qWEdDEZRbkExvdWHvSbvAWJNVdbYBRyQ0+mdUOi8YAB+
	 0CKd9CcHa0hVF+CHMRORKLy+O8zC9s6+UR95tf8VTOlaEztqeUXBHpMju1bHtVFQa2CE9
	 36dTQWFQioIJ7ifnx6KZAhj5gjW/uIENNN859L1ANZSWowBxT6bWM42aVMalyHMUSHAuO
	 eYwTE1r6Ltdu4btB1rfVX8Mt1vO6FPPCPncyiOs6qpJyoet7+q9hKIHHOUJmJ1kmcaK7q
	 Zz10BGtoZwL1vkxNCk5giSST3k/oNXsWGu3c7Yx2UKMwjV9Zskkccpw118kIetGuUxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792850972;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=P05892k1Sjquw3DwLgvMsJENfB8hU5xbQKeOl7fjF94=;
	b=cswWQUAwJK/giX/cy1c9FOIJECxIsaY0d25HyGE4TsBXJ2l41zhPKKN7bp1qepTXIjEs
	 qsm/2XlwO89TuP0QyDdY4HyKdcwkMnGNW0t4AgQGkj3td7AM4eSEV8lE7j1rTFZvF0U6L
	 gygTzIhxuvLMOscAmIDzsc70UZCYKRnFi2hfPcLibZrHTtCRx07RYvWhjc7S+e0jiR+S0
	 4ZAAmLtANTRYsSPB47jBa9hnhUvZv5ZX5NSVVhx7pbMguoO6+3FMlmsTINGJLUoBlbyM1
	 hsU+mA4bMHmKE6vQMamkrh1Lf+PPqWAWDH1cZOH+LpHpOFQ+uLxYWBoFo+D71UBLr/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QAzim/kk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAFB606A322;
	Sat, 24 Oct 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAzim/kk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F31F01825;
	Sat, 24 Oct 2026 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792850971;
	bh=P05892k1Sjquw3DwLgvMsJENfB8hU5xbQKeOl7fjF94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QAzim/kkzZl1Qpjd9NwMf58UZs0gx2PV6gyGxy6k3biJLIDTM4qZMxy1cySlMlKTN
	 PLupJ9vlpOvTWYpPpIl0ogdtyXP5gQSct+NRTmK8g4dkJZ8MyVWihZP5CGpWE8puAO
	 mSzMYZ6Zcx+71j317ADpKM/hM6ymyZWj3NDoXW8QnA2UVJ0EBJctH/XyqP/skzKzf7
	 cXK8kS846FcG3OaiM0lMJJb+oJPMfbJw3Dlp/DD1xmrkSFmezZbZ2SRDkqpjEE6vSH
	 04QID0wHyCwLbyDKX3UnvZPcRB9UY2ijymIL/46qlXVyWCYBH++CE6NkY8AMLBw1FA
	 F0ADrWsyEI5Ew==
Date: Sat, 24 Oct 2026 19:39:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [GIT PULL] PCI changes for v7.4
Message-ID: <aty5tHQi8YNM51Rr@debian>
References: <20261021224355.GA2571577@bhelgaas>
 <CAHk-=wioEin24Sm4DM9TFgYw=kH+PR7NHQ_Z5pzk2=AfpQd0qg@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wioEin24Sm4DM9TFgYw=kH+PR7NHQ_Z5pzk2=AfpQd0qg@mail.gmail.com>

+ Lukas

On Fri, Oct 23, 2026 at 03:41:39PM -1000, Linus Torvalds wrote:
> On Wed, 21 Oct 2026 at 12:44, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - Fix leaks when ACPI APEI/GHES error events overflow the kfifo or
> >     mention a device that no longer exists (Priyank Rathod)
> 
> There were conflicts in this area that I resolved differently from
> linux-next. Somebody should double-check.
> 

It looks good to me. Lukas preferred a different approach [1], but the current
version does the right thing by calling pci_dev_put() whenever pdev != NULL,
irrespective of the state of 'err'.

- Mani

[1] https://lore.kernel.org/all/as4S2GFTRLLuwAXS@wunner.de/

-- 
மணிவண்ணன் சதாசிவம்
