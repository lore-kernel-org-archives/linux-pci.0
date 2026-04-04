Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179586341;
	Sat,  4 Apr 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265606; cv=none; b=VMkjHeomsKxtAye4nJg2dMaYb8h2zYF31ixgv6+vLkptosRARPWtljWcKYLIPUX5XmwGqmPPzF8ZFW3gWyeO+x5WCqaqSv2BrwHzt00kKn5i3MA/DbBichjMdFNGXvE8Yr34tnLeOytcsgoaecNu/nFT98JL59T0IQeDG5mQe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265606; c=relaxed/simple;
	bh=vNata3QFOqKQe1j0D8ga66OZ9TCYAfaeLK+oNigpX7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQImHcOZvEQtM1JRN8R8e0VTqr8tAY2msrOWRx1oELv5am7ul+9Q35JlLUgzalopgVi3u0rJBskTAQND3FHIVy5FQmy3unWkKsrw8HeJycxdzRP2D/8vsVpCV8vj63d+kCxV3xDHRiJ71Nr22ToGuGZIwcbq1+l9aQnaaJDmwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGt0CQ1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGt0CQ1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC8C4CEF7;
	Sat,  4 Apr 2026 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775265606;
	bh=vNata3QFOqKQe1j0D8ga66OZ9TCYAfaeLK+oNigpX7g=;
	h=From:To:Cc:Subject:Date:From;
	b=YGt0CQ1RGpCSDsKMjOUvTBn9mmWMV1yR1FPBZCBm6n4NI25hY30Qah4IT4kf2+NVF
	 89UpIk9ac/k0UQGfLEfQv7CRpGJpKlwRPYpPxdgzp/n9mvo2Pr4rxDGwFzo8Sr4XlW
	 cLPo5zhdI+6BKSpjCktwGzLduXzUmNlzCQH4texYj0Bdd6bIiR6kg3KZUO/9PnaIPR
	 SNFY5EQUPqVMIOwxjaLZmJve8X3iUMqnWcgZRJ88naQfYPpY7B3Cy7xK8TBgpDrY2K
	 p0EoCHszCtotO56FSaFnUX65dKhIlpbnE/cesGNhIPaqZ0TRoYyjveiYu/o0H51m5G
	 GrfhFESlBVhoQ==
From: carlos.bilbao@kernel.org
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 0/2] misc: pci_endpoint_test: doorbell fixes
Date: Fri,  3 Apr 2026 18:20:00 -0700
Message-ID: <20260404012002.111873-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

pci_endpoint_test_doorbell() reads the BAR number from the endpoint's test
register space and uses it directly as an index into test->bar[] without
bounds checking.  Since the value is a raw u32 written by the endpoint
firmware, any value is possible; values >= PCI_STD_NUM_BARS result in an
out-of-bounds array access.

Patch 1 adds the missing bounds check.

Patch 2 removes a dead read of the same register that precedes the writel
sequence; the DB_BAR register carries no read side effect and the assigned
value is unconditionally overwritten before use.

 Carlos Bilbao (2):
   misc: pci_endpoint_test: validate BAR index in doorbell test
   misc: pci_endpoint_test: remove dead BAR read before doorbell trigger

---
 drivers/misc/pci_endpoint_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
