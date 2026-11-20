Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185233;
	b=QMbRziG4GFKSDxy6J2U6irYjE89C8TlxgoN8llpS7T+ICd+FgakJCIFvnvXcqi5AnIPe
	 Bqh4qcQTlJkzZbv5tS+uOT+yzUVbSTBblBf8AXb7SXxfTeGLAHzVTVnvNcjG7WROjDf3l
	 JYDR6qSarqjkZT3Z+wuGf0vrsFtafnCrax2N5KOWFMtMn3RBShFtBkav1u09UNHK1SF7o
	 OO9Qeneon8y5l8pCGIkhA6yENW3CB8FZwUmyeS4lcrQnDyrL3wkl3hj2FpFkgwkyIyj0D
	 bcLz8C4PHP0NyW6Bh5kELuGlkqRSA0XrN98rZ8fDBrG1njNbewLldQiPoKZMqhMqVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185233;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Fy3WW09hB+rkP27DDiDOsr/F2JQ6kUcBqy1wnUqOGKY=;
	b=IJYw+hS83DkSZ6L/9kVKxPzeRwXboyIZani8u2BqOqFRI8S5EwHFDFRowsHpqVVXwVID
	 6JKyDWsOA1GgDUjhqsTn+MgFPCeHkh9F3snKK/SxEooyKGEvVtIINgVqpGrmB9Fss9X5o
	 lxzIdLaXS6vCDnXocbpYJZjt2BG2GRKjRbRnmnRDj7r9QEMc45CM/wyxJ7aM5CCzuoIMj
	 RYj9DoVqvW3ECoQStlr8vwuhK5eP65iZnZlHPHC5dutetqkFi4sZGrhnqhPaWByvl4zD0
	 +MLAX4jM4g7K4R37DfWar/QSUcxVPjE5vd46lS3qA4MNe6XjzAeT4seSUAxLcsms/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP6gHav2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D3606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kP6gHav2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0AE1F000D8
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185233;
	bh=Fy3WW09hB+rkP27DDiDOsr/F2JQ6kUcBqy1wnUqOGKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kP6gHav2GQa1iDKRIlyXbUNoVUUQ6bzwiY7KGVt3Uongi7Bl7i9cci9WDEWJZvztc
	 hLsgKPBSH4JeI815Pd5DnJhZPovR0y2xXsfHmHIgfIUgHYpKVk0N7Z8PU5XBhh6sAz
	 9bgZE1ipS6hJRYKcOK6TPxiu3TZuZ0oIhTelgC6e9xioMq+hEtjju95EmN/Etqsn/B
	 A/EdQ037JyB0JGZ7XFHpZq20+429ZWh6bLiO7NqovbhoG9gus7Lj2hUxR4gN9jLc3V
	 Ij5Ju0kv+Stfhlda76toyjwXtXTe/lkynCTO2Rsz8gBtW5QFLRyxg0PeepL7yVdNPd
	 0XiEPWR2s/7dg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4fea434bso2073011e87.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 06:33:53 -0800 (PST)
X-Gm-Message-State: APuU4Z9QLdI63PJ8bF5cWuB1ohAXNxGVjknY5RlvMq64fgXJKwNRFFQi
	+E4K87XVGz3qBqDm93qjV73cazQcsYpILLlzXoW1AYb+zuhtOjXN7BBb+SNVVzn3olwanhbaRnI
	1YCbbGCzAERZlTuX0DzDTpH2haoGYt2c=
X-Received: by 2002:a05:6512:3052:b0:5c1:4ede:6fcb with SMTP id
 2adb3069b0e04-5c1bc822591mr845358e87.8.1795185231609; Fri, 20 Nov 2026
 06:33:51 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com> <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 15:33:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hPOdbnWVrD8gVGS9L=WoXyO7REhWSgCJ26F8Fkzf94yw@mail.gmail.com>
X-Gm-Features: Aa3M54os8iRJ1ey_0RncgK8uRQ3y9Pr0ZgaUI1JtUGreQJfTIibpDnX303gkn5g
Message-ID: <CAJZ5v0hPOdbnWVrD8gVGS9L=WoXyO7REhWSgCJ26F8Fkzf94yw@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] PCI: acpiphp: Use pci_assign_unassigned_slot_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:48=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> enable_slot() calls the internal sizing and assignment functions
> directly to size only the bridges in the slot. Use
> pci_assign_unassigned_slot_resources() instead.
>
> Sizing now happens after scanning all bridges in the slot instead of
> right after scanning each bridge. Sizing a bridge window only walks the
> hierarchy below that bridge, so the order does not matter. Sizing now
> also holds pci_bus_sem.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 632344f34cae..fc95d5814ecb 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -497,7 +497,6 @@ static void enable_slot(struct acpiphp_slot *slot, bo=
ol bridge)
>                                 acpiphp_native_scan_bridge(dev);
>                 }
>         } else {
> -               LIST_HEAD(add_list);
>                 int max, pass;
>
>                 acpiphp_rescan_slot(slot);
> @@ -511,12 +510,10 @@ static void enable_slot(struct acpiphp_slot *slot, =
bool bridge)
>                                 if (pass && dev->subordinate) {
>                                         check_hotplug_bridge(slot, dev);
>                                         pcibios_resource_survey_bus(dev->=
subordinate);
> -                                       __pci_bus_size_bridges(dev->subor=
dinate,
> -                                                              &add_list)=
;
>                                 }
>                         }
>                 }
> -               __pci_bus_assign_resources(bus, &add_list, NULL);
> +               pci_assign_unassigned_slot_resources(bus, slot->device);
>         }
>
>         acpiphp_sanitize_bus(bus);
> --
> 2.47.3
>
>
