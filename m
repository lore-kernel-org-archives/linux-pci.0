Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Nov 2017 13:29:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: endpoint: handle probable NULL pointer access
Message-ID: <20171106192923.GD31930@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20171012035806epcas1p16df484a0565cfe780416253710464a8f@epcas1p1.samsung.com>
 <1507780677-7983-1-git-send-email-pankaj.dubey@samsung.com>
 <20171024200200.GE21840@bhelgaas-glaptop.roam.corp.google.com>
 <6ee65418-8589-01c1-2156-67fbf881260a@ti.com>
 <CAGcde9E=DTTS01_FjGG2=_q-Luit_GfaXe3cVRToYxbnuKAy+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGcde9E=DTTS01_FjGG2=_q-Luit_GfaXe3cVRToYxbnuKAy+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 28, 2017 at 04:13:56PM +0530, Pankaj Dubey wrote:
> On 25 October 2017 at 17:32, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Hi,
> >
> > On Wednesday 25 October 2017 01:32 AM, Bjorn Helgaas wrote:
> >> On Thu, Oct 12, 2017 at 09:27:57AM +0530, Pankaj Dubey wrote:
> >>> controller_group allocation in pci_ep_cfs_init function can fail
> >>> so we should have a check while using it in pci_ep_cfs_add_epc_group
> >>> for registering group, else we will hit NULL pointer access.
> >>>
> >>> This patch adds required check for the same and returns -EPROBE_DEFER,
> >>> so that endpoint controller driver probe can be reattempted later
> >>> in case controller_group is not allocated because pci_ep_cfs_init is
> >>> not yet called.
> >>>
> >>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >>
> >> Looking for Kishon's ack here.
> >>
> >>> ---
> >>>  drivers/pci/endpoint/pci-ep-cfs.c   | 7 ++++++-
> >>>  drivers/pci/endpoint/pci-epc-core.c | 4 ++++
> >>>  2 files changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> >>> index 424fdd6..3cac818 100644
> >>> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> >>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> >>> @@ -172,7 +172,12 @@ struct config_group *pci_ep_cfs_add_epc_group(const char *name)
> >>>      group = &epc_group->group;
> >>>
> >>>      config_group_init_type_name(group, name, &pci_epc_type);
> >>> -    ret = configfs_register_group(controllers_group, group);
> >>> +
> >>> +    if (controllers_group)
> >>> +            ret = configfs_register_group(controllers_group, group);
> >>> +    else
> >>> +            ret = -EPROBE_DEFER;
> >>> +
> >
> > Do you ever face this issue?
> 
> Yes, I was adding support for PCIe endpoint in Exynos driver and if we
> see pci-exynos.c,
> platform_driver_probe is called via subsys_initcall, which will happen
> much before that module_init
> and during endpoint probe sequence I got kernel panic for NULL pointer access.
> 
> > Ideally controllers_group should always be
> > initialized if the dependencies are modeled properly.
> 
> Ideally Yes.
> 
> But we can't ignore error cases. Even though dependencies are modeled properly,
> this check is mandatory, if we see pci_ep_cfs_init function where
> "controllers_group" is suppose
> to be allocated via call to "configfs_register_default_group", is
> prone to failure as allocated via
> kzalloc. We are handling error condition in pci_ep_cfs_init if it
> fails to allocate "controllers_group"
> but during EP initialization sequence, there is no check on
> "controllers_group" pointer in
> "configfs_register_default_group" function. So I feel it should have a
> check for valid pointer.

It seems plausible to me to check whether controllers_group is NULL,
but it'd be nicer to do it *first* in the function so there's no
cleanup to do, e.g.,

  if (!controllers_group)
    return -EPROBE_DEFER;

  epc_group = kzalloc(sizeof(*epc_group), GFP_KERNEL);
  ...

> >>>      if (ret) {
> >>>              pr_err("failed to register configfs group for %s\n", name);
> >>>              goto err_register_group;
> >>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >>> index 42c2a11..d327a2a 100644
> >>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>> @@ -518,6 +518,10 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
> >>>              goto put_dev;
> >>>
> >>>      epc->group = pci_ep_cfs_add_epc_group(dev_name(dev));
> >>> +    if (IS_ERR(epc->group)) {
> >>> +            ret = -EPROBE_DEFER;
> >
> > should use the return value of pci_ep_cfs_add_epc_group().
> >
> 
> OK. Will modify in next version.
> 
> > However I don't think this is required since drivers might not actually need cfs.
> 
> Ok, we can avoid propagating error to the caller here, but in case if
> ERR_PTR there should be
> at least one warn message. What do you say?
> 
> 
> Thanks,
> Pankaj Dubey
> >
> > Thanks
> > Kishon
