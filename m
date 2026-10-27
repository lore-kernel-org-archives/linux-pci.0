Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097614;
	b=nqYCtbtYPRNUBhjkENPYN7xSzw8PGQk3LILDeEs8+kmhDVJkP7qIa1AXeinXK3I3DkPz
	 xb1VQNn22Du43EQm/q90ddTmv0UnFYMU0dSes2G8q0Up7qM32lzKX4fkv21H4zcejA8kw
	 zLxGCYR3jVsCp0g6HE+VSTY/U1Co8E1e+z47hQd/BQzkCVHkNcIztT+v9O6jgzy5AwmFP
	 6bxgJdWwNFFhbTKx79NIU2hgWSpUoYE1kdWt0d2WL3TZTLSVvUUnbNSPoO+UZ6nMV8lSh
	 SOVC6oQaAStJKisHdbyJObK4lWshUNI81E5caLklLvbvlqQsvHSgZPY7PXloIetBu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097614;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lJ8w6RICVC2rJQWO2YwEqy5AlXDtvGnBkAjzZ4fE/rY=;
	b=yLCJfl+XbvXgGkk+rsgTrVcqEbiTmxnzIPaYptAVAvAj+GsBU5bD/hcD9HNL2Ep9wOzv
	 7WfFnZwqLHlsTeKfQemMq79AicArCYEQqZh88oEKYluA/z3X6gJNA2FQI0jHLoTP+G7ua
	 NxeAWbWQp48b6s2IBWeBkwTofhtCmyIEA7D49x5A4+TXeo+XPruCIsqxydiaOzTR/dGFX
	 ijrDa4Cpy4oTFDQrJoTpCJBX0zp4e1V+8M7itreRYiUiRK5OGPkYqL8Z++jGeAeuTwN8N
	 +tIYxTAzFKARNSRnLq377Ec6OCqrZSMyKHqCTwj1oXbi28hNKnQCRMrlpa2iy68pKSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArOtR5Fr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CC606A328;
	Tue, 27 Oct 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ArOtR5Fr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6B61F01825;
	Tue, 27 Oct 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097614;
	bh=lJ8w6RICVC2rJQWO2YwEqy5AlXDtvGnBkAjzZ4fE/rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArOtR5FrPUw+T0ZItDKpF/wMow2WobDGJ1egLFPjYf4HWItg85vnTpQhqurXvLakI
	 JVWKvdi0ckDVJNF84xKnUW9/lNMmq/lYnnDQULzZ98/qCelywCbgmO+l4zHKMg2vvm
	 vLZIQwTuAxVbWK/hbiqrlWz2VA2RW1mk9agPD21lq/k5eM435bunH7MSr6Y4Vw9pBE
	 PY1D2jx/GOtzNIhbVtTw3Z2tJVWapV6ch2yR/y/O1U8c59lXWWZN3VCZ58OKCxLnaO
	 KOlEEh+iZOypd5geihe3nlkSAx5qX/ltnRWwzH1QbasdSlSXN+punzpesK8EBwpb5w
	 H5hh0fSbLBMPg==
Date: Tue, 27 Oct 2026 11:40:07 +0100
From: Thorsten Blum <blum@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <auB_h07OAckfI7gV@kernel.org>
References: <20260916100206.92853-2-blum@kernel.org>
 <20261026183718.GA335290@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026183718.GA335290@bhelgaas>

Hi Bjorn,

On Mon, Oct 26, 2026 at 01:37:18PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
> > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > returns nonzero, which avoids probing functions 1-7 on single-function
> > devices, but also stops scanning when a function is absent on a
> > multifunction device.
> > 
> > This can skip early quirks on multifunction devices with holes in their
> > function numbering.
> > 
> > On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> > 00:1c.3, also documented by the model list in commit abb2bafd295f
> > ("x86/quirks: Add early quirk to reset Apple AirPort card").
> > 
> > Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> > 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> > stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> > is silently skipped on these machines.
> > 
> > Check function 0 first, and if it indicates a multifunction device, scan
> > functions 1-7 independently so that absent functions do not cause later
> > ones to be skipped.
> > 
> > Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> > Link: https://zoringroup.com/forum/5/7170/ [2]
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Let me know if you'd prefer this to be merged via the PCI tree.

Thanks for the Ack.

I'd appreciate it if you could take this through the PCI tree.

Thanks,
Thorsten
