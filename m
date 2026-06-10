Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FE3563FA;
	Wed, 10 Jun 2026 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083218; cv=none; b=C4bl3IT1pppeMSFVP5ISkU2o18ZUdLeq5i/VM7BMvZ9HCpUnzg+8dz6PIkMAPQfJTFZslwSXhKJtOvmC2jdWXa20kDtvlTAN25KpegS9rSLPRQEqCLUlsRgdq0xMPMZFY6F1x6y6NXbQhr9WFCuEIrSUVsCqdxLBp6Ovn88NJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083218; c=relaxed/simple;
	bh=dAjGVbTG/Hl7i7F5CBUMJoQTOUpPtLLEFscIHk0DGZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbCHg3YjOYX1NimT9T5PMuXIFLp+uRjj/M9XB3I5GUaI3dMM2PZfvD2IlGAe8jECisi3bjoih4yWn63RVB3aaysgFPx1mt62oQ631t09Fd1wWhb7NqtI3eo2/hKT3h9O4kCrHCCb6UKxdvMTP4tGDT7e2nwlYYcWTvtNVY6Vdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xcxeojkD; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xcxeojkD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781083205; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PpLApk7k70O5urYcFe1MKAGUNSaS1SnO8IfTeUhOOkI=;
	b=xcxeojkDbogz0s1K6HsqzgtJ776cQgX/lay+1kIWG6qhx5cGCjPkRqLP9RDFKV6DdPrgMWRsxWKGWQ+BOTnt8Zp7tlHVsX0onC0U+T8rXMKIqed9AkTuUJhTNWbdBMhq9TggPMFfliLJgQr027wUHBI7Ek2KS3uvI/qm4pgC0PI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X4aHoG0_1781083191;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X4aHoG0_1781083191 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 17:20:03 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: linux@roeck-us.net,
	lihaoxiang@isrc.iscas.ac.cn
Cc: tglx@linutronix.de,
	bhelgaas@google.com,
	jgross@suse.com,
	hans.zhang@cixtech.com,
	himanshu.madhani@oracle.com,
	roger.pau@citrix.com,
	chrisl@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: add iounmap in msix_capability_init()
Date: Wed, 10 Jun 2026 17:19:51 +0800
Message-Id: <20260610091951.1073318-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <b9705904-401b-4698-b0df-c84ef2b1e948@roeck-us.net>
References: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn> <b9705904-401b-4698-b0df-c84ef2b1e948@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Mar 2026 at 10:22:12 -0700, Guenter Roeck wrote:
> Does msix_setup_interrupts() already unmap this region? If it fails,
> msix_setup_interrupts() calls pci_free_msi_irqs(), which appears to already
> call iounmap(dev->msix_base) and sets dev->msix_base to NULL.
>
> If dev->msix_base was already set to NULL by pci_free_msi_irqs() during the
> msix_setup_interrupts() error path, does this result in iounmap(NULL)?

Confirmed. We hit this on Intel Emerald Rapids (192 CPUs) when running
tools/testing/selftests/kexec/test_kexec_jump.sh.

The commit message of 1a8d4c6ecb4c states:

  "msix_capability_init() fails to unmap the MSI-X region if
   msix_setup_interrupts() fails."

This is incorrect. There is no leak on this error path.

When msix_setup_interrupts() fails, the call chain is:

  msix_setup_interrupts()
    -> __msix_setup_interrupts()
         struct pci_dev *dev __free(free_msi_irqs) = __dev;
         ...
         return ret;  // __free cleanup fires on error

The __free(free_msi_irqs) cleanup calls pci_free_msi_irqs(), which
already handles the unmap:

  void pci_free_msi_irqs(struct pci_dev *dev)
  {
      pci_msi_teardown_msi_irqs(dev);
      if (dev->msix_base) {
          iounmap(dev->msix_base);   // already unmapped here
          dev->msix_base = NULL;     // and set to NULL
      }
  }

So dev->msix_base is unmapped and NULLed before msix_setup_interrupts()
even returns to msix_capability_init(). The original "goto out_disable"
was correct -- it skipped iounmap because the cleanup was already done.

Commit 1a8d4c6ecb4c changed it to "goto out_unmap", adding a second
iounmap() call on an already-NULL pointer, which triggers:

  WARNING: CPU#44 at iounmap+0x2a/0xe0
  Workqueue: nvme-reset-wq nvme_reset_work [nvme]
  RIP: 0010:iounmap+0x2a/0xe0
  ...
  RDI: 0000000000000000
  ...
  Call Trace:
   <TASK>
   msix_capability_init+0x317/0x3f0
   __pci_enable_msix_range+0x21d/0x2c0
   pci_alloc_irq_vectors_affinity+0xa9/0x130
   nvme_setup_io_queues+0x2a8/0x420 [nvme]
   ? __pfx_nvme_calc_irq_sets+0x10/0x10 [nvme]
   nvme_reset_work+0x151/0x340 [nvme]
   process_one_work+0x197/0x3a0
   worker_thread+0x1ab/0x320
   ? __pfx_worker_thread+0x10/0x10

RDI=0 confirms iounmap() is called with NULL.

This commit should probably be reverted. The out_unmap label and its
iounmap() are redundant with the __free(free_msi_irqs) scoped cleanup
in __msix_setup_interrupts(), which already takes care of unmapping
dev->msix_base on any error path.

