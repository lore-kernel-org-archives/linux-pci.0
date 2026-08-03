Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9124334B5;
	Mon,  3 Aug 2026 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790546; cv=none; b=CqP6xiiVcVa02DowAh+10BcWJamqeOloJjBPQKfbF9vJo/3YICrxQmN6I1pIZqoEWV0rYrPVUwTuvJJ0zD/UQa+jzvloJP5NQOBCRtNcVn55WqbjNlI/30Fglq/gBsS7omrNL8y9O3RMS/xfd1Rx32YY3CPudiFLlLnbNzAxK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790546; c=relaxed/simple;
	bh=HY1s4IncSdCDaUUdtuJYpYOGMHOaIjKuZfJo4Z+exlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dpve+j+MUi/QGARyOHCvgWcklWlaZUij5j4HPwF5KWfFURP89aeLtr5QHXnsBJdXJvosmInqEo6bmVlwuMKTZmxzx57rzWE4L3++vtLbki5TcZpGrx5L6ZXiTYVrHmEq9FFc4oGEaM/rehpjrccINVTMD6JcgovEqvdNNp1WefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZJ2SzKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZJ2SzKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA401F000E9;
	Mon,  3 Aug 2026 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790545;
	bh=BuuPMwDdBBic4QR/qCxK0yRidVoGJPljgfXM7YtbXSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MZJ2SzKZXPRv7AX0pIUdgUSuOJnwRhf5AimdmGiKqcGubNAkRCTYnBJWV1SRY2Zu/
	 z/fo6Z5mRhFT/c3CkGIyA6AZQ14fdko5KyQHJ8CN5pNgOvuySSETycLUXc+e48EDY0
	 PqOUz7bGyMq08HIriZYbn6F0FDku64vKrIjqgqFxE78oPXz6M2kNG0H7YaJB85bGEo
	 czGpA2lH5KzawL09Ee6sIFyS8i2bT39K0qMt0K6UiQqmL5CvQNpkOmPPmvnkqNmGjj
	 Q6Io9ncaZ9P+153dIRhwhE+ZqtghfUolGQdqg3NKSHw9PibCNcDZTJXtwoHyEEeO36
	 zNOfxzLiEJQzA==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/11] rust: driver: use pointers instead of indices for ID info
Date: Mon,  3 Aug 2026 22:55:34 +0200
Message-ID: <20260803205534.3636191-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 13:39:34 +0100, Gary Guo wrote:
> [PATCH v2 00/11] rust: driver: use pointers instead of indices for ID info

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[5/11] rust: net/phy: remove expansion from doc
      commit: 928369abdd9b

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
