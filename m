Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F7372EF0;
	Fri, 14 Aug 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700130; cv=none; b=TgtkqA1HhWnajbt3aoudo7dzaweFc9pwdz5gkeX5zIXs/Vy9v3v/5is83NctzYEvYAnBqj+AJtCTwVLhjzVn+og8lJEQjAt6mZGFZ9tb+4wvr4FUIEdJJTywUykQLiyxQyID0O984IZjuuCzxmFvCR09WBB3X8MZ/ZVbtfYcpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700130; c=relaxed/simple;
	bh=vXU31pIrSBLJwTVXE3XMHZkPOfcYAhYLUYsI44ksAk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhQ3Two6WhamCNdc67iLSZme2jDDbTgRAWFvd0IVU5rJ0dfvdV/8zW36bkBg4/gKuwZJmSd/4lMO0JEPWuu1j8Rp5QMY7fg0MKAz0IMXOxCKK5WZD289jUuqBKJBefwrWfM9+Tr6wzdEtVpfmTcIA4rJeveB/MYiceysLp6ydgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhHr7yb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhHr7yb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646EC1F000E9;
	Fri, 14 Aug 2026 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786700125;
	bh=Pte0yYpvKWieRPdASsm63OdJ3w0+16rYPlq3Qw/T5h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jhHr7yb3U5Blcje3j22ocMUXRBhU8/a/sy16gPjJHwYjREgIWnCOjTLmonVE0pqfp
	 pnp71uYSkxR9ecwjZJVbqQC1DhPrWrTkCqFVEBHookguqtv8NxhXmJ5jzP/WlHIZ/W
	 1ZNqwj2wWW5+HN3FPU2u4BwkWpNaRs9UtqPDTr1xS42pr9Dl139+c+aWYyM5FxvzTp
	 NQuDMlkW6ohqmorh4nOpWoX4quu2IBkBYZJyZxU+SZzNFbyABIldpeU10B3KjWxjJ5
	 2vVsPAqq/QkDoa1/BAmiKzbCHY0WZOtqzVnHX1bjdT8m9k9CIhdNNDBbQPuUBkFKRI
	 DnUCLn1fJhPeQ==
Date: Fri, 14 Aug 2026 18:35:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI/sysfs: Handle a malformed _DSM result in
 acpi_attr_is_visible()
Message-ID: <20260814093405.GA3463973@rocinante>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-4-kwilczynski@kernel.org>
 <20260814071951.085BD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814071951.085BD1F00A3A@smtp.kernel.org>

Hello,

> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing how the _DSM
> buffer is handled in this file, I noticed a pre-existing issue in
> dsm_label_utf16s_to_utf8s():
> 
> drivers/pci/pci-label.c:dsm_label_utf16s_to_utf8s() {
> 	int len;
> 
> 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
> 			      obj->buffer.length,
> 			      UTF16_LITTLE_ENDIAN,
> 			      buf, PAGE_SIZE - 1);
> 	buf[len++] = '\n';
> 
> 	return len;
> }
> 
> Does this code pass a byte length instead of a character count?
> 
> Because utf16s_to_utf8s() expects the inlen parameter to represent the number
> of 16-bit characters, passing obj->buffer.length (which is the size in bytes)
> might instruct the function to process up to twice as many characters as are
> actually allocated for the buffer.
> 
> Could this result in an out-of-bounds heap memory read when an unprivileged
> user reads the world-readable /sys/bus/pci/devices/.../label sysfs file?

The last patch of this series aims to address this issue.

Thank you!

	Krzysztof
