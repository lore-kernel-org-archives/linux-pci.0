Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946337AbeCBKgg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 05:36:36 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint Rocketraid 644L card
Date: Fri,  2 Mar 2018 11:36:31 +0100
Message-Id: <20180302103633.10592-1-hdegoede@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
they can be merged independently from each-other into their resp. subsys,
but since they belong together I'm sending them out as a series.

Regards,

Hans
