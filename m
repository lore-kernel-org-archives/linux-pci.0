Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32074 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752980AbeE3RLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:11:51 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
CC: "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 17:11:37 +0000
Message-ID: <5063D90B-7955-4F1E-85A2-D8AFD661ACB7@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
 <20180530192010-mutt-send-email-mst@kernel.org>
 <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
 <1527699273.29907.2.camel@intel.com>
In-Reply-To: <1527699273.29907.2.camel@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_79A5F5B5-3E24-4259-A6B1-321A0585332D";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_79A5F5B5-3E24-4259-A6B1-321A0585332D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On May 30, 2018, at 9:54 AM, Duyck, Alexander H  
<alexander.h.duyck@intel.com> wrote:

> On Wed, 2018-05-30 at 09:44 -0700, Rustad, Mark D wrote:
>> On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>>>> +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int
>>>> num_vfs)
>>>> +{
>>>> +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>>>> +	struct virtio_device *vdev = &vp_dev->vdev;
>>>> +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
>>>> +
>>>> +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>>>> +		return -EBUSY;
>>>> +
>>>> +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>>>> +		return -EINVAL;
>>>> +
>>>> +	sriov_configure = pci_sriov_configure_simple;
>>>> +	if (sriov_configure == NULL)
>>>> +		return -ENOENT;
>>>
>>> BTW what is all this trickery in aid of?
>>
>> When SR-IOV support is not compiled into the kernel,
>> pci_sriov_configure_simple is #defined as NULL. This allows it to compile
>> in that case, even though there is utterly no way for it to be called in
>> that case. It is an alternative to #ifs in the code.
>
> Why even have the call though? I would wrap all of this in an #ifdef
> and strip it out since you couldn't support SR-IOV if it isn't present
> in the kernel anyway.

I am inclined to agree. In this case, the presence of #ifdefs I think would  
be clearer. As written, someone will want to get rid of the pointer only to  
create a build problem when SR-IOV is not configured.

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_79A5F5B5-3E24-4259-A6B1-321A0585332D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlsO20gACgkQPA7/547j
7m6sgA//aFVQG9ccnLqmx0UcGSLODSICO8nOjKH5F9TnF3JLAawh9D23rjyqdZvC
MwKssNOkMklZO9i5/2oYs4OaA2Y/prT1ocHZjL5q7gmU8kZIDSJZkbwb83M2p4ov
Cq7EHKmoBJssyHPiRG92KCRBpx2df9eIHW0X+FeoWvjTIVcLg2B7D+4hE+u7HsFJ
xMDsOCDYUAEI1RK8+IhaLpwFxjUsQGTW152Kg6vY+92JCVcm1U50bywJeyX81i7s
eJMOmDFDuwtZbKe59IYQuEHZVTWf/2A4Pgx1tddfzNdpGIhB8+1UQjSBakOqpE2Q
b/8CgGNP6MO+qsoy1RX/y/0Gnhr5zKSffDRt0neTmZ77FHltFoZSlshMPEfSpRGH
4SM/HO77OPq29gFVq2Hd5v2h4SAELExSuwIyyU2nFkyPFIR0F3UxZ5lccdAQSuzt
/6zaame34yhQdeQuD457GKinAQX+c6sEPaztYN/jVqtPkv3TiJOPS5sMaWtb4Rwk
PT8EkC/BtIyO1gsLcrNwrzZAQKmkq7OajiD8dtwboGN0uPTKm7/eTB3A/UdKB+XL
BU5wg8Hw6uL/dsjFvkqBZYml88bDPKqz2TjnqS/MI6oJdPsZI68IlHaSvQHK1HPU
hnnBQfDp878SQrSsA+mWe+eHc/YIj87DM/A/eVBLfTor5pnUcJM=
=oOs9
-----END PGP SIGNATURE-----

--Apple-Mail=_79A5F5B5-3E24-4259-A6B1-321A0585332D--
