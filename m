Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35603 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbdLNP6M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:58:12 -0500
Date: Thu, 14 Dec 2017 16:58:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 09/12] PCI: tegra: Enable PCIe xclk clock clamping
Message-ID: <20171214155809.GJ13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-10-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
In-Reply-To: <1509371843-22931-10-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2017 at 07:27:20PM +0530, Manikanta Maddireddy wrote:
> This patch enables PCIe xlck clock clamping by pad control. Pad control

xlck -> xclk

Thierry

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyn44ACgkQ3SOs138+
s6EF3RAAm0zX7IRAw2ZpZZ9woITqnB/vnPKy7THPjX9Whj24HVjVjcSpnLs7JGsf
AzoM6LR0/p6Neo0D/ydEA+hxtOHSkWV9ZuQjRNLqkaQk20kcQb7dEyRC1MngkZv3
zPROYBJOVvda0v8shLF39VrushaNF5PfcvRWS7JNdwlgQSXv6Hi+++dq5PqE4W/V
b4B3jdhZgIgkvMmbz2TzBo082YJMF9BtyFhUYoBfLCfmLFKkFyeEqvWv5v7lasz3
Wy2Og3wNkEIqVLiKk02HxWKcrwZCUMepgUJ/ngYdloOOnkwaPhyJfL9gY6UKNRti
ZCpci7mQyL1Yftzw6MdA3+QwOP9cqBYzxduQvQIBqTARzF1MW86fg0oA5smDTHYi
2eyLdFUyMzMX8u2IB+eKeIC0fMWvXZoB1FUi2RI0UPzQD09XLXlHRmasR5gIRheQ
AFG5hB5huU3NPC2rAniRNdwNXdd3C/0t1NJL9tpvqrKe9r5n2hds15l6XgYnAGMg
x9OD+rluZaOoCsCG9bFkxkAolu/Meeh9YDIL8Y6rf//7uQF5+WWjTtz7l5XVys6Y
Pgi4Ciqhe9eq7uOIPdbS8hErAKddiPQCEl4PYYdQJlNt7vgz550l6NUIefddnDye
dM9dYr7LRhjmsrVz/8zP8OZ+12EWwFXAy53bjnwRqn98C4VyZlw=
=dJlA
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--
