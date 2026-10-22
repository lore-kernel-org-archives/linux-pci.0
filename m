Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641094;
	b=rKfVSWm6b6KBdaOJ/QbM3YGkCD6BRGeYSa4fQMXK+OP78P0UfCfEub8Slmv/uIk21lJf
	 O0xmW9GVmK8bwV5E8esz8zUZEAWflMdWhQnAfO4A/UA6dwm6pSzNhCUNLMQPcP29E0Nn1
	 2mxqFbZRUCI5SiKpDL+76sKhY97XwZucPztMnvs/79ZMa8p069B1aj7Hr3s4Am5FZqLW/
	 yJMlqIC4MFyPGbLCvSZPWR1ogKeKzLjQBIyfEExMRcoi8ipBNGNtyhucWbT4bOpDHy9BV
	 87bIrAv4m2GYmD66lXiEQ1Iy8A1KQqHct7VB2Xn077YoVYhbOM7r/Aq1H3+FU73UYCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
	b=bwcGGkcRGRlWmZx9Uz/UM9uB4Yvh+heipie/7TfIWaaOO6SnehOZkj8c+QdLZn/3Fj9X
	 6qHL79n1rX2ID8i74KH9yRF9t2nKXatq8olkwSjEmkLXPoxG6W4V2s7dLlqpyU1JkQzaV
	 44wKhuZb2aeCX1KipTRpaZmc2+jtDZ6sxUddfhWKVsXxrgaum+NmQa750EQRCZuesb8/I
	 ar7y12hKAl4nHcfldZBiZN/8twe7CpCPrdLUCJ0iF3iDLlgDH/Iv7ZRsqLY0rMTwGaTLq
	 /PNbDZRpgRdqFyofcB94yEAQZHrRL1fnZoPs1WPMRg82lnxP7aSCUfSnPm0KeuseeBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=cBk9L98w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEB606A31B
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 03:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DDEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=cBk9L98w
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so2032574a12.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 20:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641086; cv=none;
        d=google.com; s=arc-20260327;
        b=OWx0AWdhuAg3ljDOxifXrcHMagQa4uCTGhNYMUg2tYd3BU+672EmWZCSsjgnDb5EAH
         OLA/ZvBSFQPAIGLqw4MTf/gF5PpZNy3CeLfO3u2Y9qcUmFrQXiLk1F4Cn6twwZZMNPfw
         fflqYRfEamo53G+ajWDXURTq+ZNvXQC7j91IkuYGLK4tZOXXnFFJUnxImctkvlcVph8/
         Crtmdkd4SM+avAFDUZYSh9UFQScAmt4a6o2ml0Bs8eeVemQU7xY7sWworhC/ctXlCXhW
         jpfXYE2y0UA3niaPOoGu2ryELlKoaKJSwag3xOAcZV91ZTIl1dMfL21s5YvDKlJqZDfH
         F++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        fh=GR6IpqCBkyuZI/ooMHzELnm8ZTAXvh+KLxp0f8/4Rm8=;
        b=bcGodSvxMSwrIDExbEXvfIcB1zm0woBuzvDxXOO1++eczWi+21gq+EX4i41W+EA96e
         5GeCET53smUe1CPthcBNOpQZDTDsKWig+wOtbntk3Upog1uTj8PhUCbXsVMoKuRMV1iU
         EALWVxwTOLz/ri2pn7TTbuLUg0K1gTm8awsz+yXg3GxXMws7cyGdoZPWLp5LbjDKLG1x
         8BYHjT+XyuZco/x65TD2HVZ9y1aBKyL5EzuZHowtg3xN/hJPb5vNs4jIrU7nIESdYa5p
         iefqLoKnG084OAQv+CH/5/1StaYSqqnOy5ByovIgez/+PUsfe1wzyY8LK2aRlEf7Dzyn
         amkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792641086; x=1793245886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=cBk9L98wdr+I57yyKoGK6ehYZVVWDgUcVA0vBev183FVZZ9gL7bx2aAI9FHk2T2N+g
         lYnDbd8lxkbmGp6fxdfORrV33M/cwga8pi3bHVDROh60aogMaMKHgRsc60E5datA891T
         aoY1tB5X1q6xy9NZolD/k5TifKRm71ur+T75WWkkRuneEyWes41oiLntbMg4lL5X4hIH
         4N9J3nmbnw1PqmHfqXMpUjdz8piQsbYLQYPGREsC1I+SWMwd6mJYf/XCYm+48Nr7XZ5t
         fKBT27EQbzvbH75Hv8N8EjbsipbFrCebOASLNVdlr/oloQYlc+ehjIi8GxJT7Uj2JART
         +Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641086; x=1793245886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=uyy/C1VHdAWky1CxMLpfW2drMCOMR2Et9LBXAuBIDB9d0A6gIRgJ7WbIiQ3gNp8lNp
         zf/WMHHWNOB/+gAJM46ZYAYWaYjbDWe1NDszYcpN/W7SuYBLAsm70b0Kd7H4q2fiQ7A5
         3Jsost/6n/O12nuikQEcaOHm0CxMXrSsBWdwt5jD1+zs/3nmVHhXdJ5TPqGdQ1whKGNw
         +Q7SZo1fovoKesCDRJUxQmMTgR7uVBf5iRB4Ox0EVhgo+HxyFCaAFvqUoFnCJVfHRSSC
         lxdW9gMjhqdibUOB00G6Q72oxr45fXehKZdJP0RmZUIad6rzPiP+lo1JJ3GjHNohJ+vy
         fZZA==
X-Forwarded-Encrypted: i=1; AKwUvBzjepr474MtexxVfVucmP04YzbVY/5gL5Tgds0HhnVPu1FIq65RcJVpO4x/F+yImg1zsGGDCWOZUfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkMQSH7C01U4TCYpjbt+2gs9wijC6qy/1vM/Vxnm16gym0EuDG
	RQvJ+7Ls9wB7hcb8trUC9VOpATIhV65lscgQOWm2IqLEXyvBwjdRG02RkUckCLs7PPSA2hFKdv5
	c5dmr3delGfH6TgW9fAviT2/tPyWzsU1GMMInACiZhQ==
X-Gm-Gg: AYBFou1D62LroPAbc8eyYwQJJ41nuCU3wMZGM4up8SkrMKjj3nEcYJmBwRAyjd1HB3Y
	Obgk/9JQ6mXemKxKlKli+3YlgJ3F5Zq2tAbPGBxwQYZiCxtEvEmaXqImuEbB+8ll7xsuGhZlsYS
	0JlOnPHo3gTzxvYjaszMBAruUBDwmUrACM/gUjqeqjGNBsDz5gds4v+Ut/Q5PuZtNKtYpBGIS16
	KbZn7eaaP3uBRbWXaWii6DIYEPCDKf02z03W7jlN8dshZ2VExRQ1h4hGjf+ygnSx8aVmK8GbHMe
	FCvXi44MY4ofHdtGr+pUHxynl5R47m8WvhQ147zjYHDlt9pnmK00JeLJfhD+D7Iorwj9iPQ12U4
	jz1myjqXWOP6HSwBKHl5tShAna9r6S/6ckVl7iqmw24t4B5aYfGZ3jrEE73oeh6N5KcQ=
X-Received: by 2002:a05:6402:400b:b0:6b4:2185:7147 with SMTP id
 4fb4d7f45d1cf-6b4218572dbmr568868a12.15.1792641085570; Wed, 21 Oct 2026
 20:51:25 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
 <atlINfvlXY4wMbpO@google.com> <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
 <atl6K2Juy6Bh29lh@google.com>
In-Reply-To: <atl6K2Juy6Bh29lh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:50:49 -0400
X-Gm-Features: AclHuK9es7KH6zjO9m5YDGIDDY6Onq6kZ5W4q1tuNZUyMat9PK3sQU18xuWoZac
Message-ID: <CA+CK2bB9xoAWP0kC+KtXeDTdwt0kWqb-PLHN=6DsA=mnRpMfxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:51=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 08:41 PM, Pasha Tatashin wrote:
> > > > >  /**
> > > > >   * struct memfd_luo_ser - Main serialization structure for a mem=
fd.
> > > > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > > > >   * @pos:       The file's current position (f_pos).
> > > > >   * @size:      The total size of the file in bytes (i_size).
> > > > >   * @seals:     The seals present on the memfd. The seals are uAB=
I so it is safe
> > > > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > > > >   *             struct memfd_luo_folio_ser.
> > > > >   */
> > > > >  struct memfd_luo_ser {
> > > > > +       struct luo_feature_hdr features;
> > > >
> > > > I have not looked into this yet, but I would prefer to use some kin=
d
> > > > of macro constructor for serialized structs. That way, they will
> > > > automatically include the header, making it easier to search the co=
de
> > > > for what is actually preserved versus what exists only in this kern=
el.
> > >
> > > If you want to know what is preserved don't you just look at
> > > include/linux/kho/abi?
> >
> > Yes, and having it initialized and declared in the code correctly with
> > proper macros and verified just gives the right handling and avoids
> > making silly mistakes. The second reason is so we never forget to
> > include the header, and to make it expandable and easy for everyone to
> > use. I think this kind of constructor is just useful overall. Are
> > there any reasons why we wouldn't want to use it?
> >
> > > > So, I think something like this:
> > > > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > > > struct luo_ser_hdr {
> > > >     __u32 total_size;
> > >
> > > Why do we need the size? I'm not really opposed to it I just don't
> > > understand what problem it solves.
> > [...]
> > > The luo_ser_hdr is needed for top-level file handler and FLB ser
> > > structs. Those structs are always dynamically allocated and preserved
> > > with KHO.
> >
> > The top level is not enough. I think it is needed for every single
> > serialized struct in kho/abi - the blocks, the FLBs, etc. They all
> > must
> > be expandable in case we need to allow that. Let's have future
> > protection for everything that gets preserved.
> >
> > For example, take a look at vCPU preservation:
> > https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@sol=
een.com
> > https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@so=
leen.com
> >
> > +struct kvm_vcpu_ser {
> > +    u32 vcpu_id;
> > +    u32 flags;
> > +    u64 vm_token;
> > +    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
> > +};
> >
> > We might want to add fields to the arch-independent part, and we also
> > absolutely must keep the arch-dependent parts expandable. Therefore,
> > the header needs to stay small and flexible enough to grow as needed.
>
> Hm, anything that is dynamically allocated can have it, but anything
> that it is embedded directly or in an array cannot, because those
> structs cannot grow anyway. So I agree it's not exclusive to the
> top-level FLB and FH structs. But I would push back on any a mandate
> that _every_ struct in include/linux/kho/abi needs it.

OK, we should *aspire* to convert as many serialized structs as
possible to the versioned format by default, and require a very strong
justification for any exceptions (such as tightly packed arrays or
block set entries). Even in those cases, we should be certain that
omitting
the header saves meaningful memory and that we are not shooting
ourselves in the foot if we later decide to replace those container
primitives or need to evolve the entries independently.

Right now, shared serialized primitives like kho_vmalloc and
kho_block_header_ser do not have proper versioning at all, and because
they are used by many clients, updating them is already problematic.
We can't simply rely on top-level FH flags to version everything:
since these primitives are shared across handlers, any change to them
would otherwise require updating every FH that uses them.

BTW, since these primitives live in KHO and all the ABI headers are in
include/linux/kho/abi/, perhaps this header format, versioning, and
the declaration macros should be part of KHO rather than LUO (e.g.,
struct kho_ser_hdr and DECLARE_KHO_SER)? Then LUO would just focus
exporting FD preservation-capabilities to userspace, as it deals only
with FDs, not internal representation. There should also be a global
switch that shows the KHO version the kernel is using, perhaps via
sysfs.
