Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582905;
	b=eqAc0Vl7MZl0aLU9HZhWREEpX0LlesdmzuABAtW29tHTXKMKN+ApGuXLVUpVAv6nEnNd
	 SUAK7o5rAboHVYIw0gLgE+UtinL4+hIo0qCb4XcAXsdgJpSONZPDZJL+8gvMUXrhkvzTY
	 SHhG/ziUdufEbV7zIryaI9Z36OWUnd8j08tej0zEqWhj7IRjpox8G6gVB+X92jnb2aTPj
	 VgJk5grOmCmLtdDFjLsZ61fblhrfayOIYZ9TtXOMop7dRtiP9+AnDtt3nLrK1lpTbINv1
	 +UCL6sYhV6eJHRd2K+mM8bCVOh3UgGf6ebvyYzTOsKy7BW/JpYR5+xzQZbpndHFaTcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582905;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xiPiX5aJ+WZHjnGnGhnyeXRN38goUbQDKEwaRO9wji8=;
	b=ZG2F4/W30/yvh2mFdGJIw3Kc49Jhi8vApHAq3cxL55Vuzl8xS7wuITY6xvmHyD8nk8Lq
	 iDhHt16V3AKrPuLA7n4kGsaj48cDsQZtIoQU0MxuSl9TflKdhcqm0GWutXz/EmqX/3pvV
	 UJbkngWKNYz4fSMFJUrRHO17LylfZ694P9c4IuZEtYnozKBe93aaXVd7RBCYpaY4BEIsp
	 UwLZmYOIrAcld+z1imluL2jUBDs9XZhNXPLt9Q95l+742Rw8ojzNTbjAcg/gT8cgEC28g
	 lcEQ4LIxwGxuDfyTX3FxFPNRFn/GkbEN837Fbh6Hl2CZLaVDST/MuHzzSMbJenwhdfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hucYT8SD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC02606A32E;
	Fri, 13 Nov 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hucYT8SD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DC01F000C4;
	Fri, 13 Nov 2026 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582905;
	bh=xiPiX5aJ+WZHjnGnGhnyeXRN38goUbQDKEwaRO9wji8=;
	h=From:Date:Subject:To:Cc;
	b=hucYT8SDlkZq6QQ2tyPT/9h4JXnn+tYruLJ3Q4FR1AJiusx4OWflDa3CMeqFeJiEH
	 jIIhuj8kOEe8hBFBVdpYVoSbBTGAQxhC6PlBB3ktgRyQeP51SX9DtWF4BWjWCNmnHF
	 yOFbENAdnEOQFswJdToUeV+FwD2955mTGC/U91oRkIrG2g5s7/peb5arjemDRtLU7I
	 o+r+F8uj43iHU062Ejjp0xb2EkkZ6ek0MzFnLq8VWHT3SBHscjx+Qd2gUJFagrqfuE
	 8+dZszaK0fL9G5if4OjShCfET/W7R+H0v7FjAM9fEO9DQHaz7r3YGxQgK09GS2N/Gk
	 ZWsTk0lBXP+kw==
From: Joshua Crofts <crofts@kernel.org>
Date: Fri, 13 Nov 2026 16:14:59 +0100
Subject: [PATCH] PCI/portdrv: remove redundant
 pm_runtime_dont_use_autosuspend() calls
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pci-remove-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHIp92oC/x3NQQqDMBBG4avIrDtgFNrQq5QuYvK3zsIkZIwI4
 t0NLr/NewcpikDp3R1UsIlKig3m0ZGfXfyDJTTT0A9PY8zI2QsXLGkDhxRXrgp2dU1aNSMGDmP
 vpwnuZa2lVskFP9nvw+d7nhdmjG05cQAAAA==
X-Change-ID: 20261113-pci-remove-dont-use-autosuspend-d30cbbea7888
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794582904; l=1336;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=FeP8hgrgd/Hf8Ck77KmPUyPRwxduv3EkLVNwa9hKVmo=;
 b=Mf8dO331JR2FFZggemPH4MO68Xb5+a6dXYGmImOE5zkLZL/qNZ86+zm0pcyJ9HS0bIVtDnMtQ
 /mudfpkqK1LCkPMjLVEVXHzQqPFUxjlD7hg1BB4sakQciIMFDdV3ytK
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/pci/pcie/portdrv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 32fc623dd41087c7f92552117499359fae4c73d8..3ce960b4ea25e4a2bec1c9991398bc445871085d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -728,7 +728,6 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
 	pcie_port_device_remove(dev);
@@ -741,7 +740,6 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
 	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
 	pcie_port_device_remove(dev);

---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261113-pci-remove-dont-use-autosuspend-d30cbbea7888

Best regards,
-- 
Joshua Crofts <crofts@kernel.org>

