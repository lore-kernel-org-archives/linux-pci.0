Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC035975
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481918; cv=pass; b=LBsh0JkfPjHgNvT240X/9S32tFO9NLAqJsDuUoX98edbSObW2bHcj17tPLMOF7AO5qlONB5F0FYQCeRCLD7Fr/di484t5q3V/ow0lyJgm+r01lOApKbWoEMsPB4vrkVeUSV1CANiQcr82x4dM7khNLMRfZ4rGSRdJEjtyXUmWno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481918; c=relaxed/simple;
	bh=97cJOwK3KCzHfauaYQfhuSYb6J7hf4uXsLX2UHCLHkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuKOsUc79owLqs1m5V3sGqBNo8VUbGkPpsm1tQ2rUQGgg91NqIYyQ44rLhh2BuQ2NlxCaUP3qnmGY32b6WArE1sgRXYevkWCzAVm59uPK++0pe3Ev9SzEFoiUy1gITLJk4OMrOVvr/B7b+EnjCH9XlOjF12ODz5T0NcpXYtoQ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iE4xpIbs; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iE4xpIbs"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so3608064e87.1
        for <linux-pci@vger.kernel.org>; Sun, 10 May 2026 23:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778481915; cv=none;
        d=google.com; s=arc-20240605;
        b=IIbbm+4oQ3QtJNjWvUumZU7laoX9psb/dgTFwnCV6avx31b6cKvBjyoRKNWLsa2DsD
         /mIdqDA/yA+MybTKQmHMAWziTKpgl4+1QpE7UJXF9bfGsqbswPCjwDWGaasGH+luvLf4
         tSjFxlsmFbdnW+bPiDt8rsMQYm3vByNQ8bWxMl2vkWkFyMuOrAklMixqKM9N/DVWpRj0
         jsDwuopSgGX6dtIptjcftNuFMuc6btlwqOvOZ10DwBO+LZb9UqKSQP133o++kUSPKxNw
         SH52Lv9+1eIFO+YOKtfq+AMvoHDucpKyVUuPYVV3SiUHSqD2Ju9gtzQFEAlNC/mrGQ6p
         XvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMPlEPi9zf9RVpC6UEP+/+vrS9JgpaFFDnRGG82wjDA=;
        fh=QdhIDWiwxlcL1884ITP/mcjlzeo+qogBsKxF+LZAApQ=;
        b=HhBR9GbPsxy7urOmqY0v8MY9mBM48MRGgPbBmNE93nLRULXKYeFP3YEJxDenXxowAW
         8sm67bmr/qL2ASnjqY1KI2qMfRU0UZqIGBXqWuAP8t4kGv2SS0paurCMVIsuJTeTqskw
         Jyby0bI0TtkvJAuDmvt9A846cedMakXirOYXaMR3s+F4pn08CBkWevD0Z7NzaynrAIJ7
         0SGBbaN3xOMdPbGstIV4hvvPN45tlYfW4GMTXGH4XPV4YxTn5uJjZ0nYBB85WP+buMIv
         c8i5VEP6fyhMwPzqe2+wZ2yfMtXqbAR2/wgyA2uYBkfYADBTV+osVz/jocuBxN64cI7r
         +Yzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778481915; x=1779086715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMPlEPi9zf9RVpC6UEP+/+vrS9JgpaFFDnRGG82wjDA=;
        b=iE4xpIbs+VRxBfqOWkEuTwfCPU+DHiqttEEpX9asyM/9a4yWTcXwGc6De0pWrp3CUL
         HRy9PlDJ33jrfKGkTFGMHoIy54V3oirnIBPgMPllOlhBSlIOv4sBXohy+1PdKnnhbxyJ
         3UascmovJDarJKgvo+G0rPoqS95vqumVMRJv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481915; x=1779086715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMPlEPi9zf9RVpC6UEP+/+vrS9JgpaFFDnRGG82wjDA=;
        b=Odg9yq5wTX+urenBtV7EGNIMkywS/y/k8KCLW3Gh3XYthOzp/eVWftcVgW/edEvJPg
         XAShkFh7DeSjczM/eKKJzBnGPULayGx+UYzuhgKESsrIswE+U3/+Zt3yrgKhDay5yPOB
         jcbHjrrddQr/HtOnK0lEt6o+jhcE6OPQq2e4uLYYIUnDPHnYSGfUrqba0MF48JAYjWRJ
         a1QPVDsyaoOYS6aHHGM8B9fxPu0/C3LYxdap7c0mUI5xhof/vl4GEV1zDSOEqN5w906W
         rR1BDg1ro0aNJYT9O5fVMEGlxMO2ggBw1+/MxVTWuFr+Y9nXjXW7XVHwgBHZftPillwi
         yy1Q==
X-Gm-Message-State: AOJu0Yz/EN9JSBCJXyK7YmOwL52aOx3WcoK4wRGOiOXVHPBUXdjBhNjt
	ZK2/rtL+dSwuzP3F1G1nVeocZ1hRk5RtXsmseKTPwZqF5TKhfl2yaH0SVALQZLngHGO63KOArDt
	Omp2tueDtYX0RiV1BVM+Ovopaafb/bp5fhneXZ3ILBRmV2vLoxfA=
X-Gm-Gg: Acq92OFSDW/532sXPNM7ryui0DQixm2UTR70VW88kET5n+/srA9hBGM2ZSOVLIPeWm3
	XXLGMdHQbmlZvm/afl49msI8qnwB0VpjQSO6EsZkDtgwZXX2R117/zLTmoqs2yvR79nkHzl6Rmr
	gdG8K2f1Homy8XnajdMwPyrzM1+BybmmSG1UGlgkwENqMoOzgO0IW+FsrKqozA1apug1+Nqs6y6
	UdTm7fAYUCK3yz0O6irV3V9qMPAzESVIErAuzL+bHONs4eL14yWu2U6i6eQCSBueZIv4v8zkU2F
	bwSA1VF36yHUd3mUsE6BikOTQfqblM3BjfvrFA==
X-Received: by 2002:a05:6512:158e:b0:5a8:63e0:971b with SMTP id
 2adb3069b0e04-5a887ceaff8mr7299552e87.35.1778481914968; Sun, 10 May 2026
 23:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505105918.1823170-1-wenst@chromium.org> <20260505112419.B9151C2BCC7@smtp.kernel.org>
In-Reply-To: <20260505112419.B9151C2BCC7@smtp.kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 11 May 2026 14:45:03 +0800
X-Gm-Features: AVHnY4KR-6Tf06R_RWua_y8Uai9EMagjSCzvJrMvpn9ggprlRnV50GcWLq8tPyw
Message-ID: <CAGXv+5Gp90XUHNk7S+ePJmymrHeLDagw+s604FZjKWZgDS49XQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: Do full device power down on removal
To: sashiko@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FTR,

On Tue, May 5, 2026 at 7:24=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Asserting PERST# and disabling clocks before deregistering the i=
nterrupt handler introduces a race condition that can cause a bus fault (ke=
rnel panic).
> --
>
> commit 392cdae7adde07f3a5a5cd47d941a62a1d778a2b
> Author: Chen-Yu Tsai <wenst@chromium.org>
>
> PCI: mediatek-gen3: Do full device power down on removal
>
> This commit updates the driver removal path to follow a proper power down
> sequence for downstream devices. It calls mtk_pcie_devices_power_down()
> on driver removal so that PERST# is asserted.
>
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index b0accd8285892..e6acca7e79a0f 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -1260,7 +1260,7 @@ static void mtk_pcie_remove(struct platform_devic=
e *pdev)
> >       pci_remove_root_bus(host->bus);
> >       pci_unlock_rescan_remove();
> >
> > -     pci_pwrctrl_power_off_devices(pcie->dev);
> > +     mtk_pcie_devices_power_down(pcie);
> >       mtk_pcie_power_down(pcie);
>
> Could this sequence cause a regression by introducing a race condition
> with the interrupt handler?
>
> Calling mtk_pcie_devices_power_down() asserts the PERST# pin, which force=
s
> the downstream PCIe link down. This can trigger a link-down or MAC error
> interrupt at the controller level.
>
> Immediately following this, mtk_pcie_power_down() disables the transactio=
n
> layer clocks via clk_bulk_disable_unprepare().
>
> If an interrupt fires during this window, the top-level chained interrupt
> handler will execute because mtk_pcie_irq_teardown() hasn't been called y=
et.
>
> If the handler attempts to read controller registers while its clocks are
> disabled:
>
> mtk_pcie_irq_handler()
>         status =3D readl_relaxed(pcie->base + PCIE_INT_STATUS_REG);
>
> Could this cause a synchronous external abort and crash the kernel?
>
> >       pci_pwrctrl_destroy_devices(pcie->dev);
> >       mtk_pcie_irq_teardown(pcie);
>
> Should the interrupt handler be deregistered or masked before the clocks
> are disabled?

The driver only handles chained IRQs, i.e. the INTX and MSI interrupts.
By the time this function is called, the downstream PCIe devices should
all have been stopped and removed, meaning all chained interrupts would
have been disabled already.

ChenYu
