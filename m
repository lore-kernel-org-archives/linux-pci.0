Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599152744F;
	Wed,  8 Jul 2026 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471995; cv=none; b=gP9ovtnTofSIIRsHq0Wep0/8ljBW6p2X5OdcdMhEQzO91buhX4pa/itywKZ8obX4jpn8JDRLtFjmYK+l/Fhj3Musa8mSUqqsXGV9jA+MPio77PeiMXc0z285Wsw+RH2TuIc6erup3dHKMHI1SAvzK0ap1FmIVVrX6KrJyPjZ3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471995; c=relaxed/simple;
	bh=LJ0J/F+MiC+l50mfwabHL5ag2lbrE+0HOss/l35n5xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCxXAhQsWTYMFJWO/ny1sCG0235/v/dfZGFFh4DNHr6LkBUyD9BBrPysbOpBXFogLSQFJXrOhXjbGE5ONb8+ZNC1vSXPTH+YjMtHFmP7cq6LYT71R9uGWhT8VaRkBoQuJyNhJ+NCERIFhHJ8BfnI7txoAV6Leu0l6pazf4iyu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gcoqcTDc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gcoqcTDc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=nT9dyDZkXxOBIWa2aNlNCaalMJPwXGui6V/AuDqcEUc=; b=gcoqcTDcb0ZU0Zz6TsGsSfE5Vj
	I697AgfZpl4oo+FtjpU64jyM1YJ4nwUru1QqacPWcGFl40WugpYjoq+iirJDBtoYA7f4NYic94tkh
	8SbmPfeHv2lOpWOf0kZXcIECuePJxD5TJ/FX85O2vvDNJEEB4XuYTCqTQYxTxj3pdORpsd7+RWd9f
	0OP6azi11u1wJIAW3gheD43WscLNjVXGJqd4vJ2kZB30mQXU4Tt26HWhHdTEIhTgUqFuovTjWcP4B
	5mCFgTISxMmeSRmIxktJAoDlZL0I0i808e++uF+VApFqxsMjZF6j/qoKxJsz5ZAKX70u4UbzgwkRe
	yNtoAkCQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whGXB-0000000G4bC-3aGL;
	Wed, 08 Jul 2026 00:53:05 +0000
Message-ID: <17aee024-e1c3-488a-aade-bd4df139cccb@infradead.org>
Date: Tue, 7 Jul 2026 17:53:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Update after split of
 <linux/mod_devicetable.h>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Dongliang Mu <dzm91@hust.edu.cn>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/6/26 8:01 AM, Uwe Kleine-König (The Capable Hub) wrote:
> Most structs that were defined in <linux/mod_devicetable.h> before were
> moved to a bus specific header. Follow the movement to get the struct's
> documenation back.
> 
> For the list of device ids in basic.rst use an explict list of all the

                                basics.rst

> headers that have kernel-doc annotations and that are not described
> elsewhere (i.e. pci and mei_cl).
> 
> Also repair the referencing in the zh_CN translation of pci.rst and
> don't duplicate `struct mei_cl_device_id`.
> 
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers")
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> the explicit list is a bit ugly, but I don't have a better idea.
> 
> If you're happy with the patch, can Linus and Jonathan please agree on how this
> is applied?
> 
> Best regards
> Uwe
> 
>  Documentation/PCI/pci.rst                     |  2 +-
>  Documentation/driver-api/basics.rst           | 31 +++++++++++++++++--
>  .../driver-api/mei/mei-client-bus.rst         | 12 ++-----
>  Documentation/pcmcia/driver.rst               |  2 +-
>  Documentation/staging/rpmsg.rst               |  2 +-
>  Documentation/translations/zh_CN/PCI/pci.rst  |  8 ++---
>  6 files changed, 39 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index be35e9a1ee75..71c42b0bfa8b 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -84,7 +84,7 @@ initialization with a pointer to a structure describing the driver
>  The ID table is an array of ``struct pci_device_id`` entries ending with an
>  all-zero entry.  Definitions with static const are generally preferred.
>  
> -.. kernel-doc:: include/linux/mod_devicetable.h
> +.. kernel-doc:: include/linux/device-id/pci.h
>     :functions: pci_device_id
>  
>  Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up
> diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
> index 8b6a5888cb11..647e14254cfb 100644
> --- a/Documentation/driver-api/basics.rst
> +++ b/Documentation/driver-api/basics.rst
> @@ -10,9 +10,36 @@ Driver Entry and Exit points
>  Driver device table
>  -------------------
>  
> -.. kernel-doc:: include/linux/mod_devicetable.h
> +.. kernel-doc:: include/linux/device-id/amba.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/cdx.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/coreboot.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/dfl.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/fsl_mc.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/ishtp.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/mdio.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/mhi.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/mips_cdmm.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/rio.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/tb.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/tee_client.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/typec.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/usb.h
> +   :internal:
> +.. kernel-doc:: include/linux/device-id/wmi.h
>     :internal:
> -   :no-identifiers: pci_device_id
>  

LGTM. Thanks.
(see nits below)

>  
>  Delaying and scheduling routines
> diff --git a/Documentation/driver-api/mei/mei-client-bus.rst b/Documentation/driver-api/mei/mei-client-bus.rst
> index f242b3f8d6aa..d46c0d0b3540 100644
> --- a/Documentation/driver-api/mei/mei-client-bus.rst
> +++ b/Documentation/driver-api/mei/mei-client-bus.rst
> @@ -41,17 +41,11 @@ the ``struct mei_cl_driver`` structure defined in :file:`include/linux/mei_cl_bu
>  

Would be nice to add kernel-doc comments in <linux/mei_cl_bus.h>
and then include those here instead of duplicating the struct.
(for mei_cl_driver)
>  
>  
> -The mei_cl_device_id structure defined in :file:`include/linux/mod_devicetable.h` allows a
> +The mei_cl_device_id structure defined in :file:`include/linux/device-id/mei_cl.h` allows a
>  driver to bind itself against a device name.
>  
> -.. code-block:: C
> -
> -        struct mei_cl_device_id {
> -                char name[MEI_CL_NAME_SIZE];
> -                uuid_le uuid;
> -                __u8    version;
> -                kernel_ulong_t driver_info;
> -        };
> +.. kernel-doc:: include/linux/device-id/mei_cl.h
> +   :functions: mei_cl_device_id
>  
>  To actually register a driver on the ME Client bus one must call the :c:func:`mei_cl_add_driver`
>  API. This is typically called at module initialization time.
> diff --git a/Documentation/pcmcia/driver.rst b/Documentation/pcmcia/driver.rst
> index 5c4fe84d51c1..b91e5c14cb87 100644
> --- a/Documentation/pcmcia/driver.rst
> +++ b/Documentation/pcmcia/driver.rst
> @@ -15,7 +15,7 @@ runtime as shown below::
>  All fields are passed in as hexadecimal values (no leading 0x).
>  The meaning is described in the PCMCIA specification, the match_flags is
>  a bitwise or-ed combination from PCMCIA_DEV_ID_MATCH_* constants
> -defined in include/linux/mod_devicetable.h.
> +defined in include/linux/device-id/pcmcia.h.

It would look a little nicer (IMO) and be more consistent to use:
   defined in file:`include/linux/device_id/pcmcia.h`.
>  
>  Once added, the driver probe routine will be invoked for any unclaimed
>  PCMCIA device listed in its (newly updated) pcmcia_device_id list.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
