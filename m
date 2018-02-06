Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:49948 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeBFSKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Feb 2018 13:10:24 -0500
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Bauer, Scott" <scott.bauer@intel.com>
Subject: Re: [PATCH] vmd: Interrupt affinity pairing to child devices
Date: Tue, 6 Feb 2018 18:10:19 +0000
Message-ID: <1517940617.2496.8.camel@intel.com>
References: <20180201222305.25066-1-keith.busch@intel.com>
In-Reply-To: <20180201222305.25066-1-keith.busch@intel.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-hNj0glRYOL1IGtdbcx06"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-hNj0glRYOL1IGtdbcx06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keith, Bjorn,

This looks good.

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

On Thu, 2018-02-01 at 15:23 -0700, Keith Busch wrote:
> Performance for devices in VMD domains suffer in NUMA environments if
> we're not respecting the desired IRQ CPU affinity. This patch fixes
> that by creating managed affinity irq vectors for the VMD device, and
> then drivers registering their chained interrupts will be assigned
> the
> h/w irq that most closely matches its desired IRQ affinity. A tie is
> awarded to the lesser used vector.
>=20
> Note, this only works for drivers that allocate their vectors with
> PCI_IRQ_AFFINITY. All other drivers will be assigned the least used
> vector without consideration for affinity.
>=20
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/host/vmd.c | 80
> ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 930a8fa08bd6..ac84676e79a4 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -166,10 +166,6 @@ static irq_hw_number_t vmd_get_hwirq(struct
> msi_domain_info *info,
>  	return 0;
>  }
> =20
> -/*
> - * XXX: We can be even smarter selecting the best IRQ once we solve
> the
> - * affinity problem.
> - */
>  static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct
> msi_desc *desc)
>  {
>  	int i, best =3D 1;
> @@ -188,24 +184,61 @@ static struct vmd_irq_list *vmd_next_irq(struct
> vmd_dev *vmd, struct msi_desc *d
>  	return &vmd->irqs[best];
>  }
> =20
> +static struct vmd_irq_list *vmd_next_affinity_irq(struct vmd_dev
> *vmd,  const struct cpumask *dest)
> +{
> +	struct vmd_irq_list *irq =3D NULL;
> +	const struct cpumask *vmd_mask;
> +	unsigned long flags, match;
> +	int i, best =3D 0;
> +
> +	if (!dest || vmd->msix_count < 2)
> +		return NULL;
> +
> +	raw_spin_lock_irqsave(&list_lock, flags);
> +	for (i =3D 1; i < vmd->msix_count; i++) {
> +		struct cpumask tmp;
> +
> +		vmd_mask =3D pci_irq_get_affinity(vmd->dev, i);
> +		cpumask_and(&tmp, vmd_mask, dest);
> +		match =3D cpumask_weight(&tmp);
> +		if (match >=3D best) {
> +			if (match =3D=3D best && irq &&
> +			    (vmd->irqs[i].count >=3D irq->count))
> +				continue;
> +			irq =3D &vmd->irqs[i];
> +			best =3D match;
> +		}
> +	}
> +	if (irq)
> +		irq->count++;
> +	raw_spin_unlock_irqrestore(&list_lock, flags);
> +
> +	return irq;
> +}
> +
>  static int vmd_msi_init(struct irq_domain *domain, struct
> msi_domain_info *info,
>  			unsigned int virq, irq_hw_number_t hwirq,
>  			msi_alloc_info_t *arg)
>  {
> -	struct msi_desc *desc =3D arg->desc;
> -	struct vmd_dev *vmd =3D
> vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
> +	struct msi_desc *msidesc =3D arg->desc;
> +	struct vmd_dev *vmd =3D
> vmd_from_bus(msi_desc_to_pci_dev(msidesc)->bus);
>  	struct vmd_irq *vmdirq =3D kzalloc(sizeof(*vmdirq),
> GFP_KERNEL);
> -	unsigned int index, vector;
> +	struct irq_desc *desc =3D irq_to_desc(virq);
> +	unsigned int vector;
> =20
>  	if (!vmdirq)
>  		return -ENOMEM;
> =20
>  	INIT_LIST_HEAD(&vmdirq->node);
> -	vmdirq->irq =3D vmd_next_irq(vmd, desc);
> -	vmdirq->virq =3D virq;
> -	index =3D index_from_irqs(vmd, vmdirq->irq);
> -	vector =3D pci_irq_vector(vmd->dev, index);
> =20
> +	if (desc && irqd_affinity_is_managed(&desc->irq_data))
> +		vmdirq->irq =3D vmd_next_affinity_irq(vmd,
> +					desc-
> >irq_common_data.affinity);
> +	if (vmdirq->irq =3D=3D NULL)
> +		vmdirq->irq =3D vmd_next_irq(vmd, msidesc);
> +
> +	vmdirq->virq =3D virq;
> +	vector =3D pci_irq_vector(vmd->dev, index_from_irqs(vmd,
> vmdirq->irq));
>  	irq_domain_set_info(domain, virq, vector, info->chip,
> vmdirq,
>  			    handle_untracked_irq, vmd, NULL);
>  	return 0;
> @@ -233,9 +266,11 @@ static int vmd_msi_prepare(struct irq_domain
> *domain, struct device *dev,
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct vmd_dev *vmd =3D vmd_from_bus(pdev->bus);
> =20
> -	if (nvec > vmd->msix_count)
> +	if (nvec > vmd->msix_count) {
> +		if (vmd->msix_count > 1)
> +			return vmd->msix_count - 1;
>  		return vmd->msix_count;
> -
> +	}
>  	memset(arg, 0, sizeof(*arg));
>  	return 0;
>  }
> @@ -663,6 +698,14 @@ static int vmd_probe(struct pci_dev *dev, const
> struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int i, err;
> =20
> +	/*
> +	 * The first vector is reserved for special use, so start
> affinity at
> +	 * the second vector.
> +	 */
> +	struct irq_affinity affd =3D {
> +		.pre_vectors =3D 1,
> +	};
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
> =20
> @@ -688,8 +731,15 @@ static int vmd_probe(struct pci_dev *dev, const
> struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
> =20
> -	vmd->msix_count =3D pci_alloc_irq_vectors(dev, 1, vmd-
> >msix_count,
> -					PCI_IRQ_MSIX);
> +	/*
> +	 * Reserve remaining vectors that IRQ affinity won't be able
> to assign.
> +	 */
> +	if ((vmd->msix_count - 1) >
> cpumask_weight(cpu_present_mask))
> +		affd.post_vectors =3D vmd->msix_count -
> +					cpumask_weight(cpu_present_m
> ask) - 1;
> +
> +	vmd->msix_count =3D pci_alloc_irq_vectors_affinity(dev, 1,
> vmd->msix_count,
> +					PCI_IRQ_MSIX |
> PCI_IRQ_AFFINITY, &affd);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
> =20
--=-hNj0glRYOL1IGtdbcx06
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIwNjE4MTAxN1owIwYJ
KoZIhvcNAQkEMRYEFKeLB/Tv5Q3FFPec2VBLkPe/LT/GMA0GCSqGSIb3DQEBAQUABIIBAFYuI6r/
dbCPq3S4JLKrkyOgusqm1U593xRGsNehF9ClcddqWt2Ajm3q+AeVxdqPelO183F2F3UXORbg3gYS
S8ltzQ8MC82A7JVRIMgJ8/lB1NvmXbcmHkRqvOMqbqZkJMNEk7OdfVY/TM2E1PH7icrbM80TdmgI
qGKLBgGTD/La1X3BYFMn593KWH2aiaLMENvwZR2UcjZCz8aaEZqKm2cJUopmN/uT69L6spjz9q2e
2pnF0lTDQHDreYvb3xj4AaApuRlqu0L2kGBgSDaSw+ZVOXuZJr9ifrzKTGIUy2DJce/vvrSEUSX6
0sN/3yLVC+m3bdpZMQ5SVEhWS7S4hkcAAAAAAAA=


--=-hNj0glRYOL1IGtdbcx06--
