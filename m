Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782351;
	b=BmuGicKtHC6mz/m9X6bmf0Kg4Wm9a4M2mfbVW3tGSiTYaKhd+DCIfXOu9hg0axIa1vSG
	 Gzv1blqIN/TY9Rb2R5rgGvKK5l3QB1Kj09tWm8dwbEBWr/djkOatCCZwcEt8+IWGF8z7C
	 Eb7xhHOkFEGTfVzIgYP/Hlhmq5VP9QYaUVuV9rtbpViiY9TrfjdruMCeQkhFE/TQnUnOJ
	 ZgQG2/+Wf3vtHNS0vM/a1xBMfTL60w8wqXAivstJ0TAUYPzw02D32jQcbOJkSzKnGZjCO
	 WESj20fXgdIx6hMpExgyOJHaF1pN2k3pkNdG+s7pn0/7zLwI1DEENxumHL+GDkNHs0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=a0qu0j6AmOnocb4ErsG1/P7x86Ov3PdyD2eIAJ7Q9CI=;
	b=Ru8HgvogscnBcx/1E8dE9lbkVwVoFHm8kBecx4E6J30QAZdp0JlAsihO2gQan95CNp+x
	 6OnSQD2SunuK/5PcQTSrfNWFIFsr/u6qYxqyq25RuvoI/zA2+OX+dQlq6fnz/KsRapJ3O
	 qWx+CLjezXvkJtKfs6TFaCIjbAmdeLsHTnFixYM426idnthvSvj7g1Nd4jgyoHoQVQZV/
	 UL0Cz7IrR1ID05xhjWHJH2S4S1EpuHS7zER24+WvNtpmlXLedtLIWPWrTN265QEAC/b8W
	 5c8nf64Dlke5dxJfdQDZlrFY/eaXjjGjSWNoDfiUGdYytHsORZljZAl5VawpqY9ZwaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcjiUnC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05705606A336;
	Fri, 27 Nov 2026 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcjiUnC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CEE1F0089A;
	Fri, 27 Nov 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782350;
	bh=a0qu0j6AmOnocb4ErsG1/P7x86Ov3PdyD2eIAJ7Q9CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcjiUnC+QzW1+A5q+f0vI+yQYATvfZE3rf+/VClnaksrClJRA0VBOqNUxEFicVdAO
	 Xowu3GA9Xxw1sQ5V2Q3Pqd7gy6qqh5ePMP/Vv3jRF2bdQ2bfVMfFIQnwhQ9V7IlXBX
	 ZAPjUnFKFmFoAIAk/cza7ql5yzSaEa4Xw7zeiTxVpYKgN9WfOzODcvW28KstEe5yQz
	 9zqoCOZdGaipyqB97hbfWemWwSggmOFhvhGIlMIW5zeIFtV7xn47pGJ8UxEA50LdBx
	 Dl23WXcx4qmnaGRNVdfYSMZwNeMmsbUB7+jH32gQj42UlCl9eiYwNCxJ8VyaP2WXxC
	 ARwmGerIkA2iQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/6] kho: build KHO objects into a single kho.o
Date: Fri, 27 Nov 2026 12:25:27 +0000
Message-ID: <20261127122536.3708770-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

kho_block.o is part of the KHO infrastructure, but is currently built as
part of luo.o, which ties it to CONFIG_LIVEUPDATE.

Group all KHO objects into a composite kho.o, built for
CONFIG_KEXEC_HANDOVER, the same way the LUO objects are grouped into
luo.o. This also gives a single place to add new KHO objects.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d9f469462556..bc679905ce3f 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,13 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 
+kho-y :=								\
+		kexec_handover.o				\
+		kho_block.o
+
+kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
+
 luo-y :=								\
-		kho_block.o						\
 		luo_core.o						\
 		luo_file.o						\
 		luo_flb.o						\
 		luo_session.o
 
-obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
-
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
-- 
2.56.1.839.g22a8290db9-goog

