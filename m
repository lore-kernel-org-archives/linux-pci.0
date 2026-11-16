Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828620;
	b=4o+Hex3xPXQCxDiySeKS6fjkTZbyDhaX3SGj+Sjs7MqBsz9ehr6fj6229EsjHq32LHyK
	 nMJUZaBwfQg1eKOc7wfqAjhg1VZcbpQLYp5NLnGLB2ukZqt8/t5q02qWPgmvYWlIv1bhp
	 ZpgMcwgdMnor9YYl71j5Iqu/jrQkdidG0FQL/Av6vWOY6joKf/RkiF1w703+xBbIwdDgx
	 DtU+7d21zO93fxDFf506EiW9pk7v7sahcOQojr4kM1on5JC2LaoGDzlQQNG9mN2kxXN71
	 2w42Q89YFeZtYTw5A4ZgFkmCPfB39aybk3Q30Taf4vdTcyouuvJcU95kyyHo2WvnGYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828620;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QC1iH90zbIMkxbgTSySSELyaokORPyV/ZfuBqoBCxz8=;
	b=NNxPpCwqEs6i5L5xqd/JhRbdTQ9uqBj2FovC7T0EJGHQj3GCXQfTMYfwOtylnjm+ny7P
	 d1OGJzdSPG5pJiIBm22VRzF6umz3wofssIV19uBJvLimqh7cx6SnXgya/ei9w4R3Gb8ho
	 RgPd2rK5Y+VtzEAX6YrAV2DpLwwXCUeOy4YhWjLN9w17pn+Yf+3UTUvvwSscY0vWCX4gx
	 cajQCRNzRWDVQIQnCxj2wJpYYOH+wRbUfS2BlI9RsYkEbgpfb0YbMn8uWhm+nfot63Yx9
	 3TLAfNI15TtdaI+LBB+prEW8RJxLBkYRicDC8pnpOywnE7ojPPvwtVvzX6e28CjJQpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6703606A33E;
	Mon, 16 Nov 2026 11:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6703606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id BABAB2F66;
	Mon, 16 Nov 2026 12:30:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 92DE16031F0E; Mon, 16 Nov 2026 12:30:17 +0100 (CET)
Date: Mon, 16 Nov 2026 12:30:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <avrpSRJ0ONIYZHI8@wunner.de>
References: <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
 <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
 <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>
 <20260925051922.GU106095@black.igk.intel.com>
 <c5754240-1768-44a2-869c-6b159fd54907@linux.intel.com>
 <ara-_IPXV_i90if1@wunner.de>
 <c7a3ef34-27f0-4b0b-8eab-db0fff15588d@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a3ef34-27f0-4b0b-8eab-db0fff15588d@linux.intel.com>

On Wed, Oct 07, 2026 at 12:55:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
> So both drivers are possible places for
> the fix, and I would like your and Bjorn's preference before sending v5.
> 
> 1. pciehp route (v4)
[...]
> 2. PME route

I am very sorry for not responding earlier.  I just wanted to say,
I think you made the right call to pick the PME route in v5.

Thanks,

Lukas
