Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77919456E18;
	Tue,  1 Sep 2026 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247066; cv=none; b=GNHm01sWhQWXN3YOO/rKa2laDn1j14lpLsIgV/63IWBQBJSazCiCSBgYBIqTDs81m+3qO2dXUYMbpYj8LEpkjkEDXSmoTPEwxxTUtZFfpSKj+3Nop6nHr5DCY7yv+oBKiy5ZpEBQj06QOewgXU/QhZ0yLKCj8b7vKxJjgYThYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247066; c=relaxed/simple;
	bh=qJ1UQCsSl/CtaiffVaPKouOvZNTniSEjJVqDnK+qT2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD2QkApGEeokEODVgtx1+2wmubBWCpWnHym0VdifLCmeDUaLHSYxcR45jPxDtSsChvS2NdeMrOAiNhIX1V35+g5DIdDhdYcz/O3fufNwtU+YCN+Rtrt89C6ohtNHJAt/TG1L75ZdmtcARWx5kIYcmMyzimba060GxhihQZyvSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07450494|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00265924-0.00015051-0.99719;FP=16252303909509023947|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j2BhS8J_1788247050;
Received: from localhost.localdomain(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j2BhS8J_1788247050 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:17:30 +0800
From: Lin Wang <wanglin@open-hieco.net>
To: Borislav Petkov <bp@alien8.de>,
	yazen.ghannam@amd.com,
	mario.limonciello@amd.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	bhelgaas@google.com,
	x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h models 0x04-0x08
Date: Tue,  1 Sep 2026 15:16:59 +0800
Message-ID: <20260901071700.3255382-5-wanglin@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901071700.3255382-1-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_smn_init() distributes host bridge roots according to
amd_num_nodes() and PCI enumeration order. Hygon Fam18h models
0x04-0x08 have multiple DF nodes per socket and group SMN roots by
socket, so the AMD mapping cannot provide their node-to-root map.

Leave the roots unclaimed on these models regardless of
CONFIG_HYGON_NODE; the AMD mapping does not apply to their topology.
Since amd_num_nodes() is independent of the root array, check
smn_exclusive before indexing the array so AMD SMN calls return
-ENODEV while its setup is inactive. When built, the Hygon node layer
provides the node-to-root mapping. Other Hygon models keep the existing
AMD SMN setup. amd_smn_init() can become AMD-only after the remaining
Hygon callers have moved to Hygon-specific interfaces.

Signed-off-by: Lin Wang <wanglin@open-hieco.net>
---
 arch/x86/kernel/amd_node.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be01725a2a4..a0cfd74ada03 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -88,6 +88,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	struct pci_dev *root;
 	int err = -ENODEV;
 
+	if (!smn_exclusive)
+		return err;
+
 	if (node >= amd_num_nodes())
 		return err;
 
@@ -95,9 +98,6 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (!root)
 		return err;
 
-	if (!smn_exclusive)
-		return err;
-
 	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, i_off, address);
@@ -252,6 +252,18 @@ static int __init amd_smn_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
 
+	/*
+	 * Hygon models outside this range, including legacy parts, keep the
+	 * existing AMD SMN setup. Models 0x04-0x08 group SMN roots by socket
+	 * instead of amd_num_nodes(), so leave AMD SMN inactive. The Hygon node
+	 * layer, when built, owns their node-to-root mapping.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+	    boot_cpu_data.x86 == 0x18 &&
+	    boot_cpu_data.x86_model >= 0x04 &&
+	    boot_cpu_data.x86_model <= 0x08)
+		return 0;
+
 	guard(mutex)(&smn_mutex);
 
 	if (amd_roots)
-- 
2.43.0

