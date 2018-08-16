Return-Path: <SRS0=Fxrs=K7=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Fxrs=K7=intel.com=jonathan.derrick@kernel.org>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "poza@codeaurora.org" <poza@codeaurora.org>
CC: "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Busch, Keith"
	<keith.busch@intel.com>, "okaya@kernel.org" <okaya@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Date: Thu, 16 Aug 2018 15:45:07 +0000
Message-ID: <1534434305.17819.26.camel@intel.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
	 <f11c06374a90650e862cb68206ad2fdb@codeaurora.org>
In-Reply-To: <f11c06374a90650e862cb68206ad2fdb@codeaurora.org>
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-JDsYvsl1RnmrMSQ8kdiR"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--=-JDsYvsl1RnmrMSQ8kdiR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-08-16 at 14:57 +0530, poza@codeaurora.org wrote:
> On 2018-08-16 02:56, Jon Derrick wrote:
> > Some users may want to disable downstream port containment (DPC),
> > so
> > give them this option
> >=20
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/pci/pci.c      |  2 ++
> >  drivers/pci/pci.h      |  6 ++++++
> >  drivers/pci/pcie/dpc.c | 48=20
> > ++++++++++++++++++++++++++++++++++++++----------
> >  include/linux/pci.h    |  6 ++++++
> >  4 files changed, 52 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 80da484..4e629c2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6062,6 +6062,8 @@ static int __init pci_setup(char *str)
> >  				pcie_ats_disabled =3D true;
> >  			} else if (!strcmp(str, "noaer")) {
> >  				pci_no_aer();
> > +			} else if (!strcmp(str, "nodpc")) {
> > +				pci_no_dpc();
> >  			} else if (!strcmp(str, "earlydump")) {
> >  				pci_early_dump =3D true;
> >  			} else if (!strncmp(str, "realloc=3D", 8)) {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 6e0d152..f73f29e 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -536,4 +536,10 @@ static inline void
> > pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> >  static inline void pci_aer_clear_device_status(struct pci_dev
> > *dev) {=20
> > }
> >  #endif
> >=20
> > +#ifdef CONFIG_PCIE_DPC
> > +void pci_no_dpc(void);
> > +#else
> > +static inline void pci_no_dpc(void) { }
> > +#endif
> > +
> >  #endif /* DRIVERS_PCI_H */
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index f03279f..068fca0 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -44,6 +44,18 @@ struct dpc_dev {
> >  	"Memory Request Completion Timeout",		 /*
> > Bit Position 18 */
> >  };
> >=20
> > +static int pcie_dpc_disable;
> > +
> > +void pci_no_dpc(void)
> > +{
> > +	pcie_dpc_disable =3D 1;
> > +}
> > +
> > +bool pci_dpc_available(void)
> > +{
> > +	return !pcie_dpc_disable && pci_aer_available() &&
> > pci_msi_enabled();
>=20
> 1) why do you check pci_aer_available() ?
I'd assumed a dependency on aer, but looking at it again I see it calls
into err.c without a requirement on aer.

Then it also seems the pci_aer_available() and AER dependency check in
portdrv_core.c is unneccessary too.

> 2) and pci_aer_available() already internally checks
> pci_msi_enabled();
>=20
> > +}
> > +
> >  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
> >  {
> >  	unsigned long timeout =3D jiffies + HZ;
> > @@ -209,6 +221,17 @@ static irqreturn_t dpc_irq(int irq, void
> > *context)
> >  	return IRQ_HANDLED;
> >  }
> >=20
> > +static void dpc_disable(struct pci_dev *pdev)
> > +{
> > +	u16 cap_pos, ctl;
> > +
> > +	cap_pos =3D pci_find_ext_capability(pdev,
> > PCI_EXT_CAP_ID_DPC);
> > +	pci_read_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL,
> > &ctl);
> > +	ctl &=3D ~(PCI_EXP_DPC_CTL_EN_FATAL |
> > PCI_EXP_DPC_CTL_EN_NONFATAL |
> > +		 PCI_EXP_DPC_CTL_INT_EN);
> > +	pci_write_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL,
> > ctl);
> > +}
> > +
> >  #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
> >  static int dpc_probe(struct pcie_device *dev)
> >  {
> > @@ -221,9 +244,16 @@ static int dpc_probe(struct pcie_device *dev)
> >  	if (pcie_aer_get_firmware_first(pdev))
> >  		return -ENOTSUPP;
> >=20
> > +	if (!pci_dpc_available()) {
> > +		status =3D -ENOTSUPP;
> > +		goto disable_dpc;
> > +	}
> > +
> >  	dpc =3D devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> > -	if (!dpc)
> > -		return -ENOMEM;
> > +	if (!dpc) {
> > +		status =3D -ENOMEM;
> > +		goto disable_dpc;
> > +	}
> >=20
> >  	dpc->cap_pos =3D pci_find_ext_capability(pdev,
> > PCI_EXT_CAP_ID_DPC);
> >  	dpc->dev =3D dev;
> > @@ -235,7 +265,7 @@ static int dpc_probe(struct pcie_device *dev)
> >  	if (status) {
> >  		dev_warn(device, "request IRQ%d failed: %d\n",
> > dev->irq,
> >  			 status);
> > -		return status;
> > +		goto disable_dpc;
> >  	}
> >=20
> >  	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP,
> > &cap);
> > @@ -260,17 +290,15 @@ static int dpc_probe(struct pcie_device *dev)
> >  		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc-
> > >rp_log_size,
> >  		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
> >  	return status;
> > +
> > +disable_dpc:
> > +	dpc_disable(pdev);
> > +	return status;
> >  }
> >=20
> >  static void dpc_remove(struct pcie_device *dev)
> >  {
> > -	struct dpc_dev *dpc =3D get_service_data(dev);
> > -	struct pci_dev *pdev =3D dev->port;
> > -	u16 ctl;
> > -
> > -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
> > &ctl);
> > -	ctl &=3D ~(PCI_EXP_DPC_CTL_EN_FATAL |
> > PCI_EXP_DPC_CTL_INT_EN);
> > -	pci_write_config_word(pdev, dpc->cap_pos +
> > PCI_EXP_DPC_CTL, ctl);
> > +	dpc_disable(dev->port);
> >  }
> >=20
> >  static struct pcie_port_service_driver dpcdriver =3D {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 5454e6b..559b792 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1473,6 +1473,12 @@ static inline int pci_irqd_intx_xlate(struct
> > irq_domain *d,
> >  static inline bool pci_aer_available(void) { return false; }
> >  #endif
> >=20
> > +#ifdef CONFIG_PCIE_DPC
> > +bool pci_dpc_available(void);
> > +#else
> > +static inline bool pci_dpc_available(void) { return false; }
> > +#endif
> > +
> >  #ifdef CONFIG_PCIE_ECRC
> >  void pcie_set_ecrc_checking(struct pci_dev *dev);
> >  void pcie_ecrc_get_policy(char *str);
--=-JDsYvsl1RnmrMSQ8kdiR
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDgxNjE1NDUwNVowIwYJ
KoZIhvcNAQkEMRYEFBwJqnY6HkeNyvQ1oYxFjHHzCzylMA0GCSqGSIb3DQEBAQUABIIBAEH8NPbt
VpTAbbvg5u0MHtZ+GNUHRAmy1Ip7jtBPv+xnHhqcLr7x2QreIc7ali1NC5tdBhlQNcWAvwPnc7u1
FIM1L5rgPyjZMk6VEmk4rkb3jC+IwsZeRXprrJAwb+7tUwIwVXp57O5Iy0rZm8h0PkVyS69hUD/K
xU5LKPlrd31NHBGKjmBeLp1QXLvcANWU3EM+CpJfbYu8m131O0yMB570CrASpeCCZz8BiqVUGhBD
+F6KA22tyUXGegpxCZxx+chylN0QPBqsxIf6hoxDLTSN7Yp6/V51cznKMC0YN1WCMs4uch87aqO+
FL6W5yZRWABU9pW4ixcMtrhBEm2t0jAAAAAAAAA=


--=-JDsYvsl1RnmrMSQ8kdiR--
