Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df0bb7cd6a3e11ec12d3e1a6c1f98351f4aea3ce.1481926599.git.lukas@wunner.de>
References: <cover.1481926599.git.lukas@wunner.de> <df0bb7cd6a3e11ec12d3e1a6c1f98351f4aea3ce.1481926599.git.lukas@wunner.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Dec 2016 01:05:10 +0200
Message-ID: <CAHp75VfzuTaBpZd+Hu2uHbhAPHzHQDdPOwOvb9ejP2j22OWoog@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] thunderbolt: Power down controller when idle
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Amir Levy <amir.jer.levy@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 17, 2016 at 4:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Document and implement Apple's ACPI-based (but nonstandard) pm mechanism
> for Thunderbolt.  Briefly, an ACPI method provided by Apple is used to
> cut power to the controller.  A GPE is enabled while the controller is
> powered down which sideband-signals a plug event, whereupon we reinstate
> power using the ACPI method.
>
> This saves 1.7 W on machines with a Light Ridge controller and is
> reported to save 4 W on Cactus Ridge 4C and Falcon Ridge 4C.  (I believe
> 4 W includes the bus power drawn by Apple's Gigabit Ethernet adapter.)
> It fixes (at least partially) a power regression introduced in 3.17 by
> commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly").
>

> +++ b/drivers/thunderbolt/power.c
> @@ -0,0 +1,347 @@

> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "power.h"
> +

> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif

Perhaps just define pr_fmt before any other include?
We have such check where actually default pr_fmt is defined. No need
to duplicate.

> +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
> +

> +       /* prevent interrupts during system sleep transition */
> +       if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
> +               pr_err("cannot disable wake GPE, resuming\n");

dev_err?

> +               pm_request_resume(dev);
> +               return -EAGAIN;
> +       }
> +
> +       return DPM_DIRECT_COMPLETE;
> +}



> +       pr_info("resetting power switch\n");
> +       if (ACPI_FAILURE(acpi_execute_simple_method(power->set, NULL, 0))) {
> +               pr_err("cannot call power->set method\n");
> +               dev->power.runtime_error = -EIO;
> +       }
> +
> +       if (ACPI_FAILURE(acpi_enable_gpe(NULL, power->wake_gpe))) {
> +               pr_err("cannot enable wake GPE, resuming\n");
> +               pm_request_resume(dev);
> +       }

Ditto. pr_ -> dev_ ?

Also in the rest of code where applicable.

> +       /*
> +        * On gen 2 controllers, the wake GPE fires as long as the controller
> +        * is powered up. Poll until it's powered down before enabling the GPE.
> +        */
> +       for (i = 0; i < 300; i++) {

300 is magic.

> +               if (ACPI_FAILURE(acpi_evaluate_integer(power->get,
> +                                             NULL, NULL, &powered_down))) {
> +                       pr_err("cannot call power->get method, resuming\n");
> +                       goto err;
> +               }
> +               if (powered_down)
> +                       break;

> +               usleep_range(800, 1600);

Why 800? Perhaps comment on this.

> +       }
> +       if (!powered_down) {
> +               pr_err("refused to power down, resuming\n");
> +               goto err;
> +       }
> +
> +       if (ACPI_FAILURE(acpi_enable_gpe(NULL, power->wake_gpe))) {
> +               pr_err("cannot enable wake GPE, resuming\n");
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:

err_resume: ?

> +       acpi_execute_simple_method(power->set, NULL, 1);
> +       dev->bus->pm->runtime_resume(dev);
> +       pci_walk_bus(pdev->subordinate, request_resume, NULL);
> +       return -EAGAIN;
> +}

> +void thunderbolt_power_init(struct tb *tb)
> +{
> +       struct device *upstream_dev, *nhi_dev = &tb->nhi->pdev->dev;
> +       struct tb_power *power = NULL;
> +       struct acpi_handle *nhi_handle;
> +
> +       power = kzalloc(sizeof(*power), GFP_KERNEL);
> +       if (!power) {
> +               dev_err(nhi_dev, "cannot allocate power data\n");
> +               goto err;
> +       }
> +
> +       nhi_handle = ACPI_HANDLE(nhi_dev);
> +       if (!nhi_handle) {
> +               dev_err(nhi_dev, "cannot find ACPI handle\n");
> +               goto err;
> +       }
> +
> +       /* Macs introduced 2011/2012 have XRPE, 2013+ have TRPE */
> +       if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRPE", &power->set)) &&
> +           ACPI_FAILURE(acpi_get_handle(nhi_handle, "TRPE", &power->set))) {
> +               dev_err(nhi_dev, "cannot find power->set method\n");
> +               goto err;
> +       }
> +
> +       if (ACPI_FAILURE(acpi_get_handle(nhi_handle, "XRIL", &power->get))) {
> +               dev_err(nhi_dev, "cannot find power->get method\n");
> +               goto err;
> +       }
> +
> +       if (ACPI_FAILURE(acpi_evaluate_integer(nhi_handle, "XRIN", NULL,
> +                                                       &power->wake_gpe))) {
> +               dev_err(nhi_dev, "cannot find wake GPE\n");
> +               goto err;
> +       }
> +
> +       if (ACPI_FAILURE(acpi_install_gpe_handler(NULL, power->wake_gpe,
> +                            ACPI_GPE_LEVEL_TRIGGERED, nhi_wake, nhi_dev))) {
> +               dev_err(nhi_dev, "cannot install GPE handler\n");
> +               goto err;
> +       }
> +
> +       if (!nhi_dev->parent || !nhi_dev->parent->parent) {
> +               dev_err(nhi_dev, "cannot find upstream bridge\n");
> +               goto err;
> +       }
> +       upstream_dev = nhi_dev->parent->parent;
> +
> +       pci_walk_bus(to_pci_dev(upstream_dev)->bus, disable_pme_poll,
> +                    to_pci_dev(upstream_dev)->subordinate);
> +
> +       power->pm_domain.ops                 = *upstream_dev->bus->pm;
> +       power->pm_domain.ops.prepare         =  upstream_prepare;
> +       power->pm_domain.ops.complete        =  upstream_complete;
> +       power->pm_domain.ops.runtime_suspend =  upstream_runtime_suspend;
> +       power->pm_domain.ops.runtime_resume  =  upstream_runtime_resume;
> +       power->tb                            =  tb;
> +       dev_pm_domain_set(upstream_dev, &power->pm_domain);
> +
> +       tb->power = power;
> +
> +       return;
> +
> +err:

err_free: ?

> +       dev_err(nhi_dev, "controller will stay powered up permanently\n");
> +       kfree(power);
> +}
> +
> +void thunderbolt_power_fini(struct tb *tb)
> +{
> +       struct device *nhi_dev = &tb->nhi->pdev->dev;
> +       struct device *upstream_dev = nhi_dev->parent->parent;
> +       struct tb_power *power = tb->power;
> +

> +       if (!power)
> +               return;

Would be the case?

> +
> +       tb->power = NULL;
> +       dev_pm_domain_set(upstream_dev, NULL);
> +
> +       if (ACPI_FAILURE(acpi_remove_gpe_handler(NULL, power->wake_gpe,
> +                                                nhi_wake)))
> +               dev_err(nhi_dev, "cannot remove GPE handler\n");
> +
> +       kfree(power);
> +}

-- 
With Best Regards,
Andy Shevchenko
