Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511793;
	b=rb9hcJoMdjqv4HnnzE7rUey4E+4lphl87Msw0k5ftzfLdyl9DVcfAyQqwKID0zRmNGdK
	 TSYG4EDmCiceyLRSVyvI3u7TLIISGEZVDmy//DYswuAVCtIE799fMzsLqZli/cc69rZvd
	 15e4l4Z/4XkpZVWnzsAlziHksiUYQoRhy8Ls82nA5PPuI6za17OK/+531eVf5ZByKsVNL
	 35fEOAEUC25hc16QQhbAgIVcs4DzrCcYFUh2eyugktms1tQspHbN8aAFB/VjKoRO4p2rh
	 t4XLqkHXjKJVbErOV1300BbSXukhHnifNLpy4CiC+1GrmJraWD4pZhgvFV3bMRe1Q2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511793;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I7wcj/Cb8lrFemDaD8hCF2wn3DRCv4F6PB0oNVJ1yWQ=;
	b=WQl4R0uxNVDByKwFPFQmmCZdJCchHf1B+DjjFKEY/zbH6X2iL0IlSTxBfOH8DgJRyS1c
	 v0rR9r8EFvGP5BEEHnL4jDzIrEkpNMr4Wxdz79kTJUHqXUFKq3TmF91Yd4fekwVWtB/mt
	 7zHaHB2J4jxyUVK4hV7OD4GJ6shuJNrgXdZFEHKIW1B84BD5IzSjIHqIfOGJmHz0a8/Gd
	 wRdDqkquWf4JywS3PD7fm/N9N5ciHotMdIQ5ue2790bhOz+YC+fNi38gI7M+TPAJ/iptq
	 twrJaxKr7A09tFkq8vIF2tGw22lnx9U169P8vsWbTvPkqE1o8V5WK2C716BjKbI7Jwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0C606A31E;
	Tue, 24 Nov 2026 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB0C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 7B757367;
	Tue, 24 Nov 2026 10:16:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A932606F538; Tue, 24 Nov 2026 10:16:31 +0100 (CET)
Date: Tue, 24 Nov 2026 10:16:31 +0100
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
Message-ID: <awVV71IbFuYAJDzh@wunner.de>
References: <av7BRHcVkXOGT6yp@wunner.de>
 <20261120181841.GA893187@bhelgaas>
 <awVTHwYMP753-iSu@wunner.de>
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
In-Reply-To: <awVTHwYMP753-iSu@wunner.de>

On Tue, Nov 24, 2026 at 10:04:31AM +0100, Lukas Wunner wrote:
> On Fri, Nov 20, 2026 at 12:18:41PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 19, 2026 at 10:28:36AM +0100, Lukas Wunner wrote:
> > > https://lore.kernel.org/r/cover.1794997749.git.lukas@wunner.de
[...]
> One more thing:  sashiko flagged two valid issues in patch [7/7] of my
> above-linked-series (which is now the top-most commit on pci/aer).
> I've provided a fixup patch for both findings at the bottom of my reply
> to sashiko:
> 
> https://lore.kernel.org/r/av4j5j9-In1uWC8T@wunner.de/
> 
> Could you fold this into the commit?  Alternatively, I'd be happy to
> submit these as two separate patches if that is preferred, with a
> proper commit message to explain each change.

Actually... come to think of it, you had this question about whether
ratelimiting knobs should be exposed at all if there is no AER-capable
Root Port or RCEC.  I think this could be implemented simply by not
allocating aer_info in pci_aer_init() and jumping directly to the
"enable" label.  (Because I think we still want to continue enabling
Error Messages in case the user or the platform sets the System Error
bits in the Root Control register.)

That would implicitly hide all statistics and ratelimiting files
and may be a cleaner approach to overcome sashiko's objection that
Root Port statistics are exposed on AER-incapable Root Ports with
patch [7/7] of my series.  It would also save a little bit of memory
if we don't unnecessarily allocate aer_info.

Do you agree?  If so I can prepare a patch.

Thanks,

Lukas
