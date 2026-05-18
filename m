Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3C38911E;
	Mon, 18 May 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136145; cv=none; b=XVc+3Lg9hCQsXNDOp7n/O/i8k49KoDeBuFqHx/IyHFZkFCQPvn5BNJHgkt0boDuMhJwsDsq7iHZSkMfIYK2OPHTve2nD+Zxn5aGhWp5RMFrV1wPdRBbJtrarCY9LPTgCvvfmWUCMFBkD865KWbGg7i89+E8iEMbB/FidTRJswvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136145; c=relaxed/simple;
	bh=nlJL4FG+FlQ7lEA+xiz8OWHlZxqnOLIRISrvfbYSZCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DRLiacvzOwQ9StvIHw7w0bxjtLXxXIEaiVm+0LD+jldhK/wbJ42t7y4UsVyOLF8VjRMTMHQu4H/KFFirrQYlVAtetB8yL4FgHdadYltCo9Fr71sgLlesjCeB8hKq+cAu+z+NhADe4LaQR3joMhdv70g4NLmSbJ3DJRso5as/YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kolcN3Lw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kolcN3Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C2BCB7;
	Mon, 18 May 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779136144;
	bh=nlJL4FG+FlQ7lEA+xiz8OWHlZxqnOLIRISrvfbYSZCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kolcN3LwzJr9KUU+xnxSqAVFurh3qjlaQPpxSwOdqKSarhihMdZJoIxjAnjhJJRp8
	 RnW6Cztf+B78QeWzyju8byeHD4ZCgCyy7ddKHnY2BGXLBc38A4KK481fsH/gZVMjma
	 p+8NZeLvxQeGxu6/iCnPaxSCSxu5wMII17huH0iC82iYo7/uXQ/koynSsWhpqiN+VS
	 PPPoPrEYZtMO02sSpQ4ZivR8qX+w6drO0FoI65OMGjTgR5k4Of9PNtDsK1mFKkROY2
	 wKRI2Z9EkWfPuFO5YqXGAbFI8oCu3b/i9Tir7/EwdzglaoL5YoWA1DNtApdJoPemvq
	 go5llXJswlDbQ==
Date: Mon, 18 May 2026 15:29:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	corbet@lwn.net, skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <20260518202903.GA641158@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>

[+cc Lukas]

On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
> If a new AER error is subsequently reported, the AER driver calls
> find_source_device() to find the source of the error. It rescans the
> whole bus and picks the first device reporting an AER error. Because the
> previous error was never cleared, the error is attributed to the wrong
> device and AER recovery is started for the wrong device.
> 
> Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
> AER error status even when recovery fails, preventing stale errors from
> causing incorrect device identification on subsequent AER events.

Why should we add a kernel parameter for this?  How would a user
decide whether to use the parameter?  Are there cases where we
find the source of the first error, but we *wouldn't* want to clear
it if recovery fails?
