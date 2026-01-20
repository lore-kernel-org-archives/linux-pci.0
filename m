Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7BA3B95F6;
	Tue, 20 Jan 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932777; cv=none; b=d+xMInm03qGZ4nE85MLs5ftSFrrvGFwg+XWf/juHU3ofbLHjjvf+Pn0jeKScQtLmrQJgX7GgJu0jTweeB3jnn1dcSMH5gXcvTPbKZNViVHElChnTO3C4n9P8JW2ts0/QIh0wjSKci76VNhOSz/1pp/sVCt8MbYVEVAjhiL3GiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932777; c=relaxed/simple;
	bh=dCIEJ0G6o69ea1Bz0/r/qRT+iH22OxnaGUsP4EaI00g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxb2lnLUJDyf1xORRztSRSsQyVkvYnKyXFlUE7zT2Bgk0FssuJAzdvA2FO2ack4DsIB6Hw+SaSF/pXgSQ2s3LCkeE0hWxho3kuFhK7jOOGPHfTwim8jSrPjfQJxBkb9vTs5DFvACZADa/orLSF1Cft8G74ryQtZVCf9XPqdO5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmoINzgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmoINzgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B860C2BCB6;
	Tue, 20 Jan 2026 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932777;
	bh=dCIEJ0G6o69ea1Bz0/r/qRT+iH22OxnaGUsP4EaI00g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=pmoINzgv3VIPGxTRFl4ulPrVpPOnRcLdY0sn1dtmdwtf/gbxUbsrl8OsR93GaynKl
	 7U5ieD28YEkz4C1wKjutoW6hxi2IsWSZUH/osOiJliJ/f/eLYD5fSn3YPd4LxOQEVX
	 PqMsDP+AdgSq1pZ/NwH239GCULg7T794odUTezrOooOaOKEmhtMZ+4l4shTYn5q5+u
	 v67hsSWgAXoPvn5sgkkztkliUovDmhpabg5866xpsV62KZfgZ1OPK/0XGYJ7OqKWMM
	 Ge0P/FPGLyTKg3G4w9eLQAgjUsuI3oCyHqQtHdloOMFX/MB757GeRNcWAcsDUxjHwv
	 snm3UJGab4oGw==
From: Gary Guo <gary@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] gpu: tyr: remove redundant `.as_ref()` for `dev_*` print
Date: Tue, 20 Jan 2026 18:11:09 +0000
Message-ID: <20260120181152.3640314-4-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260120181152.3640314-1-gary@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This is now handled by the macro itself.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/drm/tyr/driver.rs | 2 +-
 drivers/gpu/drm/tyr/gpu.rs    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 2a45d0288825..fe991d8cbb4a 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -140,7 +140,7 @@ fn probe(
 
         // We need this to be dev_info!() because dev_dbg!() does not work at
         // all in Rust for now, and we need to see whether probe succeeded.
-        dev_info!(pdev.as_ref(), "Tyr initialized correctly.\n");
+        dev_info!(pdev, "Tyr initialized correctly.\n");
         Ok(driver)
     }
 }
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index bfbf2a1d80e6..04a0a5d5ef3a 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -98,7 +98,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) {
         };
 
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
             model_name,
             self.gpu_id >> 16,
@@ -108,7 +108,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) {
         );
 
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
             self.l2_features,
             self.tiler_features,
@@ -118,7 +118,7 @@ pub(crate) fn log(&self, pdev: &platform::Device) {
         );
 
         dev_info!(
-            pdev.as_ref(),
+            pdev,
             "shader_present=0x{:016x} l2_present=0x{:016x} tiler_present=0x{:016x}",
             self.shader_present,
             self.l2_present,
-- 
2.51.2

