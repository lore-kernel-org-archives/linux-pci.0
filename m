Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269B388E7C;
	Tue,  3 Mar 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529806; cv=none; b=Sr9g2CyMg+TlgIC8Et6VrIYQ+VKyJ6F+pfkxv0m/sQUgREDyhBJ1goyCEvxdkHgkrqDykSlpfirsOjK3ZlSMLCYDTEz2mmd6ptDt7ZUjjgHZFHBIVTL4NLZ9dUu+RqRH+U0trlzQI9eqIV+4s5gbNCJyeXv2jht4ra+vMuY+Tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529806; c=relaxed/simple;
	bh=0zBTWC8IwXB4RbkGQknMHNdoMBuCWfVfKI+jsFXJbgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UimCrqU1AbtbEK57z59pEo1nggr7nrUsjybQ8OTkjJoqcYirBAi0TDdTLkl+kr6cr0VZbgQ6vHctlnyJ8gTbcfaTItfRsrCK1am3H0haQ81eW9ynJJUH+oTZhEMGC2tO1UDL2Sai35OpJrXsUoyzw7FRs1fUJCWVQ6crtKDoBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDd2VGpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDd2VGpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E32C116C6;
	Tue,  3 Mar 2026 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772529805;
	bh=0zBTWC8IwXB4RbkGQknMHNdoMBuCWfVfKI+jsFXJbgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PDd2VGpaDMViiHlpKUnz+h8PJT/E62xykUlrFdRUg+ue4P+x5Br1EwoEttR7FdvLG
	 MSq+wH8W35DjnCF6pPrj1ImTu36faqGr5WmkvGXDfnvtObfwEhWiv74qzqxk/I19ae
	 z2I6ss5Azih9POk9msxLy+1d7n82zNQxc8jPJNuLHgEw9/8gkx5pd+NPEACMbby9Qi
	 7d5yUH6xzcHyeXzhaWIiNlojw0KFdKIRsSoDK1PwIoU50UlBYWqj3vSmzDFs4iYYLB
	 nccNFudjcJA8rCtEzYAxfDK6bRJCpylcfv/dDnz1UBcHPYbKIMomDlp1hZfRqz1W1u
	 72UjOAmLaZ7Zw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Date: Tue, 03 Mar 2026 14:53:12 +0530
Message-ID: <yq5aecm19shr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

....

To support devices without  IDE/DOE support we need something similar. 

modified   drivers/pci/tsm/core.c
@@ -1236,12 +1236,14 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    struct tsm_dev *tsm_dev)
 {
 	mutex_init(&tsm->lock);
-	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
-					   PCI_DOE_FEATURE_CMA);
-	if (!tsm->doe_mb) {
-		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
-		return -ENODEV;
-	}
+
+       /*
+        * Note, low-level TSM driver responsible for determining if it wants to
+        * proceed with a device that has no DOE mailbox. TSM may have an
+        * alternate method for coordinating TDISP.
+        */
+       if (!tsm->doe_mb)
+               pci_dbg(pdev, "no CMA mailbox\n");
 
 	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
 }
