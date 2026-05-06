Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54735B631;
	Wed,  6 May 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104834; cv=none; b=gbkYvQJQvnpy2ZRRz5svyGm8eRW2Lr2mSriaHMX5I8b3/WVZJVX7bXbDH2RFuf/4D/gkloiWleUDkfspIhq7L99L3u/Phd1E+lUkSFC0a1Oho4Joom1XJqdaxjP62jbXe5MXmTIbw25KT74QsFLLOIwbEqNX0rUy2UKQufI3r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104834; c=relaxed/simple;
	bh=nCyApNb8RKn1veEhbH+LihTl9SHcYNeSopAO0tq8/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jck5wFznS4xhqP+1jmUdatgGAeXyILu9E0ZFlHNOPBJBubmL/b1yU17CUgCSRhF8t0yxfeEejP2uv3rzLwiZhLEmMBSrt/Y+5F6S5UrjrWzsAXbG+AZNYRF78l3BlzmwyMM/7uONSScfk153eM9fKhZMF3SNH8UoYUqMDZ01Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7ZPn4Zu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7ZPn4Zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5551DC2BCB2;
	Wed,  6 May 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104833;
	bh=nCyApNb8RKn1veEhbH+LihTl9SHcYNeSopAO0tq8/OA=;
	h=From:To:Cc:Subject:Date:From;
	b=r7ZPn4ZuEfXPGPabAtTXrwgZPsqXmXckRw4t6mO2USweTSvl2RUftL8wUqYiaHVc6
	 F/74M2nXgVwWrb4IB2kr1wJJsahWu+Ra4QxGTmk+dtcJrNUKk26S7ai3T5XMW4QO0e
	 /jmtBfR4JNscZOtjsINOTk345VDwTVWgpTzwrbAFE29tbdw9uLDIThLfSGSDGJx3pY
	 aOCD+Klzh2O7/VerE10AIB/YF/JAJSMjbRfhLQDnq1AR9Hw/utzMFw+u+w998uKBS+
	 0FbEMPMpM346TySODIGrcOnm+hDCujKBflOD/B+Vkwqp83Nh1h48gH7aSEOIvVJf68
	 c/8Ui70hgF0KQ==
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
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] rust: devres: add DevresLt for ForLt-aware device resource access
Date: Wed,  6 May 2026 23:58:32 +0200
Message-ID: <20260506220012.855173-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devres<T> stores resources as T and hands out &'bound T from its access
methods. For lifetime-parameterized types like Bar<'bound, SIZE> that
are transmuted to 'static for storage, the synthetic 'static leaks to
callers -- any method on the stored type that surfaces its lifetime
parameter would yield a &'static reference, which is unsound.

This series adds DevresLt<F: ForLt>, a thin wrapper around
Devres<F::Of<'static>> that applies ForLt::cast_ref in all access paths
to shorten the stored 'static back to the caller's borrow lifetime.
Devres<T: Send> remains unchanged for static resource types.

Also implement ForLt for Bar, IoMem and ExclusiveIoMem, and their
into_devres() methods to return DevresLt instead of plain Devres.
Provide convenience type aliases DevresBar, DevresIoMem and
DevresExclusiveIoMem.

This series depends on [1].

[1] https://lore.kernel.org/driver-core/20260506215113.851360-1-dakr@kernel.org/

Danilo Krummrich (3):
  rust: devres: add DevresLt for ForLt-aware device resource access
  rust: pci: return DevresLt from Bar::into_devres()
  rust: io: mem: return DevresLt from
    IoMem/ExclusiveIoMem::into_devres()

 drivers/pwm/pwm_th1520.rs |  5 +-
 rust/kernel/devres.rs     | 97 ++++++++++++++++++++++++++++++++++++---
 rust/kernel/io/mem.rs     | 55 ++++++++++++++++------
 rust/kernel/pci.rs        |  1 +
 rust/kernel/pci/io.rs     | 30 ++++++++----
 5 files changed, 155 insertions(+), 33 deletions(-)

-- 
2.54.0

