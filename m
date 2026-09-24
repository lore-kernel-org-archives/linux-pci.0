Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536035C1B2
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252833; cv=pass; b=b2AJLSX9v4gLv1MBZKnvVCllCSswqT0/3BfaK8t4liIuwl4E/g2n1tCmj6GY38bNB4nlgtS28HICCvSBjw/3iMzyhQx76QfYYqSyU79C0vs2ujFOcg42Me28nJA5pDbv860EFpevpypGluWAMg2AXYQerZ50VCFMQKB3dbfG6xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252833; c=relaxed/simple;
	bh=w9wC2Uu4PoMxm5u2Tow7lq4uAXIYb5VOPDHAeFRMpZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vs10BMPCURynwwJiJOLBAEwhtkkCNY+wDorw0S0xC1EgAhx8R5SbK3QnV7MQPQerRLZH51ITP5Y5V89Gz02PsafBtGsTm6vu/9EpXFEPb86KF1fJdgh8qlFLBZxBfCBjz2TvtKkDMLbmOlzJXpv1iU8zDBO9Zv7zz5PMN0BPEJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RywBeWcJ; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RywBeWcJ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1142864f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252826; cv=none;
        d=google.com; s=arc-20260327;
        b=hc3LFAarKoLA5YbymAP8mPNu5e5/7WAwdX5rWzq4iiIXCam/O8qtFifJY3W7ul0rnn
         EDK7E6k2ufMAcYwbmiyyJ0Yu19nApDuAOnOLNH94ZoE0HwNkGy8eNmeOJalRrcMKPY+N
         lmDIReihasKEgBiM8gF+EXY3lVDLPFyIDW8aA8DGKXGpclJSj8JhS9dvd0LI1Nz6mBeE
         11TEymvHMymlZ+e+HRmpsk9dKWioddUsNE7S9G3CG3FB/SwVkRs6/1AiPf+Po5170thJ
         CEiat1+WbyyxumZn08ZCPVAXOE16V2KSxIjo8oznyhCrcxri/yTaQ4JMOJ2dUjtdGinm
         tkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsUHcVD4iiMNHcWgFlCKX7SZ89+33YRspZou+LqEcC4=;
        fh=p/lIKa/LmmvBaainrAABP63syy9GMI7LI3PEqfXFC/E=;
        b=qApw5PwEtfosjErBFEGJjbKdtVUQxogeEEFMJ3r6DgbFvliStfyUE41l/NVRLHBCsD
         BeRB6pVcvxA/ctUjNgPUQ00c6Iqq6GLhEDH0J1T8hVZquE3QeqdLfgMzGIwiZwIgh7UO
         DSge+uWR1KGlrdx/ftHWAm0FLn2AoG6mLmzXuvTmH/5jbfQZU/qep2oM0SjLX5o4/wZd
         a91I5SNXFGPr5WyKP0LELVMeV91EbuPB5jVTRPLztQ3MDRXaco6wS/NFEAxgHzKdzNw1
         iH6kc3ITfbKBkPZyBosp5zUuCAH0pvq3eSQu9gSvc/ctsLAmYIeJddlV9eWTKYaMGLMx
         Ptiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252826; x=1790857626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsUHcVD4iiMNHcWgFlCKX7SZ89+33YRspZou+LqEcC4=;
        b=RywBeWcJiVS48jPcT6fXiHdRICBGblKhMRQH8FqrmlvPBzT96e/A7t5UCG6e9I25m9
         AzFXj1S8X2PakBWW6WsFpYvtyZp/JJ2TXt7yMgqXnX18bSFS8HbTQowu6gdMf2MpXlE0
         VtdWvjnvQkdxbf56kl4rxoH19wtk0Dqs7s0ODkxA2xrV40uQ41cFJ/pnBrM4YodY2sje
         ZlyZZMbDBEKmUiQgVoj4h3q3mGYvx0AspZ3mbO1l5icfJc36vS+23YXTdowmekaib/Tq
         nn3yNCEk/Z1xpCEo/9OIhW10+FUJABrnqKDd6a/wzEdzghrUiJvfzfAapF8Orm3/KtFo
         mE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252826; x=1790857626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsUHcVD4iiMNHcWgFlCKX7SZ89+33YRspZou+LqEcC4=;
        b=x5yjjqHQY71k9R1qSkNz5jkCCkoRgBT9pD3UNKD7kooat9Ri+VR73I31PGs1nMgSPR
         14IQB8Kre8sJpb601pgk6jR6hKowzanobaWPHozwklDXFTzapX97fFFdZIzZ1qX+Bl/g
         wWMfM7KG5jImD//wNB1+IvYmbCK7bUQH4eLx5MzpgMO9zms1BHtxokigFn+KSs4iEdpT
         HNmDJ9i6AlcfwqrMYZxP2PK1NK7BvjwrEUJrWTjOY458bWYTycHBTaOE3pwZeIrD9lsI
         4PA3e6Z8PMQKkIaHqnO974Q9BhToeFy45dyUF28T/W7K0U/+VaJIXV5TgSHNd8GqdYRh
         5CKw==
X-Forwarded-Encrypted: i=1; AKwUvBxJLHtETAK5stOWZixO1s7PAN5QF3QSsGUB66/CKDZB81nP2PSwgtQwBOwkGFzqS+6xrHSokBbzFP8=@vger.kernel.org
X-Gm-Message-State: AFuF++kgbl6us/btLGHzX8Ep8UU1hjaiCrRv05tRYwrlOKCbldAI6Qs0
	gyhw+cSpvmg/2WrSoSddPp9OTGvHOgJYCBXdXU5WQTYl5ZVgnZ93YbsLGy1BolnVd8BShU7Fsoa
	jIQ1G1V+aOk1NqE2XicBaV+TqiMN+Wbw=
X-Gm-Gg: AYBFou0D04MSqatEHyxiaA9tvOFsGM8Jf/seBEXwNRdsApqlkRxgFccxnlvX9oXSEhl
	7TSEB/86QlSHjDgaHtdG1BCXNn/384+/0yWOVaJafmjo0e/kzkbMabF/fL0A0p/vp3fO7pWH1Aq
	32NqbB7UDaP3zXnTk68hUV0WZ6okQhHtVxnE7Xm6r0Zt5wTxeUsGXwEGPQ6jOPx8NFauv43DYsQ
	oUQ+YuH6xtU99zFxO3JR68z6bY1zpo2iG6gVa/miMN3cfW47Q9pya6u7oWFIWmxA831MAOc4E4V
	zGSC0YGHvIdKRjAXD4UmDJRfb6VEhE59fUGDyfqjwQ6mGgVhGYbdnicoKsdSttKNnvbuf4vSvq3
	ERe2TX6d+p4qVPTtndmC7I2H5aVrpWQ9Gbc9AD9jNWsYOW9hl1Piy7tBXlIz+Kz2d9NUdgfXRI+
	o=
X-Received: by 2002:a05:6000:4108:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-4887787490dmr518685f8f.25.1790252826401; Thu, 24 Sep 2026
 05:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-8-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-8-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:26:39 +0100
X-Gm-Features: AclHuK-S3QMwI_w2mkt6y9Ay25qMMmBISReR0o_iUHkOdDzEtDuJRClEaL9GrhY
Message-ID: <CA+V-a8ubQ0igr1Yt5Giq9-iZ2YX13Wwjm_6yK0eeD4CnhSHhVg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Madieu <john.madieu.xa@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:55=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: John Madieu <john.madieu.xa@bp.renesas.com>
>
> The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers does not expose the
> standard PCIe Slot Capability registers, so the generic pciehp driver
> cannot be used. The only link-state signal the hardware provides is the
> DL_UpDown bit in the PEIS0 event status register, which is raised on ever=
y
> Data Link layer up/down transition.
>
> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
> can react to link-state changes: a device that trains after boot gets
> enumerated, and a device that disappears on link loss is removed. This
> provides hotplug-like behavior without the PCI hotplug core, which is
> unavailable for the reason above.
>
> On a DL_UpDown event the handler acks the W1C status bit and schedules a
> worker that inspects PCSTAT1.DL_DOWN_STS:
>
>   - link up: re-run max link speed negotiation, wait for the link to
>     settle and pci_rescan_bus() the root bus;
>   - link down: walk the bus in reverse and pci_stop_and_remove_bus_device=
()
>     each child.
>
> Both paths take pci_lock_rescan_remove() to serialize against the PCI
> core.
>
> Link events are processed only after the controller has been fully
> initialized.
>
> While at it, make probe tolerant of an absent device. Previously, if the
> link failed to come up during rzg3s_pcie_host_init(), probe tore the
> controller back down and failed. Distinguish this case with -ENODEV,
> leave the controller and refclk running, and let the link-up path
> enumerate the device once it appears.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - dropped .reset_root_port() changes
>
> Changes in v3:
> - added RZG3S_PCI_PEIE0_DL_UPDOWN
> - re-worked the support by implemeting
>   struct pci_host_bridge::reset_root_port()
> - introduced the struct rzg3s_pcie_host::state to:
> -- avoid touching the controller while a reset root port is in progress
> -- and avoid touching the controller in case a reset root port failed
> -- and to be able to re-use the already existing code in the reset
>    root port function
> -- and added CLASS() constructs helpers for it to keep the state handling
>    code simpler
> - updated the patch description to reflect the updates
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 155 ++++++++++++++++++++---
>  1 file changed, 139 insertions(+), 16 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index f4b27a77a89d..1c0353598b59 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -86,6 +86,7 @@
>  #define RZG3S_PCI_MSGRCVIS_MRI                 BIT(24)
>
>  #define RZG3S_PCI_PEIE0                                0x200
> +#define RZG3S_PCI_PEIE0_DL_UPDOWN              BIT(9)
>
>  #define RZG3S_PCI_PEIS0                                0x204
>  #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER       BIT(12)
> @@ -323,6 +324,7 @@ struct rzg3s_pcie_port {
>   * @msi: MSI data structure
>   * @port: PCIe Root Port
>   * @hw_lock: lock for access to the HW resources
> + * @event_irq: PCIe event interrupt for DL_UpDown detection
>   * @intx_irqs: INTx interrupts
>   * @max_link_speed: maximum supported link speed
>   * @controller_id: PCIe controller identifier, used for System Controlle=
r access
> @@ -340,6 +342,7 @@ struct rzg3s_pcie_host {
>         struct rzg3s_pcie_msi msi;
>         struct rzg3s_pcie_port port;
>         raw_spinlock_t hw_lock;
> +       int event_irq;
>         int intx_irqs[PCI_NUM_INTX];
>         int max_link_speed;
>         enum rzg3s_pcie_controller_id controller_id;
> @@ -1095,6 +1098,89 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>         return ret;
>  }
>
> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
> +{
> +       struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host=
);
> +       struct pci_bus *bus =3D bridge->bus;
> +       u32 val;
> +
> +       val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +       if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
> +               struct pci_dev *dev, *tmp;
> +
> +               dev_info(host->dev, "PCIe link down, removing devices\n")=
;
> +
> +               pci_lock_rescan_remove();
> +               list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
> +                                                bus_list)
> +                       pci_stop_and_remove_bus_device(dev);
> +               pci_unlock_rescan_remove();
> +       } else {
> +               int ret;
> +
> +               dev_info(host->dev, "PCIe link up, rescanning bus\n");
> +
> +               /*
> +                * Attempt link speed negotiation now that the link is up=
.
> +                * Failure is non-fatal: the device works at the negotiat=
ed
> +                * speed.
> +                */
> +               ret =3D rzg3s_pcie_set_max_link_speed(host);
> +               if (ret)
> +                       dev_info(host->dev, "Failed to set max link speed=
\n");
> +
> +               pci_host_common_link_train_delay(host->max_link_speed);
> +
> +               pci_lock_rescan_remove();
> +               pci_rescan_bus(bus);
> +               pci_unlock_rescan_remove();
> +       }
> +}
> +
> +static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
> +{
> +       struct rzg3s_pcie_host *host =3D data;
> +       u32 status;
> +
> +       status =3D readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
> +
> +       if (!(status & RZG3S_PCI_PEIS0_DL_UPDOWN))
> +               return IRQ_NONE;
> +
> +       /* Clear the DL_UpDown status (W1C) */
> +       writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_P=
EIS0);
> +
> +       rzg3s_pcie_link_event(host);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int rzg3s_pcie_request_event_irq(struct rzg3s_pcie_host *host)
> +{
> +       struct device *dev =3D host->dev;
> +       struct platform_device *pdev =3D to_platform_device(dev);
> +       const char *evt_name;
> +       int ret, irq;
> +
> +       evt_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-evt", dev_name(d=
ev));
> +       if (!evt_name)
> +               return -ENOMEM;
> +
> +       irq =3D platform_get_irq_byname(pdev, "pcie_evt");
> +       if (irq < 0)
> +               return irq;
> +
> +       ret =3D request_threaded_irq(irq, NULL, rzg3s_pcie_event_irq_thre=
ad,
> +                                  IRQF_ONESHOT, evt_name, host);
> +       if (ret) {
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to request pcie_evt IRQ\n");
> +       }
> +       host->event_irq =3D irq;
> +
> +       return 0;
> +}
> +
>  static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int c=
ount)
>  {
>         if (host->intx_domain)
> @@ -1106,6 +1192,17 @@ static void rzg3s_pcie_teardown_intx(struct rzg3s_=
pcie_host *host, int count)
>         }
>  }
>
> +static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> +{
> +       if (host->event_irq > 0)
> +               free_irq(host->event_irq, host);
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               rzg3s_pcie_teardown_msi(host);
> +
> +       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
> +}
> +
>  static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>  {
>         struct device *dev =3D host->dev;
> @@ -1152,22 +1249,21 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s=
_pcie_host *host)
>                         goto teardown_intx;
>         }
>
> +       ret =3D rzg3s_pcie_request_event_irq(host);
> +       if (ret)
> +               goto teardown_msi;
> +
>         return 0;
>
> +teardown_msi:
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               rzg3s_pcie_teardown_msi(host);
>  teardown_intx:
>         rzg3s_pcie_teardown_intx(host, i);
>
>         return ret;
>  }
>
> -static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> -{
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               rzg3s_pcie_teardown_msi(host);
> -
> -       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
> -}
> -
>  static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>  {
>         struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host=
);
> @@ -1679,16 +1775,21 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie=
_host *host)
>                                  PCIE_LINK_WAIT_SLEEP_MS * MILLI,
>                                  PCIE_LINK_WAIT_SLEEP_MS * MILLI *
>                                  PCIE_LINK_WAIT_MAX_RETRIES);
> -       if (ret)
> -               goto config_deinit_post;
> +       if (ret) {
> +               /*
> +                * Link is down. Leave the controller running so the
> +                * DL_UpDown handler can enumerate a device that appears
> +                * later.
> +                */
> +               dev_info(host->dev, "PCIe link down, waiting for DL_UpDow=
n\n");
> +               ret =3D -ENODEV;
> +       }
>
>         val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
>         dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>
> -       return 0;
> +       return ret;
>
> -config_deinit_post:
> -       host->data->config_deinit(host);
>  config_deinit_and_refclk:
>         clk_disable_unprepare(host->port.refclk);
>  config_deinit:
> @@ -1723,8 +1824,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host=
,
>
>         ret =3D rzg3s_pcie_host_init(host);
>         if (ret) {
> -               dev_err_probe(dev, ret, "Failed to initialize the HW!\n")=
;
> -               goto teardown_irqdomain;
> +               if (ret !=3D -ENODEV) {
> +                       dev_err_probe(dev, ret,
> +                                     "Failed to initialize the HW!\n");
> +                       goto teardown_irqdomain;
> +               }
> +
> +               /* Link is down: hotplug via DL_UpDown will recover. */
> +               return 0;
>         }
>
>         ret =3D rzg3s_pcie_set_max_link_speed(host);
> @@ -2004,6 +2111,14 @@ static int rzg3s_pcie_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 goto host_probe_teardown;
>
> +       /*
> +        * Unmask the PCIe event IRQ at the end of probe to avoid
> +        * spurious link-state events during controller setup and bus
> +        * enumeration. From here on, DL_UpDown events trigger the link
> +        * IRQ thread to (re)scan the bus.
> +        */
> +       writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_P=
EIE0);
> +
>         return 0;
>
>  host_probe_teardown:
> @@ -2039,8 +2154,16 @@ static int rzg3s_pcie_suspend_noirq(struct device =
*dev)
>  static int rzg3s_pcie_resume_noirq(struct device *dev)
>  {
>         struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
> +       int ret;
>
> -       return rzg3s_pcie_host_start(host);
> +       ret =3D rzg3s_pcie_host_start(host);
> +       if (ret)
> +               return ret;
> +
> +       /* Unmask link up/down IRQ. */
> +       writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_P=
EIE0);
> +
> +       return 0;
>  }
>
>  static const struct dev_pm_ops rzg3s_pcie_pm_ops =3D {
> --
> 2.43.0
>
>
