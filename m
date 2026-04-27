Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA181325483;
	Mon, 27 Apr 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302004; cv=none; b=SoMBkIrUHE7AUGOiW9k4ZMp4S/8Os+GYoDbUSWV1gvPGgUIObPtciuztcA04OOb9aekwQ4Mz+Wr/NiRvCiqIlpUce+peAPOoZJYaAAVbFoIGCe0l+fjBAznFIEojtjXMvqaVydcdPolvmV5KArbPWpDoq/M99yQk3UOt0lRdiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302004; c=relaxed/simple;
	bh=IGrroLTu2RtTp56RZqsX0hxGrIQB13lcQxS9JEkWIMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlP6bUxDZ2CQE3rqoQ4SHHInJF5i9Bac+PMtgHx7ux5lMB+K8HV/5eDfr7VIWZOuAhGzIK0KudTxtZpTZZ+9yWy3+EXajjvkKEdCxa4G4aMr3vyHpOvISQPS+FC88vuiSGkwgHWUlz2R65mPDC/ewM0zpzjAu7KOmgsvjFgvnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMiHnDib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMiHnDib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D59C2BCB5;
	Mon, 27 Apr 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302004;
	bh=IGrroLTu2RtTp56RZqsX0hxGrIQB13lcQxS9JEkWIMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gMiHnDibP2lvVXj8sftDu8/OmlvWjS8lRRDHBVuwVFkFlfPgeW2pvGkkfXPe42mUV
	 kXa/9Au4apALe9vRcvbV5U0jCxD/ilgxTJOPksnaCjV0B+jAJWfNsgm/YAFfaSJWDD
	 GRUSVJ8drHqEKuX1Ca38NAeMc4eVEnQBajvc/reQf/RYYXmzYOota38Os4uRRroTnO
	 GKOWfRi/G1UMCm5tlZLbm6sIgHlULo7lkQRm5SP1gionof7qHJv0AWezbRNJZ2T69M
	 QgBfbVdBuUnYGfVfeCPCm7Z9UcMYzJkugzeoj04NlbyT0D4TT1A7jDJTf77nlRIfMi
	 PhlXX7VZx6mmA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue
 <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 01/11] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
In-Reply-To: <20260421-io_projection-v2-1-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-1-4c251c692ef4@garyguo.net>
Date: Mon, 27 Apr 2026 15:44:21 +0200
Message-ID: <87ik9cr00a.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
> types. The existing use case where it represents a region of compile-time
> known minimum size and run-time known actual size is moved to a custom
> dynamic-sized type `Region<SIZE>` instead. The `maxsize` method is also
> renamed to `size` to reflect that it is the actual size (not a bound) of
> the region.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



