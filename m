Received: from mail-108-mta42.mxroute.com (mail-108-mta42.mxroute.com [136.175.108.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1A30F808
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769826210; cv=none; b=CkMV6EaRQjR6YW7Elfma+BEiqE+PsLLgDQcQa7TuZhxyeYPUxv/A8i575c7GzW0ZR1Vr7hoqEwf6si9paeRGaYja6bb7EeM4Qfd/APgzp076M5Ro7/oP6EVf/2Eo/RmF4n00u+82sHIFcCO2awLf6+csdH05H2ilA8SN3jHcgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769826210; c=relaxed/simple;
	bh=mYLu/kKuwG/6AdpUKPdy7IW9x3/OQFEdELFUHhpE9w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2mWpdN44wFuTcjzyA6KeByvCL8eS71dYVeM3M+h/KTm2/c5BgV4uOG3tm5hqhj2ELeyFBCsvLGUJKLCVTnzF9s7Jhk6mVEVPmNpMR9OPci2VwTOrYv1FMrPWL+GQbVKE9nwGkTeZvyS9sZa7jwcl+hC04FTktVKAElJCbgGujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=LacrvBTD; arc=none smtp.client-ip=136.175.108.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="LacrvBTD"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta42.mxroute.com (ZoneMTA) with ESMTPSA id 19c11d7f9d40009140.00e
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 02:18:12 +0000
X-Zone-Loop: a0fad8c46ff560be2e9a101b225f752d320bfeb67800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mYLu/kKuwG/6AdpUKPdy7IW9x3/OQFEdELFUHhpE9w8=; b=LacrvBTDJ5mwMPv0RxYSCPqqWL
	YzGc6O4b1RQ1LQa2+3K0KA8nflx7JfM2si3t5MchCpNLl3kdm1BIAoP52hRyIrflx+grF0sK3vYaC
	BgpWfLJz2KjZbf248VrT0uG2AH2TlNM+RFOh7UW58beaAVYXG+U1yi0YYVnsI1vvlI+hI6n7+53py
	JwgxhyLNlF3+0HlSpdzAfuCbob91lOxiUse5r0soOqWKei5t6/j9WwBFpRypKEzT37J6q+MW27XmA
	fXzZPrKSlIz4KouANSaBZh+Z59ceYgQwuIgERESfGFQwxwOGhY1q8zcDmhMJ2Pl/MatSU8rCiZYU4
	upedWscg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: charmitro@posteo.net
Cc: dakr@kernel.org,
	ojeda@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] rust: pci: add config space accessors (and a small in-tree user)
Date: Sat, 31 Jan 2026 02:18:03 +0000
Message-ID: <20260131021803.1146484-1-zijing.zhang@ry.rs>
In-Reply-To: <87sebmzk0i.fsf@posteo.net>
References: <87sebmzk0i.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Hi Charalampos,

Thanks a lot for the review and for testing the RFC series (and for the Tested-by).
Much appreciated.

It turns out I missed that PCI config space support for Rust has already landed via
Zhi Wang’s series:
https://lore.kernel.org/rust-for-linux/20260121202212.4438-1-zhiw@nvidia.com/

So my RFC is redundant and I’ll stop pushing it to avoid wasting reviewers’ time.
Sorry for the noise.

However, Gary pointed out a real usability/doc issue in the current API: while
`ConfigSpaceKind`/`ConfigSpaceSize` are re-exported from `kernel::pci`, the
`ConfigSpace` struct itself is not, which makes it hard to name the returned type
from `Device::config_space*()` and also affects rustdoc.

I’ll send a small follow-up patch to re-export `ConfigSpace` from `kernel::pci`
shortly.

Thanks again,
Zijing
