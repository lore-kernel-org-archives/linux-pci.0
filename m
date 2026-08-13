Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05444AB98
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616055; cv=none; b=sKFNPhVQ8HvwuErYeHy48DudwpdWvbSMpfryFsbgVkqEv8EkPkokUKaIpqPXzyHqqKVzfS+ZkGJmo+QolTySazRR3ktX24Va1f/ZWqowFCkTNMPdVyP/j1hGhKcq9VwT8tB999QpSYwFKoR6qQaJK/6/OPCltphjDdv0uBMZd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616055; c=relaxed/simple;
	bh=eNOgY/8tx7BxqRcfnnxrILVFjSWVTuELAsGKZxQoM/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki3/6+1ja9Jbn0NmgHP/Y7iKz4V5jDMv3Rww/67k8FQ+vM6Wkp6jHwW+FTNYsskT1nVZ4bubqVSx1Mm/kwEpEFqOhu4fzURStepfTSTgByu3Td3F0UPHKLXdMnvO89MEoVwp42utAGxX15v9bkmz3FNhGwnSOYJ5kvblcd+jZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLo6t8IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLo6t8IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4087B1F00A3F
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616043;
	bh=kTNrCV3t/mEVfwJWf78aFwuNT6sE+LNNyY+YdUQxlDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kLo6t8IBz6w/C6XDmWLBGqRq3yUY43U3bQLCxdr1uVi8u4fofA8FOObBZgl4IMFRQ
	 NLctUIslclMRnBpt7lyenPR5RPmv/XKMCpY1/4zPjflERf+DWjwM5MPrEMcHGT1tlQ
	 c8Bk+tLFAMbjutlHRuPqekSoMB0zU1zXA8JYPRXSkN1PtYXCgaCYXiadMtuHSNNqK0
	 q20EHaGKhhjZXyDDUFiupUwh5TfEUxi84ZHotKQ4ls0ADPhMGq8cfUA5oOUFQ4nNQ8
	 dmeK1v05QKYNyJcF6mfo6DLRWNMrOTx6sQoDZ+0zSXlfRPSm1rm8Ebh3kGQ8jCp6gu
	 sCN/NV4ebJLeg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2229468e87.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 03:14:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpnjxutJbdwQXDdF/36sbNr9+5l3ICuCY6QXv1zxl90LyMAepUKzPH/DLFt7SBgnG2g8FxilVysKB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPy861xGWRzCA4+7SwHuT26pyFVSvinz6qoUYDNhg4Y3EJxyv
	CbOn5m/Yo7B4V+N6TdLIoYxSEz4wOGpuh7eJHEaG1oavhW5br0UmP9KKEjILoqKyi7AKIrqroEi
	MflQrVwwtuEl9XGw1ZHQOQo6uIZjSrEo=
X-Received: by 2002:a05:6512:150e:10b0:5ae:b78c:da1 with SMTP id
 2adb3069b0e04-5b453f6fd11mr502046e87.28.1786616041559; Thu, 13 Aug 2026
 03:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com> <20260812-hmat-p2p-v1-1-75ac41380585@nvidia.com>
In-Reply-To: <20260812-hmat-p2p-v1-1-75ac41380585@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 12:13:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDR1LN=6QosMvNbctHKqEmzG0Jg6eS1np5MQkfLjXzAA@mail.gmail.com>
X-Gm-Features: AUfX_myRSOyiZCvF9QRoOS94TTWfPQ0TJEjyuMvimTc5W7PyRpU-jyLFek1aFmQ
Message-ID: <CAJZ5v0iDR1LN=6QosMvNbctHKqEmzG0Jg6eS1np5MQkfLjXzAA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] ACPICA: Define PCIe P2P latency and bandwidth information
To: Leon Romanovsky <leon@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Logan Gunthorpe <logang@deltatee.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"Natu, Mahesh" <mahesh.natu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 9:48=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> PCIe topology alone cannot tell an operating system whether traffic may
> cross host bridges, what ordering rules it needs, or how expensive the pa=
th
> is. Encoding this knowledge in chipset lists duplicates platform policy a=
nd
> cannot survive a virtualized topology.
>
> Define HMAT Type 3 as a firmware contract for directional Generic Port P2=
P
> paths, including separate ordered and Unordered I/O applicability. This
> gives platform software a standard way to distinguish unsupported,
> conditional, and usable paths. The definition follows a proposed ACPI ECN=
.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/acpi/actbl1.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
submit a pull request with this change to the upstream ACPICA project
on GitHub.  The Linux patch will become applicable when there is a
corresponding commit upstream.

> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index d824838cb7af..0fc766a8e90f 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -2003,7 +2003,8 @@ enum acpi_hmat_type {
>         ACPI_HMAT_TYPE_PROXIMITY =3D 0,   /* Memory proximity domain attr=
ibutes */
>         ACPI_HMAT_TYPE_LOCALITY =3D 1,    /* System locality latency and =
bandwidth information */
>         ACPI_HMAT_TYPE_CACHE =3D 2,       /* Memory side cache informatio=
n */
> -       ACPI_HMAT_TYPE_RESERVED =3D 3     /* 3 and greater are reserved *=
/
> +       ACPI_HMAT_TYPE_P2P_LATENCY =3D 3, /* PCIe P2P latency and bandwid=
th information */
> +       ACPI_HMAT_TYPE_RESERVED =3D 4     /* 4 and greater are reserved *=
/
>  };
>
>  struct acpi_hmat_structure {
> @@ -2108,6 +2109,30 @@ struct acpi_hmat_cache {
>  #define ACPI_HMAT_CP_WB     (1)
>  #define ACPI_HMAT_CP_WT     (2)
>
> +/* 3: PCIe P2P Latency and Bandwidth Information */
> +
> +struct acpi_hmat_p2p_latency {
> +       struct acpi_hmat_structure header;
> +       u8 flags;
> +       u8 data_type;
> +       u16 reserved1;
> +       u32 number_of_initiator_Pds;
> +       u32 number_of_target_Pds;
> +       u32 reserved2;
> +       u64 entry_base_unit;
> +};
> +
> +/* Masks for Flags field above */
> +
> +#define ACPI_HMAT_P2P_NON_UIO   (1)    /* Bit 0: Entries apply to non-UI=
O traffic */
> +#define ACPI_HMAT_P2P_UIO       (1<<1) /* Bit 1: Entries apply to UIO tr=
affic */
> +
> +/*
> + * The data_type field reuses the ACPI_HMAT_ACCESS/READ/WRITE_LATENCY an=
d
> + * ACPI_HMAT_ACCESS/READ/WRITE_BANDWIDTH values defined for the System
> + * Locality Latency and Bandwidth Information Structure above.
> + */
> +
>  /***********************************************************************=
********
>   *
>   * HPET - High Precision Event Timer table
>
> --
> 2.55.0
>
