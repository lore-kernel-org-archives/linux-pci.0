Return-Path: <SRS0=bkIg=LR=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=bkIg=LR=intel.com=jonathan.derrick@kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"okaya@kernel.org" <okaya@kernel.org>, "willy@infradead.org"
	<willy@infradead.org>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "hch@lst.de" <hch@lst.de>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"poza@codeaurora.org" <poza@codeaurora.org>, "Busch, Keith"
	<keith.busch@intel.com>
Subject: Re: [PATCH] PCI/AER: Fix an AER enabling/disabling race
Date: Mon, 3 Sep 2018 19:32:47 +0000
Message-ID: <1536003164.6725.6.camel@intel.com>
References: <1535850412-3085-1-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1535850412-3085-1-git-send-email-jonathan.derrick@intel.com>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-+GYEEi/LIYyJYpnBWCXf"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--=-+GYEEi/LIYyJYpnBWCXf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

After giving this a few days thought, I think the right way is to call
pci_enable_pcie_error_reporting after portdrv probe, and prevent AER's
pci_walk_bus from enabling err reporting if the port hasn't been
probed.

I'm going to Self-NAK this and follow-up

Sorry for the noise

On Sat, 2018-09-01 at 19:06 -0600, Jon Derrick wrote:
> There is a sequence with non-ACPI root ports where the AER driver can
> enable error reporting on the tree before port drivers have bound to
> ports on the tree. The port driver assumes the AER driver will set up
> error reporting afterwards, so instead add a check if error reporting
> was set up first.
>=20
> Example:
> [  343.790573] pcieport 10000:00:00.0:
> pci_disable_pcie_error_reporting
> [  343.809812] pcieport 10000:00:00.0:
> pci_enable_pcie_error_reporting
> [  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
> [  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
> [  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
> [  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
> [  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
> [  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
> [  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
> [  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
> [  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting
> [  343.918900] pcieport 10000:01:00.0:
> pci_disable_pcie_error_reporting
> [  343.968426] pcieport 10000:02:00.0:
> pci_disable_pcie_error_reporting
> [  344.028179] pcieport 10000:02:01.0:
> pci_disable_pcie_error_reporting
> [  344.091269] pcieport 10000:02:02.0:
> pci_disable_pcie_error_reporting
> [  344.156473] pcieport 10000:02:03.0:
> pci_disable_pcie_error_reporting
> [  344.238042] pcieport 10000:02:04.0:
> pci_disable_pcie_error_reporting
> [  344.321864] pcieport 10000:02:05.0:
> pci_disable_pcie_error_reporting
> [  344.411601] pcieport 10000:02:06.0:
> pci_disable_pcie_error_reporting
> [  344.505332] pcieport 10000:02:07.0:
> pci_disable_pcie_error_reporting
> [  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting
>=20
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/aer.c          | 1 +
>  drivers/pci/pcie/portdrv_core.c | 5 ++++-
>  include/linux/pci.h             | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83180ed..a4e36b6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1333,6 +1333,7 @@ static int set_device_error_reporting(struct
> pci_dev *dev, void *data)
>  	if (enable)
>  		pcie_set_ecrc_checking(dev);
> =20
> +	dev->aer_configured =3D 1;
>  	return 0;
>  }
> =20
> diff --git a/drivers/pci/pcie/portdrv_core.c
> b/drivers/pci/pcie/portdrv_core.c
> index 7c37d81..f5de554 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -224,8 +224,11 @@ static int get_port_device_capability(struct
> pci_dev *dev)
>  		/*
>  		 * Disable AER on this port in case it's been
> enabled by the
>  		 * BIOS (the AER service driver will enable it when
> necessary).
> +		 * Don't disable it if the AER service driver has
> already
> +		 * enabled it from the root port bus walking
>  		 */
> -		pci_disable_pcie_error_reporting(dev);
> +		if (!dev->aer_configured)
> +			pci_disable_pcie_error_reporting(dev);
>  	}
>  #endif
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8d..c071622 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -402,6 +402,7 @@ struct pci_dev {
>  	unsigned int	has_secondary_link:1;
>  	unsigned int	non_compliant_bars:1;	/* Broken
> BARs; ignore them */
>  	unsigned int	is_probed:1;		/* Device
> probing in progress */
> +	unsigned int	aer_configured:1;	/* AER
> configured for device */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has
> been called */
> =20
--=-+GYEEi/LIYyJYpnBWCXf
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKeTCCBOsw
ggPToAMCAQICEFLpAsoR6ESdlGU4L6MaMLswDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xMzAzMTkwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMHkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2Fu
dGEgQ2xhcmExGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRl
cm5hbCBCYXNpYyBJc3N1aW5nIENBIDRBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
4LDMgJ3YSVX6A9sE+jjH3b+F3Xa86z3LLKu/6WvjIdvUbxnoz2qnvl9UKQI3sE1zURQxrfgvtP0b
Pgt1uDwAfLc6H5eqnyi+7FrPsTGCR4gwDmq1WkTQgNDNXUgb71e9/6sfq+WfCDpi8ScaglyLCRp7
ph/V60cbitBvnZFelKCDBh332S6KG3bAdnNGB/vk86bwDlY6omDs6/RsfNwzQVwo/M3oPrux6y6z
yIoRulfkVENbM0/9RrzQOlyK4W5Vk4EEsfW2jlCV4W83QKqRccAKIUxw2q/HoHVPbbETrrLmE6RR
Z/+eWlkGWl+mtx42HOgOmX0BRdTRo9vH7yeBowIDAQABo4IBdzCCAXMwHwYDVR0jBBgwFoAUrb2Y
ejS0Jvf6xCZU7wO94CTLVBowHQYDVR0OBBYEFB5pKrTcKP5HGE4hCz+8rBEv8Jj1MA4GA1UdDwEB
/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMDYGA1UdJQQvMC0GCCsGAQUFBwMEBgorBgEEAYI3
CgMEBgorBgEEAYI3CgMMBgkrBgEEAYI3FQUwFwYDVR0gBBAwDjAMBgoqhkiG+E0BBQFpMEkGA1Ud
HwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwudHJ1c3QtcHJvdmlkZXIuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AudHJ1
c3QtcHJvdmlkZXIuY29tMDUGA1UdHgQuMCygKjALgQlpbnRlbC5jb20wG6AZBgorBgEEAYI3FAID
oAsMCWludGVsLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAKcLNo/2So1Jnoi8G7W5Q6FSPq1fmyKW3
sSDf1amvyHkjEgd25n7MKRHGEmRxxoziPKpcmbfXYU+J0g560nCo5gPF78Wd7ZmzcmCcm1UFFfIx
fw6QA19bRpTC8bMMaSSEl8y39Pgwa+HENmoPZsM63DdZ6ziDnPqcSbcfYs8qd/m5d22rpXq5IGVU
tX6LX7R/hSSw/3sfATnBLgiJtilVyY7OGGmYKCAS2I04itvSS1WtecXTt9OZDyNbl7LtObBrgMLh
ZkpJW+pOR9f3h5VG2S5uKkA7Th9NC9EoScdwQCAIw+UWKbSQ0Isj2UFL7fHKvmqWKVTL98sRzvI3
seNC4DCCBYYwggRuoAMCAQICEzMAAKye+0C3syvSXOcAAAAArJ4wDQYJKoZIhvcNAQEFBQAweTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMR
SW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vpbmcg
Q0EgNEEwHhcNMTcxMDE5MTcyNzI3WhcNMTgxMDE0MTcyNzI3WjBHMRowGAYDVQQDExFEZXJyaWNr
LCBKb25hdGhhbjEpMCcGCSqGSIb3DQEJARYaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20wggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCz4TvOwEKxVEgGst/n3LricX9KG2YbHHvorBFb
ggk/Wm7ZV9v/w5I5+M7SFD1CVS+MD24tlcL0mjddPXklsjPNmFb7TCXhppQMWqxwlS44iokDpHEF
wx6DtwcIlfmvgPormri3U5V0gkRvnmiFSlQ2bUycWgxttAvR4sYjxLas7hE3jZJ1LJ9IxiD7VMNJ
QWXSxxnOGZVf1tUTqC5uNv9wSvr8N7ZRYldP4nJ9JUFO7bazyoplxGlgxIR3+7I9TgbrUOziQCja
AG6qjTBc2iB2iz6IVnzrBtQT5DR3KM6EqbMTwur8keTC11xls7lwWexzsSgt37V9UNKAqfsZPgcX
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQUJRdznv8EeAa3g+3F5NKtNNctuBcwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA5LNb+VnWY0V21FlNjnQ2BIb5gmlED29zwQiC5yezn
2SexgvN31129iJSkXuiBHdcVJiUAUPHYuxPRwumwbrkY6m+sYi9kIzKt+ZKNNAN4WbnavsbyRBlb
cIn2E5swqD+sks8AmKivHmg+gFeboLaOf+EqVihIz1Wec1PpbX98R1t2ep7Y/81DD1fIjAWHl6Mq
TJwjKQuYB01kkJdXZAGPXUQSARR1y2D1YpCkDqfGH2STaB4nenD4INSyhTGo5RV9wwTAibyrIq50
rnmvBnHTmICQVdHuIhG1gGmDLUAGqfrU3W2QJr9gkICdrTMgIEdd8s73wknaZxZKqfRxnMVQMYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAKye+0C3syvSXOcAAAAArJ4wCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDkwMzE5MzI0NFowIwYJ
KoZIhvcNAQkEMRYEFDEp2p8rEhzl9vwXLHfbBMNondw9MA0GCSqGSIb3DQEBAQUABIIBAGBLtp9R
qRfaaLhi3MKjSv8X6O+xuNxTbNUAOtIOKII9Q0DfQ+bfRVIDuqc3v3oXkN5vpjxhWJXT9tbk05xz
G/JuzAmnaArb/+zw3pnuARjd7cPgkCDoF1iFAE9S6WfTAbmPqChkV5AoNcRpoSo/zB71I7d5oQZB
4V6V2oD+TI25I+KeVZHxn0nbHnC0d/2bcrmnO3SYNIPyr99UkysbExNyFgUSfzcsVfgyoFN2bLL9
ydo5QjKcl/zGZum5D8We9/V9z81PhD3XWzb7lQ7gF/NJLIxMIyt9nJpMHrZ3Lzz5xi6oxVAXWg9C
bZ8SV0Rrc6ApZQnhEc7fLX6MDWBcmQoAAAAAAAA=


--=-+GYEEi/LIYyJYpnBWCXf--
