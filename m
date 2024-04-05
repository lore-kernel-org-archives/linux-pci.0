Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57417BA0;
	Fri,  5 Apr 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331712; cv=none; b=urHcfTh/lxPsl6PyPCHxNk9sWmoSUlDsUyq/pOAaJzGCE4rEwpB956RD9mzGxb952JTu5ETrS0An6WG0qym2uDQWZZ5zg0MURXqregFuQsRPIHaEu2CsRt/4szqIFoMZmctU5WFcMl7ir6b8OIvRhjPjwcOTcRfpLJa+3jbFtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331712; c=relaxed/simple;
	bh=ZVIunp5/b3ua5z68fg7CkpvbQK47x3IgXrmASVT294A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOcZD3qZTMLso0dPIQJvCx4vuZIQEDt7nASRGHuNoGAQI+L8B35tkICMNn8g1Gfe96Bq31KXOKMC52gHPBxr3pqo1WJU9caoKZMNcJHesyJR+v31r9oyfzyzuNYWa0tUMMym5AnJnRB9RXv0ykW4UlAwUGmORZWX3WYXjIuEBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxBxDbdK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxBxDbdK"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d715638540so28858121fa.3;
        Fri, 05 Apr 2024 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331709; x=1712936509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af4tFSueF3LyD09l18VwVzYXA4EAvWmGHq3uEV1NWcA=;
        b=kxBxDbdKeUMzqS1kM1FD9qog/nYs7JYzKJDErJPya5LjCbq9u1C/oQqnq21UKs2yy7
         u4k+GoT9zBFJK5LlXxU/ZtNkd0A3/Wky2wvymoZmMK7ggCz75rkV4kzt8RQtng/zuqib
         cCjBuZbF3BaymbQFf/IYCZzQ9gM20Aecv1p8zv314T27y4gzV4x7IJgxjogRdO3m9eW6
         P9pPOY8+KUyQFgxlAmvf+xEhI4b7orsjwTWI7+Lmmucp5dxAJhQmAwSvGolJZpVfynDh
         RV1sWIOGIUGpExtR7Ga799q3OlUcykYXVH0239121JoOF+yOHpuOS5jepnXJmozuRH2E
         QUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331709; x=1712936509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af4tFSueF3LyD09l18VwVzYXA4EAvWmGHq3uEV1NWcA=;
        b=vQvYWPZr1oQLehMlhiYbMqbupxfS4K6CuX/PZlpNEYeDKOR0WzVGHRfrQ2SXwKbOnB
         ZnOO2NYKnoAIPAz9lQfHbc9SenGWvDI+mTFyqcrscnRdvyw4EVP/q07nkfgQdAVLhIB9
         05Lqv0EfnfUxFmdUapXRyyGFpY2HYhcxxqQJPElf5tBrL5xTX/C0mDu033TjorfDbFyN
         uL0sD7Hb0F3T85+R0/ok77dt0+zqViaNPyh7RL7a+ziwEDW+/dXXpQ5OZ7olCBEEcSLq
         iPTQOuPQK/6uDQ9h3924Ox87uu1k2IvLfOWFsno5xVzn74g61xXesf6cerJOZKvIKQpM
         mLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG8n4bPcROi02mj9h3nGvnqZGqxop/gvA8iSLE4YXDAMXRvXVD/oC0rwLzSPLvO7W/G2PX+zi9XpanqwnXoSm7OGjVlLDRz/PVynAOwRNzQFE862P5QuHl8Ih82Guf4G7Y
X-Gm-Message-State: AOJu0YyY5sMeDwiblWgjqsNj3+uS4CDGrqDM8CkJeDRj45+HQYA5v2QE
	5Hu/2WV1ykbdm4REFti8uDQ5jqBhWzusV5lmpg4WB55zBoEOtPqlQAM0WC7fUpXgxwVPol9eiTN
	SMEtkTj3JSeypqqUfZw6teUbd9H9vKEv1
X-Google-Smtp-Source: AGHT+IHUMqhpaA35BIk5Mvh9BR4JQ3pcLfam7lZaR6ADv1a8WRegNIjyWKhFr/AemARy2FCk3a9gNjdkngZj1f7MwjU=
X-Received: by 2002:a2e:bc20:0:b0:2d6:d536:41ca with SMTP id
 b32-20020a2ebc20000000b002d6d53641camr2085346ljf.4.1712331708386; Fri, 05 Apr
 2024 08:41:48 -0700 (PDT)
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
 <20240404193817.500523aa@kernel.org>
In-Reply-To: <20240404193817.500523aa@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 5 Apr 2024 08:41:11 -0700
Message-ID: <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 4 Apr 2024 17:11:47 -0700 Alexander Duyck wrote:
> > > Opensourcing is just one push to github.
> > > There are guarantees we give to upstream drivers.
> >
> > Are there? Do we have them documented somewhere?
>
> I think they are somewhere in Documentation/
> To some extent this question in itself supports my point that written
> down rules, as out of date as they may be, seem to carry more respect
> than what a maintainer says :S

I think the problem is there are multiple maintainers and they all
have different ways of doing things. As a submitter over the years I
have had to deal with probably over a half dozen different maintainers
and each experience has been different. I have always argued that the
netdev tree is one of the better maintained setups.

> > > > Eventually they need some kernel changes and than we block those to=
o
> > > > because we didn't allow the driver that was the use case? This seem=
s
> > > > wrong to me.
> > >
> > > The flip side of the argument is, what if we allow some device we don=
't
> > > have access to to make changes to the core for its benefit. Owner
> > > reports that some changes broke the kernel for them. Kernel rules,
> > > regression, we have to revert. This is not a hypothetical, "less than
> > > cooperative users" demanding reverts, and "reporting us to Linus"
> > > is a reality :(
> > >
> > > Technical solution? Maybe if it's not a public device regression rule=
s
> > > don't apply? Seems fairly reasonable.
> >
> > This is a hypothetical. This driver currently isn't changing anything
> > outside of itself. At this point the driver would only be build tested
> > by everyone else. They could just not include it in their Kconfig and
> > then out-of-sight, out-of-mind.
>
> Not changing does not mean not depending on existing behavior.
> Investigating and fixing properly even the hardest regressions in
> the stack is a bar that Meta can so easily clear. I don't understand
> why you are arguing.

I wasn't saying the driver wouldn't be dependent on existing behavior.
I was saying that it was a hypothetical that Meta would be a "less
than cooperative user" and demand a revert.  It is also a hypothetical
that Linus wouldn't just propose a revert of the fbnic driver instead
of the API for the crime of being a "less than cooperative maintainer"
and  then give Meta the Nvidia treatment.

> > > > Anyways we have zero ways to enforce such a policy. Have vendors
> > > > ship a NIC to somebody with the v0 of the patch set? Attach a pictu=
re?
> > >
> > > GenAI world, pictures mean nothing :) We do have a CI in netdev, whic=
h
> > > is all ready to ingest external results, and a (currently tiny amount=
?)
> > > of test for NICs. Prove that you care about the device by running the
> > > upstream tests and reporting results? Seems fairly reasonable.
> >
> > That seems like an opportunity to be exploited through. Are the
> > results going to be verified in any way? Maybe cryptographically
> > signed? Seems like it would be easy enough to fake the results.
>
> I think it's much easier to just run the tests than write a system
> which will competently lie. But even if we completely suspend trust,
> someone lying is of no cost to the community in this case.

I don't get this part. You are paranoid about bad actors until it
comes to accepting the test results? So write a broken API, "prove" it
works by running it on your broken test setup, and then get it
upstream after establishing a false base for trust. Seems like a
perfect setup for an exploit like what happened with the xz setup.

> > > > Even if vendor X claims they will have a product in N months and
> > > > than only sells it to qualified customers what to do we do then.
> > > > Driver author could even believe the hardware will be available
> > > > when they post the driver, but business may change out of hands
> > > > of the developer.
> > > >
> > > > I'm 100% on letting this through assuming Alex is on top of feedbac=
k
> > > > and the code is good.
> > >
> > > I'd strongly prefer if we detach our trust and respect for Alex
> > > from whatever precedent we make here. I can't stress this enough.
> > > IDK if I'm exaggerating or it's hard to appreciate the challenges
> > > of maintainership without living it, but I really don't like being
> > > accused of playing favorites or big companies buying their way in :(
> >
> > Again, I would say we look at the blast radius. That is how we should
> > be measuring any change. At this point the driver is self contained
> > into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
> > outside that directory, and it can be switched off via Kconfig.
>
> It is not practical to ponder every change case by case. Maintainers
> are overworked. How long until we send the uAPI patch for RSS on the
> flow label? I'd rather not re-litigate this every time someone posts
> a slightly different feature. Let's cover the obvious points from
> the beginning while everyone is paying attention. We can amend later
> as need be.

Isn't that what we are doing right now? We are basically refusing this
patch set not based on its own merits but on a "what-if" scenario for
a patch set that might come at some point in the future and conjecture
that somehow it is going to be able to add features for just itself
when we haven't allowed that for in the past, for example with things
like GSO partial.

> > When the time comes to start adding new features we can probably start
> > by looking at how to add either generic offloads like was done for
> > GSO, CSO, ect or how it can also be implemented on another vendor's
> > NIC.
> >
> > At this point the only risk the driver presents is that it is yet
> > another driver, done in the same style I did the other Intel drivers,
> > and so any kernel API changes will end up needing to be applied to it
> > just like the other drivers.
>
> The risk is we'll have a fight every time there is a disagreement about
> the expectations.

We always do. I am not sure why you would expect that would change by
blocking this patch set. If anything it sounds like maybe we need to
document some requirements for availability for testing, and
expectations for what it would mean to be a one-off device where only
one entity has access to it. However that is a process problem, and
not so much a patch or driver issue.

> > > > I think any other policy would be very ugly to enforce, prove, and
> > > > even understand. Obviously code and architecture debates I'm all fo=
r.
> > > > Ensuring we have a trusted, experienced person signed up to review
> > > > code, address feedback, fix whatever syzbot finds and so on is also=
 a
> > > > must I think. I'm sure Alex will take care of it.
> > >
> > > "Whatever syzbot finds" may be slightly moot for a private device ;)
> > > but otherwise 100%! These are exactly the kind of points I think we
> > > should enumerate. I started writing a list of expectations a while ba=
ck:
> > >
> > > Documentation/maintainer/feature-and-driver-maintainers.rst
> > >
> > > I think we just need something like this, maybe just a step up, for
> > > non-public devices..
> >
> > I honestly think we are getting the cart ahead of the horse. When we
> > start talking about kernel API changes then we can probably get into
> > the whole "private" versus "publicly available" argument. A good
> > example of the kind of thing I am thinking of is GSO partial where I
> > ended up with Mellanox and Intel sending me 40G and 100G NICs and
> > cables to implement it on their devices as all I had was essentially
> > igb and ixgbe based NICs.
>
> That'd be great. Maybe even more than I'd expect. So why not write
> it down? In case the person doing the coding is not Alex Duyck, and
> just wants to get it done for their narrow use case, get a promo,
> go work on something else?

Write what down? That the vendors didn't like me harassing them to
test my code so they shipped me the NICs and asked me to just test it
myself?

That worked in my scenario as I had a server level system in my home
lab to make that work. We cannot expect everyone to have that kind of
setup for their own development. That is why I am considering the QEMU
approach as that might make this a bit more accessible. I could then
look at enabling the QEMU at the same time I enable the driver.

> > Odds are when we start getting to those kind of things maybe we need
> > to look at having a few systems available for developer use, but until
> > then I am not sure it makes sense to focus on if the device is
> > publicly available or not.
>
> Developer access would be huge.
> A mirage of developer access? immaterial :)

If nothing else, maybe we need a writeup somewhere of the level of
support a driver should expect from the Linux community if the device
is not "easily available". We could probably define that in terms of
what a reasonable expectation would be for a developer to have access
to it.

I would say that "commercial sales" is not a good metric and shouldn't
come into it. If anything it would be about device availability for
development and testing.

In addition I would be good with a definition of "support" for the
case of a device that isn't publicly available being quite limited, as
those with access would have to have active involvement in the
community to enable support. Without that it might as well be
considered orphaned and the driver dropped.
