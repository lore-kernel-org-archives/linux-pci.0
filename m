Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605990;
	b=pkhw1tfxTGHNo92sfWC1fFkNc2h0xcD5aa0dBxlFVzmhcAagrpHhZBl8SnWzGzhOGIuJ
	 3wvyoFe9fdCVE71zhViXhKVDWl+b6+O4DFT5rsKY9dkmHRptEv15r9vZW0q45stRxS6kd
	 5s9eHdeFdcYjF0sJ3moHV6O6ldEYNBtGQF6gdu8hhLI9ErFtNMnNvjgjl8cxQ2/fwSfsz
	 IABp3vx5Hx/SQ2NfoJiXFxl26KTy9y18ZST9npYv+rOvWcuDaIClIKswKIDtkDVoOa7cp
	 SmmJhIAEwy6rPfdvtS5yzYM594tmF+MkKcq1p1Tf779ky++5qOcPuTH5dARhHX3GILA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605990;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jxYvFTkR1u5coP3khuKBvPA6Z4v5CBxl+iU250jhMGA=;
	b=OgUq7H33VvbUmp3yk4osFQIyGK7D/rArEJIEoBTDL3aMT8GybQyV7gduE/LaX6rdutr8
	 zdrmpGRQvuNBeSXmz0mv7cp6OcDchr0yKRlBEBk9fJypr9cO38iOU6XvXZibiKSWQncl0
	 YW3d8a7YtrT9gFRwpQE4X7rLGrWS4kmvN0ctvBIng1zY/T6aGWe3mNJbyJ6ZtXD88Vhvu
	 Y5MZJkFRkl0hSYyEQOzLCcNjK6kWVVwMSLdabWeygVzjja6FgJ2ZTuPVGfeqTTSyGWPFW
	 dvD9WcXIhPgk+28QnBJgfvssRr6Yz1Sh27pNLLq8SRY9X9KwsOPNTOQF3LFGC6x9yiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F0606A338;
	Wed, 25 Nov 2026 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1F0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id E281110DD1;
	Wed, 25 Nov 2026 12:26:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D84C86017F4B; Wed, 25 Nov 2026 12:26:20 +0100 (CET)
Date: Wed, 25 Nov 2026 12:26:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <awbF3MrVWm98q95O@wunner.de>
References: <awVV71IbFuYAJDzh@wunner.de>
 <20261125000838.GA1194450@bhelgaas>
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
In-Reply-To: <20261125000838.GA1194450@bhelgaas>

On Tue, Nov 24, 2026 at 06:08:38PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 24, 2026 at 10:16:31AM +0100, Lukas Wunner wrote:
> > Actually... come to think of it, you had this question about whether
> > ratelimiting knobs should be exposed at all if there is no AER-capable
> > Root Port or RCEC.  I think this could be implemented simply by not
> > allocating aer_info in pci_aer_init() and jumping directly to the
> > "enable" label.  (Because I think we still want to continue enabling
> > Error Messages in case the user or the platform sets the System Error
> > bits in the Root Control register.)
> > 
> > That would implicitly hide all statistics and ratelimiting files
> > and may be a cleaner approach to overcome sashiko's objection that
> > Root Port statistics are exposed on AER-incapable Root Ports with
> > patch [7/7] of my series.  It would also save a little bit of memory
> > if we don't unnecessarily allocate aer_info.
> > 
> > Do you agree?  If so I can prepare a patch.
> 
> I folded in the fix above for now, but will be happy to replace with
> the approach you propose.

Hm, I thought about this some more and realized that at least on x86,
the kernel may receive PCI System Errors through pci_serr_error() in
arch/86/kernel/nmi.c.

A quick web search finds numerous recent reports of messages such as:

  NMI: PCI system error (SERR) for reason a0 on CPU 0.
  Dazed and confused, but trying to continue

It would be possible to add plumbing such that pci_serr_error()
funnels such errors to the AER driver, which would search for the
error-reporting device and emit more useful messages.  The NMI
message causes a lot of head-scratching among users.

With such plumbing added, the ratelimiting knobs and statistics in sysfs
would actually be useful despite lack of an AER-capable Root Port or RCEC,
which suggests that hiding them may be the wrong thing to do.  So maybe
we should leave it as it is for now?

The "reason" in the NMI message is sometimes a1 or b1 in reports found on
the web.  It's unclear to me if the "reason" and "CPU" provide a clue
where the error-reporting device is located.

Support for this type of NMI was added in 2011 by commit 1c7b74d46fed
("x86, NMI: Add NMI symbol constants and rename memory parity to
PCI SERR").

Thanks,

Lukas
