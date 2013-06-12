Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:53563 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab3FLKds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2013 06:33:48 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so4235354bkc.20
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2013 03:33:47 -0700 (PDT)
Date: Wed, 12 Jun 2013 12:33:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] PCI: Add registry of MSI chips
Message-ID: <20130612103344.GD30841@mithrandir>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
In-Reply-To: <1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 06:41:22PM +0200, Thomas Petazzoni wrote:
[...]
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 4633529..a1a6084 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -61,6 +61,8 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
>  struct msi_chip {
>  	struct module *owner;
>  	struct device *dev;
> +	struct device_node *of_node;

Shouldn't we be reusing the dev.of_node field to look this information
up? On Tegra we do register the MSI chip and set the dev member to the
PCIe host bridge device. Can't the same thing be done for the Armada?

I assume that the MSI controller provider will be instantiated from the
device tree and hence there will already be a struct platform_device and
therefore also a struct device associated with it which should have the
of_node field set to the correct value automatically.

Thierry

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuE6IAAoJEN0jrNd/PrOhN/UP/1ZkXWQaJuYrT2so+QM1vhIM
hlvm8duYHHCQ90HxrMI3TJHzH+i8221cjnDI9LLHhyVttSnw0tu4A/KZmWxgjkln
ogRtRWaOw81h4F+agSWwcYcpj3yPhN5qS24MfROOxnHaOuFk2RlykWyUBqGWNcty
rqSXsEspyNIMmhOB0abEczF2PT7wJJzfiCCXgO22QueLIpcMsjVzNSXfGwAIS9nq
52JnohEuJ9TQHH8KJZJ/aolX9S5CnRrzBXTdUhHRNl1ewUdNhhq/FV7dTlbOew2d
FK2frZeo+j1Fpno3qh39twHym1DQsHC9dK25Sjsl9FQpL0fsjdMwG/F+feYfkTn6
6M6YUbCgeJ21Nm1KxMbcEeTw51QdVyHmuYyXyh4sVcNWiWW1KEdAJsLA96Rw/Jul
2mqWd6ufw64/JZCJ3yE0vOf0qmGsVvnqFAQEgP7jeDWjir+3UFIzphMUXnsd+GA8
/LK4+A2C8PBnZ4hraDjE+KUbrQ31ynkRV+AwnrgN7/dDdNtxYULbYtLwjkXyr5qd
nYtf5agftk6r8SHdnaUDx03R2u3i4s+LF4EtjW+rZNoc8GOQXDI5MivIgPnZiE6e
Lkt1GfI+VJzrFwFeOcSmhN4nuUr9si0l9mujhlNpJVK27gb/+WirhIDDrYZft36B
Gyb0ApjIbanpM66XRPWB
=DaeS
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
