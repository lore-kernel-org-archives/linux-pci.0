Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774A3C553A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745284; cv=pass; b=XbptUMPIlmYGTyass+5YjycZXTZkmC9VTM8co/DrACBgAYZVRk7QIHXLLRazAAYlNiGgTzVtVd1VVTX0lOD1+yxSKI/M3lK4mcv8WUeWVNTK5U/2pAEyn4r1VF1lhMhXZ8Y9PEJdgjxfgjS+m8X/vKbfEECcB6RRLHyeIHag5ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745284; c=relaxed/simple;
	bh=Peu3vBUCBh0f1zerPCNNUt5rFHVtmuDuEYHbyCMoE1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC0z0kPpuBgme3Z9nbJBRTDoIJGcyhLseZ2rapHwSI7Q+wSuLt5tv6c+zwPs5vs6LM8DJ9/sibP6Gcu+vU55zoRLTSyMZ4Z4TNM1Kv02IkEobvLM1FxXPamY9PGpHrgcKFLZR636K0vOPoafgSGFncwlomQgdvkKxQUEPjifLTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fk5rYuUa; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fk5rYuUa"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8891febd2so9220672e87.1
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 00:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745281; cv=none;
        d=google.com; s=arc-20240605;
        b=YVta15rx159LSGcSoVvQ7u8B6aH4GIxK12aA9stnlsksUFSnBTiQ+2uiSBrn5I9AxS
         1EV57g8mnUcOOu6frIIjo4T8Fdl4BsMddCH/LZtNQoUKh4ER1S5HehgUVTqn9XgUlVsE
         Lt2ph2cxqUvV6bgo4RAxDFAhr7GHwNXd3IenFX765vjwDuTVuYcFEvdLaiB/3L9szI4O
         K80O95k7ouIG8FALgig5eUN5Ivd6V+MTrYVTBP/02AtRVVzBV3pTQnc/oVhsYdC/sJcu
         GUBce7kf6dAF3K0SgYidI+hCLE1VRQueG4wTQbipMfRMFq6EwP77wzc6mBoKsVEvOgD7
         L8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XR8EnK64dtfqn5p2qNUwy1xl1ufX9OqaX2p8lb+U5Dc=;
        fh=zXRFv+wJTon+WAcKYpvDZz08QPEwTWGcvvdPtL+UOuw=;
        b=k7Slexxg9hgEx06xAXsGSbYa1zibKaT7YrC++ZBoqWoMwOOAYOc1L/lzt18yfoalws
         Wvzf/CgqOsVK8BQNvM/5zgO3Wpwd61NDHozMn1RAUdtD8c1iyPkFWQzoIpGS4TltQgso
         ThsS6QjEZrTRHlTGjsOquUiw+18Gwl+Ftin81J2FTawOFuz9TrMCpfZHTM0YdLHFeNpT
         vLHvqRQ2n0WdZkTq+YqAYV3GpVjy5RCwt4OYKKjTdYxXuAe61jDqOCUdLBjdxcM2Iam7
         rLADSp6zkOJvfDPZ9SO5HjEmsIbBJHvMVVGtsvIlD97NDssZhR/JcxsOD7yCyVENsULH
         sIUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778745281; x=1779350081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR8EnK64dtfqn5p2qNUwy1xl1ufX9OqaX2p8lb+U5Dc=;
        b=fk5rYuUad61a/xL+GW2MGdf6aLzGI6CgqHre6u4WBZHXW+Qs8NKX6z7x3fnVha+DV+
         Ie+/dYms9qma6oka8Fq3PyH7B2hLfSZxyqgTP8W1boR/WixraI0YaGK3xqAii1ip0neX
         b+BxLIvSWoQtd4q0vyqcNPRsVAP6g04W6wzs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745281; x=1779350081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XR8EnK64dtfqn5p2qNUwy1xl1ufX9OqaX2p8lb+U5Dc=;
        b=UXSzzXBYPL4co/irX8m3rId7Xltp6p+yI/8nUi+eoL98diE1qMMpTtCLnYYw5cHV7l
         hZh6gpzIfHzz5MezRjZ21eiTcj4VKYbyivC90R5llk9uwXtzTEKCC6DbpUdG0jv+C9rc
         No1cpqASU/2kIb321bj2xXXjG0Gm8QpMZSMMQzgyk/hAm2Ey5SDxyLVkc7tvDKxOGw6Z
         c2tHPFLm+R4BXNk0QrjlVDOYDPBjOFXJ/4VzQXXqDrvT0SpG1CdY1Es756wl2jS/bnxg
         45qeNzURi/PVfCAHkqAGW7JvfggYYqMgpYFU1dYBgMyMbMpC+X4wc9425WUJZLt+Ig7C
         TpSA==
X-Forwarded-Encrypted: i=1; AFNElJ+y+U4CFN/pK2jFyYOJ08EJ0RT70Me/jc1kxAOBTNyoAhdWPnR8w99pL5/BFI11vpSmCJjoJ4a6lfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nIvWyvX0g0lrZscdL2XQhq8dZEAA2D7p2ylKW4Q/8Pi0djO7
	8quoUxJ2zERipuK+sW3CUmIcmyN4wi4MF9Iii+qLbLHMSSbBMb9j/8d0KzgBhGAP3pa5TXBUaKu
	BAUzfYfA1yKUeMdfhQUYnwF0OUSrJnmrQ/+pZjsmI
X-Gm-Gg: Acq92OEsPwvh2a5tin30vyn+Vf9belhBW4TId9f8ZqRJKTlHye46073us7MSwY7oN4M
	Nj5ouaHt7JM0Qm0iCF440ZfzjeZtsfA+Y9jzTZ6E22MCgFJjHZo/dzZ3CP2sFOnGlmebsdjsTOd
	2lijaeEflHwmCUZnLmMR0WwnyV1vcLhSU6+eV+YTv3+PMHwsUFbBVvurdTo6tb37URIL+R9I7Y7
	b7y4o1dnirp9FhTxEQvQfmXwWnITLHovNG7xVo7DMX++3rqqhqW2RBdSCSqajrIMcm+RPZkTSYL
	QI+ymaRAkUVhTAAkO/Wxw/feDqgI6vBx81LtRQ==
X-Received: by 2002:a05:6512:1307:b0:5a8:e363:6f7e with SMTP id
 2adb3069b0e04-5a8ef947b4amr2826701e87.17.1778745280832; Thu, 14 May 2026
 00:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
In-Reply-To: <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 May 2026 15:54:29 +0800
X-Gm-Features: AVHnY4I-K0fe_Bfh0y4hR9dkGGPUD3Wz3qssE4qO52Iohr3iuH-UNE1unWWNmOk
Message-ID: <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:23=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > controller memory access could be limited to a small region by the
> > firmware configuring a memory protection unit. This memory region
> > must be assigned to the PCIe controller so that the OS knows to
> > use that region. Otherwise PCIe devices would not work properly.
> >
>
> So this means, the PCIe devices can only access a specific carveout memor=
y
> configured by MPU for DMA? If so, you should use 'dma-ranges' as suggeste=
d by
> Rob.
>
> 'memory-region' also serves the purpose, but for PCI, we have the dedicat=
ed
> 'dma-ranges' property.

I think I need some sort of guide on writing the 'dma-ranges' property,
because it is not working for me.

I'm adding

    dma-ranges =3D <0x42000000 0 0x00000000 0 0xc0000000 0 0x4000000>;

to the PCIe controller node, and dropping the memory-region. The WiFi
driver subsequently fails to allocate buffers:

    rtw88_8822ce 0000:01:00.0: enabling device (0000 -> 0003)
    rtw88_8822ce 0000:01:00.0: failed to allocate tx ring

This is dma_alloc_coherent() failing.

    rtw88_8822ce 0000:01:00.0: Firmware version 9.9.15, H2C version 15
    rtw88_8822ce 0000:01:00.0: failed to allocate pci resources
    rtw88_8822ce 0000:01:00.0: WOW Firmware version 9.9.4, H2C version 15
    rtw88_8822ce 0000:01:00.0: failed to setup pci resources
    rtw88_8822ce 0000:01:00.0: probe with driver rtw88_8822ce failed
with error -12


Also, using memory-region seems more straight-forward: I have a region of
memory dedicated to the PCIe controller. I describe the memory region,
and assign it to the PCIe controller.


Thanks
ChenYu
