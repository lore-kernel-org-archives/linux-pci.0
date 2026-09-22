Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D1361970;
	Tue, 22 Sep 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040498; cv=none; b=kKeQ4j0W3x/KptVkNytbHqjW0pXP/RNfU++qs8OAws+PlqkKEJdcZvVbdDClTLiCnGS5u923iU/xNsifZmCwGgEvg5h/ShLyhn+8TU+z7PtdtosKlaeuCewxR1XxH9IO3440U6e4FiCdDLiCyjKMocXU48MocWAA2sM4IBpQivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040498; c=relaxed/simple;
	bh=uwmgrDcKfV23mxoA5DcrWhYS/GoE5OhR/BNwa2EDr3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuiCXbzVvIT7UIzGA1gZJ/eSPfEmbB4J74hfEDUhSMbRW1el63iS/nhWc3cF8TkXtN9uTOBuCWZ2gMfwWQCJLI6LS0BM8NbFxypHgQdyj8GN1TfJtBVKYaagEgKU3qC+kSfIcebRujQvZEne+VZHLcSfD9TBnny2eeIUTRB+WcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCBECvw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCBECvw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD261F000FF;
	Tue, 22 Sep 2026 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040496;
	bh=lL4sJ7kD6YnNvBR4IahyBF4ibceDjqwb/p9P0/HIIBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JCBECvw9kx5PEho9eZeOwNaBxNviTdoOEnaSdLP5hSHquUJdachseeo//y7FuTXjf
	 ige7LhJJIX86Zmw2RRfhJYjNeKXFlN34O3Mbu48ydfiPA5UpxGBAyUQrWXnwp6ebMb
	 oNoeGlGKQWN746/0uRPCUB5rdBx3Ss/iW8sxFI8X/J06tx5wTDWHVGtkTZYaDaZJsQ
	 EkNleYE0uVMn4HOMlb28FyV+8CZ/sgF8x9sLH8VcHUPDUmb+N6wlDnxiKXMlmpig2g
	 RJ0Jw9zKP+ZqND/+ujIq7JLueKSguPIAkc+1qJUBhqP9lopqEDnDcSMCBlHh5DBxY9
	 oE/Mnhy2wq8Fg==
Date: Tue, 22 Sep 2026 02:28:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 01/27] cxl/regs: Split the BAR block request and
 ioremap helpers
Message-ID: <20260922022809.1ac1766a@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-2-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-2-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:14 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> devm_cxl_iomap_block() claims a register block with
> devm_request_mem_region() and then maps it with devm_ioremap().
> 
> A driver that already owns the parent BAR needs to skip the sub-block
> request while still mapping it, so the request and the map must be
> callable independently.
> 
> Split them into devm_cxl_request_block() and devm_cxl_ioremap_block().
> devm_cxl_iomap_block() keeps calling both in turn, so there is no
> functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
