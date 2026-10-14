Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2C4A6CD4
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016322; cv=pass; b=W4FVlnp+t37zGtp5f/uk5mEZgvKhtMJ/iXgQ9sIovxVg0NQV2d43Sg1K06v226guITw8yOL1TVzC30xK98gcCnUuZo2xjZL9K/wmomgrs7siwzisRsunB/8VFztIpSq2BK4BHlHNDDe9rcOKKI/mW8OJMJsV3Coz9QmCnRGox7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016322; c=relaxed/simple;
	bh=AoA4RIGi8I8W4UWQBE/7vktGmwDPhoKwwf8vTGGICrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jENOBCQfZ8XGfp38Qp9lPOD6AWBxo0B6P8C1lc5gv4n6Z6H6KgRBN8qtxmt7oPE1c8FVgsNmvGw1FDVrA7HzKb0CnJSEPrAWQB406oaHS+IU2RONjf5MobOr/YOfIYvZhW/h+3Up2L18r6EUjX2r52w7K5xGImOnKKXzocPpRmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDXVABDh; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDXVABDh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so3035ad.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 15:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792016318; cv=none;
        d=google.com; s=arc-20260327;
        b=cw/KPgh+eKfkOVi7djVwLAhZCdm7LXZOHYtDPXp8nU8AuWGr4hDVR0JSq8tGfDbDO9
         JB4OZWPxbMuVTtuXggHttrijsDioYNXkHsS/2bOQH0GYzm49CSar3l0eLWFO8jv+Oknt
         K61fFg3r87ahvjo3w0xb/xg2/B7DU4RoeHYP4evlyNHMBl8N+gAVJqAb+Wz7+QekXsxG
         R42Cy4BimzyAcoebri8M/I/mQ8QzudEnpSU5zdYD80vDgaixZjV9JBRb0fMc+BPsk9/K
         Rf+y2b8D8r8b0mpi/AMYc3kofqcavtg8OQ/gtcZF/wAZVZ5IcG8sGtm3/45mydVyEuM3
         jtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        fh=tqdyw/RYEdr/mxf+Rs2crnLxiT0UQG9fc3WV/j9EidU=;
        b=O79dONy+BdnVzaDimV8XZkHYIXxVQNtWFw0ypuTcU/wJgwAaSvkPnaplbdNQkMcTHH
         h6nykSMKzrelhK052pl9I8wt4JPHpJerM8PNxVq5IdHtUQ0G9j8iVAH9JL2oW8wHYXPH
         0O2fN/TW9WNSKBS4XZzw7QeBAXXoqVq3rL0aGTjyN98hM9Rd3njQZkFO0i50uDKY5h9u
         uyphJb9OoVvVp5l/57KR0jECYKRkxu7t/Q60GY8CFIsk96vMIbre8DpSSkIViBSBGbve
         dhxYyPtvxVtmDYiktLKGaD0QgWvT1Be3b4iPmgYfcHCUyDvPraM3kYhVvnguX7tMXhoU
         C4VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792016318; x=1792621118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        b=JDXVABDhncoKOh1dmA2Rcp7me/jY1m3n/gFbNBOnnDXrb5qi8QME4J6lcs0gFc8wfV
         Ux9j7OlggtVyU+P1I3W6Jt3WIcZrklnLOEQjevhgvJPnmTcSuhk/ptFcepYXG9ZCws5O
         RV/4sMWLZ7BzdUVybKl39c2NNCouAEG3OyITWt3EtXIc0suLiDdzI+XGHBmPNoepz0zC
         6AIzCp8gCBiIT08A98ayGdXHRQguxGkcyRw/Wh27Ww4//QlCUJzCLvWnXGxE/jsyR6QH
         ygu+9fmTVgKbDFLM09yjJThIZ7q+NktGsQJP95Sd8+/h92jiXvoIlWL/RpH9Alf3gTFm
         grfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016318; x=1792621118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eY3sf91LWak23dQ/GXfxAKMlelY/K2zut7QOmicKyVo=;
        b=TaZ1as0XrWd0FHJx90f5nXxU0vYNWxw6jnbo4yPt8smcYx9szSAKgyh/WeW6uKQjac
         dPE01WnjSsoxMDzrbhdjNzQT68t8I81dIDoOxGwOh3OaPYoBBLTfF4HYTwZTQz8+ilMd
         uENu7OVbjxLdAYf45KMlbG31emkkjdiAR6DWYouRv62ngCjaz7T3NnC/daYkVslNlDjy
         1onRdCfAyTgxc4ueaH1XyD848cvg34c5EF/1RAI6HJzw0PxszAloGuALOSJCjY9Bd/HK
         4rVpL4F8Ih+bRUqakBHvvaHnJwODOXJsaFk/EJLnHsTp38amAqXmvhnRgB/RTZv7Wml/
         uU8A==
X-Forwarded-Encrypted: i=1; AKwUvByedbFmywWeZ118CdJXlz1JjllkqLEuz49MMksk+rb8t8DvEuCSvXjEYR+1XgkmLnfjcpspXzCs4Fw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqOwZ2nzaMs/hfTGYN8G9piccLiNHviQtM41IZGMO0GmH2Ncg8
	VqqwFDoIWINiv0VZDp8NS2glq0eUZ3DsE6zjU4RsZG7niCNbylA25Ve8Rf2ZRTRLbed3SV7SQHY
	cu+nx15Vue/HhK5CKJniiThaYzhvFQjJnLMsbds8i
X-Gm-Gg: AYBFou1dF4woeYa8SjB0yMKJFdWqRWxChoMhPcydVKtfG8A6hZ2E+nCAZTFX90jRNGm
	YXgEik/CUY8ZoQPJQRaZK01FHMaX4VwAd2aNOIJCtulfviF/sXc7ohKCzcZRDU9r1+IeWbAE2Hd
	wpNIXMSZuUj6PUQsRrqbErKtnvLj1swbUO5gJ2Yn8oRGoP+OFXb/uzLCL7ddVxHzvFd+nSDpdXw
	kzC5r2+lJdnpfOzTAj6HGyF2TmOw/g+FK9/xd6Z5dJVrHPblmL9zeyhXIoOpkkxLmL7aQYqJdd7
	ENfN3Xs8gxELSuvYDRx8ELhXfc13blJRNoqsReDTQ2y522nsLp8m0gE7
X-Received: by 2002:a17:902:e542:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2e95caacd1amr603715ad.1.1792016317765; Wed, 14 Oct 2026
 15:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173106.GA1643226@bhelgaas> <878q40f0oa.ffs@fw13>
In-Reply-To: <878q40f0oa.ffs@fw13>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 15 Oct 2026 00:18:00 +0200
X-Gm-Features: AclHuK-gNlStewG6l-QH68p1JXoWsj7TI1jcaI93dXV8erEDnLAEYXepoL4jjGM
Message-ID: <CAMOZA0+N10HW1VGpMEA94smNdL4VFy-2nHti52U6Fm_SN1OR-g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] PCI/MSI: Implement irq_mask_nowait() for MSI-x
To: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, 
	hch@lst.de, changfengnan@bytedance.com, linux-pci@vger.kernel.org, 
	namjain@linux.microsoft.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:10=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Wed, Oct 14 2026 at 12:31, Bjorn Helgaas wrote:
> >> Skip the read-back that flushes the MSI-x mask write. Parent domains
> >> that mask on behalf of PCI/MSI continue using their own irq_mask().
> >>
> >> Signed-off-by: Keith Busch <kbusch@kernel.org>
> >
> > I assume Thomas will review/ack the pci/msi/ parts.
>
> Yes. I actually suggested that "nowait" mechanism to Keith at LPC.

The topic also came up around last December. The readback wastes 1000-1500n=
s
under load. I hacked a conditional in pci_msix_mask()
https://lore.kernel.org/all/20251220193120.3339162-1-lrizzo@google.com/
and you suggested a callback irq_mask_dev calling pci_irq_mask_msix_lazy()
https://lore.kernel.org/all/87jyxqiuta.ffs@tglx/

As usual naming is the hard part...

The mechanism is definitely useful (with moderation the mask is a frequent
operation, so saving the extra 1-2us per call is measurable).
I was a bit worried about adding yet another callback, but there are
already 30 or so,
hence one or two more does not make much of a difference.

On passing, on ARM this will not help unless we partially revert the
optimization
that skips PCIe if the interrupt has MSI_FLAG_PCI_MSI_MASK_PARENT
https://lore.kernel.org/all/20250517103011.2573288-1-maz@kernel.org/

> Though I hate the name of that callback because irq_mask() does not
> really wait. It guarantees that the mask store has reached the device
> which means that after that point no further interrupts will be sent by
> the device (assuming sane hardware). That means it's a synchronous
> operation which involves flushing the store, so maybe irq_mask_noflush()
> or irq_mask_async() might be more accurate and descriptive.
>
> > Cc'd Luigi since I know he's interested in interrupt moderation in
> > general.
>
> Correct. I'm curious whether the interrupt frequency based moderation
> mechanism Luigi is proposing does solve the NVME issues as well or can
> be combined with some device specific hint mechanism.

I really think we need both. It depends on what the issue is:

- for hardware level problems (backpressure on PCIe from the interrupt
dispatch pipeline)
  we need to actually disable interrupts at the PCIe sources, and
address the problem at
  a global SoC level, not on the single device (NICs, NVME, VFs used by VMs=
...).
  I honestly believe something global like GSIM is the best answer,
because the alternative
  of having all drivers implement moderation and coordinate the delays
would be hard to manage.

- for pure CPU overload due to e.g. excessive interrupts from a single sour=
ce,
  GSIM can help a bit (e.g. preventing livelock, or cutting some
10-20% interrupt overhead),
  but driver specific solutions have a lot more visibility on what is happe=
ning
   and may possibly do a better job. As an example,
   Fengnan's solution not only moderates (or does timed polling, GSIM
has that too),
   but can also dynamically switch completion processing between
hardirq and softirq.

   https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@b=
ytedance.com/

cheers
luigi

>
> That said, Luigi's approach should benefit from the "nowait" mechanism
> as well.
>
> Luigi?
>
> Thanks,
>
>         tglx
