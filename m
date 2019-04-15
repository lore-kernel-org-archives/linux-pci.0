Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE122C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605C20833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teud+hBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfDONwg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:52:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDONwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:52:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so20604101wmf.2;
        Mon, 15 Apr 2019 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ew3Izhz4Jj4Dxf5wqGJK6ZHHhKyU2GzilPPlYePs1EA=;
        b=Teud+hBHbjJOKJUueu8Vn2krtJNgW9F/AOICORE1PyyZgXYFsiFEgu4OFf7aSx4Y+R
         vUbD7i2PRnr1UrAIDooeY93Di2gfzOY6B6T6LZRCVgGD/lpOnA+jif4s0/Mz+nsbsyfv
         q//sAcUFxRNBFgG8faThgC4lL5c1LnKfO61E36R8wckyWL8NJ5+QeSf87BrOVsri4oFe
         nQb2H3bYaXBzFc4ynbct98stWfWFKSusZUMcwMQ/zHCdZbfQiedaywJkO1fCaQbpC34O
         KzkIj+cY9zfxyKrCu6izgJE1dsEYqZtAyIoVgZVhWe6Iz4xlSPYCav4m2WWzY3I4VPnc
         9w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ew3Izhz4Jj4Dxf5wqGJK6ZHHhKyU2GzilPPlYePs1EA=;
        b=Wj3vyDd53NHdNKdNgICKnN/A5+XbVmb1jOTrpO7BsS92DAD2a56Obkx1czF6tjma4d
         Cm2KO12O0lOB9Y2jw/jabufexxKgu3pyQsOfHMutfv9o4o+UpfKwa5O6taC1MWQpNGKi
         Uhl8K1pYsLYspKB+nAr/oIKf/9Kd2vrHLq/m4ACuc2MBiHNFiKQWQ9t5n23D3sprlklK
         LRJCvMEv9i/BHOFdscktUm3+d5yYYdk4uYlKw5F6FHu/9Ywqa3+nmOMx1UIqe79hIG+O
         7nc2WO4g3ySCoQFXo2q0JEpt+/A29AFj+Dgvk7UxOTtQVY6MrZTNAu+LJGmYcECAqaOT
         k5Yw==
X-Gm-Message-State: APjAAAVJgmlhM34fWm8PwNYV8XsnYf8cUzQ9rLuUyZAzkbUijOx8mvny
        5M/tPE1oRJwU/wmQNSYp9dE=
X-Google-Smtp-Source: APXvYqxpcK/uD35hoxeSzeN4g/p8Rv532bYyF4ZTCvWVjH30I6vwF0qfrYZnC9xZjAwBaD4i0aG2ww==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr22960505wmd.30.1555336353878;
        Mon, 15 Apr 2019 06:52:33 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id y17sm61244871wrh.60.2019.04.15.06.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:52:32 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:52:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190415135232.GX29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-23-mmaddireddy@nvidia.com>
 <20190411201535.GS256045@google.com>
 <e721e7f4-85c9-bee1-7131-12e0b7dfc0d1@nvidia.com>
 <20190412145003.GE141472@google.com>
 <1039fbf2-24ad-c31c-93d9-663aab74a26a@nvidia.com>
 <20190415134516.GW29254@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dZJOqldIUwtPuZvk"
Content-Disposition: inline
In-Reply-To: <20190415134516.GW29254@ulmo>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dZJOqldIUwtPuZvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 03:45:16PM +0200, Thierry Reding wrote:
> On Mon, Apr 15, 2019 at 05:06:10PM +0530, Manikanta Maddireddy wrote:
> >=20
> > On 12-Apr-19 8:20 PM, Bjorn Helgaas wrote:
> > > [+cc Jingoo, Gustavo (dwc maintainers), Ley (altera), Michal (xilinx)]
> > >
> > > On Fri, Apr 12, 2019 at 12:30:22PM +0530, Manikanta Maddireddy wrote:
> > >> On 12-Apr-19 1:45 AM, Bjorn Helgaas wrote:
> > >>> On Thu, Apr 11, 2019 at 10:33:47PM +0530, Manikanta Maddireddy wrot=
e:
> > >>>> Add PCIe link up check in config read and write callback functions
> > >>>> before accessing endpoint config registers.
> > >>>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned i=
nt devfn,
> > >>>>  				  int where, int size, u32 *value)
> > >>>>  {
> > >>>> +	struct tegra_pcie *pcie =3D bus->sysdata;
> > >>>> +	struct pci_dev *bridge;
> > >>>> +	struct tegra_pcie_port *port;
> > >>>> +
> > >>>>  	if (bus->number =3D=3D 0)
> > >>>>  		return pci_generic_config_read32(bus, devfn, where, size,
> > >>>>  						 value);
> > >>>> =20
> > >>>> +	bridge =3D pcie_find_root_port(bus->self);
> > >>>> +
> > >>>> +	list_for_each_entry(port, &pcie->ports, list)
> > >>>> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> > >>>> +			break;
> > >>>> +
> > >>>> +	/* If there is no link, then there is no device */
> > >>>> +	if (!tegra_pcie_link_status(port)) {
> > >>> This is racy and you should avoid it if possible.  The link could g=
o down
> > >>> between calling tegra_pcie_link_status() and issuing the config rea=
d/write.
> > >>>
> > >>> If your driver is to be reliable, it must be able to handle any bad
> > >>> consequence of issuing that config read/write anyway, so I think it=
's
> > >>> better if it doesn't even bother checking whether the link is up.
> > >> This change is made based on similar check present in dwc driver
> > >> dw_pcie_valid_device(), reasons for making this change in Tegra might
> > >> differ dwc.
> > > Yes, you won't be surprised to learn that I don't like the similar
> > > checks in dwc, altera, xilinx, and xilinx-nwl either :)  I raise this
> > > issue every time I see it, but I can't remember if I've mentioned dwc
> > > specifically.
> > >
> > > We need to either eradicate this pattern of checking for link up, or
> > > include a comment about why it is absolutely necessary.
> >=20
> > This patch is created to address below scenario in our downstream kerne=
l,
> > 1) Our platform has WiFi on one slot and GPU in another.
> > 2) During WiFi OFF, link is put in L2 and it goes through hot reset
> > when turning ON WiFi (since Tegra doesn't support hot-plug).
> > 3) Whenever x11 server is started it scans the PCIe bus for video devic=
es.
> > Here PCIe configuration registers of all devices are read to find out
> > all available video devices.
> > 4) If "x11 server" started with WiFi OFF, then we are seeing "response
> > decoding error"(Tegra AFI module specific error).
> >=20
> > Best solution we came up with is to have link up check in config access
> > callback functions.
>=20
> So we really need this to prevent a userspace access to PCI config space
> from triggering these errors? I'm not familiar with how PCI access from
> userspace works, but if modifying the accessors fixes this problem it
> sounds like userspace would end up calling these accessors. If so, it
> sounds more like we should fix this at the point where userspace calls
> these accessors. According to what you're saying this should never be an
> issue from kernel space, because as long as a driver needs access to its
> device, the PCI bus should be up.
>=20
> And if that wasn't the case, then we probably do want to see these AER
> errors to help diagnose the issue.
>=20
> So could we instead have some sort of host bridge operation that would
> expose the link status and use that as part of the userspace access to
> PCI configuration space?

Looks like maybe pci_user_read_config_*() would be a good place to check
for this? They're defined by the PCI_USER_READ_CONFIG() macro in
drivers/pci/access.c. Same for pci_user_write_config_*().

Thierry

--dZJOqldIUwtPuZvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0jJ8ACgkQ3SOs138+
s6G7eBAAjDJM4dQAL5aydC8f5CdCW9Mv6rV025T1pvSfxjaYcrQC2HpnvPRconjr
WfIQGbadIqw8XdV4jPCYj6eVX4JoeS90iNzlYoOZKyrUfU663IjbH+sFge0QPBjE
2Ub97UhLvY3VG7vyBNFTRNf1NmwqqN7gE7X1EQPDTAg0upNI6r5JsZPMz0TMf5Jr
CN9Jc6XmeMHVLzTzTMOri13F83UraDJo2i96O9kjQLTQcNgrSvZU+zDgOHfchW+p
dQm5imrd1CzirQ72aZG7yxRkY6jZLwWDtGvUYOaT/qLVoIzSDYjYWIm/roSCOmom
kiIcDFEXNQSkAXEOpRj7oPOaF/D/WH0RyjNbyddoogRA6Jgm4Iv+0f8pkdLxWt2s
3ypZhOScnIgUARFlz06Ma4mnWfCN9fYRS2f04L5uMu+wZvy1Rib1rvMEwJs1vi7x
CQj+RJBcaWRoF7fwruoDyTBsxrCDrvp0/awgGZ7ZddKlS0unxnHAd3pnZPFolZH6
Tov3OIx1t+b3iD4w96AACVkpZlprkGq9XyD9kLp/sY1qHcKYaELCbSGoPbOrgCwN
y7ir4gF1cunG96H/BJnBTwcQBl2pSFXvVuCp8jzV0xCNzwg3VT2jmLQx7jdWdeQo
+ORPsWGspbVj8pqyWpHT8YZeoEBpsz0pKZsNFIG+uD+WyxR9mQU=
=Szlj
-----END PGP SIGNATURE-----

--dZJOqldIUwtPuZvk--
