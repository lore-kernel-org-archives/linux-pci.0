Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B4C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6318820850
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554931275;
	bh=twOXHEYLv2vhhKZumw25ZQB+3u7eqtXAgE5PQ3zO7mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rYAjQ9B4hkzjSyG5MF2t7LbaoyLaK36rQZnEJKpq/xmKGgGvUlvJJKKXmfPRJjkaM
	 rMw3K9XsyvAE3y7wQTGsTF87w4INlHP+7yEdbLTKQ1V3ls0RzcQhvfZ79zwF37qRh3
	 IaJzA8RZ3fwlawtoDH3FV9CsTpW9RpcADIM/0FJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDJVVO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfDJVVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:21:14 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D592082A;
        Wed, 10 Apr 2019 21:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554931273;
        bh=twOXHEYLv2vhhKZumw25ZQB+3u7eqtXAgE5PQ3zO7mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvY+uQFke95LD0RLXq9tpRle/m6RByhQO6Hd3pNax7HOyRzt7o1swCwiOiX1AZbgQ
         9KXBl5yZYw7Jx+TnTGgYanD1WAMn2+pkYr06XhU/AX9vc+O4u+Bz/leXR7/3G8LD19
         jBfMgiK+swF7JwVBCP2qrCiNGkc3J000kKb65VvU=
Date:   Wed, 10 Apr 2019 16:21:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        kbuild-all@01.org, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Grant Likely <grant.likely@linaro.org>
Subject: Re: [pci:pci/enumeration 6/6] drivers/pci/of.c:40
 pci_set_bus_of_node() error: we previously assumed 'bus->self' could be null
 (see line 34)
Message-ID: <20190410212112.GH256045@google.com>
References: <20190410194901.GE31633@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410194901.GE31633@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 10:49:01PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration
> head:   60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
> commit: 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7 [6/6] PCI: OF: Support "external-facing" property
> 
> smatch warnings:
> drivers/pci/of.c:40 pci_set_bus_of_node() error: we previously assumed 'bus->self' could be null (see line 34)

Yep, that looks like a problem.  I dropped these for now:

  60ea7f5dd97e PCI: OF: Support "external-facing" property
  6201cf80200c dt-bindings: Add "external-facing" PCIe port property

> # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
> git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> git remote update pci
> git checkout 60ea7f5dd97ed9949e6fbf67e93c9b2c38cc9eb7
> vim +40 drivers/pci/of.c
> 
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  31  
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  32  void pci_set_bus_of_node(struct pci_bus *bus)
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  33  {
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11 @34  	if (bus->self == NULL)
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  35  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  36  	else
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  37  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  38  
> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02  39  	if (of_get_property(bus->dev.of_node, "external-facing", NULL))
> 60ea7f5dd9 Jean-Philippe Brucker  2019-04-02 @40  		bus->self->untrusted = true;
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  41  }
> 98d9f30c82 Benjamin Herrenschmidt 2011-04-11  42  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
