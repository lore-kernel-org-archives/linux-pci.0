Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236039B975;
	Tue,  3 Mar 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532987; cv=none; b=bVJJc4u64zzx6/4yjs0+1Oa7dIwHAGr8R9sAfh90vxFaVbbHDJ7R4nS7lfM7TbQFOaluoe2ZyrSyn/kR3ybW7/XQIOt93VxZx6yQZebVk0By6PYpYERnKdfJ+Nyo0qczjmguk6jItW2fia7039VFAGd4VXP2PupsLVzAhaTBgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532987; c=relaxed/simple;
	bh=Ep1ABK1UeNOvhBIrW+E3WpXy1BHoy0zLsBlj9HIQUlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bq4lK6Y981uWoSCbdYibFqSzbFHpROCZnn6/goAvyCh1cNNY/auWhatbXCO7FNJpWr/N/+IGgm/WPxyCwidDbNymxHLUdpmaXzHtMF8Ono3T+gqAzzfy8mziRmhAmw0dTh0w3NlsW1xpTG+vyeRDx1Z8gbngPNCwkOGtKVQ+Kh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq9eC4oE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq9eC4oE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ECAC116C6;
	Tue,  3 Mar 2026 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532986;
	bh=Ep1ABK1UeNOvhBIrW+E3WpXy1BHoy0zLsBlj9HIQUlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lq9eC4oEV7uKoPaBXovM0xmvM2pKW6w+TdiQtFSkLrqKGIHaD2vsO7bQai5FcoesD
	 KHFAur7fP1RhU2AZigrBOHe/9BD+V4JOi77NwEi4L4lb8vv1/d8zmcJ+xhP615YMDM
	 Z1r5bETZ+HM/BSAoLzKgzPmQD2+zx8WFUZktIduc2ctvMc2oXeaXxQ7eAwieg8amxn
	 vCryQBRsQikDN68NqAhVxS9TFnLFVdApZk6d/FP+m8gOaYO53AuYOFyFK6mGtg0RPZ
	 SlK0P1dagPB7Ds1Jeq4rEhvz01WLK5SDxH5D6XvsP51jvha7YehVDiBSQIgU6oDb9A
	 2dFiGKP5YsSWQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
Date: Tue, 03 Mar 2026 15:46:18 +0530
Message-ID: <yq5abjh59q19.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Once one accepts the threat model that devices may be adversarial the
> process of establishing trust in the device identity, the integrity +
> confidentiality of its link, and the integrity + confidentiality of its
> MMIO interface requires multiple evidence objects from the device. The
> device's certificate chain, measurements and interface report need to be
> retrieved by the host, validated by the TSM and transmitted to the guest
> all while mitigating TOCTOU races.
>
> All TSM implementations share the same fundamental objects, but vary in how
> the TSM conveys its trust in the objects. Some TSM implementations expect
> the full documents to be conveyed over untrustworthy channels while the TSM
> securely conveys a digest. Others transmit full objects with signed SPDM
> transcripts of requester provided nonces. Some offer a single transcript
> to convey the version, capabilities, and algorithms (VCA) data and
> measurements in one blob while others split VCA as a separate signed blob.
>
> Introduce a netlink interface to dump all these objects in a common way
> across TSM implementations and across host and guest environments.
> Userspace is responsible for handling the variance of "TSM provides combo
> measurements + VCA + nonce + signature, vs TSM provides a digest over a
> secure channel of the same".
>
> The implementation adheres to the guideline from:
> Documentation/userspace-api/netlink/genetlink-legacy.rst
>
>     New Netlink families should never respond to a DO operation with
>     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
>     instead.
>
> Per SPDM, transcripts may grow to be 16MB in size. Large PCI/TSM netlink
> blobs are handled via a sequence of dump messages that userspace must
> concatenate.
>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/Makefile                     |   2 +-
>  drivers/pci/tsm/Makefile                 |   9 +
>  Documentation/netlink/specs/pci-tsm.yaml | 151 +++++++++++++
>  drivers/pci/tsm/netlink.h                |  23 ++
>  include/linux/pci-tsm.h                  |  63 ++++++
>  include/uapi/linux/pci-tsm-netlink.h     | 101 +++++++++
>  drivers/pci/{tsm.c => tsm/core.c}        |  17 +-
>  drivers/pci/tsm/evidence.c               | 274 +++++++++++++++++++++++
>  drivers/pci/tsm/netlink.c                |  43 ++++
>  MAINTAINERS                              |   4 +-
>  10 files changed, 682 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/pci/tsm/Makefile
>  create mode 100644 Documentation/netlink/specs/pci-tsm.yaml
>  create mode 100644 drivers/pci/tsm/netlink.h
>  create mode 100644 include/uapi/linux/pci-tsm-netlink.h
>  rename drivers/pci/{tsm.c => tsm/core.c} (98%)
>  create mode 100644 drivers/pci/tsm/evidence.c
>  create mode 100644 drivers/pci/tsm/netlink.c
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index e10cfe5a280b..31f5095360af 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
>  obj-$(CONFIG_PCI_IDE)		+= ide.o
> -obj-$(CONFIG_PCI_TSM)		+= tsm.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm/
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/tsm/Makefile b/drivers/pci/tsm/Makefile
> new file mode 100644
> index 000000000000..afa775224b8d
> --- /dev/null
> +++ b/drivers/pci/tsm/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the PCI/TSM infrastructure
> +
> +obj-$(CONFIG_PCI_TSM) += tsm.o
> +
> +tsm-y := core.o
> +tsm-$(CONFIG_NET) += netlink.o
> +tsm-$(CONFIG_NET) += evidence.o
> diff --git a/Documentation/netlink/specs/pci-tsm.yaml b/Documentation/netlink/specs/pci-tsm.yaml
> new file mode 100644
> index 000000000000..eb7fc03bd705
> --- /dev/null
> +++ b/Documentation/netlink/specs/pci-tsm.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +---
> +name: pci-tsm
> +protocol: genetlink
> +uapi-header: linux/pci-tsm-netlink.h
> +doc: PCI TSM Evidence retrieval over generic netlink
> +
> +definitions:
> +  -
> +    type: const
> +    name: max-object-size
> +    value: 0x01000000
> +  -
> +    type: const
> +    name: max-nonce-size
> +    value: 256
> +  -
> +    type: const
> +    name: max-obj-type
> +    value: 4
> +  -
> +    name: evidence-type
> +    type: enum
> +    doc: PCI device security evidence objects
> +    entries:
> +      -
> +        name: cert0
> +        doc: SPDM certificate chain from device slot0
> +      -
> +        name: cert1
> +        doc: SPDM certificate chain from device slot1
> +      -
> +        name: cert2
> +        doc: SPDM certificate chain from device slot2
> +      -
> +        name: cert3
> +        doc: SPDM certificate chain from device slot3
> +      -
> +        name: cert4
> +        doc: SPDM certificate chain from device slot4
> +      -
> +        name: cert5
> +        doc: SPDM certificate chain from device slot5
> +      -
> +        name: cert6
> +        doc: SPDM certificate chain from device slot6
> +      -
> +        name: cert7
> +        doc: SPDM certificate chain from device slot7
> +      -
> +        name: vca
> +        doc: SPDM transcript of version, capabilities, and algorithms negotiation
> +      -
> +        name: measurements
> +        doc: SPDM GET_MEASUREMENTS response
> +      -
> +        name: report
> +        doc: TDISP GET_DEVICE_INTERFACE_REPORT response
> +
>

In the case of CCA, the slot number is determined early, when we create
the pdev object that maps to PF0. This is done as part of the connect
callback. Currently, the slot number is hardcoded to 0. I believe we
need to extend connect to include slot information.

Even with that change, we would only have one certificate type.
These would correspond to whichever slot number was selected during
connect.


-aneesh
