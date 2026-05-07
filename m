Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B53B7B7F;
	Thu,  7 May 2026 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178571; cv=none; b=ZdTVb+jrvuaV8aht3MfiGTVXPVFSFUaE7PbIRAZg2mVmVxOrAhUhENmHcxCJBJajdZeZglezIO+RvAsgNvknZV0dq17nodQ36zCngv+PA7JGdTeUT6/+NH4Dr/z92u//+D9X2V2uqDmH+kKSTJHEt/QzwC98TO8NEfD3uiZ8LjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178571; c=relaxed/simple;
	bh=Li5t44X8CLBTyXHBrX5yYHLu5aIsEaNbJr/x5ikzBlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh8D/Iak3H7n2CEkyn+uHoQPa8+SEcfUdP1vMotxTZF9I1OTUZenlYyB6Y3zZFhJsAoaOhh7xY5l2M6M7vNWqK9hbDEoDXpix8vMwXYth95YmRnU4yPQAhLbaKvg6GVOxb/llVbqfKJhc0JzdcQ/MJE8vBrTQRTiXHk0fNnJRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK6EcH4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK6EcH4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C50CC2BCB2;
	Thu,  7 May 2026 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778178570;
	bh=Li5t44X8CLBTyXHBrX5yYHLu5aIsEaNbJr/x5ikzBlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WK6EcH4BJ9IPRxezKa+gmItkU5zufMLjv57rFPQ5Z+jKdchzc+wIS7mO4fmT0C3F4
	 77/Skfz6S3hXj3Vwkzj3R7xjriRdOGGsFZeZb7meuSTEs/QpebcWS4fyFBbQlpuKwQ
	 ZnTf4AW6RWoP90vWGxd4z1+mtakKzw5sM3fmxk8IdNTE7/+h4XEJxPKmMO54rnJTb/
	 g70yV6j2YlWK/lfTQAFtiTwpd2gM4EW230PKLD9kEHPy5oGow6y/H4K2r4+wR01tDj
	 /V3l4TY8qJ/hhitcx0ZQf7rholkxoED+Gv+ZNsHM9xflbYRwc6HKgqAdWvgkIf7adY
	 RF2uC03fTOP+w==
Date: Thu, 7 May 2026 19:29:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: <dave@stgolabs.net>, <dave.jiang@intel.com>,
 <alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
 <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
 <Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
 <dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
 <lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
 <alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
 <rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
Message-ID: <20260507192922.451244f1@jic23-huawei>
In-Reply-To: <20260505173029.2718246-11-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:30:28 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL protocol errors are not enabled for all CXL devices after boot. They
> must be enabled in order to process CXL protocol errors. Provide matching
> teardown helpers so the masks are restored when a CXL Port or Downstream
> Port goes away.
> 
> Add pci_aer_mask_internal_errors() as the symmetric counterpart to
> pci_aer_unmask_internal_errors() and export both for the cxl_core module.
> 
> Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
> in cxl_core to wrap the PCI helpers with the dev_is_pci() and
> pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
> @dev so teardown callers do not have to special-case it.
> 
> Wire cxl_unmask_proto_interrupts() into the success path of
> cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask only
> runs when the RAS register block was actually mapped. Pair each unmask
> with a devm_add_action_or_reset() registration of
> cxl_mask_proto_interrupts() scoped to the cxl_port device. The mask is
> then restored when the cxl_port device releases its devres. This
> applies to Endpoints, Upstream Switch Ports, Downstream Switch Ports,
> and Root Ports.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

I'd have definitely preferred if the ras code generally reported
errors on setup and then we decided whether to taken any notice
at the top of the stack, but that's existing code so not your problem.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Subject to Dave's interesting suggestion...
