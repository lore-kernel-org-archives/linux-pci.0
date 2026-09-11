Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008635F184;
	Fri, 11 Sep 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168414; cv=none; b=JycSYiFRHfh1AtiLvYBfkwyqFi8Am5ySRJ9iby54sEo3E58lIfM6RSRD7CCmGbntyLhWYsJpLvx8m42S6Biaay1ROIU05Nyzfmv4LrnKL/X/UyrGFSs5ML9JZmtPy786G1NXES7CUc2qLIh/LIuQvyWNDtzz1v0R5xiGgRtmZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168414; c=relaxed/simple;
	bh=w8vlYw3ZfObRrCTCxK3wPAtyiumytNGPIZ5DP+a1z4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCEwQFvLhM3T4dYfIHwZCO8fSrvdN1my6eld8NCMUdnXz73/Y3zAdwoYPU46+KN1ciFxCgnSK4xDN+br+/BNsBiEWgTuupKMakGYn9okF1RyZdmBqyeblnHfb0T7lNU9vuEPmxvar6QhwSPVwla3DZrte+28xsgLaMvXfgq8dzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKGUrSVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKGUrSVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBA01F000FF;
	Fri, 11 Sep 2026 23:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168412;
	bh=Y5v6lOxScwOr+cmnQo0xSqrrs9HyK8+38vZD5FXttQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PKGUrSVCrASmbqz/7m9qCFgoTVmmrZJZKjDUjiAnEi/nM60LLox2pKyulfvIgDSnK
	 h80C/ymw8DJdrVS3SlftbGoVi0uBzveDTzSXklENwvyVbkpVJpeXCV3lyDfHH+Mjf9
	 i40uGEQJxjh9KGI/axALc9cH1RA1LeODerQGtmApf8NSMkttA29B2P/egJ2SpvtJrL
	 E8kqti5mke0q8wDDse31zYrok50nKwvXHnIU7bF3hWz8SwkYulytFM+gA4bME7Vo3Z
	 6Bhuc3FGggmDQHoclhHN9xrf9+GQgBbJ9t4rVHPeXnjrs5pzoxGh58eApyLfVGH5UH
	 q/TUug1K7gmJA==
Date: Sat, 12 Sep 2026 00:13:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
 bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/AER: Map a raw AER Capability image field by
 field
Message-ID: <20260912001329.6db3222b@jic23-hlaptop>
In-Reply-To: <20260911164705.841407-1-dave.jiang@intel.com>
References: <20260911164705.841407-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 09:47:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> struct aer_capability_regs is not the hardware layout: the embedded
> struct pcie_tlp_log spans 60 bytes where the Header Log it stands in for
> is 16, so a flat copy misplaces everything behind it.
> 
> extlog_print_pcie(), ghes_handle_aer() and cxl_rch_get_aer_info() work
> around that by stopping at the Header Log, dropping everything past
> offset 44. Flit mode is never decoded either: the Flit bit and Logged
> TLP Size sit at offset 0x18, unread, so the Flit DWORDs at 0x38 are lost
> and the log prints as non-Flit.
> 
> Add aer_cap_regs_unpack() to map the registers individually, taking the
> TLP Log layout from the Flit bit as pcie_read_tlp_log() does. Clamp the
> logged length: Logged TLP Size is 5 bits wide, so an untrusted value
> reaches 31 where dw[] holds 14 and pcie_print_tlp_log() walks
> header_len unbounded.
> 
> Take the image little-endian, as both sources are: CPER by definition,
> PCIe registers on the wire. Read it with get_unaligned_le32(), since a
> CPER section sits wherever firmware put it, and take the two source IDs
> out of the Error Source Identification register by bit position rather
> than byte offset. cxl_rch_get_aer_info() uses readl(), so it hands back
> __le32.
> 
> Convert all three callers. cxl_rch_get_aer_info() now reads the whole
> MMIO block, so size its ioremap by the hardware registers (96 bytes)
> rather than by sizeof(struct aer_capability_regs) (100). Shrinking the
> mapping is safe: the read it replaces stopped at 44 bytes.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jiang@intel.com?part=5
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=tzuRO+dZc=CnAEQ@mail.gmail.com/
> Assisted-by: LLM
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Nice.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
