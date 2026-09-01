Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F3426435;
	Tue,  1 Sep 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280307; cv=none; b=ctIUQ4kaDU0oEqX6Uejwe47zSYr3M4l5HG99w1FDM8RUeFA/1GwxBGFz0oWvZj2fy/3pBbkcQ3H+tzlMZdT7vchp1e/pdOsgzy5QT5u5+d68se/ZJICAimCkWLCGNflFofvyDvhThnfzJ/BwuMiozGcVUEcfCu6u4qJDAKFbLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280307; c=relaxed/simple;
	bh=m10+P4NzGrPiVA/TSDHUAsej1DpKJMn5hF4nAzL3Etk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oic7d9Hjnv4n4n3YlsAu/7hGCemIpAlDmTxhwik2X/kkYbgD6S8uzWUV0uBACgjSzip0ssJlk6ebVMlyjW88hhHjpG00+OYhji4iddV/73y6IEgjMYW8vxjLGkFDUTtPuutATx46fLh1OfVY5HxlXdxEztBCxmeQhhQZBr3F7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHz1e7x2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHz1e7x2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9031F000E9;
	Tue,  1 Sep 2026 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280306;
	bh=LBvm/7ZrwlOTQ+BvdFMZgBPhvkF2afoQkCVqiqPPYIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHz1e7x24f7QvN2u0Nc4rhpOzUmG0YphhOrR5HTbVkJLbQdScFeRTVqfHKnvUKb+j
	 HrfTdELz9LsNuCRBzDPMaVzyXLZn6JnWDBKb3zC5wsMPSDXwo5swOA1ymuvp8deLBe
	 JIoanNQO1gBdUFP9z86FCrwvTFWUNP9g8fHboqXd+oR3HdnhVqwASAI83GWeSlrxjC
	 2qGzBUcyLHww8aXu2W4fazRNW2MgbPuesuShcvXdjgh8spljohJ+eb8i3PsMLooIQR
	 11xBSvqeBxmhGjWFeyRGam1MfCRWokaAsv2yiJk2PHagrJjCwX1H9iufMg9c4JdZNA
	 9/ZLXVZ7ePT6Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Sophon Zhang <aiqubits@hotmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit in u32
Date: Tue,  1 Sep 2026 18:31:38 +0200
Message-ID: <20260901163138.1321109-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 01:09:53 +0800, Sophon Zhang wrote:
> [PATCH v4] rust: pci: reject IRQ vector indices that do not fit in u32

Applied, thanks!

  Branch: driver-core-linus
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: pci: reject IRQ vector indices that do not fit in u32
      commit: 8d7b3e41ffec

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
