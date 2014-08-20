Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49382 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaHTL2f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 07:28:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH] drivers: pci: convert generic host controller to DT host bridge creation API
Date: Wed, 20 Aug 2014 13:27:57 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201408201327.57376.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 August 2014, Liviu Dudau wrote:
> +       return of_create_pci_host_bridge(dev, 0, 0xff, &gen_pci_ops,
> +                                       gen_pci_setup, pci);

I had not noticed it earlier, but the setup callback is actually a feature
of the arm32 PCI code that I had hoped to avoid when moving to the
generic API. Can we do this as a more regular sequence of


	ret = of_create_pci_host_bridge(dev, 0, 0xff, &gen_pci_ops, pci);
	if (ret)
		return ret;

	ret = gen_pci_setup(pci);
	if (ret)
		pci_destroy_host_bridge(dev, pci);
	return ret;

?

	Arnd
