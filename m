Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14894309DB1;
	Fri,  6 Feb 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394190; cv=pass; b=gSqEJGK3HYKdJOz1KQ175YaxTMeUig0Bq0ksIdLwXpQtp1KmXo6aKOhm5FrZZZk1ptIqolWXTKqtSN3wqrYC6bm5AgYnmnZYJV8pRg1fd2JwJqSn0xqVmL2VtGi4uagRgwEMT/Laj2CtfLgjGMhbj0puNdh6px9x++kfsLRVgJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394190; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XR+s5fusnSyeKaiRcukbUePwWKTQxkqCYywDadMLH7wXJA+BtLEFcAT4OtxXKe9lcBVDzJqtToRp+G1QNOHUqgHCWQvAQQDXZtiqxKzDIJqBpGMNzMHC9WgY8SqvxYKUjuEuBxsahLydfwjKeCvgkYd4H+dQDEXHjEPIVm2gTc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XwCAx3S3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XwCAx3S3"
ARC-Seal: i=1; a=rsa-sha256; t=1770394167; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EDifnpJc1J+jdVAlCFuS7kKQU54PkveowPLed5FxLku+OwZTRQTY7+z3n1ExLB1zVlkxXZSjIOq0i2+cDalB/RU8F/dBoVyx+sgB34E3rx95179gIyK7ZMQVObq11jo6R+2FSvOa+aelnK2TEFmKij1e32jmT5rqXf0wZ+8tLXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770394167; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=NamFKyHKtGeLWKvj2LEEr/IjQSxG8i1ICeL4SIbGaMsK7hYXjATuV8O40FFuVDO9O9KKoNB0ifSyAckX2NvrXohFQoAJj2w99FVASQmfEGIPyt/IeMyDnZP2hsWlsW/6E2FO3XFrcvGynNSeKhR8c04fcn8smyp18HSeCBCBwbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770394167;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=XwCAx3S3ofbTWY/ZMVP16Unzdr+r1+PUE8x9gq+/AM2kIYHfO35toRvprsWkeX7g
	eDByp/+wpWrl3x4yXqqqsy80IORg9SNwCVEdqY8XnwkfnoqLTQc9Kf6uo7U+hmBnzUz
	dqQbva7WM7e+jN8UoqAyowgB9QbkKaPeAj0FJC3k=
Received: by mx.zohomail.com with SMTPS id 17703941648306.714167748734553;
	Fri, 6 Feb 2026 08:09:24 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 3/6] rust: io: provide Mmio relaxed ops through a
 wrapper type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260206-io-v2-3-71dea20a06e6@nvidia.com>
Date: Fri, 6 Feb 2026 13:09:07 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Zhi Wang <zhiw@nvidia.com>,
 Lyude Paul <lyude@redhat.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Content-Transfer-Encoding: 7bit
Message-Id: <72AE02B0-27E9-4963-9694-D3468E5D8EE2@collabora.com>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-3-71dea20a06e6@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
