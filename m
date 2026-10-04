Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7B3C4176;
	Sun,  4 Oct 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132665; cv=none; b=K06lUp98fp5bi7OwGaysIS+3MQyF9tkVfm1yTRIqfr2/oFFOlQB6p2rmg8ecevYtFULoTZ19VYeEc9U9+2glF52kTHu7NKY3R4GIhUP5ogo89BJXY4PmjMXkIWkeq4C9ktsVKxvug8VIM40fHC8CfwfL47YfRj8Nk+zx3XdDqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132665; c=relaxed/simple;
	bh=iFYfvWe/84EtSEUwKbZqg2CzUmS0hAVKY6F6ce74PL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtuliBGQRl3GpHwbmA/1GyA7wkrCsLfO4Yh5R4qBMZLaUXOc8txyvCdkPurvdityub6W10S8bf+aAHkX9JREdMmgwldZHQYxmbZI3Xci9IxsSrVrxutECrCsiT5CmFL34X7seSXIjRcITtkJKwbCrDJ+dpyAtamGgTEXg7pUK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBx/4WEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBx/4WEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC0A1F0089B;
	Sun,  4 Oct 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791132663;
	bh=55nP/rLqMARhythDBN1wq7/XRWHuJqh11vtjRhmv9+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBx/4WEXKcMxf6R5/9sXX0HSxs3JWH+RhmfeFAFe2wVEMuoBiUShUG448gQGx8Jq3
	 xP/xj0P5FBVV4+ALsBsbt+rreALw2nPMOQwRrGXM/GS+dRkQxqeRPqSXfNGywdsX4S
	 PL+W4y8KglAPp7WcHkUX/a8x+uvAe6RZWfEUm6qXG8AuyOuioPsVCbCuT/cADEVtkD
	 rBR1hiOCxQ7CauuJtrrMwNKV5t1DTIabNSU+bSzZlwuYMB/oSSmTlKYAZg+hvsioFo
	 Ozw34Q11B/EoiCo2zr7k2innJrUuDR7BIpe2uHIDLZoWTdABnE+Ug59s3XBPDQ9IMu
	 W26mvZNwUpigw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v6 00/17] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Sun,  4 Oct 2026 17:50:43 +0100
Message-ID: <179112990410.2366640.1873231809749459726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 13:11:19 -0700, Nicolin Chen wrote:
> This series addresses a critical vulnerability and stability issue where an
> unresponsive PCIe device failing to process ATC (Address Translation Cache)
> invalidation requests leads to silent data corruption and continuous SMMU
> CMDQ error spam.
> 
> [ As Jason pointed out, because this series fundamentally introduces a new
>   RAS feature to quarantine and recover from hardware faults and relies on
>   a recently accepted SMMU driver rework, it is not treated as a standard
>   bug fix. Thus, most of the patches here don't carry a "Fixes" tag. ]
> 
> [...]

Applied SMMU rbtree fix to iommu (arm/smmu/updates), thanks!

[06/17] iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node
        https://git.kernel.org/iommu/c/2888520bdcbe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
