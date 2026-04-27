Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4243ACA6F;
	Mon, 27 Apr 2026 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327986; cv=none; b=PBeJ9AqXXR+ks5kkCkpnW6OH+T4MvVL/nU/IqsSfJKddfR4NOWViUBhmzy0B2YfZvP3/tJqBcsDJklHkNjm1hbFpEvTYC99hXMzFwZsVrerOm21Rtkcz5EvH0NN2Gpj3EMKaJYYtbiSYa09/BZ02bMLysAyDqBSeY680p35EqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327986; c=relaxed/simple;
	bh=sZLqtheFtbTBM6ybbYnAo9fMYpWxi0B2jumJwk9Z3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTlOhoqUstGxndNnAJcbA74P9N2RvIOmWh3ASYsoIiWqkA/6OMreSP10RMPXTjbWDovb3pNl0Fz1O45ss7q6OWQ7LkHeEdPuCee+E9UEeQYBhZxdS/80pr+aenBWVvJzGtuRIYTFFCA6cTHQUMl7DNC1L3pwpJ0ZOPVWjRGT8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCTlgvTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCTlgvTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483FC19425;
	Mon, 27 Apr 2026 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327984;
	bh=sZLqtheFtbTBM6ybbYnAo9fMYpWxi0B2jumJwk9Z3cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCTlgvTV6FJHT3hQpDJhYJVDws5vZuwpsyLdFXn1Ezq4MjTkMvHsEuWGZDtCWUDEI
	 h72knNyqRACPfgsu/da1PxSroKTP+FCEBidk8Yq2pPzpJqq19+tUcXcobnsGP7lc7u
	 0ZODNbkXz+g8diiaZxCqlQvMQYll5PdX1BHHiwtVhOhLoxhf7ccVhMZkJ3JjAsAsXy
	 2FUno9OVC2YQqNd4mhctCLD0je5jEB7tsswhGAdl4MZoOv4vkmsVUO5L7C1313kPzD
	 mafFDzdfw9r/wydKN5/wUiMNGF5HrKvbhUFsP1TakxLKpDvUboStrrT7uN0BoIC7r+
	 XnFb36DELy1vA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 09/24] rust: usb: implement Sync for Device<Bound>
Date: Tue, 28 Apr 2026 00:11:07 +0200
Message-ID: <20260427221155.2144848-10-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device<Bound> uses the same underlying struct usb_device as
Device<Normal>; Bound is a zero-sized type-state marker that does not
affect thread safety.

This is needed for drivers to store &'a usb::Device<Bound> in their HRT
private data while remaining Send.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9b9d3ae41087..442e456fd2d3 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -467,6 +467,10 @@ unsafe impl Send for Device {}
 // allow any mutation through a shared reference.
 unsafe impl Sync for Device {}
 
+// SAFETY: Same as `Device<Normal>` -- the underlying `struct usb_device` is the same;
+// `Bound` is a zero-sized type-state marker that does not affect thread safety.
+unsafe impl Sync for Device<device::Bound> {}
+
 /// Declares a kernel module that exposes a single USB driver.
 ///
 /// # Examples
-- 
2.54.0

