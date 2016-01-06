Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Jan 2016 09:35:01 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: rcar: Add runtime PM support to pcie-rcar
Message-ID: <20160106083500.GB1525@katana>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-4-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <1451998831-27705-4-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +err_pm_put:
> +	pm_runtime_put(pcie->dev);
> +
> +err_pm_disable:
> +	pm_runtime_disable(pcie->dev);

What about put/disable in the remove part?


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNG0AAoJEBQN5MwUoCm2uAcP/39wqME9jZZXyomPfL5dcUec
W48LrlvV8jgjVSAFFAychVGSZZOnKWEaNHuoTbD6DhcA3Z/hwxRQP8Y9do8mHy0p
Fo9vucPVNCCs1bhdMzBuq1z541YUkMsziadauT72daWXBscyh0zbryWm1QCYI7/c
txlUeyHM1mXwB2sFiM46m4DMl4CHlDHjKj1pgvZunlaJKgwS7aod5rCO+eEPg/08
jVRq3JqNKcn5bO8Ff1eHef7iBryiF0oI1Q0XYuuKt9u9uqW2vNsQNkLiNkwcKcpB
ZjxZzH6XYEfCZi3GlGTIz11bGKYUOy3Ib0NID5XrlqsIWXf1NTq910N4ZgVyS9SY
A9EuoCsOkf3L9XHyjRwz7WWhRXpQtG5ZRHFySwLoC6czx95vVh8swda5z+KqkDve
5nYU31Gknjqp5LOeu1qLGBqlsv0O7Q3v0l6ENB4Fe2JGMfi6Rksy33RrPB1LpyR8
DvfvxL8KM9R+e4aeGjrrBXCYrStxvbnpNaASuVo22OkJow3fGawVK6l6MTuThRoa
SILvay4yB0U9/AEujxiO0gKzo01gsmeXk32QF02M77qKQ6YGUh/1z/Y69Pu1SCcE
+UwB+d2P2jHWFW5nJAf8Ywxhh02hO9pCAmp9Z5wlsFQkyhu0vgQQ7gK871hbkt1T
ikzcYDDwmiyJ20Ow/8qm
=yYzp
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
