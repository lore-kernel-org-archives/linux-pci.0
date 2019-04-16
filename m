Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BCC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C186F20821
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRBsCqup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfDPLfJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:35:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 07:35:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so24919475wmk.4;
        Tue, 16 Apr 2019 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=raMA2QOZce1hEiyeoi+STr0TMZxyjhoAD2yJUetP0L8=;
        b=JRBsCqup8GoIfz9m1gam8qYCbtBLO+ycKZoM08+9q2l6ydumf1V127aGcB1jkk/HSL
         AmxbGB7rIdjPTRNrBP4kJjEv7/uwiCPJcLmD8185Me+C3b8agggvcD6lcyVUJtUbaLaq
         Bcyyfv/pih1rvoXmuwodKo4pSMNRl50xMJmKQDSBNNTzxVz+4SRM0lMg1Jg4C0pD7F+Z
         QuqUjiogBjp0GPRncwQ9zHmYdKrj/FLwGc65vSTwtyr+BUz/aHO6kSbFl9lxu1BPsToQ
         HCFW+H0UEXgyqeZ/aJcBeQprUW9m/7B1bfjlWUlK238BwbUymC8PojKwK3Lt1P2ZgzWC
         b9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=raMA2QOZce1hEiyeoi+STr0TMZxyjhoAD2yJUetP0L8=;
        b=a9PiSAeaZVUxoj8NBwP//SuI4pRNml6K9nPXbWociOz7OW5YyyfBFX15ISly57gtjT
         jOt/obmEt9UowJan5qkQ+GNwsGVMZqy9jJ1MS7ni4XUSuRkpHvBjnlI5iRrWJK/GxZN1
         o5u3RWcvL5aOioAunMUKWOk9QNUtWnsILGDotE20LboLqMTLfLLBUBb6fGtMj2pOsMMi
         FE8nFFifZqoNnZigCP+6oJyNsvtj9E71ZQ14W56EnL1wTUtLl+DGE36satOk60X9/pEq
         flz5L85v0MDeXOIrKtYEKzS6384eZNkRtuL5sqwrkOgBzPHWhGpYArsE2Ss45vLX/cab
         cyMA==
X-Gm-Message-State: APjAAAVqqt/nXF51labGcbhyLA9o3sU6yWLIPRIuav5Hl9gLgANZ42Tp
        TJyRUUrfR/m3Roy+E1099kA=
X-Google-Smtp-Source: APXvYqzxyvpj7RQW6U7tjMq18et31cBIuMI1l9tlMI8pBAlvKA9wmcujZjm2FPXVZuPIxiRkNlGcxw==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr26830057wma.71.1555414506104;
        Tue, 16 Apr 2019 04:35:06 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id r6sm45774264wrt.38.2019.04.16.04.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 04:35:05 -0700 (PDT)
Date:   Tue, 16 Apr 2019 13:35:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Message-ID: <20190416113504.GG10907@ulmo>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
 <20190415134813.GA111421@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <20190415134813.GA111421@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 08:48:13AM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
> > This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm and
> > arm64 NVIDIA devices such as Tegra
> >=20
> > This fixes the following output:
> > "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
> > as experienced on a Trimslice device with PCI host bridge enabled
> >=20
> > v3: exclude the quirk for arm and arm64 instead of only for x86
> >=20
> > v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_leaf
> >=20
> > Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> > Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/quirks.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index a59ad09ce911..1ac65f09d7ee 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct pci_=
dev *dev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_cap_qu=
irk_all);
> >  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht=
_cap_quirk_all);
> > =20
> > -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
> > +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev *de=
v)
> >  {
> >  	return __nv_msi_ht_cap_quirk(dev, 0);
> >  }
> > +/* HyperTransport is not relevant on theses arches */
> > +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
>=20
> I don't see any of the previous versions or discussion on the list, so
> I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
> like this because they're checking for arch at the wrong level.
>=20
> If you're seeing that warning message, apparently your system contains
> an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
> HyperTransport is at least in the picture, even on arm/arm64.
>=20
> The quirk assumes a host bridge at 00:00.0, which is really a
> device-specific assumption, or maybe something specific to
> HyperTransport.  It's certainly not required by the PCI specs, which
> don't require a host bridge to be visible as a PCI device at all.
>=20
> I'd be tempted to just change that pci_warn() to a pci_info() or maybe
> even remove it altogether.  It would be nice to have the complete
> "lspci -vv" and dmesg log archived for future reference, since this
> quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
> and ugly history already.

I've been thinking about this a bit and it seems to me like the
intention of the quirk is to make sure that all devices have their HT
MSI mapping capabilities disabled if the system doesn't support HT.
As you said, the fact that a host bridge may not be present isn't an
error, however, it also means that we have to assume that HT is not
supported in such cases and make sure the HT MSI mapping capability gets
disabled for all devices.

The following patch tries to address this and gets rid of the warning on
Tegra systems.

Thoughts?

Thierry
--- >8 ---
=46rom 69fb3b269cc852964385436694d79765d5c1cab3 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Tue, 16 Apr 2019 13:27:53 +0200
Subject: [PATCH] PCI: Be less noisy if no HT host bridge exists

Embedded systems will typically not expose a host bridge's configuration
space, so such setups must be assumed not to support HyperTransport, and
consequently the HT MSI mapping capability should be disabled for all
devices.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/quirks.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f9cd4d432e05..705891c88073 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2792,24 +2792,28 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *d=
ev, int all)
 	 */
 	host_bridge =3D pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
 						  PCI_DEVFN(0, 0));
-	if (host_bridge =3D=3D NULL) {
-		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
-		return;
-	}
-
-	pos =3D pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
-	if (pos !=3D 0) {
-		/* Host bridge is to HT */
-		if (found =3D=3D 1) {
-			/* it is not enabled, try to enable it */
-			if (all)
-				ht_enable_msi_mapping(dev);
-			else
-				nv_ht_enable_msi_mapping(dev);
+	if (host_bridge) {
+		pos =3D pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
+		if (pos !=3D 0) {
+			/* Host bridge is to HT */
+			if (found =3D=3D 1) {
+				/* it is not enabled, try to enable it */
+				if (all)
+					ht_enable_msi_mapping(dev);
+				else
+					nv_ht_enable_msi_mapping(dev);
+			}
+			goto out;
 		}
-		goto out;
 	}
=20
+	/*
+	 * Some systems, such as embedded devices, may not expose the host
+	 * bridge's configuration space. Assume such systems to not support
+	 * HyperTransport and disable the HT MSI mapping capability for all
+	 * devices.
+	 */
+
 	/* HT MSI is not enabled */
 	if (found =3D=3D 1)
 		goto out;
--=20
2.21.0


--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly1vegACgkQ3SOs138+
s6ERRhAAlO7UkxmQD3r8/vys/K0f1j7iuZGqMZgs/ZoGdeIpXIilXtSjq7nZ0CoP
b4d1/dkg3GYHcFz3oIVhk0DrJ8tgcigdwYkMw29aLt7gaHyMU8Tk7vh1TBvCLSRr
NPP9R7TGxu3YPwBKAulW7bbho+z4H7Uw7SCWkhUbd/QV+4LG3QDGtbcZ0WhlpkBx
Lc20nS1r9eFtQApm8olorPXRm9myYvLxD89U/OMtbs+Nb6fFl6ECTUH8sMcVkA1p
uLY43iM0IpxpIfsM6Fdga2z+frr+mp62B4kLEhTMPrwT+0GQWrhDJT44omi6l4dm
UnfTLG2lz4r+tPV85A8GVzrtQlW4avfcBVreBgi7yuCXabFn3LfTWMyrUpjXDani
WQNVIoKrWNQi3wKNhSU7U9CcQjZ91EFaO4zH9k26w6PL/O4RsJrCG62McOEjp7aD
ms4lzJ+rW9PnHgE26a1Lu9quYA1minrB6i6t6QY3Ns8qaPntvq2nPmOBP5TA9yA2
FhDXLeqoqlzxzh63IZ5fzK8LIgUWGZAsybvz3ioOV7Z2e73pjfT8ycyLQKRkB8ZK
/mh1fQeJTRg4GpS8MsfhdWLQnpIUw0JVnTeQhmssYw7+MAnorboQW/iiA+bXgiwX
C6rDzH4fTpkfLi4ZryzfQjlidghBZiXHdX3On27pLd38GEHn7I4=
=0+6X
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
