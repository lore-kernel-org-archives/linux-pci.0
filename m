Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A83C5522;
	Sun, 16 Aug 2026 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786879200; cv=none; b=RE4kxa9Sv2cIwa8u4XERyN7RU0ANw1qOgVHFnos8CTapPBB48YolrIftc54yjOteZ89NHK3c3Kev3iJ8hfiBwlOdEatCpm4UBspldxtA2XXRZ9PIzBKJwz3ZqgJb3vlZbAu1NRDuSXOv8OV30O1jmL61Hfbtw+QqORE3QBa5Ztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786879200; c=relaxed/simple;
	bh=baYv8sRnl7njnWGpWePZZ7Lh1EnESdPhmUmNkKAjG/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3RaeO0JOawIs4Mbvw7Hxvl4QzOlvdAR2tTu+GFNuhQ2pOLJVkbAOKRXuz7ePkULdXidWUczwpX7lBE7N6MSqr9gh4PALU2ADcB5OxbX8eS5HZYxXLSQkkKYiPD/DyuiZECZC3bUq0SuDgZ0ZmbXFVyS55/DAmrB4+6yx0QlmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id AE3341062A;
	Sun, 16 Aug 2026 13:19:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 791D1629CE25; Sun, 16 Aug 2026 13:19:48 +0200 (CEST)
Date: Sun, 16 Aug 2026 13:19:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: peng.guo@montage-tech.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, djbw@kernel.org, johnny.li@montage-tech.com,
	jingzhong.yang@montage-tech.com, engguopeng@buaa.edu.cn
Subject: Re: [PATCH 1/2] PCI: Add MMIO Capabilities Register Block definitions
Message-ID: <aoGc1Ie-S5-Ytsp_@wunner.de>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
 <20260816084957.3316727-2-peng.guo@montage-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816084957.3316727-2-peng.guo@montage-tech.com>

On Sun, Aug 16, 2026 at 04:49:56PM +0800, peng.guo@montage-tech.com wrote:
> The PCIe Management Message Passthrough via MMIO Mailbox ECN defines
> the MMIO Capabilities Register Block (MCAP). MCAP contains an array
> header followed by capability headers that describe the ID, version,
> location, size, and vendor of each MMIO capability.

That ECN went into PCIe r6.2.  For ECNs that are already part of the
PCIe Base Spec, it's better to cite the section in the latest spec
revision, i.e. PCIe r7.0 sec 6.35, rather than the ECN that originally
introduced the feature.  Reviewers (like me) generally have the latest
spec revision at hand, but not every ECN.

Otherwise this is
Reviewed-by: Lukas Wunner <lukas@wunner.de>
