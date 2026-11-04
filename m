Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760604;
	b=b7QaJUbg1c1uAPtoIOxVRlmWhGXyyan6R+rYJ2ZinhIVkrq82jUY7QdKszSt2nOCUPzg
	 sjbRhYHgLh3LOYERsuXHurXLBBFwLxMlqn5H8UDaIsfM2zN6FjZ8nv4kqiKBEioBTDnlj
	 S7cRPXbyhm/GTlvVdsDTh7Il7mn1H811Xy0qT4wbi8PyD1rKeFQDONVSBPWjGQ1HxO05M
	 9ywjSCMI0QhvBlTPjwUi+/Z0BKRcDAErDLMAytZD+FIj6wdVRnCXy/IkBYfqZyL50ZPoR
	 EX9HLMWOLfppZGdlOC2YMWqZsNvRTasEzbviRfj9chx8/l1Bt+3DXM8c3L+kHXvPOsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760604;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UG+jbvPjXUmrsRpl/vei6M3UPhoSxLuxyhfY4Evfnjs=;
	b=Xb46wiV9L7mYtXa8U/OLiXoNhKxGHsmyTzPoOKcNdEhHnd9ks2ZIb1gcAyDEb/tYL22B
	 fEGuqECfpzJmoBBfAxApNJM+6bMXFrnc7J6ENq6+tyrjfQAnNiF1eXRpx/wfasy9RF6+k
	 U0RcamsoC1/QymfVT3Vecm3Wcwn0ve8R8SK1hknxlSv6DlDk4qpSEGClfN3IeoXAkobWB
	 0K4PzymrlPWxoLJQjR+Td10uOyJcIesXrEi6TwNOMASFOvr86EUa31a7nywXDGLT08M5w
	 S4VaZE7++nE2LSsRbATQbTsFQ8gUZlAAd9AJleyay/7owvsW6dUL0Bl7VMfC6sKbkeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AljjXN2i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9641606A31B;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AljjXN2i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760603;
	b=n5U5bJF2jHxmllJw96YdqUL+gltCbDZedPaOVcxbFe5gU8QamKgmeTqmj0/RWlo1uZ59
	 eUcys9skdZQOqAyX8Db7+06gVLzUz3p4TBzsfiJNGPauxbHDG1KZxN+BCecxO2G2sE16v
	 4H8ILyT0wtxYGm2bJRJoZcpYEZSMQ6MYWuaQexJtKCPpNQldddTDbyjfYB6V3kQ35bBS7
	 euzCX833mNfCM6a8ypkreF1CO0dx5lg7Now43EnpTxnWw9lI+qTy5a+lPJpERrDVtoqw7
	 t7DNnFoVhBNtoHjKOYXQA+qPN2qjtx85TPjRAX1SeO2UL0K0lk/MXvpKhvDgqS1IL5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760603;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UG+jbvPjXUmrsRpl/vei6M3UPhoSxLuxyhfY4Evfnjs=;
	b=uTPdVmcuFHjVPjASnM2L7CLzKEOoDs4SR51lt3GOPBzMtPR6E6TCbLi/mQfWE6qqnd8T
	 nTN+TUfN5pBmv3Byrrl0caXKL/2s09UYSFA1xsQDqrrpYy9tQ1GlV3fLCn39vJbgGTolj
	 8QtDBP27BX10d+eerxIpwS1lWhMircZQrzr8igfak35HHHTvL9gXHvRqjo5kJgvxRQxpL
	 rUP8lQOJ4qkaIlcGyUD890QAGLRDFEsNwASFvsdPpA1dsqTrSUWXmX6ov8LS2Um317QMe
	 m7Y4pwvF5SdSkEvfxSYpyhpth1r53jRarfxXeTSpzMM3EzHk1F3fZpqznBz0yJFriyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D541A1F000C1;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760603;
	bh=UG+jbvPjXUmrsRpl/vei6M3UPhoSxLuxyhfY4Evfnjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AljjXN2iY+eopP6gSfpce/8PzlWCxuG1kDx8NMlNKVqmKSblUm+6Mkc42iDOQ+2/o
	 bF8FpirvBiSXCzleURAnG4OVzirAURPLt0KbxV7w4AVaaaISNT+Om78wXkD2PhgdMM
	 6fzyz05yVDBxeTWCx6ARrPnLF8xCmPgCTIy9qxyO0CSRgkPfzyXUGC+OA/gRLGuhKo
	 xEtm9fhMDuSsDTnwp+VVTIPrPftZQLmEvGMTL3LhD1BmWGndEA2YsCDz2GbUL7Y8+z
	 DE3mGDB0N0QTOnnoiK1P3rQsoKwoo6mH21BCWQM9fxuRWJ22Rq4mONOYBZ/oflc7lB
	 NDBzl+qG1UPwQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 40A6946BF9;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:42 -0600
Subject: [PATCH v4 01/25] PCI: Add SNIA SDXI accelerator sub-class
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=1441;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=HRHBHsVrsPkhfleJt5OBxEfrKMfiC19WMsFKZuGKy20=;
 b=m5f++TxThWkgV2jkX4Aooxp6TSW96jcTFHmilmjD+IKhFsRoC3Q82tlJBBwMlU8WU8prKM6Ql
 sq2uuAVvLYPBTdJFVPu3wQcJvxw2nSchc8jt1eu1Usd9LuG47WXLqZr
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

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
index 030c86dd6d67..dcb26f52b5a1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,7 @@
 
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
 
 #define PCI_CLASS_OTHERS		0xff
 
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..d714e4b83852 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -292,6 +292,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
 
     ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
+    ACCELERATOR_SDXI           = bindings::PCI_CLASS_ACCELERATOR_SDXI,           // 0x120100
 
     OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
 }

-- 
2.56.0


