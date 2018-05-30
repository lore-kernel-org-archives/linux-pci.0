Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:39721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbeE3QDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:03:39 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: "Bie, Tiwei" <tiwei.bie@intel.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:03:37 +0000
Message-ID: <D7004E41-C23D-48B7-94A4-ACBBA06B021D@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
In-Reply-To: <20180530085521.26583-1-tiwei.bie@intel.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BAEA8DCF-7D8D-46E0-BF67-24CFA346618A";
        protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_BAEA8DCF-7D8D-46E0-BF67-24CFA346618A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On May 30, 2018, at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:

> There is a new feature bit allocated in virtio spec to
> support SR-IOV (Single Root I/O Virtualization):
>
> https://github.com/oasis-tcs/virtio-spec/issues/11
>
> This patch enables the support for this feature bit in
> virtio driver.
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> This patch depends on below proposal:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html
>
> This patch depends on below patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8effc395c2097e258fcedfc02ed4a66d45fb4238
>
>  drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
>  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
>  include/uapi/linux/virtio_config.h |  7 ++++++-
>  3 files changed, 40 insertions(+), 1 deletion(-)
>

<snip>

> diff --git a/include/uapi/linux/virtio_config.h  
> b/include/uapi/linux/virtio_config.h
> index 308e2096291f..b7c1f4e7d59e 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -49,7 +49,7 @@

There is a value in the comment directly before this that should
be updated as well to be consistent with the new value for
VIRTIO_TRANSPORT_F_END below.

>   * transport being used (eg. virtio_ring), the rest are per-device feature
>   * bits. */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		34
> +#define VIRTIO_TRANSPORT_F_END		38
>
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've

<snip>

--
Mark Rustad, Networking Division, Intel Corporation

--Apple-Mail=_BAEA8DCF-7D8D-46E0-BF67-24CFA346618A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlsOy1gACgkQPA7/547j
7m76ZA//Y2LUMKR3vk+daXgmttHCcE/LQRNdsp+Ik27ahXsyWiUT77IJ2RPB0Mze
J5LThGz0VlmeUFJ5vc1l3RutQoF4DTOo8j1V9U5TD+FG9K9jimJAjf2KQBOZngBx
ui5BctfAfRkk3hHN35p9B5E8XuOOYGzfwUGFrqCse0tsz+v11s+NwZvtylt9vnDH
9wDK37Ot2gl/ufee/dRj6cRZXpbO3D4+7heiAx+UfqNGvCDwDII6xhslJAJNGAxt
TtGgR5sWc6dm7Z02sMQS5IXonrBtZSOkk6Th6P0sAxkc/OiiWTNZjyvP39TM9AkM
ZKpmXEDwyBaSgqGnrd4GordqXCh6DgVPI6APsKdfl8KNf0GZuFxmCtu8sugYOnA9
M2UYRppTV73vPB/jIMgo5ClDJ3LIsLeOlwr7oZcOBTzKqzj1YzLcuqAXasR4+rx/
oZjXMw77yHZbWHWCA2ErIa+Lgeu1xdfHJm/f7ExDQIgGUVKlXfbj2lE87ttm8Zdi
yY02wOS2z05P2+xnawmEx/p94nQnVz6l4Vdgh48VqUU8g5kax3Zkxb4v8B9oVtDo
uY+VJrfJ9VReziVzPfIqUAKaCciamvsbAytjRd0JyxALy2600iQZZxt67Z5CMBEp
MIPoubbmknwnjWXJlDdpGNp24J4d0ZrftJSJtiqbw8TPZ7GcFSQ=
=13w0
-----END PGP SIGNATURE-----

--Apple-Mail=_BAEA8DCF-7D8D-46E0-BF67-24CFA346618A--
