Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453604;
	b=gj6ZTnzhVuE52ucVpbpNQnuKnHgoMQXqRUDYogbVhR4IyY4WohICbr9QMBp0/+WOxXKr
	 VqTsvMJKygiXBYqkt5OnpsFN8pY8g4GRzC+WztufnWgnlCUiPJSCa1qxOxnuCsVLtcBiA
	 YPl7Xfip69c2mV+lVjAA9PS+v8RkjhL0ieMV85q7DqgWUf06H6Tqch+svdKIZmaTKW7c6
	 Ts4mwW7NIBWaZZb+HKGprubXRalvLt5yFufgZbLMIRK0wiHgRg0reawqkjCRGJFpc5qps
	 CPFKfA7s7+6G+PSVFBkLOLB8TgKsRXz/H+5zfEwX70awoH2Seum57AXZU/IFfMIgoUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453604;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HAfb+6DUs0uTtEcf+iKm/8+qgjcv7Bls9H8c4BeRrAs=;
	b=KGwjBfNTL/unvDeyoGO7sfrcn0SN5oZFIsimP7JYJmT/oxVmEae/jWgZ+azT5Du/CSHP
	 sMI/ud/b++vSCbOY3L6RLYu9RiKEMhGpC4FqoaFSLHvNZjYYjNx6h2N8HmY61QK9mQPlO
	 mQm1FMW3GKYb9mtqd/Afovwa9rgBe6ZGtwLlt3og+cwyuYGOFaLnjDleayDtPLGkMPd17
	 NXQFBgMs2F4NWWFpYrJPzyXwDYJYtNcGLKHcB1TzsNMQ2RRP0f/pxNLCFFPxed1wIfnPj
	 0G2If6GX8OFo/6/UaxNhZv87AtNxtx4y3Lnna3CzwrE4VWRr0SEJmK3ootUdo2Q/EnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JOkt+7Vu;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA5606A886;
	Thu, 12 Nov 2026 03:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBA5606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JOkt+7Vu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HA
	fb+6DUs0uTtEcf+iKm/8+qgjcv7Bls9H8c4BeRrAs=; b=JOkt+7VuOdQ4lOZjPg
	pv+fQ2kLYgOKw2WyDgraRXax13C3KCcZxAUGXatDuL2WTK2rMyxNvRnFxf4i3L+I
	JxWE37LkBTTDcP9fpfcsu+SwiHxAKTkanHb/f1Syx41qFdsxXxURDY0K0dV20q4n
	1p9AFL1owHcf+KzdwoOnyrvNw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S2;
	Thu, 12 Nov 2026 11:19:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 0/2] PCI: Introduce pci_clear/set_config_dword()
Date: Thu, 12 Nov 2026 11:19:19 +0800
Message-ID: <20261112031921.1255661-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3Zr17tFykJFyUCw1fCrg_yoW8WFyUpr
	WfZryfWrW7GFySgFW7Wa12k34UWan7JrZ3GrnxK34rZr47ArW7XF9agryrCFy7GrW8Kw17
	urs7WF109w1qka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUDG5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xwz1mr1MDwi6gAA3J

Hi,

This series introduces auxiliary functions for the PCI configuration space
and simplifies the read and write operations of the AER driver, reducing a
lot of repetitive code.

Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
to reduce repetitive read-modify-write sequences when modifying PCI config
space. These helpers improve code readability and maintainability.

Patch 2 refactors the PCIe AER driver to use these new helpers,
eliminating manual read-modify-write patterns and intermediate variable
in several functions. This results in cleaner and more concise code.

Changes for v5:
- Rebase onto v7.4-rc2.

Changes for v4:
- Introduce pci_clear/set_config_dword() (Lukas)

Changes for v3:
- Rebase to v6.17-rc1.
- Modify the patch commit messages.
- Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Changes for v2:
- Modify the patch commit messages.
- Add new optimizations for the functions disable_ecrc_checking,
  aer_enable_irq, and aer_disable_irq.

v4 patch:
https://patchwork.kernel.org/project/linux-pci/patch/20251101162219.12016-2-18255117159@163.com/

v3 series:
https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/

Hans Zhang (2):
  PCI: Introduce pci_clear/set_config_dword()
  PCI/AER: Use pci_clear/set_config_dword to simplify code

 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 include/linux/pci.h    | 12 ++++++++++++
 2 files changed, 22 insertions(+), 19 deletions(-)


base-commit: 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
-- 
2.43.0

