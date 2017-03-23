Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:40732 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbdCWJBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2017 05:01:06 -0400
Subject: Re: [PATCH v2 0/2] Fix memory leak in
 of_pci_get_host_bridge_resources
To: Jeffy Chen <jeffy.chen@rock-chips.com>
References: <1490256755-889-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, toshi.kani@hpe.com,
        briannorris@chromium.org, dianders@chromium.org,
        bhelgaas@google.com, dtor@chromium.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <1b2060aa-09e9-64c8-833f-9d39bb5bc4c3@rock-chips.com>
Date: Thu, 23 Mar 2017 17:00:47 +0800
MIME-Version: 1.0
In-Reply-To: <1490256755-889-1-git-send-email-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jeffy,

On 2017/3/23 16:12, Jeffy Chen wrote:
> In of_pci_get_host_bridge_resources, we alloced some struct resource
> variables, and they would cause memory leak since no where to free them.
>

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Changes in v2:
> Don't change the resource_list_create_entry's behavior.
>
> Jeffy Chen (2):
>   PCI: return resource_entry in pci_add_resource helpers
>   of/pci: Fix memory leak in of_pci_get_host_bridge_resources
>
>  drivers/of/of_pci.c | 57 +++++++++++++++++++++++------------------------------
>  drivers/pci/bus.c   | 13 +++++++-----
>  include/linux/pci.h |  8 +++++---
>  3 files changed, 38 insertions(+), 40 deletions(-)
>
