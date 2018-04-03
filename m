Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbeDCTS0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Apr 2018 15:18:26 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
        "Daly, Dan" <dan.daly@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        kvm-devel <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "netanel@amazon.com" <netanel@amazon.com>,
        Don Dutile <ddutile@redhat.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
 unmanaged SR-IOV on virtio_pci devices
Date: Tue, 3 Apr 2018 19:18:23 +0000
Message-ID: <0927465E-0B56-4903-9F5E-288A7D9C46E6@intel.com>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
 <20180315184132.3102.90947.stgit@localhost.localdomain>
 <20180316183042-mutt-send-email-mst@kernel.org>
 <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com>
 <20180403161151-mutt-send-email-mst@kernel.org>
 <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com>
 <20180403212503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180403212503-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C63078D8-EFD9-47F7-B81E-F2320701BA1F";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_C63078D8-EFD9-47F7-B81E-F2320701BA1F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On Apr 3, 2018, at 11:27 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> I'm not sure why you would need a feature bit. The capability is
>> controlled via PCI configuration space. If it is present the device
>> has the capability. If it is not then it does not.
>>
>> Basically if the PCI configuration space is not present then the sysfs
>> entries will not be spawned and nothing will attempt to use this
>> function.
>>
>> - ALex
>
> It's about compability with older guests which ignore the
> capability.
>
> The feature is thus helpful so host knows whether guest supports VFs.

This is not about a guest creating its own VFs. This is about a host PF  
that happens to have a virtio interface to be able to create virtio VFs  
that can be assigned to guests. Nothing changes at all from a guest  
perspective. Or maybe I am not understanding what you mean by "whether  
guest supports VFs".

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_C63078D8-EFD9-47F7-B81E-F2320701BA1F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlrD034ACgkQPA7/547j
7m5NWBAAwS8hSMcLsTqh7qp59nFGFZgOM91t49d2Hh4eZI2XOtGG/4uKk7oiQx6/
S6p8c3FnA2IFPKSc3HpGk4lha6JL45LE6emSeYmGoyOTaUR+u48HrB65IIPbLjJA
8B8X+do+vtLyp31t61UH1BcO6oYwgRnAIojrKFjM7ga8fnbn0YprCDuGxIeDF/QY
iXZ373KYf8rbPDIDt9I9USntO6Id47/usTVeTAiyn6Fvjp0AxWm0/JRdOZvoNn2D
ZEpugdAm3oPG59IZSk9zQzh61VxAL7qOIsGBON60tYQZsHpJKLmsiwwksW3hhmCB
cE6bcSKmHA5KkA230UtHVizVnja7zJ4TC5luJmctQ1uNzxUL5kMqDuGpCxpGaBml
7JlF6mhyTGuz3ZgkOkUaH+flpU2AXJ91kxAw1yB9cjZQ17S7ZHO0ke5/lyhzBV1Y
oz+02LIpgN6KkSuKWS8M1jSDzWpTt7XXJII5ZdcOn8DYrguW2541vltoZlTh1B71
rCZgT1RfUjktaEaUlGJ7yZ6f4hPtI5cAdfLXw7BHOZNZgkJNxjCKO3Vvi/HRiyQJ
KdE4pmd4cwOey0NKwcDR3wdYG1/dKrlQCGzb2siaOiCrdIK46FHA3Ubg8PmA1qNk
3xdRPPTgy3c8iGGWFnUyOTgLPMgPavz+fsZmtQrzBg4L3QV/CS4=
=0tdq
-----END PGP SIGNATURE-----

--Apple-Mail=_C63078D8-EFD9-47F7-B81E-F2320701BA1F--
