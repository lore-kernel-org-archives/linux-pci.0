Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9553A7F48
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338925; cv=none; b=QX2Ua6gsAWOAeo6tsa+/ikRCs8hBpTQLUYaC5Ni/FPXBea6QO/MrF3at6Kg1wjeGnTioM9Z9eS/d9sRgYH5ctZ0FlKK2F5cHanN70XzwxRink5jPlgeAE6dkJYbyO2O9I4WH/qrmdn/3wsTCIsED2G/6SOe22J6O21iMFdFdG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338925; c=relaxed/simple;
	bh=XI5DiIWGv3ZHR4ELQt4TG1wvoKDdF3J5NDKnJ9BMuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx+bal8d+yF4/laV3nmFnO1waws7EOwvuGPhgR2roNvBXFE+ChLtsjiUnAUQijX1KCZD1iOy41ukWU8e9IYhxY5k0CwTt1JsoMzlKQX1Va4ya8jpfeskUjQhCgq5WAal56q0Km8pD3wpyjTRbwUidNYZUBqtafYAw4cKCCv0LpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6ADBF384;
	Thu, 16 Apr 2026 13:28:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 664AF6010CEA; Thu, 16 Apr 2026 13:28:33 +0200 (CEST)
Date: Thu, 16 Apr 2026 13:28:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bernd Schumacher <bernd@bschu.de>,
	"Alexandre N." <an.tech@mailo.com>,
	Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org,
	Uwe Kleine-Koenig <ukleinek@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Williamson <alex@shazbot.org>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource assignment
Message-ID: <aeDH4XNvwcX7RI0m@wunner.de>
References: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
 <fa331b71-133c-3773-3ec9-1aecc807fd9b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa331b71-133c-3773-3ec9-1aecc807fd9b@linux.intel.com>

On Thu, Apr 16, 2026 at 02:08:03PM +0300, Ilpo Järvinen wrote:
> On Wed, 15 Apr 2026, Lukas Wunner wrote:
> > Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
> > adapter plugged into an ASRock X570S PG Riptide board with BIOS version
> > P5.41 (09/07/2023):
[...]
> > Since a2f1e22390ac, config space is saved on enumeration, prior to BAR
> > correction.  Upon passthrough, the corrected BAR is overwritten with the
> > incorrect saved value by:
> 
> I'm wondering if there's something that makes this problem specific to 
> only standard BARs?
> 
> Can other resources, namely IOV resources or bridge windows, similarly be 
> updated "too late" and not get correctly updated into the saved config 
> space?

IOV registers are not saved, they're reconstructed from pci_dev->resource[]:

pci_restore_iov_state()
  sriov_restore_state()
    pci_update_resource()
      pci_iov_update_resource()

Bridge windows are saved when portdrv probes (see call to pci_save_state()
in pcie_portdrv_probe()) and that happens after the fs_initcall() because
portdrv is registered from a device_initcall().  So those should be fine
as well.

(FWIW sashiko also flagged the bridge windows not getting saved as an
(alleged) problem.)

Thanks for taking a look!

Lukas
