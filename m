Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608964DD3D1
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617235; cv=none; b=YLfupgHB1jQmTJmz9T7790aMFE4VxGnDc5AOHEXhIw85I54smcL+57XYIQbapQUptcAASIjqx1OoHL70LoHNTKHQPWglkoY+doIi3iJRfblJMprpL5Q/wHlXStIhLddIJGJM39aTCi/eIlgatir+M5wh1U5topdqz2BYSHd8tV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617235; c=relaxed/simple;
	bh=bhpyAU15yC6QPGadz4JxsbfOGUa1ye2WK8iafRoSRFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gv2dJK7D0JtOum04yUXd79oVpHwdDc2tjcBcqLsh61Z9Ozm4iHS5LmqiGrAbFhAk+ua3NNiZjz8WykCN73cxfs64hUaTIhNZHsayQHaAnI9TrHDFe4DeWVmJiovICfwCNUAXBiat99531R5d6Dhhdom16DKBZnnR+e8wCLgEgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFFw/qtm; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFFw/qtm"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso2748027a91.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617234; x=1791222034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=oFFw/qtmkPcaAdDhrUT5O3OKP1pPiLdlkXUnQWEkCnpfSnvmQ4mKhOQTryU1BlQYUh
         WvSCFj5VZVY6FQr7ftU2w4p9LC2JMiew04+IT97ZsM+M8Ab0ESNZ+vbgdDbvgBQS6JnV
         S9djDEag7sU7dmZD14OmkRvzAlgtWNepeV7HjC3sAZGJLCzRjD2Mq544g1HvQT/oVIGO
         i/2M9RBU8xL03m8QLIhxQ2juNBWO75WGenLWGMPOy1ZrGrOJzFZGyWz1juvnoMq7o7yo
         xGOAsnVMheqlCu8Tuf/NQ59bBfeSGVqSzBSzT3Ef97qPTzMKQrWJPdu/OIkvhg1OF4Cd
         PYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617234; x=1791222034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=OpiPsiPL0OJA8U7TD3uz4kh8I9nWrh10I0AWe3v99F49ChIE2cbnnejcmBdflvgCuJ
         eJF6Bw/zJRrX2pTw0drSCu5lVMN9GEWOKwQZrYcWNwZPct47lYSIFNCVEcqEpIvAfr8U
         KPp8TmCQBVX73tV+azgUjg2ujbJZZZl/FeAejuMOayEl9sMMmPHYqpQz762Tuo4+f9cG
         BHBCtx3T5YpetPYYr2Fduil5io/SZA6EACUffoHte4rC4ksQzf7hLXyXoiI3KcHtB3iM
         FRiJ15p78/eUXNTZDarD9zMdt+HZ5zF/06TSaUNpTomJHxYyY5LDL9kwQJnJEW0VjJBZ
         uG3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy35kTiR13RRIScz7S72yw3bDUA5EQQAvwdmL0NmP0e2LNtW/2S6v23XrmAFi1/5EIxaufRnPGFHBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDDtmQV3Na/jMJJLVURvLXPrYENeKLN9YmJStxxWxj2ZYGrxhX
	A/x6Cq4H+cDsVqnm98lo7SmXfEJ7y7mTrhu1hClpEiPMQbz6DFADXXPjGcAWnqkKlfncf+VrDqN
	mB13zH0KpvYLJ3eaNzL1Z7RwyFueTqq+W2w==
X-Received: from pjyo13.prod.google.com ([2002:a17:90a:eb8d:b0:3a0:dfb1:6c07])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a2b04e8389mr2449084a91.44.1790617233471;
 Mon, 28 Sep 2026 10:40:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:12 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-1-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 1/3] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
to aer_recover_queue() to be enqueued into aer_recover_ring.

If kfifo_in_spinlocked() fails due to a buffer overflow,
aer_recover_queue() logged an error message but returned without freeing
aer_regs. Because the entry was rejected and never inserted into the
queue, aer_recover_work_func() could never dequeue or free it, leaking
the allocated ghes_estatus_pool memory.

aer_recover_queue() returns void, so the caller ghes_handle_aer() cannot
free the buffer itself: ownership is transferred to the AER code, which
until now only released it on the success path.

Free aer_regs via ghes_estatus_pool_region_free() when
kfifo_in_spinlocked() fails on buffer overflow.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..b013b853b555 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1415,11 +1415,14 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	};
 
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
-				 &aer_recover_ring_lock))
+				 &aer_recover_ring_lock)) {
 		schedule_work(&aer_recover_work);
-	else
+	} else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					      sizeof(struct aer_capability_regs));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

