Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:32941 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423688AbcBQPAO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Feb 2016 10:00:14 -0500
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com> <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 08:59:53 -0600
Message-ID: <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
Subject: Re: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
	dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
> populates multiple device nodes from FDT blob. No logical changes
> introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

I'm happy to take patches 40-42 for 4.6 if the rest of the series
doesn't go in given they fix a separate problem. I just need to know
soon (or at least they need to go into -next soon).

Rob
