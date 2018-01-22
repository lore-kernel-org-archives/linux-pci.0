Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:17498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeAVJaN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jan 2018 04:30:13 -0500
Date: Mon, 22 Jan 2018 17:30:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] devres: Move managed io function declarations into
 device.h
Message-ID: <201801221715.OdDnS1NF%fengguang.wu@intel.com>
References: <20180121211508.GB15151@lenoch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <20180121211508.GB15151@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ladislav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180119]
[also build test ERROR on v4.15-rc9]
[cannot apply to linus/master pci/next l2-mtd-boris/nand/next v4.15-rc8 v4.15-rc7 v4.15-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ladislav-Michl/Add-managed-ioremap-function-for-shared-resources/20180122-164512
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:23:0,
                    from drivers/base/dd.c:19:
   include/linux/pinctrl/devinfo.h:48:44: warning: 'struct device' declared inside parameter list will not be visible outside of this definition or declaration
    static inline int pinctrl_bind_pins(struct device *dev)
                                               ^~~~~~
   include/linux/pinctrl/devinfo.h:53:44: warning: 'struct device' declared inside parameter list will not be visible outside of this definition or declaration
    static inline int pinctrl_init_done(struct device *dev)
                                               ^~~~~~
   drivers/base/dd.c: In function 'really_probe':
>> drivers/base/dd.c:394:26: error: passing argument 1 of 'pinctrl_bind_pins' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret = pinctrl_bind_pins(dev);
                             ^~~
   In file included from include/linux/device.h:23:0,
                    from drivers/base/dd.c:19:
   include/linux/pinctrl/devinfo.h:48:19: note: expected 'struct device *' but argument is of type 'struct device *'
    static inline int pinctrl_bind_pins(struct device *dev)
                      ^~~~~~~~~~~~~~~~~
>> drivers/base/dd.c:451:20: error: passing argument 1 of 'pinctrl_init_done' from incompatible pointer type [-Werror=incompatible-pointer-types]
     pinctrl_init_done(dev);
                       ^~~
   In file included from include/linux/device.h:23:0,
                    from drivers/base/dd.c:19:
   include/linux/pinctrl/devinfo.h:53:19: note: expected 'struct device *' but argument is of type 'struct device *'
    static inline int pinctrl_init_done(struct device *dev)
                      ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pinctrl_bind_pins +394 drivers/base/dd.c

0ff26c662 Adrian Hunter      2017-11-02  360  
21c7f30b1 Cornelia Huck      2007-02-05  361  static int really_probe(struct device *dev, struct device_driver *drv)
07e4a3e27 Patrick Mochel     2005-03-21  362  {
013c074f8 Strashko, Grygorii 2015-11-10  363  	int ret = -EPROBE_DEFER;
58b116bce Grant Likely       2014-04-29  364  	int local_trigger_count = atomic_read(&deferred_trigger_count);
c5f062748 Rob Herring        2016-10-11  365  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
c5f062748 Rob Herring        2016-10-11  366  			   !drv->suppress_bind_attrs;
07e4a3e27 Patrick Mochel     2005-03-21  367  
013c074f8 Strashko, Grygorii 2015-11-10  368  	if (defer_all_probes) {
013c074f8 Strashko, Grygorii 2015-11-10  369  		/*
013c074f8 Strashko, Grygorii 2015-11-10  370  		 * Value of defer_all_probes can be set only by
013c074f8 Strashko, Grygorii 2015-11-10  371  		 * device_defer_all_probes_enable() which, in turn, will call
013c074f8 Strashko, Grygorii 2015-11-10  372  		 * wait_for_device_probe() right after that to avoid any races.
013c074f8 Strashko, Grygorii 2015-11-10  373  		 */
013c074f8 Strashko, Grygorii 2015-11-10  374  		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
013c074f8 Strashko, Grygorii 2015-11-10  375  		driver_deferred_probe_add(dev);
013c074f8 Strashko, Grygorii 2015-11-10  376  		return ret;
013c074f8 Strashko, Grygorii 2015-11-10  377  	}
013c074f8 Strashko, Grygorii 2015-11-10  378  
9ed989537 Rafael J. Wysocki  2016-10-30  379  	ret = device_links_check_suppliers(dev);
0ff26c662 Adrian Hunter      2017-11-02  380  	if (ret == -EPROBE_DEFER)
0ff26c662 Adrian Hunter      2017-11-02  381  		driver_deferred_probe_add_trigger(dev, local_trigger_count);
9ed989537 Rafael J. Wysocki  2016-10-30  382  	if (ret)
9ed989537 Rafael J. Wysocki  2016-10-30  383  		return ret;
9ed989537 Rafael J. Wysocki  2016-10-30  384  
d779249ed Greg Kroah-Hartman 2006-07-18  385  	atomic_inc(&probe_count);
7dc72b284 Greg Kroah-Hartman 2007-11-28  386  	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
1e0b2cf93 Kay Sievers        2008-10-30  387  		 drv->bus->name, __func__, drv->name, dev_name(dev));
9ac7849e3 Tejun Heo          2007-01-20  388  	WARN_ON(!list_empty(&dev->devres_head));
07e4a3e27 Patrick Mochel     2005-03-21  389  
bea5b158f Rob Herring        2016-08-11  390  re_probe:
07e4a3e27 Patrick Mochel     2005-03-21  391  	dev->driver = drv;
ab78029ec Linus Walleij      2013-01-22  392  
ab78029ec Linus Walleij      2013-01-22  393  	/* If using pinctrl, bind pins now before probing */
ab78029ec Linus Walleij      2013-01-22 @394  	ret = pinctrl_bind_pins(dev);
ab78029ec Linus Walleij      2013-01-22  395  	if (ret)
14b6257a5 Andy Shevchenko    2015-12-04  396  		goto pinctrl_bind_failed;
ab78029ec Linus Walleij      2013-01-22  397  
09515ef5d Sricharan R        2017-04-10  398  	ret = dma_configure(dev);
09515ef5d Sricharan R        2017-04-10  399  	if (ret)
09515ef5d Sricharan R        2017-04-10  400  		goto dma_failed;
09515ef5d Sricharan R        2017-04-10  401  
1901fb260 Kay Sievers        2006-10-07  402  	if (driver_sysfs_add(dev)) {
1901fb260 Kay Sievers        2006-10-07  403  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
1e0b2cf93 Kay Sievers        2008-10-30  404  			__func__, dev_name(dev));
1901fb260 Kay Sievers        2006-10-07  405  		goto probe_failed;
1901fb260 Kay Sievers        2006-10-07  406  	}
1901fb260 Kay Sievers        2006-10-07  407  
e90d55327 Rafael J. Wysocki  2015-03-20  408  	if (dev->pm_domain && dev->pm_domain->activate) {
e90d55327 Rafael J. Wysocki  2015-03-20  409  		ret = dev->pm_domain->activate(dev);
e90d55327 Rafael J. Wysocki  2015-03-20  410  		if (ret)
e90d55327 Rafael J. Wysocki  2015-03-20  411  			goto probe_failed;
e90d55327 Rafael J. Wysocki  2015-03-20  412  	}
e90d55327 Rafael J. Wysocki  2015-03-20  413  
52cdbdd49 Grygorii Strashko  2015-07-27  414  	/*
52cdbdd49 Grygorii Strashko  2015-07-27  415  	 * Ensure devices are listed in devices_kset in correct order
52cdbdd49 Grygorii Strashko  2015-07-27  416  	 * It's important to move Dev to the end of devices_kset before
52cdbdd49 Grygorii Strashko  2015-07-27  417  	 * calling .probe, because it could be recursive and parent Dev
52cdbdd49 Grygorii Strashko  2015-07-27  418  	 * should always go first
52cdbdd49 Grygorii Strashko  2015-07-27  419  	 */
52cdbdd49 Grygorii Strashko  2015-07-27  420  	devices_kset_move_last(dev);
52cdbdd49 Grygorii Strashko  2015-07-27  421  
594c8281f Russell King       2006-01-05  422  	if (dev->bus->probe) {
594c8281f Russell King       2006-01-05  423  		ret = dev->bus->probe(dev);
1901fb260 Kay Sievers        2006-10-07  424  		if (ret)
d779249ed Greg Kroah-Hartman 2006-07-18  425  			goto probe_failed;
594c8281f Russell King       2006-01-05  426  	} else if (drv->probe) {
0d3e5a2e3 Patrick Mochel     2005-04-05  427  		ret = drv->probe(dev);
1901fb260 Kay Sievers        2006-10-07  428  		if (ret)
d779249ed Greg Kroah-Hartman 2006-07-18  429  			goto probe_failed;
07e4a3e27 Patrick Mochel     2005-03-21  430  	}
1901fb260 Kay Sievers        2006-10-07  431  
bea5b158f Rob Herring        2016-08-11  432  	if (test_remove) {
bea5b158f Rob Herring        2016-08-11  433  		test_remove = false;
bea5b158f Rob Herring        2016-08-11  434  
bdacd1b42 Rob Herring        2016-10-11  435  		if (dev->bus->remove)
bea5b158f Rob Herring        2016-08-11  436  			dev->bus->remove(dev);
bea5b158f Rob Herring        2016-08-11  437  		else if (drv->remove)
bea5b158f Rob Herring        2016-08-11  438  			drv->remove(dev);
bea5b158f Rob Herring        2016-08-11  439  
bea5b158f Rob Herring        2016-08-11  440  		devres_release_all(dev);
bea5b158f Rob Herring        2016-08-11  441  		driver_sysfs_remove(dev);
bea5b158f Rob Herring        2016-08-11  442  		dev->driver = NULL;
bea5b158f Rob Herring        2016-08-11  443  		dev_set_drvdata(dev, NULL);
bea5b158f Rob Herring        2016-08-11  444  		if (dev->pm_domain && dev->pm_domain->dismiss)
bea5b158f Rob Herring        2016-08-11  445  			dev->pm_domain->dismiss(dev);
bea5b158f Rob Herring        2016-08-11  446  		pm_runtime_reinit(dev);
bea5b158f Rob Herring        2016-08-11  447  
bea5b158f Rob Herring        2016-08-11  448  		goto re_probe;
bea5b158f Rob Herring        2016-08-11  449  	}
bea5b158f Rob Herring        2016-08-11  450  
ef0eebc05 Douglas Anderson   2015-10-20 @451  	pinctrl_init_done(dev);
ef0eebc05 Douglas Anderson   2015-10-20  452  
e90d55327 Rafael J. Wysocki  2015-03-20  453  	if (dev->pm_domain && dev->pm_domain->sync)
e90d55327 Rafael J. Wysocki  2015-03-20  454  		dev->pm_domain->sync(dev);
e90d55327 Rafael J. Wysocki  2015-03-20  455  
1901fb260 Kay Sievers        2006-10-07  456  	driver_bound(dev);
0d3e5a2e3 Patrick Mochel     2005-04-05  457  	ret = 1;
7dc72b284 Greg Kroah-Hartman 2007-11-28  458  	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
1e0b2cf93 Kay Sievers        2008-10-30  459  		 drv->bus->name, __func__, dev_name(dev), drv->name);
d779249ed Greg Kroah-Hartman 2006-07-18  460  	goto done;
2287c322b Patrick Mochel     2005-03-24  461  
d779249ed Greg Kroah-Hartman 2006-07-18  462  probe_failed:
09515ef5d Sricharan R        2017-04-10  463  	dma_deconfigure(dev);
09515ef5d Sricharan R        2017-04-10  464  dma_failed:
14b6257a5 Andy Shevchenko    2015-12-04  465  	if (dev->bus)
14b6257a5 Andy Shevchenko    2015-12-04  466  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
14b6257a5 Andy Shevchenko    2015-12-04  467  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
14b6257a5 Andy Shevchenko    2015-12-04  468  pinctrl_bind_failed:
9ed989537 Rafael J. Wysocki  2016-10-30  469  	device_links_no_driver(dev);
9ac7849e3 Tejun Heo          2007-01-20  470  	devres_release_all(dev);
1901fb260 Kay Sievers        2006-10-07  471  	driver_sysfs_remove(dev);
1901fb260 Kay Sievers        2006-10-07  472  	dev->driver = NULL;
0998d0631 Hans de Goede      2012-05-23  473  	dev_set_drvdata(dev, NULL);
e90d55327 Rafael J. Wysocki  2015-03-20  474  	if (dev->pm_domain && dev->pm_domain->dismiss)
e90d55327 Rafael J. Wysocki  2015-03-20  475  		dev->pm_domain->dismiss(dev);
5de85b9d5 Ulf Hansson        2015-11-18  476  	pm_runtime_reinit(dev);
08810a411 Rafael J. Wysocki  2017-10-25  477  	dev_pm_set_driver_flags(dev, 0);
1901fb260 Kay Sievers        2006-10-07  478  
bb2b40754 Sergei Shtylyov    2015-01-17  479  	switch (ret) {
bb2b40754 Sergei Shtylyov    2015-01-17  480  	case -EPROBE_DEFER:
d1c3414c2 Grant Likely       2012-03-05  481  		/* Driver requested deferred probing */
13fcffbbd Mark Brown         2015-03-10  482  		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
0ff26c662 Adrian Hunter      2017-11-02  483  		driver_deferred_probe_add_trigger(dev, local_trigger_count);
bb2b40754 Sergei Shtylyov    2015-01-17  484  		break;
bb2b40754 Sergei Shtylyov    2015-01-17  485  	case -ENODEV:
bb2b40754 Sergei Shtylyov    2015-01-17  486  	case -ENXIO:
bb2b40754 Sergei Shtylyov    2015-01-17  487  		pr_debug("%s: probe of %s rejects match %d\n",
bb2b40754 Sergei Shtylyov    2015-01-17  488  			 drv->name, dev_name(dev), ret);
bb2b40754 Sergei Shtylyov    2015-01-17  489  		break;
bb2b40754 Sergei Shtylyov    2015-01-17  490  	default:
2287c322b Patrick Mochel     2005-03-24  491  		/* driver matched but the probe failed */
2287c322b Patrick Mochel     2005-03-24  492  		printk(KERN_WARNING
2287c322b Patrick Mochel     2005-03-24  493  		       "%s: probe of %s failed with error %d\n",
1e0b2cf93 Kay Sievers        2008-10-30  494  		       drv->name, dev_name(dev), ret);
2287c322b Patrick Mochel     2005-03-24  495  	}
c578abbc2 Cornelia Huck      2006-11-27  496  	/*
c578abbc2 Cornelia Huck      2006-11-27  497  	 * Ignore errors returned by ->probe so that the next driver can try
c578abbc2 Cornelia Huck      2006-11-27  498  	 * its luck.
c578abbc2 Cornelia Huck      2006-11-27  499  	 */
c578abbc2 Cornelia Huck      2006-11-27  500  	ret = 0;
d779249ed Greg Kroah-Hartman 2006-07-18  501  done:
d779249ed Greg Kroah-Hartman 2006-07-18  502  	atomic_dec(&probe_count);
735a7ffb7 Andrew Morton      2006-10-27  503  	wake_up(&probe_waitqueue);
d779249ed Greg Kroah-Hartman 2006-07-18  504  	return ret;
d779249ed Greg Kroah-Hartman 2006-07-18  505  }
d779249ed Greg Kroah-Hartman 2006-07-18  506  

:::::: The code at line 394 was first introduced by commit
:::::: ab78029ecc347debbd737f06688d788bd9d60c1d drivers/pinctrl: grab default handles from device core

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sbCy879fAAA=

--azLHFNyN32YCQGCU--
