Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43186
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729727AbeGQTdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2018 15:33:18 -0400
Date: Tue, 17 Jul 2018 20:59:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@01.org
Subject: Re: [PATCH v12 07/12] pci-epf-test/pci_endpoint_test: Cleanup
 PCI_ENDPOINT_TEST memspace (fwd)
Message-ID: <alpine.DEB.2.20.1807172056580.2373@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following code contains the following lines:

045c759f Gustavo Pimentel       2018-07-17  340                 count = pci_epc_get_msi(epc, epf->func_no);
045c759f Gustavo Pimentel       2018-07-17 @341                 if (reg->irq_number > count || count <= 0)

count has type u16, so it cannot be < 0.  Furthermore, pci_epc_get_msi
never returns a negative value, so the test for < 0 is unnecessary.

julia

---------- Forwarded message ----------
Date: Wed, 18 Jul 2018 02:50:45 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v12 07/12] pci-epf-test/pci_endpoint_test: Cleanup
    PCI_ENDPOINT_TEST memspace

CC: kbuild-all@01.org
In-Reply-To: <26fc54d264ca4229360cf632f08e6935b1abb30c.1531818979.git.gustavo.pimentel@synopsys.com>
References: <26fc54d264ca4229360cf632f08e6935b1abb30c.1531818979.git.gustavo.pimentel@synopsys.com>
TO: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: bhelgaas@google.com, lorenzo.pieralisi@arm.com, joao.pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com, adouglas@cadence.com, jesper.nilsson@axis.com, shawn.lin@rock-chips.com
CC: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Hi Gustavo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Gustavo-Pimentel/Add-MSI-X-support-on-pcitest-tool/20180717-233319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/pci/endpoint/functions/pci-epf-test.c:341:33-38: WARNING: Unsigned expression compared with zero: count <= 0

# https://github.com/0day-ci/linux/commit/045c759f7ad4eeb208d74b476af11c8bba90e80e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 045c759f7ad4eeb208d74b476af11c8bba90e80e
vim +341 drivers/pci/endpoint/functions/pci-epf-test.c

349e7a85 Kishon Vijay Abraham I 2017-03-27  274
349e7a85 Kishon Vijay Abraham I 2017-03-27  275  static void pci_epf_test_cmd_handler(struct work_struct *work)
349e7a85 Kishon Vijay Abraham I 2017-03-27  276  {
349e7a85 Kishon Vijay Abraham I 2017-03-27  277  	int ret;
045c759f Gustavo Pimentel       2018-07-17  278  	u16 count;
3ecf3232 Kishon Vijay Abraham I 2017-08-18  279  	u32 command;
349e7a85 Kishon Vijay Abraham I 2017-03-27  280  	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
349e7a85 Kishon Vijay Abraham I 2017-03-27  281  						     cmd_handler.work);
349e7a85 Kishon Vijay Abraham I 2017-03-27  282  	struct pci_epf *epf = epf_test->epf;
045c759f Gustavo Pimentel       2018-07-17  283  	struct device *dev = &epf->dev;
349e7a85 Kishon Vijay Abraham I 2017-03-27  284  	struct pci_epc *epc = epf->epc;
3235b994 Kishon Vijay Abraham I 2017-08-18  285  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
3235b994 Kishon Vijay Abraham I 2017-08-18  286  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
349e7a85 Kishon Vijay Abraham I 2017-03-27  287
3ecf3232 Kishon Vijay Abraham I 2017-08-18  288  	command = reg->command;
3ecf3232 Kishon Vijay Abraham I 2017-08-18  289  	if (!command)
349e7a85 Kishon Vijay Abraham I 2017-03-27  290  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  291
3ecf3232 Kishon Vijay Abraham I 2017-08-18  292  	reg->command = 0;
3235b994 Kishon Vijay Abraham I 2017-08-18  293  	reg->status = 0;
3ecf3232 Kishon Vijay Abraham I 2017-08-18  294
045c759f Gustavo Pimentel       2018-07-17  295  	if (reg->irq_type > IRQ_TYPE_MSI) {
045c759f Gustavo Pimentel       2018-07-17  296  		dev_err(dev, "Failed to detect IRQ type\n");
045c759f Gustavo Pimentel       2018-07-17  297  		goto reset_handler;
045c759f Gustavo Pimentel       2018-07-17  298  	}
749aaf33 John Keeping           2017-09-20  299
3ecf3232 Kishon Vijay Abraham I 2017-08-18  300  	if (command & COMMAND_RAISE_LEGACY_IRQ) {
349e7a85 Kishon Vijay Abraham I 2017-03-27  301  		reg->status = STATUS_IRQ_RAISED;
4494738d Cyrille Pitchen        2018-01-30  302  		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
349e7a85 Kishon Vijay Abraham I 2017-03-27  303  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  304  	}
349e7a85 Kishon Vijay Abraham I 2017-03-27  305
3ecf3232 Kishon Vijay Abraham I 2017-08-18  306  	if (command & COMMAND_WRITE) {
349e7a85 Kishon Vijay Abraham I 2017-03-27  307  		ret = pci_epf_test_write(epf_test);
349e7a85 Kishon Vijay Abraham I 2017-03-27  308  		if (ret)
349e7a85 Kishon Vijay Abraham I 2017-03-27  309  			reg->status |= STATUS_WRITE_FAIL;
349e7a85 Kishon Vijay Abraham I 2017-03-27  310  		else
349e7a85 Kishon Vijay Abraham I 2017-03-27  311  			reg->status |= STATUS_WRITE_SUCCESS;
045c759f Gustavo Pimentel       2018-07-17  312  		pci_epf_test_raise_irq(epf_test, reg->irq_type,
045c759f Gustavo Pimentel       2018-07-17  313  				       reg->irq_number);
349e7a85 Kishon Vijay Abraham I 2017-03-27  314  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  315  	}
349e7a85 Kishon Vijay Abraham I 2017-03-27  316
3ecf3232 Kishon Vijay Abraham I 2017-08-18  317  	if (command & COMMAND_READ) {
349e7a85 Kishon Vijay Abraham I 2017-03-27  318  		ret = pci_epf_test_read(epf_test);
349e7a85 Kishon Vijay Abraham I 2017-03-27  319  		if (!ret)
349e7a85 Kishon Vijay Abraham I 2017-03-27  320  			reg->status |= STATUS_READ_SUCCESS;
349e7a85 Kishon Vijay Abraham I 2017-03-27  321  		else
349e7a85 Kishon Vijay Abraham I 2017-03-27  322  			reg->status |= STATUS_READ_FAIL;
045c759f Gustavo Pimentel       2018-07-17  323  		pci_epf_test_raise_irq(epf_test, reg->irq_type,
045c759f Gustavo Pimentel       2018-07-17  324  				       reg->irq_number);
349e7a85 Kishon Vijay Abraham I 2017-03-27  325  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  326  	}
349e7a85 Kishon Vijay Abraham I 2017-03-27  327
3ecf3232 Kishon Vijay Abraham I 2017-08-18  328  	if (command & COMMAND_COPY) {
349e7a85 Kishon Vijay Abraham I 2017-03-27  329  		ret = pci_epf_test_copy(epf_test);
349e7a85 Kishon Vijay Abraham I 2017-03-27  330  		if (!ret)
349e7a85 Kishon Vijay Abraham I 2017-03-27  331  			reg->status |= STATUS_COPY_SUCCESS;
349e7a85 Kishon Vijay Abraham I 2017-03-27  332  		else
349e7a85 Kishon Vijay Abraham I 2017-03-27  333  			reg->status |= STATUS_COPY_FAIL;
045c759f Gustavo Pimentel       2018-07-17  334  		pci_epf_test_raise_irq(epf_test, reg->irq_type,
045c759f Gustavo Pimentel       2018-07-17  335  				       reg->irq_number);
349e7a85 Kishon Vijay Abraham I 2017-03-27  336  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  337  	}
349e7a85 Kishon Vijay Abraham I 2017-03-27  338
3ecf3232 Kishon Vijay Abraham I 2017-08-18  339  	if (command & COMMAND_RAISE_MSI_IRQ) {
045c759f Gustavo Pimentel       2018-07-17  340  		count = pci_epc_get_msi(epc, epf->func_no);
045c759f Gustavo Pimentel       2018-07-17 @341  		if (reg->irq_number > count || count <= 0)
349e7a85 Kishon Vijay Abraham I 2017-03-27  342  			goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  343  		reg->status = STATUS_IRQ_RAISED;
045c759f Gustavo Pimentel       2018-07-17  344  		pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI,
045c759f Gustavo Pimentel       2018-07-17  345  				  reg->irq_number);
349e7a85 Kishon Vijay Abraham I 2017-03-27  346  		goto reset_handler;
349e7a85 Kishon Vijay Abraham I 2017-03-27  347  	}
349e7a85 Kishon Vijay Abraham I 2017-03-27  348
349e7a85 Kishon Vijay Abraham I 2017-03-27  349  reset_handler:
349e7a85 Kishon Vijay Abraham I 2017-03-27  350  	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
349e7a85 Kishon Vijay Abraham I 2017-03-27  351  			   msecs_to_jiffies(1));
349e7a85 Kishon Vijay Abraham I 2017-03-27  352  }
349e7a85 Kishon Vijay Abraham I 2017-03-27  353

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
