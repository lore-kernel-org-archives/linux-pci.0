Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA843563E1
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925028; cv=pass; b=P0JKX2adHhKFqzcFwq114ddODuC457FBTaG4fVAEoXCeaakexTINHq86xExXDvc00UQdfRaF1pb5YoAwaPFaM9Uj+uJuP1ed+w1BOKVbj2HUUHy9gSg0lgbrYckJSOIatJIyLMjQbGHHgWzxsgVfh2UBkwQ6a/xYodcoqjHeR60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925028; c=relaxed/simple;
	bh=QtP+iFUv4BWoWROfaSmBG7+inBADppzkL3R7RVdJ3SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXMzzhaVSg9bsBSSh67i7ck05/896RQwz2lgjCmkCd485BeWqRrLvD2nz4Nc9ykUixP2IsNc3ePWOvUpPEjefnNm5Ss3CB0lLQl604azYiVBkTSYBMeiX5tUj8MXrwkMjDg72PzmAIHuq8xtz2O8wZAzzbNcjAuBm9mLXBSXaNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=jg3SBPsO; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="jg3SBPsO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a08fa355a1so45224666d6.0
        for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 09:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775925026; cv=none;
        d=google.com; s=arc-20240605;
        b=dVJMWMEtSw8dsJT9g1hzR6U51ZzALwxQCeWKDaInEAdISW3IG4qLWvI2ihDzuLUbn3
         Addsp/d7vAhju1DsfHRADb8qJeB68weO1TlFkOAGSvvkeUElfPuDTp1vHl0cVjknZr8H
         zrb4UPLsAyq1JJs846rSiqXEBewzDOgJXLAmzEo9pk8WQ/knLZFP5NMXL72EbiMDs80Y
         fl9A/8QC6NpniLrl1AHRAVUKpkImA5ZyRQ6Vk2YEcYAWKEvrtGC1SQq9NGB91ByG9EUE
         IsMzPUoKe3w4mGTvXABv62VcEA7VDlL9/JSwcEhVOxCqvqSYe9/Ocw1BBWmZ5Okr45U2
         zgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5PfjSuV5cfy0EpfRDJ55yvjZtX21xPbkjl0mcI/Ids=;
        fh=xrHIWUIOS9Aq540F+ioHnaRod1/NGw0Oq5BxlMFl4cA=;
        b=VZoy3b8Obl7CGw2T9NAkpBcUCcFb16KLpdZ9xbtkwmw6BrHNBoZGGHMBU4TbJkLSl0
         ZHYMdDfdwfz/Hjq9UJdI7Ju4bh863D04BZLmtBe6vy+hRUTfjpoqCJ56VJpbvuwo5OcO
         SHzXUSlulCMe3F0FUEDJpWxG4yISbvTpAeGbCVx/ZiOpdUqkc6nhFCZc3hB4YHdCsYu6
         yPjgbtD2Os3J0LVAolrcEE/8NbGWWnD53FiOuaTAAk19R33/xCtGRffDfkkYw89Z5kxL
         adJzfn/azVJn1dP3yKO2Ep2iceSU7iQFZhi7UC/CgqP/wwa1vg6dDOh0pqn4fVVvo5rw
         gMqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775925026; x=1776529826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5PfjSuV5cfy0EpfRDJ55yvjZtX21xPbkjl0mcI/Ids=;
        b=jg3SBPsOG4eijn48KWPjSXw6cWHaatHArJm99NQnEraCsv1xXaF30mQ8TyZ0s3Bdto
         2esNFSauK1QrLVWdNWuqEaMaQxnipZniuSpfxG2bO7YrF1EirEGO+7ecZWGW7VSINNva
         uLgCFb03qSI2BgG+yHC0WL2Brq5mUhQHtxC+esAOp8QMMwsrbVCi2tnm0eInHqE+/psg
         21gO8e2No3fIu121MZufSvUfRat9IwGtNZYnEEARA7+UpCYOrfTzmf933otxUijd3EgY
         kbjrxrfOW1wdFujhJz6UX67NZLIJf9wBZfURgUSI/rsx9xWdD2S0ecdoFAey0OfQySUL
         4FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775925026; x=1776529826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5PfjSuV5cfy0EpfRDJ55yvjZtX21xPbkjl0mcI/Ids=;
        b=aA0ETsk9pnMzc6WAGgVYZOfNdF6vpQ33FNB40DZBti+UYsNYGKHQJxcHwM4ChoBTqK
         RVh4gqzih28oytwyUMbpjFNywkSoel0Pfb9bM6w2ueP0CHyhXA9kdynM9c5LKtOMzxR7
         OlhPCbfmRwchJJtyC8WdFDUCGBIX1/2hH4tDnwlouPPCxmjc7pYCFJMaTd/a2HjbPso5
         AhvW1zReIz1ierHdR6Q92aPKZvzEWQI7X8JMlj5EqlCckq7HHjYarBaLWWiGsFU7EjLH
         D1+i+y1sfxX8pj04hjS39pXd84y9F2oxB8pfaSGxrpXSBERbHJkkSR2royZArXe3wlcT
         mxlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/88xHnymiqHPDiJPIRZVk2OfwI2kcMSHIiz45sI/PcARcIYNKV94w5EyXIXJPFRHM0GF4O/KuAOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1YwB1yuIR385mOaJY8sCCtKadnp6T25EsVs4IkSoL9knXLNS
	ZOBXiXez27JqP60S0nix0HyBRF8QO4/pdy18+T2JHIvCwhuyqwWlmEmt8JsrOGKYadvfML7TPRM
	zgpDyyS2GTwa/LNxQ9C+zobqyG4Iuqb0HZRxZBM5XvQ==
X-Gm-Gg: AeBDievi05I35fNiRwK0aQ3G/ZlQIalWQ3vFAkdOathh4z01rgX5TAKdeyEE8XMsmLD
	P+AHWs69aW9Jay7vU6N9m5wLSjRmMuocyX1xZrt/Pg35/bsb1yTGwIWZzmZ9bnv7nTFDaL3fHq2
	AGq6DFm+dEaKB5uRg6zDpiZ36k9na5KVAB0mziqKk5bSLiw1rNDLe8x+7tjLit+v9eVvpb2ruzS
	/mBypNSMDC1QSMiWrovKijwjWkFn4vnEcYaArec/D1n/Q0l5kIsY9wLBeywSiUdYxjQdrG4Buy8
	NRR0/FmSyLLtqqEmvpcF9s+/8fWWhLJTMlR/gbVq0Rz4YS4zuHY=
X-Received: by 2002:a05:6214:29c4:b0:89c:4be3:5d6 with SMTP id
 6a1803df08f44-8ac8628471fmr118062956d6.29.1775925025989; Sat, 11 Apr 2026
 09:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
 <20260410052918.5556-2-gloveless@jqluv.com> <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
 <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
 <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org> <CAGpo2meYZ+JmBo5veqF3tAexu+RevMMRmPgB5QjfZKncntYGZg@mail.gmail.com>
 <CAGpo2mfVV-UcTg2ST9jHC-irUDYEb=rk4yvf2AQc2Gw9EgyFuw@mail.gmail.com>
 <58b240e489d3a4d41e7dbbe5720b80c310700582.camel@ieee.org> <2fe254c2-38f2-4213-9055-43b810502ccd@amd.com>
In-Reply-To: <2fe254c2-38f2-4213-9055-43b810502ccd@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Sat, 11 Apr 2026 09:30:15 -0700
X-Gm-Features: AQROBzBh-0-nocVIYn4NRFNNSpAlBs8_SzGCGqlrX5q9AfDD1vpJl5HS0KigoZQ
Message-ID: <CAGpo2mdvW3zL8p8kZCu2Q8r6kdrZ_N_YyMQkE-ayAvMrN7bh+Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during rebar expansion
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Cristian Cocos <cristi@ieee.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mario,

Yeah I would consider this a bios bug but it seems the MS-S1 isn=E2=80=99t =
the
only one with it. I=E2=80=99m not sure how bios development goes together o=
r
who standardizes the ACPI table that would be the right way to fix
this.

I would think the faster way is to adapt the AMD driver to use the
Thunderbolt provided function in the kernel to detect if it=E2=80=99s on a =
hot
plug table port. Which would only work on driver versions that where
introduced during the time the kernel had that new capability. It
could get backported / patched. That in my eyes would be the fastest
resolution, correct or not. We could update the ACPI table during
kernel load but that seems a lot more hacky then using pre-existing
thunderbolt provided functionality for detecting if the device is on
Thunderbolt.

I already patched the driver with the additional thunderbolt function
call, I=E2=80=99m not seeing any problems at all. My kernel loaded with the
devices connected and made it the primary display PITA but Linux has
always been a PITA for displays haha. :) once done what is your
recommendations for submitting all 8 patches I believe or should I
just do one for adding =E2=80=9Cis thunderbolt=E2=80=9D function call?

Sorry about the last reply my phone doesnt like text only mode.

Thanks!



Geramy L. Loveless
Founder & Chief Innovation Officer

JQluv.net, Inc.
Site: JQluv.com
Mobile: 559.999.1557
Office: 1 (877) 44 JQluv




On Fri, Apr 10, 2026 at 8:28=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 4/10/26 18:21, Cristian Cocos wrote:
> > [You don't often get email from cristi@ieee.org. Learn why this is impo=
rtant at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > In *Windows*, yes, GPUs have indeed been supported in eGPU
> > configuration, though not so much in Linux(!). The troubles we are
> > currently experiencing, esp. concerning hot-plugging, have not been
> > reported simply because eGPUs in Linux has, so far, been a very niche,
> > limited application. In other words, it's not that these issues have
> > not been around, it's just that they have not been REPORTED due to a
> > very limited pool of users running Linux in eGPU configuration. GPU
> > manufacturers have thus focused on patching up bugs in Windows, while
> > hot-plugging-Thunderbolt-eGPUs-in-Linux has fallen onto the back burner
> > due to its small market share. As such, I doubt that TB5 has anything
> > to do with all this.
> >
> > On Fri, 2026-04-10 at 16:01 -0700, Geramy Loveless wrote:
> >> So after a while of doing investigations I keep thinking, gpus have
> >> supported hotplug or so i would believe for a while ever since at
> >> least thunderbolt 4 and possibly older styles too of hotplug as well
> >> as dual gpu machines like laptops that have a dedicated and
> >> integrated. I would think all of these problems we are seeing is most
> >> likely due to something very specific to thunderbolt 5. So here is a
> >> theory.
> >>
> >> Root port ACPI device: \_SB_.PCI0.GP10 at address 0x00030002 =3D PCI
> >> 00:03.2
> >> Its _DSD (Device-Specific Data) contains only:
> >> "FundamentalDeviceResetTriggeredOnD3ToD0" =3D 1
> >>
> >> No ExternalFacingPort property. The firmware gives it a D3-to-D0
> >> reset
> >> hint but never declares it as external-facing.
> >> For comparison, a properly configured system would have:
> >>
> >> Package {"ExternalFacingPort", 1},
> >> Package {"DmaProperty", 1},
> >>
> >> The complete proof chain:
> >>
> >> DSDT (/tmp/dsdt.dsl:4194-4205): GP10 (00:03.2) _DSD has no
> >> ExternalFacingPort
> >> pci_acpi_set_external_facing() (pci-acpi.c:1422):
> >> device_property_read_u8("ExternalFacingPort") fails =E2=86=92 external=
_facing
> >> stays 0
> >> pci_set_removable() (probe.c:1780): parent not removable =E2=86=92 fal=
ls
> >> through
> >> arch_pci_dev_is_removable() (arch/x86/pci/acpi.c:353):
> >> !root->external_facing =E2=86=92 returns false
> >> Result: dev->removable never set to DEVICE_REMOVABLE on any device in
> >> the chain
> >>
> >> Sysfs proof:
> >>    00:03.2: removable=3DN/A, external_facing=3DN/A
> >>    65:00.0: removable=3DN/A
> >>    66:03.0: removable=3DN/A  (TB bridge with HotPlug+ Surprise+)
> >>    93:00.0: removable=3DN/A
> >>    97:00.0: removable=3DN/A  (eGPU =E2=80=94 dev_is_removable() return=
s false)
> >>
> >> I'm not sure its correct so much but I have patched up the amdgpu
> >> driver myself to use what its using now and "||
> >> pci_is_thunderbolt_attached"
> >> This might be entirely completely wrong :D but I figured I would see
> >> what happens.
> >>
>
> I would say it's wrong.  We explicitly moved away from this because it's
> only indicating there is an Intel VSEC:
>
> commit 7b1c6263eaf4f ("drm/amdgpu: don't use pci_is_thunderbolt_attached(=
)")
>
> Isn't what you point out a BIOS bug?
>
> If the BIOS has an externally facing port without ExternalFacingPort or
> DmaProperty it's going to cause problems in Windows too.
>
> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pc=
ie-root-ports#identifying-externally-exposed-pcie-root-ports
>
> Now granted; in Linux we might be using this a little bit differently.
>
> If we were going to do /anything/ in Linux - I would say adding
> pci_is_thunderbolt_attached() as another criteria that marks devices as
> removable is what makes sense.
>
>
