Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCE32FA2A;
	Fri, 23 Jan 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180250; cv=none; b=laTYyUmm42VxWK8bC7EYorDbiVozoASQMx+N5h4o4JMQxp6Sc6d6+E+cX7enVUoEVsNZF/Cp+K6iwwRiPLmm/+dRdnXgGSUirR9epzYD5c0l2A+eMcP1MuyvICV/eDSB4LHg0Lc3n+obRdrkQLxhDV2vZwk0BbLs0GonvKzoZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180250; c=relaxed/simple;
	bh=r0kw9edHnS7R1ESg/5g5RXGIYX5Nrze7ea54bTHrVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTFFt+VJjKRV06AVkAb8oM35TT1PyQXHKcKnfehSr0efEmWmVKQeil9VPiACIQCX5SyoHxjeTq2dM6OvU9rrs6aiy4SuSgWIP1P80POIdgf6L1nnr5ObAB7Is6bbHQVaKKjsD8wI8Zr6rmFy/38VzqFJcs82jEOw+HIbCgmDnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFRRSNXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFRRSNXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D28AC4CEF1;
	Fri, 23 Jan 2026 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769180249;
	bh=r0kw9edHnS7R1ESg/5g5RXGIYX5Nrze7ea54bTHrVo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFRRSNXJq4ecdlZoxj4Jx4foa3gqTVLkXeJKmnozx1RpwDjAWCN0BY0yZEMNFMj/r
	 8j3psD9RIOzBAQGTZE9JAwUGEUZMNqxwOMKBNQkABpwOS7v/MWeydns8RIYZ+xLfWd
	 TxRG3/Y11Dk6WPY26v0QWwToJZqdRRKTXyl/lLUAwfKCUIKIpPNrfCz9JzRngzI4WM
	 IdqqfrsBreevdwvG1EtjPWPHUIhQarO222MFaasxA+oJZlSIA/w09COcQKhnHHMjc5
	 j9faomdBfpAoTki9US8w9BkKK1VP3CjfbdnVRTjvPtRvTI0Y2eWA3TXHHRGfUTJCkf
	 eecjngaxUPheA==
Date: Fri, 23 Jan 2026 15:57:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXOMVYowDxHBL8kg@ryzen>
References: <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
 <aXMytcJTIeBHatIF@ryzen>
 <t2hsk77mp3shacbehlqfnpjgc4az2phvo2cyjn5hkybqdmzrcj@hnuwporebhz2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t2hsk77mp3shacbehlqfnpjgc4az2phvo2cyjn5hkybqdmzrcj@hnuwporebhz2>

On Fri, Jan 23, 2026 at 11:08:39PM +0900, Koichiro Den wrote:
> > 
> > So if we wanted to, a good number would be to have at least a few BARs of size
> > 128k or larger (so there could be two submaps), since I assume that some other
> > DWC controllers might also have have 64k min alignment.
> 
> I'm not entirely sure whether it's really acceptable to bump the hard-coded
> sizes for BAR0/1/2/3 (512, 512, 1024, 16384) to 128k, in other words,
> whether there were any reasons behind choosing such small default numbers.
> Let's see. I agree that 128k or larger should suffice for DWC-based
> platforms (as you mentioned, testing with two submaps).

When the PCI endpoint subsystem was created, most SoC were arm32, and many
of them had a very small PCIe aperture, like a few megabytes in total.

So if you were running two boards based on the same SoC, one as host and
one as endpoint, and perhaps you even had a PCIe switch on the host board,
you really did not want to have larger BARs than needed because it would
not fit inside the small address space dedicated to PCIe.

Additionally, the PCI endpoint subsystem allocates backing memory for
these BARs, some of these systems might have a very small amount of RAM.

However, I think that:
static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };

512+512+1024+16384+131072+1048576 = 1 Mi + 146 Ki

Is still quite low...

When adding more and more features to the PCI endpoint subsystem,
these small BAR sizes will not be enough to evaluate new features.
E.g. for Resizable BARs, as per the PCIe specification, the minimum
possible size for a Resizable BAR is 1 MB.

I solved this by making sure that pci_epf_alloc_space() overrides
the requested size, to set it to 1MB, if BAR type is BAR_RESIZABLE:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=52132f3a63b33fd38ceef07392ed176db84d579f

If a few MB is too much for your host system, use a different host
system to test. (E.g. if you connect these arm32 boards to a PC,
and run pci_endpoint_test, larger BAR sizes would not be a problem,
assuming that the endpoint itself can allocate enough backing memory.)

So my suggestion is that we that we just bump the defaults...


I guess in worst case, if someone actually complains, I think a nice
solution would be do to like you are doing for vntb:
https://lore.kernel.org/linux-pci/20260118135440.1958279-34-den@valinux.co.jp/

i.e. pci-epf-test could have {barX_size} in configfs, one per BAR,
and then the user themselves could configure the BAR sizes that they
want to run pci-epf-test with, if the pci-epf-test default sizes are
not desirable, before starting the link. (Some tests like e.g. the
subrange mapping test should of course fail if there is not a single
BAR with BAR size larger than needed to test the feature.)

But if I were you, I would just bump the defaults, since the defaults
are currently overrided for BAR type FIXED_BAR and RESIZABLE_BAR anyway,
and just add the barX_size attributes in configfs if someone complains.


Kind regards,
Niklas
