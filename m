Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23D37F740
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884183; cv=none; b=B2E9L4g6UqHUzCnCxftnO7Xi6TpYUTi2TyNf5kzgL25ATg04tWjFQ+FVgBMI22PyfO1vYDIAJFHXjTfKeAglzqgnU/pceoY9HhRSy5wvZQeyPYoOkhs2FhSQybmAY36MjUiodgVOT0xuJ2qG5fsaCWitSbQDPYQxjqTKI8FjmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884183; c=relaxed/simple;
	bh=9Sb/xkU3v8/9uduQw8INIPdXie4ch1cc63FC0eUwks4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl5k6LU9DpT40BeIVEzklpACtMne/d3ytA7M8yN31J2uGZ1VTnKjH6ntb+Iu1PGtaZDEbdcwXfUcPiYf72q76pk6gPlYvkPjKdr9gPt+PMzfYSpW1cwV7z4L0hpbZHqIiFeZv1v+kkhheAN8Kv0ox3AFzNrD0s1XZGDQ5qPOlNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b9B2tjuk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9B2tjuk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvLU3/OFGdKoVwhBbJQJP18E6kos8ULMe5LmNRtSO6Q=;
	b=b9B2tjuklqH75ksP6xPP5SMFQDHmY2nf/rzwbHWSgnsbxGw9swK4lW3bz0xxKnu+dZu+CF
	+OX9hYMAKTymCLnwr9JXbusWVBuUiyCPhasc1YITx7YXv6Gi8pKgRry37ryKBGBv90gTrI
	DGRpiJfpzYSjPq9cLWo4c7UeoRyIczM=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 27/62] pci: Fix locking in pci_do_resource_release_and_resize() error paths
Date: Mon, 23 Feb 2026 14:00:27 -0800
Message-ID: <20260223220102.2158611-28-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

Make sure that down(&pci_bus_sem) has been called before
up(&pci_bus_sem) is called. This has been detected by the Clang
thread-safety analyzer. Compile-tested only.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..3bb8cd9a581e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2346,6 +2346,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (ret)
 		return ret;
 
+	down_read(&pci_bus_sem);
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
 			break;
@@ -2367,7 +2368,6 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	if (!bus->self)
 		goto out;
 
-	down_read(&pci_bus_sem);
 	ret = pbus_reassign_bridge_resources(bus, res, &saved);
 	if (ret)
 		goto restore;
