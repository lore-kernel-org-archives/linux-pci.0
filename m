Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:35899 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbbEYB1E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2015 21:27:04 -0400
Message-ID: <55627A3D.6070309@huawei.com>
Date: Mon, 25 May 2015 09:26:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 2/3] PCI/ASPM: Fix NULL pointer when find parent pcie_link_state
References: <1432191904-16451-1-git-send-email-wangyijing@huawei.com> <1432191904-16451-2-git-send-email-wangyijing@huawei.com> <20150522194207.GI32152@google.com>
In-Reply-To: <20150522194207.GI32152@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I think we also have a problem here:
> 
>    517  static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>    518  {
>    519          struct pcie_link_state *link;
>    520  
>    521          link = kzalloc(sizeof(*link), GFP_KERNEL);
>    522          if (!link)
>    523                  return NULL;
>    524          INIT_LIST_HEAD(&link->sibling);
>    525          INIT_LIST_HEAD(&link->children);
>    526          INIT_LIST_HEAD(&link->link);
>    527          link->pdev = pdev;
>    528          if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
>    529                  struct pcie_link_state *parent;
>    530                  parent = pdev->bus->parent->self->link_state;
>    531                  if (!parent) {
>    532                          kfree(link);
>    533                          return NULL;
>    534                  }
>    535                  link->parent = parent;
>    536                  list_add(&link->link, &parent->children);
>    537          }
> 
> Before your patch, we could only see Root Ports or Downstream Ports at line
> 528.  Now we may also see Upstream Ports, so I think that test should be
> changed to "if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)".

Good catch, thanks!

> 
> Without this change, I think we would allocate pcie_link_state for the
> 03:00.0 Upstream Port in your example, but it would not be connected to the
> tree of links starting at the 00:1c.0 Root Port.
> 
> Do you agree?

Yes.

I will update it.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

