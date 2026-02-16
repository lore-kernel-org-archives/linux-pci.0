Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EB1D95A3;
	Mon, 16 Feb 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248687; cv=none; b=mVT1zPckhPcoeEHhROc7k3y+jioU7NFYcS9eqFhFqGdEq45mE2FwzPE9J9f8LdA+G1910lHBLQK/Xuez4UqhsH8UTkAKgGcnLgYS8WYv+bc19p9RffHptvy12xZcVjZyFUWZhjQTpXsu7rs5zss7fC5EDkZXkubqwateWxvlSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248687; c=relaxed/simple;
	bh=ZPMzqF0XfngDTZUEp4xUUaP3i0ZBEp0HYc0YvPQhkOU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=q44/VrdM8E9cVJVTWgV2e9/z37jge89EDynm1VnOwSlhZI1jJWKTJmSrMC/s6FxG3bP2u+XoOgZ1w7rUxxVdfMasG3M6Xz+SxAH5IHcB2I8fXCcyeMnNltcxWdGZX/el4HK0JvcdqnJT4vFL/PGTcRS0VN4tGSFraEvLWFiig18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXONtpYF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXONtpYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D29C116C6;
	Mon, 16 Feb 2026 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248687;
	bh=ZPMzqF0XfngDTZUEp4xUUaP3i0ZBEp0HYc0YvPQhkOU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IXONtpYFb9gyc+QCsfQgCRGFSBJgO4LpG+aDFiWeULSvE8JnKVmXRK5xpyaLWh13O
	 raIVTZO+misITf/m2FZZkylKlDz/m66qbFLjh38umPbm0cgSNITFvFZtc2YLhB4zbO
	 oMRCkqnS353tM/sNhC/bo/xx0NO8V6GfPHusCpiG6KXJ6d5zDwTOh528TRC0eJ281o
	 89QmtQHDcuwilP9t+b+1/iUY35mzJLjf9ur85gp4ptrEre61eNFu5gkA6vCZSMdDub
	 RosErUe5u1Y7xXtMChDOo46kE1fKVUGB4qBjkMFhGuHHqZ74Swg1cX58irsGGAEU9T
	 m4LYZ3AgEAo3A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 14:31:22 +0100
Message-Id: <DGGF97AAA3HF.3DSNMFJTCNI9Z@kernel.org>
Subject: Re: [PATCH] rust: io: macro_export io_define_read!() and
 io_define_write!()
Cc: <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260216131534.65008-1-dakr@kernel.org>
 <aZMaFhvZWiknu8UK@google.com>
In-Reply-To: <aZMaFhvZWiknu8UK@google.com>

On Mon Feb 16, 2026 at 2:22 PM CET, Alice Ryhl wrote:
> You should keep these re-exports (as full `pub`) so that they can be
> accessed from kernel::io. Exposing all macros from crate root via
> #[macro_export] is legacy approach.

Good catch!

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 58f464cf5efd..e5fba6bf6db0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -249,6 +249,7 @@ macro_rules! io_define_read {
         }
     };
 }
+pub use io_define_read;

 /// Generates an accessor method for writing to an I/O backend.
 ///
@@ -305,6 +306,7 @@ macro_rules! io_define_write {
         }
     };
 }
+pub use io_define_write;

 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 2c8d7d00e54d..fb6edab2aea7 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,14 +8,14 @@
     device,
     devres::Devres,
     io::{
+        io_define_read,
+        io_define_write,
         Io,
         IoCapable,
         IoKnownSize,
         Mmio,
         MmioRaw, //
     },
-    io_define_read,
-    io_define_write,
     prelude::*,
     sync::aref::ARef, //
 };


(I'd still keep the `io_` prefix though.)
