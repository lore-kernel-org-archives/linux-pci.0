Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5F3033CB;
	Tue,  6 Oct 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255729; cv=none; b=uSRHhE0WjLeZDlaYIvSMZBGRlQYIHliHViJQ+i/+qEzVzjrvyvi7LioGTz68dsr00e6NrFpgeR6Mv4CKtaqjd85yT7QE1mYibSXx40ZeZHP4TDzvtAhLkATxUHTkjVUw2J4X7zkO+08IMDf3qSQDgQ8GsCv5IMvxozY4zoYp6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255729; c=relaxed/simple;
	bh=b15E84kfB8rqaYJ7OrtsC5/SG72PD/BU+DwCNGnv1ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg/me6XeImIsx9oSvrwh7PYMmR1mNvwBqfBmcgNJ0n/xHQ0KUhhTHWbc6qYYMdthMfklgSP88jFPbWUuOaqa6V0PafqW0wMKBL5NIHnzK9H2uYQikuGweqolaqQXvG0/vh6O/f0PcP8Ue0baIjgaK14+bXaTRntIYN4POWaP2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 55432C24;
	Tue, 06 Oct 2026 04:56:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 17816627ED97; Tue,  6 Oct 2026 04:56:50 +0200 (CEST)
Date: Tue, 6 Oct 2026 04:56:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Perlow, Jason" <jperlow@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Aditya Garg <aditya.garg@linux.dev>,
	Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
Message-ID: <asRjch1fMBslk07D@wunner.de>
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
 <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>

On Mon, Oct 05, 2026 at 08:17:12PM -0400, Perlow, Jason wrote:
> > > My guess, and it is
> > > only a guess: treating a possible Advisory Non-Fatal Error as
> > > non-Advisory and recovering through the uncorrectable path resets or
> > > disturbs a T2 function, and the T2 then powers the machine down.

Advisory Non-Fatal Errors aren't handled through the Uncorrectable
Error code path.  The kernel just reports and clears the errors.

And if the device has a driver and that driver implements the
->cor_error_detected callback() in struct pci_error_handlers,
that callback is invoked.  (Currently only the CXL driver
implements the callback.)

>   masked only on 04:00.2 (Apple T2 Secure Enclave, 106b:1802):
>       stays up (120 s)
[...]
> So here the trigger is unmasking Advisory Non-Fatal Errors on that
> one function.

That's quite unexpected.  Maybe there's a bug in the PCIe IP which
Apple used for the T2 Secure Enclave device (which I believe is a
fully-fledged arm64 CPU with a PCIe port in Endpoint mode).

Another explanation might be that there's a watchdog on the T2 device
which monitors its Config Space and triggers a poweroff whenever
some suspicious register mutation is detected.  I'm just guessing
here because this is really weird.

macOS likely never unmasks the bit and so they never saw this during
validation testing.  Is the T2 device visible on Windows?  If it is,
it seems Windows doesn't support and unmask Advisory Non-Fatal Errors
either.

> Would you accept a quirk that keeps the bit masked on Apple
> 106b:1802?
[...]
> I am happy to write and test that, or any other patch you
> would like tried on this machine, and I can send lspci -vvv and the
> journals.

A quirk does sound like the only possible solution.  However I'd
really like to see lspci and dmesg output with the bit unmasked
shortly before poweroff to get a full understanding.

Thanks!

Lukas
