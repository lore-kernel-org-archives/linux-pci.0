Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CF37F731
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518524; cv=none; b=Naw8brLOPCWa0WxwuItTxAlY+bhDn2ZiHV/NioWLv3mYc9kYg/TpCUguAZZHjY3jjR2W4uKC4IzffabeQqEPJpLS3wezOkOk53Ao4uzpjmhSskuvJgeaV9SRUn7lfU9isbwMv78y0ct4XwKryQ5KxN7MU7265TbaN1T3g7LVEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518524; c=relaxed/simple;
	bh=dFmRbKPIPJ1dWc3CYobE3uhZixiwIuXjAzJXkmuSq8A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HhypOIjqbbudtF1k4du9JaSG7dciZJG38I8cxoKaUzSx1WEZboiXeZ7VycxTz4u+Mwqhiapt+yj/RJCVwOTyXdAZtXubaZ6UnGJBdDWORLQPPr00Jq783icV3HbehFbliIutw2Iy9U9r8S20PcjPHOy1rR9829wzOiO3GtLC8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UASpAwch; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UASpAwch"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39b268e608eso6887091fa.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518521; x=1784123321; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EWSbzTVGjohibpFGciauhEYGIu8dVHtLsNaD8KvexjA=;
        b=UASpAwchV1BUV+ilpu+u5K7L++S7pIJjxbABAoJiJZiAu/DFqBNWsLCtRYiPYWKCJ7
         i1tyod0BEl822bl+YReaFUm+XCCsw8l2gOVNG7NQ6u0NFU7xT5+S1mG5rcCVEcildKqa
         VJbqBx0KT9n2V4UuRNHpdamJBHZRqNEw0dyeNfL/fJjQNl3o1khyf6k9xkbnh69WpM3R
         bscJeW2PgpPM0Sz/InzhxeWQvg3135qHhTNqKDQPd1Hf3O5TeyI0qalNo1A2tKgc5fta
         kkzfy7QEf9cFpV9pJDiBZFcMA+X/ZPzF9LwZY8QeO0pLOQsXPjWb/xYKuHi+801gPxWH
         5Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518521; x=1784123321;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EWSbzTVGjohibpFGciauhEYGIu8dVHtLsNaD8KvexjA=;
        b=ocJ/pNNU00QIB75HXrNzR1vpr04exLiJeXViahmtjIDMsJN2zv4JdCRrmGLgG5Jmff
         r7erraQscCeEycEICyw0pc+MItmgq0hB2C5NAtwqrv9/SSe/lShFX9iGmLkGMDGaJ2EK
         lUBhr/qpsZt2j0ptWn4C0gyvJHxiZo3f98ad+m1cMAv2xqrxXgLy70GO5ViiqJPQtbJM
         xKZPYGQDtRdQ/W9/W/Gcz8JsniA3CJQr8AwhwEAbNGN24quP3m6wbsapa5giUgYGiKys
         BAaNGqPXChBMemriNz70ShbSntZEaZNZAI+u1mEhgzWbQlTUfPsUabwTe+PmFWHLz/8U
         kXRg==
X-Forwarded-Encrypted: i=1; AHgh+RoPGy9SmcFCjhNQTIycUjsd8ay2XdhKwHm3ajmMXBsE4HrAOg2xjHs02ZjMIFeOGkBDNOQBwHwrA6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ufXdPkS1CCT28wglVxfj99I93yAsJbXqhx8KGxJid18SfGK7
	zQvkL/J5xea4FonN+HeoSS+whdKZQdE9i0VEMo4xn1sd4hGAY1xZ0cEh
X-Gm-Gg: AfdE7cnZLXPZ+suetwCT/qLJri5Nn3kRZeSa9vuxzEM8xWsegvfWx2rj7bz7vqn5IWC
	N0GZAx9IWV8vwPTuOave9bfsV5sfs4YoyTU1OjTwCUUwpUn1L8ClP1iunZcgNlwQ53fE7ZlN8P/
	9gn6cw/OwWc5ltk7A9a6IhoBL6g/ansuJQAj88hXoWA0NllptkWVl8av+AAECzGfkoC/MS6RCgs
	yCLPXqgBIdnuqNkGQcjXtbg7RYkQMJ2Qm9M16fz76v67+dxOjTHRYpyRgsXIAzIm/zD4rwoZmGh
	9JzbCUv+z3LMm91LG1d/RJSsax3E9QTsm+Q3v6u6sVIOgR52F+O61QtVPJyeMBEXJDmQp+q0Suy
	+w0e/msJlRVNZoin7Lw37FB40xvpQyLCdQH3Jv/8XPLb7XEGOg2HMqUgVafy5WDXOS/5GSKQqjy
	nycgOXnUVn99r90WXjDcm+IV84+IAXxQ==
X-Received: by 2002:a2e:92d6:0:b0:39a:e7f6:49aa with SMTP id 38308e7fff4ca-39c7994ff4fmr5349471fa.2.1783518520282;
        Wed, 08 Jul 2026 06:48:40 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:eccc:7ea2:9458:892d])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c78e8490esm3194461fa.17.2026.07.08.06.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:48:39 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev,  linux-pci@vger.kernel.org,
  driver-core@lists.linux.dev,  ankita@nvidia.com,  Alistair Francis
 <alistair.francis@wdc.com>,  Lukas Wunner <lukas@wunner.de>,  Jakub
 Kicinski <kuba@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Xu
 Yilun <yilun.xu@linux.intel.com>,  "Aneesh Kumar K.V (Arm)"
 <aneesh.kumar@kernel.org>,  Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH 04/15] device core: Introduce "device evidence" over
 netlink
In-Reply-To: <20260705220819.2472765-5-djbw@kernel.org>
Date: Wed, 08 Jul 2026 14:22:06 +0100
Message-ID: <m2tsq9boqp.fsf@gmail.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-5-djbw@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <djbw@kernel.org> writes:

> Multiple device security mechanisms are built on top of the SPDM protocol
> from the DMTF. The protocol arranges for devices to verify their identity
> and establish secure sessions between requesters and responders. In turn,
> device security protocols like PCIe IDE use SPDM sessions to program link
> encryption keys, and protocols like PCIe TDISP use exclusive secure
> sessions for managing the device's security state.
>
> All of these uses share a need to retrieve the device's installed
> certificates, its measurements, and other protocol specific objects like
> interface reports. Unify all of those object retrieval and regeneration
> cases into a device-scoped ABI that buses can leverage.
>
> When PCI CMA was presented at Linux Plumbers the consensus reaction was
> that it was not suitable to be driven via sysfs. Given the varied use
> cases of the same fundamental objects the consensus converged on
> netlink. With the new 'blob' extensions to netlink, it can support up to
> the 16MB signed transcripts that SPDM generates.
>
> A bus opts in to evidence gathering via device_evidence_register() and
> passing device_evidence_ops. The ops resolve a device handle to its
> corresponding 'struct device_evidence' context.
>
> See inline documentation in
> Documentation/netlink/specs/device-evidence.yaml for the object types and
> options. This includes objects like TDISP interface reports and options
> like digests instead of full blobs.

Can you include sample pyynl output; it helps immensely during review.

>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

You probably need to cc the netdev list so that the series gets picked
up by patchwork.

> ---
>  drivers/base/Kconfig                          |   4 +
>  drivers/base/Makefile                         |   1 +
>  .../netlink/specs/device-evidence.yaml        | 186 +++++++
>  drivers/base/device-evidence-netlink.h        |  23 +
>  include/linux/device/evidence.h               |  85 ++++
>  include/uapi/linux/device-evidence.h          | 110 +++++
>  drivers/base/device-evidence-netlink.c        |  44 ++
>  drivers/base/evidence.c                       | 453 ++++++++++++++++++
>  MAINTAINERS                                   |   4 +
>  9 files changed, 910 insertions(+)
>  create mode 100644 Documentation/netlink/specs/device-evidence.yaml
>  create mode 100644 drivers/base/device-evidence-netlink.h
>  create mode 100644 include/linux/device/evidence.h
>  create mode 100644 include/uapi/linux/device-evidence.h
>  create mode 100644 drivers/base/device-evidence-netlink.c
>  create mode 100644 drivers/base/evidence.c
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index f7d385cbd3ba..e3929fe6b240 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -190,6 +190,10 @@ config HMEM_REPORTING
>  	  Enable reporting for heterogeneous memory access attributes under
>  	  their non-uniform memory nodes.
>  
> +config DEVICE_EVIDENCE
> +	bool
> +	depends on NET
> +
>  source "drivers/base/test/Kconfig"
>  
>  config SYS_HYPERVISOR
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..02bdc4f74019 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
> +obj-$(CONFIG_DEVICE_EVIDENCE) += evidence.o device-evidence-netlink.o
>  obj-$(CONFIG_ACPI) += physical_location.o
>  
>  obj-y			+= test/
> diff --git a/Documentation/netlink/specs/device-evidence.yaml b/Documentation/netlink/specs/device-evidence.yaml
> new file mode 100644
> index 000000000000..44b278bc20e1
> --- /dev/null
> +++ b/Documentation/netlink/specs/device-evidence.yaml
> @@ -0,0 +1,186 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +---
> +name: device-evidence

The naming seems to be too narrow - if the scope expands at all then the
name would need to change. A subsystem name like spdm, tsm or tsm-device
seems better?

> +protocol: genetlink
> +uapi-header: linux/device-evidence.h
> +doc: Device evidence retrieval over generic netlink
> +
> +definitions:
> +  -
> +    type: const
> +    name: max-object-size
> +    value: 0x01000000
> +  -
> +    type: const
> +    name: max-nonce-size
> +    value: 32
> +  -
> +    name: type
> +    type: enum
> +    doc: Device security evidence objects
> +    render-max: true
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
> +        doc: |
> +          SPDM version, capabilities, and algorithms transcript
> +          negotiated at session establishment. An implementation may not
> +          provide this separately and instead include it in the
> +          measurements transcript.
> +      -
> +        name: measurements
> +        doc: SPDM GET_MEASUREMENTS response
> +      -
> +        name: report
> +        doc: |
> +          A bus that implements a device interface security protocol
> +          like TDISP may convey an interface report that details
> +          interface settings and capabilities.
> +  -
> +    name: type-flag
> +    type: flags
> +    doc: Device security evidence request flags
> +    render-max: true
> +    # NOTE! these values must match the type enum name and order
> +    entries:
> +      -
> +        name: cert0
> +      -
> +        name: cert1
> +      -
> +        name: cert2
> +      -
> +        name: cert3
> +      -
> +        name: cert4
> +      -
> +        name: cert5
> +      -
> +        name: cert6
> +      -
> +        name: cert7
> +      -
> +        name: vca
> +      -
> +        name: measurements
> +      -
> +        name: report
> +  -
> +    name: flag
> +    type: flags
> +    render-max: true
> +    doc: Flags to control evidence retrieval
> +    entries:
> +      -
> +        name: digest
> +        doc: |
> +          Request a secure hash of objects like vca and measurements.
> +          The expectation is that this digest is produced by a responder
> +          within the TCB like a platform TSM. It validates a blob that
> +          may have traversed a transport without integrity protections.
> +
> +attribute-sets:
> +  -
> +    name: object
> +    attributes:
> +      -
> +        name: type
> +        type: u32

Is this an instance of the type enum? If so then:

           enum: type

> +        doc: evidence type-id
> +      -
> +        name: type-mask
> +        type: u32

Likewise:
           enum: type-flag

> +        doc: evidence types as a flag mask
> +      -
> +        name: flags
> +        type: u32

And:
           enum: flags

> +        doc: evidence modifier flags like 'request object digest'
> +      -
> +        name: subsys
> +        type: string
> +        doc: device subsystem name (e.g. bus or class name)
> +      -
> +        name: dev-name
> +        type: string
> +        doc: device name
> +      -
> +        name: nonce
> +        type: binary
> +        checks:
> +          max-len: max-nonce-size
> +      -
> +        name: generation
> +        type: u32
> +        doc: detect local threads racing evidence refresh
> +      -
> +        name: count
> +        type: u64
> +        doc: TSM, if present, observed count of evidence refresh events
> +      -
> +        name: length
> +        type: u32
> +        checks:
> +          max: max-object-size
> +        doc: |
> +          Final size of 'val' blob after all messages received.
> +      -
> +        name: val

Any reason for the abbreviated name?

> +        type: binary
> +        multi-attr: true
> +        bloblen: length
> +        doc: |
> +          Ordered evidence object value chunk. Large evidence objects
> +          may be split over several dump reply messages up to 'length'.
> +          'length' is transmitted before the first chunk.
> +
> +operations:
> +  list:
> +    -
> +      name: read
> +      doc: |
> +        Read device evidence objects of a given type mask. The dump reply
> +        reports the total value length before val attributes fill the evidence
> +        object, possibly across multiple messages.
> +      attribute-set: object
> +      flags: [admin-perm]
> +      dump:
> +        pre: device-evidence-nl-read-pre
> +        post: device-evidence-nl-read-post
> +        request:
> +          attributes:
> +            - type-mask
> +            - flags
> +            - subsys
> +            - dev-name
> +            - nonce
> +        reply:
> +          attributes:
> +            - type
> +            - generation
> +            - length
> +            - val

Is the intention that the dump filter must narrow to a single device? Is
the user expected to enumerate the devices in subsystem then read device
evidence for each in turn?
