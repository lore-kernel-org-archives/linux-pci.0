Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 23 Jun 2017 23:01:04 +0100
From: James Hogan <james.hogan@imgtec.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
References: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, dalias@libc.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, sparclinux@vger.kernel.org,
 gxt@mprc.pku.edu.cn, ysato@users.sourceforge.jp, linux@armlinux.org.uk,
 hch@infradead.org, geert@linux-m68k.org, linux-pci@vger.kernel.org,
 mattst88@gmail.com, linux-snps-arc@lists.infradead.org, cmetcalf@mellanox.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru,
 viro@zeniv.linux.org.uk, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, rth@twiddle.net, vgupta@synopsys.com,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, linux-alpha@vger.kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net
Content-Type: multipart/mixed; boundary="===============2327877893190484629=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

--===============2327877893190484629==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline

--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c1a35f15838..86872246951c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -96,6 +96,7 @@ config ARM
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> +	select PCI_GENERIC_SETUP
>  	# Above selects are sorted alphabetically; please add new ones
>  	# according to that.  Thanks.

This comment seems to suggest PCI_GENERIC_SETUP should be added a few
lines up to preserve the alphabetical sorting.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b2024db225a9..6c684d8c8816 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -115,6 +115,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select PCI_GENERIC_SETUP

Here too.

> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 4583c0320059..6679af85a882 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -33,6 +33,7 @@ config TILE
>  	select USER_STACKTRACE_SUPPORT
>  	select USE_PMC if PERF_EVENTS
>  	select VIRT_TO_BUS
> +	select PCI_GENERIC_SETUP

and here

Otherwise
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllNj58ACgkQbAtpk944
dnqhdg//SJAI7UamQnmPRbqhd0gYMgcMzrRPh0vqsiV9afGNrHMYVzth2hX+OeJ9
edYIVIlz0ky02rwtw0eW17nxowjc6kDgFJjMDCwXZkhtOUKaCZ8iZ2hzs9tDm0a9
iY1/8aSk71HagWfO0GX0zAPERIGzXsdTb+UL/+KCO9vAd5xYKeAcof7U55cs8M/O
YA8AeyTGBVZTzsgFZAb/1Pd63z7oMq99RNyBHMP4fGB0qIiXbL8vpWEN2cXOmZP+
ERBA+AqvywLTp8PM1CZGQNgJzPmYHrRycWg0JWpsTc+ZejIniBTsVR+AWMn7Oef+
yz5qJso9DGjVKcK/5U0xZ4Lmm51mvrvsGj9lM8PPZTnMJnHPPDrL+R5NyL3/jhpO
bd+E3hNT2sZxwiWxGaeuY2w/Hejx/basnBXvVH82TceRIKnbOPpuS+kym2UEoCQ8
uRGqvNs04Mq5eqOlZIMaFsPuLS+QLEL6iWA1yid1hozNkqX4+T36nx/7qHmk0cgB
mrqu+BraxA8nQJaTTMCxgiYOKT4cCNV64EqUVn4OhEenCkSxdIK+0wY+mC9L158r
NA8CAsgLdX/MCkNJrpAcbhJWrnELFK4eRXr3qSj3hKVt1pSuwdgt9ZU9ZV4gNY8j
UKx0brQlyfUFAZQLqGqceX7fipZ/xFyJ7cF5ztcLNDMvffqQBm0=
=0daY
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--


--===============2327877893190484629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2327877893190484629==--
