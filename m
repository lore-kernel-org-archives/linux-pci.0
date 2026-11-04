Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799649;
	b=oXRQnOt4gDTruGoURX5p8lMJ3zy/3m0Jf53okgv2+Sici37cJghwUdpHd6ABIwbcD3DA
	 EequzyH3vs8KvfgoSVb5cdvM99DJMm4L7nuwzBZ2EzmHDfUJJhQ6FkvpOKo9vjF8XCZBK
	 InHm9sdsurw6RSpa2IpXG4rRTscQgeoO4eJ4ElNeIz3XXHFoSq9eFqQuNE1r/HoGrspzg
	 7ynPuwrPRHUXOuRZMOUJQHhl1GzP9gVukTQbEaIt/WKl9X3v2V0SSXDJtlHrLoVhXZCbK
	 oakNqm2SGdF+QFMdbAdXULXpJJrZyJFTeh5jzzJ83sGU+kX26kfpZ8X0TgAugVFX0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EZAUQMhN3rMe7FCapRNk/7rrtwkPUHUoi09OPENdnHg=;
	b=GUbx+u8yytqEt4RRy392qsQ7Spuh2+oYqX10qNWcUm6KL2Kbj0rnR5A/8UPCiKNCpBGl
	 EX/uHP6a4SeZN97EQiP4N7a1IXkfC9lykN+V8huLIryo616QxnKONFxF0AuZNQhy78Z3U
	 ttXyZoGsiQpk4P/Ei8GM3On+edkLZhVRVaY61BOlTaJ5yAvrRiXailahfF2re83+YyEYw
	 REiYW0SBa0OW1Ct7fhXeMsvRTPMxYPdBTJIwlZAU5W5Fo2CtSzX0WYt3bCR217qjtGTll
	 SOXlElSkW9CbhFs34j3jZZOKQ6rWlDSDvN9y7zu0X56+gQfx2OLFPow3tqIDG5Mpcug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIrbZaDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F7606A31B;
	Wed,  4 Nov 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIrbZaDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263761F000C1;
	Wed,  4 Nov 2026 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799648;
	bh=EZAUQMhN3rMe7FCapRNk/7rrtwkPUHUoi09OPENdnHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIrbZaDlsoXr337Dd1aQvpZtyvWkUbui9aNsdGO39rnOez9/LC9vHEkL6oLEMmOjM
	 5ZS/EHVquAEEDjPxCrKhN3kshP7TS3JrO7w5Z0n0AQEv2MP6imfd5lntHJRp9EEZzU
	 AO1b/xidJ4xZJiAUB8EK5i2yqdQFoIbjV2rlSzG1AWl8xYdHcII+CrKkb2amyd2Tgn
	 siqgy24+C2iDDSdGuvES7WbPh2sAvX4J3wa6ToVDiYzL70KuyKjQ1uvZiShbArseLU
	 OZvXeGJ81KpgtvCcDjm84M+yrDFCeHPphdgMb/Wl3mb7UkVZo1aN5xTbwtXqV3KT5q
	 Uk3jtazUmpszg==
Date: Wed, 4 Nov 2026 15:40:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aus12iOdLyiIiywZ@kernel.org>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <179373348545.623992.16522569527665218421.b4-ty@b4>
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
In-Reply-To: <179373348545.623992.16522569527665218421.b4-ty@b4>

On Tue, Nov 03, 2026 at 02:21:10PM -0500, Pasha Tatashin wrote:
> On Tue, 13 Oct 2026 16:25:16 +0000, David Matlack wrote:
> > This series can be found on GitHub:
> > 
> >   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> > 
> > This series introduces support in the PCI core for Live Update, enabling
> > drivers to preserve PCI devices across a kexec-based kernel update
> > without interrupting the device. This functionality is critical for
> > minimizing downtime in environments where PCI devices (e.g., those
> > assigned to VMs via VFIO) must continue operating or maintain state
> > across a host kernel upgrade.
> > 
> > [...]
> 
> Applied, thanks!
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation
 
And luckily we have a few weeks chase Bjorn and Alex for Acks ;-)
 
> Best regards,
> -- 
> Pasha
> 

-- 
Sincerely yours,
Mike.
