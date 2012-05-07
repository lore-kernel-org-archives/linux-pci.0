Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120507011722.GA8122@richard>
References: <CAE9FiQXLxEEu68tJvph3LB53nqycK+YctwDKMEF824koXVM5AA@mail.gmail.com>
	<20120503065455.GA30042@richard>
	<CAE9FiQUVNA_jdRfsSR9Rv47aa6JX-HKET0z3SfK19wT=Fcd9Cg@mail.gmail.com>
	<20120504024721.GA6775@richard>
	<CAE9FiQUz2w815gU5vY5b0BPf+1pz_pafgzqVKizJC++z27RTaQ@mail.gmail.com>
	<20120504045205.GA21624@richard>
	<CAE9FiQWM4OTFp5NN+KOXxNREQxNWipDjWbbPPiHHJsb6yFmuiQ@mail.gmail.com>
	<20120506151715.GA7773@richard>
	<CAE9FiQWsSWK-_zGe1ggaKuZu+RJ1kb1zuTEokdxqFSbE3UjNRw@mail.gmail.com>
	<CAE9FiQXKjxLDLeh8TXU_OCNwFt+UMv3qFjcPrKcPcorA1YmkdQ@mail.gmail.com>
	<20120507011722.GA8122@richard>
Date: Sun, 6 May 2012 19:04:09 -0700
Message-ID: <CAE9FiQUpcJdAvK=wisNc_zq5c9zDtgEM=MNugDcHN9h3=ZPUcA@mail.gmail.com>
Subject: Re: One problem in reassign pci bus number?
From: Yinghai Lu <yinghai@kernel.org>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang.kernel@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 6, 2012 at 6:17 PM, Richard Yang <weiyang@linux.vnet.ibm.com> wrote:
> so this free space will be combined with the free space got from
> parent, form a big space to meet the requirement.
>
> This is the general idea about probe_resource()?
>
> And this is the design decision to find the free space at the end
> of top, even at the start we have more free space?

no, probe_resource will get from start if space is big enough.

if not, it will try to extend top.

Yinghai
