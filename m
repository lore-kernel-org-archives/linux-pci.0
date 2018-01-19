Return-Path: <SRS0=P7E9=EO=huawei.com=weiyongjun1@kernel.org>
Return-Path: <SRS0=P7E9=EO=huawei.com=weiyongjun1@kernel.org>
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
To: Ladislav Michl <ladis@linux-mips.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Date: Fri, 19 Jan 2018 01:54:58 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB401337E23@dggemi507-mbx.china.huawei.com>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
 <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
 <20180118213417.GA30723@lenoch>
In-Reply-To: <20180118213417.GA30723@lenoch>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> On Thu, Jan 18, 2018 at 12:35:25PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 18, 2018 at 03:54:20PM +0100, Ladislav Michl wrote:
> > > On Thu, Jan 18, 2018 at 02:00:37PM +0000, Wei Yongjun wrote:
> > > > platform_get_resource_byname() may fail and return NULL, so we
> should
> > > > better check it's return value to avoid a NULL pointer dereference =
a
> > > > bit later in the code.
> > > >
> > > > This is detected by Coccinelle semantic patch.
> > > >
> > > > @@
> > > > expression pdev, res, n, t, e, e1, e2;
> > > > @@
> > > >
> > > > res =3D platform_get_resource_byname(pdev, t, n);
> > > > + if (!res)
> > > > +   return -EINVAL;
> > > > ... when !=3D res =3D=3D NULL
> > > > e =3D devm_ioremap(e1, res->start, e2);
> > >
> > > Well, then it should be replaced with devm_ioremap_resource()
> > > which already checks for NULL and the right resource type
> > > (IORESOURCE_MEM).
> >
> > That's probably a better idea.  Maybe we should add a comment like this
> > to help avoid this in the future:

Not all of the place using devm_ioremap() can be replaced with
devm_ioremap_resource(), devices share the memory resource for example.

So maybe you should also add an exception list to the comment, otherwise
many people still not know how to use devm_ioremap_resource() or devm_iorem=
ap().

> >
> > --- a/lib/devres.c
> > +++ b/lib/devres.c
> > @@ -22,6 +22,8 @@ static int devm_ioremap_match(struct device *dev,
> void *res, void *match_data)
> >   * @size: Size of map
> >   *
> >   * Managed ioremap().  Map is automatically unmapped on driver detach.
> > + *
> > + * When possible, use devm_ioremap_resource() instead.
> >   */
> >  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
> >  			   resource_size_t size)
>=20
> Yes, please. It would be nice first patch in the serie converting existin=
g
> users of devm_ioremap into devm_ioremap_resource:
> find drivers -name "*.c" | xargs grep "devm_ioremap(" | grep resource_siz=
e
> | wc -l
> 82
> I know, that was dumb, Coccinelle would certainly do better job.
> And from a quick look a lot of
> if (!res) {
> 	print error
> 	return -EINVAL;
> }
> code blocks could be deleted (and many cases where check for NULL
> resource
> is missing fixed).
>=20
