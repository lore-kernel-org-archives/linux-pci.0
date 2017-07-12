Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54005 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752182AbdGLNyE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 09:54:04 -0400
Date: Wed, 12 Jul 2017 15:53:57 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>, albert@sifive.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        sstabellini@kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Salter <msalter@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@groups.riscv.org
Subject: Re: RISC-V Linux Port v6
Message-ID: <20170712135357.GU21846@wotan.suse.de>
References: <20170712013130.14792-1-palmer@dabbelt.com>
 <CAK8P3a2FhHhTwNErhqwijsYsOOmhMBuyx7EeSyBu00=Q-N8Viw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a2FhHhTwNErhqwijsYsOOmhMBuyx7EeSyBu00=Q-N8Viw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 09:58:01AM +0200, Arnd Bergmann wrote:
> On Wed, Jul 12, 2017 at 3:31 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > At this point I'm not really sure how to proceed: reviews have calmed down
> > quite a bit over the last two weeks, but I'm not familiar with the Linux
> > development process enough to know how to get closer to upstream.  Is this
> > ready for inclusion into another tree?  If so, is linux-next the right tree to
> > work off of?
> 
> For the pci patch, ask Bjorn if he has a preference whether he wants
> to merge the patch or have you put it into your tree with his
> 'Acked-by' tag.

There is one pending issue with these patches, but other than the above
possibility the other one is to see if Bjorn is OK for these 2 PCI patches
to go through Andrew's tree for the current merge window with his Acked-by.

> > Of course, if anyone has outstanding code reviews then feel free to submit them
> > either to this patch set or a previous one (v5 is essentially the same, and v4
> > is mostly some small SMP fixes).  I don't want to rush anyone by re-submitting
> > so quickly, it's just that my usual protocol has been sped up.
> >
> > As usual, the patch set has been posted to our Git Hub page
> >
> >   https://github.com/riscv/riscv-linux/tree/riscv-for-submission-v6
> 
> There are a couple of downsides to hosting the git tree on github,
> so as you get nearer to inclusion, you should decide whether to
> have your own git server on riscv.org or sifive.com, or to get an
> account on kernel.org.
> 
> You should also make sure you get your gpg key signed by other
> kernel maintainers so you can properly sign git tags for pull requests.

I've met Palmer in person, and at the sifive offices and signed his key.
Recently Chris Metcalf <cmetcalf@tilera.com> also signed his key.

Indeed a kernel.org tree would be nicer, Palmer have you requested an
account yet?

  Luis
