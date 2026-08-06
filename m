Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92F220F2D;
	Thu,  6 Aug 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051906; cv=none; b=m3znH2/EvG/3dUc3sUlZVZWBHUFrwkxVJwMEn7OtfuSXfrhumS4LYwbqupbYN1vqVVPSsyMYJ5LTbRwW9tS3vfbVI1WJlbraaMeFtHKqES1hNTNaIADJpL8aEMk/F6IaxrFPPLraRd4LjnPQd15nlzTt/Skzyd53Aiz8cBwVwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051906; c=relaxed/simple;
	bh=9ltNq9oflccewiUUPNhzH4qk7ncxJvafRlNdeGvDcCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJ4OIye4T0+XRVLvg3WPwsj4N60kDi4PTUAPZPSrq/6QKyksV1gFo5m462wR5ZlaqFE9eW1IMTOzxVzdnDHRUmSvO78CYqG6FLPNhJLL3mfHb31WOeYh06Iy8AaTABKfyTOt8r5JOttjNLzMoipwb5msPIamNOKbN9YO7/w+u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KopJ8D+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KopJ8D+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C1E1F00A3A;
	Thu,  6 Aug 2026 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051905;
	bh=H5vIWcTOlsFxJmhOAKA8dyBFGOJufDXvxTLahxqZMUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KopJ8D+L3k2Q4AhCVUvaPYpXiveioTF9gClo3Qh4+338+MC/uy6Y5kZCILC7VWLvS
	 yzoReLT/FCdUeIoBqyQ9dfiOy/Jtu5f3wSqxjtZguoCxN8umv4Tf+2EIf+MkKfRAVQ
	 6/kDaPUMp6wGCCmOnoFxGZs2ErftNOWKzYRDwJr9CZl3WjEj0/LO//uggj7UnhXeBT
	 YRKjPjsAr2Iq0/nojqrJirePYPfYE3qgE6lcWckEaWHOkc7NHZ4TMwimgdkzByNe03
	 Nq6B9DfWWHyawLiaVIw4ygoGejURHg6Irf8MqOB3IhnKI+BOMWa2IAZsm090Lad0ku
	 Uc9CZ3qxMsZgw==
From: Danilo Krummrich <dakr@kernel.org>
To: Ethan Plant <plant.ethan@gmail.com>
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
Subject: Re: [PATCH] rust: pci: Mark Device refcount methods inline
Date: Thu,  6 Aug 2026 23:31:39 +0200
Message-ID: <20260806213139.3131211-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
References: <20260804-inline-wrappers-v1-1-16916db867e5@gmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 04 Aug 2026 16:24:25 -0700, Ethan Plant wrote:
> [PATCH] rust: pci: Mark Device refcount methods inline

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: pci: Mark Device refcount methods inline
      commit: 56c193a5cb37

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
