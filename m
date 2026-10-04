Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B73CFF7F;
	Sun,  4 Oct 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132660; cv=none; b=lGAOEb+nfIHbsYvEgsgncHaqtAKFJWLB2KnUkrkh8vVjeJ3wrCV7VVVanhlWZSiKkkfzX1GbpKzbJ/mIDni7acRFrG/Yd2JA1OWTuj66E2K225p0sg8i3v1O7YrJqJsbORXBli5ZoQ8Tuh8KkF/VXgAmOtnYIzXexlofkqQ+9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132660; c=relaxed/simple;
	bh=JCidIUm3sRlD3jhIDoJa818+BU7UPZsl4HFTzapC/Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sru5PUIRHj7CAfBFllR06b485AthESmPrsgdQIoWbcJTxMiX6AYFuzVV2QazV1d2irnUzDceSWPRfM26wpNDV47bzzG5wk7fJAS5esjLpAEJr5iL3sxeLgetO4HFmDyAtluMiERwrgRSb/FRm2AcXdcCkHXHLcSitVHZiQ/biWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haSH8Acg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haSH8Acg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3CC1F00893;
	Sun,  4 Oct 2026 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791132658;
	bh=LP2fMzrU0K8D7zvaOGjEP0wUd36Gy0Q43v1N1nD45Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=haSH8Acg1QJNOZMgF+ewqo0gnPt34E2RXBCcsBvNhEw9QH7PFmJA9Ea0GPo7PZZGg
	 PH5konCHCpj6esW6lh/gaEDccb+/zsISKmrH6I2Z8GVRdcSXCqE/rummn87cHwRZbu
	 F9Bryn5C2povyRiuKjqqSle2fc0+9EBHqWPGSeS+eZwiRlcg/kYkWcUdlC4YiRW5Y0
	 mLrWJ/yg7XAFFYNaeZzD7Mdjh8Cb1kvLudpD71Cj4qjZ0kbwaoNX8TCnpmnuyC9m2B
	 znaheuZy8If/AkTOjQ88hWvyBNJvVv435bZMcggB3/VKeq5H/1MIjxr2RK4JhMAmcA
	 mZBFkqX00Z9bg==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	joro@8bytes.org,
	bhelgaas@google.com,
	praan@google.com,
	kevin.tian@intel.com,
	kees@kernel.org,
	smostafa@google.com,
	baolu.lu@linux.intel.com,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	skaestle@nvidia.com,
	mmarrid@nvidia.com,
	skolothumtho@nvidia.com,
	bbiber@nvidia.com,
	harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v5 00/15] iommu/arm-smmu-v3: Add PRI support
Date: Sun,  4 Oct 2026 17:50:42 +0100
Message-ID: <179112969067.2365011.2400275632382171863.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 09:38:12 -0700, Nicolin Chen wrote:
> The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
> faults. This series adds the missing pieces, using the IOPF infrastructure,
> to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.
> 
> The iopf_queue_flush_dev() contract requires the driver to first drain the
> hardware PRI queue and synchronize using a threaded IRQ handler before the
> IOPF software flush. This drove the additional commits compared to v1:
>  - arm_smmu_wait_for_queue_drained() drains the hardware queue by counting
>    the entries that the threaded IRQ handler consumes
>  - arm_smmu_attach_release() moves the teardown outside the global lock
>  - synchronize_irq() closes the gap before the final flush
> 
> [...]

Applied first three to iommu (arm/smmu/updates), thanks!

[01/15] iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown
        https://git.kernel.org/iommu/c/ab0dbf411ace
[02/15] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
        https://git.kernel.org/iommu/c/580bbfcdcd2e
[03/15] iommu/arm-smmu-v3: Add Q_POS() macro
        https://git.kernel.org/iommu/c/02b5c4639bcd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
