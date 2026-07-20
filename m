Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDA25742F
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580110; cv=none; b=sKoXFMeLo4SxnwuQJcWW6AWTIjV7+CDIneOYK5kxZEqNo/ZxunL9SIYOs2244QKzByeQ2DxdluHDx5/m6hX3qlLJuNYT0trIq0E11fzCe8EKcx7DToeAnWOyyGiUwbDMveQU8REHzKBVExG4+7Me1vfbR3/6f7S5r1wMfHgsKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580110; c=relaxed/simple;
	bh=YU3ocPkcev/Jq7W05hqhmIitUNVZuwh6elpblEMmiWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gf2VlVbZyuoYRLlm96fvEdzBZAFysMBXJ8EYpHAqkazOJv+JTSC3d5ejrsUMq00ACZCTtUPBLtEReLlu0Ehh/FAc3IxEjaVItsskoiX8sJXcbhka8xCyfCtNdbdRUpAVqhlm0TQAW6gcPZtl+ZPlARpA+iA6Y0HDbfcXZlPfFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIJEMlvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIJEMlvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BAC1F00ACF;
	Mon, 20 Jul 2026 20:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580108;
	bh=SYRND2bfCmNqrKJVlXDYbuaKXvHsF4pmoyMZQmHiydk=;
	h=From:To:Cc:Subject:Date;
	b=aIJEMlvGx1vdSIn0w7iUi8dC4jAxeRnLLg/EIbSH9xfa7vdndOQn8mrRgVVtHVf4f
	 ZtNaZdgJF0l/7m6nsEVO+8ZIuvD1lm5Yms2L2ro2ZBYg7QSq9HQyjTQKnDlReNP7HL
	 EPEYfnVhi3IaPGYmpLn+nnvZQeyCDMrfssPCrqGMtBsNuUaNL2OwN1Cw/OUKzqtmpo
	 vj1LrDTan5hfK3BNlHlhK3RA11kEY6OAMQKVY7yqnytO/ZJdXkAfG+DggXL2FwvKl5
	 W9KBf4MucvrbSOP8W14niYJdo6/6OntYHoKwUFPCnfhgx/RxbsyHeWKrlvC5jcTMQ1
	 2KVpKcRWSWVeA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/proc: Use file_ns_capable() when checking config space read access
Date: Mon, 20 Jul 2026 20:41:45 +0000
Message-ID: <20260720204145.1500105-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

proc_bus_pci_read() decides how much of the config space is readable
based on capable(CAP_SYS_ADMIN), which checks the credentials of the
task calling read(), not the credentials of the process that opened
the file.

The sysfs equivalent, pci_read_config(), has checked the credentials
of the opening process since commit de139a339395 ("pci: check caps
from sysfs file open to read device dependent config space"), so a
privileged process can open the config space file and pass the file
descriptor to an unprivileged process (for example, a process running
a KVM guest with an assigned device), which can then read the entire
config space.  The check was subsequently routed through the LSM
framework in commit 47970b1b2aa6 ("pci: use security_capable() when
checking capablities during config space read") and converted to the
dedicated helper in commit ab0fa82b2df9 ("pci-sysfs: use proper file
capability helper function").

Thus, the two interfaces check the same capability against different
credentials.  Checking the credentials of the task calling read()
makes the outcome depend on who reads rather than who opened, so the
restriction is bypassed whenever a more privileged process reads
through the descriptor.  Checking the credentials recorded in
file->f_cred settles the decision at open() time and ties it to the
file, where it cannot change with the caller.

Therefore, use file_ns_capable() to check CAP_SYS_ADMIN against the
credentials in effect when the file was opened, bringing the procfs
interface in line with the sysfs behaviour.

As a result, a file descriptor opened by a privileged process and
passed to an unprivileged one now allows the entire config space to
be read through procfs, matching sysfs.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 71ad289fcb8e..690a5625fcb4 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -39,7 +39,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	 * undefined locations (think of Intel PIIX4 as a typical example).
 	 */
 
-	if (capable(CAP_SYS_ADMIN))
+	if (file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN))
 		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
-- 
2.55.0

