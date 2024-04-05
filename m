Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518016F0C9;
	Fri,  5 Apr 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327112; cv=none; b=Bcls7QpUuVkbej7zkMX2nlH+FLnoZGCFAXRCP6LZjBnvTD+YF7SD27BiOhBVYZTz7/GdPQChCZnfypg4ikL/Teh7zD5q1bhWbCPrdV2kQ6RpTwDt0S/PaWRAvhGD5t5ii0RB1DPsgKUnTaHiOQGrXGY2pzTNPmJu7GSwXY2LORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327112; c=relaxed/simple;
	bh=OBEuIQbJ84oi06SvVCoeEWG7ouOuB6BPHOlXg74//f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNptOSCdWi8hOLcBl1TWThxBjk5XAfj+QVc9y1KZdHDddrMDpypirFtFOOGUNpGfbS30P3ttSFmqersjElUH7wMTaAa0rXNV/5M1eKGCLOAHrIaQb+43F7RcPUSR+RCXx2x+9pRmjHshDXapexPVv8+MjXArky1yj7zSxGu8rAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/xKKDJ8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/xKKDJ8"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343e096965bso597251f8f.3;
        Fri, 05 Apr 2024 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327109; x=1712931909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBEuIQbJ84oi06SvVCoeEWG7ouOuB6BPHOlXg74//f8=;
        b=N/xKKDJ8nMsJt/avoul6zIsklYdHCMIqdnbWp3O2fe6fzdg4iJY4AvN29ZlE9Z3NXs
         ZcVJq/FKumrC4wj/KEUNbv7GCheesb0fxqLA0XlwJ6hd+EGtvW1bRlH93CKM07NPCYvE
         6SQgfDNDSrROkYZCW1uDE/bPbUn6W1h3v83SqFOkKEBTV7VgXyUDXSrlDNEolsvMaOrg
         ELfb05Dgf+JcCc3hja7xc1t71y69opWWlxOkSV9xw6iT3eJIbPjrXNKPIzdNj56PwgBT
         0QDkwIAog7HQ1R8vYL5cObOvhds8xvudqLgADHQtNXT7jkbkieRbs4qdf5ZFXQXtUsQL
         iHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327109; x=1712931909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBEuIQbJ84oi06SvVCoeEWG7ouOuB6BPHOlXg74//f8=;
        b=Bt2p+qF6FPn9s7mYZxdIDZ7OkZindds6NHox+RdHTMpv4H/TqDDMjoyFaScWqeqQLg
         YCHFS9EcLuY4BOGu4N/qi9mjLPzaj+4R2p81uLt0BNg6sbMGH7XSa9yRaK3E97Jkm9Cz
         1J7ruLaw5mmUn8nPhLO0Lo3oqmyTFWXUr2npxnpjefK/dcsms7lwjvAeeJIRN/lLbzTY
         QkKZ0JsdDgPiDaRRk7sBDIhhjEI/ICLsCUNaPlZkrAgY7r6jyLNdXtJAoFqKDwf3nklb
         qHuA4sslVZNW8EUEZuxnSbbhNXYpqmirBJO3N/6+ca8Mjp7WS1tBDQTEx7S5ldgGD8bW
         +G+g==
X-Forwarded-Encrypted: i=1; AJvYcCVv/05chBKZKBig4aqxAXdJzoRGEJ+7JLHfUeU006mr7yuMAcXr5rjjRx9U2iT3ZwBv5QVs1m0oFi8bVCgqz5PsG4Ps0VRX/uGznfCAUbBsuHFLjplQ9Ys0Fjqx/DhKVDSu
X-Gm-Message-State: AOJu0Yxch9/fi30JlfCNmaonK7KBFRRwUhdfrWUUxx7zymZ/yBHmk/P4
	juo0/oVBBCjrNLD/2ej2gc/9/qbNLcM9ijAS125sHMY3YlsirJFQlZBTNHUVxevTlId2QMRu11N
	Mq4iKhJxc1EO76ml8KbfOXCJQ56o=
X-Google-Smtp-Source: AGHT+IGEzu0IsE2S0d/yxwH/NrkVH2cW7n+LFCqjO79F9cieJRuAeMJaahH4ef26P7mep59WB7RBi7Ks+gAjS+xa+08=
X-Received: by 2002:a5d:4b87:0:b0:343:679e:fb87 with SMTP id
 b7-20020a5d4b87000000b00343679efb87mr1437101wrt.44.1712327108927; Fri, 05 Apr
 2024 07:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho> <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com> <20240405122646.GA166551@nvidia.com>
In-Reply-To: <20240405122646.GA166551@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 5 Apr 2024 07:24:32 -0700
Message-ID: <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 5:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Fri, Apr 05, 2024 at 09:11:19AM +0200, Paolo Abeni wrote:
> > On Thu, 2024-04-04 at 17:11 -0700, Alexander Duyck wrote:
> > > Again, I would say we look at the blast radius. That is how we should
> > > be measuring any change. At this point the driver is self contained
> > > into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
> > > outside that directory, and it can be switched off via Kconfig.
> >
> > I personally think this is the most relevant point. This is just a new
> > NIC driver, completely self-encapsulated. I quickly glanced over the
> > code and it looks like it's not doing anything obviously bad. It really
> > looks like an usual, legit, NIC driver.
>
> This is completely true, and as I've said many times the kernel as a
> project is substantially about supporting the HW that people actually
> build. There is no reason not to merge yet another basic netdev
> driver.
>
> However, there is also a pretty strong red line in Linux where people
> belive, with strong conviction, that kernel code should not be merged
> only to support a propriety userspace. This submission is clearly
> bluring that line. This driver will only run in Meta's proprietary
> kernel fork on servers running Meta's propriety userspace.
>
> At this point perhaps it is OK, a basic NIC driver is not really an
> issue, but Jiri is also very correct to point out that this is heading
> in a very concerning direction.
>
> Alex already indicated new features are coming, changes to the core
> code will be proposed. How should those be evaluated? Hypothetically
> should fbnic be allowed to be the first implementation of something
> invasive like Mina's DMABUF work? Google published an open userspace
> for NCCL that people can (in theory at least) actually run. Meta would
> not be able to do that. I would say that clearly crosses the line and
> should not be accepted.

Why not? Just because we are not commercially selling it doesn't mean
we couldn't look at other solutions such as QEMU. If we were to
provide a github repo with an emulation of the NIC would that be
enough to satisfy the "commercial" requirement?

The fact is I already have an implementation, but I would probably
need to clean up a few things as the current setup requires 3 QEMU
instances to emulate the full setup with host, firmware, and BMC. It
wouldn't be as performant as the actual hardware but it is more than
enough for us to test code with. If we need to look at publishing
something like that to github in order to address the lack of user
availability I could start looking at getting the approvals for that.

> So I think there should be an expectation that technically sound things
> Meta may propose must not be accepted because they cross the
> ideological red line into enabling only proprietary software.

That is a faulty argument. That is like saying we should kick out the
nouveu driver out of Linux just because it supports Nvidia graphics
cards that happen to also have a proprietary out-of-tree driver out
there, or maybe we need to kick all the Intel NIC drivers out for
DPDK? I can't think of many NIC vendors that don't have their own
out-of-tree drivers floating around with their own kernel bypass
solutions to support proprietary software.

> To me it sets up a fairly common anti-pattern where a vendor starts
> out with good intentions, reaches community pushback and falls back to
> their downstream fork. Once forking occurs it becomes self-reinforcing
> as built up infrastructure like tests and CI will only run correctly
> on the fork and the fork grows. Then eventually the upstream code is
> abandoned. This has happened many times before in Linux..
>
> IMHO from a community perspective I feel like we should expect Meta to
> fail and end up with a fork. The community should warn them. However
> if they really want to try anyhow then I'm not sure it would be
> appropriate to stop them at this point. Meta will just end up being a
> "bad vendor".
>
> I think the best thing the netdev community could do is come up with
> some more clear guidelines what Meta could use fbnic to justify and
> what would be rejected (ideologically) and Meta can decide on their
> own if they want to continue.

I agree. We need a consistent set of standards. I just strongly
believe commercial availability shouldn't be one of them.
