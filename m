Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dexuan Cui <decui@microsoft.com>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
CC: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Simon Xiao" <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Jork Loeser" <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Date: Sat, 23 Dec 2017 01:35:12 +0000
Message-ID: <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20171218101131.GA5338@amd>
 <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
In-Reply-To: <20171222222917.GA1138@arch-chirva.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> Sent: Friday, December 22, 2017 14:29
>=20
> The output of that precise command run just now on a freshly-compiled
> copy of that commit is attached.
>=20
> On Fri, Dec 22, 2017 at 09:31:28PM +0000, Dexuan Cui wrote:
> > > From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> > > Sent: Friday, December 22, 2017 06:21
> > >
> > > In the absence of logs, the best I can do at the moment is attach a
> > > picture of the screen I am presented with on the apic=3Ddebug boot
> > > attempt.
> > > Alex
> >
> > The panic happens in irq_matrix_assign_system+0x4e/0xd0 in your picture=
.
> > IMO we should find which line of code causes the panic. I suppose
> > "objdump -D kernel/irq/matrix.o" can help to do that.
> >
> > Thanks,
> > -- Dexuan

The BUG_ON panic happens at line 147:
                   BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));

I'm sure Thomas and Dou know it better than me.=20

137 void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
138                               bool replace)
139 {
140         struct cpumap *cm =3D this_cpu_ptr(m->maps);
141
142         BUG_ON(bit > m->matrix_bits);
143         BUG_ON(m->online_maps > 1 || (m->online_maps && !replace));
144
145         set_bit(bit, m->system_map);
146         if (replace) {
147                 BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
148                 cm->allocated--;
149                 m->total_allocated--;
150         }
151         if (bit >=3D m->alloc_start && bit < m->alloc_end)
152                 m->systembits_inalloc++;
153
154         trace_irq_matrix_assign_system(bit, m);
155 }

-- Dexuan
