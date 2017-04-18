Return-Path: <SRS0=0XAo=32=intel.com=elena.reshetova@kernel.org>
Return-Path: <SRS0=0XAo=32=intel.com=elena.reshetova@kernel.org>
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Stephen Hemminger <sthemmin@microsoft.com>, Kees Cook
	<keescook@chromium.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "Hans
 Liljestrand" <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>
Subject: RE: [PATCH 17/29] drivers, pci: convert hv_pci_dev.refs from
 atomic_t to refcount_t
Date: Tue, 18 Apr 2017 10:40:03 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C8C518@IRSMSX102.ger.corp.intel.com>
References: <1488810076-3754-1-git-send-email-elena.reshetova@intel.com>
	<1488810076-3754-18-git-send-email-elena.reshetova@intel.com>
	<20170306213829.GB5305@bhelgaas-glaptop.roam.corp.google.com>
 <20170307115808.16f5235e@xeon-e3>
In-Reply-To: <20170307115808.16f5235e@xeon-e3>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> On Mon, 6 Mar 2017 15:38:29 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> > [+cc Hyper-V folks, -cc others]
> >
> > On Mon, Mar 06, 2017 at 04:21:04PM +0200, Elena Reshetova wrote:
> > > refcount_t type and corresponding API should be
> > > used instead of atomic_t when the variable is used as
> > > a reference counter. This allows to avoid accidental
> > > refcounter overflows that might lead to use-after-free
> > > situations.
> > >
> > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
>=20
>=20
> Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>

Getting back on this: could you take the patch via your tree or should I re=
submit to some dedicated place with a new review-by added?

Best Regards,
Elena
