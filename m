Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71B34DB4B;
	Fri, 27 Mar 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628559; cv=none; b=HyvFry/w8zl82BQksroaWDErIZdduBWr0CZQHg/ac6yAlHPbWxarCkvbzc6a+s9fayEJcD8yXA61CPv9ELX+BnsDYwrXaCtVTqo9LsyqQIJNk9nQQmcLnAL8+NUamuVCC3n/Eo0PMHrvjyq1EtLSbSYoUEBpx6+v+aLI6CDLbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628559; c=relaxed/simple;
	bh=tn87qbpi3uJdSP6hJiwGmQFrzB7vH6TbAKN6CQKakWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLdHaZi3OIfHA9qe8OJh9CjmPj59wpOv1WkgbFAR0e74APLeiYaFilcbff1tW16lMrC3TZ7PfeeshZnMMAnt1Q0WEqU4gYXl0udB514niSjTqYk3uOT1NcQmA/a7zaCEFFu9gOOsjECZkYJy9tEucEyIdbdCESXFl2rjwUATyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtqQAND4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtqQAND4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628557; x=1806164557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tn87qbpi3uJdSP6hJiwGmQFrzB7vH6TbAKN6CQKakWs=;
  b=BtqQAND4QBLjA0dv4hbJFPy4KoGdSMxqI6IoKj31yISSbz+I4WcGxL7J
   AqrD1zUZhgo/XgEns0wJaYuet/2EbpF8iSF4bW3QnNKhe2cs6DFLNoXF2
   dj9akjrg7mEanCtptbpehEcywENMVeT/bF7J/KItsLEJQcRgz4fMIFDyn
   CULf7VCBjr1QvgI83ERsEO0ZL3ae/ft0fVBZjF318eUpvfoq07A0JHQxk
   DsX7z4t706mlGwLh540whvXGfH/BXkKLhtECz/GKqgwSFChJ9KQfkqpbh
   vDa+KIxwYI/VHOr/KSnabQAkBrSClmIb+sSlSaNqgIIwe6wcSJG/scHru
   Q==;
X-CSE-ConnectionGUID: ZH/2QFkRT0m3HSejyTjR0A==
X-CSE-MsgGUID: j5IQSO10Ro+w0+hvkXJkGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565486"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565486"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:37 -0700
X-CSE-ConnectionGUID: n5MuiketTTKylM0c7VmCRw==
X-CSE-MsgGUID: FsBQH4yORziItrEV7TBWJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516112"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:34 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com,
	x86@kernel.org
Cc: chao.gao@intel.com,
	dave.jiang@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	zhenzhong.duan@intel.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org,
	xiaoyao.li@intel.com,
	vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into <asm/shared/tdx_errno.h>
Date: Sat, 28 Mar 2026 00:01:02 +0800
Message-Id: <20260327160132.2946114-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Today there are two separate locations where TDX error codes are defined:
         arch/x86/include/asm/tdx.h
         arch/x86/kvm/vmx/tdx_errno.h

They have some overlap that is already defined similarly. Reduce the
duplication and prepare to introduce some helpers for these error codes in
the central place by unifying them. Join them at:
        asm/shared/tdx_errno.h
...and update the headers that contained the duplicated definitions to
include the new unified header.

"asm/shared" is used for sharing TDX code between the early compressed
code and the normal kernel code. While the compressed code for the guest
doesn't use these error code header definitions today, it does make the
types of calls that return the values they define. So place the defines in
"shared" location so that it can, but leave such cleanups for future
changes.

Also, adjust BITUL() -> _BITULL() to address 32 bit build errors after the
move.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[enhance log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/shared/tdx.h             |  1 +
 .../vmx => include/asm/shared}/tdx_errno.h    | 28 +++++++++++++++----
 arch/x86/include/asm/tdx.h                    | 21 --------------
 arch/x86/kvm/vmx/tdx.h                        |  1 -
 4 files changed, 23 insertions(+), 28 deletions(-)
 rename arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h (64%)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 8bc074c8d7c6..6a1646fc2b2f 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -4,6 +4,7 @@
 
 #include <linux/bits.h>
 #include <linux/types.h>
+#include <asm/shared/tdx_errno.h>
 
 #define TDX_HYPERCALL_STANDARD  0
 
diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
similarity index 64%
rename from arch/x86/kvm/vmx/tdx_errno.h
rename to arch/x86/include/asm/shared/tdx_errno.h
index 6ff4672c4181..8bf6765cf082 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/include/asm/shared/tdx_errno.h
@@ -1,14 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* architectural status code for SEAMCALL */
-
-#ifndef __KVM_X86_TDX_ERRNO_H
-#define __KVM_X86_TDX_ERRNO_H
+#ifndef _ASM_X86_SHARED_TDX_ERRNO_H
+#define _ASM_X86_SHARED_TDX_ERRNO_H
+#include <asm/trapnr.h>
 
+/* Upper 32 bit of the TDX error code encodes the status */
 #define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
 
 /*
- * TDX SEAMCALL Status Codes (returned in RAX)
+ * TDX Status Codes (returned in RAX)
  */
+#define TDX_SUCCESS				0ULL
 #define TDX_NON_RECOVERABLE_VCPU		0x4000000100000000ULL
 #define TDX_NON_RECOVERABLE_TD			0x4000000200000000ULL
 #define TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE	0x6000000500000000ULL
@@ -17,6 +18,7 @@
 #define TDX_OPERAND_INVALID			0xC000010000000000ULL
 #define TDX_OPERAND_BUSY			0x8000020000000000ULL
 #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
+#define TDX_RND_NO_ENTROPY			0x8000020300000000ULL
 #define TDX_PAGE_METADATA_INCORRECT		0xC000030000000000ULL
 #define TDX_VCPU_NOT_ASSOCIATED			0x8000070200000000ULL
 #define TDX_KEY_GENERATION_FAILED		0x8000080000000000ULL
@@ -28,6 +30,20 @@
 #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
 #define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
 
+/*
+ * SW-defined error codes.
+ *
+ * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
+ * TDX module.
+ */
+#define TDX_ERROR			_BITULL(63)
+#define TDX_NON_RECOVERABLE		_BITULL(62)
+#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
+#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _ULL(0xFFFF0000))
+
+#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
+#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
+
 /*
  * TDX module operand ID, appears in 31:0 part of error code as
  * detail information
@@ -37,4 +53,4 @@
 #define TDX_OPERAND_ID_SEPT			0x92
 #define TDX_OPERAND_ID_TD_EPOCH			0xa9
 
-#endif /* __KVM_X86_TDX_ERRNO_H */
+#endif /* _ASM_X86_SHARED_TDX_ERRNO_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 6b338d7f01b7..e040e0467ae4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -9,29 +9,8 @@
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
-#include <asm/trapnr.h>
 #include <asm/shared/tdx.h>
 
-/*
- * SW-defined error codes.
- *
- * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
- * TDX module.
- */
-#define TDX_ERROR			_BITUL(63)
-#define TDX_NON_RECOVERABLE		_BITUL(62)
-#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
-#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
-
-#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
-#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
-
-/*
- * TDX module SEAMCALL leaf function error codes
- */
-#define TDX_SUCCESS		0ULL
-#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
-
 #ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 45b5183ccb36..ce2720a028ad 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -3,7 +3,6 @@
 #define __KVM_X86_VMX_TDX_H
 
 #include "tdx_arch.h"
-#include "tdx_errno.h"
 
 #ifdef CONFIG_KVM_INTEL_TDX
 #include "common.h"
-- 
2.25.1

