Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35837 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423688AbcBQPAw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2016 10:00:52 -0500
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com> <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 09:00:31 -0600
Message-ID: <CAL_JsqLLrp+ZxkhEp9Whg=jhm4-Cq4-GpRVerj4h6igzRQXiEQ@mail.gmail.com>
Subject: Re: [PATCH v8 43/45] drivers/of: Specify parent node in of_fdt_unflatten_tree()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Jyri Sarha <jsarha@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> This adds one more argument to of_fdt_unflatten_tree() to specify
> the parent node of the FDT blob that is going to be unflattened.
> In the result, the function can be used to unflatten FDT blob that
> represents device sub-tree in PowerNV PCI hotplug driver.
>
> Cc: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c |  2 +-
>  drivers/of/fdt.c                             | 14 ++++++++++----
>  drivers/of/unittest.c                        |  2 +-
>  include/linux/of_fdt.h                       |  1 +
>  4 files changed, 13 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
