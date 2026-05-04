Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76253E5564
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920207; cv=none; b=eA7vvGFb/JHkDdiWPeWPhmUFy2ry00cBkdvORK6j8gOIWO2azBUQB3/uID7BPXAeG1mTzZ4jme9xfqoYN+r5Pd0mKehlLbS2XAaPjQM6GYcZpd/GPE7L2rpn+mY+yWp7clCrdDlSWfDY9FVsikheq/FnKliZo1yXqvuMZ2eooOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920207; c=relaxed/simple;
	bh=c2vylaWTkP+lQdPDfHcsHllD1LphYuf66Sc/MNK9+zI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iuJQDw3nLweqYMiFinBUTcSihyyGyMkDal53sCj6cMQkUxxIOJCMtrKDZbqHUwRZXGYucOYPOu1RWNX6CVeF8pvMVueHaz9NtYW7Mg4Hx3Uz0DeULxLWhJRN1AaY5M3Br04X9TGDUL1vWy0WYNmv6Tg2WO/pCiAigQDGuX5RXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM3Y768q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM3Y768q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F248C2BCB8;
	Mon,  4 May 2026 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777920207;
	bh=c2vylaWTkP+lQdPDfHcsHllD1LphYuf66Sc/MNK9+zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BM3Y768q3CAQZxktNHd5DeHJL2SZxnvir81m/Y7im4y7t+R3UBxCkHa313Vvpaseu
	 IkENyJB6yl3FFP42pdbcC+FKSW/RbAI9WWlCIGfZzbgzxszJ1RDAIleQRQTmZ74gr5
	 1FLceHfVHRLqGFbDcV/bs88tIkcf/j4zdw7pdYsaj1JPfIRO07QYcP/ikKcnRO72uM
	 fcM9bj5B6osJiK8kppzZWxktk84PsT6bWa15GfsKgjs0iaEPb2lOcviMdEMOrfwiCr
	 UDnE1E+DKCraIR3frA0FgNW6tiFIujCBW0fJxRZPW9xvJ5XItTY9HsLoq68wYG8f4w
	 mucfqEyim+xtw==
Date: Mon, 4 May 2026 13:43:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: bjorn@helgaas.com
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after
 ASPM common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
Message-ID: <20260504184325.GA656008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUVSiQM+KAXeEFCPJSnQFq1Bc7F6GZys1ucfpE0Gs+3V6A@mail.gmail.com>

[+bcc reporter]

On Mon, May 04, 2026 at 01:29:28PM -0500, Bjorn Helgaas wrote:
> ---------- Forwarded message ---------
> https://bugzilla.kernel.org/show_bug.cgi?id=221457
> ...
> SUMMARY
> 
> Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
> Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
> common-clock reconfigure on the host root port, the downstream bridges go
> through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
> MB.

stuck-tamer-growl: Thanks for the report.  Would you mind collect the
complete dmesg log and the output of "sudo lspci -vv" and posting them
here (or in the bugzilla if you prefer)?
