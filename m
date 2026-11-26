Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673317;
	b=xeFUBbgFumxIUFXDlPJqzcjHG0XxTpmspJsW7HXoGavS+Zj87dZhZsDWhoqzsIB0GCxW
	 5cpgLKjffZ5Bdf3EKo0x5SM0o+tz/PR8VtTE8F9kex2zPG/mQWfWHPMsoBkBXf3gaXb+A
	 x2QAkFoj75NjZRjy869vRPZy08LFKkiryvflUlSm9SJfI70Ov+k5OL7bKlfcEOyJTM1ri
	 9wab9C4f/L/cv5HQOmi5tzSc+6PD/DCoeddKGmtLeSgZtBuHPQ06snZYtfbLjKmgFHkgN
	 bHi9Ai3OJWg4D4e2VR+tFaxV4+/j0i6bGFsKGuA/jpqU/849luOXPcPwuJXnreoQJ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673317;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OlqIcjiayRsUtYpoeNZkwmrbEBPqqT/RvAPJg1txEMI=;
	b=THAzzs5sqCS7BJyhjxbk/OLXZgpTVIf14sCX5HZ9zj3lTjd3XW70Ct59a+Ko2faetFw0
	 dY0cECAtpA8ZN7mwnzk+xnRrgkACHoIZ+5dFArnzl8LeJtits3tJ/pLhJwxLm3kC+XRbR
	 rgNq3wJA48mfRrvrHaYt4TFZBov+hd9cbUn7vN0OMJK8Q8Bux6mkx91pASRWc99Rbd8dh
	 E3Vtm73jyDHDWdNCgn60YAX4b03VbXTpM4WFW/+F5YjoPYRHEsG8evAr/XLWc3cJQcIov
	 lcWLhr86UPHsOqs7kbfOX4CDO+3y2JlkuaXlNAdz+kqgQ4MheUf1W07/07FDabDi7Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b="Y/2gJW/D";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wj+5LEq9;
	arc=none smtp.remote-ip=103.168.172.143
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DE606A32D
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 06:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4DE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=Y/2gJW/D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wj+5LEq9
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 83BDB138069E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 01:08:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Nov 2026 01:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795673315;
	 x=1795680515; bh=OlqIcjiayRsUtYpoeNZkwmrbEBPqqT/RvAPJg1txEMI=; b=
	Y/2gJW/D3vTnDJk8Vgq+SFodx44867q7vY8ogBqUXSgqf8N9vHItfM8sNEShuzxd
	5nTaZ13riRegcN9Tnbl0DDJCTcNZxcca1kU0f7Yal+GtLLL4HHBxJpXnWJ0XVjcc
	h+GpeYAAG2gDEdwqdwY3l27OKKdeRqRjvCuwhril8ngtjPFMEGeRG64HgHBTlNVk
	0HVxg7whD3hwvb1R0p2QRr1ENWQ5tkLbeuGAmSObk4/txfA6A2rgCSodg1aGJT/T
	cZmRakQmaCycN6AjHGgabvmRRHKFbMNmuIBt6DfDhihMBEdM1M8ZerjFoFqFv+1Z
	gP0dns5nrwtCG7yKXFOQ1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795673315; x=
	1795680515; bh=OlqIcjiayRsUtYpoeNZkwmrbEBPqqT/RvAPJg1txEMI=; b=w
	j+5LEq9ltIC3mZgjN00vulQlBhT60VkkvWVS7OPJzG/czZqgyF7VV8mLajbZAiQx
	7nUcGi2Y6+VfMZljpH/X2/qLaOBCa3KJ/blghJ4cMM1//U3Tn9sPmyilNgCQI9Ow
	fuXYp34foYfpFWAAPLgAELo5hCKD6Djy92w5yxsaFnHlbQuw/BTU/WnNjGf+89cR
	B3J0/dviMigvMtqHN1cTqOe2q+ufvt1n9fwRF3KNkMt+3dJioHL9vDcbz9lu8m6J
	km6j37RjRM7IStf/gXWCYMdAZrPV0uCPyyR6g2OPsd9Hitn3vY2tp3eH7RrOjj7x
	r59oLNjcI8hN5t7YqB5PQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795673315; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JYdxNAiLz5NVFFJdQxcnxKixVMiDe+z0pJ6wM5A6SZUqU1s
	bZt2TV3uRAGDV8x6jYOVms3uebhTvNC6nZl6HVtsLlcnEt+p40OYKUYmhw6hugW0
	uF/WI6PPpwZcaGk5piBAUv5GzhemRhABHUaazvWXlOGCeC5oHuTpTeAhXvMrHMix
	D90vo8WLK3Mfes3O+juYbR3pkXWRZ5EaXkKwsl3u4Afwi5oBc0OuSjwk5Fsyw7mw
	1jg2L80VQJT9vcqs0hpBwcs0S22j1JQYXM/DG2co7K7z4drbwLJwuk09U049lNjr
	ZyfD8mCrvWkmUBb5jvfpavn180kdFMSuTwt0Qzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZwiqwLbTKsqev7qLRhdGKuqlcUPCKb2M64FoQiyCXkE=:onXiofhsw28hLL8h2Jn7CqrTijcxJ+xdXI6ZsCEvOVo=;
X-ME-Sender: <xms:4swHa2sz1eZSKITGvPnFmgZ3JG7rN21TGEtm1mLYrKBRBoSup6Ki9w>
    <xme:4swHaxSeQzVcutmYEcNR1grgw0q0pH0IbRbZT36-JiE7m84W7mY9aW2L-DE6FR_9p
    PYS3igdoAjQhOQs4UP64gHaUcJykCfZNQXJ8-3wMnP-O-i1ouQ4ikw>
X-ME-Received: <xmr:4swHaz1csqX8w1oKyodwAB-V6g4MLRphlhiC1rwSW9bC7X5SUaWXsCsEv27WSw>
X-ME-Proxy-Cause: dmFkZTGnfL3rTnYkc2JVcLxAqQLhOkg7VINV1D77Trh4Ih8apo2IbqKGfR4n7R2YS3J5On
    OHNx7TlOVXiZmy9dtheM3BFn8d8NIGVWFRgNf1ZVo8nbYJat2S8d7X7QNWjj85qQVQAUtc
    +2isW3wlkm2nEP+byDStjbnYDSjboS7OWZyEHntnL8erBKc6xcOkVE5ETxQIBBoh56oKhk
    vEzPndJg0SYqaSnwTlqj453/4as+lGlPGHx7TR8mL4fdYetQIRhPjwqoRRf9TmK1yZ5fxi
    5OCultlFEAqRfoOqvU09p7whk0kQq8mIqhEya/PasWvsfCQyYB31i55580vXIMQanNnxeJ
    pFRz9cuIAradCuOn/sblXO0nvrAzm3Lrl4r2UNaf73JVhd3iRH7jgB9AkQp5qFKrlCwyDj
    NU9mOIFTj7KRdc+e/nR/3vw2/Hr8TrbcjLV2/tKRb9y/WNcpKsT+PDcEpDYfoCY0R+5Vww
    0vOHFscezQdM7HHoNQt2hc4n42fkTobwcMFFiIjuI727K23EaGWrIzK726+t0lbiUSfXG8
    Ple2xdSAhZkfbNi52P1PSShRSf5P7Fpc8F55e4UfRFQETgm+rMlNvqNsrMfHIlksbOgdHL
    gZJ2aezmRavQIV/XyWfqvvuNYWgP/VukKujEyKawnQgG04RYmFfAb4FVI51A
X-ME-Proxy: <xmx:4swHa5wqrawIp5ohZJmM0Ruo8ah28vtOtAM4MgGHT7TKUNIjZLI0Zg>
    <xmx:4swHa2FcgQwXTOE0VG5gU3fvMdh5CSEx0TX6VU2JeKqltCl5mmsNqQ>
    <xmx:4swHa3gAKZwLxBNSmYlSQYPWWZjwd61ez2ZbfHoieJ0YMX0S1W8eLA>
    <xmx:4swHa5psIP_-a5NkI-OORpuua5XWOhDL3rW3_2JdNLGy0wthSKYdbQ>
    <xmx:48wHa9BUbKCXAn4bga9W4cOcgJVrZzznvOHdK2uq6rL3N_Dyzey5HF3d>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 01:08:31 -0500 (EST)
Date: Wed, 25 Nov 2026 23:08:30 -0700
From: Alex Williamson <alex@shazbot.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, boqun@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org,
 alex@shazbot.org
Subject: Re: [PATCH v3 9/9] vfio/nova-vgpu: add the Rust VFIO variant driver
Message-ID: <20261125230830.48e768b7@shazbot.org>
In-Reply-To: <abc4a0e3-2478-4b12-8a06-ffc81196bd20@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
	<20261119215046.2892839-10-xinmengs@nvidia.com>
	<20261124201931.55c65263@shazbot.org>
	<abc4a0e3-2478-4b12-8a06-ffc81196bd20@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 21:45:13 -0500
Simon Song <xinmengs@nvidia.com> wrote:

> On 11/24/2026 7:19 PM, Alex Williamson wrote:
> 
> >> +    fn bar1_size(&self) -> Result<Option<u64>> {
> >> +        let Some(instance) = &self.instance else {
> >> +            return Ok(None);
> >> +        };
> >> +        let physical = self
> >> +            .registration
> >> +            .pdev
> >> +            .resource_len(self.registration.fb_bar)?;
> >> +        let size = instance
> >> +            .type_info()
> >> +            .bar1_length
> >> +            .checked_mul(1 << 20)
> >> +            .ok_or(EOVERFLOW)?;
> >> +        Ok(Some(if size == 0 {
> >> +            physical
> >> +        } else {
> >> +            size.min(physical)
> >> +        }))
> >> +    }  
> > 
> > Does this provide a power-of-two size?
> >   
> currently it does not, we can add a check for is_power_of_two:
> --- a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
> +++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
> @@ -120,6 +120,9 @@ fn bar1_size(&self) -> Result<Option<u64>> {
>              .bar1_length
>              .checked_mul(1 << 20)
>              .ok_or(EOVERFLOW)?;
> +        if size != 0 && !size.is_power_of_two() {
> +            return Err(EINVAL);
> +        }
> 
> on a side note, i think vf bar1 of 0 can be a valid case too, so i should remove that check in next respin

The real question is whether the PF tells us a power-of-two size based
on the vGPU profile.  If it's expected to, this is a maybe a good
sanity test, it if doesn't then maybe we'd want to extend the BAR to a
power-of-two size with a sparse mmap to indicate we can't map past the
implemented size.

> >> +
> >> +    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
> >> +        if buf.is_empty() || position.region_index() != self.registration.fb_bar {
> >> +            return Ok(());
> >> +        }
> >> +        if let Some(size) = self.bar1_size()? {
> >> +            let offset = position.region_offset();
> >> +            if offset >= size {
> >> +                return Err(EINVAL);
> >> +            }
> >> +            if size - offset < buf.len() as u64 {
> >> +                buf.truncate((size - offset) as usize);
> >> +            }
> >> +        }
> >> +        Ok(())
> >> +    }
> >> +}
> >> +
> >> +impl Drop for NovaVgpuOpenData<'_, '_> {
> >> +    fn drop(&mut self) {
> >> +        let mut state = self.registration.lock_instance();
> >> +        state.active = false;
> >> +        drop(self.instance.take());
> >> +    }
> >> +}
> >> +
> >> +impl vfio::pci::Operations for NovaVgpuOps {
> >> +    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
> >> +    type RegistrationData<'a> = NovaVgpuRegData<'a>;
> >> +    type OpenData<'a, 'data: 'a> = NovaVgpuOpenData<'a, 'data>;
> >> +
> >> +    fn open_device<'a, 'data: 'a>(
> >> +        dev: &'a vfio::pci::Device<Self, Open>,
> >> +        rd: &'a NovaVgpuRegData<'data>,
> >> +    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a {
> >> +        NovaVgpuOpenData::new(dev, rd)
> >> +    }
> >> +
> >> +    fn ioctl<'data>(
> >> +        dev: &vfio::pci::Device<Self, Ioctl>,
> >> +        rd: &NovaVgpuRegData<'data>,
> >> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
> >> +        cmd: u32,
> >> +        arg: usize,
> >> +    ) -> Result<isize> {
> >> +        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
> >> +        if reset {
> >> +            if let Some(error) = rd.state.lock().reset_error {
> >> +                return Err(error);
> >> +            }  
> > 
> > Is a previous reset error effectively unrecoverable?
> >   
> yes, currently the behaviour makes reset error sticky, we could make the the vfio driver to be able to try again, 
> so errors in reset_prepare would be stateless and allow vf to try to reset again, something like:
> 
> @@ -171,14 +170,8 @@ fn ioctl<'data>(
>          cmd: u32,
>          arg: usize,
>      ) -> Result<isize> {
> -        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
> -        if reset {
> -            if let Some(error) = rd.state.lock().reset_error {
> -                return Err(error);
> -            }
> -        }
>          let result = dev.core_ioctl(cmd, arg)?;
> -        if reset {
> +        if cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET {
>              if let Some(error) = rd.state.lock().reset_error {
>                  return Err(error);
> 
> @@ -260,11 +253,10 @@ fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
>          // close release this mutex before entering the VFIO core.
>          let mut state = rd.state.lock();
>          state.resetting = true;
> +        state.reset_error = None;
>          if state.active {
>              if let Some(vgpu) = &rd.vgpu {
> -                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
> -                    state.reset_error.get_or_insert(error);
> -                }
> +                state.reset_error = vgpu.api.reset(vgpu.gfid).err();
>              }
>          }
> 
> this also remove the hot-reset check and address the comment regarding intercepting hot-reset:

Why were we trying to make it sticky?  I don't know why this is still
trying to handle a hot-reset.  A hot-reset is a bus reset, we can't bus
reset a VF.  Reiterating reset_prepare comments below.

> > vGPUs are VFs, why are we intercepting hot-reset?  That's a different
> > class of reset that VFs don't support (unless we're running on s390).
> >   
> >> +        }
> >> +        let result = dev.core_ioctl(cmd, arg)?;
> >> +        if reset {
> >> +            if let Some(error) = rd.state.lock().reset_error {
> >> +                return Err(error);
> >> +            }
> >> +        }
> >> +        Ok(result)
> >> +    }
> >> +
> >> +    fn read<'data>(
> >> +        dev: &vfio::pci::Device<Self, Read>,
> >> +        _rd: &NovaVgpuRegData<'data>,
> >> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> >> +        buf: &mut vfio::UserBuf,
> >> +        position: &mut Position<'_>,
> >> +    ) -> Result<isize> {
> >> +        if let Some(instance) = &open_data.instance {
> >> +            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
> >> +                let offset = position.region_offset();
> >> +                return position.with_temporary(|next| {
> >> +                    let count = dev.core_read(buf, next)?;
> >> +                    buf.write_overlapping(
> >> +                        offset,
> >> +                        count.try_into()?,
> >> +                        u64::from(bindings::PCI_SUBSYSTEM_ID),
> >> +                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
> >> +                    )?;
> >> +                    Ok(count)
> >> +                });
> >> +            }
> >> +        }
> >> +        open_data.limit_bar1(buf, position)?;
> >> +        dev.core_read(buf, position)
> >> +    }  
> > 
> > Why do we virtualize the subsystem ID on read and the device ID on open?
> >   
> 
> This is done intentially, as core viratualized it in vconfig, where it is set
> at open, while the core read subsystem id from hardware, will add a comment: 
> 
>  // A VF has no device ID of its own, so the core keeps it in vconfig, where
>  // it is set once at open. The core reads the subsystem ID from the hardware,
>  // as a firmware update can change it there, so replace it on every read.

Right, I'd forgotten that device ID is virtualized for this purpose but
subsystem ID is not, so we require this split.

> >> +
> >> +    fn write<'data>(
> >> +        dev: &vfio::pci::Device<Self, Write>,
> >> +        _rd: &NovaVgpuRegData<'data>,
> >> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> >> +        buf: &mut vfio::UserBuf,
> >> +        position: &mut Position<'_>,
> >> +    ) -> Result<isize> {
> >> +        open_data.limit_bar1(buf, position)?;
> >> +        dev.core_write(buf, position)
> >> +    }
> >> +
> >> +    fn mmap<'data>(
> >> +        dev: &vfio::pci::Device<Self, Mmap>,
> >> +        rd: &NovaVgpuRegData<'data>,
> >> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> >> +        mapping: &mut Mapping<'_>,
> >> +    ) -> Result {
> >> +        if mapping.region_index() == rd.fb_bar {
> >> +            if let Some(size) = open_data.bar1_size()? {
> >> +                if mapping.region_end()? > size {
> >> +                    return Err(EINVAL);
> >> +                }
> >> +            }
> >> +        }
> >> +        dev.core_mmap(mapping)
> >> +    }
> >> +
> >> +    fn get_region_info<'data>(
> >> +        dev: &vfio::pci::Device<Self, GetRegionInfo>,
> >> +        rd: &NovaVgpuRegData<'data>,
> >> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> >> +        info: &mut bindings::vfio_region_info,
> >> +        caps: &mut vfio::InfoCap<'_>,
> >> +    ) -> Result {
> >> +        dev.core_get_region_info(info, caps)?;
> >> +        if info.index == rd.fb_bar && info.size != 0 {
> >> +            if let Some(size) = open_data.bar1_size()? {
> >> +                info.size = info.size.min(size);
> >> +            }
> >> +        }
> >> +        Ok(())
> >> +    }  
> > 
> > BAR sizing in config space also needs to reflect the virtualized BAR
> > size.
> >   
> right, the BAR sizing through config space still not handled in this version, sizing through
> config space will still return the physical size, in the next version, i will add code to
> return virtual bar size to match what region info reports.
> 
> >> +
> >> +    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
> >> +        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
> >> +        // close release this mutex before entering the VFIO core.
> >> +        let mut state = rd.state.lock();
> >> +        state.resetting = true;
> >> +        if state.active {
> >> +            if let Some(vgpu) = &rd.vgpu {
> >> +                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
> >> +                    state.reset_error.get_or_insert(error);
> >> +                }
> >> +            }
> >> +        }
> >> +    }  
> > 
> > This seems very wrong, why are we calling the PF driver reset in
> > reset_prepare()?  Isn't there still an FLR happening between prepare
> > and done?  Does it do anything?
> >   
> It will not reset the PF, vgpu.api.reset will reset this vgpu instance behind this VF,
> the PF driver would ask firmware to reset the instance and scrub its memory, then FLR
> follows

PF reset is not the question.  We're calling into the PF driver to reset
the VF, but we should not be doing that from reset_prepare().  This
also still doesn't explain what the FLR that follows the PF initiated
VF reset actually does.  Why can't we just use FLR?  Do we need a
device specific reset quirk?

> >> +
> >> +    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
> >> +        let mut state = rd.state.lock();
> >> +        let error = state.reset_error;
> >> +        state.resetting = false;
> >> +        rd.reset_done.notify_all();
> >> +        error.map_or(Ok(()), Err)
> >> +    }
> >> +}
> >> +
> >> +struct NovaVgpuDriver;
> >> +
> >> +kernel::pci_device_table!(
> >> +    PCI_TABLE,
> >> +    <NovaVgpuDriver as pci::Driver>::IdInfo,
> >> +    [(
> >> +        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
> >> +        (),
> >> +    ),]
> >> +);  
> > 
> > Whoah, this would break a ton of users that are assigning NVIDIA devices
> > and depend on the module options supported by vfio-pci (that aren't
> > supported here).  This entry marks this driver as the preferred over
> > the vfio-pci driver for any NVIDIA vendor ID device.  We don't want
> > that blast radius.
> > 
> > This should list the specific VF device IDs we want to claim?
> >   
> 
> True, i will update the list to include only 0x2bb3 and 0x2bb5, which are the 2 GPUs we currently claim to support
> 
> >> +
> >> +#[pin_data]
> >> +struct NovaVgpuData<'bound> {
> >> +    reg: vfio::pci::Registration<'bound, NovaVgpuOps>,
> >> +}
> >> +
> >> +#[vtable]
> >> +impl pci::Driver for NovaVgpuDriver {
> >> +    type IdInfo = ();
> >> +    type Data<'bound> = NovaVgpuData<'bound>;
> >> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> >> +    // SAFETY: VFIO hands the DMA ownership of the device to userspace. This driver never uses
> >> +    // the kernel DMA API for its devices, directly or through helpers.
> >> +    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =
> >> +        Some(unsafe { pci::DriverManagedDma::new() });
> >> +
> >> +    fn probe<'bound>(
> >> +        pdev: &'bound pci::Device<Core<'_>>,
> >> +        _info: Option<&'bound Self::IdInfo>,
> >> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> >> +        try_pin_init!(NovaVgpuData {
> >> +            reg: {
> >> +                let vgpu = match NovaCoreVfApi::handle(pdev) {
> >> +                    Ok(api) => Some(VgpuRegistration {
> >> +                        api,
> >> +                        gfid: u32::from(pdev.vf_id()?) + 1,
> >> +                    }),
> >> +                    Err(_) => None,
> >> +                };
> >> +                let dev = if vgpu.is_some() {
> >> +                    vfio::pci::Device::<NovaVgpuOps>::new(pdev)?
> >> +                } else {
> >> +                    vfio::pci::Device::<NovaVgpuOps>::new_passthrough(pdev)?
> >> +                };  
> > 
> > My LLM tells me that the new constructor installs ops that don't
> > support get_dmabuf_phys, therefore can't expose dma-buf to iommufd,
> > therefore cannot support P2P with iommufd.  But type1 uses a different
> > mechanism, so we would be able to map the vGPU BARs for P2P with the
> > legacy backend.  Is this true?  If so, why?  It needs to support
> > dma-buf.
> >   
> yes it's true, the vgpu path has no get_dmabuf_phys, would it be acceptable to add this in a follow-up series?
> P2P is not in the scope of the first verssion, and i would rather add it together with a P2P test

It seems incomplete without this.  We're suggesting that iommufd is the
preferred IOMMU backend, but we're introducing a device here that only
supports P2P using the legacy type1 IOMMU backend.  What's the
difficulty in hooking up vfio_pci_core_get_dmabuf_phys()?  Thanks,

Alex
