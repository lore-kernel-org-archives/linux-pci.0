Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291139;
	b=G/1skbRlAQ44DiryNMluEXlvjisOKa1Qn/3Q9nBCoTWBe6/LlxOcrn3ZAMCkqzkCbLjI
	 gumXudvXR/JI82prEJOSbbYG74DE5wu5hHeHaSaFzTQoRyPcNODp2q3uzGcRWFVnx3H6c
	 OolVqXuYGpYlr5Se8JmjB68MoHIuLIlZo/L9jq527fp8qcwdY3+x7uU12B/M09Il8YWZD
	 LfwaJbgcKw4xK7JVaPnhDkvLNy8M5OtN9IIkAA+73NlmVKhUkBVs9KXd5w9WOqH70ZRcp
	 p6V/Lrydr4aw5S0PXbIEqWauM+NPY96HzwX6kX2zYFuZX5otiVjB/QhJm743pOu+CuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291139;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:In-Reply-To:
	 References;
	bh=AMEe9uy+oW3f3SwsgSW+M/nxThzS0Dp2S/VJ3lcqVCQ=;
	b=1E8prIxy11bGv8FAOsZHRyJcNBQ7YXGXVZ2fVcUDX33u+jdZYHBXFYLRiMv9UA5XfAt0
	 JNpBSP4ANRmHmzOIhwEW/5eikRN3cXaWxE8RcdmiQrwHxvtPesBEU6xX2tGGCuUmXk+Ej
	 rclVx+/9Sko3xaXLwpdq2bYBE8XUuvmAn+S3bIIGa6co0H9Tx0EdtWraAAP+Y9wVnvmsa
	 DNPV1Cdym8Pt610TvxhFnpgCsl94sdpD2Mz0Bl85C/UdgQErto/nWU0ttKeOWITYhl93x
	 lZ0rWnqWDpM0O2GEdeSBBKogLLiwu/QMQyWKY6ne+wDIjdtmbO1KBNPDl2gjWO1RPDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cressey.dev;
	spf=pass smtp.mailfrom=cressey.dev;
	dkim=pass header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=kJhAd9K4;
	arc=none smtp.remote-ip=95.215.58.191
Received: from mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A9606A32A
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5A9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=kJhAd9K4
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AMEe9uy+oW3f3SwsgSW+M/nxThzS0Dp2S/VJ3lcqVCQ=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795291136; v=1; x=1795895936;
 b=kJhAd9K4ndTKd5xgwqITCwW2p0FEvQy7CDm3hX+FKOvASBD9sfGYZDNmb0LQZad+P0ZxQyzr
 62PUFq8Zf2Uli5rQj+1KJqdUVqItG8zhPJXNekBSU3qw3Bu8Rcd+Dy8MaHD29QJ7zTGDMPCoDFs
 HtOLxml3QUYT1a6UI1YsQpqeDjoe9bE/r5WbjM7+qZt7K4xjNGjt0UbmOWWRxx8j4q2eXH2Wgvs
 7dqs/FrjhiyO43ZURYhSGGRkrMrok6eZ1skkJNRICajA9F+o8r1bAUCs66KQbqinscdzXU94Gg5
 uNq+4UNfcxFCoz0xmoVvKQcSTdib8N2wg0WDb9MdgcHgw==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cba09444c80e291f;
	Sat, 21 Nov 2026 19:58:56 +0000
X-Mizu-Trace-ID: cba09444c80e291f
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
Subject: Re: [PATCH v2] PCI: Add ID@path device format for pci= parameters
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Sat, 21 Nov 2026 11:58:42 -0800
Message-Id: <20261121-re-913694b40323@cressey.dev>
In-Reply-To: <JH0PR01MB57796AD53E6089D3254A76D6DC7C2@JH0PR01MB5779.apcprd01.prod.exchangelabs.com>
References: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>
 <JH0PR01MB57796AD53E6089D3254A76D6DC7C2@JH0PR01MB5779.apcprd01.prod.exchangelabs.com>

On Mon, Nov 16, 2026 at 09:21:00PM +0800, Wei Wang wrote:
> Nit: I think this is more readable with a single '@' check:
> [...]

Thanks for the review and the suggestion. I will revisit that block if
a v3 is needed.
