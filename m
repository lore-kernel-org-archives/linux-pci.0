Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36449 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3G2M6b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 08:58:31 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so1568392bkg.36
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2013 05:58:30 -0700 (PDT)
Date: Mon, 29 Jul 2013 14:58:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130729125826.GH23152@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E41F7A.4010502@gmail.com>
 <20130728043310.6CF1D3E08FE@localhost>
 <20130728162711.32a9a21e@skate>
 <20130729065431.GA1115@manwe>
 <20130729142600.63eeab50@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
In-Reply-To: <20130729142600.63eeab50@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 02:26:00PM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Mon, 29 Jul 2013 08:54:31 +0200, Thierry Reding wrote:
>=20
> > > So what is your suggestion to allow the PCIe controller to retrieve t=
he
> > > correct irq_domain if we have only one DT node for the IRQ controller
> > > that registers two irq_domains ?
> >=20
> > If I understand correctly, Grant isn't objecting to the introduction of
> > the lookup function, but rather its implementation. You could add a
> > pointer to a struct msi_chip within struct irq_domain and then iterate
> > over all irq_domain instances (see irq_find_host()) and find one which
> > has the correct device_node pointer and the msi_chip pointer set.
>=20
> Ah ok. The only trick is that we have to change irq_find_host() to
> *not* match on MSI domains. Can you check the below patch to see if it
> matches what Grant suggested? It works for me, and it allows to completely
> remove the registry of msi_chip in drivers/of, as well as the of_node
> pointer in struct msi_chip.
>=20
> Thanks!
>=20
> Thomas
>=20
> From c2c0137cb110270f96e1e0fa298a5d585b8d829e Mon Sep 17 00:00:00 2001
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date: Mon, 29 Jul 2013 14:12:31 +0200
> Subject: [PATCHv6 05/11] irqdomain: add support to associate an irq_domain
>  with a msi_chip
>=20
> Message Signaled Interrupts are a PCI-specific mechanism that allows
> PCI devices to notify interrupts to the CPU using in-band
> messages. The PCI subsystem represents an MSI-capable interrupt
> controller as an msi_chip structure, and this patch improves the
> irqdomain subsystem with a new pointer associating an irq_domain with
> the corresponding msi_chip.
>=20
> The __irq_domain_add() function is augmented with an additional
> argument, the 'msi_chip' pointer, and all callers of this function are
> updated.
>=20
> A new function irq_domain_add_msi() function is added to allow the
> registration of an MSI-type irq domain.
>=20
> The irq_find_host() function is modified to not match on MSI-type irq
> domains: a given DT device node may represent both a normal interrupt
> controller and a MSI interrupt controller. irq_find_host() should
> return the irq_domain that corresponds to the normal interupt

"interupt" -> "interrupt"

> controller.
>=20
> An irq_find_msi() function is added to get the MSI_type irq domain

"MSI_type" -> "MSI-type".

> given a DT device node.

And "irq domain" -> "IRQ domain" in all of the above.

> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
[...]
> @@ -162,7 +167,16 @@ static inline struct irq_domain *irq_domain_add_tree=
(struct device_node *of_node
>  					 const struct irq_domain_ops *ops,
>  					 void *host_data)
>  {
> -	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
> +	return __irq_domain_add(of_node, 0, ~0, 0, ops, NULL, host_data);
> +}
> +static inline struct irq_domain *irq_domain_add_msi(struct device_node *=
of_node,
> +						    unsigned int size,
> +						    const struct irq_domain_ops *ops,
> +						    struct msi_chip *msi_chip,
> +						    void *host_data)
> +{
> +	return __irq_domain_add(of_node, size, size, 0, ops,
> +				msi_chip, host_data);
>  }

Given that the majority of interrupt controllers probably don't have any
MSI functionality, I wonder if perhaps this should be done in a more
helper-oriented way, see below...

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
[...]
> @@ -198,6 +201,12 @@ struct irq_domain *irq_find_host(struct device_node =
*node)
>  	 */
>  	mutex_lock(&irq_domain_mutex);
>  	list_for_each_entry(h, &irq_domain_list, link) {
> +		/*
> +		 * We only want to match normal interrupt domains, not
> +		 * MSI domains
> +		 */
> +		if (h->msi_chip)
> +			continue;
>  		if (h->ops->match)
>  			rc =3D h->ops->match(h, node);
>  		else
> @@ -214,6 +223,28 @@ struct irq_domain *irq_find_host(struct device_node =
*node)
>  EXPORT_SYMBOL_GPL(irq_find_host);
> =20
>  /**
> + * irq_find_msi() - Locates a MSI domain for a given device node
> + * @node: device-tree node of the interrupt controller
> + */
> +struct irq_domain *irq_find_msi(struct device_node *node)
> +{
> +	struct irq_domain *h, *found =3D NULL;
> +
> +	mutex_lock(&irq_domain_mutex);
> +	list_for_each_entry(h, &irq_domain_list, link) {
> +		if (!h->msi_chip)
> +			continue;
> +		if (h->of_node && h->of_node =3D=3D node) {
> +			found =3D h;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&irq_domain_mutex);
> +	return found;
> +}
> +EXPORT_SYMBOL_GPL(irq_find_msi);

This doesn't quite copy what irq_find_host() does, since it ignores the
associated ops->match().

But given that ops->match() already provides a way to hook into the
lookup, perhaps we could add a function such as this:

	int irq_domain_supports_msi(struct irq_domain *d, struct device_node *node)
	{
		if ((d->of_node =3D=3D NULL) || (d->of_node !=3D node))
			return 0;

		return d->msi_chip !=3D NULL;
	}

Then use that in drivers that expose MSI functionality via an IRQ domain
like this:

	static const struct irq_domain_ops foo_irq_domain_ops =3D {
		...
		.match =3D irq_domain_supports_msi,
		...
	};

One problem with this is that it doesn't solve your problem where two
different IRQ domains are exposed by the same device, because the
irq_find_host() will still match the MSI IRQ domain for the non-MSI
device node as well. This could be solved by adding another match
function...

This goes in hand with the helper-style API that I mentioned above. But
it's really up to Grant to decide which way he wants this to go.

Thierry

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9mbyAAoJEN0jrNd/PrOhbcgQAK07VGL10C2JeXFhhKfMHl4q
lXp0uZgeUF66rFtiYg2odBxnJIt63W+FUMkhj6gS8KKA7yXXT/3rGIRXhTECt0Fm
qqFhUtOMNPXZIO5yhu869P+s6I+MFjTPLRtfPjwbueJQtWc5wSa2SoslMlauUuN6
mRm+D16l0EdQxmrHQvqVM3IlshdxXZo2SL96bOjBiEqCxCzxC/yl9ESb9upLPZKj
r/Z+uPkv4i+xNdri6n4RBViJ3JgOaLDxi2pLzjxqeUqBxXi7wJkSCTare4nghJ5m
KE2OdEf/4VwVYNL15ueJ1cajGTNM7mh5m2LFhLdbSdDmMMoLQ3mk3aJXjdG3zuCV
HHXnypmu2T/jcDyh9juzAwazUWs1P2E3Klne1Hrx6wwjkF4WhaCx/EvKOFrD4kXi
h6wNz3ZjyV4G8jzyzRrxFTbHKOQv7oGoM+rJvNYQDiM6WvWflwIjbxPdk22fLUce
VlLyVnEgFTqJ1qa0oOG/zJahTlRh3Z1dJ6fOn3QSZNnDCw3pVimk+eX5PsGUMe0+
M7820gS8PPIZg2DAwAlYeMgEdDIR4iSjQmQBYEd27kZrgyfaJQsZ4YTUjCmnTb8T
DTZdnFLkGSaMLXWhWy6EH00TAS+R7luT2UqKnSrU1il7Hm9Gicej2XuKrEYOK8g4
M2jRFKBhn0gaQt3X8mBW
=Dsul
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
