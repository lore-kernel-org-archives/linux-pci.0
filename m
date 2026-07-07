Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF140D56B
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428206; cv=none; b=H7GOfr8bpElpyqdTfCPpW7R+cL6ybwTy+ShHXXWA5KnOhAXRhNACa4J/s61J8FBcXP6BUV4J4ws30CevnXyc8u/u2tsuEhaZl8+fWXFMDmHnswGLhbNowlyMOdRbBjNmKfNiArpYucIk/s2sgEhDzBrOJbcPjaD0RJINlCaD/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428206; c=relaxed/simple;
	bh=0syJgOL7UuJijsJI6FAumA8sQyhvCuWjenbq/nczlOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1otuTI8Jsj9rfHMKNWfp9XLllBM97eNW06wt9cwSfIuBqd396lBZC1gc7KUbYRiIOhSLoSwy4hK0oWtNqxGBIctv6F9LObXIXWyzoGA5Y7ZFPCr98yxiUM+5U2+l5lVyeMt+oxGHoc/5BJ7haZ8u5z1JKo6Z6dr6tXgehgtBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ap4f+ERJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ap4f+ERJ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2a449c57so26955011cf.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783428203; x=1784033003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpR/IZcE7y8vF/86rmuimft6GS353sbM1gJlGWQ97b0=;
        b=ap4f+ERJ85R5xGs+B2NyDHjVBHtkwvbunDT7ASliusfLPjGG4CTlBMYwOGp5TIyh5/
         ZMnOz50Izh9Osyqu3VXJBRgoWsiGVFFpegOyTMTA5lP+rLjZ4rRoeu4zGKDeOilUoZRi
         cgDbqatthfCq39pkNBRhyurrV1MsmMm2GCTaB+XUnrB5SQhRm6saNHWNrDuWs/R7B5MJ
         7853SmejESc0kXQ1FlFMWnR5BMJHBWxXgMD2Ll83Xs5YnlEWXk612S2h2V9QAWqbmdn7
         UoVDlxK562bfrOO7J4L3Ap2YN2qsqopevJAFyjTmwITzE2H94dFlZ20kp9vMQQ6YGiIS
         ZY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783428203; x=1784033003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpR/IZcE7y8vF/86rmuimft6GS353sbM1gJlGWQ97b0=;
        b=TDRy3y3/scSU0UrjmLMjZD+QYECXcELLD7wJqEAKZ35GpSE3GMDc1T/hHVWUVUxw0t
         BXwb/xrRMLkpQ++WsWPCQihY0IaBn/t3UXfUEEsrVa6v7a8OR5SuKWIyY6esw0GBh1Uu
         IQVic5uUwrKI24Zg2WIgzs82M+h1SY9DHOf/OQrn6gYl5b+nKq54pn5ZcBh/3UKf0AXP
         feDy/R9sEYN2K76nemX7587aMboB/yZJFSfSX9aAHbCIkZQgSKzNWT1vcgNXddyirns1
         ER4Iq3K0IrXRumQewyNv4kaPrd+xjoLqXEYzLUh4jiVKfjHr3sIRWx/YUTEVa+pA83f0
         nlXg==
X-Forwarded-Encrypted: i=1; AHgh+RpewW//pQuuTCEX6hWeYkIA39jY7yLU1vAH+uyHrxHTjMLx529L5dSuukXO2FGg4COWFdSIOF252zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjB93l+Av6gAM/tZ3cmtCxnZe6B64V05PEyZwiJfsROXKnh14
	zY+tMXCfatqExyScugddbyCYgcFmjnPCS0fXBj87tNwF6JdsQHX+qLfbUi/LTTr3C6c=
X-Gm-Gg: AfdE7cl8LOu1zjv95DkNzmGcPT/QfkDGlrxymRvF9o5LBCpMhmvNRSpuk6N3o5kNR5Q
	8oXmmNJK2WD3xM05xVf9mTjdd/SoW0swirDT6eYsqzkkTCugUhjmAmmF+UerfK6nOhOub/o2BIS
	Rny39Yo+tb1m15jmVRTzCbSqu93VNDzk8JLAuc/mpFPdfEkPeO0WiCtevCO80KoIHk5Ay6VoRDx
	6P1MBFHH+MOtIdMI/fbMpz2fc3cc+05xSoydel6bxFEDzyRcCvZY7mLccEi4cQT0uymEnGpFltp
	LEjBzVMRtPRp+e7y11BOHbb0PiyCAS/WNfD+LFL63cz9oGwF2pKu9Q+4ZzLYSFOuFgSwi6qTU1n
	j6K44Oz5s21Q6FusIDRXaGRiiwHQntGkTz+92iXWqYMb4otx9GEtJmP8ohsI/
X-Received: by 2002:ac8:7f05:0:b0:51c:1cbd:5fdc with SMTP id d75a77b69052e-51c747a1052mr51204751cf.10.1783428202942;
        Tue, 07 Jul 2026 05:43:22 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4718143aasm158188786d6.32.2026.07.07.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:43:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wh58z-00000000vM8-1tLF;
	Tue, 07 Jul 2026 09:43:21 -0300
Date: Tue, 7 Jul 2026 09:43:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, ankita@nvidia.com,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260707124321.GF118978@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260706125140.GB107792@ziepe.ca>
 <6a4c163072c60_174db6100c4@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4c163072c60_174db6100c4@djbw-dev.notmuch>

On Mon, Jul 06, 2026 at 01:55:12PM -0700, Dan Williams (nvidia) wrote:
> Jason Gunthorpe wrote:
> > On Sun, Jul 05, 2026 at 03:08:04PM -0700, Dan Williams wrote:
> > > * NONE: no usage of the device unless the trust is explicitly overridden
> > >   by user policy specified via a driver flag, module flag, or uapi (TBD).
> > > 
> > > * ADVERSARY: needs acknowledgement from the bus and IOMMU / DMA layers
> > >   that the device is limited to strict IOMMU translation behavior. Drivers
> > >   can use this as a signal to limit functionality. This designation
> > >   implies follow-on IOMMU and bus enabling work for features like
> > >   arranging for the device to attach to a blocked IOMMU domain when
> > >   detached from a driver.
> > > 
> > > * AUTO: typical / historical Linux driver model.
> > > 
> > > * TCB: a trust level that only exists in Confidential Computing
> > >   environments. When acked by the IOMMU / DMA layer it enables the device
> > >   to issue direct-DMA to private/encrypted addresses or otherwise attach to
> > >   a secure vIOMMU within the TCB.
> > 
> > I'm not sure I entirely like this one, certainly it needs to be
> > possible to have both T=1 and ADVERSARY together.
> 
> T=1 and ADVERSARY are independent for link encryption and private MMIO.
> In other words the device is placed into the TDISP RUN state independent
> of its trust level. 

That's the right thing

> Downstream accesses to the device must have T=1, and
> its upstream accesses will have T=1, but with force_dma_unencrypted() ==
> true.

That should never happen. Once in RUN force_dma_unencrypyted() ==
false, it has nothing to do with the trust level.

Even if you set ADVERSARY it should still be bouncing partial page
DMAs into private memory. The point of running something like this is
to remove the shared memory attack surface - ie the hypervisor SW. The
attack surface is reduced to the device itself by remaining in shared
memory.

> > I'd also argue this list is missing "FULL" trust, which is the
> > historical Linux behavior for a normal device. AUTO should be
> > selecting between FULL/ADVERSARY based on things like the ACPI/etc as
> > it does today.
> 
> 1/ that is effectively how the UNSET level behaves. If the
> bus has not set ADVERSARY before device_add() then the default behavior
> is the AUTO level. Where AUTO means all of the automatic privileges a
> device can be offered without needing any other coordination.

I think my other remark about two enums is some of the issue, the
policy can have things like UNSET or AUTO, but once the driver starts
to probe an in-effect mode should be computed and be concrete. Having
a driver run with a trust mode of AUTO or UNSET is just confusing.

> 2/ The ambiguity and conflict occurs at ->dma_configure() time when the
> bus and IOMMU layer want to reject the device's access to some privilege
> by failing. When FULL is defined as !ADVERSARY then it is difficult to
> describe the semantics when FULL trust honors rejections to private DMA
> and when it falls back to shared operation.

Given that the trust level shouldn't impact force_dma_unencrypted(),
the only thing left is to setup the IOMMU differently, and maybe
operate a driver in a hardened mode or something like that.

I don't see what the TCB is supposed to be changing here.

That leaves it just as a policy gate to check that T=1, I'm not sure
if that is worthwhile enough for dedicated UAPI?

> The above more points to a need to have an explicit trust level for
> adversarial private memory access. The address spaces are distinct
> assets with different levels of trust.
> 
> UNSET: bus picks initial level, or leaves it to the device_core().
> NONE:
> ADVERSARY: Device can be in T=0, or T=1 mode (UNLOCKED, or RUN).
> AUTO: Could rename this to be FULL or ALL or DEFAULT, I still keep
>       coming back to the "AUTO" name because the privileges are not
>       uniform based on the IOMMU / DMA topology and device capability.
>       Again, the TDISP state is independent. The TSM driver does
>       not get called to gatekeep and verify access in this mode.
> TCB_ADVERSARY: or PRIVATE_ADVERSARY. Device can access private platform
> 	       resources iff an enforcing IOMMU is present.
> TCB: or PRIVATE_FULL, automatically enable all access privileges
>      including private memory access.

Yeah, we can keep adding more modes to make a big cross product, but
I do wonder if this is going to get too big..

IDK, maybe it should be a bitmap instead of a level?

bit 0 = Force Disable
bit 1 = Device is adversarial:
           - Enable strong IOMMU protections
           - Enable driver protections
bit 2 = Require T=1
bit 3 = Require IOMMU
bit 4 = Require DMA/MMIO security (eg Link IDE)

Where value 0 means the current level of full trust.

It is a little easier to explain what each thing is doing and easier
to add new things

Then from a sysfs perpsective the policy would have special string
values like 'use bus default'

> > If the trust level is reduced to just be a command to the kernel how
> > it should operate the device then it would be up to userspace to
> > confirm things like T=1 before setting the trust.
> 
> This discussion gets strained for me when T=1 is used to mean both
> "device is in TDISP RUN (with link encryption and private MMIO)" and
> "device is in TDISP RUN + force_dma_unencrypted() == false".

It means both things though, we really must not run with
force_dma_unencrypted() = true when T=1, that's pointless and harmful.

> Otherwise, full bi-directional T=1 before setting the trust would
> require an IOMMU to be blocking the device until that final confirmation
> point. Given that is not always available the proposal is to defer
> acknowledging the trust level with the TSM until ->dma_configure().

?? If you have no iommu the instance you set T=1 and do the platform
step to activate DMA the device has 100% acess to all
memory. force_dma_unencrypted() does nothing to constrain device
access, it is all about accommodating an addressing limitation.

ARM at least has a dedicated call to enable DMA. It would be nice to
place that call right before the driver probes so DMA remains off
until we commit to using the device. Maybe other platforms have the
same - but I'm not sure it is *essential* as the point of setting RUN
can reasonably be the acceptance point.

> NONE: Device core rejects device operation
> ADVERSARY: reject device operation if an IOMMU to set IOMMU_DOMAIN_DMA
>            not available (not in current patches)
> AUTO: no rejections, but no private memory access either
> TCB_ADVERSARY: reject device operation if IOMMU_DOMAIN_DMA not
> 	       available, or TSM rejects the evidence used to enable
>                private memory access.
> TCB: reject device operation if TSM rejects chosen evidence

What does "TSM rejectes chosen evidence" mean? Kernel isn't supposed
to be evaluating evidence?

Jason
