Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22650223DFB;
	Fri, 10 Apr 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862186; cv=none; b=hqWqGAoSLhLXhcD8iH4eZeRoF1BKByAm9sQ7SBc2skFfR6rzrQFzICAgtYIV0EgjWBGlHhBGVe8YNe4ecQCpxCetRmwOmcIxJxDfUKT+XAFn2P7k869cNyX4LCsL7i8RL5TzcSThjh98bMbX426/ivsBJqAma4CDnTM6d93Qz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862186; c=relaxed/simple;
	bh=WAMkBQc1h8yLAINGXQ2j2zMism2d+aY+jNOWL9O+r8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRMfmwUqSezWaLGgBJFfHEsht126QqY+D8RhsL08+e8HFuenrLNTTvwUjZewEqlBE3cgFnYca82GOJsEMSphqc0nFaQGG6V/oFIaHCmQaEtNQsaJCxcC30so/BZD1Cy/fneaQLHy772vnhyGL4M3wcKDcR7pBGz2G/8knzFtcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXfiawP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXfiawP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EBEC19421;
	Fri, 10 Apr 2026 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862185;
	bh=WAMkBQc1h8yLAINGXQ2j2zMism2d+aY+jNOWL9O+r8k=;
	h=From:To:Cc:Subject:Date:From;
	b=TXfiawP7sieaI/A64eJV9CY8NxKgW2/c1R5vAZNGtVMOGF1VB5IhF64lGAkygis1r
	 BErHzvkrm8T0CNxLe4Z0YFElv9ZKoBFRRojXgBELQIMgq2phCNiVlpAzDDHAsBAYQE
	 BKy9Yv0bRL//Dd6a3+BdlGWPotLS7Yvqr1YjanVM6qiOV08OAk2lG6xubtyQQ1k/1d
	 PAn1/AE4BB/R4QwRih7x8vb0ZWTpHXW3rmGyE30UxHlcvMTjhGCV/EiVx+wBPTXgGV
	 1ivQFzvDfqdWNx3+uOUBqOidwGP+BuLRocnwRcy1fiv/u8WXn9WC+efdUtsWD9D/Zd
	 /itsCwXHp5mug==
From: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	den@valinux.co.jp
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH v2 0/2] misc: pci_endpoint_test: doorbell BAR validation fixes
Date: Fri, 10 Apr 2026 16:02:58 -0700
Message-ID: <20260410230300.135631-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

pci_endpoint_test_doorbell() reads a BAR number from endpoint MMIO and
uses it as an array index into test->bar[].  Add a defensive bounds check
covering both out-of-range positive values and NO_BAR (-1), and remove a
dead register read that precedes the writel sequence.

Changes since v1:

- Patch 1: extend bounds check to also reject NO_BAR (-1), which is the
  Use %d (not %u) in the error message.
- Patch 2: no code change; add Reviewed-by tag.

Carlos Bilbao (2):
  misc: pci_endpoint_test: validate BAR index in doorbell test
  misc: pci_endpoint_test: remove dead BAR read before doorbell trigger

 drivers/misc/pci_endpoint_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0

