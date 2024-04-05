Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368716C6B2;
	Fri,  5 Apr 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342346; cv=none; b=Z2D0CzsMdLAAkRaFbXoSvvRv2O9d7CXH7NeJywPlP3N+rQbjIx1YRETvPoHX1JMIMoXT4DsnJ5KC9wdevfWnWi1h/EC7YiygwxirrkMih0MfzTcWmafhLbnQO4m+0QgGL1HKWnXBHAhsbrDgx7DiP7Feh3Oo0iAd8WpZX2aqbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342346; c=relaxed/simple;
	bh=SGSz6uksXBlvkdUHuq7oGsbF9M5aHrsrGbWqwgfk2hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iobkXu9RVgSq03+J7hI4kbbgsNQEUMk8sQ/dG1FW7tqjQWMnZ06kQTk8piA4Fe8V54OHbiX1uYIyHBt5YmK3+zXHZLkVoiUj9QGrDKe+7U5tuWOhl5u4kMKX9LQRpJgjtN1jMJe8O3rlfWJVgII4KtkdBD5qt/N4LpgmAGb/VcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvnbDNZI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvnbDNZI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d7ff2350so824389f8f.0;
        Fri, 05 Apr 2024 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712342342; x=1712947142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/+xdG9cVP5ZIfzeQbo6e2GbG7wqYcohb7Py0LWsQKQ=;
        b=lvnbDNZIOBTU/FJR++rMUy4cR80mt4KNjtZ1YWUVh+BcCCT3IJw8tfsmAxx9a2mdkW
         zev4rtoi7rtRSOqNQnTYFAZH504cBxEe9F7zTmhlzbn0skty2jpKqvYyvmZ5+z+FE6JV
         KVyT1EOWnEoipH+rO2Y3RjZiFsofYvqNNIedB0RLiBTK3atNWIcdnlqerarS/Sgpp6Du
         1b7CuNUe9+bfOK91FNuCsKvVl72ROtPz+zEzs0AWHNXbVBlIKwH7OkZYd1so3tRtzN1y
         09L4dis1QfORXqhy24GG2nSx8iPiLWHmEa/8I502ctLO+zZbqxEQ9ut26BWpOYXd1Yfo
         CN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342342; x=1712947142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/+xdG9cVP5ZIfzeQbo6e2GbG7wqYcohb7Py0LWsQKQ=;
        b=jtTxNwaIpoVkYPFaHJjkQGhZ9Mr+ocz80yEwTuZG/yZDChXDbtU7UfKYP9xwjjUDU/
         ZMBZMIsR3AaOmNGjLQAmhDO0FpBbr8lwAp3VvcUSQ+fv8PLaYiQLwHGyL5jtp0nwQFHC
         3dnO/dhNyql2ECsqrblhpZOCx1AoK0ggx3s52KS/G/nj1oCH9WnwpjPCfPPkqYmH+3fo
         8yG3I2XQh4LK5GLIja0tQnUHxiPoKqFamSUYMFzOC+o2XxB93M6XMuyOYbQTg5WQL6Bp
         ltO83fAbVQyr6Fhk+7JErU0GEhqqCa1FruYctXNfF2YnwPvCw6oKVCwwPj/aFdxmnd5W
         Cn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqFTugUv8u3ZNyubgA/eEroZfDqzhnNBG/j6Q7nGcHEM+bfCMPmulZ/qUNNQdOdtvRDNQY3O6v6fpHVzGcbZoDUajKiHySl0SgHxy7UIqRhWYq2hUOrwpt1O7LRRWaIy5B
X-Gm-Message-State: AOJu0YyZsCfqVU/wh/HWCGnBzuOvkCn+EXBPN9A9nNvhD2VXYoE0hLEm
	R3eFv+dZzqTSyZ5Y8RppbLSy10hmQcNYY3fjUNutfFYqYbZK5vOJpJTl18tz01kTNudTX4TLLLM
	kTcD/ZKWEkkCfsfg2cwVPRcq4PCQ=
X-Google-Smtp-Source: AGHT+IEpzBVjnCrXhEBnu2lSobPpKtDHuXvGxmAT8ZYzNt2+42iPSfn7yazIhfwHqyJzZMDwiMCBlhESEijS755tORQ=
X-Received: by 2002:adf:a158:0:b0:343:64be:b543 with SMTP id
 r24-20020adfa158000000b0034364beb543mr1784056wrr.57.1712342342205; Fri, 05
 Apr 2024 11:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho> <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org> <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com> <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
In-Reply-To: <20240405151703.GF5383@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 5 Apr 2024 11:38:25 -0700
Message-ID: <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:17=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
> > > Alex already indicated new features are coming, changes to the core
> > > code will be proposed. How should those be evaluated? Hypothetically
> > > should fbnic be allowed to be the first implementation of something
> > > invasive like Mina's DMABUF work? Google published an open userspace
> > > for NCCL that people can (in theory at least) actually run. Meta woul=
d
> > > not be able to do that. I would say that clearly crosses the line and
> > > should not be accepted.
> >
> > Why not? Just because we are not commercially selling it doesn't mean
> > we couldn't look at other solutions such as QEMU. If we were to
> > provide a github repo with an emulation of the NIC would that be
> > enough to satisfy the "commercial" requirement?
>
> My test is not "commercial", it is enabling open source ecosystem vs
> benefiting only proprietary software.

Sorry, that was where this started where Jiri was stating that we had
to be selling this.

> In my hypothetical you'd need to do something like open source Meta's
> implementation of the AI networking that the DMABUF patches enable,
> and even then since nobody could run it at performance the thing is
> pretty questionable.
>
> IMHO publishing a qemu chip emulator would not advance the open source
> ecosystem around building a DMABUF AI networking scheme.

Well not too many will be able to afford getting the types of systems
and hardware needed for this in the first place. Primarily just your
large data center companies can afford it.

I never said this hardware is about enabling DMABUF. You implied that.
The fact is that this driver is meant to be a pretty basic speeds and
feeds device. We support header split and network flow classification
so I suppose it could be used for DMABUF but by that logic so could a
number of other drivers.

> > > So I think there should be an expectation that technically sound thin=
gs
> > > Meta may propose must not be accepted because they cross the
> > > ideological red line into enabling only proprietary software.
> >
> > That is a faulty argument. That is like saying we should kick out the
> > nouveu driver out of Linux just because it supports Nvidia graphics
> > cards that happen to also have a proprietary out-of-tree driver out
> > there,
>
> Huh? nouveau supports a fully open source mesa graphics stack in
> Linux. How is that remotely similar to what I said? No issue.

Right, nouveau is fully open source. That is what I am trying to do
with fbnic. That is what I am getting at. This isn't connecting to
some proprietary stack or engaging in any sort of bypass. It is going
through the standard networking stack. If there were some other
out-of-tree driver for this to support some other use case how would
that impact the upstream patch submission?

This driver is being NAKed for enabling stuff that hasn't even been
presented. It is barely enough driver to handle PXE booting which is
needed to be able to even load an OS on the system. Yet somehow
because you are expecting a fork to come in at some point to support
DMABUF you are wanting to block it outright. How about rather than
doing that we wait until there is something there that is
objectionable before we start speculating on what may be coming.

> You pointed at two things that I would consider to be exemplar open
> source projects and said their existance somehow means we should be
> purging drivers from the kernel???
>
> I really don't understand what you are trying to say at all.

I'm trying to say that both those projects are essentially doing the
same thing you are accusing fbnic of doing, even though I am exposing
no non-standard API(s) and everything is open source. You are
projecting future changes onto this driver that don't currently and
may never exist.

> The kernel standard is that good quality open source *does* exist, we
> tend to not care what proprietary things people create beyond that.

Now I am confused. You say you don't care what happens later, but you
seem to be insisting you care about what proprietary things will be
done with it after it is upstreamed.

> > I can't think of many NIC vendors that don't have their own
> > out-of-tree drivers floating around with their own kernel bypass
> > solutions to support proprietary software.
>
> Most of those are also open source, and we can't say much about what
> people do out of tree, obviously.

Isn't that exactly what you are doing though with all your
"proprietary" comments?

> > I agree. We need a consistent set of standards. I just strongly
> > believe commercial availability shouldn't be one of them.
>
> I never said commercial availability. I talked about open source vs
> proprietary userspace. This is very standard kernel stuff.
>
> You have an unavailable NIC, so we know it is only ever operated with
> Meta's proprietary kernel fork, supporting Meta's proprietary
> userspace software. Where exactly is the open source?

It depends on your definition of "unavailable". I could argue that for
many most of the Mellanox NICs are also have limited availability as
they aren't exactly easy to get a hold of without paying a hefty
ransom.

The NIC is currently available to developers within Meta. As such I
know there are not a small number of kernel developers who could get
access to it if they asked for a login to one of our test and
development systems. Also I offered to provide the QEMU repo, but you
said you had no interest in that option.

> Why should someone working to improve only their proprietary
> environment be welcomed in the same way as someone working to improve
> the open source ecosystem? That has never been the kernel communities
> position.

To quote Linus `I do not see open source as some big goody-goody
"let's all sing kumbaya around the campfire and make the world a
better place". No, open source only really works if everybody is
contributing for their own selfish reasons.`[1]

How is us using our own NIC any different than if one of the vendors
were to make a NIC exclusively for us or any other large data center?
The only reason why this is coming up is because Meta is not a typical
NIC vendor but normally a consumer. The fact that we will be
dogfooding our own NIC seems to be at the heart of the issue here.

Haven't there been a number of maintainers who end up maintaining code
bases in the kernel for platforms and/or devices where they own one of
the few devices available in the world? How would this be any
different. Given enough time it is likely this will end up in the
hands of those outside Meta anyway, at that point the argument would
be moot.

> If you want to propose things to the kernel that can only be
> meaningfully used by your proprietary software then you should not
> expect to succeed. No one should be surprised to hear this.

If the whole idea is to get us to run a non-proprietary stack nothing
sends the exact opposite message like telling us we cannot upstream a
simple network driver because of a "what if" about some DMABUF patch
set from Google. All I am asking for is the ability to net install a
system with this device. That requires the driver to be available in
the provisioning kernel image, so thus why I am working to upstream it
as I would rather not have to maintain an out-of-tree kernel driver.

The argument here isn't about proprietary software. It is proprietary
hardware that seems to be the issue, or at least that is where it
started. The driver itself anyone could load, build, or even run on
QEMU as I mentioned. It is open source and not exposing any new APIs.
The issue seems to be with the fact that the NIC can't be bought from
a vendor and instead Meta is building the NIC for it's own
consumption.

As far as the software stack the concern about DMABUF seems like an
orthogonal argument that should be had at the userspace/API level and
doesn't directly relate to any specific driver. As has been pointed
out enabling anything like that wouldn't be a single NIC solution and
to be accepted upstream it should be implemented on at least 2
different vendor drivers.  Additionally, there isn't anything unique
about this hardware that would make it more capable of enabling that
than any other device.

Thanks,

- Alex

[1]: https://www.bbc.com/news/technology-18419231
