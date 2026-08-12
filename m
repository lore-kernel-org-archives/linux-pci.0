Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30F473C73;
	Wed, 12 Aug 2026 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557475; cv=none; b=DpnZHjmtSbzv/evFi/YcIS1i/BOP6uBNZkodXpHfkJS2nHnr71YoFwTqphC8J21YWFKZdo9oupB/D2hvSTLncxUr+LHsbxoWpY3ZPLFHJcn0oX/hPfdWIWZG8XrzNP0FF5SJmzGwojCoaSWYOx07619yFUx/8SpzAn1DwAt5oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557475; c=relaxed/simple;
	bh=bdXywvVtLHaAYQW1PL84FI9W+aNTIeXq/rO2t2U05tE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CuFR6dYkP5YMoYopmahjmEeeeSfbrk/F6Vw/EEUBSPpC5MV0FUTCoTblTjt47sGEl9ljhD0axi47yWFEL4OrXM6hic9kn4NaNvrOWDPgHkYRTo+6FP0URcSUIW9af2+oTrHMqfHMK0k8OXuzKWIEzN92dFyGb5NXYlhpOVoYUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLtYBL4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLtYBL4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86CE1F000E9;
	Wed, 12 Aug 2026 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557474;
	bh=m8pnupQQZqLhe3J9PcDyJGRs2XMzwrFwmW7WpVjEKCI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=MLtYBL4Rafw7j2evmZ+cTAVMy4x3OEb6aEkF1Lmm+j/gQhbmlH6SLNkH9rkLHaUZC
	 N4Akp/YqJ4zhEk8ba8+C54ocZ49imOCoPMjPVDhVB7qdTshqGI51y997jWaqkpTUJU
	 A/syW1/X4Su5EE3HKYB9rL1/yvnXzFaiXNKQTB3uImZSJgKXysg3cfwk1N7Pew5rgD
	 BaaByfmSq4FG/elpS1+hxHN3oZ+x2LrPDsO6I9cy9TxrlT3U7u8T6LKcPnYB5+cbsG
	 SGNNa54PReXkO42GRyXb+orJlnDtyaoPLTMZj/wJZAYvuauSmvI9YLcQUHP5nHjyPr
	 x0lHkax/rejzQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 19:57:48 +0200
Message-Id: <DKN5RMNZUBGM.1EFIG6TFAT3AW@kernel.org>
Subject: Re: [PATCH v2 5/5] rust: pci: expose the allocated interrupt type
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-6-dakr@kernel.org>
 <DKN47TIEH9R7.2Z6FDMEZTUKL5@garyguo.net>
In-Reply-To: <DKN47TIEH9R7.2Z6FDMEZTUKL5@garyguo.net>

On Wed Aug 12, 2026 at 6:44 PM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>> +    pub fn irq_type(&self) -> IrqType {
>> +        self.reg.irq_type()
>
> Do you expect people to call this on the `IrqVetor` (or even
> `IrqVectorRegistration`)? This is really a property of the device, and no=
t on a
> specific IRQ vector/allocation.

You are not wrong, but the C API sets msix_enabled and msi_enabled in
pci_alloc_irq_vectors() and clears them in pci_free_irq_vectors().

So, if we'd put it on Device<Bound> it'd be a bit of a footgun because it w=
ould
potentially yield different results depending on whether it is called befor=
e or
after obtaining an IrqVectorRegistration.
