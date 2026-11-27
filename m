Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817105;
	b=Igjqw9M5t/QXmqbQUeQ+2ZmdNZ2Dciqa3/Qlz7gHLO6hOHE7KsozTk8CwzjKXN4gM6vH
	 y6PSvYHFr+LG+Ci4ak2sJyBlQ4R4GZRBo+pAOky5hl5Bo0tjMdApwaVGa9ZBGrMiOP/8r
	 M/aZZDO+vSI1THq+N7EP1JFKK0zAKlumG9XqIxaB4QozzajBEuFoUOpP7KfErcBitzJaN
	 DUNGfx4FF4Us85k8bQ4S+q2YegstH9SG5djKUAkRPojVeCCv+6FAJhXatwAFM/4DWukZh
	 brjgIl0Z4UjfZ4BM2bvGWzop0Rz1VMLMSbtfzBkmWCILqZh0A3KyteW3nnPTaTt1QwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817105;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ruSTi2KXnNElVne/1XJA5zErngKPBaYI+3TNP5Q+jOA=;
	b=DF7k47laht1SGjldEc7QdS/CZ8u/rmDPCQumE4NN2NBWOBWmrpjRLy661c4LHsZqLEJz
	 zdRIBANa1FUunhL6cJFrdNqP8B5YWbkbvgUDU9mg6dGdcpuRPMJ4WLPTZTRwow08GLNeh
	 /XxNPZU0ErrLdwpshWAfiuxgbTDoOnuxbbIFFVD6Crcq95N9DPSNibfuAcnHV2dbyhXN9
	 aQDMD7CJRCA15+Qy+ESjmWVbDDJg+/9TIX+fptwZ9ikj71fMjU0AE7+27kCbmCaockS9v
	 8AU/6w6ieKrbnBAQmyfsovcPpd+5oifA/NB+C0AY37CcLQjVaLGhiEsvDXiSX2zlCig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=H2Cmp6h+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Rp09Bfw;
	arc=none smtp.remote-ip=202.12.124.140
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439E606A321
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 22:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3439E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=H2Cmp6h+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Rp09Bfw
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id B6BFA1303349
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 17:04:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Nov 2026 17:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795817098;
	 x=1795824298; bh=ruSTi2KXnNElVne/1XJA5zErngKPBaYI+3TNP5Q+jOA=; b=
	H2Cmp6h+LZGx9f0bQnDfTD/mrFYtXbkzK+rXTkUYR5pU021YammeG2K3MeYucaFM
	NmgMdpTE9MXujDVHLvXUNk0z9yqRkXpJpUYFdfNtPQcK1+ybgPrO+THRJyb0QbfM
	NZYtfuwCRSBym+06RvCpT8HXTeWNdoQ/JpteGKuPSsa7lQ1QQ1eNda2XsGujwS1n
	769FI7ntsYsQVdOZyNETx1l2kw0SOie8DcrNR5kJyc4N1IpuQp1nJxNyTJP6Qv8x
	5KpATTU5XacwMY/h0d9W1k07cuco7/KcfXCxV5nqyuofPfi5i9u8oUyEpA3fM8Fb
	D0lKdjC7VtSUmizrLe+K0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795817098; x=
	1795824298; bh=ruSTi2KXnNElVne/1XJA5zErngKPBaYI+3TNP5Q+jOA=; b=1
	Rp09BfwURwtupcfc9BQnP0xBC2kpqHBoXafW0PQRhRS5Yy8uyPJgI1oHOW9SMyBx
	nL1rh18j+qXSRsMczrcOEWcmE1jGgI9PDQPWAqrb7VlrIZ7AfOqH6lOgqCvTfG6s
	fLWKm6g8DnKe5yFiszv0oYotaHBlUv2Jsj21jdeTrus8VKxCwNdf4qUEtItt4Mvo
	Lyq7q7og5HC7V+NHiENtaXKa9I+X9w3pnrENY9qMOD/se58JWkJBK3QSmYO8DzvJ
	LWyY9Tx4xkiI86zgzmcd4QDCFpB1pw6c1dBzVbSmdpapEP3qO+LX4wTI6J/c1toz
	2WIUsY/Wa8LnKHpfHrnrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795817098; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SOHE0qDnZMR/QXLgxejXk+s6uVOonM5VDfvxsxYhiL93heA
	oD+FRzfUnKek8RnsjsPAluFtvBoFLPO5FKnWTxvRi8RdhCYcQSIyDp4hl4WLpF1R
	Qy3YglowPlM9rRXGaDw74uUh6efkHoA2KXNdw90dCXDpQstifkGQP9TXABCOHDxy
	tEZw5oO2fnVBU6258fxHo4toB9rLIKLq8QOndMfTG+kkztO6p84ViZneIMcfCjLU
	/a1A9gTtqe35dMoUKdOFVmE5VvhkKPBRGmcN9WkuJzdPQrXEUxZOx3Z+/ktjyXJY
	rc36yXpFDMmQI9K7n/vGsrDxV+cEHn/Sru3RVYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0/gjl7sT3nacJr3v+xNspH0IHXx9HtVAOimrDYWjgp4=:VtKoA94nBuwKQPdehHAdkaiDSgvkIeIqZH8gzxzVZf0=;
X-ME-Sender: <xms:if4Ja32y9uccKKWgA6awKiUv1jsGnifiarSTqXHKpNdk2405PeVa-Q>
    <xme:if4Ja1GuK9qZubZpc7tiETesteIEMXaSGyYLu30X-k5SNhajo8yHNgT85hpYffCf1
    zQx1bYlsDGKWPYzWa-O90ieHdbQSF-drzGxgCt_PpFLo9B-f6y17pU>
X-ME-Received: <xmr:if4JawKWiEMjKTJcNjQKUk2MQpn-Q8JrYKNspHnC9IxfAIyb4LhLqZcKXYNV0g>
X-ME-Proxy-Cause: dmFkZTFjoLBAvKIejJlSbE4Q3c7bkxlwYcgKg00iy/1FtMqgE0UdHsF+zkRGYeqeIRPxUo
    Iwd9jRHRKNfQ9hDSzZCbQRpCbytMCSe5RbXFr5dsjvcES8LL1AaH39Ywx2JBlqO1XAK980
    fT1E3+bKrWsl1e2eZp2tDDY6Em9VuPuj/fcK3NR5NhAMehQQcp1ZK6MkNzHoSfXTPUKBnk
    xz35R79TqFIpzvcDmSZksFlk95TX8eYyGE7JxUOXuRvieaCQa2CuWVJ5K/gfCk9HehMrYk
    oIep/2Sm621WsrtQQS+Cbkh8XXCK+vBZcwj+I7FB7jnkybhrFuKbwwbbjXImziG4O2TZfh
    AbKogQ7P03x0oUsBf5l4zFHiJP39hzK/oDWZksyVD81l7WlsrRfLhL0KRIGhmeAsStmO7Q
    qJw1PoIvQU4ttXMOHScaWA7aaPwxD3fzXavZXikiAWp6fHurIZMOn84YvIuOrCeUKJ6e0k
    xEMBmiG+vu0+/y8Fi57kiWtYHq4BN6Ausxugj7ol0vbMIvod7U2rqAtptPnlIu4eulW+QY
    TRhnuM9D3d+v/B29vt9UF1NG4zzseTSKWMPA9cA+Xh0svixSfX1tZFbDi36vLGCVCYMBSp
    A/A4Uc7hTuwMLCW688CoK/C/58IQhbeb/r89C3k2DgnProwfkI5fSp15bvvg
X-ME-Proxy: <xmx:if4Ja5PAN6NdHFNG7OZ7_UnTCfMxe3tG6bpy35Zf_MAgXQB53LFk1A>
    <xmx:if4Jazon5onLn2WLqaJA6_cFMlo3NtcZmEPrBEei0ykviuniNnmcBQ>
    <xmx:if4Ja6ffYlYIoFiPFJLmYci-181LdzyKk_cEIWYn6UsmVwoUr7EvlA>
    <xmx:if4Ja0bJpmV5ratTRzHTZVYYzR4YxwwakIDTYkn9TpxNkFodqK3sjQ>
    <xmx:iv4Ja4aTdJ5d9t4-fak9OuiXx4z4FAU3UYUlLPKdqc_oOGilNnuxnd4C>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 17:04:54 -0500 (EST)
Date: Fri, 27 Nov 2026 15:04:52 -0700
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
Message-ID: <20261127150452.03a1c163@shazbot.org>
In-Reply-To: <ad773f07-bf03-4042-b79b-f82cc2d64579@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
	<20261119215046.2892839-10-xinmengs@nvidia.com>
	<20261124201931.55c65263@shazbot.org>
	<abc4a0e3-2478-4b12-8a06-ffc81196bd20@nvidia.com>
	<20261125230830.48e768b7@shazbot.org>
	<ad773f07-bf03-4042-b79b-f82cc2d64579@nvidia.com>
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

On Fri, 27 Nov 2026 16:35:10 -0500
Simon Song <xinmengs@nvidia.com> wrote:

> On 11/26/2026 1:08 AM, Alex Williamson wrote:
> > On Wed, 25 Nov 2026 21:45:13 -0500
> > Simon Song <xinmengs@nvidia.com> wrote:
> >   
> >> On 11/24/2026 7:19 PM, Alex Williamson wrote:
> >>>> +
> >>>> +    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
> >>>> +        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
> >>>> +        // close release this mutex before entering the VFIO core.
> >>>> +        let mut state = rd.state.lock();
> >>>> +        state.resetting = true;
> >>>> +        if state.active {
> >>>> +            if let Some(vgpu) = &rd.vgpu {
> >>>> +                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
> >>>> +                    state.reset_error.get_or_insert(error);
> >>>> +                }
> >>>> +            }
> >>>> +        }
> >>>> +    }    
> >>>
> >>> This seems very wrong, why are we calling the PF driver reset in
> >>> reset_prepare()?  Isn't there still an FLR happening between prepare
> >>> and done?  Does it do anything?
> >>>     
> >> It will not reset the PF, vgpu.api.reset will reset this vgpu instance behind this VF,
> >> the PF driver would ask firmware to reset the instance and scrub its memory, then FLR
> >> follows  
> > 
> > PF reset is not the question.  We're calling into the PF driver to reset
> > the VF, but we should not be doing that from reset_prepare().  This
> > also still doesn't explain what the FLR that follows the PF initiated
> > VF reset actually does.  Why can't we just use FLR?  Do we need a
> > device specific reset quirk?
> >   
> FLR resets the VF itself, and firmware stops VF channels and reset registers,
> but doesn't reset vGPU state inside the firmware, and only PF driver can ask firmware to do that
> 
> I agree it doesn't belong in reset_prepare, in next respin, I moved it to reset_done(), so it runs
> after FLR

Both seem like an abuse of the setup/cleanup wrappers.  Is this a gap
in FLR support?  If so, this is why we have device specific reset
support in PCI-core.  Depending on the PF driver is going to be a
challenge though.  When and where specifically do we need this firmware
state reset?  Isn't the firmware already involved in the FLR?  Thanks,

Alex
