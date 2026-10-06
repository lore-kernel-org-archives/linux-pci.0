Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89833D1CD7;
	Tue,  6 Oct 2026 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322115; cv=none; b=ojfrpRCSk/b4WmvoGguSBZSJFoHenzH5drx5dOd9GrpvaE7Dfg/H6jS/Mi5yr9igkVQ+GAjNeQrDwq0m2qtvtsvsVS7LlbufsNHIYk7EFuSrqsrflkEIguIcLA+LzmuoF6K+zxDMBkH83qqMsbe37JDwAkSOMlOLIIqtBqLyx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322115; c=relaxed/simple;
	bh=172AY1LtbJ9WzIpzs71jiNNlhd1CxbpWXlAYp+Gs8ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh4una6+yMGsWuX9n749nr31IQPqFrriMH/rRI7Qm92zSEtFq9qLYeLTRiWoFnlEAoNjtWqsHIG9iHai5AVXBkNSQgK/jjhSJGPsEy12FvyRZzM0EXjKTu4Km3QcOi4GxcZW7gcOyCkxC9u+zd3lGEPrgWOKTevF2kd6yaWAzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 05AA710606;
	Tue, 06 Oct 2026 23:19:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CEC7960F5533; Tue,  6 Oct 2026 23:19:10 +0200 (CEST)
Date: Tue, 6 Oct 2026 23:19:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Perlow, Jason" <jperlow@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Aditya Garg <aditya.garg@linux.dev>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
Message-ID: <asVlzjaUFAoowH-r@wunner.de>
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
 <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>

On Tue, Oct 06, 2026 at 12:37:18PM -0400, Alex Deucher wrote:
> On Mon, Oct 5, 2026 at 7:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Alex reported something similar at
> > https://bugzilla.kernel.org/show_bug.cgi?id=222095.
> 
> Lukas' patches fixes some boards, but unfortunately, I'm still seeing
> failures on others.  Reverting the patch fixes those failures.  I've
> updated the ticket.

I've added an analysis of the dmesg output as well as a patch.
It looks like the BIOS is raising a false alarm in that it signals
a Fatal Error even though the Uncorrectable Error Status register is
blank.  The patch causes such events to be reported, but otherwise
ignored (i.e. no recovery is attempted for a false alarm).

Newly enabled functionality like Advisory Non-Fatal Errors causes
BIOS code paths to be exercised which likely haven't been tested
by firmware validation folks, hence the fallout.  However I believe
ultimately we *want* to see those errors being reported because they
may point to BIOS issues which flew under the radar so far.

Thanks,

Lukas
