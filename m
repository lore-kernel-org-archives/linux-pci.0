Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1378286800.2048.1.camel@jtkirshe-mobl>
Subject: Re: [E1000-devel] [PATCH 5/7] ixgbe: use
 pcie_capability_read_word() to simplify code
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	"David S. Miller" <davem@davemloft.net>,
	e1000-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 04 Sep 2013 02:26:40 -0700
In-Reply-To: <1378193715-25328-5-git-send-email-wangyijing@huawei.com>
References: <1378193715-25328-1-git-send-email-wangyijing@huawei.com>
	 <1378193715-25328-5-git-send-email-wangyijing@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FzsLmdWGu8vfr7ZgN+tn"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-FzsLmdWGu8vfr7ZgN+tn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-09-03 at 15:35 +0800, Yijing Wang wrote:
> use pcie_capability_read_word() to simplify code.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: e1000-devel@lists.sourceforge.net
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

Thanks Yijing, I will add it to my queue.

--=-FzsLmdWGu8vfr7ZgN+tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAABCgAGBQJSJvzQAAoJEOVv75VaS+3OG8IP/iHrGRDmPGoofrbCkgAIj+uL
eCCvun9ymY0BSfGB9Uu9VNB+ryJAIk2H5apldYWeURyoVQxdJVlBJnPTqI3jN1Kw
/DzP+FRUyiRVD9NCW2cRB9ZVzKSlkqOZ/UKtpOwbAh0+rWT/k8T/cvfK1/EMibyh
71w05n1IlXJoDZqKi01M+w3JQJhK3yLwq/pcW4npwxXI864Mg21ExjQqxgd0ABVl
2UJ3LNQ297vfTco4bOXXLtS6Wdtl316iYFG3Ix3YdBK+q5ly4qtHX6UEp1YtaZlv
UMtlEIZu0TDiDzO1srxyroHFcEmB76OmZZnY30huVwx07zbOFP0JuzT4yyWGRIuk
+LBQWMhkJ2c5l74PmejzDfD/Ur4+1dFwi7qs++z2NZJE1IH6L1HZbdPHMm6yq5B8
ZNzV9nsaS0JO6XVJYdtzB/r0jfHhbTuYqYN83eFtW2n6qGYqyj/K+mm1LVJ+WjmS
HTsJxbElwVPbJbt8s7OUNt8EFNogezIiPGzqUAx6+CVHAidN5cxxsu7ueF6LLLNF
MgjlZrWL9a/1mi7pco5JMSLUaQm4Ej3vAm0u2W+hiSfWuNKG9K/9eHHkFqiL7747
A8xDvnxfpfZPKyK97miOeJAL+GXbndeVcjqdNAAc8AW0Q8OuBQcqYmsqyeqIHFWd
+s2B/j2TWlba8UnxQdRE
=YYqR
-----END PGP SIGNATURE-----

--=-FzsLmdWGu8vfr7ZgN+tn--

