Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504F385D6E
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299248; cv=none; b=B8Ux9mphUTCHau9kCivYST+zcaEH6/tTBSF+u2+6Qw2jPg3IYvTCov13IHmLG7A8cLa4Pm+H51JzTj8b684aunyLsidyr0/Wh+lH3G2CoY+vseKUkqi+tpbn65BmG8byajV6Yxdf0KECskHG1wtinQ8xUNv6Kpk2x6Hzhu9ec34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299248; c=relaxed/simple;
	bh=bsvnCUzHmtPAQvzXZfKyuJapqwi6rj1thyCpPf1C5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBS7qjqhibXGk+HxHBkN9tBF4qQQa8/d+5k17+dy3fgrB+3o9ss9kredSuXeQ6PL05xH/ZDe0sRlzAwX5S6nlsQ2IXSmgQVSODumvOVAf3OtFX4Bi70aSL2X+5fHJk5T9RZKTJfGtL5NpKEsbDm1YmA+0BoAN+eqCOoCWV/Te4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 78462C17;
	Mon, 01 Jun 2026 09:34:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 558986029989; Mon,  1 Jun 2026 09:34:03 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:34:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Filippe Duke <fduke@greennet.ua>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"superm1@kernel.org" <superm1@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Message-ID: <ah016_TukXkcqnyQ@wunner.de>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
 <ahyerEqlBdIbQN9u@wunner.de>
 <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>

On Sun, May 31, 2026 at 09:22:52PM +0000, Filippe Duke wrote:
> A working LTS kernel version tells completely different story.

Right:

 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
[...]
-       Interrupts: pin B disabled, MSI(X) routed to IRQ 34
+       Interrupts: pin B disabled, MSI(X) routed to IRQ 28
[...]
-               Address: 0000000000000000  Data: 0000
+               Address: 00000000fee00000  Data: 0022

That's the only difference.  Seems plausible that it causes
communication failure with the HDA controller.

The offending commit causes current_state to be PCI_D0 instead of
PCI_UNKNOWN at boot time enumeration and this results in different
code paths being taken.

I note that current_state is queried in three places in
drivers/pci/msi/msi.c, so I'd start by instrumenting them with
printk()'s to see why the behavior is different.

E.g. __pci_write_msi_msg() bails out if current_state is not PCI_D0.
Perhaps it used to do that on a working kernel and now it doesn't.

Thanks,

Lukas
