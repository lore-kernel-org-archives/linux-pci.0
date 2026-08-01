Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D692C21FF;
	Sat,  1 Aug 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785597734; cv=none; b=TZaUQ0KRSj9VIj2WzI7brYTXY2GO3WIzNxuNUZElSxKv4d1soP5ZHtvm4EhGkJg9BKhCWczele0bM8cM8GS5F+DCCzJ4KZi8jTcFhVVi4RnWEHDFzZPL/en9ZBre+VO6rWTl06u9bVn8dXf8KYgFfshpSBio43VigROefuJ43a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785597734; c=relaxed/simple;
	bh=2Ur65veEjRIOMJCoFNG0wxu4vm/uX9mzrAOsEMEKFzo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iCARjz9JUZ8CmBFR7J0i7/fkYlnhG6DOiRVctDYGD2f280pnCNiXe9uNuj1H/aI3OUWRNPpQLkgru4FmU3nopUBsA60mqF/JELZhGTztp7gcfy1lBR4nRSOlSc7JYudo7tnPC26FzJ/ukl49FqqfemWr83RwtYIFEe9WkS0VP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8DB1992009C; Sat,  1 Aug 2026 17:14:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 86B4392009B;
	Sat,  1 Aug 2026 16:14:05 +0100 (BST)
Date: Sat, 1 Aug 2026 16:14:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Wild <andiwild@gmail.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Avoid link retraining on empty ports when lifting
 speed restriction
In-Reply-To: <20260801105441.6506-1-andiwild@gmail.com>
Message-ID: <alpine.DEB.2.21.2608011520280.14485@angie.orcam.me.uk>
References: <20260801105441.6506-1-andiwild@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 1 Aug 2026, Andreas Wild wrote:

> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
> failed link retraining") the Target Speed quirk lifts a firmware-imposed
> 2.5GT/s restriction on any downstream port, without checking whether the
> link is up.  Where nothing is plugged in, the retraining that follows can
> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
> quirk makes two of them -- the initial one and the restore on the error
> path -- adding a fixed 2 s to every boot.
> 
> On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
> slot, running v7.2-rc5:
> 
>  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
>  1.541 pci 0000:00:1c.0: retraining failed
>  2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400
> 
> The kerneldoc above the quirk already contemplates this case ("For a port
> that has been left unconnected both bits will be clear") and describes
> lifting the restriction where firmware arranged it "and the port reports
> its link already being up".  The code stopped checking the latter.

 I think we need to just bail out early in this case.  If a link has been 
already clamped at 2.5GT/s and no link has been established, then there's 
no point in going through the whole dance, just as already documented.  

 I.e. something like the change below.  It works for me and if it does for 
you too, then please feel free to use it as v3 with the change description 
updated accordingly.  Thank you for the report and the proposed fix.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/quirks.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

linux-pcie-failed-link-retrain-unclamp-always-fix.diff
Index: linux-macro/drivers/pci/quirks.c
===================================================================
--- linux-macro.orig/drivers/pci/quirks.c
+++ linux-macro/drivers/pci/quirks.c
@@ -108,7 +108,11 @@ int pcie_failed_link_retrain(struct pci_
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
-	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
+	if (lnksta & PCI_EXP_LNKSTA_DLLLA) {
+		;
+	} else if (PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2) == PCIE_SPEED_2_5GT) {
+		return ret;
+	} else if (pcie_lbms_seen(dev, lnksta)) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret)
