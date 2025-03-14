Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B722204598;
	Fri, 14 Mar 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973584; cv=none; b=t4h9qE7FYJli/OlPKtQWtBO2DEMPNYVMPFi7f4tH9pPaJ85xUyRA5BjDRI5NsRQ8ENn0PEifPbA7iUHxjKs+F7vNNf0u9vfUi7YEFf3SHHDjLi8AuiyahBxRFP0QA3xQ6gUlDVxOzdi1v2/KL8+baoVfldIdelNyfkFvYdB/l8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973584; c=relaxed/simple;
	bh=zfn5VWjxo7ZDgOCWJO7pCYr4Hzfj9zPlbt8RdIWP8LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idg/L9WH3K1p2ZezbtEAiXtJQ50HYK5c/aOdB/+fFjuY/6iXiXIPhZ8+kFLxBwo3vcZY5c5s+yo337wrUTP5lR7bWg0/vh3IrgO9Tcae8Qb0hPGxvmO3rMddC1NQv6fg2jBP8vC9AMCM4HVCBf+gxbvrewDD0uCyQbHxqDT+ZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRA0nvSi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRA0nvSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92037C4CEE3;
	Fri, 14 Mar 2025 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741973583;
	bh=zfn5VWjxo7ZDgOCWJO7pCYr4Hzfj9zPlbt8RdIWP8LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRA0nvSiEVgTWihAcOhTP114eFFeRebng1HpbdP7CKxQkajLjVlbnmu8I+fY+tQsW
	 DMYcN2NLJvSn1wbYIhWJ8tf5CZaCt13gPMljWMboGt8ks5Yi+81w1/Cr64TaGrqcIK
	 zxhPvs/PypmaTHRYcH2yjrroz6xHFX02kIGPe/FBZeFkDaNRyCvpj9F13l3eGMC8Y9
	 0D0cQWbhW0MLpmNEenJWMmOGI1lM2SdhAjzOR19zZuidNr48koHHYlyRL/WNnKujLL
	 OMNa4Aoa/+ltwPqBUqOfEa7d1taz3O0OKilKr4gI5G/e6rrTcpDxmHgawgfbHFtm2W
	 Ji0WMQhqRXoxw==
Date: Fri, 14 Mar 2025 18:32:57 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Improve soundness of bus device abstractions
Message-ID: <Z9RoSXx7ZGhgOkAD@cassiopeiae>
References: <20250314160932.100165-1-dakr@kernel.org>
 <67d4672d.c80a0220.68408.902a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d4672d.c80a0220.68408.902a@mx.google.com>

On Fri, Mar 14, 2025 at 10:28:09AM -0700, Boqun Feng wrote:
> On Fri, Mar 14, 2025 at 05:09:03PM +0100, Danilo Krummrich wrote:
> > Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
> > do not have a way to restrict which functions of a bus device can be called.
> > 
> > Consequently, it is possible to call all bus device functions concurrently from
> > any context. This includes functions, which access fields of the (bus) device,
> > which are not protected against concurrent access.
> > 
> > This is improved by applying an execution context to the bus device in form of a
> > generic type.
> > 
> > For instance, the PCI device reference that is passed to probe() has the type
> > pci::Device<Core>, which implements all functions that are only allowed to be
> > called from bus callbacks.
> > 
> > The implementation for the default context (pci::Device) contains all functions
> > that are safe to call from any context concurrently.
> > 
> > The context types can be extended as required, e.g. to limit availability  of
> > certain (bus) device functions to probe().
> > 
> > A branch containing the patches can be found in [1].
> > 
> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
> > 
> 
> Again,
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Sorry, I forgot to add your ACKs. Thanks for providing it again!
