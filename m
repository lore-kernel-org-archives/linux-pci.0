Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C283ABDA8;
	Tue,  6 Oct 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279887; cv=none; b=KzeowX+1+IkT1rb0+NNaFqAy+FIrewCnnIBXB+BJ7RzoxOG6RYZyHj9QFEEa0LIc9BZXk/XTgGbPO1uUKmKx1CVa7wOv7bYGbBHMFeZhRXdkIqzoiO36tfR81n+tpfzH0rHjgLwiLcpcOy2TdvbrZ5xfHzzTMXJNYVXbrdbqzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279887; c=relaxed/simple;
	bh=ZvUH+z8vQ8h5nsALRrcCmlmDFeZr2Esi/BQtBak8F5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCpwCVcl7VTynDqeAFOiDZJEtnNNHRWIFOQIY1mJqZKPnK91Rxw6eupxTCpKIpyZzrkPWbw67lxOt1nhKLn6JkfiCFhhwQ/8zDDjB610pk8E7ODdyBgFPXEARi4TkMzOr0c+W5zk+ugooTuNqls8a55FXz7yPvZ2uScuOrw+dF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 60693C29;
	Tue, 06 Oct 2026 11:44:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B5CB627ED8E; Tue,  6 Oct 2026 11:44:41 +0200 (CEST)
Date: Tue, 6 Oct 2026 11:44:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: "Perlow, Jason" <jperlow@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
Message-ID: <asTDCW28kKBfKAVs@wunner.de>
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
 <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>
 <asRjch1fMBslk07D@wunner.de>
 <2a7a97cc-7ad0-4e6f-845a-dd841d36079b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a7a97cc-7ad0-4e6f-845a-dd841d36079b@linux.dev>

On Tue, Oct 06, 2026 at 02:01:52PM +0530, Aditya Garg wrote:
> On 06-10-2026 08:26 am, Lukas Wunner wrote:
> > On Mon, Oct 05, 2026 at 08:17:12PM -0400, Perlow, Jason wrote:
> > >   masked only on 04:00.2 (Apple T2 Secure Enclave, 106b:1802):
> > >       stays up (120 s)
> > [...]
> > > So here the trigger is unmasking Advisory Non-Fatal Errors on that
> > > one function.
> > 
> > That's quite unexpected.  Maybe there's a bug in the PCIe IP which
> > Apple used for the T2 Secure Enclave device (which I believe is a
> > fully-fledged arm64 CPU with a PCIe port in Endpoint mode).
[...]
> > macOS likely never unmasks the bit and so they never saw this during
> > validation testing.  Is the T2 device visible on Windows?  If it is,
> > it seems Windows doesn't support and unmask Advisory Non-Fatal Errors
> > either.
> 
> T2 device is visible on Windows as well as "System Device"

It looks like lspci is also available as a Windows binary:

https://github.com/pciutils/pciutils/releases/tag/v3.15.0
https://eternallybored.org/misc/pciutils/

Could you double-check whether it unmasks Advisory Non-Fatal Errors
in the Uncorrectable Error Mask Register, on the T2 or any other device?

Thanks!

Lukas
