Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445269;
	b=tAqXsxRnzWaouz8E0kVwHnlXPqo/XbzDLje2S6OkepmkkG8fW15ZRQqTpZO6rA92zMf1
	 xdNOa2r9SLWAABVM/d18F3XWeopBH3tP7dA1TVOAMxBc9dSfwFk0muV7Fy4qk4ytRwYe6
	 pdzXPMEEoptMDPmdsTH3LuQ3x3o/eZVDxJVQWdada24By3U3AzbjUqtmChXaGgw2V7bE0
	 mUdygf0MHUmdZkjHk2rdOIJkvAT7Fu0TJVZFfKjbiHqlZXq9EUioENq1jxl5tQ3G2ptz0
	 os5hON5hTHhqglrVdOq81CnxschfF0JOInFD7lJ5dq+nHOw5UtB2lDLmMY7M1wzPhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qYC9QcKfgc8oHWdQxJGb508dI5hLnrohqththuu9bxk=;
	b=L7Z97g8jQ5bhwgh5epAzd5yuMm8oblNcbsTEFt0aqDFrx32Sh/6Ajfb5AYrBOIE+vUbR
	 uvjXiDeXnq0ZkLXwUlSy+wMSP7zR9vexCLWJdLGGuPq62F3ESjFTl9VMnY6iPhZk3LhZa
	 UOQ3gzD2PZoPFIplxpo9nx/CUkAkND9KlSxI3F8+pqJPQ10yf4FXyUZbwU9lKkz7mi49G
	 slDsKpa5TDXeu1nsRv1nFuZJZUv3Sjr3sHFk+NpVVV45ErQODVdEJoHqkz48NptoPbqFY
	 oCg3L58uoHgaU4VbRTUWc5Yd83h7GRVaFonL4kV6ztZbjSxGaB9kG7fcJl02A+X2Wuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BijvoLP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E419606A31C;
	Thu, 12 Nov 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BijvoLP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405671F00A05;
	Thu, 12 Nov 2026 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445269;
	bh=qYC9QcKfgc8oHWdQxJGb508dI5hLnrohqththuu9bxk=;
	h=From:To:Cc:Subject:Date;
	b=BijvoLP4I1SmTd0xHjtZOtETyORg3eKBrZq2NZInxZlVtT3CjOWIryEeocmeObB6a
	 upgaiw2byqUR2c5wo2PXoV8IAtIDqVxpIqC9qCipcugA3M167f7ZEoBH51gZ9gh0Tn
	 t1eIzBqpW3cLz4g2EDKZjwhMzZvsGf600fQKZCbmUbojKYl98MfMwL9RiaOJbPdcQu
	 jDvSOM3YdulL9v18JJHsuGu/lbEfteP8pJ39XVan8KOMmXpjdGJDf6cZNoNXbQlTMy
	 Fl7XrTzgZxPgxsvEOJA9mvnbucAvIoqJClUtLtD5LVDiMOhEp7sH4qlAUjOTXKNcI6
	 iX7CWR9ox8bkg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	david.m.ertman@intel.com,
	iweiny@kernel.org,
	leon@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	igor.korotin@linux.dev,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	markus.probst@posteo.de
Cc: driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/7] rust: treewide: remove driver unbind callbacks
Date: Thu, 12 Nov 2026 01:52:54 +0100
Message-ID: <20261112005455.1224352-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver model uses native Rust lifetimes, allowing driver data to
retain device resources and a bound device reference for use in its
destructor. Separate teardown callbacks are therefore no longer needed.

Remove unbind() from the PCI, platform, auxiliary, serdev and I2C driver
traits, and disconnect() from the USB driver trait. Move the affected
sample teardown into destructors and update the driver documentation.

Danilo Krummrich (7):
  rust: pci: remove the unbind() callback
  rust: platform: remove the unbind() callback
  rust: auxiliary: remove the unbind() callback
  rust: serdev: remove the unbind() callback
  rust: i2c: remove the unbind() callback
  rust: usb: remove the disconnect() callback
  rust: driver: document teardown through destructors

 rust/kernel/auxiliary.rs        | 34 ++++-----------------------
 rust/kernel/driver.rs           | 18 ++++++---------
 rust/kernel/i2c.rs              | 31 ++++---------------------
 rust/kernel/pci.rs              | 34 ++++-----------------------
 rust/kernel/platform.rs         | 34 ++++-----------------------
 rust/kernel/serdev.rs           | 41 ++++-----------------------------
 rust/kernel/usb.rs              | 36 +++++------------------------
 samples/rust/rust_driver_i2c.rs | 18 ++++++++++-----
 samples/rust/rust_driver_pci.rs |  7 ++----
 samples/rust/rust_driver_usb.rs | 11 +++++----
 samples/rust/rust_i2c_client.rs | 12 +++++-----
 11 files changed, 59 insertions(+), 217 deletions(-)


base-commit: de7625abe4e92f1fb0047ed5f163b2ecaba77e50
-- 
2.56.0

