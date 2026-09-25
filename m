Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799850AC35;
	Fri, 25 Sep 2026 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377998; cv=none; b=ew+v2qw1cFsK0kyCqF4dBfbAPHSPR8oa2NZQHLS/4TT1kfAtaZXG/YTm7EZYDJE9qvIww8J2zr4tx7rkupV3MT021L+JQvnqSpWa/QcCoSXBlBKS75oQfPd7A8eXtWHvp7bFScPPT/VLvMVxFPWkNyR6h6DmKe3iFK+G2jXZKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377998; c=relaxed/simple;
	bh=e1j5V/L0VzspKNk78JWsm8355AhsJzdZja1i2Yc21cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZxyQqj+H2GGOTDdW3gy4SQ/XISCjoj8yKXTgDmiYWZnjBDuD9spmU4OJ72BSi23tn5XZ1U4InCKyzJYtAaPzlXddnkwYq1FoEW5OfV9rqym1RRBeusaknjsrOD9NJWEUU36XJCW+/DZ7ORRA1s6Ekkm3DYuC2vvkEG6mrpI04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QanQH2jI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QanQH2jI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D4D1F000FF;
	Fri, 25 Sep 2026 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377995;
	bh=4zdOp4OInhQs1N3FTnInrZQD8rBPlTXBdjpw6h1ZL/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QanQH2jICPlqPLsXjriL30mgkc+t/HLU0FDAcsKhv8A2cyVXjF0UjtKLT8gjwKjlK
	 r5OF3xA/kA8PiTKAZwefA7GSmOzTJOxmMn66F2EayD6f+dnJRVrXNqXAZpTTLfRvMg
	 UvlnCF3+fRVCRUpBCHDDTBWzXjh+yOey61zjZzFOmhEqQ8xdxPjI2Lenr1Zxa2VMuN
	 Z+SOMaemdK1J/WL5UzMbw7NgD6lwW08zTaTu7BdyWUjsFe/0b07hg5QcOr2ImSUihy
	 t+TxrnNbn4nG2J/Vx1nTA7OpF5dlbUpVjljJfoNXWBvk96lQuKWm3yOGEW81tWTzvj
	 dZ/gTr5T/uGew==
Date: Sat, 26 Sep 2026 00:13:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Jason Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pranjal Shrivastava
 <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v6 02/17] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <20260926001311.7c4be583@jic23-hlaptop>
In-Reply-To: <a05695c1dcb0682425bad7b8387cd24ad71e2d9d.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
	<a05695c1dcb0682425bad7b8387cd24ad71e2d9d.1790188510.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 13:11:21 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> cxl_reset_bus_function() reports "supported" to a probe after checking only
> that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
> can still be unavailable, e.g. on a bus shared with other devices, so both
> the reset_methods[] array and the reset_method sysfs node end up listing a
> "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
> 
> Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> applicable, pci_parent_bus_reset(). These are the same two checks that the
> actual reset runs, so a shared-bus CXL device no longer advertises a method
> that can never succeed.
> 
> Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> check rejects every CXL port with a masked SBR, while the do-reset path in
> this function unmasks the SBR before resetting. Such a port would wrongly
> probe as unsupported.
> 
> Move the port control register read above the probe branch as well, so that
> probe runs the same checks. That read asserts no reset, and a failure means
> the device cannot be reset this way, which is a probe-time answer.
> 
> Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> probe is always false at that point.
> 
> Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Nice clear explanation and it looks like the code does what that says,
so I'm fine with this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


