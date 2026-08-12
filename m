Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4239EF24;
	Wed, 12 Aug 2026 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567723; cv=none; b=U9jPSc+8gav7ekNPCbgP/U8D3s5JrfGZA70L467TXKu+nHDPUsaTXRjEIv9jJYTEN1Qft9KPQ9hNq3KZ4vMV7zwpPQGCFAoYCXRVmqFO2VTyX3k4ZdjKs+DMX6cBKNXFs6XcKC8nUXA3hfNwU//BY6zfsx8GkQhS9fcWFPu4tmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567723; c=relaxed/simple;
	bh=1mN0W9jVS3pWyld65UwIqwvx8g5pSH42AxTZxBPJpSY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Xx9IXMNl0+yMeRbRg3tRiZCMA/PurmhC7caRyqzulA9SPSETgsQYz0JrfgI40qDrIk2riKAW3lH7HSuKV5Mz9ODpHTHrU+NWGxHtxouK9DbEOM/l7ITCU1ilbKYwQKbUpu56it4VfRNTlqCbgkbH6+Jf93Fr44+FsesBS42udlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTwyNwcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTwyNwcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93A91F000E9;
	Wed, 12 Aug 2026 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786567722;
	bh=54ZL8Gpq8SFzNp6XwaLdeir1X0WUzZIgaSehqvjcHxw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=lTwyNwcsu29wfBKMkMFvXAWw2zBZ0F7zLYmqbuL5fB1y3upbA3+yChXpsySb+68Za
	 FbWj00Brsf6TbsFNsT+QR4PUM1vgjyPgARXHXLpZLwCUFEXWMGMgwwT3H30NmPSShB
	 u0K3+EbzpcGZjoGMlbQ4YoiPqtaSy7ehtRrYgJH1+HP4yRlAp7TCv8QUfPwBb/jxzr
	 ecfjplVrUnZ+ZphajAuuuicUCj5nxGAiKo2Yn/gGod7BCGXMGt0LseNI3mcextiCc8
	 WwDN3t/wzsBvQZwXYQBUGkktg8spht94IBNwT2NhNMy4tj4f9s3JVmoZwQcqYtzHBs
	 5QHp41GZ0Jq8w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 22:48:36 +0200
Message-Id: <DKN9EEKUAK60.1M10BUHE5C6SS@kernel.org>
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
 <DKN5RMNZUBGM.1EFIG6TFAT3AW@kernel.org>
 <DKN65PE95UMV.1NW8ZW80Y60UC@garyguo.net>
In-Reply-To: <DKN65PE95UMV.1NW8ZW80Y60UC@garyguo.net>

On Wed Aug 12, 2026 at 8:16 PM CEST, Gary Guo wrote:
> On Wed Aug 12, 2026 at 6:57 PM BST, Danilo Krummrich wrote:
>> On Wed Aug 12, 2026 at 6:44 PM CEST, Gary Guo wrote:
>>> On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
>>>> +    pub fn irq_type(&self) -> IrqType {
>>>> +        self.reg.irq_type()
>>>
>>> Do you expect people to call this on the `IrqVetor` (or even
>>> `IrqVectorRegistration`)? This is really a property of the device, and =
not on a
>>> specific IRQ vector/allocation.
>>
>> You are not wrong, but the C API sets msix_enabled and msi_enabled in
>> pci_alloc_irq_vectors() and clears them in pci_free_irq_vectors().
>
> Right, then putting it on `IrqVectorRegistration` does make sense. Speaki=
ng of
> which, what prevents people from calling pci_alloc_irq_vectors twice with
> different irq types or with both IrqType::Intx?

Most cases are fine: INTX is idempotent; MSI and MSIX mixed up should be ca=
ught
by the C API already.

I'm aware of a preexisting issue with mixing INTX and either MSI or MSIX, s=
ince
calling pci_free_irq_vectors() on the INTX one would also disable MSI/MSIX.

I plan to fix it up when fixing the C bitfied issue [1] with an additional =
flag.

[1] https://lore.kernel.org/all/DKKG2QM3YJYB.Z2H2B2UXJ75N@kernel.org/
