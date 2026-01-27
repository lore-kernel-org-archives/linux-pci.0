Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D01A9F85
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554857; cv=none; b=nh0iCQ6rwGporwQ7ZKiTpaZ/Cbek3702hWyFGjAoT2Vd0dnnoIPzNhqhg4Mt1/T/22bawGkSEB67kkEXdT54pgyQfqQTeKSsmNBfIuncFHCh4j8HwwAzbNBcflIp0JseCnUzxt7BAzlHDjAVGqpqeKU40PQYKhwuByOV6b2Qtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554857; c=relaxed/simple;
	bh=/H7K35di+y+EhmmFwDD88J5ULIdDHgdZ4IyV+8b6/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WBRdemiM0eUA3FCWVJ123kUbB8aiI3J4JJJJlQI5dNTxKIKVj4Cf5b0/WG8B+m053Yd8en0EGYqkIbYUUiYu4kFi27U/hjhj1geKeq3SPfybU4hTfZ2DN0TpdB1SCwEqImjBWfSPWdZBa4TLhHB/mKfNVlQQWJuYGb4WAywmwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC/L3hnF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC/L3hnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C26FC116C6;
	Tue, 27 Jan 2026 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769554856;
	bh=/H7K35di+y+EhmmFwDD88J5ULIdDHgdZ4IyV+8b6/vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZC/L3hnFnH6Pq+FFLN5YLdOTWVldlN8s4OleLEYClwK0VLpSM4JBFd3q1WgyMgRet
	 6tyWqd6un7Vmsga8qyv3KhNjBw4jE1qSFt0fztDVQB6QX8XQ7sJ9JB6fj9Glu1lZiQ
	 ya60A94ln/F+mjZWNOG/gZhIQ4haTn7KLrq23wnkFMWqRC+5/eYZk/ZzZXd+Wi/rgd
	 NirnMlV6wKUI0tmPYMhSVSnswjKq1AJ5NPT3cjve85UYR6zcNtoYCQR/IaYQFBRzDC
	 1/nymRAPhGXGtxdQY7rOAuBPYtbDjxaPCiNtMtFQKd+9V9ohA73YLySeG65I4VQqfi
	 hxPUOhXpPsyzg==
Date: Tue, 27 Jan 2026 17:00:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	tianruidong@linux.alibaba.com, Keith Busch <kbusch@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
Message-ID: <20260127230055.GA384686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>

On Sun, Jan 25, 2026 at 10:25:51AM +0100, Lukas Wunner wrote:
> Correctable and Uncorrectable Error Status Registers on reporting agents
> are cleared upon PCI device enumeration in pci_aer_init() to flush past
> events.  They're cleared again when an error is handled by the AER driver.

Do you think pci_aer_init() is the right time to clear the error
status bits?  Most of those bits are sticky, so they're not cleared by
reset.

I'm thinking about the scenario where a PCIe error occurs is captured
in the AER error status registers, but the system reboots before the
AER driver can log the error.  Since the bits are sticky, the new
kernel might have a chance to find and log the error that happened
with the previous kernel.

So I wonder if pci_aer_init() should just find the Capability and
alloc its buffers, and aer_probe() should look for existing errors and
log them before clearing them.

Of course enumeration will cause some errors (probably mostly
Unsupported Requests), and we wouldn't want to log all those.

Bjorn
