Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971C2745E;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704142; cv=none; b=Dq2zqzkc92xSL+W9uOeyjF80oPOOAjlglbWxvkbffwMoPv76ZZdd4blaDOruYk/+PbjxeFup9LNYwgHlO0vvwm+Zpn9AmTXJG0E7anZd1uIUNhKDMXPTtULXJFkRqwem30CeeuyXLhaUyJ79sUPW1Fzar+z0w46xdEKAKFYIIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704142; c=relaxed/simple;
	bh=poRenvYc2UJwmpUd+sGYuOxBqoO2KziJseV7+TelkSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltpJtw9GRME3ouIFFxN3q4CcA6YnuVI2cny0A5+ZbJmVaMomRb2o0eZJ42ON66ZlZ1myIpUhKXk+/KzpQvhDopPXlVkfCK9BfHnWtG/DSM2gvbIBMZGsj42EHessCNDju1yWJRy2qXUSfKxuu6kGJrzvq4PBinJfg/lGrvCQmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGnX24KV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGnX24KV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57D18C2BCC6;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=poRenvYc2UJwmpUd+sGYuOxBqoO2KziJseV7+TelkSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BGnX24KVv3TdjWNe2/0afNFiR+pnQwMZ8K1Ta92Afx9DdVrmUh2YkBxz+cVaOHsK0
	 bLg02Kv+OVxBvq0G4cXhD+WtyliXMOJ4s1rPVdcoAviXm3MIDnio3KU6JvX7hscH4U
	 K6hPwLzUt86ZVD8/xhMgOvFxryXq49NdmgoDKhtpI8HVYPdXoutaIvHfDe6j9i/GJo
	 zfzG52fJKlwYXKPYAp8ungVIjfNqj1P6DFquC5Aao/9U2bXSmv8AMdr0MUya2P+trh
	 5IBVXo88wQUD2uESXB+kbTwrubZaqLdVkxsTyP9TjyGvFGl4d2RH0wT8i/ZXftV0kx
	 3kgztN9xV7eNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4273CCD6E7E;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:04 -0500
Subject: [PATCH v3 01/23] PCI: Add SNIA SDXI accelerator sub-class
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-1-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=1441;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=OwdioeWEQcxJLVaFYqBTlKzpo10yCo7NwekOCC/At7U=;
 b=9kwewPyVlVZHqx4QMSTGgh3csIXnMQl80YqCwZI/mMFGfRce66vPzr9fMKonYJTZ4LK5wOWLE
 v68SjNI/wN/CieUMRBpaR1/FmLqdFSFWRFU4a6449acS3/mpBWJ3V+A
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Make the class code for SNIA Smart Data Accelerator Interface (SDXI)
functions available to both C and Rust code.

See PCI Code and ID Assignment spec r1.14, sec 1.19.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 include/linux/pci_ids.h | 1 +
 rust/kernel/pci/id.rs   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 24cb42f66e4b..83ab3f27eb5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,7 @@
 
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
 
 #define PCI_CLASS_OTHERS		0xff
 
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 50005d176561..d5e006cd6641 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -292,6 +292,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
 
     ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
+    ACCELERATOR_SDXI           = bindings::PCI_CLASS_ACCELERATOR_SDXI,           // 0x120100
 
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
 }

-- 
2.54.0


