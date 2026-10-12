Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9D3B9930;
	Mon, 12 Oct 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846955; cv=none; b=Ydsy7Su6dN+n2Bo+22ve5rX2oZilBZiz2vREJlO7Cacrlk4Az7AyrnqZLJ7GhC4iL+VhXrdYn2T0DvImw+N63eMR1bDOMBEPwgZPDjIR4NDWyhPZDUR2UupblYI3AGJQXEgYcyKHybggPMkcDTLX3t1GOVTz7l7oB05oquXOOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846955; c=relaxed/simple;
	bh=3mEcGqfH+ZAtf7001rTj8rbQcPHl2ut0eBpCWawxd/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNMTNi/WBqqs0mv2W25Kw4kiM3/h23KhppYbgxFCFROEsE1sABhuakt+WU7uhxcER3cuwZNI9Z6irTOoZmbIFmV8h5X9KccAVkBcXTKbqM0PaRrwVDabd97wjq4jIkkGtdBF/tpJMhy0CYishfWRf3f6oRUxvsOnOqrBFYSO0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioZKdC0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioZKdC0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B7D1F008A1;
	Mon, 12 Oct 2026 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846954;
	bh=7T2N0Hfigtu934f7TIFZHXejcBUCOyKOnN0loNPPn0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ioZKdC0ZqNCtcJQmCya+OTq9cHK1MgFz1Lx3oEAp9CElTc4LPOOOj7TE5bEJXnGPD
	 uIf7/xPBnfnPXecJ/cxT8ZRyo2prevJHlXL/oZGCn0w2Mg/T/nwnje+B0ZwCW+o6zr
	 u4CceVIpGnGCOXE4/gv9dKSrqcmLDSY3qAsjrTCgNvPAHxEDCAz67vTnOIwZ1Z2B7k
	 O8YFTzG9gwTUWp/MbWiSIOtmjjx3kNOf1KPyQ6jpmbkIYF4u87wj7DGIMUnBKbY8/J
	 YQcjUUkKJd0nm2Q2cdbQpp4FgbQJxlQV/RCevV1g7Z69i3RthKkwB1r3MctvRTj1Po
	 LRQ5877MUjoRQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	markus.probst@posteo.de,
	cjia@nvidia.com,
	smitra@nvidia.com,
	ankita@nvidia.com,
	aniketa@nvidia.com,
	kwankhede@nvidia.com,
	targupta@nvidia.com,
	kjaju@nvidia.com,
	alkumar@nvidia.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com,
	zhiwang@kernel.org
Subject: Re: [PATCH v10 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Tue, 13 Oct 2026 01:15:46 +0200
Message-ID: <20261012231546.1611388-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260906060404.3336193-1-zhiw@nvidia.com>
References: <20260906060404.3336193-1-zhiw@nvidia.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 6 Sep 2026 09:04:03 +0300, Zhi Wang wrote:
> [PATCH v10 0/1] Rust PCI capability infrastructure and SR-IOV support

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: pci: add extended capability and SR-IOV support
      commit: d4ffc4896b3e

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
