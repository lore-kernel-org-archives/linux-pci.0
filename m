Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE94370D69;
	Wed, 12 Aug 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558844; cv=none; b=hJjYhUIGjJjl0fChzERZRt0qP778Wg18u8d3ablJ2eO61LRzY1s9ize484itwyRYosRS444tD6RyTmFNrm4xgihUmI1lKFLV7BDDl8+dT6zW43u+lXl4MgKrKMqHeTxM56PzzGzSQLssQWaY02RfujX9yqtHRm9/ISvYZac/ZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558844; c=relaxed/simple;
	bh=NSfg6Es/6m6iLqnRp76emDxyN3fVksrfzoWZ77Gu3tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTwPY2H8W8gmTcX0u/2eS6U3B9q2b5y2IFq+gsCJ/BafCJ6tIiFYD0wveudVRK5Se/YwlXw4oxhh638K2zJijTc2zpWVAy0i08SAoRHw3Ctc5rws3idMUnJrK5SzhNMjNx4pjAN8ghpvA9TxivEmT2eB0v6YUlr/pmuh3MLfjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 7329B1A07;
	Wed, 12 Aug 2026 20:20:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5D309606F45E; Wed, 12 Aug 2026 20:20:34 +0200 (CEST)
Date: Wed, 12 Aug 2026 20:20:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <any5ciFCjh-0cGkB@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
 <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de>
 <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
 <anqw0M6cQLEA0J6d@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anqw0M6cQLEA0J6d@wunner.de>

On Tue, Aug 11, 2026 at 07:19:12AM +0200, Lukas Wunner wrote:
> On Mon, Aug 10, 2026 at 01:57:58PM -0700, Derek John Clark wrote:
> > I suppose that is true, but in that case we still wouldn't be able to
> > use it as the root fs since it gets removed/re-added during a suspend.
> > Would the quirk I submitted not have this compromise?
> 
> Okay I wasn't sure that using the MMC card as root filesystem
> is even possible on this product.  If that's a potential use case,
> it needs a separate fix.  I'll come up with a proposal for that one
> as well.

Here's my proposal for allowing root on an MMC card.

Both this and the other patch I just sent (or something like it)
need to be submitted upstream.  The other one is necessary so others
don't see a lockup when disconnecting e.g. a Thunderbolt-attached
card reader during system sleep.

But either one of the patches should make the issue go away on the
MSI Claw, so each patch needs to be tested by itself, without applying
the other one as well.  Thanks!

-- >8 --

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..9da7ae0b2437 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -1080,4 +1080,20 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
+
+/*
+ * MSI Claw A8 firmware initializes the onboard Realtek RTS525A cardreader
+ * with an MSI-specific Subsystem Vendor and Device ID on boot, but neglects
+ * to re-initialize it on resume.  Avoid hot-removal of the cardreader due to
+ * the spurious ID change.
+ */
+static void quirk_msi_claw_cardreader(struct pci_dev *pdev)
+{
+	if (pdev->subsystem_vendor == 0x1462 &&
+	    pdev->subsystem_device == 0x14af) {
+		pdev->subsystem_vendor = pdev->vendor;
+		pdev->subsystem_device = pdev->device;
+	}
+}
+DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_msi_claw_cardreader);
 #endif /* CONFIG_SUSPEND */
