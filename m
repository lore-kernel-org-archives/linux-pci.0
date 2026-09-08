Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52D95519AD;
	Tue,  8 Sep 2026 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908232; cv=none; b=elJj07oqUJOxPKK/qzgdEBEdD+WpclMDjtlZBtvLAfnFA43YrHkbvZBy7u1p2Bc1HN0ypV5EdJDa2Q44WaqM8VscUgGUjMKwd34heVOimsxrnzZHgOmJzRxgs/15zfLH8b+wuHh8S7NQi6rPz8vZZk9hiMXndMdFCtPbPcz+aMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908232; c=relaxed/simple;
	bh=kFMz61bsSeVxZPVzvMmlybzCV4rtrABCn9D1StHNpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnOXTtkqH2pwA9osfUouuATXPHhB6/h9ijaERh4AzNR3PMwo5DqDHR0UvOyKIpHxNiiRErbcA0YrTQwMDcfVsvOdKi6QBWUvmWcTkEIPCPnKVzrE2TK/BK97gdr8rk5wcMvCeVemMl4+x0ltXtmECDXH96FuC7j6S+CZD+ZTdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDQLFF1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDQLFF1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD31F00A3A;
	Tue,  8 Sep 2026 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908230;
	bh=JmSpKmNIGuwtBGwWNlLCzEn+j2a/Pzi41loRI1R69tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gDQLFF1WU/6zDJOhTFeQh0hNYRCezlbSR7yubbGbesGlWOJw0hnA3+P13642yhq6U
	 WvPdwcdIjVtXMM5Vdgu83pXfM8F9uCGWFnVYQ0P9mY0eLzktuKQvQOA82cASNB0gbj
	 LW4Qr8wiHZihD98r0ODyIgIkcFr3v0qoQffiLoIzfYbKxf+P4UceaW+EM0R4Mxi4BR
	 2WNr1fxNCgknKTyxvLMm/971seMUznKe53hcMPPywFssDj2gTgnxppAgcPWZ7pijm1
	 LlVW3Lnv05htUn2/rbSz+q7mJkNLqaNFG3vfVs9UU/AniVF0R0CHLATDmFijkfw0+S
	 KbLAy7IX6pOKQ==
Date: Tue, 8 Sep 2026 23:57:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 09/21] lib: rspdm: Initial commit of Rust SPDM
Message-ID: <20260908235704.7b5992c3@jic23-huawei>
In-Reply-To: <20260901010347.2614656-10-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-10-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:35 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> This is the initial commit of the Rust SPDM library.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
Maybe want to consider updating the copyright given you changed some stuff
since 2024 :)


Subject to tags from rust folk, this looks fine to me.  Note I still haven't
found the time to actually learn rust properly so this is me as a c coder
reading and mostly figuring out what is going on.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
