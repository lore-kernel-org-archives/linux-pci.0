Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932392F85B;
	Wed,  4 Feb 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220771; cv=pass; b=m2kDTZr3jfhzzMwtsPfCTaV36YVQH4rY1lAaA4n3ewNnN3I9SyHAd8jqErPP3Q0Cc7AJoldwJXiAY370HRiZyR4LSMtX7OWiCrk+NTgN5697JQnuMHDhafjrs4b7ws+e50fhrWA5Et2dRK2EP8i/kABfSYyMEMBA510xk7s5xnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220771; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RIkQHjIsqRZJYsUlaQKHElhUExTtN0UbUKpra0SmTe57VtMi0pRF16l2BwlHkmAVuxbPAGMYOI+0JwvnZklG+zUOZdVsj/2YmJHPiKH+fUCl8/mdFiVRGcuF8mmZ5krbL+EtabxqqZjkoIeO04VoJuCqvlPu+sNAxmFF42z1mwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZMGeQBoF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZMGeQBoF"
ARC-Seal: i=1; a=rsa-sha256; t=1770220752; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RbBmQ4/imz68yPvgd4nDvnpMwwSAdGPPiiClrXMSgbSyi7oCqmiVzrjoYKfZYtZBUup9vmCs8x8JUgHxoFsxTjR5bv8f2ZVo6YQaZI1LtFaVacPAuGSeRRqbfcxSp0B2zBafaq9r4cmhZMAaTeJYWWpM8jZgBP9j8qL1J05Ftms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770220752; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=ML8tFgVtPKDiEC/gFFef3B5IeK9yQf8OIK59V+muGDGjTQq8+S1Q40Tp410oR7XRQAG707oLZWt4Zb7nZKKVgtLQg8g5Dtv3AGZZJxnikibCFTk6nCTm9buvI7qYXJMjZwdvIHzupaF3hWokTx7Z2G6Axg4hLl4fUQQ9QDgC4jM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770220752;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=ZMGeQBoFbhsqP0JU8+8NUWL8lSATfd2lQpk2xadnudi0frcabOKnJO/xU55HhZlX
	HVB97aj2+OJ9moCve6qc8jjtpe120a5bVO8Nk1e42adfn0EwP6wqUKIywhxOS/1GdUH
	TVaMGv90WZkSDhZ0OLKabLDr5KU03//N369ArJm8=
Received: by mx.zohomail.com with SMTPS id 1770220751775218.7288851516015;
	Wed, 4 Feb 2026 07:59:11 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 6/6] rust: io: remove overloaded Io methods of Mmio
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260202-io-v1-6-9bb2177d23be@nvidia.com>
Date: Wed, 4 Feb 2026 12:58:54 -0300
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
Message-Id: <50942329-2CAD-464B-AAC6-2B147ECF7385@collabora.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
 <20260202-io-v1-6-9bb2177d23be@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
